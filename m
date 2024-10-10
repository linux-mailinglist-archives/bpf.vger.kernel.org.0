Return-Path: <bpf+bounces-41592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5792998DFB
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE27281DA5
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5431C19B5AC;
	Thu, 10 Oct 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQsc9nlV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6E2AD12;
	Thu, 10 Oct 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579879; cv=none; b=nKIUmuXmyh+VAJViLYF1M0G29O07mRvQYdq7I9wZI9n7PPL1IiFdKr8QHvQLSALKEp4PdTUB4a4xSqO/NNJqSYjk93bNUtFxcBe77NMyfqt70siu/X0ighYAR0Dou8O4GNbLdZ0SH///1W2Ra5Ofrpf3rlavK3UyPmDNKgaAbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579879; c=relaxed/simple;
	bh=KmaCXUsf76qXjPkMG6xmS/GxpfPhh7ZBsUs/imeasvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfDI30glzZcVMWsytN9DZ1205Btmepw7+tXjEb7wm05Vm2KeQD8VB30O6HVauVvjT9VF0zxtI1QNGXfvnHNQIvA03XHCY014zIK7iTrGRXZKFnGpmHxRV4A18WxC5Y1LGCgj5c7wLZNZbnNJcd3HnW4LBZmAFIqjHwnipIFVwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQsc9nlV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d50fad249so352307f8f.1;
        Thu, 10 Oct 2024 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728579876; x=1729184676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+DAWWUvKTQgW3MLl9vHnA8Jud2Bc9oa6MqljB4YdFk=;
        b=DQsc9nlVQYksrDWPRNaitZr6XdkLUIZY3eUXQ+lunrHAFOQE6yU/rtssDHEdruxOxn
         Bx4bO76wi9shTaDogWsnDYOwlcPYXvDkpg7CC9/o/aFstM4G/CiSgwzKkVXIMQQ3PkBp
         bsgz2wIFnyW97D5b5pYtd44UH0RQmu9R6LYuyOxhljVtZA/QXgLUTwLF3T2hnz8XncYL
         xoz2nCWnRTC3NFc+I5DFn6Es3tnsdti+ZNAAuMzfcGUcYW9p3dvQBAB/R3VaQIbYMlo7
         hq1YfXPMX5Nvdth4aTz/BCTWIMMq1q+2/MIsQs3G9HeYTjqJ5MrMFmkMwIf75m8qB71O
         TftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728579876; x=1729184676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+DAWWUvKTQgW3MLl9vHnA8Jud2Bc9oa6MqljB4YdFk=;
        b=OVymdUJZJiwKCw1dqy5EAaY95XC1bqoVKUSPelQ50dKHrRYa1PvP28pao8OE8JkPn7
         0RmpcPnA3QN7gpgfIUAKgCuxto/ytpO51TTH323XvGfS5Ak29rEysq2pHFOYGwXwaGqh
         dOof4yf4GmPtzn2hRyIyaVnWxT/x1Kxw0JgHa4N7BHeruSQ2oojcUtrEnZjkhNl4+4lH
         5zSQlSB+B/e5rS2pWwfbVbxRE2RksBxal39wXBEkaTsOcm0rXlmWjlbsuREWBBQJcHSE
         1+nd9Xsurr7izoqyfu2G6/pUrlslqmBf+rXpqiIu4hQpUv7ZXIJ5haZ96tPbkas+5y7a
         fw1w==
X-Forwarded-Encrypted: i=1; AJvYcCUORYqYFuM3q9rsJDAF0HZeV0SlGDpw+3PDI1FOp/B/l0S+moF4ONcBmf2ITF5Yr7RFh/A=@vger.kernel.org, AJvYcCXImh3NHmaGPtKQznFl/4jfl2z0aVO9owLUbn4vTC5dg2Fmri9HFzbhSxpRmM0Oi0GlNSiHoa9D2KN38UVS@vger.kernel.org
X-Gm-Message-State: AOJu0YxulFEHnjhDXih/ZGA7nKiufDh7uD1IgksUjyPxZpI6IaL4DAIm
	y0bywEDcBz0lfPcPQ+3ntwEoTKIthGnwrpYoIkNFwDp7/9JtqJRuFdHa1cBdyfjCE0A2EvwpjUd
	OFjlJhNN5ch5Z6EVDUjLYgW2DsXg=
