Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD952F489D
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 11:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbhAMK0J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 13 Jan 2021 05:26:09 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:59143 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbhAMK0J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Jan 2021 05:26:09 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-T5eYJ6JSOWGQ4ljXKotyig-1; Wed, 13 Jan 2021 05:25:14 -0500
X-MC-Unique: T5eYJ6JSOWGQ4ljXKotyig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0181D180A092;
        Wed, 13 Jan 2021 10:25:13 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD4641F0;
        Wed, 13 Jan 2021 10:25:10 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: [PATCHv2] btf_encoder: Add extra checks for symbol names
Date:   Wed, 13 Jan 2021 11:25:09 +0100
Message-Id: <20210113102509.1338601-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
  v2 changes:
    - reorg the code based on Andrii's suggestion

 btf_encoder.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 333973054b61..5557c9efd365 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -68,10 +68,14 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 	struct elf_function *new;
 	static GElf_Shdr sh;
 	static int last_idx;
+	const char *name;
 	int idx;
 
 	if (elf_sym__type(sym) != STT_FUNC)
 		return 0;
+	name = elf_sym__name(sym, btfe->symtab);
+	if (!name)
+		return 0;
 
 	if (functions_cnt == functions_alloc) {
 		functions_alloc = max(1000, functions_alloc * 3 / 2);
@@ -94,7 +98,7 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 		last_idx = idx;
 	}
 
-	functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
+	functions[functions_cnt].name = name;
 	functions[functions_cnt].addr = elf_sym__value(sym);
 	functions[functions_cnt].sh_addr = sh.sh_addr;
 	functions[functions_cnt].generated = false;
@@ -731,8 +735,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 			continue;
 		if (functions_cnt) {
 			struct elf_function *func;
+			const char *name;
+
+			name = function__name(fn, cu);
+			if (!name)
+				continue;
 
-			func = find_function(btfe, function__name(fn, cu));
+			func = find_function(btfe, name);
 			if (!func || func->generated)
 				continue;
 			func->generated = true;
-- 
2.26.2

