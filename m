Return-Path: <bpf+bounces-7020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B377041D
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624EA1C218BB
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EC15ACC;
	Fri,  4 Aug 2023 15:11:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F363CA6E
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 15:11:42 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D349E6;
	Fri,  4 Aug 2023 08:11:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so36639401fa.2;
        Fri, 04 Aug 2023 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691161897; x=1691766697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/x2HU6+MV/IqQjm0ooiMjVQBEg/IdxB1FJC8ElSTtiQ=;
        b=TEULtEHQBd3bVfKkrwwfcAPuYfhGwt/bgqLMENdx4P9MRoTicS2EO8P2u5uINRulH2
         I66yg992gWDo/eOWaA+DcANuDhavotStbDoLFsz7dueS0OuOdpY9mbgYpuWAEmhd5m28
         vctyq02R31BzEf/Tt2hUBNLHogdX01iO3cDkDDjPLQFUtuPgYCSQaOFyOWxj8c5PGrG3
         U8VRr+5kmZ3cXMVHTsTdfYg1TNmgrbDb/S3p2U7bHbXAElJIc4THO8/I7XwKsMMn4eXz
         XOY5kYHy6dxrTI4BtmDt5hkvskSXHkaBu0NTtQ5CeBiUxzhYlayTtio/cxBYdZrLPV11
         y2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691161897; x=1691766697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/x2HU6+MV/IqQjm0ooiMjVQBEg/IdxB1FJC8ElSTtiQ=;
        b=g6e6ulHAnKwW7fbcSaaWsIU27VQ44uqMVEwwQxs3oD2fRmD3oQxavQhhNx+90P1z6G
         wLf0qs9vasZdkaIuHeCOAMpimp1urT2bmHhtFT1zkeiYT5SMBxQBp/mGg9K0753pNGR4
         2cwK74J/n3C0ckbA96QwBu85isnb9plvqgprHd+kkNhArtndhskOSjrQ4lQZ7JEIJZKt
         /hPU4AB+VSw035fOiBTNMTu6ABu6hLDBsE4WVettn9kYMx3nBYj3NZM9zx+CpeFq91lt
         wT/zvVmipWNkjLSAQadKyvW7QGBHaOW+G4jMKnnY9b0mBdErSiljd5H/HxCNyya/GwAz
         k8dQ==
X-Gm-Message-State: AOJu0YxaTaPOc1SRajaW2+oIvdEXguXKs5or2E19hy22YOo3XCfcqQBx
	kU4pVcqTRnpsx1dU8vzlZMnhpLAmCgGsAWraYPY=
X-Google-Smtp-Source: AGHT+IH3SCHrWsUBZdKSKq6MVfreO1tH8EoTPZVb+Od34GLVwq7o3dz+yk67Is/qO+1iwG7vxLqDyEZyepsRRtoU51M=
X-Received: by 2002:a2e:9d86:0:b0:2b7:339c:f791 with SMTP id
 c6-20020a2e9d86000000b002b7339cf791mr1751152ljj.25.1691161896946; Fri, 04 Aug
 2023 08:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net> <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
 <CANk7y0gTXPBj5U-vFK0cEvVe83tP1FqyD=MuLXT_amWO=EssOA@mail.gmail.com>
 <CANk7y0hRYzpsYoqcU1tHyZThAgg-cx46C4-n2JYZTa7sDwEk-w@mail.gmail.com>
 <CAADnVQJJHiSZPZFpu1n-oQLEsUptacSzF7FdOKfO6OEoKz-jXg@mail.gmail.com> <ZMuLvKRbPfOK0IpN@FVFF77S0Q05N>
In-Reply-To: <ZMuLvKRbPfOK0IpN@FVFF77S0Q05N>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 4 Aug 2023 17:11:25 +0200
Message-ID: <CANk7y0hQcuabELOH-QHiqNAJhuCZYeWim7AJ125zS7_GnKwcGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, bpf <bpf@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Mark,

On Thu, Aug 3, 2023 at 1:13=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> Hi Alexei,
>
> On Wed, Aug 02, 2023 at 02:02:39PM -0700, Alexei Starovoitov wrote:
> > On Sun, Jul 30, 2023 at 10:22=E2=80=AFAM Puranjay Mohan <puranjay12@gma=
il.com> wrote:
> > >
> > > Hi Mark,
> > > I am really looking forward to your feedback on this series.
> > >
> > > On Mon, Jul 17, 2023 at 9:50=E2=80=AFAM Puranjay Mohan <puranjay12@gm=
ail.com> wrote:
> > > >
> > > > Hi Mark,
> > > >
> > > > On Mon, Jul 3, 2023 at 7:15=E2=80=AFPM Mark Rutland <mark.rutland@a=
rm.com> wrote:
> > > > >
> > > > > On Mon, Jul 03, 2023 at 06:40:21PM +0200, Daniel Borkmann wrote:
> > > > > > Hi Mark,
> > > > >
> > > > > Hi Daniel,
> > > > >
> > > > > > On 6/26/23 10:58 AM, Puranjay Mohan wrote:
> > > > > > > BPF programs currently consume a page each on ARM64. For syst=
ems with many BPF
> > > > > > > programs, this adds significant pressure to instruction TLB. =
High iTLB pressure
> > > > > > > usually causes slow down for the whole system.
> > > > > > >
> > > > > > > Song Liu introduced the BPF prog pack allocator[1] to mitigat=
e the above issue.
> > > > > > > It packs multiple BPF programs into a single huge page. It is=
 currently only
> > > > > > > enabled for the x86_64 BPF JIT.
> > > > > > >
> > > > > > > This patch series enables the BPF prog pack allocator for the=
 ARM64 BPF JIT.
> > > > >
> > > > > > If you get a chance to take another look at the v4 changes from=
 Puranjay and
> > > > > > in case they look good to you reply with an Ack, that would be =
great.
> > > > >
> > > > > Sure -- this is on my queue of things to look at; it might just t=
ake me a few
> > > > > days to get the time to give this a proper look.
> > > > >
> > > > > Thanks,
> > > > > Mark.
> > > >
> > > > I am eagerly looking forward to your feedback on this series.
> >
> > Mark, Catalin, Florent, KP,
> >
> > This patch set was submitted on June 26 !
>
> I appreciate this was sent a while ago, but I have been stuck on some urg=
ent
> bug-fixing for the last few weeks, and my review bandwidth is therfore ve=
ry
> limited.
>
> Given Puranjay had previously told me he was doing this as a side project=
 for
> fun, and given no-one had told me this was urgent, I assumed that this wa=
sn't a
> major blocker and could wait.

Yes, I am just doing it as a side project for fun. It is not a major blocke=
r.

>
> I should have sent a holding reply to that effect; sorry.
>
> The series addresses my original concern. However, in looking at it I thi=
nk
> there may me a wider potential isssue w.r.t. the way instruction memory g=
ets
> reused, because as writtten today the architecture doesn't seem to have a
> guarantee on when instruction fetches are completed and therefore when it=
's
> safe to modify instruction memory. Usually we're saved by TLB maintenance=
,
> which this series avoids by design.
>
> I unfortunately haven't had the time to dig into that, poke our architect=
s,
> etc.
>
> So how urgent is this?

This is not urgent as this is not a blocker for anything.

I just wanted to know if there was something pending from my side.

Please review it whenever you have spare time. Thanks for helping me debug =
the
issue with the cache maintenance.

Thanks,
Puranjay

