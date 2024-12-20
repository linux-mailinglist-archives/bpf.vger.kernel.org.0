Return-Path: <bpf+bounces-47406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FFB9F8DEB
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 09:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4FC16B742
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20CF1A0731;
	Fri, 20 Dec 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MUOz1K3p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2452F1804A
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734683100; cv=none; b=UvkcZd9D/xCo+NgwPtewR1ykH1jmroldXyP6I9oIjpKcV6OzBrBPvBW+Ug5ZXRjutZbYwmFnGUHzTU1ZgPZZaVdYx79sn5fpIMaL6kSaPLz5n4gzEMggi0WQ4PlSkvaHndtJ4oQ0cSgwNQjS+FNxnbM5QQQZMZvjOpisfk2GZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734683100; c=relaxed/simple;
	bh=sZ7W+b83JLESq3wVIHpDAj9dS8bm0p1gaOSAJS3EjZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIelNU9qj2j3vfZl+pn91y9FvJUtfcquPYPb78LjZTjle6Y6YHAICdVdG0nsIbEzF14VJDpngJt7TJD7YXU+GC8bzKkLbjaT3D37SPV4oCvbIn76uop6rTKsFa12iEujjFRKrodVraqMbpvsnt47VC4EhVWpbFiXoU8snV9WkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MUOz1K3p; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so4926447a12.1
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 00:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734683096; x=1735287896; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Urqu9iSmfH6SROfO9Gb6Yy0aeXqtUTT+yKgW/YW4rGs=;
        b=MUOz1K3pksbWzzmOt8c9tUO+h2PBhROOfWJaxVJRujpvcDyixrSlkfMXZH/DsmyChE
         SztgFGaaboxkw076DeGxFEoHI0OWOqlRmhWaJrFtSH+u/gusa/ZAt1goCK8YdLiGGeG0
         mjiRc9jhzZCLQ+5PpshKC/b4P6zn7zp/UDPs+QgG5F4w5B9aA0tboB/OWUBK0RnWkxgo
         JMAjKuHn8dNX989WXZwoc0hEk8uf2RfTbFaT2NMgkFuOUwwDSgXASfLu8NTR2pGKjGfL
         mjHdBHksTIL7shGmrXriGrc1/eA2ki2JmtHt0W7iIESw1s1MI62TfC13FO5EQIyxBav2
         onaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734683096; x=1735287896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Urqu9iSmfH6SROfO9Gb6Yy0aeXqtUTT+yKgW/YW4rGs=;
        b=adMrMqDzEdZHzrZHt/wBB2Xh68BF+lOXR1pfEOW7ml8FKrB59Muau/vUqGyQrXYzPS
         m7mKkz+kCH+PpYwtJxuRwyeIQysjt1FYG/NqCG8Ds/QBvuWD1+kUQA1TPnGFRjjjGhZG
         LTpgCioimrJab8YS9qvSVms41GGa7/mUSJDHPy7yJFdk0SCbCbxIkRRy3yPEi0awzYfW
         CGLBcBh16seegQlCewp4QGjf2Ieh5+bPmsvcayYhixbZ1cOLzfKeF7QQkyBVmkQiscjN
         ClJW8TZSJQgGYq5CCHpQmYqM2JueMHG/bB8JU84Exi033JO7bNRgxxVfDXYcHX4lcm1v
         tWsQ==
X-Gm-Message-State: AOJu0YxB5BcFsLMVSFbr3rgQIZ7u6P+/j42imKlXpYCgnCrkCp2tkXh1
	DEEFSp6cVZv3VPSrhR+oSRDQGrWikvITSDIQJlAf9BxxDHkl+TD3YHMk6QI+oS4=
X-Gm-Gg: ASbGncs+lYNV0gFIE2nU5+iqQMA6qiR+RIjzamIBOYnaBXSDGkKHNSlVfr3kwS4RvRl
	6ELW4ouXTB9YXHusXVnyBXOyR+2L4alDbFV+aHQPQ3tUw8DrRUFmBPJh/vj8is/ODRHeJxjjb7J
	05v1Cjx4j6xKc2/MBNDbZau+2UxG+S2zEE5sZc86kdLFk5RpytVEMkxHFeiIwnSWg14vcOViFGL
	36+ukpMZFGMoaarJhb65ifQam2K7cWHI+CCjXXhT9xF09E=
X-Google-Smtp-Source: AGHT+IEEJw1PFfgfh9Omb3EZ32kpp5CtPbHnxjC3BlcrCvpiIwXYmAD3OK1KKBMHhPcIP797MTnnTQ==
X-Received: by 2002:a17:906:f5aa:b0:aa5:53d4:8876 with SMTP id a640c23a62f3a-aac08228224mr538509966b.20.1734683096271;
        Fri, 20 Dec 2024 00:24:56 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe35d4sm151853766b.108.2024.12.20.00.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 00:24:55 -0800 (PST)
