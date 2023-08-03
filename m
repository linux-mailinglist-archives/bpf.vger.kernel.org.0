Return-Path: <bpf+bounces-6882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97476EF85
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFCF1C21665
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFA02592D;
	Thu,  3 Aug 2023 16:32:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC218B0A
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 16:32:54 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB8E1713
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 09:32:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-563e21a6011so763034a12.0
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691080372; x=1691685172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYYdr/1So7112CLMqwU1LIAwaDshgf8gao4QKvTkcRo=;
        b=M+ZKqYU8fXEel9JjCi2XZLWMGoWnIK/qOCrJvERH7Q/SxLUJQd0CB2YUBa7SxDVrXw
         SiBxtQ4Q5bEINOPwKrPOtjmL65gdGKMnYHSASNj31HsGY+xvFVdOLglYLW0rzSsjgqNX
         AeQDJSTuvXPi6/Sr70bXpDqS/nLz4QZWSrKfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080372; x=1691685172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYYdr/1So7112CLMqwU1LIAwaDshgf8gao4QKvTkcRo=;
        b=IdaOZqYwxul2GB6AdlKsNx0HOxx+6mlgPPYk6qLplme3f0RUpY9QjNIlUn7GeRXX0s
         6zuG1Uu7n8MgURzLYqiKq6kiUES3fBq7nNwediQ7Ukv6fq554Ey/pR3wAXjzqUijYX1r
         1dftE1qNrin27jzBDtYI/9vrjJVWhKhMyiIYDaPgXWu63AuLVUPczR0VbXRK9vgJHb7G
         MEswa3VvREhTwrTCGYW0N24jFUHzX0fYOVqZRp8yGSS+Gn/PDyWKB4fFPtmONFfXHQZn
         P+IROz8GDGZajUMaryv35QSjDKAcxNtcLUW9W9TOwdt8S7tIM3ud8dMcwxs8NTpnFNGN
         w30g==
X-Gm-Message-State: ABy/qLZU9z56E7it+GzEZ64aB/YpRBrhxuWXTc6xf5gDY5c2d1dVfHH7
	cs6rkkmmvGTYQE6TXChHCk5UdDxYVWvTGVVcbZ62Sg==
X-Google-Smtp-Source: APBJJlEQinzR/ZwMkC8+PIX0jJqMJbe4ONAXQnmB+TG480giwzrr/DGf1KUR3Ju0EQ7Q/fBoYKbnHmKp0bMB/VzgPs8=
X-Received: by 2002:a17:90a:690f:b0:267:7021:4e3c with SMTP id
 r15-20020a17090a690f00b0026770214e3cmr19045564pjj.8.1691080371817; Thu, 03
 Aug 2023 09:32:51 -0700 (PDT)
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
 <CAADnVQJJHiSZPZFpu1n-oQLEsUptacSzF7FdOKfO6OEoKz-jXg@mail.gmail.com>
 <ZMuLvKRbPfOK0IpN@FVFF77S0Q05N> <CAADnVQJvtLjByy2E6Cy1JO8REiUVtBDSfsLMgN3OvHrDwWOykw@mail.gmail.com>
In-Reply-To: <CAADnVQJvtLjByy2E6Cy1JO8REiUVtBDSfsLMgN3OvHrDwWOykw@mail.gmail.com>
From: Florent Revest <revest@chromium.org>
Date: Thu, 3 Aug 2023 18:32:40 +0200
Message-ID: <CABRcYmLAjezx+awDicxYQkoim6JS1CQ-G_9+tJADudxNe3sutg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, bpf <bpf@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 6:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 3, 2023 at 4:13=E2=80=AFAM Mark Rutland <mark.rutland@arm.com=
> wrote:
> >
> > Hi Alexei,
> >
> > On Wed, Aug 02, 2023 at 02:02:39PM -0700, Alexei Starovoitov wrote:
> > > Mark, Catalin, Florent, KP,

Maybe you've missed my Acked-by for the series Alexei ?
https://lore.kernel.org/all/CABRcYmLAzhG=3Do2wcBNBtFP34Aj3+eYsEMtMREDT7SqNz=
Bc9-qw@mail.gmail.com/

> > > This patch set was submitted on June 26 !
> >
> > I appreciate this was sent a while ago, but I have been stuck on some u=
rgent
> > bug-fixing for the last few weeks, and my review bandwidth is therfore =
very
> > limited.
> >
> > Given Puranjay had previously told me he was doing this as a side proje=
ct for
> > fun, and given no-one had told me this was urgent, I assumed that this =
wasn't a
> > major blocker and could wait.
> >
> > I should have sent a holding reply to that effect; sorry.
> >
> > The series addresses my original concern. However, in looking at it I t=
hink
> > there may me a wider potential isssue w.r.t. the way instruction memory=
 gets
> > reused, because as writtten today the architecture doesn't seem to have=
 a
> > guarantee on when instruction fetches are completed and therefore when =
it's
> > safe to modify instruction memory. Usually we're saved by TLB maintenan=
ce,
> > which this series avoids by design.

But I must say that this sits firmly outside of my knowledge of the
arm architectural details and I would totally miss this sort of nuance
so this is best handled by arm64 maintainers :)

> > I unfortunately haven't had the time to dig into that, poke our archite=
cts,
> > etc.
> >
> > So how urgent is this?
>
> The performance wins are substantial.
> We'd like to realize them sooner than later.

I've worked with Mark before, I know for a fact that he is dragged in
all directions. Until we figure out a way to clone him we should try
to not burn him out too often... :)

