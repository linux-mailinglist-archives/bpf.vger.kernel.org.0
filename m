Return-Path: <bpf+bounces-75700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7736DC920D9
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40F5A34E5AF
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFA332B99F;
	Fri, 28 Nov 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay8sAmHw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766ED28727C
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334825; cv=none; b=COO+XiX9dLZgclgKPQ1O5xgVSi+vZVixbypxWTfDodORk9RGwAhQeucPJ2pBCKwiA2D38TphK3gCBHPTcykL/Ze296fVseIerICUrHiL3N0xc0kBpClYmkRfefgPRvj9wRv9aOssphPs7QIUyNsU3dBmpFdjHOLiCLmUSir4EHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334825; c=relaxed/simple;
	bh=MG2jjE1UUQQkLUKTMdA9dMsj3aO6TocY6L3RQxPrTO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=db+fGzTyr0FF99QB9MeYptnbTErQubwaHvQAf3xMspJKAmC3E6Kxc6pfKt75t53mX6F1U8CiwNiELaIIvBa4b0E2/l1rBkr87me7I2TCmUeR0UEG06zmWew0z7IU1ymdvIUeuWiEtk4Ev/58ob7M+xGKIXl2wGHFEDMYYy01oZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay8sAmHw; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-43479d86958so9607285ab.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 05:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764334822; x=1764939622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFVzoZiwIX/orU71QhnED0qFZ9kumMRQnrX2//SwexM=;
        b=ay8sAmHwc0ywzniyPAGfxAdzB2/4Lj0N/Yoae7twayDwvOfrgBMQ19N8juDndqcUPK
         VzuvoVvvx1E5K/tNOSmm9MV3v7JThi+qnu2A4Y71LlPwsi8Q9/y473Bu9i8HsC5vbhYT
         JoPQ02YgtvLQWI4/ncI6UAq9pfpyCHMGwXqwpeSMUhlqmVyoWB6PwYQA2pxAhm7U0q2N
         PV/OeQ8/tpdr8wUvUpbexMKfKXnGwOzI3eK95ARMtAj8FsL6U3Af+yL7HsA0Kmso2Tef
         uaKcHGEdhW6xVz4uNwdt0SKgxj1CbUTu7WD3R3wJSVrwpo2qEVFeh/yZRYvBls+O4pGZ
         cyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334822; x=1764939622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFVzoZiwIX/orU71QhnED0qFZ9kumMRQnrX2//SwexM=;
        b=Ns2fvC0UHvoMS2xuxczP0d667GQ3c5URT50nPInRYTZqiuy/o+kCncfz5dSaRjMh9i
         tZ3tb1/mWQjSlJS3ajfRokahB3u0FN4y5xLIWRz4d0aszuaaMWHX5Kd3qXsFarBhWBHZ
         tg9uHrgUUwcXrK5kBAYnq3DBmKWMWMjFkdpI+m7UcTPxgsYbEBJtUzSKrQroYRAoAfQU
         D1oLKV6N3/06kvaw+hTBb56104IR3kbtd1xfh4G7xOsoLZfxdaFMygWdNhh51/ylY+ML
         AHzaW3WR/K4Mw9EsgUr/9Ua2zIHvhuCHiGchQJ0x7dvHJdXOKH+XJQCgJfDApz7f9eM0
         1zMw==
X-Forwarded-Encrypted: i=1; AJvYcCXavLwVtdjqzld7l4yBGCvnLg6xe8uLDO7OEDWatbu6BEzdefcl53Y7KCHLDDN9j6d5DLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2oqFAspQsT4PueP+aAXYpaWME4SrhU0AJ/YUh4nsA6sUdB6K
	tdRCl6W1zoMhvuzjCBphv3C5pybmNSKAHTzgfgt9SZ8/FxPFSvLwGMy8iMWPOy3nKY6ofHrookx
	9p86xVtPYJ+2V4LwlD4ieF5QjVXI+8vc=
X-Gm-Gg: ASbGncv9QjU2UGmkPp2Zfel2h+2i8OztdrvN0NuQgYGoPXuan6AoR0bUteswQQAZGbx
	Ml2rvTxA9fx5lZTBNfLY2cGry1JCwcHQHr+7Vn6PZLR9Utz6IwKxUw73DYgE7f1ws4cfA7Hl0Qs
	zptaBpKKW8wfVjCPQ7tDn3zM+yDKb/dZGjfLSUY2fKeG6Kp5F4MGAs6YMA03vNmTKfN8gOViJmP
	naGXRhrxGycz7k91iCy2mtdDjutiQKCYRzKoXoKy5yRVCU7We/tZmvGSpuZn+YgL1+/Z78=
