Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B622B3135
	for <lists+bpf@lfdr.de>; Sat, 14 Nov 2020 23:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKNWjN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 14 Nov 2020 17:39:13 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:56489 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbgKNWjN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 14 Nov 2020 17:39:13 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-Ya3WHxqBP7-9Enos_V8bfw-1; Sat, 14 Nov 2020 17:39:06 -0500
X-MC-Unique: Ya3WHxqBP7-9Enos_V8bfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85A251007B01;
        Sat, 14 Nov 2020 22:39:04 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85F976EF56;
        Sat, 14 Nov 2020 22:39:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH 2/2] btf_encoder: Fix function generation
Date:   Sat, 14 Nov 2020 23:38:53 +0100
Message-Id: <20201114223853.1010900-3-jolsa@kernel.org>
In-Reply-To: <20201114223853.1010900-1-jolsa@kernel.org>
References: <20201114223853.1010900-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current conditions for picking up function records break
BTF data on some gcc versions.

Some function records can appear with no arguments but with
declaration tag set, so moving the 'fn->declaration' in front
of other checks.

Then checking if argument names are present and finally checking
ftrace filter if it's present. If ftrace filter is not available,
using the external tag to filter out non external functions.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d531651b1e9e..f3f6291391ee 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -164,18 +164,13 @@ static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
 	return 0;
 }
 
-static bool should_generate_function(const struct btf_elf *btfe, const char *name)
+static struct elf_function *find_function(const struct btf_elf *btfe,
+					  const char *name)
 {
-	struct elf_function *p;
 	struct elf_function key = { .name = name };
 
-	p = bsearch(&key, functions, functions_cnt,
-		    sizeof(functions[0]), functions_cmp);
-	if (!p || p->generated)
-		return false;
-
-	p->generated = true;
-	return true;
+	return bsearch(&key, functions, functions_cnt, sizeof(functions[0]),
+		       functions_cmp);
 }
 
 static bool btf_name_char_ok(char c, bool first)
@@ -612,25 +607,25 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		const char *name;
 
 		/*
-		 * The functions_cnt != 0 means we parsed all necessary
-		 * kernel symbols and we are using ftrace location filter
-		 * for functions. If it's not available keep the current
-		 * dwarf declaration check.
+		 * Skip functions that:
+		 *   - are marked as declarations
+		 *   - do not have full argument names
+		 *   - are not in ftrace list (if it's available)
+		 *   - are not external (in case ftrace filter is not available)
 		 */
+		if (fn->declaration)
+			continue;
+		if (!has_arg_names(cu, &fn->proto))
+			continue;
 		if (functions_cnt) {
-			/*
-			 * We check following conditions:
-			 *   - argument names are defined
-			 *   - there's symbol and address defined for the function
-			 *   - function address belongs to ftrace locations
-			 *   - function is generated only once
-			 */
-			if (!has_arg_names(cu, &fn->proto))
-				continue;
-			if (!should_generate_function(btfe, function__name(fn, cu)))
+			struct elf_function *func;
+
+			func = find_function(btfe, function__name(fn, cu));
+			if (!func || func->generated)
 				continue;
+			func->generated = true;
 		} else {
-			if (fn->declaration || !fn->external)
+			if (!fn->external)
 				continue;
 		}
 
-- 
2.26.2

