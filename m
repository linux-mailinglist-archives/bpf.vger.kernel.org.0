Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD56817D8
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 18:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjA3Rj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 12:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjA3Rj0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 12:39:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2756559F;
        Mon, 30 Jan 2023 09:38:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FD36611D5;
        Mon, 30 Jan 2023 17:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0834C433EF;
        Mon, 30 Jan 2023 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675100287;
        bh=17+FeIvbkAM3fJGeEcNMlt9H04ynimiJKF2gLfk/wlM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VvSUgdgwvmVuEH3dqC7eSDLALusmZWaq75CkoqnbxWEGxw74Mmr81HJE4HyxCTjXf
         foXDk7EUbOoxuo2TTlk2SRt9nNPJAdt+o4EZBLNnShQrfQ1/fJZRSx8HqC6eGwrJY9
         U3y6P3m/L7gWkNVggMwT/5paPKJdrETFJhwfzC8Pibb3VrBjCsuacJCbSxKamNCY2+
         3/jyJjEuBbB9GOdCxlZtJcIedzjtV7FiMagnbiJsxuSMEIOVQ8f4Mw4pWVO2olweh8
         18DqhFRFXr8nvXPtO3De4yCiSHGhF9EghqEzqkyTqT9lzI3BS4cvAJjn++uB8iMEBN
         T79bjbA9bhw+A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B2F329726F8; Mon, 30 Jan 2023 18:38:03 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [RFC] bpf: add bpf_link support for BPF_NETFILTER programs
In-Reply-To: <20230130150432.24924-1-fw@strlen.de>
References: <20230130150432.24924-1-fw@strlen.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 30 Jan 2023 18:38:03 +0100
Message-ID: <87zg9zx6ro.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Doesn't apply, doesn't work -- there is no BPF_NETFILTER program type.
>
> Sketches the uapi.  Example usage:
>
> 	union bpf_attr attr = { };
>
> 	attr.link_create.prog_fd = progfd;
> 	attr.link_create.attach_type = BPF_NETFILTER;
> 	attr.link_create.netfilter.pf = PF_INET;
> 	attr.link_create.netfilter.hooknum = NF_INET_LOCAL_IN;
> 	attr.link_create.netfilter.priority = -128;
>
> 	err = bpf(BPF_LINK_CREATE, &attr, sizeof(attr));
>
> ... this would attach progfd to ipv4:input hook.
>
> Is BPF_LINK the right place?  Hook gets removed automatically if the calling program
> exits, afaict this is intended.

Yes, this is indeed intended for bpf_link. This plays well with
applications that use the API and stick around (because things get
cleaned up after them automatically even if they crash, say), but it
doesn't work so well for programs that don't (which, notably, includes
command line utilities like 'nft').

This is why I personally never really liked those semantics for
networking hooks: If I run a utility that attaches an XDP program I
generally expect that to stick around until the netdev disappears unless
something else explicitly removes it. (Yes you can pin a bpf_link, but
then you have the opposite problem: if the netdev disappears some entity
has to remove the pinned link, or you'll have a zombie program present
in the kernel until the next reboot).

For XDP and TC users can choose between bpf_link and netlink for
attachment and get one of the two semantics (goes away on close or stays
put). Not sure if it would make sense to do the same for nftables?

> Should a program running in init_netns be allowed to attach hooks in other netns too?
>
> I could do what BPF_LINK_TYPE_NETNS is doing and fetch net via
> get_net_ns_by_fd(attr->link_create.target_fd);

We don't allow that for any other type of BPF program; the expectation
is that the entity doing the attachment will move to the right ns first.
Is there any particular use case for doing something different for
nftables?

> For the actual BPF_NETFILTER program type I plan to follow what the bpf
> flow dissector is doing, i.e. pretend prototype is
>
> func(struct __sk_buff *skb)
>
> but pass a custom program specific context struct on kernel side.
> Verifier will rewrite accesses as needed.

This sounds reasonable, and also promotes code reuse between program
types (say, you can write some BPF code to parse a packet and reuse it
between the flow dissector, TC and netfilter).

> Things like nf_hook_state->in (net_device) could then be exposed via
> kfuncs.

Right, so like:

state = bpf_nf_get_hook_state(ctx); ?

Sounds OK to me.

> nf_hook_run_bpf() (c-function that creates the program context and
> calls the real bpf prog) would be "updated" to use the bpf dispatcher to
> avoid the indirect call overhead.

What 'bpf dispatcher' are you referring to here? We have way too many
things with that name :P

> Does that seem ok to you?  I'd ignore the bpf dispatcher for now and
> would work on the needed verifier changes first.

Getting something that works first seems reasonable, sure! :)

-Toke
