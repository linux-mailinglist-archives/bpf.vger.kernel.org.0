Return-Path: <bpf+bounces-74326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D09C545A3
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 21:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4355034D46A
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F6283FD9;
	Wed, 12 Nov 2025 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzjijuJz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39688A55
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977902; cv=none; b=CSldKpDDFo+1UKEXGNI8F3+SbbrFrbRrNPuJC13NQ8ze4wuylO0wbX9A5Vs1rJOF1uO3RD81FC9/a4sga2Q9ueBZY9iT2VX/GBK6SsYWluQnIQrwasuvNIAw6iBh0JOj5vm6lyHl6RHlHMTqEzxV8+eXx3kfr+1mtk9KdqgDySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977902; c=relaxed/simple;
	bh=9rDP7WFt6h3HMM5ZZSqB17XM5Av/Jk9Zj4KggaoDnWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0/eVbcDwXzpk/m36lQGkmeUPRpeNs/kI5gM62ynhYkXkt3KBOG9CkfS95naaOHPy1/f5TpH5zCVRVcXbsQ+FZMJ7cWdnSmP8WIQxTyrRyCTbw1GOv/C8/9jinedmf4Xyuj/JNHVEX85U7yAQOfHs9M0upg0fZxqhYk0F7lZo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzjijuJz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477770019e4so905375e9.3
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 12:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762977899; x=1763582699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i1blxOxdeWMBKsoLhp/+DSxr57RwLSHutTSzz4//F4=;
        b=bzjijuJzBxnJlOPijEH/jtcIvwur8s3g0Kk7elI2Sw80BmVOt9MH0kvyy9+S4nNZqK
         H0Y/c9on9OAIqMcBIQ+Ja5BdTBUFCXDPdeWhvKodcsPFqZSNJ4H6ZWNA2N8O7V8HDdJ+
         0+A5hWutfNb1jvrDrVQuPxxz8z3zedZV+CgdOUpYOVhihF78mgHx+saZ1mQSrNKA0bHQ
         RY/l7LWijSZi5O0skhppStq3aeNgbobOffKdBUzo/QYNlsTC6WhW3yvAGIVhA0U32d2q
         aIYzI8UWeASa90SJFQl3/RLgCsdvhuZDeJfhrk1k+QmsgFqipQ+yl853Buhw5S7thamB
         /bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977899; x=1763582699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7i1blxOxdeWMBKsoLhp/+DSxr57RwLSHutTSzz4//F4=;
        b=gZRf9JZn+GBYrI61TV8yVZtnS/ubmX3S7fwrcoPBBjl89kr8/k2EwN66ijVG4z5/Tq
         skRMIGjqol6VqtIMiKxKiHnY/eSiUaNNykKlrVqCBcMpTkqO4tvG1VTfdwuImNlrvB4B
         XS4j2v4nTpit9A0bRWfBSnNy7mMp7KdRZMI/h8Ikhztk+1azbgDeHC6eOR4/aysnyf88
         SUI0uYf8hvMFu1oqTPjBI0Tf/bJPDe1K9B711CYXCqDMRm0DHeo1I87GO0Ls8yUtaCc5
         nqfvQIcAzS6fXKdcMHsby8dM73rsmAijluiRNlB77uQW+UMy8gRGX3u9vndnYwctLEsE
         OZtw==
X-Gm-Message-State: AOJu0Yyb5rBbn0aXQ1AD9EWn3fElepqw8TkYevCyxa0Y88N017G0Hs7W
	hiWHV65b8zIBNMaK3KuFdRa/iHClhRqr7xTZ4RjIClUDuqiJnWicB6JWJJiugdKFkXEa3bukchG
	tMNIF1K2ILcPEeiEeGmxdiyfrlTIL4gc=
