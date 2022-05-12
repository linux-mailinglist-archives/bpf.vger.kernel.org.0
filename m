Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FADF5248A8
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 11:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345467AbiELJN7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 05:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242267AbiELJN6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 05:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880931BD70B
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 02:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26A9F617D7
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 09:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F94C385B8;
        Thu, 12 May 2022 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652346836;
        bh=eanKwLGK/lGv6DwEKxEhaU3mHSj+HqQBOVEA1RHApnc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jbL8sassjBltUx6sorNuf3CG2lNL7JbTJ4t1IJgaHxyXJqA1Iu3ljEmkxzISclZdU
         h6GIyzaQWManG2qMr7zt3HRWz08tiBksqoz6Jkk+iOuPqEJ53fqwI233diWOyKZiUr
         4fSYVWxfsGWIBT09Z/OdGS7unvo1CEmw3K8ToKlX86dnp4xh+wuWIBIb1eEvcp8XLZ
         Z+rI2BVRJwUt/4R11bSHKZsM/EpqMXVXLpH8/W5TmziKQVpuEuSlkqVlJOnwIWW8MI
         DEOKNE4cId7YuXac6+MzjEw7WFeSFRs4YM14hU500NnRnI8SA2lBsyK7vXV+MYHET6
         2c8KFZSJ+gQIQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6014638E59F; Thu, 12 May 2022 11:13:53 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: BPF maps don't work without CONFIG_TRACING/CONFIG_FTRACE
In-Reply-To: <CAN9vWDLd43B-_PLAWj-6Fr8-W6m=Scn_zNdOnJHALDdrDPM4og@mail.gmail.com>
References: <CAN9vWDLY24LEY-zhBSNVRTPBqbYQd+D62av0jKK_BqMvwt5-ig@mail.gmail.com>
 <CAEf4Bza6Ks-FGAGkLCGhK1KEDRdtqv==y7nN63KejF829XQtfA@mail.gmail.com>
 <CAN9vWD+6SBQtQqxZ__bvqJ8MsrOUr4cfQcU99at1XVPSUiOsmw@mail.gmail.com>
 <CAEf4BzYtkLX8cYGC9rAnDyMBrQ8uHmgA8T8+nZ6dJe3c1X+73w@mail.gmail.com>
 <CAN9vWDJHrYUVFtBU-cAz6trvJAx903hGgO2Yj6=3Bt2CjS61Yg@mail.gmail.com>
 <87czgji43i.fsf@toke.dk>
 <CAN9vWDLd43B-_PLAWj-6Fr8-W6m=Scn_zNdOnJHALDdrDPM4og@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 12 May 2022 11:13:53 +0200
Message-ID: <877d6ri04u.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Michael Zimmermann <sigmaepsilon92@gmail.com> writes:

> On Thu, May 12, 2022 at 9:48 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@ke=
rnel.org> wrote:
>>
>> Michael Zimmermann <sigmaepsilon92@gmail.com> writes:
>>
>> > On Thu, May 12, 2022 at 5:21 AM Andrii Nakryiko
>> > <andrii.nakryiko@gmail.com> wrote:
>> >>
>> >> On Mon, May 9, 2022 at 10:12 PM Michael Zimmermann
>> >> <sigmaepsilon92@gmail.com> wrote:
>> >> >
>> >> > Thank you for your answer.
>> >> > What I'm ultimately trying to do is: Use aya-rs to watch egress on a
>> >> > network interface and notify userspace through a map (for certain I=
Ps
>> >> > only).
>> >> >
>> >> > In my actual use case, the userspace is supposed to do more complex
>> >> > stuff but for testing I simply logged the receival of a message
>> >> > through the BPF map on the console. And that is what I expect to
>> >> > happen and which does happen as long as CONFIG_TRACING/CONFIG_FTRACE
>> >> > are active. If not, I simply never receive any messages on any map.
>> >> >
>> >> > I've also tried this using an XDP program which sends a message eve=
ry
>> >> > time it sees a packet. And while the program seemed to be
>> >> > working(since it did block certain traffic), I never saw any data in
>> >> > the map when those configs were disabled.
>> >> >
>> >> > Also, I'm giving you two configs(tracing and ftrace) since the other
>> >> > one seems to get y-selected automatically if one of them is active.
>> >>
>> >> Please don't top post, reply inline instead.
>> > Sorry for that, GMail does that by default and even hides that it's
>> > quoting at all.
>> >
>> >>
>> >> I don't think we have enough to investigate here, even "receive any
>> >> messages on any map" is so ambiguous that it's hard to even guess what
>> >> you are really trying to do. BPF maps are not sending/receiving
>> >> messages. So please provide some pieces of code and what you are doing
>> >> to check. CONFIG_TRACING and CONFIG_FTRACE shouldn't have any effect
>> >> on functioning of BPF maps, so it's most probably that you are doing
>> >> something besides BPF map update/lookup, but you don't provide enough
>> >> information to check anything.
>> >
>> > An aya project I tested where I don't receive any events:
>> > https://github.com/aya-rs/book/tree/6b52a6fac5fa3e5a1165f98591b2eaff96=
92048a/examples/myapp-03
>>
>> It's using a PERF_EVENT_ARRAY map to send events to userspace. This
>> requires CONFIG_BPF_EVENTS to work, which depends on CONFIG_PERF_EVENTS.
>> Not sure if this depends on CONFIG_TRACING specifically, but maybe you
>> disabled PERF_EVENTS as well?
>
> PERF_EVENTS is enabled in both my working and my broken config.
> But both directly and through others, BPF_EVENTS depends on FTRACE
> (which then also selects TRACING).
>
> So is this some weird dependency chain or expected behavior?
> If it's expected, are there alternatives to achieve similar
> functionality or do I have to convince my distro to enable tracing
> support?

Andrii can probably answer for sure, but I *think* this is expected.
There's the BPF_MAP_TYPE_RINGBUF which can be used as an alternative;
not sure what the dependencies are for that, but from a cursory glance
it looks like it doesn't depend on anything in TRACING...

-Toke
