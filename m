Return-Path: <bpf+bounces-68282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A19B55A85
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 02:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A66A08698
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE91862;
	Sat, 13 Sep 2025 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge9mHX22"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB9632
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722094; cv=none; b=kRg4ja88ySYdvvj1odLfZgncRPwRv4UCRDIXFBI68cb0oAh9haghZQ3Fj1s6hf+4BUD4FAjIJReC0T/OeMXk1YdYQC2Kt2w9FqmAmH+3E3U9GrXb+7DGhUCYSb5zs1hEwNHWCiaaeobmskTBOBC4iuQcHD85H6ctLsw3WqilEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722094; c=relaxed/simple;
	bh=TAjJBaMAFAfZDro+BxkFOfM7s/oG4mlDysD9vCut3SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew0RMxA2B6niHLFWs8/5oaq6lb9OZ75UTh+fpbjflBI/t/sQdxT/tlFOXP46iAwn2YFubuemeNnOgNdlNvGmuk8QRkw3PGcDs8Axqyn3CCKF2b6obaFtqXv2pJpC8cURS0l1HGIzBg1OHPB/cbJ3YbqaS2QGJXGiXsEfp9DXHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge9mHX22; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45decc9e83dso15443805e9.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757722091; x=1758326891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oarCFVaYBfWe/dEymvNS5bjL3XCSyA2+fYOAmVQlg5Q=;
        b=Ge9mHX22gJoJ4jp2vhHgg3JO022ecjaf3taNOXWknT4dA+TRTqH4E+8+qCWe15bUA1
         XKamdpVaP7ZiK6vYGPYjBtQgWsKiW+FbrrMKLc0JPWPCm/6z3rOIKksHmk0ubTBGyFz9
         pHwJH4AxXYBsHdoZEh02jsPD9X7iOnTIg+nbguxcd2eisGJjm+QBdnvNqEBg8jzSVnC7
         MCXYVfHeCz6TtZTPBT3RGIbJROEJIjbZMDx8V59Uux8lvnqqAl++tjh7YDic9mzf0uGf
         W/3/kylQWe9ZGEHgoFX+5Gng8G2IldIe8ZSmdwpP44EVNo/URpEGQLisfx9xJMZzYoKs
         jruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757722091; x=1758326891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oarCFVaYBfWe/dEymvNS5bjL3XCSyA2+fYOAmVQlg5Q=;
        b=SMGb+bdDY6hoKfpDcfTrDAWf0V/k51NQszWAzmskP8O2VzcFxAdv4LAoZyKojQBqPM
         dhAwD7x1EvFg/txUycwHgHYpBg8BHLIVYdJdCFhqs74bYu0pvM5LfNyDs2dk2L6kd3uE
         1jXT3ZqHl4VbRdwenAMhjaU0I4Bp/pI+99WWYR57Rk+p0rkezQM/22t9rMcNjJJKSBBo
         0xg8inA08EGWTXD7AA6u24dvwIah8aYNCMT5sgpi8Hyd4jlE23k44EMIUMuxFFLYxLJ3
         ItoAdJ8eul9rDjcw7t7uf/rwiS8BqpFsw5Ak37RfZQ+ieG9xBi5vdcDSeY7U28wQzjlQ
         ZeYA==
X-Forwarded-Encrypted: i=1; AJvYcCVzXekzviylHARCCN5SL0Lua4LhB0dcz4pcUoMDHvqdBWuddds/tvHkUmoqD7Utqw63msw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDD3n0krCIVEz3hMBCqPdLpxR5LcWCXDZ+d/L69H2Rp0Q+8Fju
	Idu0TRZnhjUKnXwg8qugHyfVOYb7kItEDCdNnkLANlwyib0TFfeuK9XzPRm98ilHcllM5me1IVB
	Wz8+SuUqg1DEHLdeXhu/UuHPYxQnmcZo=
X-Gm-Gg: ASbGncu0N6l/zhOXP331q4baABroxnA2ZxSB9OORY+nfjqIrLDzIcW45i4fuY2j7/lb
	gH1VJdQmLmGIzzwJsaEFPlK4b5d0ANDL1waIvD4xh/ni8E9ZYcQrJip+g8TmrwA5Xi/EeM2nOA6
	fb3BgsonnXmeGxMf7o77eUTAo1Cf0CjQ5pTRzopKl2Lwplr/mMsCNwj43wHlJc7MKVJSzxTo0qN
	/D92+sDiNxouoC1ApKfO/60AB7ypZej3B0e6Q7D/typuGo=
X-Google-Smtp-Source: AGHT+IGs+Xusqht/8VJHegMGPb9jp1iG1FiTVIwbkOnWYvsoVG9viYUph7imP1ifYwIEbTOxvv/ltAkVzWvCpvR4B2o=
X-Received: by 2002:a05:6000:186a:b0:3d8:afc6:e8f8 with SMTP id
 ffacd0b85a97d-3e76579dc26mr4995623f8f.2.1757722090851; Fri, 12 Sep 2025
 17:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com> <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
 <CAADnVQJu-mU-Px0FvHqZdTTP+x8ROTXaqHKSXdeS7Gc4LV9zsQ@mail.gmail.com>
 <shfysi62hb5g7lo44mw4htwxdsdljcp3usu2wvsjpd2a57vvid@tuhj63dixxpn>
 <CAADnVQ+eD7p4i0B9Q2T-OS_n=AqcrrvYZGY57QOOqKEof6SkDQ@mail.gmail.com>
 <lv2tkehyh4pihbczb7ghvbkkl4l75ksdx2xjtxf2r7lgzam76h@ekkrlady2et3>
 <CAADnVQLX_mi9WLygRxwp5PtBFG7L_sqm9sL93ejENWqVO3ar7g@mail.gmail.com> <e7nh3cxyhmlxds4b2ko36gnxbdfclcxu3eae5irvrd2m6qzqoj@gor7vopfe47z>