X-Gm-Gg: ASbGncvkqsH2FeW7gg6ykUOflkl0vf5FOtQuouC777VmPFQGqdLq5G5HuejasV2zx8i
	me4C4M15OOyxLyNfvw/A/MeP2I0j631/0+I0rhFYI4buraglVVW956fMzupdm4RFFIetJgGQACC
	ygoxit3nV/gegJH9Q7UsDEWzlM5F0dXBaICQF3u/4y4umfMe7z/w8n4BUR4u6ejZMQ5d+9IohVk
	IQHJWvkDI+TKYrseLN19+uu7IC71luPoSQox0Q7D4Tr3dvXPVOU0T3FAQzPM65QS3/YL6RFxDKg
	YdIp47/oeGo3DSFwzA==
X-Google-Smtp-Source: AGHT+IFT+9fXgwsbAD9vCMeqMd3K0+NF3yAvEotSOT0bUnU8stxpPM2iGhYOmowDB/Y/EvjjPHdpb7/6NCzVd/Ex1vg=
X-Received: by 2002:a05:600c:1d10:b0:477:5486:ec73 with SMTP id
 5b1f17b1804b1-477870b953emr39722905e9.39.1762977899441; Wed, 12 Nov 2025
 12:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112175939.2365295-1-ameryhung@gmail.com> <20251112175939.2365295-3-ameryhung@gmail.com>
 <CAADnVQ+2OXNo99B2krjwOb5XeFhi6GUagotcyf36xvLDoHqmjw@mail.gmail.com> <CAMB2axM0-NF5F=O6Lq1WPbb8PJtdZrQaOTFKWApWEhfT7MD4hw@mail.gmail.com>
In-Reply-To: <CAMB2axM0-NF5F=O6Lq1WPbb8PJtdZrQaOTFKWApWEhfT7MD4hw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Nov 2025 12:04:47 -0800
X-Gm-Features: AWmQ_bl1hNz8FdEtKYHEH1VSS8S9DBhuGihUCXyvFJrS_suogQ5asfWjIHtASsg
Message-ID: <CAADnVQKWKC3oh6ycxE+tstYupwVsdbhYHOncnfTOFWLL2DmJjw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/2] bpf: Use kmalloc_nolock() in local
 storage unconditionally
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:51=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Wed, Nov 12, 2025 at 11:35=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 12, 2025 at 9:59=E2=80=AFAM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > @@ -80,23 +80,12 @@ bpf_selem_alloc(struct bpf_local_storage_map *sma=
p, void *owner,
> > >         if (mem_charge(smap, owner, smap->elem_size))
> > >                 return NULL;
> > >
> > > -       if (smap->bpf_ma) {
> > > -               selem =3D bpf_mem_cache_alloc_flags(&smap->selem_ma, =
gfp_flags);
> > > -               if (selem)
> > > -                       /* Keep the original bpf_map_kzalloc behavior
> > > -                        * before started using the bpf_mem_cache_all=
oc.
> > > -                        *
> > > -                        * No need to use zero_map_value. The bpf_sel=
em_free()
> > > -                        * only does bpf_mem_cache_free when there is
> > > -                        * no other bpf prog is using the selem.
> > > -                        */
> > > -                       memset(SDATA(selem)->data, 0, smap->map.value=
_size);
> > > -       } else {
> > > -               selem =3D bpf_map_kzalloc(&smap->map, smap->elem_size=
,
> > > -                                       gfp_flags | __GFP_NOWARN);
> > > -       }
> > > +       selem =3D bpf_map_kmalloc_nolock(&smap->map, smap->elem_size,=
 gfp_flags, NUMA_NO_NODE);
> >
> >
> > Pls enable CONFIG_DEBUG_VM=3Dy then you'll see that the above triggers:
> > void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> > {
> >         gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags=
;
> > ...
> >         VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
> >                                       __GFP_NO_OBJ_EXT));
> >
> > and benchmarking numbers have to be redone, since with
> > unsupported gfp flags kmalloc_nolock() is likely doing something wrong.
>
> I see. Thanks for pointing it out. Currently the verifier determines
> the flag and rewrites the program based on if the caller of
> storage_get helpers is sleepable. I will remove it and redo the
> benchmark.

yes. that part of the verifier can be removed too.
First I would redo the benchmark numbers with s/gfp_flags/0 in the above li=
ne.

