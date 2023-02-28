Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB956A63AB
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 00:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjB1XIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 18:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjB1XIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 18:08:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9589EC9
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 15:08:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5737361202
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 23:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE5CC433D2;
        Tue, 28 Feb 2023 23:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677625719;
        bh=ZBr/w6HfdMY+A5t6d6w8rMPSeoU8vodJySUm4P93kbE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QBqjDOwe3MtGz1nKf6tJnxMs7UePuj4GyORzUTT4B8UjLFkDHKe/0tK1srxDRPPQw
         b+3F9HpgPOugCQQ+Ert1sEyo6vyvrv1c/zkDlUfNk+SDHE8Jm+44g/WORENMZ/Kjpz
         gUxSbXuw7AWTz4QWUwNCv5UVTEod4fTGrssH3w0B0xfJgs3NW5UvvlKMFZkUkZICh+
         1Y6YZzA28d0fIKQKd9l4c535CmxjUKOODBl+385Zq7t3pQs7axUHnr97GOYLIg2BLU
         s+JX2HwyX1zzyuyu/Bzbk6NWiC2z6prCauOshD8CISdAJdooGD3IJEj/0xxugHpTOY
         kWyju3diu+jTg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9F91E975EF5; Wed,  1 Mar 2023 00:08:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] XDP metadata for TX
In-Reply-To: <Y/6IBI8hlyI3DcUz@google.com>
References: <Y/fnZkXQdc8lkP7q@google.com> <874jrcklvf.fsf@toke.dk>
 <CAKH8qBsoTiVja8=EXTcfJNYpF7JjgPoD=Wi4JBX5PGbggn=S4g@mail.gmail.com>
 <878rgjjipq.fsf@toke.dk>
 <CAKH8qBstQb0CS1Q-dcx_jeZM2sKSMH3PHFww6=6Hy+3wJ-NL+Q@mail.gmail.com>
 <87zg8yis0h.fsf@toke.dk>
 <CAKH8qBvzhuaZzEbWT1_4pDuiE7ZooJ6tZJFLZJctqLrEFQ_YrA@mail.gmail.com>
 <87y1ohh282.fsf@toke.dk> <Y/6IBI8hlyI3DcUz@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 01 Mar 2023 00:08:36 +0100
Message-ID: <87lekhgzgr.fsf@toke.dk>
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

Stanislav Fomichev <sdf@google.com> writes:

