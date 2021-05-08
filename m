Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BDF376F41
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhEHDuM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhEHDuM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:50:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14928C061574
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:49:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so6530002pjz.0
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=guOxpEi8kNk6mB7wT4ySKJnrqmhE0DB/sFrSnvn66yc=;
        b=E21x2ek9f2Uv+AuW3pXVFfB/nrXYDLaXr6nNxpyi3xh6S4gW9ktGqm+Ucjlm6NMQng
         cWFZLSdSbECwlOyJRHXe1AR0AOFZVxw5H9cXKp3O8K3+T0hkFIf22splv71iZF2lGpBE
         bbwjevwOsDYqGMn0Wi6ZLke4ZMSD/h3gPcR2p/KqSq2wCtk3w8iBJYjKh9yZ9oEKHcSg
         pMRtyaTt2v0KYaIPXeIyF9r0yPYpMQKfho7qel5jNGSyPg4aP/rUBoTkerV0wFldek0E
         p01KD3WU4lbxdAILqAbayQwy2v917wqkpUp6cDerk05ux4uaDRlVI3/Qrk+ELTeCIw9x
         VJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=guOxpEi8kNk6mB7wT4ySKJnrqmhE0DB/sFrSnvn66yc=;
        b=lOmsuEC06lqUs/2qvk/XoIdVuptYjm0UDQ4dLGIgzhVAWn8pDmOzP0eeoi1z2Z0YXf
         ki/pF9CdJPH7yaB5Xd2J12ut47/7Jy3d1Z62uFs0rvzfMxkymCamUtcPwCUUlhHmEf4P
         T1vqs8EnwApXkSEaVE0MmfC3r9/lZ6mjYaI9ob53Fn6JfxZtU6jRT5kO00JNPv3dd1Mu
         sKh1vVL+91ciZNdYZOYPylDCM+ax7uxve8kpz1KxlMW6bW/j0j/Nxjb75zipCWYuv8CK
         BFn9Ixv/+N9Q38nSmqwgOSrrBAeCYRyED3xuPhIIRqBO7UmDNQ8i+9K11nTH6gVYiQO+
         520g==
X-Gm-Message-State: AOAM530geey4ySmEjYChs2b11GrsxYtmdNlvEMT/lo8oEoSwkRcPQVwV
        hcbgZgjcOj0CHNjC/wILt9g=
X-Google-Smtp-Source: ABdhPJyFKNJyl7FSImuWiIyToM+F394vwUK8yIh/rx45iwjK05Ppy5f0OSGcLRJz0ZKwTte0onZzMA==
X-Received: by 2002:a17:902:a60f:b029:ee:cc8c:f891 with SMTP id u15-20020a170902a60fb02900eecc8cf891mr13071731plq.39.1620445748685;
        Fri, 07 May 2021 20:49:08 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.49.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:49:08 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 15/22] libbpf: Use fd_array only with gen_loader.
Date:   Fri,  7 May 2021 20:48:30 -0700
Message-Id: <20210508034837.64585-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
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
index 0ca79712f850..24a659448782 100644
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

