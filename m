Return-Path: <bpf+bounces-31054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D98D6710
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA39B24686
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809416A360;
	Fri, 31 May 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7SyYA5K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7415B128;
	Fri, 31 May 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173848; cv=none; b=kwZLfWKiLUXkTpoaTeHB24qBVfHalprS/1JO8ZKtMBduGWBk+ppU0oOAZgDzOU0lNrQ0WwB0ABGjAXb4qNZYhkqttPau580WDpQaPPnX+7RedyPTEjr1I/6uTIIX3grMqYRN3Ze8hoTS3aHAtn0Ycrz4lv6BlToKvw4eNLC8Vmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173848; c=relaxed/simple;
	bh=uG7P1x3HrP8RowMmWDcBXTYjXz0LxJxK8wl6ae3emAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDRdQmoGXR1FSOkLIM2ycT2kiDzToRVd5WAdNr7zUkCbdpSQ0c37PZurO7JsZLiW8HB9SDR/GjG93wn46BcvxOT1kNH2pNJML01/p97ljMPDYLx7S0OB+4MK45oFTMzA4zza1IyPZkOFhrC1mRnO01Nrxt9I6fXY7PRWqlYlw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7SyYA5K; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-421208c97a2so21008805e9.1;
        Fri, 31 May 2024 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717173845; x=1717778645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgrPSqavQhhCwRo/IO4y9sSd78oBJ0BfHadESybGIRk=;
        b=T7SyYA5KUZsU23dLb8L62F/2Jh5Qo6J/r4/MNbO8TkE8nC2FZnaVwWl+kKSqh/QOe+
         BS1fGqJHvsUtzbGAS4xwdvW8m59LhW2FsM+AlGMc1N3DyrOTvD/76DP7mPJ3Iwm8i5JH
         eFkkoolx/lsc5ilSkRkPla5644JSh1ltjHyFeP6aCNsujj1mx6xHn72aXGvOgsOPcpTo
         9DIkSl8uLu/8/e9YHZbf3g4Y3m3AJ57YcLmiSD0LXUyqkqT2P5oi4bpWcLpMXsUQpFZT
         GwcNl1bC9kXpKpGRO7WQOQC8vMMuSzPT6jJN2kEXAHXlf6SUkKPeKtN0PMsGETVR7mLa
         ImLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717173845; x=1717778645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgrPSqavQhhCwRo/IO4y9sSd78oBJ0BfHadESybGIRk=;
        b=KNUJo6s2zjEMtfJv+23IQd1ZLp/RwYOf3qzaQZd65wf5WooWRDd7+R8A3qeqoBVtsV
         n3NjqQe2gwHO+/ZU6+SGPZ9NW2+47ztfKDeTu6t3ydC/U5ro6doF15t2a+GHCFuJLzRW
         lxSv5NFlGYOYm/iTf83GGuoTY/k6LRtBsaiokJIcfWSwLyht4Wau2j7LFGaxzajOFSNW
         lEBXFvBa8Cu2QBtZzCWivRu9oihXC6pDxyQ1pS2eM7+LU/GZfENhG2FGm6JqdfaRnuRo
         XKxQGDP0R+6gUczIg7k8NCkvw+YINmHSUJ4q80GB9eVFSM2TGpW+maMFaxQz3gF0MFtg
         CR6w==
X-Forwarded-Encrypted: i=1; AJvYcCW201XqUwz/uvT0jmYeD9qAlOn7uN64A2c3btX4znu03YN1rqGa0lSlV7RkzlNYnSSh8ShvdMHYB8ax4sTvEvfHmMnoscb9wawIqrpI9YCgi8cVw6iTmSPXqZ8+xnM79ndW2i/cmm2L9U34luoTyMhyiOLuDOaM745GLyYXmlWp5LP6/Ind
X-Gm-Message-State: AOJu0Yz1UyywsN/HQ4N5+OWt4YRfYPY7D2GEoxeSnRxyuKOXv+xQM0Pq
	DfAGcHkimmLGrQdhqZU3mNre/EhgTKe7QliavpBzWLgYCGqttssCRuxCM27upee9DVgiFBo9CzE
	JnZJrsoLPsjXNvKpPXQnQBiwaukG0bDSf
