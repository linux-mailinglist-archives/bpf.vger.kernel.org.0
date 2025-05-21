Return-Path: <bpf+bounces-58665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2ABABFCDE
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94999E5752
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB31E3DED;
	Wed, 21 May 2025 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiZEDFfv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82FE22FF42;
	Wed, 21 May 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852309; cv=none; b=Xg4srhDLX0btAhjUP86auWYX1n3VHZPapHDhv0d4p1YTT0/lmOo/1QEehW8d6BYnzAfvXQwMnRB4lvGGgNkwtstRTN0wZuDYkQqJA74qN1gicBf78umGSRg6T6iFZtywI9ojneyfX92rQih+Faeugt8XeMXvGZuUmVuFMejWd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852309; c=relaxed/simple;
	bh=VfQkC8b965RKXGTa8a92jClkdj8ZsqN4QbPyT7wSK0A=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rrwRSs6Gwnkfwn1jRJA7MuQ17hizzokHWslpP+xZmA00D/BsUK9hkhUlF2gLBoYRqickQgbDaPlE/g12O2SQr/fbEkUpt8kK494FibLi4H0pB91VIIXg50H9U4vVpbAbgBHXznXe/2GtRskhvkSgZnIWPbteOaSiHikJqaY9sEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiZEDFfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC80BC4CEEA;
	Wed, 21 May 2025 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747852309;
	bh=VfQkC8b965RKXGTa8a92jClkdj8ZsqN4QbPyT7wSK0A=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=SiZEDFfv/JqF5cgVzbbAq3YeHhk3WyjvrShj43MuiX34DkFj6564u+omftuhjfNBz
	 bsWKP4DN8o1FSkczWY254vqQM0vI2P6Kh6UGaoIkjbATqz7gbDsUoqXSiq8CJLJQvu
	 7IXVBSJbX8Up6Id/IERpkeWoot8dQdqoWeSEw+g0/0YsOrGQi0yOF9pCaZAjIFJSBC
	 Ipi9bcE2Jf+dc9fOSEg1xtGGQ8o7yvt7cn/A43HwOe2t+jiXI059dRS9rGhBNxC7/9
	 THnXvs0IHJHr1KF0NTmdBEYgHI8x2PuWMZ85j/pyTzttxc54VBPMsn3oqUCNSHF0EH
	 B+ZNlbghwtaAA==
From: Puranjay Mohan <puranjay@kernel.org>
To: syzbot <syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in bpf_check (4)
In-Reply-To: <682dd10b.a00a0220.29bc26.028e.GAE@google.com>
References: <682dd10b.a00a0220.29bc26.028e.GAE@google.com>
Date: Wed, 21 May 2025 18:31:41 +0000
Message-ID: <mb61p7c29zugi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    172a9d94339c Merge tag '6.15-rc6-smb3-client-fixes' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d15ef4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4f080d149583fe67
> dashboard link: https://syzkaller.appspot.com/bug?extid=0ef84a7bdf5301d4cbec
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130462d4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14efaef4580000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-172a9d94.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/88f3b6a8815a/vmlinux-172a9d94.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8835063aa13d/zImage-172a9d94.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3102 at kernel/bpf/verifier.c:20723 opt_subreg_zext_lo32_rnd_hi32 kernel/bpf/verifier.c:20723 [inline]
> WARNING: CPU: 1 PID: 3102 at kernel/bpf/verifier.c:20723 bpf_check+0x2d58/0x2ed4 kernel/bpf/verifier.c:24078
> Modules linked in:
> Kernel panic - not syncing: kernel: panic_on_warn set ...
> CPU: 1 UID: 0 PID: 3102 Comm: syz-executor107 Not tainted 6.15.0-rc6-syzkaller #0 PREEMPT 
> Hardware name: ARM-Versatile Express
> Call trace: 
> [<802019e4>] (dump_backtrace) from [<80201ae0>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
>  r7:00000000 r6:828227fc r5:00000000 r4:82257e84
> [<80201ac8>] (show_stack) from [<8021ff7c>] (__dump_stack lib/dump_stack.c:94 [inline])
> [<80201ac8>] (show_stack) from [<8021ff7c>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:120)
> [<8021ff28>] (dump_stack_lvl) from [<8021ffbc>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
>  r5:00000000 r4:82a70d4c
> [<8021ffa4>] (dump_stack) from [<802025f8>] (panic+0x120/0x374 kernel/panic.c:354)
> [<802024d8>] (panic) from [<802619e8>] (check_panic_on_warn kernel/panic.c:243 [inline])
> [<802024d8>] (panic) from [<802619e8>] (get_taint+0x0/0x1c kernel/panic.c:238)
>  r3:8280c604 r2:00000001 r1:8223ea4c r0:8224654c
>  r7:804020d0
> [<80261974>] (check_panic_on_warn) from [<80261b4c>] (__warn+0x80/0x188 kernel/panic.c:749)
> [<80261acc>] (__warn) from [<80261dcc>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:776)
>  r8:00000009 r7:8225e3a4 r6:df989c44 r5:844f0000 r4:00000000
> [<80261c58>] (warn_slowpath_fmt) from [<804020d0>] (opt_subreg_zext_lo32_rnd_hi32 kernel/bpf/verifier.c:20723 [inline])
> [<80261c58>] (warn_slowpath_fmt) from [<804020d0>] (bpf_check+0x2d58/0x2ed4 kernel/bpf/verifier.c:24078)
>  r10:00000002 r9:84850000 r8:00000004 r7:00000002 r6:00000003 r5:000000c3
>  r4:ffffffff
> [<803ff378>] (bpf_check) from [<803d66d0>] (bpf_prog_load+0x68c/0xc20 kernel/bpf/syscall.c:2971)

I think this issue is triggered because insn_def_regno() doesn't
understand BPF_LOAD_ACQ and returns -1 for it. On arm32 and other
architectures that need zext, BPF_LOAD_ACQ will be marked for zext if
the load is < 64 bit, but when opt_subreg_zext_lo32_rnd_hi32() tries to
find the destination register to zext for BPF_LOAD_ACQ, it gets -1 from
insn_def_regno() and triggers the WARN().

This should be fixed by the the patch at the end.

Thanks,
Puranjay

#syz test

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..9aa67e46cb8b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3643,6 +3643,9 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 /* Return the regno defined by the insn, or -1. */
 static int insn_def_regno(const struct bpf_insn *insn)
 {
+       if (is_atomic_load_insn(insn))
+               return insn->dst_reg;
+
        switch (BPF_CLASS(insn->code)) {
        case BPF_JMP:
        case BPF_JMP32:

