Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE2A46873C
	for <lists+bpf@lfdr.de>; Sat,  4 Dec 2021 20:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349843AbhLDTty (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Dec 2021 14:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349772AbhLDTtv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Dec 2021 14:49:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF56C061751
        for <bpf@vger.kernel.org>; Sat,  4 Dec 2021 11:46:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v23so4821103pjr.5
        for <bpf@vger.kernel.org>; Sat, 04 Dec 2021 11:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VTb8i8+jJHUPmjXGl47HEO0JN6mA1sSMO1XRieAtUdk=;
        b=b9Mv1i720Kc/coEP71WjOYfrnugbzAF65oj6re+zNcVgN5s4Izj0mwK5iYkip87kF8
         bypukSXWnKc/8Lt5+BdgBnbLVQAbtu2+O4GLhf9ka7mGlEBxcCCbypq7/xpp7tu5LR40
         goWyEBEeWY+CLG9PtzRo9u/D9Y0Eo6+o6rOwdgLK7aZ7/0FPiyY2dD/l5NjiBFwgicMJ
         a4PBrc/tf/t97WVz4pyHh9FWERnVF/VPSdZUx6nccb2cdIQ/eNNVXrQb8eTR4RkofCUk
         1JOpHlat6ugdY6NEaEqwWsQZnCshZ4EZ/6uEL6dMFhgWr5l2xswi8RynBjR+mI3v5xlZ
         +REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VTb8i8+jJHUPmjXGl47HEO0JN6mA1sSMO1XRieAtUdk=;
        b=aj9IkbSb54yjuOt6ZL/HhvmNeKZ/nfzy4FkuzzzAvqng8lifmzLK6yGJRkp6gMxcFj
         DUQTod8Kmi9D3PsN4GDe5u4uTSBAWn0jmvdFJkr0WIgqPym6SvYjEdVa0TMsChUslqzd
         RmaJzPfEiLCQ4+aw67XY6e/S+WCwHUpznD1710wBLSY8fiyj+2Vg1lWK/Dskj6271gBg
         6HfOg1P5xmqmmEKKmRaOKYPYVCGUS11y5HurMqP3GD05wqnEGfOhnl3mwtLFaUU3Ozni
         ouhb9XYZMQoeE38XJNnLHpnf4uhbBwYOUOS77VztErBEXH0tvxvYp6KCj+gPVe2nlY4D
         OaXw==
X-Gm-Message-State: AOAM532gFCtB6fvDalwbBTEIkIRtglbGktt6fw02oVFNNSBeO/Iy+Hci
        rsmC9VDbmy+sguzweb/bXwQ=
X-Google-Smtp-Source: ABdhPJyBdp7bdjmz1TDgklKUO1e86iM/gGqa7oY6X6kpK3RjyPtzX9OlxeVjNL5tRzxFiYF7L1Hhyg==
X-Received: by 2002:a17:902:f693:b0:142:9ec:c2e1 with SMTP id l19-20020a170902f69300b0014209ecc2e1mr31686668plg.34.1638647185414;
        Sat, 04 Dec 2021 11:46:25 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:bbb5])
        by smtp.gmail.com with ESMTPSA id on5sm5996152pjb.23.2021.12.04.11.46.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Dec 2021 11:46:25 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next] bpftool: Add debug mode for gen_loader.
Date:   Sat,  4 Dec 2021 11:46:23 -0800
Message-Id: <20211204194623.27779-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Make -d flag functional for gen_loader style program loading.

