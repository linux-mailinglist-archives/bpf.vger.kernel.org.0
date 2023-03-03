Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD46A9754
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 13:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCCMhZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 07:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCCMhY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 07:37:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8F25D441
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 04:37:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54FFD6181D
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 12:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D905C433D2;
        Fri,  3 Mar 2023 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677847041;
        bh=OP2X1+hx1DN75bYsiwga9cdUaE4peM8OpSuwx8r3BBI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dYCffnv2e5C9xv5UkRSkH0oB3h1TWQ94PfxCc4Yw9H+RGrIzwSsgKWwNPPJMnxnIt
         cv+Rf04hoieqjnkkGg/ZyAgra24nZb4/zvnICvazydOLYvZdgwogO1WqwCoYJm1pWx
         aFlronJ0mCCfBA83ZyyK8JYQO3IF1i5kBUl5pgFcsO8AY4GhgQ3zNcA33tiUOu2rhr
         Vru92LDXnZbltrhOhiVtoDNh+deYQhihafovxYcYd/RI3pFc3WVIspfxyRl2jfmPcV
         sdpahOjq4qzGmRU3ae8N3m/01OimgLyuEPaZCWGPrlVhzmfv9q7aSP09sLQ+KOsVg3
         I/VIouHAvQy/A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 638DD9763CF; Fri,  3 Mar 2023 13:37:19 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
In-Reply-To: <CAJ8uoz0jnavFxMJ8tgb4+-+OsCPqVJQez8ULOTM2a60D4RmJ7A@mail.gmail.com>
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
 <878rgjjipq.fsf@toke.dk>
 <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
 <CAJ8uoz0jnavFxMJ8tgb4+-+OsCPqVJQez8ULOTM2a60D4RmJ7A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 03 Mar 2023 13:37:19 +0100
Message-ID: <87zg8uc8ow.fsf@toke.dk>
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

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Mon, 27 Feb 2023 at 21:16, Stanislav Fomichev <sdf@google.com> wrote:
>>
>> On Mon, Feb 27, 2023 at 6:17 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@k=
ernel.org> wrote:
>> >
>> > Stanislav Fomichev <sdf@google.com> writes:
>> >
>> > > On Thu, Feb 23, 2023 at 3:22 PM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@kernel.org> wrote:
>> > >>
>> > >> Stanislav Fomichev <sdf@google.com> writes:
>> > >>
>> > >> > I'd like to discuss a potential follow up for the previous "XDP RX
>> > >> > metadata" series [0].
>> > >> >
>> > >> > Now that we can access (a subset of) packet metadata at RX, I'd l=
ike to
>> > >> > explore the options where we can export some of that metadata on =
TX. And
>> > >> > also whether it might be possible to access some of the TX comple=
tion
>> > >> > metadata (things like TX timestamp).
>> > >> >
>> > >> > I'm currently trying to understand whether the same approach I've=
 used
