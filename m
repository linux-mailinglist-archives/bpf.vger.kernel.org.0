Return-Path: <bpf+bounces-23275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D9586F64F
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 18:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05741C21F17
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE176044;
	Sun,  3 Mar 2024 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM6nnGy4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73E76033;
	Sun,  3 Mar 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709485351; cv=none; b=gbVzDm+HHwZF4iq77Fs23aQiMzFTrgJr1qo/atXcG+rV6KVWS0hrNu+NIu0kcdbG58Cj9ZRSlsuwBDfcH2S/klcJuyS041gKLGhrGwZD/QnSnOrGyF8TfRUfksA270cyYnU76ONSIrgJdFiZMvmHsseWtTWzmJiiCobk7AmnZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709485351; c=relaxed/simple;
	bh=f09NI2/XxHP07DS5G48Jhx1ZgN9x1rYt+LRFgFJxvVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EV+wq4WHgBBl59qy33aVWTpFoPtUQo07qFpQWDFuN3bN/KmagzUD1C2VrH0qTjmECzMmd3dYB5bzV1+Y6Ulf1m+9SXjAh4jSFSFvgPP3iuQSnmqJB7+2xhbmnjkO2XnXMl96ZqEit/yr48hb68Lc9+5cSCWHLp+bCRaQAkufRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM6nnGy4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412e4426e32so160345e9.2;
        Sun, 03 Mar 2024 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709485348; x=1710090148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXb8hGH2jHCp7nT3iUyBh9PSkpjh+LjZSwquxd8Rwc0=;
        b=RM6nnGy4gY2N5euRbjm3nEiobOrU7I1909hhvJOj9xF3GmofKe0hMWFh4aA6DA5Hs+
         gFsK3TJR7DGjrBsZ5hpIQGEat9lVDEuUxzjFeOtI75wMkL7ihJlTBJ9XEpOHIPaIBbSz
         Rq87P0WwVsNQ59VFGABlAgwkhFVMoR61r+MdU3SYon1oaxxlmGLDkT95yLEQBr0j1zGl
         UVqtDGxhwhyTinAcIynNBNGOyKzjI39kMpaKmzfK3LvM4VdiJZowCvMZhHZzvcFLPWDr
         V4++MuCv7JA91LAuAikzfReUzyK5E/JaweWzUNbHJoqPJtmI+i+S8M8sXlce8nmOTREf
         yz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709485348; x=1710090148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXb8hGH2jHCp7nT3iUyBh9PSkpjh+LjZSwquxd8Rwc0=;
        b=PiPpQWTy7HC3Q0tj1Dg7LjSRV10WH/BE1tjJ2qODIsW0gbfLX73tf4+LF3VNH7PBC4
         tVejaHSw3Z/KE1nAmxLYpG4Q9oivt0jvksJbPD2/xk8F42rE1EhKfRI/95cc7s91ZJvx
         Xf7oxqp3fx5uSB+KYWVyyiw+4fqFGG3Q9taXoBPMyM1EWlNox78WIgwzpyQP3FulKBP6
         ClWQvXTKEExjjB9tblafwYPJgYGdlovcduZtbt7CtLVBXUn9qwy/C5QGhXC38Ie+p52m
         Gq2YqACYwBfXk2UWyN4p5OgmdziCC/JO+BiW4o635gEPD5ut/FJva9IcNbV0Lx74t38S
         Eldw==
X-Forwarded-Encrypted: i=1; AJvYcCW+vYV5K7p0dyU4OaLsz+/BbPljfO1AJyBh0PE6SlWnSY/KGe+t6zhu6dZ7sPkhnBNS2vnGZf4R2o5kjm3yz7jFxlg0mGy+mJZ7IaNbTt35IloaSXW3Lj//BS+SRDaifDyY
X-Gm-Message-State: AOJu0YyoeFqNBfnAuHGM/eQH05pcyPn/hxSHWbEVjCMGYPxpGUZ4aniB
	6ktf/o6MowYoutR4w2dc7GN6sQPALt7jykJrNprYv/0Sx0AQNsr+
