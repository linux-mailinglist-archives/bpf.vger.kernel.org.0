Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E7F3C6CB2
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhGMI4o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 04:56:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:23190 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234599AbhGMI4n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 04:56:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="190506037"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="190506037"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 01:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="649320931"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2021 01:53:51 -0700
Date:   Tue, 13 Jul 2021 10:39:41 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix tail_call_reachable rejection for
 interpreter when jit failed
Message-ID: <20210713083941.GB60476@ranger.igk.intel.com>
References: <618c34e3163ad1a36b1e82377576a6081e182f25.1626123173.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618c34e3163ad1a36b1e82377576a6081e182f25.1626123173.git.daniel@iogearbox.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 12, 2021 at 10:57:35PM +0200, Daniel Borkmann wrote:
> During testing of f263a81451c1 ("bpf: Track subprog poke descriptors correctly
> and fix use-after-free") under various failure conditions, for example, when
> jit_subprogs() fails and tries to clean up the program to be run under the
> interpreter, we ran into the following freeze:
> 
>   [...]
>   #127/8 tailcall_bpf2bpf_3:FAIL
>   [...]
>   [   92.041251] BUG: KASAN: slab-out-of-bounds in ___bpf_prog_run+0x1b9d/0x2e20
>   [   92.042408] Read of size 8 at addr ffff88800da67f68 by task test_progs/682
>   [   92.043707]
>   [   92.044030] CPU: 1 PID: 682 Comm: test_progs Tainted: G   O   5.13.0-53301-ge6c08cb33a30-dirty #87
>   [   92.045542] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
>   [   92.046785] Call Trace:
>   [   92.047171]  ? __bpf_prog_run_args64+0xc0/0xc0
>   [   92.047773]  ? __bpf_prog_run_args32+0x8b/0xb0
>   [   92.048389]  ? __bpf_prog_run_args64+0xc0/0xc0
>   [   92.049019]  ? ktime_get+0x117/0x130
>   [...] // few hundred [similar] lines more
>   [   92.659025]  ? ktime_get+0x117/0x130
>   [   92.659845]  ? __bpf_prog_run_args64+0xc0/0xc0
>   [   92.660738]  ? __bpf_prog_run_args32+0x8b/0xb0
>   [   92.661528]  ? __bpf_prog_run_args64+0xc0/0xc0
>   [   92.662378]  ? print_usage_bug+0x50/0x50
>   [   92.663221]  ? print_usage_bug+0x50/0x50
>   [   92.664077]  ? bpf_ksym_find+0x9c/0xe0
>   [   92.664887]  ? ktime_get+0x117/0x130
>   [   92.665624]  ? kernel_text_address+0xf5/0x100
>   [   92.666529]  ? __kernel_text_address+0xe/0x30
>   [   92.667725]  ? unwind_get_return_address+0x2f/0x50
>   [   92.668854]  ? ___bpf_prog_run+0x15d4/0x2e20
>   [   92.670185]  ? ktime_get+0x117/0x130
>   [   92.671130]  ? __bpf_prog_run_args64+0xc0/0xc0
>   [   92.672020]  ? __bpf_prog_run_args32+0x8b/0xb0
>   [   92.672860]  ? __bpf_prog_run_args64+0xc0/0xc0
>   [   92.675159]  ? ktime_get+0x117/0x130
>   [   92.677074]  ? lock_is_held_type+0xd5/0x130
>   [   92.678662]  ? ___bpf_prog_run+0x15d4/0x2e20
>   [   92.680046]  ? ktime_get+0x117/0x130
>   [   92.681285]  ? __bpf_prog_run32+0x6b/0x90
>   [   92.682601]  ? __bpf_prog_run64+0x90/0x90
>   [   92.683636]  ? lock_downgrade+0x370/0x370
>   [   92.684647]  ? mark_held_locks+0x44/0x90
>   [   92.685652]  ? ktime_get+0x117/0x130
>   [   92.686752]  ? lockdep_hardirqs_on+0x79/0x100
>   [   92.688004]  ? ktime_get+0x117/0x130
>   [   92.688573]  ? __cant_migrate+0x2b/0x80
>   [   92.689192]  ? bpf_test_run+0x2f4/0x510
>   [   92.689869]  ? bpf_test_timer_continue+0x1c0/0x1c0
>   [   92.690856]  ? rcu_read_lock_bh_held+0x90/0x90
>   [   92.691506]  ? __kasan_slab_alloc+0x61/0x80
>   [   92.692128]  ? eth_type_trans+0x128/0x240
>   [   92.692737]  ? __build_skb+0x46/0x50
>   [   92.693252]  ? bpf_prog_test_run_skb+0x65e/0xc50
>   [   92.693954]  ? bpf_prog_test_run_raw_tp+0x2d0/0x2d0
>   [   92.694639]  ? __fget_light+0xa1/0x100
>   [   92.695162]  ? bpf_prog_inc+0x23/0x30
>   [   92.695685]  ? __sys_bpf+0xb40/0x2c80
>   [   92.696324]  ? bpf_link_get_from_fd+0x90/0x90
>   [   92.697150]  ? mark_held_locks+0x24/0x90
>   [   92.698007]  ? lockdep_hardirqs_on_prepare+0x124/0x220
>   [   92.699045]  ? finish_task_switch+0xe6/0x370
>   [   92.700072]  ? lockdep_hardirqs_on+0x79/0x100
>   [   92.701233]  ? finish_task_switch+0x11d/0x370
>   [   92.702264]  ? __switch_to+0x2c0/0x740
>   [   92.703148]  ? mark_held_locks+0x24/0x90
>   [   92.704155]  ? __x64_sys_bpf+0x45/0x50
>   [   92.705146]  ? do_syscall_64+0x35/0x80
>   [   92.706953]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>   [...]
> 
> Turns out that the program rejection from e411901c0b77 ("bpf: allow for tailcalls
> in BPF subprograms for x64 JIT") is buggy since env->prog->aux->tail_call_reachable
> is never true. Commit ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT") added a tracker into check_max_stack_depth() which propagates
> the tail_call_reachable condition throughout the subprograms. This info is then
> assigned to the subprogram's func[i]->aux->tail_call_reachable. However, in the
> case of the rejection check upon JIT failure, env->prog->aux->tail_call_reachable
> is used. func[0]->aux->tail_call_reachable which represents the main program's
> information did not propagate this to the outer env->prog->aux, though. Add this
> propagation into check_max_stack_depth() where it needs to belong so that the
> check can be done reliably.
> 
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 42a4063de7cd..9de3c9c3267c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3677,6 +3677,8 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>  	if (tail_call_reachable)
>  		for (j = 0; j < frame; j++)
>  			subprog[ret_prog[j]].tail_call_reachable = true;
> +	if (subprog[0].tail_call_reachable)

This could be just:
	if (tail_call_reachable)

But what you propose is fine to me as well. Not sure how we missed it.
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

With that I expect that we bail out in fixup_call_args() right?

Oh and John's f263a81451c1 ("bpf: Track subprog poke descriptors correctly
and fix use-after-free") landed in my junk folder, heh, that's why I
stayed silent and didn't participate in further review. Need to talk to
IT.

> +		env->prog->aux->tail_call_reachable = true;
>  
>  	/* end of for() loop means the last insn of the 'subprog'
>  	 * was reached. Doesn't matter whether it was JA or EXIT
> -- 
> 2.21.0
> 
