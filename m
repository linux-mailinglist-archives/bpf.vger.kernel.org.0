Return-Path: <bpf+bounces-6880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB76376EF3A
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838ED28223C
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E02417D;
	Thu,  3 Aug 2023 16:16:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA34182C8
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 16:16:17 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A73A97;
	Thu,  3 Aug 2023 09:16:11 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so14943321fa.0;
        Thu, 03 Aug 2023 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691079369; x=1691684169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ak2e6qyQw5b5s1FOOu8IqFAFc+5BX1aqKP7dFDqfSkg=;
        b=LWv3jcuFeu+HQkIEQ6J0LW5YNcp1nRfncRfXPIe5WqVTH7k9FCfWBWVQBYfgDt68uC
         /MGOfeXglLZMHClwSpOAHGUEvH0LeD7S5ikJu+WfkHGPPn1uv0jy352Q5TXuDVD0zwfX
         8eix3oqFIqSe2zsj43NMFSZ4eDT9rc4T3mLD6dAQbrrC7KwNz1dWPyDUvkkEMIBuM9iR
         2vngNLtenYn1jzOe1/Wn0U+uAeFQBOskYIpZFxsT1pfAdVD2MyVhMy5Hg7jt1DEFnNPg
         1aC35lNIZcWCtqUq+c8o/2609YnYX/uvLz+MZEyAxOeHRFh/kFujzyle6iv816/KVPKC
         o+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079369; x=1691684169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak2e6qyQw5b5s1FOOu8IqFAFc+5BX1aqKP7dFDqfSkg=;
        b=F+DK427nKUnPWtLyRJDVm3AxLxtiYr2dA2duMLJmRmxyOgObTdTzXgYuP8GNjx7gl2
         hixBbeHzOf29s0/ZX9z8KkYGAog75I+wwc+9EXZoh12eTu0vxQyvQthe4EWjur60DsvO
         1/0hbgxYv6IOuBVQmYWaIDrJPzx3nLGRyMqFIJszcgt1DaSJbRpMZrJhtHOc7r2brYOa
         tz0UZMuTKAOEdmBT8Y4IZ+C2htWlq09vM9yUgqTQHQKvtV2tq4J56LVBL9OhbQfxFUn/
         8w0zT2a19wLwK4ZGLS6oiBAcxdB1zosN845NTCn6C8D3d4Vn9hFpB1LFYuomVTrIuO5y
         lA5Q==
X-Gm-Message-State: ABy/qLZr3yv5QxKxKnIqM/NlcVV1AsnSnZpgrMmcdJaE2LTHk40JkKKm
	bTixJnInUAwcXQdnPduEZfiY7HkfKb665rmOFjY=
X-Google-Smtp-Source: APBJJlFPy5XddgcUkQ8ldIEwz7iLpQjjQrxx2s2OJio36y38yw8a5auP9RBYgm318xZCRkWZUt2Vqp2Wnbgn5gyK2/A=
X-Received: by 2002:a2e:9602:0:b0:2b6:c3f9:b86b with SMTP id
 v2-20020a2e9602000000b002b6c3f9b86bmr3531763ljh.15.1691079368631; Thu, 03 Aug
 2023 09:16:08 -0700 (PDT)
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
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Aug 2023 09:15:57 -0700
Message-ID: <CAADnVQJvtLjByy2E6Cy1JO8REiUVtBDSfsLMgN3OvHrDwWOykw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To: Mark Rutland <mark.rutland@arm.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Florent Revest <revest@chromium.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, bpf <bpf@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 4:13=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
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

The performance wins are substantial.
We'd like to realize them sooner than later.

