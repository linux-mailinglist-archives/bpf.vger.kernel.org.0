Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAED5F6892
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJFNvt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 09:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiJFNvd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 09:51:33 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7522531EE7
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 06:51:26 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ogRHY-0008Ic-Ib; Thu, 06 Oct 2022 15:51:24 +0200
Date:   Thu, 6 Oct 2022 15:51:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Subject: Re: [RFC v2 6/9] netfilter: add bpf base hook program generator
Message-ID: <20221006135124.GB3034@breakpoint.cc>
References: <20221005141309.31758-1-fw@strlen.de>
 <20221005141309.31758-7-fw@strlen.de>
 <20221006025209.rx4xnwdduqypja4b@macbook-pro-4.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006025209.rx4xnwdduqypja4b@macbook-pro-4.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > +#if IS_ENABLED(CONFIG_NF_HOOK_BPF)
> > +		const struct bpf_prog *p = READ_ONCE(hook_head->hook_prog);
> > +
> > +		nf_hook_state_init(&state, hook, pf, indev, outdev,
> > +				   sk, net, okfn);
> > +
> > +		state.priv = (void *)hook_head;
> > +		state.skb = skb;
> >  
> > +		migrate_disable();
> > +		ret = bpf_prog_run_nf(p, &state);
> > +		migrate_enable();
> 
> Since generated prog doesn't do any per-cpu work and not using any maps
> there is no need for migrate_disable.
> There is cant_migrate() in __bpf_prog_run(), but it's probably better
> to silence that instead of adding migrate_disable/enable overhead.

Ah, thanks -- noted.

> > +static bool emit_mov_ptr_reg(struct nf_hook_prog *p, u8 dreg, u8 sreg)
> > +{
> > +	if (sizeof(void *) == sizeof(u64))
> > +		return emit(p, BPF_MOV64_REG(dreg, sreg));
> > +	if (sizeof(void *) == sizeof(u32))
> > +		return emit(p, BPF_MOV32_REG(dreg, sreg));
> 
> I bet that was never tested :) because... see below.

Right, never tested, only on amd64 arch.

I suspect that real 32bit support won't reduce readability too much,
else I can either remove it or add it in a different patch.

> > +static void patch_hook_jumps(struct nf_hook_prog *p)
> > +{
> > +	unsigned int i;
> > +
> > +	if (!p->insns)
> > +		return;
> > +
> > +	for (i = 0; i < p->pos; i++) {
> > +		if (BPF_CLASS(p->insns[i].code) != BPF_JMP)
> > +			continue;
> > +
> > +		if (p->insns[i].code == (BPF_EXIT | BPF_JMP))
> > +			continue;
> > +		if (p->insns[i].code == (BPF_CALL | BPF_JMP))
> > +			continue;
> > +
> > +		if (p->insns[i].off != JMP_INVALID)
> > +			continue;
> > +		p->insns[i].off = p->pos - i - 1;
> 
> Pls add a check that it fits in 16-bits.

Makes sense.

> > +	if (!emit(p, BPF_EMIT_CALL(nf_queue)))
> > +		return false;
> 
> here and other CALL work by accident on x84-64.
> You need to wrap them with BPF_CALL_ and point BPF_EMIT_CALL to that wrapper.
> On x86-64 it will be a nop.
> On x86-32 it will do quite a bit of work.

I see. thanks.

> > +	prog->len = len;
> > +	prog->type = BPF_PROG_TYPE_SOCKET_FILTER;
> 
> lol. Just say BPF_PROG_TYPE_UNSPEC ?

Right, will do that.

> > +	memcpy(prog->insnsi, insns, prog->len * sizeof(struct bpf_insn));
> > +
> > +	prog = bpf_prog_select_runtime(prog, &err);
> > +	if (err) {
> > +		bpf_prog_free(prog);
> > +		return NULL;
> > +	}
> 
> Would be good to do bpf_prog_alloc_id() so it can be seen in
> bpftool prog show.

Agree.

> and bpf_prog_kallsyms_add() to make 'perf report' and
> stack traces readable.

Good to know, will check that this works.

> Overall I don't hate it, but don't like it either.
> Please provide performance numbers.

Oh, right, I should have included those in the cover letter.
Tests were done on 5.19-rc3 on a 56core intel machine using pktgen,
(based off pktgen_bench_xmit_mode_netif_receive.sh), i.e.
64byte udp packets that get forwarded to a dummy device.

Ruleset had single 'ct state new accept' rule in forward chain.

Baseline, with 56-rx queues: 682006 pps, 348 Mb/s
with this patchset:          696743 pps, 356 MB/s

Averaged over 10 runs each, also reboot after each run.
irqbalance was off, scaling_governor set to 'performance'.

I would redo those tests for future patch submission.
If there is a particular test i should do please let me know.

I also did a test via iperf3 forwarding
(netns -> veth1 -> netns -> veth -> netns), but 'improvement'
was in noise range, too much overhead for the indirection avoidance
to be noticeable.

> It's a lot of tricky code and not clear what the benefits are.
> Who will maintain this body of code long term?
> How are we going to deal with refactoring that will touch generic bpf bits
> and this generated prog?

Good questions.  The only 'good' answer is that it could always be
marked BROKEN and then reverted if needed as it doesn't add new
functionality per se.

Furthermore (I have NOT looked at this at all) this opens the door for
more complexity/trickery.  For example the bpf prog could check (during
code generation) if $indirect_hook is the ipv4 or ipv6 defrag hook and
then insert extra code that avoids the function call for the common
case.  There are probably more hack^W tricks that could be done.

So yes, maintainablity is a good question, plus what other users in the
tree might want something similar (selinux hook invocation for
example...).

I guess it depends on wheter the perf numbers are decent enough.
If they are, then I'd suggest to just do a live experiment and give
it a try -- if it turns out to be a big pain point
(maintenance, frequent crashes, hard-to-debug correctness bugs, e.g.
 'generator failed to re-jit and now it skips my iptables filter
 table',...) or whatever, mark it as BROKEN in Kconfig and, if
everything fails just rip it out again.

Does that sound ok?

> > Purpose of this is to eventually add a 'netfilter prog type' to bpf and
> > permit attachment of (userspace generated) bpf programs to the netfilter
> > machinery, e.g.  'attach bpf prog id 1234 to ipv6 PREROUTING at prio -300'.
> > 
> > This will require to expose the context structure (program argument,
> > '__nf_hook_state', with rewriting accesses to match nf_hook_state layout.
> 
> This part is orthogonal, right? I don't see how this work is connected
> to above idea.

Yes, orthogonal from technical pov.

> I'm still convinced that xt_bpf was a bad choice for many reasons.

Hmmm, ok -- there is nothing I can say, it looks reasonably
innocent/harmless to me wrt. backwards kludge risk etc.

> "Add a 'netfilter prog type' to bpf" would repeat the same mistakes.

Hmm, to me it would be more like the 'xtc/tcx' stuff rather than
cls/act_bpf/xt_bpf etc. pp.  but perhaps I'm missing something.

> Let's evaluate this set independently.

Ok, sure.