X-Google-Smtp-Source: AGHT+IF/TqX/I0NZGfvkrtdnuIrxpQgk8oUm1ToE2zC3uGin/sJGLVKXB2EguEYWlR9r7OLsWT2HLQ==
X-Received: by 2002:adf:eb03:0:b0:33d:2dd4:7f5b with SMTP id s3-20020adfeb03000000b0033d2dd47f5bmr4453339wrn.45.1709485347987;
        Sun, 03 Mar 2024 09:02:27 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id v13-20020adfd04d000000b0033d202abf01sm9986612wrh.28.2024.03.03.09.02.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2024 09:02:27 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 0/1] Support kCFI + BPF on riscv64
Date: Sun,  3 Mar 2024 17:02:06 +0000
Message-Id: <20240303170207.82201-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_CFI_CLANG, the compiler injects a type preamble immediately
before each function and a check to validate the target function type
before indirect calls:

  ; type preamble
    .word <id>
  function:
    ...
  ; indirect call check
    lw      t1, -4(a0)
    lui     t2, <hi20>
    addiw   t2, t2, <lo12>
    beq     t1, t2, .Ltmp0
    ebreak
  .Ltmp0:
    jarl    a0

BPF JIT currently doesn't emit this preamble before BPF programs and when
the calling fuction tries to load the type id from the preamble, it finds
an invalid value there.

This will cause CFI failures like in the following bpf selftest:

root@rv-selftester:~/bpf# ./test_progs -a "rbtree_success"

 CFI failure at bpf_rbtree_add_impl+0x148/0x350 (target: bpf_prog_fb8b097ab47d164a_less+0x0/0x42; expected type: 0x00000000)
 WARNING: CPU: 1 PID: 278 at bpf_rbtree_add_impl+0x148/0x350
 Modules linked in: bpf_testmod(OE) drm fuse dm_mod backlight i2c_core configfs drm_panel_orientation_quirks ip_tables x_tables
 CPU: 1 PID: 278 Comm: test_progs Tainted: P           OE      6.8.0-rc1 #1
 Hardware name: riscv-virtio,qemu (DT)
 epc : bpf_rbtree_add_impl+0x148/0x350
  ra : bpf_prog_27b36e47d273751e_rbtree_first_and_remove+0x1aa/0x35e
 epc : ffffffff805acc0c ra : ffffffff780077fa sp : ff2000000110b9d0
  gp : ffffffff868d6218 tp : ff60000085772a40 t0 : ffffffff86849660
  t1 : 0000000000000000 t2 : ffffffff9e4709a9 s0 : ff2000000110ba50
  s1 : ff60000089c14958 a0 : ff60000089c14758 a1 : ff60000089c14958
  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
  a5 : 0000000000000000 a6 : ff6000008aba4b30 a7 : ffffffff86849640
  s2 : ff6000008aba4b30 s3 : ff60000089c14758 s4 : ffffffff780079f0
  s5 : 0000000000000000 s6 : ffffffff84c01080 s7 : ff6000008aba4b30
  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000001
  s11: 0000000000000000 t3 : ffffffff868499e0 t4 : ffffffff868499c0
  t5 : ffffffff86849840 t6 : ffffffff86849860
 status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
 [<ffffffff805acc0c>] bpf_rbtree_add_impl+0x148/0x350
 [<ffffffff780077fa>] bpf_prog_27b36e47d273751e_rbtree_first_and_remove+0x1aa/0x35e
 [<ffffffff8294f32c>] bpf_test_run+0x2a4/0xa3c
 [<ffffffff8294d032>] bpf_prog_test_run_skb+0x47a/0xe52
 [<ffffffff805083ee>] bpf_prog_test_run+0x170/0x548
 [<ffffffff805029c8>] __sys_bpf+0x2d2/0x378
 [<ffffffff804ff570>] __riscv_sys_bpf+0x5c/0x120
 [<ffffffff8000e8fe>] syscall_handler+0x62/0xe4
 [<ffffffff83362df6>] do_trap_ecall_u+0xc6/0x27c
 [<ffffffff833822c4>] ret_from_exception+0x0/0x64
 ---[ end trace 0000000000000000 ]---

The calling function tries to load the type id hash from target_func - 4.
If this memory address is not mapped then it can cause a page fault and
crash the kernel.

This behaviour can be seen by running the 'dummy_st_ops' selftest:

