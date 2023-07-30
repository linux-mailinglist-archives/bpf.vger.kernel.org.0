Return-Path: <bpf+bounces-6385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290927686A4
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 19:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09B21C209A6
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0948B134C8;
	Sun, 30 Jul 2023 17:22:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FDDF56
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 17:22:48 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F71102;
	Sun, 30 Jul 2023 10:22:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so37234371fa.2;
        Sun, 30 Jul 2023 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690737765; x=1691342565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAAPafUCJ2pRxW/N+9tfq47Lu1Ww0WCELCCpvql1l10=;
        b=X4ZRseiDdqSGT748A2Sh2ob4JEtxR+TXGzikjntpXqxg/eTWkuN2OpOufJuBisxR+N
         56U//CGBUZ+peAz10Kn4GfCCtgWYI8DvY5Fuw46CW0GDm7/arTaWWYjTxRzqjduX9bdH
         YI+qkVZ9XWCK6CCBiauz3z8US0G1sVuL7Gml0fv49JJTDyiAFHra5pqzj+nwFO1vT7iE
         bew3AtjOmuqAWGGZCnNiSo+kfYRWwwbkjaUM6Q8D/V77ZKt03rkyFVxbhQV5z5qDMdQN
         rvHHOJbWSoq29Pcs2hNPOHKJuOa3t6I2gUdOHHeyiKoGEehOTLo6QYAoQBkFKrVOpwms
         DrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690737765; x=1691342565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAAPafUCJ2pRxW/N+9tfq47Lu1Ww0WCELCCpvql1l10=;
        b=kAeEg3xwIqUyu6U6lHLjHWFfuq3+Mn0FmWAzlNnqeihfPQoA7H4lxuqpoUA11q5nMT
         6MD7fS1lFKg59u+SYe82JyfynfFVHOsYYeJhDsU2swdgzNBV6yCfrrF9JspA4EZFyyZ+
         5nLgoHq0xiYzZ7noWY+Pu6nX16bJStVtNUzBo4K1Uv4csAhA8uUM4hWlvdx5mBmeZ0L8
         SGfwVBAA+e6FdzbTkhrn86QktmWHAXPFVOWI/Pa3+tgBgxhduwRE4483cKxhv7X+XQAr
         XZYMA5G2OhSJDt01DNsdy1EHLvDvrf4xQnJ4p6aRtSj45OcvDPIbyVCnd516RNslQHAd
         asxg==
X-Gm-Message-State: ABy/qLZjn+MRg8YEX3pQCuRO9FXOY9pmDEgR2P0bq8QcDuscBWmzzEdB
	z0CS265XN2eHp2D1EudkNkKhFGoHm+dI5m/VaqI=
X-Google-Smtp-Source: APBJJlHzg61K1OIAwJKyO/9lLNYZJk5c0zWM1z7XNOG2nQScIrV0w8Fo2IT0+SzCZT/XDWrVux3ZdkzbUZH3qwDyJcI=
X-Received: by 2002:a2e:7c0a:0:b0:2b9:cc8e:8729 with SMTP id
 x10-20020a2e7c0a000000b002b9cc8e8729mr4709350ljc.26.1690737765193; Sun, 30
 Jul 2023 10:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net> <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
 <CANk7y0gTXPBj5U-vFK0cEvVe83tP1FqyD=MuLXT_amWO=EssOA@mail.gmail.com>
In-Reply-To: <CANk7y0gTXPBj5U-vFK0cEvVe83tP1FqyD=MuLXT_amWO=EssOA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Sun, 30 Jul 2023 19:22:34 +0200
Message-ID: <CANk7y0hRYzpsYoqcU1tHyZThAgg-cx46C4-n2JYZTa7sDwEk-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Mark,
I am really looking forward to your feedback on this series.

On Mon, Jul 17, 2023 at 9:50=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Hi Mark,
>
> On Mon, Jul 3, 2023 at 7:15=E2=80=AFPM Mark Rutland <mark.rutland@arm.com=
> wrote:
> >
> > On Mon, Jul 03, 2023 at 06:40:21PM +0200, Daniel Borkmann wrote:
> > > Hi Mark,
> >
> > Hi Daniel,
> >
> > > On 6/26/23 10:58 AM, Puranjay Mohan wrote:
> > > > BPF programs currently consume a page each on ARM64. For systems wi=
th many BPF
> > > > programs, this adds significant pressure to instruction TLB. High i=
TLB pressure
> > > > usually causes slow down for the whole system.
> > > >
> > > > Song Liu introduced the BPF prog pack allocator[1] to mitigate the =
above issue.
> > > > It packs multiple BPF programs into a single huge page. It is curre=
ntly only
> > > > enabled for the x86_64 BPF JIT.
> > > >
> > > > This patch series enables the BPF prog pack allocator for the ARM64=
 BPF JIT.
> >
> > > If you get a chance to take another look at the v4 changes from Puran=
jay and
> > > in case they look good to you reply with an Ack, that would be great.
> >
> > Sure -- this is on my queue of things to look at; it might just take me=
 a few
> > days to get the time to give this a proper look.
> >
> > Thanks,
> > Mark.
>
> I am eagerly looking forward to your feedback on this series.
>
> Thanks,
> Puranjay


Thanks,
Puranjay

