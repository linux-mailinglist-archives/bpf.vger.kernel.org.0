Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C592B0816
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 16:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgKLPFV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 12 Nov 2020 10:05:21 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:60350 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728434AbgKLPFU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 10:05:20 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-wKL2GB7IPPKqGTmpkswAgw-1; Thu, 12 Nov 2020 10:05:15 -0500
X-MC-Unique: wKL2GB7IPPKqGTmpkswAgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55905CE642;
        Thu, 12 Nov 2020 15:05:13 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F0C960C0F;
        Thu, 12 Nov 2020 15:05:11 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC/PATCH 2/3] btf_encoder: Put function generation code to generate_func
Date:   Thu, 12 Nov 2020 16:05:05 +0100
Message-Id: <20201112150506.705430-3-jolsa@kernel.org>
In-Reply-To: <20201112150506.705430-1-jolsa@kernel.org>
References: <20201112150506.705430-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We will use generate_func from another place in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d531651b1e9e..efc4f48dbc5a 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -351,6 +351,23 @@ static struct btf_elf *btfe;
 static uint32_t array_index_id;
 static bool has_index_type;
 
+static int generate_func(struct btf_elf *btfe, struct cu *cu,
+			 struct function *fn, uint32_t type_id_off)
+{
+	int btf_fnproto_id, btf_fn_id, err = 0;
+	const char *name;
+
+	btf_fnproto_id = btf_elf__add_func_proto(btfe, cu, &fn->proto, type_id_off);
+	name = dwarves__active_loader->strings__ptr(cu, fn->name);
+	btf_fn_id = btf_elf__add_ref_type(btfe, BTF_KIND_FUNC, btf_fnproto_id, name, false);
+	if (btf_fnproto_id < 0 || btf_fn_id < 0) {
+		err = -1;
+		printf("error: failed to encode function '%s'\n", function__name(fn, cu));
+	}
+
+	return err;
+}
+
 int btf_encoder__encode()
 {
 	int err;
@@ -608,9 +625,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 	}
 
 	cu__for_each_function(cu, core_id, fn) {
-		int btf_fnproto_id, btf_fn_id;
-		const char *name;
-
 		/*
 		 * The functions_cnt != 0 means we parsed all necessary
 		 * kernel symbols and we are using ftrace location filter
@@ -634,14 +648,8 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 				continue;
 		}
 
-		btf_fnproto_id = btf_elf__add_func_proto(btfe, cu, &fn->proto, type_id_off);
-		name = dwarves__active_loader->strings__ptr(cu, fn->name);
-		btf_fn_id = btf_elf__add_ref_type(btfe, BTF_KIND_FUNC, btf_fnproto_id, name, false);
-		if (btf_fnproto_id < 0 || btf_fn_id < 0) {
-			err = -1;
-			printf("error: failed to encode function '%s'\n", function__name(fn, cu));
+		if (generate_func(btfe, cu, fn, type_id_off))
 			goto out;
-		}
 	}
 
 	if (skip_encoding_vars)
-- 
2.26.2