In-Reply-To: <e7nh3cxyhmlxds4b2ko36gnxbdfclcxu3eae5irvrd2m6qzqoj@gor7vopfe47z>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Sep 2025 17:07:59 -0700
X-Gm-Features: AS18NWCwWrkehvUmDDVjVIsB98WyNlLefJiTWEE2sdpB7_QgIyHcNpFJxwLW6m4
Message-ID: <CAADnVQJuAo5K417ZZ77AA1LM5uZr5O2v1dRrEEue-v39zGVyVw@mail.gmail.com>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 5:02=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Sep 12, 2025 at 02:59:08PM -0700, Alexei Starovoitov wrote:
> > On Fri, Sep 12, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Fri, Sep 12, 2025 at 02:31:47PM -0700, Alexei Starovoitov wrote:
> > > > On Fri, Sep 12, 2025 at 2:29=E2=80=AFPM Shakeel Butt <shakeel.butt@=
linux.dev> wrote:
> > > > >
> > > > > On Fri, Sep 12, 2025 at 02:24:26PM -0700, Alexei Starovoitov wrot=
e:
> > > > > > On Fri, Sep 12, 2025 at 2:03=E2=80=AFPM Suren Baghdasaryan <sur=
enb@google.com> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 12, 2025 at 12:27=E2=80=AFPM Shakeel Butt <shakee=
l.butt@linux.dev> wrote:
> > > > > > > >
> > > > > > > > +Suren, Roman
> > > > > > > >
> > > > > > > > On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoito=
v wrote:
> > > > > > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > > > > >
> > > > > > > > > Since the combination of valid upper bits in slab->obj_ex=
ts with
> > > > > > > > > OBJEXTS_ALLOC_FAIL bit can never happen,
> > > > > > > > > use OBJEXTS_ALLOC_FAIL =3D=3D (1ull << 0) as a magic sent=
inel
> > > > > > > > > instead of (1ull << 2) to free up bit 2.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > > >
> > > > > > > > Are we low on bits that we need to do this or is this good =
to have
> > > > > > > > optimization but not required?
> > > > > > >
> > > > > > > That's a good question. After this change MEMCG_DATA_OBJEXTS =
and
> > > > > > > OBJEXTS_ALLOC_FAIL will have the same value and they are used=
 with the
> > > > > > > same field (page->memcg_data and slab->obj_exts are aliases).=
 Even if
> > > > > > > page_memcg_data_flags can never be used for slab pages I thin=
k
> > > > > > > overlapping these bits is not a good idea and creates additio=
nal
> > > > > > > risks. Unless there is a good reason to do this I would advis=
e against
> > > > > > > it.
> > > > > >
> > > > > > Completely disagree. You both missed the long discussion
> > > > > > during v4. The other alternative was to increase alignment
> > > > > > and waste memory. Saving the bit is obviously cleaner.
> > > > > > The next patch is using the saved bit.
> > > > >
> > > > > I will check out that discussion and it would be good to summariz=
e that
> > > > > in the commit message.
> > > >
> > > > Disgaree. It's not a job of a small commit to summarize all options
> > > > that were discussed on the list. That's what the cover letter is fo=
r
> > > > and there there are links to all previous threads.
> > >
> > > Currently the commit message is only telling what the patch is doing =
and
> > > is missing the 'why' part and I think adding the 'why' part would mak=
e it
> > > better for future readers i.e. less effort to find why this is being
> > > done this way. (Anyways this is just a nit from me)
> >
> > I think 'why' here is obvious. Free the bit to use it later.
> > From time to time people add a sentence like
> > "this bit will be used in the next patch",
> > but I never do this and sometimes remove it from other people's
> > commits, since "in the next patch" is plenty ambiguous and not helpful.
>
> Yes, the part about the freed bit being used in later patch was clear.
> The part about if we really need it was not obvious and if I understand
> the discussion at [1] (relevant text below), it was not required but
> good to have.
> ```
>         > I was going to say "add a new flag to enum objext_flags",
>         > but all lower 3 bits of slab->obj_exts pointer are already in u=
se? oh...
>         >
>         > Maybe need a magic trick to add one more flag,
>         > like always align the size with 16?
>         >
>         > In practice that should not lead to increase in memory consumpt=
ion
>         > anyway because most of the kmalloc-* sizes are already at least
>         > 16 bytes aligned.
>
>         Yes. That's an option, but I think we can do better.
>         OBJEXTS_ALLOC_FAIL doesn't need to consume the bit.
> ```
>
> Anyways no objection from me but Harry had a followup request [2]:
> ```
>         This will work, but it would be helpful to add a comment clarifyi=
ng that
>         when bit 0 is set with valid upper bits, it indicates
>         MEMCG_DATA_OBJEXTS, but when the upper bits are all zero, it indi=
cates
>         OBJEXTS_ALLOC_FAIL.
>
>         When someone looks at the code without checking history it might =
not
>         be obvious at first glance.
> ```
>
> I think the above requested comment would be really useful.

... and that comment was added. pretty much verbatim copy paste
of the above. Don't you see it in the patch?

> Suren is
> fixing the condition of VM_BUG_ON_PAGE() in slab_obj_exts(). With this
> patch, I think, that condition will need to be changed again.

That's orthogonal and I'm not convinced it's correct.
slab_obj_exts() is doing the right thing. afaict.

