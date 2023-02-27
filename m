Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78706A4416
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 15:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjB0ORm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 09:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjB0ORl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 09:17:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F23B47B
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 06:17:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DAC760E73
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 14:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DBFC433D2;
        Mon, 27 Feb 2023 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677507459;
        bh=JMEDcE0AzMshsB2yTwQcl3wKJurSFgFeg5QjJ6vu7Z0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=s0dKiAH3GaEYPUzNHd+FF9IdZhmP//W0gHZRR3tBvxK1trG8Z6782bAQOUuEFzIht
         A+av3rmSxghAryy85XbEt2SvnWKQJaf5Z3ooMII8HvEXLEtHGtjFo/DI7clD0vbE4S
         MRWknw/yzD7ktg/CyMSWdnnkBdiTY5IuQWtN994Fxz/I/88MmJVbE6udU9r/5vr+ul
         kdO8TMmuXiZQD952+USrZ4WMcr0tUEx7b3oM0v49vMtNb++lbNUY4PPYVoVuhwRumo
         Cl1U4xTJ5Km7UHhGuSdz0eyPhFdyGogs7jKpiJgTTtYwXcJLtw5sZDguc73NEUGwc1
         DIV5LIpN6agyw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2D65D975C50; Mon, 27 Feb 2023 15:17:37 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
In-Reply-To: <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 27 Feb 2023 15:17:37 +0100
Message-ID: <878rgjjipq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> On Thu, Feb 23, 2023 at 3:22 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@ke=
rnel.org> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > I'd like to discuss a potential follow up for the previous "XDP RX
>> > metadata" series [0].
>> >
>> > Now that we can access (a subset of) packet metadata at RX, I'd like to
>> > explore the options where we can export some of that metadata on TX. A=
nd
>> > also whether it might be possible to access some of the TX completion
>> > metadata (things like TX timestamp).
>> >
>> > I'm currently trying to understand whether the same approach I've used
>> > on RX could work at TX. By May I plan to have a bunch of options laid
>> > out (currently considering XSK tx/compl programs and XDP tx/compl
>> > programs) so we have something to discuss.
>>
>> I've been looking at ways of getting a TX-completion hook for the XDP
>> queueing stuff as well. For that, I think it could work to just hook
>> into xdp_return_frame(), but if you want to access hardware metadata
>> it'll obviously have to be in the driver. A hook in the driver could
>> certainly be used for the queueing return as well, though, which may
>> help making it worth the trouble :)
>
> Yeah, I'd like to get to completion descriptors ideally; so nothing
> better than a driver hook comes to mind so far :-(
> (I'm eye-balling mlx5's mlx5e_free_xdpsq_desc AF_XDP path mostly so far).

Is there any other use case for this than getting the TX timestamp? Not
really sure what else those descriptors contain...

>> > I'd like to some more input on whether applying the same idea on TX
>> > makes sense or not and whether there are any sensible alternatives.
>> > (IIRC, there was an attempt to do XDP on egress that went nowhere).
>>
>> I believe that stranded because it was deemed not feasible to cover the
>> SKB TX path as well, which means it can't be symmetrical to the RX hook.
>> So we ended up with the in-devmap hook instead. I'm not sure if that's
>> made easier by multi-buf XDP, so that may be worth revisiting.
>>
>> For the TX metadata you don't really have to care about the skb path, I
>> suppose, so that may not matter too much either. However, at least for
>> the in-kernel xdp_frame the TX path is pushed from the stack anyway, so
>> I'm not sure if it's worth having a separate hook in the driver (with
>> all the added complexity and overhead that entails) just to set
>> metadata? That could just as well be done on push from higher up the
>> stack; per-driver kfuncs could still be useful for this, though.
>>
>> And of course something would be needed so that that BPF programs can
>> process AF_XDP frames in the kernel before they hit the driver, but
>> again I'm not sure that needs to be a hook in the driver.
>
> Care to elaborate more on "push from higher up the stack"?

I'm referring to the XDP_REDIRECT path here: xdp_frames are transmitted
by the stack calling ndo_xdp_xmit() in the driver with an array of
frames that are immediately put on the wire (see bq_xmit_all() in
devmap.c). So any metadata writing could be done at that point, since
the target driver is already known; there's even already a program hook
in there (used for in-devmap programs).

> I've been thinking about mostly two cases:
> - XDP_TX - I think this one technically doesn't need an extra hook;
> all metadata manipulations can be done at xdp_rx? (however, not sure
> how real that is, since the descriptors are probably not exposed over
> there?)

Well, to me XDP_REDIRECT is the most interesting one (see above). I
think we could even drop the XDP_TX case and only do this for
XDP_REDIRECT, since XDP_TX is basically a special-case optimisation.
I.e., it's possible to XDP_REDIRECT back to the same device, the frames
will just take a slight detour up through the stack; but that could also
be a good thing if it means we'll have to do less surgery to the drivers
to implement this for two paths.

It does have the same challenge as you outlined above, though: At that
point the TX descriptor probably doesn't exist, so the driver NDO will
have to do something else with the data; but maybe we can solve that
without moving the hook into the driver itself somehow?

> - AF_XDP TX - this one needs something deep in the driver (due to tx
> zc) to populate the descriptors?

Yeah, this one is a bit more challenging, but having a way to process
AF_XDP frames in the kernel before they're sent out would be good in any
case (for things like policing what packets an AF_XDP application can
send in a cloud deployment, for instance). Would be best if we could
consolidate the XDP_REDIRECT and AF_XDP paths, I suppose...

> - anything else?

Well, see above ;)

>> In any case, the above is just my immediate brain dump (I've been
>> mulling these things over for a while in relation to the queueing
>> stuff), and I'd certainly welcome more discussion on the subject! :)
>
> Awesome, thanks for the dump! Will try to keep you in the loop!

Great, thanks!

-Toke
