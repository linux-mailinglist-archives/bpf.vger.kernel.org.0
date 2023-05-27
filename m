Return-Path: <bpf+bounces-1349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1039F7132BB
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 08:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C751C21163
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 06:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732BC17E3;
	Sat, 27 May 2023 06:00:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70EE15B7
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 06:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6CFC433EF;
	Sat, 27 May 2023 06:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685167241;
	bh=DRJ2hW77KV7JT7D8w0czYcUvJx+zg2reDxwU/Lcd2vg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B1IR0Oslg8BumaIG1ey0DK8MQsKn9Svc6u9nSGqd+yYaqnEcxC0fej570nYslQPCJ
	 Bu7kkyCfKzE9yl02dCSLxDd81wr4zU4cMPOUshH7KySDpi466whp4YysEzytA8u2/z
	 111o0q1APX0V7MEmtvl438sDmWGFLxzfJrbWMWd0iEh61XgwPxxm6XJom9eTAEWFBe
	 8jh0VuxUSBDCF36uuaitgAW0Zt5+jfxw3eqiPqHDp9u/3Im607A0uB1/0afU+bvZ2Z
	 FFOcX4vvRSE/JnIEWuJg0vS1Rkx2m9hJUuH5yxZKH+1rLAYTQDFNYupP1RM9XNavHn
	 W3PceGI2aaJng==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f3a166f8e9so1943798e87.0;
        Fri, 26 May 2023 23:00:41 -0700 (PDT)
X-Gm-Message-State: AC+VfDz7KmRL/XEeDiA1HDaeXum1YhymanjUTTRlXUZKVJEU1/tfYZVc
	YabNddYC8qjPyMLKeO95FiqsyuvEsTvB0nSimXY=
X-Google-Smtp-Source: ACHHUZ5IJ5iKKq+6GZyV9H/ii1wa72DxNHq11zIEOqAj+5ZY1Wkusw+vOQNvMxeaGVHJcfI/q1OTj9HBZdsRWnqlRQQ=
X-Received: by 2002:a05:6512:3e1b:b0:4f4:f4fe:1797 with SMTP id
 i27-20020a0565123e1b00b004f4f4fe1797mr24520lfv.0.1685167239554; Fri, 26 May
 2023 23:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230526051529.3387103-1-song@kernel.org> <20230526051529.3387103-2-song@kernel.org>
 <ZHEy5SkFwI+dZjOC@moria.home.lan> <CAPhsuW5nbXozvBs1X7q_u=eTY0U=Ep32n1bM8bxR6h9UEU3AxQ@mail.gmail.com>
 <ZHFDO/95KMXRdOWI@moria.home.lan> <CAPhsuW5CTANR_B57w5n3HvdDjvHXOCSGTDc=a4s+JR0pKCAOcw@mail.gmail.com>
 <ZHF21CSxyjQy9C7F@moria.home.lan>
In-Reply-To: <ZHF21CSxyjQy9C7F@moria.home.lan>
From: Song Liu <song@kernel.org>
Date: Fri, 26 May 2023 23:00:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5dx_A_brhf0HHWMWj3HB_31QCQ8xbqZPir8YxHM5WRig@mail.gmail.com>
Message-ID: <CAPhsuW5dx_A_brhf0HHWMWj3HB_31QCQ8xbqZPir8YxHM5WRig@mail.gmail.com>
Subject: Re: [PATCH 1/3] module: Introduce module_alloc_type
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mcgrof@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, x86@kernel.org, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 8:20=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
[...]
> > > void jitalloc_update(void *dst, void *src, size_t len)
> > > {
> > >         if (text_poke_available) {
> > >                 text_poke(...);
> > >         } else {
> > >                 unprotect();
> > >                 memcpy();
> > >                 protect();
> > >         }
> > > }
> >
> > I think this doesn't work for sub page allocation?
>
> Perhaps I elided too much - it does if you add a single lock. You can't
> do that if it's not a common helper.

Actually, sub page allocation is not the problem. The problem is
with unprotect() and protect(), as they require global TLB flush.

>
> > At the end of all this, we will have modules running from huge pages, d=
ata
> > and text. It will give significant performance benefit when some key dr=
iver
> > cannot be compiled into the kernel.
>
> Yeah, I've seen the numbers for the perf impact of running as a module
> due to the extra TLB overhead - but Mike's recent data was showing that
> this doesn't matter nearly as much as data as it does for text.
>
> > > Also - module_memory_fill_type(), module_memory_invalidate_type() - I
> > > know these are for BPF, but could you explain why we need them in the
> > > external interface here? Could they perhaps be small helpers in the b=
pf
> > > code that use something like jitalloc_update()?
> >
> > These are used by all users, not just BPF. 1/3 uses them in
> > kernel/module/main.c. I didn't use them in 3/3 as it is arch code, but =
I can
> > use them instead of text_poke_* (and that is probably better code style=
).
> > As I am writing the email, I think I should use it in ftrace.c (2/3) to=
 avoid
> > the __weak function.
>
> Ok. Could we make it clearer why they're needed and what they're for?
>
> I know bpf fills in invalid instructions initially; I didn't read
> through enough code to find the "why", and let's document that to save
> other people the same effort.
>
> And do they really need to be callbacks in mod_alloc_params...?

If we want to call them from common code, they will either be callback
or some __weak functions.

>
> Do we need the other things in mod_alloc_params/vmalloc_params?
>  - your granularity field says it's for specifying PAGE/PMD size: we
>    definitely do not want that. We've had way too much code along the
>    lines of "implement hugepages for x", we need to stop doing that.
>    It's an internal mm/ detail.

We don't need "granularity" yet. We will need them with the binpack
allocator.

>  - vmalloc_params: we need gfp_t and pgprot_t, but those should be
>    normal arguments. start/end/vm_flags? They seem like historical
>    module baggage, can we get rid of them?

All these fields are needed by some of the module_alloc()s for different
archs. I am not an expert of all the archs, so I cannot say whether some
of them are not needed.
[...]
> > I don't really think module code is very messy at the moment. If
> > necessary, we can put module_alloc_type related code in a
> > separate file.
>
> Hey, it's been organized since I last looked at it :) But I tihink this
> belongs in mm/, not module code.

I don't have a strong preference for this (at the moment). If we agree
it belongs to mm/, we sure can move it.

Thanks,
Song

