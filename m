Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39991524759
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351205AbiELHse (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 03:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351206AbiELHs3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 03:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BA95BD16
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCA4D61E1D
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 07:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0681C385B8;
        Thu, 12 May 2022 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652341701;
        bh=fWljWNS5KfLft/haqYHuPhPKVr/bjtrftvn0biOJ1x4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iWu237AetNha8fDvdCDEOX5eioi7ToVdjDxLpcZQABYREwHDdW90kL96h2f6CFqwy
         rfsiuDw1hm3SY/Oohstfoh1Y9kBzyNJNdv68w58JTBzvFs3BfcW6qRIiK54/18lZsz
         M8QoPGDiXZ4AvxMgngooohJ1Nmfm7mHffQSiYdCem2TmcoWrwqAd6J4Iq28LqUVcwO
         Wk7UY0UYQTl1lKONtdaqrBsWOGT7IoS9iv0T8mjZjlPm5+SAGBYdLTks7zvAvcFsaa
         IvR2W14u1Brv1ee1SI1yOFUrivT4RO9vTyL7tPHJx4Kce1wQV7XwaAR0xhYhlmfBJ8
         NNU2+W1+pyq3w==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 51A2938E58C; Thu, 12 May 2022 09:48:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: BPF maps don't work without CONFIG_TRACING/CONFIG_FTRACE
In-Reply-To: <CAN9vWDJHrYUVFtBU-cAz6trvJAx903hGgO2Yj6=3Bt2CjS61Yg@mail.gmail.com>
References: <CAN9vWDLY24LEY-zhBSNVRTPBqbYQd+D62av0jKK_BqMvwt5-ig@mail.gmail.com>
 <CAEf4Bza6Ks-FGAGkLCGhK1KEDRdtqv==y7nN63KejF829XQtfA@mail.gmail.com>
 <CAN9vWD+6SBQtQqxZ__bvqJ8MsrOUr4cfQcU99at1XVPSUiOsmw@mail.gmail.com>
 <CAEf4BzYtkLX8cYGC9rAnDyMBrQ8uHmgA8T8+nZ6dJe3c1X+73w@mail.gmail.com>
 <CAN9vWDJHrYUVFtBU-cAz6trvJAx903hGgO2Yj6=3Bt2CjS61Yg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 12 May 2022 09:48:17 +0200
Message-ID: <87czgji43i.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
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

> On Thu, May 12, 2022 at 5:21 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, May 9, 2022 at 10:12 PM Michael Zimmermann
>> <sigmaepsilon92@gmail.com> wrote:
>> >
>> > Thank you for your answer.
>> > What I'm ultimately trying to do is: Use aya-rs to watch egress on a
>> > network interface and notify userspace through a map (for certain IPs
>> > only).
>> >
>> > In my actual use case, the userspace is supposed to do more complex
>> > stuff but for testing I simply logged the receival of a message
>> > through the BPF map on the console. And that is what I expect to
>> > happen and which does happen as long as CONFIG_TRACING/CONFIG_FTRACE
>> > are active. If not, I simply never receive any messages on any map.
>> >
>> > I've also tried this using an XDP program which sends a message every
>> > time it sees a packet. And while the program seemed to be
>> > working(since it did block certain traffic), I never saw any data in
>> > the map when those configs were disabled.
>> >
>> > Also, I'm giving you two configs(tracing and ftrace) since the other
>> > one seems to get y-selected automatically if one of them is active.
>>
>> Please don't top post, reply inline instead.
> Sorry for that, GMail does that by default and even hides that it's
> quoting at all.
>
>>
>> I don't think we have enough to investigate here, even "receive any
>> messages on any map" is so ambiguous that it's hard to even guess what
>> you are really trying to do. BPF maps are not sending/receiving
>> messages. So please provide some pieces of code and what you are doing
>> to check. CONFIG_TRACING and CONFIG_FTRACE shouldn't have any effect
>> on functioning of BPF maps, so it's most probably that you are doing
>> something besides BPF map update/lookup, but you don't provide enough
>> information to check anything.
>
> An aya project I tested where I don't receive any events:
> https://github.com/aya-rs/book/tree/6b52a6fac5fa3e5a1165f98591b2eaff9692048a/examples/myapp-03

It's using a PERF_EVENT_ARRAY map to send events to userspace. This
requires CONFIG_BPF_EVENTS to work, which depends on CONFIG_PERF_EVENTS.
Not sure if this depends on CONFIG_TRACING specifically, but maybe you
disabled PERF_EVENTS as well?

-Toke
