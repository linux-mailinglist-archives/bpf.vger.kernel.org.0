Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF96A6221
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjB1WJH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 17:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjB1WJG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 17:09:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3FAAD0F
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 14:09:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 435C4611D6
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 22:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876BEC433D2;
        Tue, 28 Feb 2023 22:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677622143;
        bh=nEZqOg3YOwBOklL8wHlhv2/kON7O2YTtjZyoZ4AsRBM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Imp17qzpCEqxz+sdqFD8ezau4snv7Il0CDqgKB2y4RPc0pDT4cUifFxrvLt51FHfv
         /UOa7u8JuT2Rhzc6lnanfXz9ke//fIlRFFm9r9euZ6l7KhcrGbZ/P7+LIHqioUn0As
         Frge9E1s0txS5O2OjvGus+dYgTCZjOWuZRgkRt/EZC81Jf1yNL0g9tplzKqEPlLdkP
         nSYWoplHYe6z+cnNS8Ed8oej7fPUWCNVfmZ6E9y2HR2L4Ql4NHe5B8wYMdcvR8oAvS
         idqvuPSTJ8FMN1DSrnXIJnGgnlQ3sMWFpuqHVUNhA/HM4/7FZYONR5+p3RlvNkwLdy
         hOPXWKNYWDGsA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 31359975ED8; Tue, 28 Feb 2023 23:09:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
In-Reply-To: <CAKH8qBvzhuaZzEbWT1_4pDuiE7ZooJ6tZJFLZJctqLrEFQ_YrA@mail.gmail.com>
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
 <878rgjjipq.fsf@toke.dk>
 <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
 <87zg8yis0h.fsf@toke.dk>
 <CAKH8qBvzhuaZzEbWT1_4pDuiE7ZooJ6tZJFLZJctqLrEFQ_YrA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 28 Feb 2023 23:09:01 +0100
Message-ID: <87y1ohh282.fsf@toke.dk>
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

> On Mon, Feb 27, 2023 at 3:54 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@ke=
rnel.org> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > On Mon, Feb 27, 2023 at 6:17 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@kernel.org> wrote:
>> >>
>> >> Stanislav Fomichev <sdf@google.com> writes:
>> >>
>> >> > On Thu, Feb 23, 2023 at 3:22 PM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>> >> >>
>> >> >> Stanislav Fomichev <sdf@google.com> writes:
>> >> >>
>> >> >> > I'd like to discuss a potential follow up for the previous "XDP =
RX
>> >> >> > metadata" series [0].
>> >> >> >
>> >> >> > Now that we can access (a subset of) packet metadata at RX, I'd =
like to
>> >> >> > explore the options where we can export some of that metadata on=
 TX. And
>> >> >> > also whether it might be possible to access some of the TX compl=
etion
>> >> >> > metadata (things like TX timestamp).
>> >> >> >
>> >> >> > I'm currently trying to understand whether the same approach I'v=
e used
>> >> >> > on RX could work at TX. By May I plan to have a bunch of options=
 laid
>> >> >> > out (currently considering XSK tx/compl programs and XDP tx/compl
>> >> >> > programs) so we have something to discuss.
>> >> >>
>> >> >> I've been looking at ways of getting a TX-completion hook for the =
XDP
>> >> >> queueing stuff as well. For that, I think it could work to just ho=
ok
>> >> >> into xdp_return_frame(), but if you want to access hardware metada=
ta
>> >> >> it'll obviously have to be in the driver. A hook in the driver cou=
ld
>> >> >> certainly be used for the queueing return as well, though, which m=
ay
>> >> >> help making it worth the trouble :)
>> >> >
>> >> > Yeah, I'd like to get to completion descriptors ideally; so nothing
>> >> > better than a driver hook comes to mind so far :-(
>> >> > (I'm eye-balling mlx5's mlx5e_free_xdpsq_desc AF_XDP path mostly so=
 far).
>> >>
>> >> Is there any other use case for this than getting the TX timestamp? N=
ot
>> >> really sure what else those descriptors contain...
>> >
>> > I don't think so; at least looking at mlx5 and bnxt (the latter
>> > doesn't have a timestamp in the completion ring).
>> > So yeah, not sure, maybe that should be on the side and be AF_XDP spec=
ific.
>> > And not even involve bpf, just put the tx tstamp somewhere in umem:
>> > setsockopt(xsk_fd, SOL_XDP, XSK_STAMP_TX_COMPLETION,
>> > &data_relative_offset, ..);
>> > OTOH, if it is only a timestamp now, it doesn't mean that's all we'd
>> > have for eternity? (plus, this needs a driver "hook" for af_xdp
>> > anyway, so why not make it generic?)
>>
>> So since this is read-only in any case, we could just make it a
>> tracepoint instead of a whole new hook? That's what I was planning to do
>> for xdp_return_frame(); we just need a way to refer back to the original
>> frame, but we'd need to solve that anyway. Just letting XDP/AF_XDP
>> specify their own packet ID in some form, and make that part of the
>> tracepoint data, would probably be sufficient?
>
> That would probably mean a driver specific tracepoint (since we might
> need to get to the completion queue descriptor)?
> Idk, probably still makes sense to have something that works across
> different drivers?
> Or are you suggesting to just do fentry/mlx5e_free_xdpsq_desc and go from=
 there?
> Not sure I can get a umem frame, as you've mentioned; and also it
> doesn't look like cqe is there...

No, we'd define the tracepoint in one place (like along with the others
in include/xdp/trace/event.h), and have it include the fields we need
(ifindex, queue index, timestamp, some kind of packet ID). And then add
a call in each driver that will support this, wherever it makes sense in
that driver. This is what we do with the trace_xdp_exception() calls
already scattered through drivers in the RX handling code.

