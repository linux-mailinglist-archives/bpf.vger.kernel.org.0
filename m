Return-Path: <bpf+bounces-57732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E19AAF292
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 07:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378CA3B1D15
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331CB215070;
	Thu,  8 May 2025 05:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i1pPdaVg"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBC210F59
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680773; cv=none; b=RJy4dJv/OtHQpyav52aFiPfG7XUmUomQuNxSFzWC60sNX9OkLiS1kJHLRkJ2XBLrwoYe+2mMLOeHinlIpx2pUAkmRXVnEEpxRLMnw9JcAfa7vcsq6c2q+RSqtcX9tvKG6/iX95A8VNiSVl8zGB1wldYkpTsDWbiKdiC2W86uLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680773; c=relaxed/simple;
	bh=RsfaED26pfw6JjUOq1mJOmhNfVnokkIsAYZ1hzcDSKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbbvj0Of+FtsZTX2linv7SIM4HJWYvUL7kqEF29uQuy4W4fC7A/Xy0xjZkusvYLpp73g38tXn4qUQhgkFheMBCeVhskwLfEOO55M9euUOE7i3e8r724GePI1W18DYRiEdn/s70tK9rXvwZs/VtCjI1vZP+MRfdl7X2a6q68stRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i1pPdaVg; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <763cbfb4-b1a0-4752-8428-749bb12e2103@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746680767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xinyocB3ig1oT1OM1/gr1VSp0AJD83rT1kMV9JeGv6Y=;
	b=i1pPdaVgAXbWvL4bR7hRfxbwOe7+yCaoLYJK0oJLOJyPN2qkFjAGRLVDTk3oQorcHoTWnK
	fsE/HPGYRARo/urCCsKiz/xtMVRWJoMFsUaO/RZa5Zz4ghWJO8137vI+5mLaHtZre+hrho
	Espx1XGF4fU9okJcPMgEfOrcu4K1HYM=
Date: Wed, 7 May 2025 22:06:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 07/17] bpf: Support new 32bit offset jmp
 instruction
Content-Language: en-GB
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 David Faust <david.faust@oracle.com>, Fangrui Song <maskray@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Eduard Zingerman <eddyz87@gmail.com>, yi1.lai@intel.com
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
 <20230728011231.3716103-1-yonghong.song@linux.dev>
 <Z/8q3xzpU59CIYQE@ly-workstation>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <Z/8q3xzpU59CIYQE@ly-workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/15/25 11:58 AM, Lai, Yi wrote:
> Hi Yonghong Song,
>
> Greetings!
>
> I used Syzkaller and found that there is WARNING in __mark_chain_precision in linux-next tag - next-20250414.

Thanks, Yi. I will investigate this soon.

