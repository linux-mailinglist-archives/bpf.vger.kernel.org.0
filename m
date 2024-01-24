Return-Path: <bpf+bounces-20227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1385083AA3E
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 13:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74862909AC
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8F177639;
	Wed, 24 Jan 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b="LLUFyQ4K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-6.sys.kth.se (smtp-6.sys.kth.se [130.237.48.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13917543
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.237.48.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100448; cv=none; b=PINDHPEcjv1XHCt/KJS4AYOllbEnwXou5ziMdSX3flXwwBjQ/Br9sR1WqyPez1aRUVi8MxOWFLaAbLXFZemczZnBZlx2TMur5/yHEYLi32uP+g3kDM/84mrAMmqDddeIBIuU0ws4LIEsBuboslbtkKR9TcCUidTbfJ/SFKY1DeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100448; c=relaxed/simple;
	bh=PbpcHbuDBr5wl5Nj8M1BBIHLfZIEZWVGCcQif9hxls8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjXIJyt9OQT6EEWRamkc34F6tjJVpuuv7kRlNXhLuIwkgH1Q3W0rDNIzfkoPRmMAvVoIXq0appXQsyuCBkaTp0gVET6KRMZbbHd3E7sdJtChkT1idgSHtfYe3jSX0zcadosIbS/zovCEYl12frUc1pvoHil/rSAJuBqq1r717eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kth.se; spf=pass smtp.mailfrom=kth.se; dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b=LLUFyQ4K; arc=none smtp.client-ip=130.237.48.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kth.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kth.se
Received: from mbs00 (mbs00.scilifelab.se [130.237.250.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sfle)
	by smtp-6.sys.kth.se (Postfix) with ESMTPSA id 4TKk5r2gNwzNfQP;
	Wed, 24 Jan 2024 13:38:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-6.sys.kth.se 4TKk5r2gNwzNfQP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kth.se; s=default;
	t=1706099921; bh=493Yhh2u759WSzP+H8B1pHjMGKz/LSb+eQbUkRWNp4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LLUFyQ4K7NxUtZMQGisC0jliJVnSWaiB4q6VBxjLsZvcnvNGR0Q18+fD8iBJ9ncJI
	 iyM5Iznwt37Om0vWhJbkGLTCxozuSvEZ37FMN9nPUofGRYWh8iePfFRcZwG7oOwzeT
	 5zJuGx/MrZ3ruLG5iBpG7oxRcGuWAPVZEpO/mwko=
Date: Wed, 24 Jan 2024 13:38:36 +0100
From: Stefan Fleischmann <sfle@kth.se>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/6] bpf: stop setting precise in current
 state
Message-ID: <20240124133836.02f48f1a@mbs00>
In-Reply-To: <20240124110650.2e94eec5@vinyamar>
References: <20221104163649.121784-1-andrii@kernel.org>
	<20221104163649.121784-5-andrii@kernel.org>
	<20240124110650.2e94eec5@vinyamar>
Organization: KTH
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: *

