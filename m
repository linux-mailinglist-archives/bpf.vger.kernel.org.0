Return-Path: <bpf+bounces-33075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1155A916EEA
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C50B1C22329
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6410176AC3;
	Tue, 25 Jun 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/79w8su"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D9172786;
	Tue, 25 Jun 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335581; cv=none; b=ZaHRK0vXXb7MFrxVsd4Y+r+athqATinKFehfQSdrh3NpaE9PxabSegqbPgWDsPj7dB2ecLgcOj6lXPaONn4gankyEm3ZG+PgAbKhRaOSBmqd4q8GYnKBnC+NJCcokW67jwj0wU2mKp42+Yrkmrb3hqUGLuOKR5S5r6mTU7NnKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335581; c=relaxed/simple;
	bh=Wwa4HGkLETbKqeTTU6fvEcD/qSObTjEYyqi/1NukKz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0do4xvrnEPlNxWdkkgQIB4zlMiVhgd1B2Xx8hPH1SmkufUPbOB+Th3L9OgErd2GKm7EBJeYZQ81UjIyPrxn6qp9vSsOrlKIC+pSLKvUv1jKUF19k3RPFjst/gJnt97RS+E08iO8sX6kO6tre7+dQRdj4b+B0fR9pI9QaQI1YEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/79w8su; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36703b0f914so575245f8f.0;
        Tue, 25 Jun 2024 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719335578; x=1719940378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI5OFEaVYhrUkuh/u4LxK0p6IDDHPXl4NuFtwgsoCq4=;
        b=R/79w8su5OYlKu588PZ/L+Ac39IOQMnyTSJ6jiEcZXGnjdnJHHihyaWIzcSrDU309q
         /ehpuklLrmwPDHBRN77ZoYMc+ngp5IrpJO/QIrU7bihMKqVtykI/ilaqsHrySnew2+07
         y3XkeBlHriGL0wA5+I9HsM33TrqOd+P4D/f0YkazajKxnIgvwVsQv7ybm1Oz7MM1zuii
         atX+um2HLZHQbLBJnyIcEvsR4zny5gxS4Ka/qQlHat9wutU99XDDUMK5Pz0S0C6ST7n/
         tKmKi/iWPXv+qhABAOTRyUIrqVtZSd2S5Ru4NLrNJACKLZ0NWlYowtk4bTIyE4oJEfL0
         4Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719335578; x=1719940378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI5OFEaVYhrUkuh/u4LxK0p6IDDHPXl4NuFtwgsoCq4=;
        b=YkSYEuiQl5vJnXmr1Kv5UxlXfxp99IwxyUamjJxfH2gHunEeBtufkbOLNqhs2ghv5z
         Vhy00vqUEg91Yzc+1YWl1SMJVupdX9/uNXAHmTF1YRO4G4VlXBrwxFewRSM7LgsDqoPm
         gF0gL2dZgXSVYbAbZ5BgBwF7GH9Q7S43UZ+quYFKm6q6CIKOIM8Vqn08zVeEIu02Gdwg
         Axj5z0hM4UguSzBq3Q5za7FyNKSo3+K2cuXuLrBEXlfITRKtB09soT4zlh1eCusf6Pi8
         G/nuoMS9aTnRWqLCg7/6ZASGcQ7YTS7D3KSVJqcmM+/DYNSSxXCtmORD1uOe3nsO96oE
         a2iw==
X-Forwarded-Encrypted: i=1; AJvYcCV1ROdD7Z2AMIKhcIdQlCgirf+aMBh0yOJnV7cou52N/LPx2vkBfJJRRgDRxp1BD0LuyIV7Dwts/q7uFACj6aGwhK3gpAclBCRW32zzDyk6Hilqdw5N0tQ06ZEARVdl8g8P+RxDfiw0JFbLl8TNfSCy7naxkEASxdSyul0fhIIj5EsvP26q
X-Gm-Message-State: AOJu0Yzo1++47F56ZlbyP5CP+UiFgAAqDfM9d6vBnJO1ghiBqZ7zFxWO
	JR4VHj91vQucNc9nrJGr6MEbvho0pPNNAccTpqKV4ICTY6sm9kO3L+gX435EZZIqLtAPTwhWVk7
	jrP4Nlr2+HwEuVnpaDOxt1fDHr3M=
X-Google-Smtp-Source: AGHT+IE06FOCAbgOD9xJVbw3JngT0HOsO4esODsbSBdUue19gmiKBnUmKzc7qwytynqNUagCApCOkM09kU86aKoNtak=
X-Received: by 2002:a05:6000:1a8c:b0:360:728d:8439 with SMTP id
 ffacd0b85a97d-366e36491b7mr11108459f8f.2.1719335577845; Tue, 25 Jun 2024
 10:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz>
 <20240620-fault-injection-statickeys-v2-6-e23947d3d84b@suse.cz> <78177ff2-e140-4e81-9b2a-be5bece34cfc@suse.cz>
In-Reply-To: <78177ff2-e140-4e81-9b2a-be5bece34cfc@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jun 2024 10:12:46 -0700
Message-ID: <CAADnVQJrirvzu8fqwRChM1aUvHUNoszNpLhXHB9EHVesuD_YJA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] mm, slab: add static key for should_failslab()
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

On Tue, Jun 25, 2024 at 7:24=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 6/20/24 12:49 AM, Vlastimil Babka wrote:
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3874,13 +3874,37 @@ static __always_inline void maybe_wipe_obj_free=
ptr(struct kmem_cache *s,
> >                       0, sizeof(void *));
> >  }
> >
> > -noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
> > +#if defined(CONFIG_FUNCTION_ERROR_INJECTION) || defined(CONFIG_FAILSLA=
B)
> > +DEFINE_STATIC_KEY_FALSE(should_failslab_active);
> > +
> > +#ifdef CONFIG_FUNCTION_ERROR_INJECTION
> > +noinline
> > +#else
> > +static inline
> > +#endif
> > +int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>
> Note that it has been found that (regardless of this series) gcc may clon=
e
> this to a should_failslab.constprop.0 in case the function is empty becau=
se
> __should_failslab is compiled out (CONFIG_FAILSLAB=3Dn). The "noinline"
> doesn't help - the original function stays but only the clone is actually
> being called, thus overriding the original function achieves nothing, see=
:
> https://github.com/bpftrace/bpftrace/issues/3258
>
> So we could use __noclone to prevent that, and I was thinking by adding
> something this to error-injection.h:
>
> #ifdef CONFIG_FUNCTION_ERROR_INJECTION
> #define __error_injectable(alternative)         noinline __noclone

To prevent such compiler transformations we typically use
__used noinline

We didn't have a need for __noclone yet. If __used is enough I'd stick to t=
hat.