root@rv-selftester:~/bpf# ./test_progs -a dummy_st_ops

 Unable to handle kernel paging request at virtual address ffffffff78204ffc
 Oops [#1]
 Modules linked in: bpf_testmod(OE) drm fuse backlight i2c_core drm_panel_orientation_quirks dm_mod configfs ip_tables x_tables [last unloaded: bpf_testmod(OE)]
 CPU: 3 PID: 356 Comm: test_progs Tainted: P           OE      6.8.0-rc1 #1
 Hardware name: riscv-virtio,qemu (DT)
 epc : bpf_struct_ops_test_run+0x28c/0x5fc
  ra : bpf_struct_ops_test_run+0x26c/0x5fc
 epc : ffffffff82958010 ra : ffffffff82957ff0 sp : ff200000007abc80
  gp : ffffffff868d6218 tp : ff6000008d87b840 t0 : 000000000000000f
  t1 : 0000000000000000 t2 : 000000002005793e s0 : ff200000007abcf0
  s1 : ff6000008a90fee0 a0 : 0000000000000000 a1 : 0000000000000000
  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
  a5 : ffffffff868dba26 a6 : 0000000000000001 a7 : 0000000052464e43
  s2 : 00007ffffc0a95f0 s3 : ff6000008a90fe80 s4 : ff60000084c24c00
  s5 : ffffffff78205000 s6 : ff60000088750648 s7 : ff20000000035008
  s8 : fffffffffffffff4 s9 : ffffffff86200610 s10: 0000000000000000
  s11: 0000000000000000 t3 : ffffffff8483dc30 t4 : ffffffff8483dc10
  t5 : ffffffff8483dbf0 t6 : ffffffff8483dbd0
 status: 0000000200000120 badaddr: ffffffff78204ffc cause: 000000000000000d
 [<ffffffff82958010>] bpf_struct_ops_test_run+0x28c/0x5fc
 [<ffffffff805083ee>] bpf_prog_test_run+0x170/0x548
 [<ffffffff805029c8>] __sys_bpf+0x2d2/0x378
 [<ffffffff804ff570>] __riscv_sys_bpf+0x5c/0x120
 [<ffffffff8000e8fe>] syscall_handler+0x62/0xe4
 [<ffffffff83362df6>] do_trap_ecall_u+0xc6/0x27c
 [<ffffffff833822c4>] ret_from_exception+0x0/0x64
 Code: b603 0109 b683 0189 b703 0209 8493 0609 157d 8d65 (a303) ffca
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Fatal exception
 SMP: stopping secondary CPUs

This patch improves the BPF JIT for the riscv64 architecture to emit kCFI
type id before BPF programs and struct ops trampolines.

After applying this patch, the above two selftests pass without any issues.

 root@rv-selftester:~/bpf# ./test_progs -a "rbtree_success,dummy_st_ops"
 #70/1    dummy_st_ops/dummy_st_ops_attach:OK
 #70/2    dummy_st_ops/dummy_init_ret_value:OK
 #70/3    dummy_st_ops/dummy_init_ptr_arg:OK
 #70/4    dummy_st_ops/dummy_multiple_args:OK
 #70/5    dummy_st_ops/dummy_sleepable:OK
 #70/6    dummy_st_ops/test_unsupported_field_sleepable:OK
 #70      dummy_st_ops:OK
 #189/1   rbtree_success/rbtree_add_nodes:OK
 #189/2   rbtree_success/rbtree_add_and_remove:OK
 #189/3   rbtree_success/rbtree_first_and_remove:OK
 #189/4   rbtree_success/rbtree_api_release_aliasing:OK
 #189     rbtree_success:OK
 Summary: 2/10 PASSED, 0 SKIPPED, 0 FAILED

 root@rv-selftester:~/bpf# zcat /proc/config.gz | grep CONFIG_CFI_CLANG
 CONFIG_CFI_CLANG=y

Puranjay Mohan (1):
  riscv64/cfi,bpf: Support kCFI + BPF on riscv64

 arch/riscv/include/asm/cfi.h    | 17 +++++++++++
 arch/riscv/kernel/cfi.c         | 53 +++++++++++++++++++++++++++++++++
 arch/riscv/net/bpf_jit.h        |  2 +-
 arch/riscv/net/bpf_jit_comp32.c |  2 +-
 arch/riscv/net/bpf_jit_comp64.c | 14 ++++++++-
 arch/riscv/net/bpf_jit_core.c   |  9 +++---
 6 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.40.1