> On 02/28, Toke H=EF=BF=BDiland-J=EF=BF=BDrgensen wrote:
>> Stanislav Fomichev <sdf@google.com> writes:
>
>> > On Mon, Feb 27, 2023 at 3:54 PM Toke H=EF=BF=BDiland-J=EF=BF=BDrgensen=
=20=20
>> <toke@kernel.org> wrote:
>> >>
>> >> Stanislav Fomichev <sdf@google.com> writes:
>> >>
>> >> > On Mon, Feb 27, 2023 at 6:17 AM Toke H=EF=BF=BDiland-J=EF=BF=BDrgen=
sen=20=20
>> <toke@kernel.org> wrote:
>> >> >>
>> >> >> Stanislav Fomichev <sdf@google.com> writes:
>> >> >>
>> >> >> > On Thu, Feb 23, 2023 at 3:22 PM Toke H=EF=BF=BDiland-J=EF=BF=BDr=
gensen=20=20
>> <toke@kernel.org> wrote:
>> >> >> >>
>> >> >> >> Stanislav Fomichev <sdf@google.com> writes:
>> >> >> >>
>> >> >> >> > I'd like to discuss a potential follow up for the=20=20
>> previous "XDP RX
>> >> >> >> > metadata" series [0].
>> >> >> >> >
>> >> >> >> > Now that we can access (a subset of) packet metadata at RX,=
=20=20
>> I'd like to
>> >> >> >> > explore the options where we can export some of that metadata=
=20=20
>> on TX. And
>> >> >> >> > also whether it might be possible to access some of the TX=20=
=20
>> completion
>> >> >> >> > metadata (things like TX timestamp).
>> >> >> >> >
>> >> >> >> > I'm currently trying to understand whether the same approach=
=20=20
>> I've used
>> >> >> >> > on RX could work at TX. By May I plan to have a bunch of=20=20
>> options laid
>> >> >> >> > out (currently considering XSK tx/compl programs and XDP=20=20
>> tx/compl
>> >> >> >> > programs) so we have something to discuss.
>> >> >> >>
>> >> >> >> I've been looking at ways of getting a TX-completion hook for=
=20=20
>> the XDP
>> >> >> >> queueing stuff as well. For that, I think it could work to just=
=20=20
>> hook
>> >> >> >> into xdp_return_frame(), but if you want to access hardware=20=
=20
>> metadata
>> >> >> >> it'll obviously have to be in the driver. A hook in the driver=
=20=20
>> could
>> >> >> >> certainly be used for the queueing return as well, though, whic=
h=20=20
>> may
>> >> >> >> help making it worth the trouble :)
>> >> >> >
>> >> >> > Yeah, I'd like to get to completion descriptors ideally; so=20=20
>> nothing
>> >> >> > better than a driver hook comes to mind so far :-(
>> >> >> > (I'm eye-balling mlx5's mlx5e_free_xdpsq_desc AF_XDP path mostly=
=20=20
>> so far).
>> >> >>
>> >> >> Is there any other use case for this than getting the TX timestamp=
?=20=20
>> Not
>> >> >> really sure what else those descriptors contain...
>> >> >
>> >> > I don't think so; at least looking at mlx5 and bnxt (the latter
>> >> > doesn't have a timestamp in the completion ring).
>> >> > So yeah, not sure, maybe that should be on the side and be AF_XDP=
=20=20
>> specific.
>> >> > And not even involve bpf, just put the tx tstamp somewhere in umem:
>> >> > setsockopt(xsk_fd, SOL_XDP, XSK_STAMP_TX_COMPLETION,
>> >> > &data_relative_offset, ..);
>> >> > OTOH, if it is only a timestamp now, it doesn't mean that's all we'd
>> >> > have for eternity? (plus, this needs a driver "hook" for af_xdp
>> >> > anyway, so why not make it generic?)
>> >>
>> >> So since this is read-only in any case, we could just make it a
>> >> tracepoint instead of a whole new hook? That's what I was planning to=
=20=20
>> do
>> >> for xdp_return_frame(); we just need a way to refer back to the=20=20
>> original
>> >> frame, but we'd need to solve that anyway. Just letting XDP/AF_XDP
>> >> specify their own packet ID in some form, and make that part of the
>> >> tracepoint data, would probably be sufficient?
>> >
>> > That would probably mean a driver specific tracepoint (since we might
>> > need to get to the completion queue descriptor)?
>> > Idk, probably still makes sense to have something that works across
>> > different drivers?
>> > Or are you suggesting to just do fentry/mlx5e_free_xdpsq_desc and go=
=20=20
>> from there?
>> > Not sure I can get a umem frame, as you've mentioned; and also it
>> > doesn't look like cqe is there...
>
>> No, we'd define the tracepoint in one place (like along with the others
>> in include/xdp/trace/event.h), and have it include the fields we need
>> (ifindex, queue index, timestamp, some kind of packet ID). And then add
>> a call in each driver that will support this, wherever it makes sense in
>> that driver. This is what we do with the trace_xdp_exception() calls
>> already scattered through drivers in the RX handling code.
>
>> With this, a BPF listener can attach to just the one tracepoint, and get
>> events from all drivers that support it (but it can filter on ifindex
>> for the events it's interested in).
>
>> This probably doesn't scale indefinitely: it's possible to add new
>> fields to the tracepoint if we discover other uses than the timestamp,
>> but this would probably get unwieldy at some point. However, it's a
>> lightweight way to add a "hook" if we don't have any other use cases
>> than getting the timestamp for now.
>
>> > I guess the fact that it would arrive out-of-band (not in a umem
>> > frame) is a minor inconvenience, the userspace should be able to join
>> > the data together hopefully.
>
>> Yeah, that's why I suggested the user-defined packet ID: if the event
>> just includes that, the BPF or userspace program can do its own matching
>> depending on its needs...
>
> I guess we can implement this user-defined packet ID as a TX metadata
> as well? Some kind of u32 tag/mark that the XDP program can set? (and
> some new AF_XDP TX hook where we can set it up as well)

Yeah, good point, that would be an excellent way to resolve that
particular issue :)

-Toke
