Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB7681821
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbjA3SBW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 13:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbjA3SBV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 13:01:21 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC051EFF3;
        Mon, 30 Jan 2023 10:01:17 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pMYSx-0004qr-TH; Mon, 30 Jan 2023 19:01:15 +0100
Date:   Mon, 30 Jan 2023 19:01:15 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [RFC] bpf: add bpf_link support for BPF_NETFILTER programs
Message-ID: <20230130180115.GB12902@breakpoint.cc>
References: <20230130150432.24924-1-fw@strlen.de>
 <87zg9zx6ro.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg9zx6ro.fsf@toke.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> > Is BPF_LINK the right place?  Hook gets removed automatically if the calling program
> > exits, afaict this is intended.
> 
> Yes, this is indeed intended for bpf_link. This plays well with
> applications that use the API and stick around (because things get
> cleaned up after them automatically even if they crash, say), but it
> doesn't work so well for programs that don't (which, notably, includes
> command line utilities like 'nft').

Right, but I did not want to create a dependency on nfnetlink or
nftables netlink right from the start.

> For XDP and TC users can choose between bpf_link and netlink for
> attachment and get one of the two semantics (goes away on close or stays
> put). Not sure if it would make sense to do the same for nftables?

For nftables I suspect that, if nft can emit bpf, it would make sense to
pass the bpf descriptor together with nftables netlink, i.e. along with
the normal netlink data.

nftables kernel side would then know to use the bpf prog for the
datapath instead of the interpreter and could even fallback to
interpreter.

But for the raw hook use case that Alexei and Daniel preferred (cf.
initial proposal to call bpf progs from nf_tables interpreter) I think
that there should be no nftables dependency.

I could add a new nfnetlink subtype for nf-bpf if bpf_link is not
appropriate as an alternative.

> > Should a program running in init_netns be allowed to attach hooks in other netns too?
> >
> > I could do what BPF_LINK_TYPE_NETNS is doing and fetch net via
> > get_net_ns_by_fd(attr->link_create.target_fd);
> 
> We don't allow that for any other type of BPF program; the expectation
> is that the entity doing the attachment will move to the right ns first.
> Is there any particular use case for doing something different for
> nftables?

Nope, not at all.  I was just curious.  So no special handling for
init_netns needed, good.

> > For the actual BPF_NETFILTER program type I plan to follow what the bpf
> > flow dissector is doing, i.e. pretend prototype is
> >
> > func(struct __sk_buff *skb)
> >
> > but pass a custom program specific context struct on kernel side.
> > Verifier will rewrite accesses as needed.
> 
> This sounds reasonable, and also promotes code reuse between program
> types (say, you can write some BPF code to parse a packet and reuse it
> between the flow dissector, TC and netfilter).

Ok, thanks.

> > Things like nf_hook_state->in (net_device) could then be exposed via
> > kfuncs.
> 
> Right, so like:
> 
> state = bpf_nf_get_hook_state(ctx); ?
> 
> Sounds OK to me.

Yes, something like that.  Downside is that the nf_hook_state struct
is no longer bound by any abi contract, but as I understood it thats
fine.

> > nf_hook_run_bpf() (c-function that creates the program context and
> > calls the real bpf prog) would be "updated" to use the bpf dispatcher to
> > avoid the indirect call overhead.
> 
> What 'bpf dispatcher' are you referring to here? We have way too many
> things with that name :P

I meant 'DEFINE_BPF_DISPATCHER(nf_user_progs);'

Thanks.
