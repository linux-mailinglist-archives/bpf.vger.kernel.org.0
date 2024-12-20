Return-Path: <bpf+bounces-47438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6A9F9616
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935AC7A49FF
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F721A428;
	Fri, 20 Dec 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArL/3c6f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945AA219EAB
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711062; cv=none; b=ONAgv8AGcKBDH0ZbrPiQMRM7kkduourLG2qJO1Shb71kIVZdW/ohb/qN2q4oHRq+Fc4Hwou3BJ6HEMfg+2sz79QHS39XahDHZ3LJfXQfGLha981floqYk5przTC091EjF7LlDnHf73+L3xP5DaQ+lbfpt2osyMT8omMyuEs88mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711062; c=relaxed/simple;
	bh=CBrH5ZeEZIrubxW04IGe/2OpySYncMamgt9MdkqiVZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XV6O8Watkd3XabuDcwthzAzGML/rA2P/1AzyHW6bH1/2IyWNPP6/aSlAofO5TcTIF+2X2dZ5d7Oer1wLHU3nHSP4hQuel5KYYgxOCb3w0VGnA0XMP7ovc1Xm6fEwRIA+cp1idpS3QUIHrNW0QsDKiIJC+sjUTmSxxoFDajM98Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArL/3c6f; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38637614567so1074676f8f.3
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734711059; x=1735315859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5ApsFhZd+Y7Oges9Z73UxPFo1bv6HIbsG+URH0gKCk=;
        b=ArL/3c6fpZs6HqiZLqd80eZE/9ktcZNBe8YEdjV3UaXuln6MUcdqGj5+6r6QW62IIa
         glB5jRIk0bYvp9xFSqik6MqlCSvCZKOadClUd+YYcFXIxnD15j/VqRcgvqCeax2P0tLN
         A/X+PRWy0AqbgunIKaRx3DR8UpxP7GqGVeBefy0ZvIhdmI90Ed6AGbWKqwBVcZZ5y5ha
         1Qj5gXZLGTBHZ8p/NxjeJB/k+7gjvD6Hb4YUZ8/khLVtOX7QdvxXA1buWizrtwytWEjs
         YruYaw0WrI0s0hJVkZ2jvciGYRebey27jGfMtw4k0KpBdGpBcnXNomJMkF6dsUiHmLzO
         ew1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711059; x=1735315859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5ApsFhZd+Y7Oges9Z73UxPFo1bv6HIbsG+URH0gKCk=;
        b=Drvk19az7jtOYtsAuxZDMWmxAsKfVhsZY8eWtFXBGtaPzZJInj1M7XBowbwgUpFYbZ
         5+lUI4qH1MrWIud2n6iDv8TS8l3Mg0s6mi2vfUV0rTDJU03plwAV/68LX8Lpa+02T5ss
         d20qGSRDolICx9zfxdYZLt6cdp7CJhvSB1LEeZMGkIx/TdscsylH9BWD3QxdSWH7wv0N
         5aR02hnfnIXY6YDzG3Bd7jLsWPuB3M6PZ7+sqESBYGEh8TjkWPlHkaWspmzyh5E+PYyh
         ALYbCeAwXr/pudOEDaKcLP335TWk/I5MeFjSNTUIpqUmt+O+6gm6RSLX3NLSkERsZP8U
         Si4Q==
X-Gm-Message-State: AOJu0YwE9948tcdXLFoMXaOBcxPzpHeEohJRpRtcl3ty+CDtxE3/TnMK
	EAWcqXHkwuh3mw46hVB3I+tEgMeKPlKTOfov7tJqqGPAVh4ofAqMSiplqbC757Zl4ZVzKVQlfev
	2FiJVS4w6pRMKvZyLdzgIHghP1aY=
X-Gm-Gg: ASbGncvwfPTke070Kt1cb6OXoFcv8KYI7jN9LazjN65hO6PgPQ8R6Zaia/D94mb6OMO
	82RQG+y+1+xHA4RHKq1u223EJpBrQQlHtR5XTHQ==
