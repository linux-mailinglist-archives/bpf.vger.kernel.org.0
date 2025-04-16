Return-Path: <bpf+bounces-56022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854E9A8AECA
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 05:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519BD1904741
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 03:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C38227EA1;
	Wed, 16 Apr 2025 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2pk/eTN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0EB227E84
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 03:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775871; cv=none; b=cWrXuKPSLuEdgIi6k2L9CR5gyxy71+A3wPSrm+dTvyZJCLLRruQdbMFuSLisSFFQl46RZy7UTWASs0XBPIc1ZopFncF99cH4bOSfm6ZkG4uEhVbtymgeugp/H04yTV9hTdw9wkazDAWsOxDApnr2xKk/TUNXthhD9L8fgzak+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775871; c=relaxed/simple;
	bh=wVsJDF+t1fF9tQ/KppAuD2kTWqXofnERmP/4bMdLgzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmtrioVynJLfn9ANFCvBe6TjaXK9JG/vNAk33htGy78dV4/mwYKfNAE0DO8k+Gc43WvOMbghbVD0OhAE3I8rL/2eLWZ5PPRxO3iDh+JWT4z0RfadMWUzJtH2unk+UUth2phkcq+HVZgFGwpW7GOu/r/2WNnNpuUMolit8l/zMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2pk/eTN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744775869; x=1776311869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wVsJDF+t1fF9tQ/KppAuD2kTWqXofnERmP/4bMdLgzU=;
  b=Z2pk/eTNO9UBsU/WNHeaiusBSIzo4WaJwgb2o8adkQumrestWiIy0bg5
   fEpKSDDBNGWQpV3AQDF4hL2+M2W5Y0tcT+0F4lWUpWoJuHJSk9do2xpep
   focp5oyt1HTgUgwgF/vW4TxvLMupckbsvuBWOonSgSZjvMJS3gJ84Nhts
   CoTczHzLOnrzosT6CPtokkAJQl0e+QIxl6C+ddRgLfsteR/XEQqyMXFEE
   5Myz2VWWLDJA3HIA8Ln263ExneNtD6dLH+aWiX6Jon1Lpj1uFY5t4j1va
   96vrfA8+nnaQLKUS/nEM+Bvs95kVtBq6YoFRaaiLKuoWJ4h6R2eYXEgoi
   Q==;
X-CSE-ConnectionGUID: O37VHbysSRiF4sl3qVqOzg==
X-CSE-MsgGUID: MPbphMgfTjKekBdQ4Ms+zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56943469"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="56943469"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 20:57:48 -0700
X-CSE-ConnectionGUID: hX1DKEX3TgC9ZI0fnoL4Pg==
X-CSE-MsgGUID: uS9BzadUQZ6pYigDRnvfzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="153529451"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 20:57:45 -0700
Date: Wed, 16 Apr 2025 11:58:23 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Faust <david.faust@oracle.com>,
	Fangrui Song <maskray@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>, yi1.lai@intel.com
Subject: Re: [PATCH bpf-next v5 07/17] bpf: Support new 32bit offset jmp
 instruction
Message-ID: <Z/8q3xzpU59CIYQE@ly-workstation>
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
 <20230728011231.3716103-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728011231.3716103-1-yonghong.song@linux.dev>

Hi Yonghong Song,

Greetings!

I used Syzkaller and found that there is WARNING in __mark_chain_precision in linux-next tag - next-20250414.

After bisection and the first bad commit is:
"
4cd58e9af8b9 bpf: Support new 32bit offset jmp instruction
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250415_203801___mark_chain_precision/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250415_203801___mark_chain_precision/bzImage_8ffd015db85fea3e15a77027fda6c02ced4d2444
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250415_203801___mark_chain_precision/8ffd015db85fea3e15a77027fda6c02ced4d2444_dmesg.log