With this, a BPF listener can attach to just the one tracepoint, and get
events from all drivers that support it (but it can filter on ifindex
for the events it's interested in).

This probably doesn't scale indefinitely: it's possible to add new
fields to the tracepoint if we discover other uses than the timestamp,
but this would probably get unwieldy at some point. However, it's a
lightweight way to add a "hook" if we don't have any other use cases
than getting the timestamp for now.

> I guess the fact that it would arrive out-of-band (not in a umem
> frame) is a minor inconvenience, the userspace should be able to join
> the data together hopefully.

Yeah, that's why I suggested the user-defined packet ID: if the event
just includes that, the BPF or userspace program can do its own matching
depending on its needs...

>> >> >> > I'd like to some more input on whether applying the same idea on=
 TX
>> >> >> > makes sense or not and whether there are any sensible alternativ=
es.
>> >> >> > (IIRC, there was an attempt to do XDP on egress that went nowher=
e).
>> >> >>
>> >> >> I believe that stranded because it was deemed not feasible to cove=
r the
>> >> >> SKB TX path as well, which means it can't be symmetrical to the RX=
 hook.
>> >> >> So we ended up with the in-devmap hook instead. I'm not sure if th=
at's
>> >> >> made easier by multi-buf XDP, so that may be worth revisiting.
>> >> >>
>> >> >> For the TX metadata you don't really have to care about the skb pa=
th, I
>> >> >> suppose, so that may not matter too much either. However, at least=
 for
>> >> >> the in-kernel xdp_frame the TX path is pushed from the stack anywa=
y, so
>> >> >> I'm not sure if it's worth having a separate hook in the driver (w=
ith
>> >> >> all the added complexity and overhead that entails) just to set
>> >> >> metadata? That could just as well be done on push from higher up t=
he
>> >> >> stack; per-driver kfuncs could still be useful for this, though.
>> >> >>
>> >> >> And of course something would be needed so that that BPF programs =
can
>> >> >> process AF_XDP frames in the kernel before they hit the driver, but
>> >> >> again I'm not sure that needs to be a hook in the driver.
>> >> >
>> >> > Care to elaborate more on "push from higher up the stack"?
>> >>
>> >> I'm referring to the XDP_REDIRECT path here: xdp_frames are transmitt=
ed
>> >> by the stack calling ndo_xdp_xmit() in the driver with an array of
>> >> frames that are immediately put on the wire (see bq_xmit_all() in
>> >> devmap.c). So any metadata writing could be done at that point, since
>> >> the target driver is already known; there's even already a program ho=
ok
>> >> in there (used for in-devmap programs).
>> >>
>> >> > I've been thinking about mostly two cases:
>> >> > - XDP_TX - I think this one technically doesn't need an extra hook;
>> >> > all metadata manipulations can be done at xdp_rx? (however, not sure
>> >> > how real that is, since the descriptors are probably not exposed ov=
er
>> >> > there?)
>> >>
>> >> Well, to me XDP_REDIRECT is the most interesting one (see above). I
>> >> think we could even drop the XDP_TX case and only do this for
>> >> XDP_REDIRECT, since XDP_TX is basically a special-case optimisation.
>> >> I.e., it's possible to XDP_REDIRECT back to the same device, the fram=
es
>> >> will just take a slight detour up through the stack; but that could a=
lso
>> >> be a good thing if it means we'll have to do less surgery to the driv=
ers
>> >> to implement this for two paths.
>> >>
>> >> It does have the same challenge as you outlined above, though: At that
>> >> point the TX descriptor probably doesn't exist, so the driver NDO will
>> >> have to do something else with the data; but maybe we can solve that
>> >> without moving the hook into the driver itself somehow?
>> >
>> > Ah, ok, yeah, I was putting XDP_TX / XDP_REDIRECT under the same
>> > "transmit something out of xdp_rx hook" umbrella. We can maybe come up
>> > with a skb-like-private metadata layout (as we've discussed previously
>> > for skb) here as well? But not sure it would solve all the problems?
>> > I'm thinking of an af_xdp case where it wants to program something
>> > similar to tso/encap/tunneling offload (assuming af_xdp will get 4k+
>> > support) or a checksum offload. Exposing access to the driver tx hooks
>> > seems like the easiest way to get there?
>>
>> Well, I was thinking something like exposing driver kfuncs like what you
>> implemented on RX, but having the program that calls them be the one in
>> the existing devmap hook (each map entry is tied to a particular netdev,
>> so we could use the same type of dev-bound logic as we do on RX). The
>> driver wouldn't have a TX descriptor at this point, but it could have a
>> driver-private area somewhere in the xdp_frame (if we make space for it)
>> which the kfuncs could just write to in whichever format it wants, so
>> that copying it to the descriptor later is just a memcpy().
>
> Yeah, that sounds similar to what we've discussed for the xdp->skb
> path, right? Maybe it should be even some kind of extension to that?
> On rx, we stash a bunch of metadata in that private area. If the frame
> goes to the kernel stack -> put it into skb; if the frame goes back to
> the wire -> the driver can parse it?

Yeah, not a bad idea to combine those.

>> There would still need to be a new hook for AF_XDP, but I think it could
>> have the same semantics as a devmap prog (i.e., an XDP program type that
>> runs right before TX, but after the destination device is selected); we
>> could attach it to the socket, maybe? Doesn't have to be in the driver
>> itself (just before the driver ndo is called for zc - I think?).
>
> Sounds sensible; will try to explore more, thx!

Awesome, looking forward to seeing what you come up with :)

-Toke
