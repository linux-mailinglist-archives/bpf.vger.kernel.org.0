Return-Path: <bpf+bounces-22770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00E2869A05
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 16:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2B21F24395
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4E14534F;
	Tue, 27 Feb 2024 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MunjGpUr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D913B2B3;
	Tue, 27 Feb 2024 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046703; cv=none; b=sQEGGBUXM+3WTw5L7hk7eCgPFwO2fXK6h/KsyqudLFo6QfWw54GZ4z2ZVg0SDVgrSMKXHbRlQtffDes3i4tLZ9M4y4O3KZU2FOsI17M/FxUBaqq7XYueqrFVan+ymZ1BOlIwsl125LbmtyIryrznZ8b0fjoryeBYCKgLBMcH0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046703; c=relaxed/simple;
	bh=GvUIZKcHHKBnQQAaTnEtyLTv8orDMf6CA4/PYxI3DNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fa0wh8t0oHxSY2jZY1UEIp3HLQ5ujNVWJNODmvp1whyN27Pc1PcD+roZu56GvobO8UTr2r3Xuk7adarH8K6YDcj+OfMEBgf/ArHL1gon2zI0p1zO8zu6DizlNpm9uuv2PbaC0rC6Swptl0liXi82gJU3tjPin82pFtf03kVfr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MunjGpUr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d7b8f563eso3550962f8f.0;
        Tue, 27 Feb 2024 07:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046700; x=1709651500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfgf6iCOs5FvWaw1ia5k8xLHc6e2QjcjYzqDMduTgxk=;
        b=MunjGpUrxVjbiwTVwc6tlysycYjTTjRE+vS7YafEKRas0/O1EBZkcJULaVWyoVvp1j
         7y4ZdAAUeXTRrEV6ahg/DwWpAMaApaGIN7B4KafQE+tVaEwE5F/xq6caA0BY3nM9MPF1
         C2w9xW7mVG0lIrbX8YaJzuLKxS0eg2RZ6OLnqElUBOf+nIJaNbdVpy5NccSw/ItnDx2E
         Vl7zIbsBaGtc1ScGyBnUGJTxKV6s58tBIhoeJoBT1f5WyKcYevbNaeaDLfXswX70M5vo
         usmoL52XYQTjO6ZJ5TA4Rl5MVhoRTYWi0lftAYsnyOfOBpFYjlLUfnVy3SjZpKnYdrJS
         pkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046700; x=1709651500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pfgf6iCOs5FvWaw1ia5k8xLHc6e2QjcjYzqDMduTgxk=;
        b=A9g42Yhh2Wzzgjk+35iZB7ZNKiaJnXPQDXO61ZJ+aOHhdXbUlLOtu90gPt/AD1vLo8
         s6PJAmHORaQ1eomQURjdK+aSXhgCWyk8jiJEFASUbTE1Bp4KNl3feFnz0NVE9dHaXl09
         62gKTUBk6i675/9YOF8Rnioab+hHSdoQWkWtzJBONxzDp9AD+9vfTsPkaVicp6yfrSjd
         Yt8YLgmaMrjA+XFfHwyzYUoAZsRKcZocfb8T68gkM+KqwTXgpWtSic2ugG/MusYLCy04
         oPHoCU8yoHdVmHU8cfQlTykJDImV45QsK2HXx4SdtlB6UC0UFwsOe75xuNkWQcBXnaMP
         0P6w==
X-Forwarded-Encrypted: i=1; AJvYcCVWaAKPxW+iVotQn15wP2qzMqharHSzssnsGjBkpxxvIxhxus6hnQMBMq5QVVKTfatTVYzt1NxJa0F2hL0Vo5NIv3xTP9miizMnydQg52q8B+fTxm/Ss4sZPMLP99miB6UQ
X-Gm-Message-State: AOJu0YxZV+XEWscYAju6hlX3Ml/64sLk3eFBdHiEFDNdeQU0L1rFI+Bh
	8sOZlyN5zYBhi7C7V0P9wn31y++ynH/+8XDCxUsoglJ241vuAlLQ
X-Google-Smtp-Source: AGHT+IGi22IcrcMjuPixoEYXnz/VFg0RYi4SuhHKNmgYNnAFLM9gxRbZeI9hMSQI9xm3s6jc52Gc3g==
X-Received: by 2002:adf:f390:0:b0:33d:afbc:6c76 with SMTP id m16-20020adff390000000b0033dafbc6c76mr8159783wro.1.1709046699465;
        Tue, 27 Feb 2024 07:11:39 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id w10-20020adff9ca000000b0033d1b760125sm11751556wrr.92.2024.02.27.07.11.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2024 07:11:38 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 0/1] Support kCFI + BPF on arm64
Date: Tue, 27 Feb 2024 15:11:14 +0000
Message-Id: <20240227151115.4623-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ARM64 with CONFIG_CFI_CLANG, CFI warnings can be triggered by running
the bpf selftests. This is because the JIT doesn't emit proper CFI prologues
for BPF programs, callbacks, and struct_ops trampolines.