"
[   51.167546] ------------[ cut here ]------------
[   51.167803] verifier backtracking bug
[   51.167867] WARNING: CPU: 1 PID: 672 at kernel/bpf/verifier.c:4302 __mark_chain_precision+0x35d3/0x37b0
[   51.168496] Modules linked in:
[   51.168684] CPU: 1 UID: 0 PID: 672 Comm: repro Not tainted 6.15.0-rc2-8ffd015db85f #1 PREEMPT(voluntary)
[   51.169127] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
[   51.169980] RIP: 0010:__mark_chain_precision+0x35d3/0x37b0
[   51.170255] Code: 06 31 ff 89 de e8 cd 0b e0 ff 84 db 0f 85 a7 e5 ff ff e8 90 11 e0 ff 48 c7 c7 a0 cb f4 85 c6 05 f
[   51.171108] RSP: 0018:ffff8880115ff2d8 EFLAGS: 00010296
[   51.171424] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81470f72
[   51.171759] RDX: ffff88801f422540 RSI: ffffffff81470f7f RDI: 0000000000000001
[   51.172112] RBP: ffff8880115ff428 R08: 0000000000000001 R09: ffffed100d8a5941
[   51.172443] R10: 0000000000000000 R11: ffff88801f423398 R12: 0000000000000400
[   51.172769] R13: dffffc0000000000 R14: 0000000000000002 R15: ffff88801f720000
[   51.173152] FS:  00007f8a0a0b1600(0000) GS:ffff8880e3684000(0000) knlGS:0000000000000000
[   51.173563] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.173861] CR2: 0000000000402010 CR3: 000000001179a006 CR4: 0000000000770ef0
[   51.174244] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   51.174614] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   51.174995] PKRU: 55555554
[   51.175151] Call Trace:
[   51.175302]  <TASK>
[   51.175439]  ? __lock_acquire+0x381/0x2260
[   51.175675]  ? __pfx___sanitizer_cov_trace_const_cmp4+0x10/0x10
[   51.176006]  ? __pfx___mark_chain_precision+0x10/0x10
[   51.176326]  ? mark_reg_read+0x1e4/0x340
[   51.176558]  ? __check_reg_arg+0x1c8/0x440
[   51.176802]  ? kasan_quarantine_put+0xa2/0x200
[   51.177068]  check_cond_jmp_op+0x2692/0x65f0
[   51.177335]  ? krealloc_noprof+0xe5/0x330
[   51.177569]  ? krealloc_noprof+0x190/0x330
[   51.177790]  ? __pfx_check_cond_jmp_op+0x10/0x10
[   51.178060]  ? push_insn_history+0x1d0/0x6d0
[   51.178308]  do_check_common+0x9134/0xd570
[   51.178532]  ? ns_capable+0xec/0x130
[   51.178748]  ? bpf_base_func_proto+0x7e/0xbe0
[   51.179025]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   51.179319]  ? __pfx_do_check_common+0x10/0x10
[   51.179540]  ? __pfx_mark_fastcall_pattern_for_call+0x10/0x10
[   51.179864]  ? bpf_check+0x89b9/0xd880
[   51.180072]  ? kvfree+0x32/0x40
[   51.180237]  bpf_check+0x9c27/0xd880
[   51.180450]  ? rcu_is_watching+0x19/0xc0
[   51.180680]  ? __lock_acquire+0x380/0x2260
[   51.180900]  ? __pfx_bpf_check+0x10/0x10
[   51.181099]  ? __lock_acquire+0x410/0x2260
[   51.181355]  ? __this_cpu_preempt_check+0x21/0x30
[   51.181673]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   51.181989]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   51.182229]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[   51.182510]  ? bpf_obj_name_cpy+0x152/0x1b0
[   51.182765]  bpf_prog_load+0x14d7/0x2600
[   51.182970]  ? __pfx_bpf_prog_load+0x10/0x10
[   51.183193]  ? __might_fault+0x14a/0x1b0
[   51.183435]  ? __this_cpu_preempt_check+0x21/0x30
[   51.183670]  ? lock_release+0x14f/0x2c0
[   51.183876]  ? __might_fault+0xf1/0x1b0
[   51.184074]  __sys_bpf+0x18ac/0x5c10
[   51.184279]  ? __pfx___sys_bpf+0x10/0x10
[   51.184502]  ? __lock_acquire+0x410/0x2260
[   51.184725]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   51.184960]  ? ktime_get_coarse_real_ts64+0xb6/0x100
[   51.185253]  ? __audit_syscall_entry+0x39c/0x500
[   51.185507]  __x64_sys_bpf+0x7d/0xc0
[   51.185718]  ? syscall_trace_enter+0x14d/0x280
[   51.185945]  x64_sys_call+0x204a/0x2150
[   51.186182]  do_syscall_64+0x6d/0x150
[   51.186395]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   51.186654] RIP: 0033:0x7f8a09e3ee5d
[   51.186869] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 8
[   51.187767] RSP: 002b:00007fff00100bb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
[   51.188152] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8a09e3ee5d
[   51.188527] RDX: 0000000000000090 RSI: 00000000200009c0 RDI: 0000000000000005
[   51.188895] RBP: 00007fff00100bc0 R08: 0000000000000000 R09: 0000000000000001
[   51.189263] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff00100cd8
[   51.189657] R13: 0000000000401146 R14: 0000000000403e08 R15: 00007f8a0a0fa000
[   51.190071]  </TASK>
[   51.190197] irq event stamp: 3113
[   51.190380] hardirqs last  enabled at (3121): [<ffffffff8165d8c5>] __up_console_sem+0x95/0xb0
[   51.190797] hardirqs last disabled at (3128): [<ffffffff8165d8aa>] __up_console_sem+0x7a/0xb0
[   51.191214] softirqs last  enabled at (2600): [<ffffffff8149050e>] __irq_exit_rcu+0x10e/0x170
[   51.191656] softirqs last disabled at (2589): [<ffffffff8149050e>] __irq_exit_rcu+0x10e/0x170
[   51.192093] ---[ end trace 0000000000000000 ]---
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 

