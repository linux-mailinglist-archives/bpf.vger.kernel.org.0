Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CFC2F390D
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 19:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406182AbhALSlB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 12 Jan 2021 13:41:01 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:22835 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404158AbhALSlB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 13:41:01 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-TmcvJLZrPHaMclKdPHvBvQ-1; Tue, 12 Jan 2021 13:40:08 -0500
X-MC-Unique: TmcvJLZrPHaMclKdPHvBvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21613107ACF7;
        Tue, 12 Jan 2021 18:40:07 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E31DF60BE2;
        Tue, 12 Jan 2021 18:40:04 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: [PATCH] btf_encoder: Add extra checks for symbol names
Date:   Tue, 12 Jan 2021 19:40:04 +0100
Message-Id: <20210112184004.1302879-1-jolsa@kernel.org>
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

When processing kernel image build by clang we can
find some functions without the name, which causes
pahole to segfault.

Adding extra checks to make sure we always have
function's name defined before using it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 333973054b61..17f7a14f2ef0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 
 	if (elf_sym__type(sym) != STT_FUNC)
 		return 0;
+	if (!elf_sym__name(sym, btfe->symtab))
+		return 0;
 
 	if (functions_cnt == functions_alloc) {
 		functions_alloc = max(1000, functions_alloc * 3 / 2);
@@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		if (!has_arg_names(cu, &fn->proto))
 			continue;
 		if (functions_cnt) {
-			struct elf_function *func;
+			const char *name = function__name(fn, cu);
+			struct elf_function *func = NULL;
 
-			func = find_function(btfe, function__name(fn, cu));
+			if (name)
+				func = find_function(btfe, name);
 			if (!func || func->generated)
 				continue;
 			func->generated = true;
-- 
2.26.2