>
> After bisection and the first bad commit is:
> "
> 4cd58e9af8b9 bpf: Support new 32bit offset jmp instruction
> "
>
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250415_203801___mark_chain_precision/bzImage_8ffd015db85fea3e15a77027fda6c02ced4d2444
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/250415_203801___mark_chain_precision/8ffd015db85fea3e15a77027fda6c02ced4d2444_dmesg.log
>
> "
> [   51.167546] ------------[ cut here ]------------
> [   51.167803] verifier backtracking bug
> [   51.167867] WARNING: CPU: 1 PID: 672 at kernel/bpf/verifier.c:4302 __mark_chain_precision+0x35d3/0x37b0
> [   51.168496] Modules linked in:
> [   51.168684] CPU: 1 UID: 0 PID: 672 Comm: repro Not tainted 6.15.0-rc2-8ffd015db85f #1 PREEMPT(voluntary)
> [   51.169127] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
> [   51.169980] RIP: 0010:__mark_chain_precision+0x35d3/0x37b0
> [   51.170255] Code: 06 31 ff 89 de e8 cd 0b e0 ff 84 db 0f 85 a7 e5 ff ff e8 90 11 e0 ff 48 c7 c7 a0 cb f4 85 c6 05 f
> [   51.171108] RSP: 0018:ffff8880115ff2d8 EFLAGS: 00010296
> [   51.171424] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81470f72
> [   51.171759] RDX: ffff88801f422540 RSI: ffffffff81470f7f RDI: 0000000000000001
> [   51.172112] RBP: ffff8880115ff428 R08: 0000000000000001 R09: ffffed100d8a5941
> [   51.172443] R10: 0000000000000000 R11: ffff88801f423398 R12: 0000000000000400
> [   51.172769] R13: dffffc0000000000 R14: 0000000000000002 R15: ffff88801f720000
> [   51.173152] FS:  00007f8a0a0b1600(0000) GS:ffff8880e3684000(0000) knlGS:0000000000000000
> [   51.173563] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   51.173861] CR2: 0000000000402010 CR3: 000000001179a006 CR4: 0000000000770ef0
> [   51.174244] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   51.174614] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [   51.174995] PKRU: 55555554
> [   51.175151] Call Trace:
> [   51.175302]  <TASK>
> [   51.175439]  ? __lock_acquire+0x381/0x2260
> [   51.175675]  ? __pfx___sanitizer_cov_trace_const_cmp4+0x10/0x10
> [   51.176006]  ? __pfx___mark_chain_precision+0x10/0x10
> [   51.176326]  ? mark_reg_read+0x1e4/0x340
> [   51.176558]  ? __check_reg_arg+0x1c8/0x440
> [   51.176802]  ? kasan_quarantine_put+0xa2/0x200
> [   51.177068]  check_cond_jmp_op+0x2692/0x65f0
> [   51.177335]  ? krealloc_noprof+0xe5/0x330
> [   51.177569]  ? krealloc_noprof+0x190/0x330
> [   51.177790]  ? __pfx_check_cond_jmp_op+0x10/0x10
> [   51.178060]  ? push_insn_history+0x1d0/0x6d0
> [   51.178308]  do_check_common+0x9134/0xd570
> [   51.178532]  ? ns_capable+0xec/0x130
> [   51.178748]  ? bpf_base_func_proto+0x7e/0xbe0
> [   51.179025]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [   51.179319]  ? __pfx_do_check_common+0x10/0x10
> [   51.179540]  ? __pfx_mark_fastcall_pattern_for_call+0x10/0x10
> [   51.179864]  ? bpf_check+0x89b9/0xd880
> [   51.180072]  ? kvfree+0x32/0x40
> [   51.180237]  bpf_check+0x9c27/0xd880
> [   51.180450]  ? rcu_is_watching+0x19/0xc0
> [   51.180680]  ? __lock_acquire+0x380/0x2260
> [   51.180900]  ? __pfx_bpf_check+0x10/0x10
> [   51.181099]  ? __lock_acquire+0x410/0x2260
> [   51.181355]  ? __this_cpu_preempt_check+0x21/0x30
> [   51.181673]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [   51.181989]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [   51.182229]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [   51.182510]  ? bpf_obj_name_cpy+0x152/0x1b0
> [   51.182765]  bpf_prog_load+0x14d7/0x2600
> [   51.182970]  ? __pfx_bpf_prog_load+0x10/0x10
> [   51.183193]  ? __might_fault+0x14a/0x1b0
> [   51.183435]  ? __this_cpu_preempt_check+0x21/0x30
> [   51.183670]  ? lock_release+0x14f/0x2c0
> [   51.183876]  ? __might_fault+0xf1/0x1b0
> [   51.184074]  __sys_bpf+0x18ac/0x5c10
> [   51.184279]  ? __pfx___sys_bpf+0x10/0x10
> [   51.184502]  ? __lock_acquire+0x410/0x2260
> [   51.184725]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [   51.184960]  ? ktime_get_coarse_real_ts64+0xb6/0x100
> [   51.185253]  ? __audit_syscall_entry+0x39c/0x500
> [   51.185507]  __x64_sys_bpf+0x7d/0xc0
> [   51.185718]  ? syscall_trace_enter+0x14d/0x280
> [   51.185945]  x64_sys_call+0x204a/0x2150
> [   51.186182]  do_syscall_64+0x6d/0x150
> [   51.186395]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   51.186654] RIP: 0033:0x7f8a09e3ee5d
> [   51.186869] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 8
> [   51.187767] RSP: 002b:00007fff00100bb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> [   51.188152] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8a09e3ee5d
> [   51.188527] RDX: 0000000000000090 RSI: 00000000200009c0 RDI: 0000000000000005
> [   51.188895] RBP: 00007fff00100bc0 R08: 0000000000000000 R09: 0000000000000001
> [   51.189263] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff00100cd8
> [   51.189657] R13: 0000000000401146 R14: 0000000000403e08 R15: 00007f8a0a0fa000
> [   51.190071]  </TASK>
> [   51.190197] irq event stamp: 3113
> [   51.190380] hardirqs last  enabled at (3121): [<ffffffff8165d8c5>] __up_console_sem+0x95/0xb0
> [   51.190797] hardirqs last disabled at (3128): [<ffffffff8165d8aa>] __up_console_sem+0x7a/0xb0
> [   51.191214] softirqs last  enabled at (2600): [<ffffffff8149050e>] __irq_exit_rcu+0x10e/0x170
> [   51.191656] softirqs last disabled at (2589): [<ffffffff8149050e>] __irq_exit_rcu+0x10e/0x170
> [   51.192093] ---[ end trace 0000000000000000 ]---
> "
>
> Hope this cound be insightful to you.
>
> Regards,
> Yi Lai
>
> ---
>
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>    // You could change the bzImage_xxx as you want
>    // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
>
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>
[...]