X-Google-Smtp-Source: AGHT+IGbj7k+HgHOlNNhDTO+5U0mZry/FWsFevnxV7HGtrtVAL96ReRaig6LfPIpw4zjooBXQiHAB5p1guaXtLs4IvE=
X-Received: by 2002:a05:6000:2ad:b0:385:e8f9:e839 with SMTP id
 ffacd0b85a97d-38a224063b2mr3139132f8f.56.1734711058618; Fri, 20 Dec 2024
 08:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-5-alexei.starovoitov@gmail.com> <Z2Ky2idzyPn08JE-@tiehlicka>
 <CAADnVQKv_J-8CdSZsJh3uMz2XFh_g+fHZVGCmq6KTaAkupqi5w@mail.gmail.com>
 <Z2PGetahl-7EcoIi@tiehlicka> <Z2PKyU3hJY5e0DUE@tiehlicka> <Z2PQv8dVNBopIiYN@tiehlicka>
 <CAADnVQLm=gSAh2u3iF4HoGmLEqa-AV0FAEnDqcoFYDgZ06d+gQ@mail.gmail.com> <Z2Up17maf6FHkVu5@tiehlicka>
In-Reply-To: <Z2Up17maf6FHkVu5@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Dec 2024 08:10:47 -0800
Message-ID: <CAADnVQ+t3EF_CDrsYuY4eR87u1YnoSoj2S7fCQS7gi67cdhz0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] memcg: Use trylock to access memcg stock_lock.
To: Michal Hocko <mhocko@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 12:24=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> > +static inline bool gfpflags_allow_spinning(const gfp_t gfp_flags)
> > +{
> > +       /*
> > +        * !__GFP_DIRECT_RECLAIM -> direct claim is not allowed.
> > +        * !__GFP_KSWAPD_RECLAIM -> it's not safe to wake up kswapd.
> > +        * All GFP_* flags including GFP_NOWAIT use one or both flags.
> > +        * try_alloc_pages() is the only API that doesn't specify eithe=
r flag.
>
> I wouldn't be surprised if we had other allocations like that. git grep
> is generally not very helpful as many/most allocations use gfp argument
> of a sort. I would slightly reword this to be more explicit.
>           /*
>            * This is stronger than GFP_NOWAIT or GFP_ATOMIC because
>            * those are guaranteed to never block on a sleeping lock.
>            * Here we are enforcing that the allaaction doesn't ever spin
>            * on any locks (i.e. only trylocks). There is no highlevel
>            * GFP_$FOO flag for this use try_alloc_pages as the
>            * regular page allocator doesn't fully support this
>            * allocation mode.

Makes sense. I like this new wording. Will incorporate.

> > +        */
> > +       return !(gfp_flags & __GFP_RECLAIM);
> > +}
> > +
> >  #ifdef CONFIG_HIGHMEM
> >  #define OPT_ZONE_HIGHMEM ZONE_HIGHMEM
> >  #else
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index f168d223375f..545d345c22de 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1768,7 +1768,7 @@ static bool consume_stock(struct mem_cgroup
> > *memcg, unsigned int nr_pages,
> >                 return ret;
> >
> >         if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > -               if (gfp_mask & __GFP_TRYLOCK)
> > +               if (!gfpflags_allow_spinning(gfp_mask))
> >                         return ret;
> >                 local_lock_irqsave(&memcg_stock.stock_lock, flags);
> >         }
> >
> > If that's acceptable then such an approach will work for
> > my slub.c reentrance changes too.
>
> It certainly is acceptable for me.

Great.

> Do not forget to add another hunk to
> avoid charging the full batch in this case.

Well. It looks like you spotted the existing bug ?

Instead of
+       if (!gfpflags_allow_blockingk(gfp_mask))
+               batch =3D nr_pages;

it should be unconditional:

+               batch =3D nr_pages;

after consume_stock() returns false.

Consider:
        stock_pages =3D READ_ONCE(stock->nr_pages);
        if (memcg =3D=3D READ_ONCE(stock->cached) && stock_pages >=3D nr_pa=
ges) {

stock_pages =3D=3D 10
nr_pages =3D=3D 20

so after consume_stock() returns false
the batch will stay =3D=3D MEMCG_CHARGE_BATCH =3D=3D 64
and
page_counter_try_charge(&memcg->memsw, batch,...

will charge too much ?

and the bug was there for a long time.

Johaness,

looks like it's mostly your code?

Pls help us out.

