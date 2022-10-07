Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B509D5F779A
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJGLps (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 07:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJGLpr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 07:45:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2669C236
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 04:45:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oglnT-0005nk-R5; Fri, 07 Oct 2022 13:45:43 +0200
Date:   Fri, 7 Oct 2022 13:45:43 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Subject: Re: [RFC v2 6/9] netfilter: add bpf base hook program generator
Message-ID: <20221007114543.GA4296@breakpoint.cc>
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
> > +	if (!emit(p, BPF_STX_MEM(BPF_H, BPF_REG_6, BPF_REG_8,
> > +				 offsetof(struct nf_hook_state, hook_index))))
> > +		return false;
> > +	/* arg2: struct nf_hook_state * */
> > +	if (!emit(p, BPF_MOV64_REG(BPF_REG_2, BPF_REG_6)))
> > +		return false;
> > +	/* arg3: original hook return value: (NUM << NF_VERDICT_QBITS | NF_QUEUE) */
> > +	if (!emit(p, BPF_MOV32_REG(BPF_REG_3, BPF_REG_0)))
> > +		return false;
> > +	if (!emit(p, BPF_EMIT_CALL(nf_queue)))
> > +		return false;
> 
> here and other CALL work by accident on x84-64.
> You need to wrap them with BPF_CALL_ and point BPF_EMIT_CALL to that wrapper.

Do you mean this? :

BPF_CALL_3(nf_queue_bpf, struct sk_buff *, skb, struct nf_hook_state *,
           state, unsigned int, verdict)
{
     return nf_queue(skb, state, verdict);
}

-       if (!emit(p, BPF_EMIT_CALL(nf_hook_slow)))
+       if (!emit(p, BPF_EMIT_CALL(nf_hook_slow_bpf)))

?

If yes, I don't see how this will work for the case where I only have an
address, i.e.:

if (!emit(p, BPF_EMIT_CALL(h->hook))) ....

(Also, the address might be in a kernel module)

> On x86-64 it will be a nop.
> On x86-32 it will do quite a bit of work.

If this only a problem for 32bit arches, I could also make this
'depends on CONFIG_64BIT'.

But perhaps I am on the wrong track, I see existing code doing:
        *insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);

(kernel/bpf/hashtab.c).

> > +	prog = bpf_prog_select_runtime(prog, &err);
> > +	if (err) {
> > +		bpf_prog_free(prog);
> > +		return NULL;
> > +	}
> 
> Would be good to do bpf_prog_alloc_id() so it can be seen in
> bpftool prog show.

Thanks a lot for the hint:

39: unspec  tag 0000000000000000
xlated 416B  jited 221B  memlock 4096B

bpftool prog  dump xlated id 39
   0: (bf) r6 = r1
   1: (79) r7 = *(u64 *)(r1 +8)
   2: (b4) w8 = 0
   3: (85) call ipv6_defrag#526144928
   4: (55) if r0 != 0x1 goto pc+24
   5: (bf) r1 = r6
   6: (04) w8 += 1
   7: (85) call ipv6_conntrack_in#526206096
   [..]
