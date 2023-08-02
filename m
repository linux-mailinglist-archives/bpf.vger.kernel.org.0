Return-Path: <bpf+bounces-6753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733FE76D91C
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 23:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F50281D7B
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1BE11C90;
	Wed,  2 Aug 2023 21:02:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F99D2E8
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 21:02:53 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA1BE57;
	Wed,  2 Aug 2023 14:02:52 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9c0391749so4008221fa.0;
        Wed, 02 Aug 2023 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691010170; x=1691614970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyKdssS3O4EjoRoatGN7f1gu01LsifXS0W03mQDshAY=;
        b=ap4MO4ZCYH1F8BdhG5nduO3I27RUIorgHhXVGC8KpVpUYxSkEJN2fwRGQb++NwLeBp
         SOBsR7zhGOTHbf0vz/oElrZsDLcNppOY38P6iz6NTwOUKIp5F/aFOIfxpytTEHflN2QQ
         603aUJK6xVQRhXarrIZTl0pQPiXy4bVngod8FYlYaoDEro+EEwJwB8IOZG171LIcVh/O
         7/OE2N2rzGXpCJrs4kc8RAuYGcSFfbQeQALH4pECRat/r3AAERr9ETXAHUPCQrI7XyWT
         XPNJ1YI2qGY0GxuDWM89lpVQ8R00RLzRj6m57vwkvjhrHjqXvH96HKef9G1jlulWYHuP
         HZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691010170; x=1691614970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyKdssS3O4EjoRoatGN7f1gu01LsifXS0W03mQDshAY=;
        b=mApOv9fPjuBtaeB5i9wVwiVW5MMgOktLf7ak368JaYlrUXJfDzgVcqU/AcXWebnQW5
         8VTmVF2E9pY25v2lK19C69Yoqx27j2i24xdtE74XR681dkR30sBBM87RpywXfgLhBOmK
         bsyoAj5MGjmXxM8cZjiMTtSo9k2FKtFNWzGZPbm0FSEyc2CAHbmym8R7L7JIT9TY50kV
         1XYC6VnIgw3IJSh0EC6i/21pfovM1abxDNFUZuDJP0EU61DpecvGMyXa7BxKl7w0+za5
         hqF/bkyyP9LIaPc5l1zI9cDSkIWtLQX9ZaSrVCRhpjTRlO5VTlWMT+Qv2mRdzUYz3jVt
         iDEw==
X-Gm-Message-State: ABy/qLZ75NfZLwpzjrSo2VJvXD11jvmOJGD9QdkztwNmYMeFfaOmhBkB
	AJ+yPRoL2/+byf+bB/Rb4gg9BDrY9jzCm5xBQmM=
X-Google-Smtp-Source: APBJJlGXV1RF7XwlUTO+8xiygghiya9fKskN4rXSWgydfN37JEVYAtvDvZqxigGx22sGEFuFsiJgZcEcHlgoxkvM6YI=
X-Received: by 2002:a2e:9b09:0:b0:2b9:b9c8:99 with SMTP id u9-20020a2e9b09000000b002b9b9c80099mr6122338lji.22.1691010170211;
 Wed, 02 Aug 2023 14:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net> <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
 <CANk7y0gTXPBj5U-vFK0cEvVe83tP1FqyD=MuLXT_amWO=EssOA@mail.gmail.com> <CANk7y0hRYzpsYoqcU1tHyZThAgg-cx46C4-n2JYZTa7sDwEk-w@mail.gmail.com>
In-Reply-To: <CANk7y0hRYzpsYoqcU1tHyZThAgg-cx46C4-n2JYZTa7sDwEk-w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Aug 2023 14:02:39 -0700
Message-ID: <CAADnVQJJHiSZPZFpu1n-oQLEsUptacSzF7FdOKfO6OEoKz-jXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To: Puranjay Mohan <puranjay12@gmail.com>, Florent Revest <revest@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
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

On Sun, Jul 30, 2023 at 10:22=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> Hi Mark,
> I am really looking forward to your feedback on this series.
>
> On Mon, Jul 17, 2023 at 9:50=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > Hi Mark,
> >
> > On Mon, Jul 3, 2023 at 7:15=E2=80=AFPM Mark Rutland <mark.rutland@arm.c=
om> wrote:
> > >
> > > On Mon, Jul 03, 2023 at 06:40:21PM +0200, Daniel Borkmann wrote:
> > > > Hi Mark,
> > >
> > > Hi Daniel,
> > >
> > > > On 6/26/23 10:58 AM, Puranjay Mohan wrote:
> > > > > BPF programs currently consume a page each on ARM64. For systems =
with many BPF
> > > > > programs, this adds significant pressure to instruction TLB. High=
 iTLB pressure
> > > > > usually causes slow down for the whole system.
> > > > >
> > > > > Song Liu introduced the BPF prog pack allocator[1] to mitigate th=
e above issue.
> > > > > It packs multiple BPF programs into a single huge page. It is cur=
rently only
> > > > > enabled for the x86_64 BPF JIT.
> > > > >
> > > > > This patch series enables the BPF prog pack allocator for the ARM=
64 BPF JIT.
> > >
> > > > If you get a chance to take another look at the v4 changes from Pur=
anjay and
> > > > in case they look good to you reply with an Ack, that would be grea=
t.
> > >
> > > Sure -- this is on my queue of things to look at; it might just take =
me a few
> > > days to get the time to give this a proper look.
> > >
> > > Thanks,
> > > Mark.
> >
> > I am eagerly looking forward to your feedback on this series.

Mark, Catalin, Florent, KP,

This patch set was submitted on June 26 !
It's not acceptable to delay review for so long.
Please review asap.

