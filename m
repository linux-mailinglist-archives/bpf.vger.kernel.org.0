Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED66A6935
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 09:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCAIzK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 03:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCAIzJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 03:55:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E77227D42
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 00:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677660862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rv5ila1S6/HFhGjzd/E23AUX33te4LIWeJqmr8F0apM=;
        b=KBHexcU+kxdHmdlQD8sZJ/EMjiCg6TaAGk4Njef6fWxl9iRuMSTnQLN0mPF32F/FWvDuGy
        HIhClAlbVzeAuFb+qAt/R0SO/GC1JteBoUNIThe7RqTeMvuUALElutTv9qNkxVZdtoDHhP
        NQxdyciCPY9g1XhQkG7oQhcC22DOaqc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-yyNTfYrNNOyqeCP5RfOIow-1; Wed, 01 Mar 2023 03:54:17 -0500
X-MC-Unique: yyNTfYrNNOyqeCP5RfOIow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AB361C06EC3;
        Wed,  1 Mar 2023 08:54:17 +0000 (UTC)
Received: from dhcph048.fit.vutbr.cz (unknown [10.45.224.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DD8C2026D4B;
        Wed,  1 Mar 2023 08:54:13 +0000 (UTC)
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
Subject: [PATCH bpf-next 2/3] libbpf: remove several dead assignments
Date:   Wed,  1 Mar 2023 09:53:54 +0100
Message-Id: <5503d18966583e55158471ebbb2f67374b11bf5e.1677658777.git.vmalik@redhat.com>
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

Clang Static Analyzer (scan-build) reports several dead assignments in
libbpf where the assigned value is unconditionally overridden by another
value before it is read. Remove these assignments.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/lib/bpf/btf.c       | 2 --
 tools/lib/bpf/libbpf.c    | 1 -
 tools/lib/bpf/relo_core.c | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9181d36118d2..0a2c079244b6 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1000,8 +1000,6 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 		}
 	}
 
-	err = 0;
-
 	if (!btf_data) {
 		pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
 		err = -ENODATA;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 905193d98885..ba9e7e2b7951 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -798,7 +798,6 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 	progs = obj->programs;
 	nr_progs = obj->nr_programs;
 	nr_syms = symbols->d_size / sizeof(Elf64_Sym);
-	sec_off = 0;
 
 	for (i = 0; i < nr_syms; i++) {
 		sym = elf_sym_by_idx(obj, i);
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index c4b0e81ae293..a26b2f5fa0fc 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1551,9 +1551,6 @@ int __bpf_core_types_match(const struct btf *local_btf, __u32 local_id, const st
 	if (level <= 0)
 		return -EINVAL;
 
-	local_t = btf_type_by_id(local_btf, local_id);
-	targ_t = btf_type_by_id(targ_btf, targ_id);
-
 recur:
 	depth--;
 	if (depth < 0)
-- 
2.39.1

