Return-Path: <bpf+bounces-12857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535047D154E
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8042824CA
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14574208C8;
	Fri, 20 Oct 2023 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/kswMZd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB01E530
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 17:58:52 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F1AC0
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 10:58:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so802413f8f.2
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697824729; x=1698429529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZ9J4etV4XyxH/p23jplLUii5ZwDC1wU3DhVZOLo/oo=;
        b=K/kswMZd9sKn6qcbObAmvc4iPQpUm+vE8b6XoOUVDPyygmc0o9gshY3nw6KyCupB19
         rTozyL8Mqd/9SsbcwzwAblCecnV2gJz/Wp6BXnIP2IZtuXFTvfjhla2sGpuEi9Spn839
         ghiE0Mizx8PIPZBcbeMxQjeTI4F4kmcj2lUPHb45tCfe82hZ66GyxzT3oCV/qKZd6mWc
         vXszxNnucs71SM7RLiU7trP5IT81RC8pxzleTvguqBvmggFasBz7QkbNZKFUM6dcKU4t
         vWrmzRx/A+ccMeNliy3aPFuyoXgyrqWj0lqtnJ66WSTBQ9tBBtJLBDCbzvl53xSn+Gsb
         B55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824729; x=1698429529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZ9J4etV4XyxH/p23jplLUii5ZwDC1wU3DhVZOLo/oo=;
        b=qo1cPdAmwIgAJB38Uvy7pc8WEWzBE/RVhowmoQ73ynmJMuSxXag90ZeUlNAR54uInq
         4Z3DCR9ITNo+L29TJ8zPtyxNno3QB+/mWdKyWiybqDDs6CDnbRCELDcz4QkiPgrXmI7U
         YLoXsUQQRWuVkntUrVwI+knnnbRf5mwnIJPiR2DWhMLCswSTpWXppU5nCAiTF4GEcZ38
         dMKjr5eABK0+DCJ9qtBu/jC++E8bCbBZIgbSRKoeUXw4RJXkuFdwinr94B9HSzHxUry5
         dOsnJau+6wsdUX7pC+mkQfkTza69IBT9MtWA0yFVVzoqbF8RCK8c/AWp4OrZ4SQ5w1+z
         Z++w==
X-Gm-Message-State: AOJu0YwWtuQWCejrRySaMX1cWels64U1aTsDRnsRgWpZ7Xeyd7o0dFnM
	RcV2KLBt4+zcXMPZJt1IOuRoiT7WAlFIxRmsMtc=
X-Google-Smtp-Source: AGHT+IH5kOwPSUcFh1hKA14nYuEsEO//NFyPkZ3EqGrUY7euHnWr2jbBUn4sG8OXxWF8KY9OOsF/YfRI7uBk/47D8cM=
X-Received: by 2002:a05:6000:78d:b0:32d:8401:404a with SMTP id
 bu13-20020a056000078d00b0032d8401404amr2366145wrb.10.1697824729093; Fri, 20
 Oct 2023 10:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020133202.4043247-1-houtao@huaweicloud.com>
 <20231020133202.4043247-3-houtao@huaweicloud.com> <ZTK9a4H2iuJrJG+x@snowbird>
In-Reply-To: <ZTK9a4H2iuJrJG+x@snowbird>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Oct 2023 10:58:37 -0700
Message-ID: <CAADnVQKREaN65cNMJ0qajjA9=46JWHyK9jdGFKcQ=RwjAMuQKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] mm/percpu.c: introduce pcpu_alloc_size()
To: Dennis Zhou <dennis@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 10:48=E2=80=AFAM Dennis Zhou <dennis@kernel.org> wr=
ote:
>
> On Fri, Oct 20, 2023 at 09:31:57PM +0800, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > Introduce pcpu_alloc_size() to get the size of the dynamic per-cpu
> > area. It will be used by bpf memory allocator in the following patches.
> > BPF memory allocator maintains per-cpu area caches for multiple area
> > sizes and its free API only has the to-be-freed per-cpu pointer, so it
> > needs the size of dynamic per-cpu area to select the corresponding cach=
e
> > when bpf program frees the dynamic per-cpu pointer.
> >
> > Acked-by: Dennis Zhou <dennis@kernel.org>
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  include/linux/percpu.h |  1 +
> >  mm/percpu.c            | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> > index 68fac2e7cbe67..8c677f185901b 100644
> > --- a/include/linux/percpu.h
> > +++ b/include/linux/percpu.h
> > @@ -132,6 +132,7 @@ extern void __init setup_per_cpu_areas(void);
> >  extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gf=
p_t gfp) __alloc_size(1);
> >  extern void __percpu *__alloc_percpu(size_t size, size_t align) __allo=
c_size(1);
> >  extern void free_percpu(void __percpu *__pdata);
> > +extern size_t pcpu_alloc_size(void __percpu *__pdata);
> >
> >  DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
> >
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 76b9c5e63c562..1759b91c8944a 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -2244,6 +2244,37 @@ static void pcpu_balance_workfn(struct work_stru=
ct *work)
> >       mutex_unlock(&pcpu_alloc_mutex);
> >  }
> >
> > +/**
> > + * pcpu_alloc_size - the size of the dynamic percpu area
> > + * @ptr: pointer to the dynamic percpu area
> > + *
> > + * Returns the size of the @ptr allocation. This is undefined for stat=
ically
>                                               ^
>
> Nit: Alexei, when you pull this, can you make it a double space here?
> Just keeps percpu's file consistent.

Argh. Already applied.
That's a very weird style you have in a few places.
$ grep '\.  [A-z]' mm/*.c|wc -l
1118
$ grep '\. [A-z]' mm/*.c|wc -l
2451

Single space is used more often in mm/* and in the rest of the kernel.

$ grep '\. [A-z]' mm/percpu.c|wc -l
10

percpu.c isn't consistent either.

I can force push if you really insist.