X-Google-Smtp-Source: AGHT+IFTytoJamLJRvTQO3BYC2MBDxCEuBj6lgJTYnD/N3Qp380NOujMSa5JG5AI3SYo5H23tb7dmLf0PjIWpX8mTVk=
X-Received: by 2002:a05:600c:3541:b0:41a:c86e:a4db with SMTP id
 5b1f17b1804b1-4212e04732amr18706075e9.9.1717173844917; Fri, 31 May 2024
 09:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz> <20240531-fault-injection-statickeys-v1-3-a513fd0a9614@suse.cz>
In-Reply-To: <20240531-fault-injection-statickeys-v1-3-a513fd0a9614@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 May 2024 09:43:53 -0700
Message-ID: <CAADnVQJ=bNg9nWQPXGjJ11pZnmjntt=zLBqtJng3328T1L-u0g@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] mm, slab: add static key for should_failslab()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 2:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Since commit 4f6923fbb352 ("mm: make should_failslab always available for
> fault injection") should_failslab() is unconditionally a noinline
> function. This adds visible overhead to the slab allocation hotpath,
> even if the function is empty. With CONFIG_FAILSLAB=3Dy there's additiona=
l
> overhead when the functionality is not enabled by a boot parameter or
> debugfs.
>
> The overhead can be eliminated with a static key around the callsite.
> Fault injection and error injection frameworks can now be told that the
> this function has a static key associated, and are able to enable and
> disable it accordingly.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/failslab.c |  2 +-
>  mm/slab.h     |  3 +++
>  mm/slub.c     | 10 +++++++---
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/mm/failslab.c b/mm/failslab.c
> index ffc420c0e767..878fd08e5dac 100644
> --- a/mm/failslab.c
> +++ b/mm/failslab.c
> @@ -9,7 +9,7 @@ static struct {
>         bool ignore_gfp_reclaim;
>         bool cache_filter;
>  } failslab =3D {
> -       .attr =3D FAULT_ATTR_INITIALIZER,
> +       .attr =3D FAULT_ATTR_INITIALIZER_KEY(&should_failslab_active.key)=
,
>         .ignore_gfp_reclaim =3D true,
>         .cache_filter =3D false,
>  };
> diff --git a/mm/slab.h b/mm/slab.h
> index 5f8f47c5bee0..792e19cb37b8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -11,6 +11,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/kfence.h>
>  #include <linux/kasan.h>
> +#include <linux/jump_label.h>
>
>  /*
>   * Internal slab definitions
> @@ -160,6 +161,8 @@ static_assert(IS_ALIGNED(offsetof(struct slab, freeli=
st), sizeof(freelist_aba_t)
>   */
>  #define slab_page(s) folio_page(slab_folio(s), 0)
>
> +DECLARE_STATIC_KEY_FALSE(should_failslab_active);
> +
>  /*
>   * If network-based swap is enabled, sl*b must keep track of whether pag=
es
>   * were allocated from pfmemalloc reserves.
> diff --git a/mm/slub.c b/mm/slub.c
> index 0809760cf789..3bb579760a37 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3874,13 +3874,15 @@ static __always_inline void maybe_wipe_obj_freept=
r(struct kmem_cache *s,
>                         0, sizeof(void *));
>  }
>
> +DEFINE_STATIC_KEY_FALSE(should_failslab_active);
> +
>  noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>  {
>         if (__should_failslab(s, gfpflags))
>                 return -ENOMEM;
>         return 0;
>  }
> -ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
> +ALLOW_ERROR_INJECTION_KEY(should_failslab, ERRNO, &should_failslab_activ=
e);
>
>  static __fastpath_inline
>  struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags=
)
> @@ -3889,8 +3891,10 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem=
_cache *s, gfp_t flags)
>
>         might_alloc(flags);
>
> -       if (unlikely(should_failslab(s, flags)))
> -               return NULL;
> +       if (static_branch_unlikely(&should_failslab_active)) {
> +               if (should_failslab(s, flags))
> +                       return NULL;
> +       }

makes sense.
Acked-by: Alexei Starovoitov <ast@kernel.org>

Do you have any microbenchmark numbers before/after this optimization?