Date: Fri, 20 Dec 2024 09:24:55 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 4/6] memcg: Use trylock to access memcg
 stock_lock.
Message-ID: <Z2Up17maf6FHkVu5@tiehlicka>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-5-alexei.starovoitov@gmail.com>
 <Z2Ky2idzyPn08JE-@tiehlicka>
 <CAADnVQKv_J-8CdSZsJh3uMz2XFh_g+fHZVGCmq6KTaAkupqi5w@mail.gmail.com>
 <Z2PGetahl-7EcoIi@tiehlicka>
 <Z2PKyU3hJY5e0DUE@tiehlicka>
 <Z2PQv8dVNBopIiYN@tiehlicka>
 <CAADnVQLm=gSAh2u3iF4HoGmLEqa-AV0FAEnDqcoFYDgZ06d+gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLm=gSAh2u3iF4HoGmLEqa-AV0FAEnDqcoFYDgZ06d+gQ@mail.gmail.com>

On Thu 19-12-24 16:39:43, Alexei Starovoitov wrote:
> On Wed, Dec 18, 2024 at 11:52 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 19-12-24 08:27:06, Michal Hocko wrote:
> > > On Thu 19-12-24 08:08:44, Michal Hocko wrote:
> > > > All that being said, the message I wanted to get through is that atomic
> > > > (NOWAIT) charges could be trully reentrant if the stock local lock uses
> > > > trylock. We do not need a dedicated gfp flag for that now.
> > >
> > > And I want to add. Not only we can achieve that, I also think this is
> > > desirable because for !RT this will be no functional change and for RT
> > > it makes more sense to simply do deterministic (albeit more costly
> > > page_counter update) than spin over a lock to use the batch (or learn
> > > the batch cannot be used).
> >
> > So effectively this on top of yours
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index f168d223375f..29a831f6109c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1768,7 +1768,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> >                 return ret;
> >
> >         if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > -               if (gfp_mask & __GFP_TRYLOCK)
> > +               if (!gfpflags_allow_blockingk(gfp_mask))
> >                         return ret;
> >                 local_lock_irqsave(&memcg_stock.stock_lock, flags);
> 
> I don't quite understand such a strong desire to avoid the new GFP flag
> especially when it's in mm/internal.h. There are lots of bits left.
> It's not like PF_* flags that are limited, but fine
> let's try to avoid GFP_TRYLOCK_BIT.

Because historically this has proven to be a bad idea that usually
backfires.  As I've said in other email I do care much less now that
this is mostly internal (one can still do that but would need to try
hard). But still if we _can_ avoid it and it makes the code generally
_sensible_ then let's not introduce a new flag.

[...]
> How about the following:
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index ff9060af6295..f06131d5234f 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -39,6 +39,17 @@ static inline bool gfpflags_allow_blocking(const
> gfp_t gfp_flags)
>         return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
>  }
> 
> +static inline bool gfpflags_allow_spinning(const gfp_t gfp_flags)
> +{
> +       /*
> +        * !__GFP_DIRECT_RECLAIM -> direct claim is not allowed.
> +        * !__GFP_KSWAPD_RECLAIM -> it's not safe to wake up kswapd.
> +        * All GFP_* flags including GFP_NOWAIT use one or both flags.
> +        * try_alloc_pages() is the only API that doesn't specify either flag.

I wouldn't be surprised if we had other allocations like that. git grep
is generally not very helpful as many/most allocations use gfp argument
of a sort. I would slightly reword this to be more explicit.
	  /*
	   * This is stronger than GFP_NOWAIT or GFP_ATOMIC because
	   * those are guaranteed to never block on a sleeping lock.
	   * Here we are enforcing that the allaaction doesn't ever spin
	   * on any locks (i.e. only trylocks). There is no highlevel
	   * GFP_$FOO flag for this use try_alloc_pages as the
	   * regular page allocator doesn't fully support this
	   * allocation mode.
> +        */
> +       return !(gfp_flags & __GFP_RECLAIM);
> +}
> +
>  #ifdef CONFIG_HIGHMEM
>  #define OPT_ZONE_HIGHMEM ZONE_HIGHMEM
>  #else
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f168d223375f..545d345c22de 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1768,7 +1768,7 @@ static bool consume_stock(struct mem_cgroup
> *memcg, unsigned int nr_pages,
>                 return ret;
> 
>         if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> -               if (gfp_mask & __GFP_TRYLOCK)
> +               if (!gfpflags_allow_spinning(gfp_mask))
>                         return ret;
>                 local_lock_irqsave(&memcg_stock.stock_lock, flags);
>         }
> 
> If that's acceptable then such an approach will work for
> my slub.c reentrance changes too.

It certainly is acceptable for me. Do not forget to add another hunk to
avoid charging the full batch in this case.

Thanks!
-- 
Michal Hocko
SUSE Labs