X-Google-Smtp-Source: AGHT+IEClv/cTkt5E2SWxAPhIQ5PRwySBYvQxAVESe6/iRML/OaeVGWjqVj4NOlIkO5y/2r/8QROOzYWbH5DxUg6kZw=
X-Received: by 2002:a05:6000:109:b0:37c:cdb6:6a9e with SMTP id
 ffacd0b85a97d-37d3a9b5242mr4815198f8f.9.1728579875879; Thu, 10 Oct 2024
 10:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002180956.1781008-1-namhyung@kernel.org> <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com> <37ca3072-4a0b-470f-b5b2-9828a2b708e5@suse.cz>
 <ZwYt-GJfzMoozTOU@google.com> <ZwgEykf_XmVpEE8_@google.com>
In-Reply-To: <ZwgEykf_XmVpEE8_@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 10:04:24 -0700
Message-ID: <CAADnVQLXrS0coJrk5RPxvik5Sz2yFko5z=+PXdGfju_7Lxj=mQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
To: Namhyung Kim <namhyung@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 9:46=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Oct 09, 2024 at 12:17:12AM -0700, Namhyung Kim wrote:
> > On Mon, Oct 07, 2024 at 02:57:08PM +0200, Vlastimil Babka wrote:
> > > On 10/4/24 11:25 PM, Roman Gushchin wrote:
> > > > On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
> > > >> On Wed, Oct 2, 2024 at 11:10=E2=80=AFAM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > >>>
> > > >>> The bpf_get_kmem_cache() is to get a slab cache information from =
a
> > > >>> virtual address like virt_to_cache().  If the address is a pointe=
r
> > > >>> to a slab object, it'd return a valid kmem_cache pointer, otherwi=
se
> > > >>> NULL is returned.
> > > >>>
> > > >>> It doesn't grab a reference count of the kmem_cache so the caller=
 is
> > > >>> responsible to manage the access.  The intended use case for now =
is to
> > > >>> symbolize locks in slab objects from the lock contention tracepoi=
nts.
> > > >>>
> > > >>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > >>> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> > > >>> Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> > > >>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > >
> > > So IIRC from our discussions with Namhyung and Arnaldo at LSF/MM I
> > > thought the perf use case was:
> > >
> > > - at the beginning it iterates the kmem caches and stores anything of
> > > possible interest in bpf maps or somewhere - hence we have the iterat=
or
> > > - during profiling, from object it gets to a cache, but doesn't need =
to
> > > access the cache - just store the kmem_cache address in the perf reco=
rd
> > > - after profiling itself, use the information in the maps from the fi=
rst
> > > step together with cache pointers from the second step to calculate
> > > whatever is necessary
> >
> > Correct.
> >
> > >
> > > So at no point it should be necessary to take refcount to a kmem_cach=
e?
> > >
> > > But maybe "bpf_get_kmem_cache()" is implemented here as too generic
> > > given the above use case and it should be implemented in a way that t=
he
> > > pointer it returns cannot be used to access anything (which could be
> > > unsafe), but only as a bpf map key - so it should return e.g. an
> > > unsigned long instead?
> >
> > Yep, this should work for my use case.  Maybe we don't need the
> > iterator when bpf_get_kmem_cache() kfunc returns the valid pointer as
> > we can get the necessary info at the moment.  But I think it'd be less
> > efficient as more work need to be done at the event (lock contention).
> > It'd better setting up necessary info in a map before monitoring (using
> > the iterator), and just looking up the map with the kfunc while
> > monitoring the lock contention.
>
> Maybe it's still better to return a non-refcounted pointer for future
> use.  I'll leave it for v5.

Pls keep it as:
__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)

just make sure it's PTR_UNTRUSTED.
No need to make it return long or void *.
The users can do:
  bpf_core_cast(any_value, struct kmem_cache);
anyway, but it would be an unnecessary step.

