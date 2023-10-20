Return-Path: <bpf+bounces-12870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1B7D17E7
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 23:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B0BB215BD
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5E24A18;
	Fri, 20 Oct 2023 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS82LXwD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B220315
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 21:17:59 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B168BD65
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 14:17:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso21175611fa.1
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697836671; x=1698441471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VSu/up4BtxqY9kA9X5D7qVX7VZc1rv3uL9WcJiZCGo=;
        b=LS82LXwDbvK76nGgfdAgtwy43BC6KnggQk1rWTXIOW8m71zbxvfnuxppamu17yOOxd
         6bvGsCcLkAUJjpnvGvGt3L8bCuIrlWZgqzv0ULcUUCG3HaQBuOOkQ9F3XGcaUIrAdyoe
         x3BZE8pHNcOS+MH5zFkEgkQcE7K0DAq9GHaNz6P02T0+p65MW2C95XOVLzXlbh6SzZDh
         JQckwz4ypCJcsTh1fXlGwjJZFkdhdlWC5D8YMRUczZBsv76hdjT7XigjGYqynJ5TcOyA
         JteSmRprtlmLzOon3NIBqDeKuvGlrAIX1q/ba0e/fzydbvTcsPmKKjoDUlm/ms3e9zeJ
         bYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836671; x=1698441471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VSu/up4BtxqY9kA9X5D7qVX7VZc1rv3uL9WcJiZCGo=;
        b=rOj8+nsBOnamKZ6Kzg9jmL8I9GHRWpkAnjCVRh+pg/ReP72e7X2QE4lkDDhVQPc2v6
         uSgI+hYmEg7UNsIjSYWJ2xVP97RgXdTQMWsNFl3rszyB04Y5If3h1qZL7fPwDbiz+CEa
         m94C6EJs5l5jZhORV7SCGbBlIcL3z2RUzdg+z8jelW4BqEtIET+/iq5LnDRLsDGxZYrY
         EwlF6CMMEXrD0SrisQBgoXvMrso0upVqX6nG3GrFjeIWMIDVTZd6t1kdppwjAHix1S45
         wnKHpQbcq9WTonHP7dVe0rqoCrXkmJIgI4/asr0xkBY7N9/npfC8os6q2KdnqcyBk+jx
         5Hkw==
X-Gm-Message-State: AOJu0YwTZeXMld0dE7I5YUXlWHRORVUOZ5hipTvM51q8b9/nDfVDiKLV
	Kie3fsiAXb52PpVxDy+MYCchMJTjhq4NBGqEdt4=
X-Google-Smtp-Source: AGHT+IGZVYhkb9MhLLVxzdsiQWh4RDf1U7olKW8wE7vuUmxOpZ31dkeH/Y14411XKhkmSc5K3FsSJKDrA3/S/KBwVjw=
X-Received: by 2002:a2e:a589:0:b0:2c5:1a40:f26a with SMTP id
 m9-20020a2ea589000000b002c51a40f26amr2108118ljp.13.1697836669959; Fri, 20 Oct
 2023 14:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020133202.4043247-1-houtao@huaweicloud.com>
 <20231020133202.4043247-3-houtao@huaweicloud.com> <ZTK9a4H2iuJrJG+x@snowbird>
 <CAADnVQKREaN65cNMJ0qajjA9=46JWHyK9jdGFKcQ=RwjAMuQKQ@mail.gmail.com> <ZTLA87JYVRLHn/zk@snowbird>
In-Reply-To: <ZTLA87JYVRLHn/zk@snowbird>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Oct 2023 14:17:38 -0700
Message-ID: <CAADnVQJiDfTgE_pEirDf2z0cc93pyWQnNCWnmOp=uks=6FViAg@mail.gmail.com>
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

On Fri, Oct 20, 2023 at 11:03=E2=80=AFAM Dennis Zhou <dennis@kernel.org> wr=
ote:
>
> On Fri, Oct 20, 2023 at 10:58:37AM -0700, Alexei Starovoitov wrote:
> > On Fri, Oct 20, 2023 at 10:48=E2=80=AFAM Dennis Zhou <dennis@kernel.org=
> wrote:
> > >
> > > On Fri, Oct 20, 2023 at 09:31:57PM +0800, Hou Tao wrote:
> > > > From: Hou Tao <houtao1@huawei.com>
> > > >
> > > > Introduce pcpu_alloc_size() to get the size of the dynamic per-cpu
> > > > area. It will be used by bpf memory allocator in the following patc=
hes.
> > > > BPF memory allocator maintains per-cpu area caches for multiple are=
a
> > > > sizes and its free API only has the to-be-freed per-cpu pointer, so=
 it
> > > > needs the size of dynamic per-cpu area to select the corresponding =
cache
> > > > when bpf program frees the dynamic per-cpu pointer.
> > > >
> > > > Acked-by: Dennis Zhou <dennis@kernel.org>
> > > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > > > ---
> > > >  include/linux/percpu.h |  1 +
> > > >  mm/percpu.c            | 31 +++++++++++++++++++++++++++++++
> > > >  2 files changed, 32 insertions(+)
> > > >
> > > > diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> > > > index 68fac2e7cbe67..8c677f185901b 100644
> > > > --- a/include/linux/percpu.h
> > > > +++ b/include/linux/percpu.h
> > > > @@ -132,6 +132,7 @@ extern void __init setup_per_cpu_areas(void);
> > > >  extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align=
, gfp_t gfp) __alloc_size(1);
> > > >  extern void __percpu *__alloc_percpu(size_t size, size_t align) __=
alloc_size(1);
> > > >  extern void free_percpu(void __percpu *__pdata);
> > > > +extern size_t pcpu_alloc_size(void __percpu *__pdata);
> > > >
> > > >  DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
> > > >
> > > > diff --git a/mm/percpu.c b/mm/percpu.c
> > > > index 76b9c5e63c562..1759b91c8944a 100644
> > > > --- a/mm/percpu.c
> > > > +++ b/mm/percpu.c
> > > > @@ -2244,6 +2244,37 @@ static void pcpu_balance_workfn(struct work_=
struct *work)
> > > >       mutex_unlock(&pcpu_alloc_mutex);
> > > >  }
> > > >
> > > > +/**
> > > > + * pcpu_alloc_size - the size of the dynamic percpu area
> > > > + * @ptr: pointer to the dynamic percpu area
> > > > + *
> > > > + * Returns the size of the @ptr allocation. This is undefined for =
statically
> > >                                               ^
> > >
> > > Nit: Alexei, when you pull this, can you make it a double space here?
> > > Just keeps percpu's file consistent.
> >
> > Argh. Already applied.
> > That's a very weird style you have in a few places.
> > $ grep '\.  [A-z]' mm/*.c|wc -l
> > 1118
> > $ grep '\. [A-z]' mm/*.c|wc -l
> > 2451
> >
> > Single space is used more often in mm/* and in the rest of the kernel.
> >
> > $ grep '\. [A-z]' mm/percpu.c|wc -l
> > 10
> >
> > percpu.c isn't consistent either.
> >
> > I can force push if you really insist.
>
> Eh, if it's trouble I can fix it in the future. I know single space is
> more common, but percpu was written with double so I'm trying my best to
> keep the file consistent.

Ok. Fair enough.
Force pushed with double space.

