Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB066A6936
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 09:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCAIzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 03:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCAIzN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 03:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5449E32CE7
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 00:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677660866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Knrux4ZtBA0k+RI+TuuKKyAib/njULm/87MPp1L0bs=;
        b=FQCISxb3P+4DuvirHIV3Qn05neVqG6SqYZlKWI84BWbHlPbJ4IBbO5ovFnbCnYh5WjFi8c
        UJ/Nrjs4rpvKvAQaqNPXHKHlDaCruQKupQjjVLo2pnE3icL2w3MGyWbPlu5+DP/MvzSgFW
        /So1dosYHNRzWzP7QwvujAF3a2EQTvc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-6hBBMfa-Nsm2K32e-EJLxQ-1; Wed, 01 Mar 2023 03:54:20 -0500
X-MC-Unique: 6hBBMfa-Nsm2K32e-EJLxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5E092807D62;
        Wed,  1 Mar 2023 08:54:19 +0000 (UTC)
Received: from dhcph048.fit.vutbr.cz (unknown [10.45.224.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F8912026D4B;
        Wed,  1 Mar 2023 08:54:17 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 3/3] libbpf: cleanup linker_append_elf_relos
Date:   Wed,  1 Mar 2023 09:53:55 +0100
Message-Id: <c5c8fe9f411b69afada8399d23bb048ef2a70535.1677658777.git.vmalik@redhat.com>
In-Reply-To: <cover.1677658777.git.vmalik@redhat.com>
References: <cover.1677658777.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Clang Static Analyser (scan-build) reports some unused symbols and dead
assignments in the linker_append_elf_relos function. Clean these up.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/lib/bpf/linker.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 4ac02c28e152..d7069780984a 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1997,7 +1997,6 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *obj)
 {
 	struct src_sec *src_symtab = &obj->secs[obj->symtab_sec_idx];
-	struct dst_sec *dst_symtab;
 	int i, err;
 
 	for (i = 1; i < obj->sec_cnt; i++) {
@@ -2030,9 +2029,6 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 			return -1;
 		}
 
-		/* add_dst_sec() above could have invalidated linker->secs */
-		dst_symtab = &linker->secs[linker->symtab_sec_idx];
-
 		/* shdr->sh_link points to SYMTAB */
 		dst_sec->shdr->sh_link = linker->symtab_sec_idx;
 
@@ -2049,16 +2045,13 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 		dst_rel = dst_sec->raw_data + src_sec->dst_off;
 		n = src_sec->shdr->sh_size / src_sec->shdr->sh_entsize;
 		for (j = 0; j < n; j++, src_rel++, dst_rel++) {
-			size_t src_sym_idx = ELF64_R_SYM(src_rel->r_info);
-			size_t sym_type = ELF64_R_TYPE(src_rel->r_info);
-			Elf64_Sym *src_sym, *dst_sym;
-			size_t dst_sym_idx;
+			size_t src_sym_idx, dst_sym_idx, sym_type;
+			Elf64_Sym *src_sym;
 
 			src_sym_idx = ELF64_R_SYM(src_rel->r_info);
 			src_sym = src_symtab->data->d_buf + sizeof(*src_sym) * src_sym_idx;
 
 			dst_sym_idx = obj->sym_map[src_sym_idx];
-			dst_sym = dst_symtab->raw_data + sizeof(*dst_sym) * dst_sym_idx;
 			dst_rel->r_offset += src_linked_sec->dst_off;
 			sym_type = ELF64_R_TYPE(src_rel->r_info);
 			dst_rel->r_info = ELF64_R_INFO(dst_sym_idx, sym_type);
-- 
2.39.1

