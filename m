Return-Path: <bpf+bounces-68272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC0FB558B0
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 23:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE6E7BB269
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696772C0281;
	Fri, 12 Sep 2025 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW2idmlC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD9221264
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757714364; cv=none; b=D+ClusHZaWuRNhe72oIRQOxdPrwgB7NbAAFK3umbZ40h8S/jZBhxMIq8HkF61MJvqPBU901EHPv2JRJfNL+Tj0ZdGu1B7D8dbieTm5pT8dm9TvA1ja1XI97Qc8xTZvo6ZVSLqGHZvnmhkEclYvoHKyV+Wpb9msk6lLrSbvqEwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757714364; c=relaxed/simple;
	bh=NZFaD5oyiRAoOLBuEZcvlYJuqNMd+CQKfb8R9bWF8Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzQKk9doG6GnVWvLwa/4Eg8+QFbHT4s9fWXgOtEzW7qLzTT9RYRL2W+t8DkcBC1wcVB/D6tsgACnaq58T2OAhMB/js+CBFV5uyFb+xspJng87Ct98mxWsMlLOKRZrulr5TiGcEDyD9/3UrVwsoqqzdMLIVncaVdV8V1C2GJ2a6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW2idmlC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so21742475e9.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757714359; x=1758319159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZFaD5oyiRAoOLBuEZcvlYJuqNMd+CQKfb8R9bWF8Eg=;
        b=hW2idmlCRX26oUV3wXdDvTKAbBejpnbShw9idjRIso3H/xKw/kgqOK9xKWuIrFAVn0
         kb6wV2diU4Io1o3Ko0G5ksIwzHyDT9FVsZUpJj2BBVFhhl56+7C6jL6s1HvuMIPBdl5X
         kYo48Z0AvqGkjnccaUfQvwqFzaXGNo+Zg+GcRfbl6bqynKxVFgypmKZXSXJqcCE6l3u4
         3yZnmz4CYU59gtWIszn/U0pK1t33u95D9edNEpBayAypo0uwRrhtmMIXKcmItfj9Ate5
         8Y4jq692jOIbe3DXOVVBHbN0yWQRtnPoVClBu0K88Q4Lyrth0S71gLVIxq+sVRJyQc7E
         C1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757714359; x=1758319159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZFaD5oyiRAoOLBuEZcvlYJuqNMd+CQKfb8R9bWF8Eg=;
        b=hIUFn+i/D2xfeBMtwVgXB/1PFvTf4u6gxZXDW9TpeKH8llRIDygDsrEj+qKx6utbc1
         Qgw5cczHZJQMHZksEZ98c1ptvmSTAHnWUa/blc4no0CGbMI3Sv+2v29Rc6b6lZ31fu30
         5x2fps8/JpcOsWy0qVzWyqinZeD7T3nX2piEDI2j9cu6ZyT9pr80nD+z4ZGd2krtO/2p
         Q+4qfIHTcY4FZHniH7VsqRuHgknj9+vZmj9ZDVQ+DANmpech/eo7o/JcZ/XEzDRNai/p
         lKQBX2HzvMVoWcFtYIL4bTeHwVY6wYWGqVZaU/VgHyd632MfnKmYJ8qfrc/GYw2tzFqL
         zTow==
X-Forwarded-Encrypted: i=1; AJvYcCUWMb2CH8b/euWbS+kG8Haro2rAv+A1C6dyFi+cvIIw9tKJn3ch43d5VOhGPmklsdXl9I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkmIPjNFfmq+Mls3cWQOQKD/Ai1LlIuPsGIsjA3CbdBlObMmqU
	XQWKj5rUFePClt2aRS6UQ3bj0Qoo5/PRJMWg3fH2q2atn2BgZbVva+R4xNcNmc5HHOay41t5fqU
	+kBL1UfZb3asYmlwGr+3uph+ncUrxerU=
X-Gm-Gg: ASbGncvJeqZjQz/1hiZPppfEYpfhKYLy59SNIP/NDHmfM0bqM1IQQvpKhnAsBHUlVSD
	Ghjc98BUY5hdC8dbuPiE3c2pYUC8cahoLBgwV1DPw6nm8+BtHWWVtFMsKj0IJXljgkwaDTPeThY
	e4gvwl4gI6LQijDdhhNmUho2orCoJUPigiGswCCexjvz+fY9Bd6Frhb6pE9ZqBeHoxy8BYCayz/
	qCWRj11mNRIVL2LB+qA/25YRa9igxzqS/vtH1o0JlHp33o=