X-Google-Smtp-Source: AGHT+IEeUIj9qmHb10pZeY1liejqFTogBJEDZyyydjuRFbwwca32Cto899dU+724a0Db4TqqO2ydWouLhKL1T63sngU=
X-Received: by 2002:a05:6e02:19c5:b0:435:bd03:22a0 with SMTP id
 e9e14a558f8ab-435dd110c32mr102433265ab.35.1764334822289; Fri, 28 Nov 2025
 05:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125115754.46793-1-kerneljasonxing@gmail.com>
 <b859fd65-d7bb-45bf-b7f8-e6701c418c1f@redhat.com> <CAL+tcoDdntkJ8SFaqjPvkJoCDwiitqsCNeFUq7CYa_fajPQL4A@mail.gmail.com>
 <f8d6dbe0-b213-4990-a8af-2f95d25d21be@redhat.com> <CAL+tcoAY5uaYRC2EyMQTn+Hjb62KKD1DRyymW+M27BT=n+MUOw@mail.gmail.com>
 <66f0659a-c7f1-4ebd-8f75-98e053c9f390@redhat.com>
In-Reply-To: <66f0659a-c7f1-4ebd-8f75-98e053c9f390@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 28 Nov 2025 20:59:44 +0800
X-Gm-Features: AWmQ_bkQE58NgGjKwxOgpu-29fPjLuW72AC1nPSRC8d-IO8gefPz0599UwTF30g
Message-ID: <CAL+tcoAExWe1+Mj8Sg+XxaROJo+Z8ub=74MCturUNfRSSZojgg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] xsk: skip validating skb list in xmit path
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 4:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/28/25 2:44 AM, Jason Xing wrote:
> > On Fri, Nov 28, 2025 at 1:58=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 11/27/25 1:49 PM, Jason Xing wrote:
> >>> On Thu, Nov 27, 2025 at 8:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>> On 11/25/25 12:57 PM, Jason Xing wrote:
> >>>>> This patch also removes total ~4% consumption which can be observed
> >>>>> by perf:
> >>>>> |--2.97%--validate_xmit_skb
> >>>>> |          |
> >>>>> |           --1.76%--netif_skb_features
> >>>>> |                     |
> >>>>> |                      --0.65%--skb_network_protocol
> >>>>> |
> >>>>> |--1.06%--validate_xmit_xfrm
> >>>>>
> >>>>> The above result has been verfied on different NICs, like I40E. I
> >>>>> managed to see the number is going up by 4%.
> >>>>
> >>>> I must admit this delta is surprising, and does not fit my experienc=
e in
> >>>> slightly different scenarios with the plain UDP TX path.
> >>>
> >>> My take is that when the path is extremely hot, even the mathematics
> >>> calculation could cause unexpected overhead. You can see the pps is
> >>> now over 2,000,000. The reason why I say this is because I've done a
> >>> few similar tests to verify this thought.
> >>
> >> Uhm... 2M is not that huge. Prior to the H/W vulnerability fallout
> >> (spectre and friends) reasonable good H/W (2016 old) could do ~2Mpps
> >> with a single plain UDP socket.
> >
> > Interesting number that I'm not aware of. Thanks.
> >
> > But for now it's really hard for xsk (in copy mode) to reach over 2M
> > pps even with some recent optimizations applied. I wonder how you test
> > UDP? Could you share the benchmark here?
> >
> > IMHO, xsk should not be slower than a plain UDP socket. So I think it
> > should be a huge room for xsk to improve...
>
> I can agree with that. Do you have baseline UDP figures for your H/W?

No, sorry. So I'm going to figure out how to test like xdpsock. I
think netperf/iperf should be fine?

>
> >> Also validate_xmit_xfrm() should be basically a no-op, possibly some b=
ad
> >> luck with icache?
> >
> > Maybe. I strongly feel that I need to work on the layout of those struc=
tures.
> >>
> >> Could you please try the attached patch instead?
> >
> > Yep, and I didn't manage to see any improvement.
>
> That is unexpected. At very least that 1% due to validate_xmit_xfrm()

Ah, I finally realize why you asked xfrm. The perf graph I provided in
the log was generated on my VM a few months ago and the test that I
did today is running on the physical server. There is one common thing
on both setups that is validate_xmit_skb() introducing additional
overhead.

> should go away. Could you please share the exact perf command line you
> are using? Sometimes I see weird artifacts in perf reports that go away
> adding the ":ppp" modifier on the command line, i.e.:
>
> perf record -ag cycles:ppp <workload>

I will try this one :)

>
> >> I think you still need to call validate_xmit_skb()
> >
> > I can simplify the whole logic as much as possible that is only
> > suitable for xsk: only keeping the linear check. That is the only
> > place that xsk could run into.
> What about checksum offload? If I read correctly xsk could build
> CSUM_PARTIAL skbs, and they will need skb_csum_hwoffload_help().

Thanks for your reminder. What you said pushed me again to go through
all the details as much as I can. Apparently I missed the
xsk_skb_metadata() function as I never used it before.

>
> Generally speaking if validate_xmit_skb() takes a relevant slice of time
> for frequently generated traffic, I guess we should try to optimize it.

I agree on this since I can definitely see the overhead through
perf[1] on every machine I own.

[1] perf record -g -p <pid> -- sleep 10

>
> @Eric: if you have the data handy, do you see validate_xmit_skb() as a
> relevant cost in your UDP xmit tests?
>
> Thanks,
>
> Paolo
>

