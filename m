Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF653681C65
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 22:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjA3VKy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 16:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjA3VKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 16:10:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EFB1CADF;
        Mon, 30 Jan 2023 13:10:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5169C6122C;
        Mon, 30 Jan 2023 21:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8C4C433D2;
        Mon, 30 Jan 2023 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675113049;
        bh=DnHr1LbMcoGKDw/UbF+UJ3q/uIAGq2Km3uH30O8+GYw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eOe+m0dD6nNDHlwAZASSqvRRwH+M55+EUNWE8dTSk4sUmMqeBO/fkU3lxWbC7nmvN
         kgClo8Xp3sEfPJlZ5mtG+ThwvpJwVj6+D3RA4r8KNKohSk5H6eUH71sRrbJLt1OFC/
         KfC5Qnn+FBzaDH6EhbGghsmIPtWcUgk8oQA0Dxx18SbQdeNF0O5rFPvv0NJgEAiNXP
         +ox09edXaF+5fftqcJNVyuhxs2xBiNQFRUGj065xeDylbF1Oi9LwUyYKm7LOQAZR2j
         wbzLnd1jycond8VRuQNVZqtap7wZ1R/mDGobiIawlt3QOEWaByyrRGltcZMqciTEuz
         I1MQHQgATe3/w==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4A55C97272C; Mon, 30 Jan 2023 22:10:45 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [RFC] bpf: add bpf_link support for BPF_NETFILTER programs
In-Reply-To: <20230130180115.GB12902@breakpoint.cc>
References: <20230130150432.24924-1-fw@strlen.de> <87zg9zx6ro.fsf@toke.dk>
 <20230130180115.GB12902@breakpoint.cc>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 30 Jan 2023 22:10:45 +0100
Message-ID: <87o7qfwwx6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org> wrote:
>> > Is BPF_LINK the right place?  Hook gets removed automatically if the c=
alling program
>> > exits, afaict this is intended.
>>=20
>> Yes, this is indeed intended for bpf_link. This plays well with
>> applications that use the API and stick around (because things get
>> cleaned up after them automatically even if they crash, say), but it
>> doesn't work so well for programs that don't (which, notably, includes
>> command line utilities like 'nft').
>
> Right, but I did not want to create a dependency on nfnetlink or
> nftables netlink right from the start.

Dependency how? For userspace consumers, you mean?

>> For XDP and TC users can choose between bpf_link and netlink for
>> attachment and get one of the two semantics (goes away on close or stays
>> put). Not sure if it would make sense to do the same for nftables?
>
> For nftables I suspect that, if nft can emit bpf, it would make sense to
> pass the bpf descriptor together with nftables netlink, i.e. along with
> the normal netlink data.
>
> nftables kernel side would then know to use the bpf prog for the
> datapath instead of the interpreter and could even fallback to
> interpreter.
>
> But for the raw hook use case that Alexei and Daniel preferred (cf.
> initial proposal to call bpf progs from nf_tables interpreter) I think
> that there should be no nftables dependency.
>
> I could add a new nfnetlink subtype for nf-bpf if bpf_link is not
> appropriate as an alternative.

I don't think there's anything wrong with bpf_link as an initial
interface at least. I just think it should (eventually) be possible to
load a BPF-based firewall from the command line via this interface,
without having to resort to pinning. There was some talk about adding
this as a mode to the bpf_link interface itself at some point, but that
never materialised (probably because the need is not great since the
netlink interface serves this purpose for TC/XDP).

>> > Things like nf_hook_state->in (net_device) could then be exposed via
>> > kfuncs.
>>=20
>> Right, so like:
>>=20
>> state =3D bpf_nf_get_hook_state(ctx); ?
>>=20
>> Sounds OK to me.
>
> Yes, something like that.  Downside is that the nf_hook_state struct
> is no longer bound by any abi contract, but as I understood it thats
> fine.

Well, there's an ongoing discussion about what, if any, should be the
expectations around kfunc stability:

https://lore.kernel.org/r/20230117212731.442859-1-toke@redhat.com

I certainly don't think it's problematic for a subsystem to give *more*
stability guarantees than BPF core. I mean, if you want the kfunc
interface to be stable you just... don't change it? :)

>> > nf_hook_run_bpf() (c-function that creates the program context and
>> > calls the real bpf prog) would be "updated" to use the bpf dispatcher =
to
>> > avoid the indirect call overhead.
>>=20
>> What 'bpf dispatcher' are you referring to here? We have way too many
>> things with that name :P
>
> I meant 'DEFINE_BPF_DISPATCHER(nf_user_progs);'

Ah, right. Yeah, that can definitely be added later!

-Toke