For example:
$ bpftool prog load -L -d test_d_path.o
... // will print:
libbpf: loading ./test_d_path.o
libbpf: elf: section(3) fentry/security_inode_getattr, size 280, link 0, flags 6, type=1
...
libbpf: prog 'prog_close': found data map 0 (test_d_p.bss, sec 7, off 0) for insn 30
libbpf: gen: load_btf: size 5376
libbpf: gen: map_create: test_d_p.bss idx 0 type 2 value_type_id 118
libbpf: map 'test_d_p.bss': created successfully, fd=0
libbpf: gen: map_update_elem: idx 0
libbpf: sec 'fentry/filp_close': found 1 CO-RE relocations
libbpf: record_relo_core: prog 1 insn[15] struct file 0:1 final insn_idx 15
libbpf: gen: prog_load: type 26 insns_cnt 35 progi_idx 0
libbpf: gen: find_attach_tgt security_inode_getattr 12
libbpf: gen: prog_load: type 26 insns_cnt 37 progi_idx 1
libbpf: gen: find_attach_tgt filp_close 12
libbpf: gen: finish 0
... // at this point libbpf finished generating loader program
   0: (bf) r6 = r1
   1: (bf) r1 = r10
   2: (07) r1 += -136
   3: (b7) r2 = 136
   4: (b7) r3 = 0
   5: (85) call bpf_probe_read_kernel#113
   6: (05) goto pc+104
... // this is the assembly dump of the loader program
 390: (63) *(u32 *)(r6 +44) = r0
 391: (18) r1 = map[idx:0]+5584
 393: (61) r0 = *(u32 *)(r1 +0)
 394: (63) *(u32 *)(r6 +24) = r0
 395: (b7) r0 = 0
 396: (95) exit
err 0  // the loader program was loaded and executed successfully
(null)
func#0 @0
...  // CO-RE in the kernel logs:
CO-RE relocating STRUCT file: found target candidate [500]
prog '': relo #0: kind <byte_off> (0), spec is [8] STRUCT file.f_path (0:1 @ offset 16)
prog '': relo #0: matching candidate #0 [500] STRUCT file.f_path (0:1 @ offset 16)
prog '': relo #0: patched insn #15 (ALU/ALU64) imm 16 -> 16
vmlinux_cand_cache:[11]file(500),
module_cand_cache:
... // verifier logs when it was checking test_d_path.o program:
R1 type=ctx expected=fp
0: R1=ctx(id=0,off=0,imm=0) R10=fp0
; int BPF_PROG(prog_close, struct file *file, void *id)
0: (79) r6 = *(u64 *)(r1 +0)
func 'filp_close' arg0 has btf_id 500 type STRUCT 'file'
1: R1=ctx(id=0,off=0,imm=0) R6_w=ptr_file(id=0,off=0,imm=0) R10=fp0
; pid_t pid = bpf_get_current_pid_tgid() >> 32;
1: (85) call bpf_get_current_pid_tgid#14

... // if there are multiple programs being loaded by the loader program
... // only the last program in the elf file will be printed, since
... // the same verifier log_buf is used for all PROG_LOAD commands.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/prog.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index e47e8b06cc3d..b9f42e9e9067 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1779,12 +1779,14 @@ static int try_loader(struct gen_loader_opts *gen)
 	ctx = alloca(ctx_sz);
 	memset(ctx, 0, ctx_sz);
 	ctx->sz = ctx_sz;
-	ctx->log_level = 1;
-	ctx->log_size = log_buf_sz;
-	log_buf = malloc(log_buf_sz);
-	if (!log_buf)
-		return -ENOMEM;
-	ctx->log_buf = (long) log_buf;
+	if (verifier_logs) {
+		ctx->log_level = 1 + 2 + 4;
+		ctx->log_size = log_buf_sz;
+		log_buf = malloc(log_buf_sz);
+		if (!log_buf)
+			return -ENOMEM;
+		ctx->log_buf = (long) log_buf;
+	}
 	opts.ctx = ctx;
 	opts.data = gen->data;
 	opts.data_sz = gen->data_sz;
@@ -1793,9 +1795,9 @@ static int try_loader(struct gen_loader_opts *gen)
 	fds_before = count_open_fds();
 	err = bpf_load_and_run(&opts);
 	fd_delta = count_open_fds() - fds_before;
-	if (err < 0) {
+	if (err < 0 || verifier_logs) {
 		fprintf(stderr, "err %d\n%s\n%s", err, opts.errstr, log_buf);
-		if (fd_delta)
+		if (fd_delta && err < 0)
 			fprintf(stderr, "loader prog leaked %d FDs\n",
 				fd_delta);
 	}
-- 
2.30.2