>> > >> > on RX could work at TX. By May I plan to have a bunch of options =
laid
>> > >> > out (currently considering XSK tx/compl programs and XDP tx/compl
>> > >> > programs) so we have something to discuss.
>> > >>
>> > >> I've been looking at ways of getting a TX-completion hook for the X=
DP
>> > >> queueing stuff as well. For that, I think it could work to just hook
>> > >> into xdp_return_frame(), but if you want to access hardware metadata
>> > >> it'll obviously have to be in the driver. A hook in the driver could
>> > >> certainly be used for the queueing return as well, though, which may
>> > >> help making it worth the trouble :)
>> > >
>> > > Yeah, I'd like to get to completion descriptors ideally; so nothing
>> > > better than a driver hook comes to mind so far :-(
>> > > (I'm eye-balling mlx5's mlx5e_free_xdpsq_desc AF_XDP path mostly so =
far).
>> >
>> > Is there any other use case for this than getting the TX timestamp? Not
>> > really sure what else those descriptors contain...
>>
>> I don't think so; at least looking at mlx5 and bnxt (the latter
>> doesn't have a timestamp in the completion ring).
>> So yeah, not sure, maybe that should be on the side and be AF_XDP specif=
ic.
>> And not even involve bpf, just put the tx tstamp somewhere in umem:
>> setsockopt(xsk_fd, SOL_XDP, XSK_STAMP_TX_COMPLETION,
>> &data_relative_offset, ..);
>> OTOH, if it is only a timestamp now, it doesn't mean that's all we'd
>> have for eternity? (plus, this needs a driver "hook" for af_xdp
>> anyway, so why not make it generic?)
>>
>> > >> > I'd like to some more input on whether applying the same idea on =
TX
>> > >> > makes sense or not and whether there are any sensible alternative=
s.
>> > >> > (IIRC, there was an attempt to do XDP on egress that went nowhere=
).
>> > >>
>> > >> I believe that stranded because it was deemed not feasible to cover=
 the
>> > >> SKB TX path as well, which means it can't be symmetrical to the RX =
hook.
>> > >> So we ended up with the in-devmap hook instead. I'm not sure if tha=
t's
>> > >> made easier by multi-buf XDP, so that may be worth revisiting.
>> > >>
>> > >> For the TX metadata you don't really have to care about the skb pat=
h, I
>> > >> suppose, so that may not matter too much either. However, at least =
for
>> > >> the in-kernel xdp_frame the TX path is pushed from the stack anyway=
, so
>> > >> I'm not sure if it's worth having a separate hook in the driver (wi=
th
>> > >> all the added complexity and overhead that entails) just to set
>> > >> metadata? That could just as well be done on push from higher up the
>> > >> stack; per-driver kfuncs could still be useful for this, though.
>> > >>
>> > >> And of course something would be needed so that that BPF programs c=
an
>> > >> process AF_XDP frames in the kernel before they hit the driver, but
>> > >> again I'm not sure that needs to be a hook in the driver.
>> > >
>> > > Care to elaborate more on "push from higher up the stack"?
>> >
>> > I'm referring to the XDP_REDIRECT path here: xdp_frames are transmitted
>> > by the stack calling ndo_xdp_xmit() in the driver with an array of
>> > frames that are immediately put on the wire (see bq_xmit_all() in
>> > devmap.c). So any metadata writing could be done at that point, since
>> > the target driver is already known; there's even already a program hook
>> > in there (used for in-devmap programs).
>> >
>> > > I've been thinking about mostly two cases:
>> > > - XDP_TX - I think this one technically doesn't need an extra hook;
>> > > all metadata manipulations can be done at xdp_rx? (however, not sure
>> > > how real that is, since the descriptors are probably not exposed over
>> > > there?)
>> >
>> > Well, to me XDP_REDIRECT is the most interesting one (see above). I
>> > think we could even drop the XDP_TX case and only do this for
>> > XDP_REDIRECT, since XDP_TX is basically a special-case optimisation.
>> > I.e., it's possible to XDP_REDIRECT back to the same device, the frames
>> > will just take a slight detour up through the stack; but that could al=
so
>> > be a good thing if it means we'll have to do less surgery to the drive=
rs
>> > to implement this for two paths.
>> >
>> > It does have the same challenge as you outlined above, though: At that
>> > point the TX descriptor probably doesn't exist, so the driver NDO will
>> > have to do something else with the data; but maybe we can solve that
>> > without moving the hook into the driver itself somehow?
>>
>> Ah, ok, yeah, I was putting XDP_TX / XDP_REDIRECT under the same
>> "transmit something out of xdp_rx hook" umbrella. We can maybe come up
>> with a skb-like-private metadata layout (as we've discussed previously
>> for skb) here as well? But not sure it would solve all the problems?
>> I'm thinking of an af_xdp case where it wants to program something
>> similar to tso/encap/tunneling offload (assuming af_xdp will get 4k+
>> support)
>
> We have a patch set of this in the works. Need to finish the last
> couple of tests then optimize performance and it is good to go. We
> should be able to post it during the next cycle that starts next week.

Uh, exciting, will look forward to seeing that! :)

-Toke