X-Google-Smtp-Source: AGHT+IEj5hCxNC661gWndefrK0QFWrEBg3qrCVagAwTeaWebQwq+mCJEkQC4fnaq2I7BeFFFGHNJ6BjP9R+zaCJ8vC4=
X-Received: by 2002:a05:600c:1f13:b0:45d:d79c:7503 with SMTP id
 5b1f17b1804b1-45f2128cc58mr44251025e9.12.1757714359396; Fri, 12 Sep 2025
 14:59:19 -0700 (PDT)
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
 <CAADnVQ+eD7p4i0B9Q2T-OS_n=AqcrrvYZGY57QOOqKEof6SkDQ@mail.gmail.com> <lv2tkehyh4pihbczb7ghvbkkl4l75ksdx2xjtxf2r7lgzam76h@ekkrlady2et3>
In-Reply-To: <lv2tkehyh4pihbczb7ghvbkkl4l75ksdx2xjtxf2r7lgzam76h@ekkrlady2et3>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Sep 2025 14:59:08 -0700
X-Gm-Features: AS18NWB0F8pNvh3GzUKMDxADrrXIaRl6ltZK30yA_21OC0u6XClr7XbCRoVpX0s
Message-ID: <CAADnVQLX_mi9WLygRxwp5PtBFG7L_sqm9sL93ejENWqVO3ar7g@mail.gmail.com>
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

On Fri, Sep 12, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Sep 12, 2025 at 02:31:47PM -0700, Alexei Starovoitov wrote:
> > On Fri, Sep 12, 2025 at 2:29=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Fri, Sep 12, 2025 at 02:24:26PM -0700, Alexei Starovoitov wrote:
> > > > On Fri, Sep 12, 2025 at 2:03=E2=80=AFPM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > >
> > > > > On Fri, Sep 12, 2025 at 12:27=E2=80=AFPM Shakeel Butt <shakeel.bu=
tt@linux.dev> wrote:
> > > > > >
> > > > > > +Suren, Roman
> > > > > >
> > > > > > On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoitov wr=
ote:
> > > > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > > >
> > > > > > > Since the combination of valid upper bits in slab->obj_exts w=
ith
> > > > > > > OBJEXTS_ALLOC_FAIL bit can never happen,
> > > > > > > use OBJEXTS_ALLOC_FAIL =3D=3D (1ull << 0) as a magic sentinel
> > > > > > > instead of (1ull << 2) to free up bit 2.
> > > > > > >
> > > > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > >
> > > > > > Are we low on bits that we need to do this or is this good to h=
ave
> > > > > > optimization but not required?
> > > > >
> > > > > That's a good question. After this change MEMCG_DATA_OBJEXTS and
> > > > > OBJEXTS_ALLOC_FAIL will have the same value and they are used wit=
h the
> > > > > same field (page->memcg_data and slab->obj_exts are aliases). Eve=
n if
> > > > > page_memcg_data_flags can never be used for slab pages I think
> > > > > overlapping these bits is not a good idea and creates additional
> > > > > risks. Unless there is a good reason to do this I would advise ag=
ainst
> > > > > it.
> > > >
> > > > Completely disagree. You both missed the long discussion
> > > > during v4. The other alternative was to increase alignment
> > > > and waste memory. Saving the bit is obviously cleaner.
> > > > The next patch is using the saved bit.
> > >
> > > I will check out that discussion and it would be good to summarize th=
at
> > > in the commit message.
> >
> > Disgaree. It's not a job of a small commit to summarize all options
> > that were discussed on the list. That's what the cover letter is for
> > and there there are links to all previous threads.
>
> Currently the commit message is only telling what the patch is doing and
> is missing the 'why' part and I think adding the 'why' part would make it
> better for future readers i.e. less effort to find why this is being
> done this way. (Anyways this is just a nit from me)

I think 'why' here is obvious. Free the bit to use it later.
From time to time people add a sentence like
"this bit will be used in the next patch",
but I never do this and sometimes remove it from other people's
commits, since "in the next patch" is plenty ambiguous and not helpful.