Example Warning:

 CFI failure at bpf_rbtree_add_impl+0x120/0x1d4 (target: bpf_prog_fb8b097ab47d164a_less+0x0/0x98; expected type: 0x9e4709a9)
 WARNING: CPU: 0 PID: 1488 at bpf_rbtree_add_impl+0x120/0x1d4
 Modules linked in: bpf_testmod(OE) virtio_net net_failover failover aes_ce_blk aes_ce_cipher ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_mmio uio_pdrv_genirq uio dm_mod dax configfs [last unloaded: bpf_testmod(OE)]
 CPU: 0 PID: 1488 Comm: new_name Tainted: P           OE      6.8.0-rc1+ #1
 Hardware name: linux,dummy-virt (DT)
 pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : bpf_rbtree_add_impl+0x120/0x1d4
 lr : bpf_prog_234260f1d6227155_rbtree_first_and_remove+0x218/0x438
 sp : ffff80008444bb10
 x29: ffff80008444bb10 x28: ffff80008444bbf0 x27: ffff80008444bb60
 x26: 0000000000000000 x25: 0000000000000010 x24: 0000000000000008
 x23: 0000000000000001 x22: ffff00000ab71658 x21: ffff8000843dd5fc
 x20: ffff00000ab459f0 x19: ffff00000ab71358 x18: 0000000000000000
 x17: 000000009e4709a9 x16: 00000000d4202000 x15: 0000aaaadf15e420
 x14: 0000000000004007 x13: ffff800084448000 x12: 0000000000000000
 x11: dead00000000eb9f x10: ffff00000ab71370 x9 : 0000000000000000
 x8 : ffff00000ab71658 x7 : 0000000000000000 x6 : 0000000000000000
 x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : ffff00000ab71658 x0 : ffff00000ab71358
 Call trace:
  bpf_rbtree_add_impl+0x120/0x1d4
  bpf_prog_234260f1d6227155_rbtree_first_and_remove+0x218/0x438
  bpf_test_run+0x190/0x358
  bpf_prog_test_run_skb+0x354/0x460
  bpf_prog_test_run+0x128/0x164
  __sys_bpf+0x364/0x428
  __arm64_sys_bpf+0x30/0x44
  invoke_syscall+0x64/0x128
  el0_svc_common+0xb4/0xe8
  do_el0_svc+0x28/0x34
  el0_svc+0x58/0x108
  el0t_64_sync_handler+0x90/0xfc
  el0t_64_sync+0x1a8/0x1ac
 irq event stamp: 35493817
 hardirqs last  enabled at (35493816): [<ffff8000802e4268>] unit_alloc+0x110/0x1b0
 hardirqs last disabled at (35493817): [<ffff8000802ad35c>] bpf_spin_lock+0x2c/0xec
 softirqs last  enabled at (35493688): [<ffff800080275934>] bpf_ksym_add+0x164/0x184
 softirqs last disabled at (35493810): [<ffff800080cd9ac8>] local_bh_disable+0x4/0x30
 ---[ end trace 0000000000000000 ]---

This patch fixes the prologue and trampoline generation code to emit the
KCFI hash before the expected branch targets. The KCFI hashes are generated
at compile time and are unique to function prototypes. To allow the JIT to
find these hashes at runtime, the following behaviour of the compiler is used:

Two function prototypes are declared, one for BPF programs and another for callbacks:

extern unsigned int __bpf_prog_runX(const void *ctx, const struct bpf_insn *insn);
extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);

We force a reference to these external symbols:

__ADDRESSABLE(__bpf_prog_runX);
__ADDRESSABLE(__bpf_callback_fn);

This makes the compiler add the following two symbols with the hashes in
the symbol table:

00000000d9421881     0 NOTYPE  WEAK   DEFAULT  ABS __kcfi_typeid___bpf_prog_runX
000000009e4709a9     0 NOTYPE  WEAK   DEFAULT  ABS __kcfi_typeid___bpf_callback_fn

The JIT can now use the above symbols to emit the hashes in the prologues of
the programs and callbacks.

For struct_ops trampoline, the bpf_struct_ops_prepare_trampoline() function
receives a stub function that would have the hash at (function - 4). The
bpf_struct_ops_prepare_trampoline() sets `flags = BPF_TRAMP_F_INDIRECT;`
which tells prepare_trampoline() to find the hash before the stub function
and emit it in the struct_ops trampoline.

Running the selftests causes no CFI warnings:
---------------------------------------------

test_progs: Summary: 454/3613 PASSED, 62 SKIPPED, 74 FAILED
test_tag: OK (40945 tests)
test_verifier: Summary: 789 PASSED, 0 SKIPPED, 0 FAILED

ARM64 Doesn't support DYNAMIC_FTRACE_WITH_CALL_OPS when CFI_CLANG is
enabled. This causes all tests that attach fentry to kernel functions to fail.

While running the selftests, I saw some CFI warnings which were related to
static calls. Josh Poimboeuf had sent a patch series[1] last year that includes
a patch to fix this issue. I forward ported those patches and rebased my patch
on that series. You can find the tree here[2]. With this tree there are
zero CFI warnings.

[1] https://lore.kernel.org/all/cover.1679456900.git.jpoimboe@kernel.org/
[2] https://github.com/puranjaymohan/linux/tree/kcfi_bpf

Puranjay Mohan (1):
  arm64/cfi,bpf: Support kCFI + BPF on arm64

 arch/arm64/include/asm/cfi.h    | 23 ++++++++++++++
 arch/arm64/kernel/alternative.c | 54 +++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c   | 26 ++++++++++++----
 3 files changed, 97 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h

-- 
2.40.1