On Thu, Jul 27, 2023 at 06:12:31PM -0700, Yonghong Song wrote:
> Add interpreter/jit/verifier support for 32bit offset jmp instruction.
> If a conditional jmp instruction needs more than 16bit offset,
> it can be simulated with a conditional jmp + a 32bit jmp insn.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 28 ++++++++++++++++++----------
>  kernel/bpf/core.c           | 19 ++++++++++++++++---
>  kernel/bpf/verifier.c       | 32 ++++++++++++++++++++++----------
>  3 files changed, 56 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a89b62eb2b40..a5930042139d 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1815,16 +1815,24 @@ st:			if (is_imm8(insn->off))
>  			break;
>  
>  		case BPF_JMP | BPF_JA:
> -			if (insn->off == -1)
> -				/* -1 jmp instructions will always jump
> -				 * backwards two bytes. Explicitly handling
> -				 * this case avoids wasting too many passes
> -				 * when there are long sequences of replaced
> -				 * dead code.
> -				 */
> -				jmp_offset = -2;
> -			else
> -				jmp_offset = addrs[i + insn->off] - addrs[i];
> +		case BPF_JMP32 | BPF_JA:
> +			if (BPF_CLASS(insn->code) == BPF_JMP) {
> +				if (insn->off == -1)
> +					/* -1 jmp instructions will always jump
> +					 * backwards two bytes. Explicitly handling
> +					 * this case avoids wasting too many passes
> +					 * when there are long sequences of replaced
> +					 * dead code.
> +					 */
> +					jmp_offset = -2;
> +				else
> +					jmp_offset = addrs[i + insn->off] - addrs[i];
> +			} else {
> +				if (insn->imm == -1)
> +					jmp_offset = -2;
> +				else
> +					jmp_offset = addrs[i + insn->imm] - addrs[i];
> +			}
>  
>  			if (!jmp_offset) {
>  				/*
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 646d2fe537be..db0b631908c2 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -373,7 +373,12 @@ static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_old,
>  {
>  	const s32 off_min = S16_MIN, off_max = S16_MAX;
>  	s32 delta = end_new - end_old;
> -	s32 off = insn->off;
> +	s32 off;
> +
> +	if (insn->code == (BPF_JMP32 | BPF_JA))
> +		off = insn->imm;
> +	else
> +		off = insn->off;
>  
>  	if (curr < pos && curr + off + 1 >= end_old)
>  		off += delta;
> @@ -381,8 +386,12 @@ static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_old,
>  		off -= delta;
>  	if (off < off_min || off > off_max)
>  		return -ERANGE;
> -	if (!probe_pass)
> -		insn->off = off;
> +	if (!probe_pass) {
> +		if (insn->code == (BPF_JMP32 | BPF_JA))
> +			insn->imm = off;
> +		else
> +			insn->off = off;
> +	}
>  	return 0;
>  }
>  
> @@ -1593,6 +1602,7 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
>  	INSN_3(JMP, JSLE, K),			\
>  	INSN_3(JMP, JSET, K),			\
>  	INSN_2(JMP, JA),			\
> +	INSN_2(JMP32, JA),			\
>  	/* Store instructions. */		\
>  	/*   Register based. */			\
>  	INSN_3(STX, MEM,  B),			\
> @@ -1989,6 +1999,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>  	JMP_JA:
>  		insn += insn->off;
>  		CONT;
> +	JMP32_JA:
> +		insn += insn->imm;
> +		CONT;
>  	JMP_EXIT:
>  		return BPF_R0;
>  	/* JMP */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c0aceedfcb9c..0b1ada93582b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2855,7 +2855,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  			goto next;
>  		if (BPF_OP(code) == BPF_EXIT || BPF_OP(code) == BPF_CALL)
>  			goto next;
> -		off = i + insn[i].off + 1;
> +		if (code == (BPF_JMP32 | BPF_JA))
> +			off = i + insn[i].imm + 1;
> +		else
> +			off = i + insn[i].off + 1;
>  		if (off < subprog_start || off >= subprog_end) {
>  			verbose(env, "jump out of range from insn %d to %d\n", i, off);
>  			return -EINVAL;
> @@ -2867,6 +2870,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  			 * or unconditional jump back
>  			 */
>  			if (code != (BPF_JMP | BPF_EXIT) &&
> +			    code != (BPF_JMP32 | BPF_JA) &&
>  			    code != (BPF_JMP | BPF_JA)) {
>  				verbose(env, "last insn is not an exit or jmp\n");
>  				return -EINVAL;
> @@ -14792,7 +14796,7 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
>  static int visit_insn(int t, struct bpf_verifier_env *env)
>  {
>  	struct bpf_insn *insns = env->prog->insnsi, *insn = &insns[t];
> -	int ret;
> +	int ret, off;
>  
>  	if (bpf_pseudo_func(insn))
>  		return visit_func_call_insn(t, insns, env, true);
> @@ -14840,14 +14844,19 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
>  		if (BPF_SRC(insn->code) != BPF_K)
>  			return -EINVAL;
>  
> +		if (BPF_CLASS(insn->code) == BPF_JMP)
> +			off = insn->off;
> +		else
> +			off = insn->imm;
> +
>  		/* unconditional jump with single edge */
> -		ret = push_insn(t, t + insn->off + 1, FALLTHROUGH, env,
> +		ret = push_insn(t, t + off + 1, FALLTHROUGH, env,
>  				true);
>  		if (ret)
>  			return ret;
>  
> -		mark_prune_point(env, t + insn->off + 1);
> -		mark_jmp_point(env, t + insn->off + 1);
> +		mark_prune_point(env, t + off + 1);
> +		mark_jmp_point(env, t + off + 1);
>  
>  		return ret;
>  
> @@ -16643,15 +16652,18 @@ static int do_check(struct bpf_verifier_env *env)
>  				mark_reg_scratched(env, BPF_REG_0);
>  			} else if (opcode == BPF_JA) {
>  				if (BPF_SRC(insn->code) != BPF_K ||
> -				    insn->imm != 0 ||
>  				    insn->src_reg != BPF_REG_0 ||
>  				    insn->dst_reg != BPF_REG_0 ||
> -				    class == BPF_JMP32) {
> +				    (class == BPF_JMP && insn->imm != 0) ||
> +				    (class == BPF_JMP32 && insn->off != 0)) {
>  					verbose(env, "BPF_JA uses reserved fields\n");
>  					return -EINVAL;
>  				}
>  
> -				env->insn_idx += insn->off + 1;
> +				if (class == BPF_JMP)
> +					env->insn_idx += insn->off + 1;
> +				else
> +					env->insn_idx += insn->imm + 1;
>  				continue;
>  
>  			} else if (opcode == BPF_EXIT) {
> @@ -17498,13 +17510,13 @@ static bool insn_is_cond_jump(u8 code)
>  {
>  	u8 op;
>  
> +	op = BPF_OP(code);
>  	if (BPF_CLASS(code) == BPF_JMP32)
> -		return true;
> +		return op != BPF_JA;
>  
>  	if (BPF_CLASS(code) != BPF_JMP)
>  		return false;
>  
> -	op = BPF_OP(code);
>  	return op != BPF_JA && op != BPF_EXIT && op != BPF_CALL;
>  }
>  
> -- 
> 2.34.1
> 