On Wed, 24 Jan 2024 11:06:50 +0100 Stefan Fleischmann <sfle@kth.se>
wrote:
> On Fri, 4 Nov 2022 09:36:47 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> > Setting reg->precise to true in current state is not necessary from
> > correctness standpoint, but it does pessimise the whole precision
> > (or rather "imprecision", because that's what we want to keep as
> > much as possible) tracking. Why is somewhat subtle and my best
> > attempt to explain this is recorded in an extensive comment for
> > __mark_chain_precise() function. Some more careful thinking and code
> > reading is probably required still to grok this completely,
> > unfortunately. Whiteboarding and a bunch of extra handwaiving in
> > person would be even more helpful, but is deemed impractical in Git
> > commit.  
> 
> Not sure if this is the preferred way to bring this up, if not please
> direct me elsewhere. I've noticed problems with this patch in the 5.15
> kernel line, originally the Ubuntu kernel. Bug report with more
> information can be found here:
>  https://bugs.launchpad.net/ubuntu/+source/linux-signed/+bug/2050098
> 
> > Next patch pushes this imprecision property even further, building
> > on top of the insights described in this patch.  
> 
> I tracked this down to the changes in upstream version from 5.15.126
> to 127, and have confirmed that reverting this patch and the next
> mentioned here solves our problem.
> 
> > End results are pretty nice, we get reduction in number of total
> > instructions and states verified due to a better states reuse, as
> > some of the states are now more generic and permissive due to less
> > unnecessary precise=true requirements.  
> 
> I'll describe the problem here briefly in case you don't have time to
> read through the Ubuntu bug report. We use Slurm on a cluster and use
> cgroup2 for resource confinement. Now with this change in 5.15 we get
> this error from the slurm daemon on the node:
> 
>  slurmstepd: error: load_ebpf_prog: BPF load error (No space left on
>  device). Please check your system limits (MEMLOCK).
>  (debug log available here:
>  https://launchpadlibrarian.net/710598602/slurmd_cgroup_log.txt)
> 
> And more importantly the cgroup confinement is not working anymore.
> As I said reverting this patch brings back functionality. Now it would
> be easy to blame Slurm here, but I've tested newer kernels, 6.5,
> 6.6.13, 6.7.1 which all work fine. Which makes me believe some crucial
> parts might not have been backported to 5.15.

Sorry for the noise, turns out this is a bug in Slurm that is only
triggered by long bpf logs. So I suppose the newer kernels produce less
logs, hence the issue is not triggered there.

Best regards,
Stefan


> Best regards,
> Stefan
> 
> > SELFTESTS RESULTS
> > =================
> > 
> > $ ./veristat -C -e file,prog,insns,states
> > ~/subprog-precise-results.csv ~/imprecise-early-results.csv | grep
> > -v '+0' File                                     Program
> > Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states
> > (A)  Total states (B)  Total states (DIFF)
> > ---------------------------------------  ----------------------
> > ---------------  ---------------  ------------------
> > ----------------  ----------------  -------------------
> > bpf_iter_ksym.bpf.linked1.o              dump_ksym
> >        347              285       -62 (-17.87%)                20
> >            19          -1 (-5.00%) pyperf600_bpf_loop.bpf.linked1.o
> >       on_event                           3678             3736
> > +58 (+1.58%)               276               285          +9
> > (+3.26%) setget_sockopt.bpf.linked1.o             skops_sockopt
> >       4038             3947        -91 (-2.25%)               347
> >           343          -4 (-1.15%) test_l4lb.bpf.linked1.o
> >       balancer_ingress                   4559             2611
> > -1948 (-42.73%)               118               105        -13
> > (-11.02%) test_l4lb_noinline.bpf.linked1.o         balancer_ingress
> >                 6279             6268        -11 (-0.18%)
> >   237               236          -1 (-0.42%)
> > test_misc_tcp_hdr_options.bpf.linked1.o  misc_estab
> >       1307             1303         -4 (-0.31%)               100
> >            99          -1 (-1.00%) test_sk_lookup.bpf.linked1.o
> >       ctx_narrow_access                   456              447
> >  -9 (-1.97%)                39                38          -1
> > (-2.56%) test_sysctl_loop1.bpf.linked1.o          sysctl_tcp_mem
> >       1389             1384         -5 (-0.36%)                26
> >            25          -1 (-3.85%) test_tc_dtime.bpf.linked1.o
> >       egress_fwdns_prio101                518              485
> > -33 (-6.37%)                51                46          -5
> > (-9.80%) test_tc_dtime.bpf.linked1.o              egress_host
> >        519              468        -51 (-9.83%)                50
> >            44         -6 (-12.00%) test_tc_dtime.bpf.linked1.o
> >       ingress_fwdns_prio101               842             1000
> > +158 (+18.76%)                73                88        +15
> > (+20.55%) xdp_synproxy_kern.bpf.linked1.o          syncookie_tc
> >               405757           373173     -32584 (-8.03%)
> > 25735             22882      -2853 (-11.09%)
> > xdp_synproxy_kern.bpf.linked1.o          syncookie_xdp
> >     479055           371590   -107465 (-22.43%)             29145
> >         22207      -6938 (-23.81%)
> > ---------------------------------------  ----------------------
> > ---------------  ---------------  ------------------
> > ----------------  ----------------  -------------------
> > 
> > Slight regression in
> > test_tc_dtime.bpf.linked1.o/ingress_fwdns_prio101 is left for a
> > follow up, there might be some more precision-related bugs in
> > existing BPF verifier logic.
> > 
> > CILIUM RESULTS
> > ==============
> > 
> > $ ./veristat -C -e file,prog,insns,states
> > ~/subprog-precise-results-cilium.csv
> > ~/imprecise-early-results-cilium.csv | grep -v '+0' File
> > Program                         Total insns (A)  Total insns (B)
> > Total insns (DIFF)  Total states (A)  Total states (B)  Total states
> > (DIFF) -------------  ------------------------------
> > --------------- ---------------  ------------------
> > ---------------- ----------------  ------------------- bpf_host.o
> >   cil_from_host 762              556      -206 (-27.03%)
> >              43                37         -6 (-13.95%) bpf_host.o
> > tail_handle_nat_fwd_ipv4                  23541            23426
> >  -115 (-0.49%)              1538              1537          -1
> > (-0.07%) bpf_host.o     tail_nodeport_nat_egress_ipv4
> > 33592            33566        -26 (-0.08%)              2163
> >     2161          -2 (-0.09%) bpf_lxc.o
> > tail_handle_nat_fwd_ipv4 23541            23426       -115 (-0.49%)
> >    1538              1537          -1 (-0.07%) bpf_overlay.o
> > tail_nodeport_nat_egress_ipv4             33581            33543
> >   -38 (-0.11%)              2160              2157          -3
> > (-0.14%) bpf_xdp.o      tail_handle_nat_fwd_ipv4
> > 21659            20920       -739 (-3.41%)              1440
> >     1376         -64 (-4.44%) bpf_xdp.o
> > tail_handle_nat_fwd_ipv6 17084            17039        -45 (-0.26%)
> >     907               905          -2 (-0.22%) bpf_xdp.o
> > tail_lb_ipv4                              73442            73430
> >   -12 (-0.02%)              4370              4369          -1
> > (-0.02%) bpf_xdp.o      tail_lb_ipv6
> > 152114           151895       -219 (-0.14%)              6493
> >      6479         -14 (-0.22%) bpf_xdp.o
> > tail_nodeport_nat_egress_ipv4             17377            17200
> >  -177 (-1.02%)              1125              1111         -14
> > (-1.24%) bpf_xdp.o      tail_nodeport_nat_ingress_ipv6
> > 6405             6397         -8 (-0.12%)               309
> >     308          -1 (-0.32%) bpf_xdp.o      tail_rev_nodeport_lb4
> >                  7126             6934       -192 (-2.69%)
> >    414               402         -12 (-2.90%) bpf_xdp.o
> > tail_rev_nodeport_lb6                     18059            17905
> >  -154 (-0.85%)              1105              1096          -9
> > (-0.81%) -------------  ------------------------------
> > ---------------  ---------------  ------------------
> > ----------------  ----------------  -------------------
> > 
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 103
> > +++++++++++++++++++++++++++++++++++++----- 1 file changed, 91
> > insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c1169ee1bc7c..ff3fc21ce99b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2749,8 +2749,11 @@ static void mark_all_scalars_precise(struct
> > bpf_verifier_env *env, 
> >  	/* big hammer: mark all scalars precise in this path.
> >  	 * pop_stack may still get !precise scalars.
> > +	 * We also skip current state and go straight to first
> > parent state,
> > +	 * because precision markings in current non-checkpointed
> > state are
> > +	 * not needed. See why in the comment in
> > __mark_chain_precision below. */
> > -	for (; st; st = st->parent)
> > +	for (st = st->parent; st; st = st->parent) {
> >  		for (i = 0; i <= st->curframe; i++) {
> >  			func = st->frame[i];
> >  			for (j = 0; j < BPF_REG_FP; j++) {
> > @@ -2768,8 +2771,88 @@ static void mark_all_scalars_precise(struct
> > bpf_verifier_env *env, reg->precise = true;
> >  			}
> >  		}
> > +	}
> >  }
> >  
> > +/*
> > + * __mark_chain_precision() backtracks BPF program instruction
> > sequence and
> > + * chain of verifier states making sure that register *regno* (if
> > regno >= 0)
> > + * and/or stack slot *spi* (if spi >= 0) are marked as precisely
> > tracked
> > + * SCALARS, as well as any other registers and slots that
> > contribute to
> > + * a tracked state of given registers/stack slots, depending on
> > specific BPF
> > + * assembly instructions (see backtrack_insns() for exact
> > instruction handling
> > + * logic). This backtracking relies on recorded jmp_history and is
> > able to
> > + * traverse entire chain of parent states. This process ends only
> > when all the
> > + * necessary registers/slots and their transitive dependencies are
> > marked as
> > + * precise.
> > + *
> > + * One important and subtle aspect is that precise marks *do not
> > matter* in
> > + * the currently verified state (current state). It is important to
> > understand
> > + * why this is the case.
> > + *
> > + * First, note that current state is the state that is not yet
> > "checkpointed",
> > + * i.e., it is not yet put into env->explored_states, and it has no
> > children
> > + * states as well. It's ephemeral, and can end up either a) being
> > discarded if
> > + * compatible explored state is found at some point or BPF_EXIT
> > instruction is
> > + * reached or b) checkpointed and put into env->explored_states,
> > branching out
> > + * into one or more children states.
> > + *
> > + * In the former case, precise markings in current state are
> > completely
> > + * ignored by state comparison code (see regsafe() for details).
> > Only
> > + * checkpointed ("old") state precise markings are important, and
> > if old
> > + * state's register/slot is precise, regsafe() assumes current
> > state's
> > + * register/slot as precise and checks value ranges exactly and
> > precisely. If
> > + * states turn out to be compatible, current state's necessary
> > precise
> > + * markings and any required parent states' precise markings are
> > enforced
> > + * after the fact with propagate_precision() logic, after the fact.
> > But it's
> > + * important to realize that in this case, even after marking
> > current state
> > + * registers/slots as precise, we immediately discard current
> > state. So what
> > + * actually matters is any of the precise markings propagated into
> > current
> > + * state's parent states, which are always checkpointed (due to b)
> > case above).
> > + * As such, for scenario a) it doesn't matter if current state has
> > precise
> > + * markings set or not.
> > + *
> > + * Now, for the scenario b), checkpointing and forking into
> > child(ren)
> > + * state(s). Note that before current state gets to checkpointing
> > step, any
> > + * processed instruction always assumes precise SCALAR
> > register/slot
> > + * knowledge: if precise value or range is useful to prune jump
> > branch, BPF
> > + * verifier takes this opportunity enthusiastically. Similarly,
> > when
> > + * register's value is used to calculate offset or memory address,
> > exact
> > + * knowledge of SCALAR range is assumed, checked, and enforced. So,
> > similar to
> > + * what we mentioned above about state comparison ignoring precise
> > markings
> > + * during state comparison, BPF verifier ignores and also assumes
> > precise
> > + * markings *at will* during instruction verification process. But
> > as verifier
> > + * assumes precision, it also propagates any precision dependencies
> > across
> > + * parent states, which are not yet finalized, so can be further
> > restricted
> > + * based on new knowledge gained from restrictions enforced by
> > their children
> > + * states. This is so that once those parent states are finalized,
> > i.e., when
> > + * they have no more active children state, state comparison logic
> > in
> > + * is_state_visited() would enforce strict and precise SCALAR
> > ranges, if
> > + * required for correctness.
> > + *
> > + * To build a bit more intuition, note also that once a state is
> > checkpointed,
> > + * the path we took to get to that state is not important. This is
> > crucial
> > + * property for state pruning. When state is checkpointed and
> > finalized at
> > + * some instruction index, it can be correctly and safely used to
> > "short
> > + * circuit" any *compatible* state that reaches exactly the same
> > instruction
> > + * index. I.e., if we jumped to that instruction from a completely
> > different
> > + * code path than original finalized state was derived from, it
> > doesn't
> > + * matter, current state can be discarded because from that
> > instruction
> > + * forward having a compatible state will ensure we will safely
> > reach the
> > + * exit. States describe preconditions for further exploration, but
> > completely
> > + * forget the history of how we got here.
> > + *
> > + * This also means that even if we needed precise SCALAR range to
> > get to
> > + * finalized state, but from that point forward *that same* SCALAR
> > register is
> > + * never used in a precise context (i.e., it's precise value is not
> > needed for
> > + * correctness), it's correct and safe to mark such register as
> > "imprecise"
> > + * (i.e., precise marking set to false). This is what we rely on
> > when we do
> > + * not set precise marking in current state. If no child state
> > requires
> > + * precision for any given SCALAR register, it's safe to dictate
> > that it can
> > + * be imprecise. If any child state does require this register to
> > be precise,
> > + * we'll mark it precise later retroactively during precise
> > markings
> > + * propagation from child state to parent states.
> > + */
> >  static int __mark_chain_precision(struct bpf_verifier_env *env, int
> > frame, int regno, int spi)
> >  {
> > @@ -2787,6 +2870,10 @@ static int __mark_chain_precision(struct
> > bpf_verifier_env *env, int frame, int r if (!env->bpf_capable)
> >  		return 0;
> >  
> > +	/* Do sanity checks against current state of register
> > and/or stack
> > +	 * slot, but don't set precise flag in current state, as
> > precision
> > +	 * tracking in the current state is unnecessary.
> > +	 */
> >  	func = st->frame[frame];
> >  	if (regno >= 0) {
> >  		reg = &func->regs[regno];
> > @@ -2794,11 +2881,7 @@ static int __mark_chain_precision(struct
> > bpf_verifier_env *env, int frame, int r WARN_ONCE(1, "backtracing
> > misuse"); return -EFAULT;
> >  		}
> > -		if (!reg->precise)
> > -			new_marks = true;
> > -		else
> > -			reg_mask = 0;
> > -		reg->precise = true;
> > +		new_marks = true;
> >  	}
> >  
> >  	while (spi >= 0) {
> > @@ -2811,11 +2894,7 @@ static int __mark_chain_precision(struct
> > bpf_verifier_env *env, int frame, int r stack_mask = 0;
> >  			break;
> >  		}
> > -		if (!reg->precise)
> > -			new_marks = true;
> > -		else
> > -			stack_mask = 0;
> > -		reg->precise = true;
> > +		new_marks = true;
> >  		break;
> >  	}
> >  
> > @@ -11534,7 +11613,7 @@ static bool regsafe(struct bpf_verifier_env
> > *env, struct bpf_reg_state *rold, if (env->explore_alu_limits)
> >  			return false;
> >  		if (rcur->type == SCALAR_VALUE) {
> > -			if (!rold->precise && !rcur->precise)
> > +			if (!rold->precise)
> >  				return true;
> >  			/* new val must satisfy old val knowledge
> > */ return range_within(rold, rcur) &&  
> 

