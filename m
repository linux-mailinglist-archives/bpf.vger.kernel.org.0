Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E07374E1A
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 05:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhEFDq3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 23:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhEFDq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 23:46:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4BEC061761
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 20:45:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h127so4113357pfe.9
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 20:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R/m7PRzq1a27Qr43Q2HFqlvRkKmmTTmeyVD0AXyb4X4=;
        b=uX06Rc+Kn5CuODDK+fNyKvNs31O95eSqvuvNyg0zlL+ngCFg8Ixuog4q3d2vxLLQrS
         UHrZl1RgwpCPuonMS5WV8R0w3UusAD+d8LVdZrQqVDSwVKnumhuXD33XwIkYGki/PZ7W
         tQ1ehvTrYIWdyFT1BsAAUG9vgAmlHNPGsLCKSnuG22edRF/nn++U5pGteLRAcEZlclji
         0N3jg66iX12NJRcgfF0Ozqhe1zJqYbTtip35CVLyL+MsHQRy/upq3GT9ETswWtGo7mwa
         bcqCA5kEyxe+OB75lHJQ6Ulo9+S2kVgP2UvomsFsozG/BepbYOnOnOUYsM/ah+aLRNhb
         jMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R/m7PRzq1a27Qr43Q2HFqlvRkKmmTTmeyVD0AXyb4X4=;
        b=iSqR9wMWcGY48UJc7Orz3wMXeqF6/l5aM8F6rvxL6VOqR0iI+R7/vYWWSqKxNGjx/P
         Yh4xEbcoiOUA7bUHu9XTqCqKVhIjHGlbe8l3To5C+SPDJaL/XoFsQdj/6pyf7J2u46Gv
         ZZpq33GcKs72GOA0PEVCr7FYbGHbwmy5nk0l3K0glWPt1rZkcCrZIKYvvFZPC09DASQq
         H5gd189Wi5l2gv/XrIFjbRcECyEGY/39LgRS+GweqAb4QsL2oZLM4BYYgWZ+zQM12S+y
         wG3P0AM5zVDT9HVMXvuMoAGTOwUlf87Oi/hL+fSxVKWgYd4BaCB9ZGC2rNTr6dZ8rYej
         9qLQ==
X-Gm-Message-State: AOAM531ElzZ7IbrkdnQxBBPD9Wx1NmREHPmhWddIVLN8sLrjJvEvuzoX
        cbHmnegPQtIUObRVjlUtxrZBPaPmCw0=
X-Google-Smtp-Source: ABdhPJxxxHpzf6DUDEqp5uN8RTkO5sfK4WWA0qQ6l2kDbpDvp89PkmmrwHp6ucaAqdfaVC91xiu9Iw==
X-Received: by 2002:aa7:8103:0:b029:247:74a8:e54d with SMTP id b3-20020aa781030000b029024774a8e54dmr2414452pfi.60.1620272730220;
        Wed, 05 May 2021 20:45:30 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r22sm578997pgr.1.2021.05.05.20.45.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 20:45:29 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 15/17] libbpf: Use fd_array only with gen_loader.
Date:   Wed,  5 May 2021 20:45:03 -0700
Message-Id: <20210506034505.25979-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
References: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Rely on fd_array kernel feature only to generate loader program,
since it's mandatory for it.
Avoid using fd_array by default to preserve test coverage
for old style map_fd patching.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 78aa3cad9a05..5e9c8c75eb0f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -291,7 +291,6 @@ struct bpf_program {
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
 	__u32 prog_flags;
-	int *fd_array;
 };
 
 struct bpf_struct_ops {
@@ -6451,7 +6450,7 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 
 		switch (relo->type) {
 		case RELO_LD64:
-			if (kernel_supports(obj, FEAT_FD_IDX)) {
+			if (obj->gen_loader) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX;
 				insn[0].imm = relo->map_idx;
 			} else {
@@ -6461,7 +6460,7 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 			break;
 		case RELO_DATA:
 			insn[1].imm = insn[0].imm + relo->sym_off;
-			if (kernel_supports(obj, FEAT_FD_IDX)) {
+			if (obj->gen_loader) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 				insn[0].imm = relo->map_idx;
 			} else {
@@ -6472,7 +6471,7 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_EXTERN_VAR:
 			ext = &obj->externs[relo->sym_off];
 			if (ext->type == EXT_KCFG) {
-				if (kernel_supports(obj, FEAT_FD_IDX)) {
+				if (obj->gen_loader) {
 					insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 					insn[0].imm = obj->kconfig_map_idx;
 				} else {
@@ -7275,7 +7274,6 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
-	load_attr.fd_array = prog->fd_array;
 
 	/* specify func_info/line_info only if kernel supports them */
 	btf_fd = bpf_object__btf_fd(prog->obj);
@@ -7506,7 +7504,6 @@ static int
 bpf_object__load_progs(struct bpf_object *obj, int log_level)
 {
 	struct bpf_program *prog;
-	int *fd_array = NULL;
 	size_t i;
 	int err;
 
@@ -7517,14 +7514,6 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			return err;
 	}
 
-	if (kernel_supports(obj, FEAT_FD_IDX) && obj->nr_maps) {
-		fd_array = malloc(sizeof(int) * obj->nr_maps);
-		if (!fd_array)
-			return -ENOMEM;
-		for (i = 0; i < obj->nr_maps; i++)
-			fd_array[i] = obj->maps[i].fd;
-	}
-
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
@@ -7534,17 +7523,12 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			continue;
 		}
 		prog->log_level |= log_level;
-		prog->fd_array = fd_array;
 		err = bpf_program__load(prog, obj->license, obj->kern_version);
-		prog->fd_array = NULL;
-		if (err) {
-			free(fd_array);
+		if (err)
 			return err;
-		}
 	}
 	if (obj->gen_loader)
 		bpf_object__free_relocs(obj);
-	free(fd_array);
 	return 0;
 }
 
-- 
2.30.2

