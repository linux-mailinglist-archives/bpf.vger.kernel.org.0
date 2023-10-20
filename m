Return-Path: <bpf+bounces-12858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA617D1563
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 20:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EA31F230AC
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAB6208D8;
	Fri, 20 Oct 2023 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102D208C1
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 18:03:37 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB84FD55
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 11:03:35 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c9e95aa02dso9062515ad.0
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 11:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697825015; x=1698429815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpII6b9oaZNjQ3tCIXcHqka8Qic7Krz7uMGzb0VJeiQ=;
        b=XPkST0XiLRYIQU6n5WTFrW83iK85sBLwEkR/GmXLDawd4Oj5Xqe6OsP1hdUFPcxXM4
         D7FpdJ1yZy7cANiTXbPGQAKC3XiXh2i3RSOxAS4XHks1l6y4pbiHF5Lf53at58IUYDlF
         U8S3iotwtQdUl9F9eFUpqYsU5POyXeAmjce0m2mn46/dnJNFW2R6Je6VcZm8moHWww8u
         O7CcTAF3Mo66EA1LmWte1Q0UvFlUcm6sOR1+c8UphxkQzlFFIwCU3dQ9LnKPapJeote0
         noLrXsUiXRRbZhjmyeOvA/G8mrMWlzv4gbXTDyBgj8ArAJvRaKRdlt+di1L5MYHubMxA
         Hikw==
X-Gm-Message-State: AOJu0YzWuH9XOAzBlovpcYFVUDYHTBaOrFeQvGhRDifJflS3kLH2t3S8
	xeM65ayiP1zC8nHobS/cT1M=
X-Google-Smtp-Source: AGHT+IH9has0vvBvKB7gt/ycVawFyKqF+p+rd0E80S6fa04jM38bTfD3gU/ycmLy0/uNYwt2X03uIg==
X-Received: by 2002:a17:902:e841:b0:1bc:edd:e891 with SMTP id t1-20020a170902e84100b001bc0edde891mr8878263plg.1.1697825014875;
        Fri, 20 Oct 2023 11:03:34 -0700 (PDT)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902708b00b001ca4c20003dsm1812068plk.69.2023.10.20.11.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:03:34 -0700 (PDT)
Date: Fri, 20 Oct 2023 11:03:31 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hou Tao <houtao1@huawei.com>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 2/7] mm/percpu.c: introduce pcpu_alloc_size()
Message-ID: <ZTLA87JYVRLHn/zk@snowbird>
References: <20231020133202.4043247-1-houtao@huaweicloud.com>
 <20231020133202.4043247-3-houtao@huaweicloud.com>
 <ZTK9a4H2iuJrJG+x@snowbird>
 <CAADnVQKREaN65cNMJ0qajjA9=46JWHyK9jdGFKcQ=RwjAMuQKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKREaN65cNMJ0qajjA9=46JWHyK9jdGFKcQ=RwjAMuQKQ@mail.gmail.com>

On Fri, Oct 20, 2023 at 10:58:37AM -0700, Alexei Starovoitov wrote:
> On Fri, Oct 20, 2023 at 10:48 AM Dennis Zhou <dennis@kernel.org> wrote:
> >
> > On Fri, Oct 20, 2023 at 09:31:57PM +0800, Hou Tao wrote:
> > > From: Hou Tao <houtao1@huawei.com>
> > >
> > > Introduce pcpu_alloc_size() to get the size of the dynamic per-cpu
> > > area. It will be used by bpf memory allocator in the following patches.
> > > BPF memory allocator maintains per-cpu area caches for multiple area
> > > sizes and its free API only has the to-be-freed per-cpu pointer, so it
> > > needs the size of dynamic per-cpu area to select the corresponding cache
> > > when bpf program frees the dynamic per-cpu pointer.
> > >
> > > Acked-by: Dennis Zhou <dennis@kernel.org>
> > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > > ---
> > >  include/linux/percpu.h |  1 +
> > >  mm/percpu.c            | 31 +++++++++++++++++++++++++++++++
> > >  2 files changed, 32 insertions(+)
> > >
> > > diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> > > index 68fac2e7cbe67..8c677f185901b 100644
> > > --- a/include/linux/percpu.h
> > > +++ b/include/linux/percpu.h
> > > @@ -132,6 +132,7 @@ extern void __init setup_per_cpu_areas(void);
> > >  extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp) __alloc_size(1);
> > >  extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
> > >  extern void free_percpu(void __percpu *__pdata);
> > > +extern size_t pcpu_alloc_size(void __percpu *__pdata);
> > >
> > >  DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
> > >
> > > diff --git a/mm/percpu.c b/mm/percpu.c
> > > index 76b9c5e63c562..1759b91c8944a 100644
> > > --- a/mm/percpu.c
> > > +++ b/mm/percpu.c
> > > @@ -2244,6 +2244,37 @@ static void pcpu_balance_workfn(struct work_struct *work)
> > >       mutex_unlock(&pcpu_alloc_mutex);
> > >  }
> > >
> > > +/**
> > > + * pcpu_alloc_size - the size of the dynamic percpu area
> > > + * @ptr: pointer to the dynamic percpu area
> > > + *
> > > + * Returns the size of the @ptr allocation. This is undefined for statically
> >                                               ^
> >
> > Nit: Alexei, when you pull this, can you make it a double space here?
> > Just keeps percpu's file consistent.
> 
> Argh. Already applied.
> That's a very weird style you have in a few places.
> $ grep '\.  [A-z]' mm/*.c|wc -l
> 1118
> $ grep '\. [A-z]' mm/*.c|wc -l
> 2451
> 
> Single space is used more often in mm/* and in the rest of the kernel.
> 
> $ grep '\. [A-z]' mm/percpu.c|wc -l
> 10
> 
> percpu.c isn't consistent either.
> 
> I can force push if you really insist.

Eh, if it's trouble I can fix it in the future. I know single space is
more common, but percpu was written with double so I'm trying my best to
keep the file consistent.

Thanks,
Dennis

