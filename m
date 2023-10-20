Return-Path: <bpf+bounces-12790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381357D0750
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 06:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E711D2822FE
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 04:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894302106;
	Fri, 20 Oct 2023 04:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDfx2YFO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A25395
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 04:16:59 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCA5CE
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 21:16:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40651a726acso3122915e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 21:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697775417; x=1698380217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq2GHe4S8Tx96jWYrK8W2I7QeV1dNeA11hm6wpM3tp4=;
        b=VDfx2YFOGh9b6xGqM2D5oDdx8A3yTE2Z0WxseanQFPnvzcrsZBjgLUcJ3/94UsyFgT
         j085LHBqHh1sABN1q4KnpsuOINUqFOMc4EBMGSUgE93EQGzMPE9973fR8VoSpM3OXomr
         2IkjDnSro8japw5hVvuFQM3bHt16EFdjBNOaFziirkzFylY7AXYTESYi5Qn/io638Q7A
         IVuwwxjQZpxHZb0RP82u5kXEAxmoR8pBf1ooZKRIFQfx4LvpGjCVkpQCUFTKEY6t19xJ
         nzynSfWblmzH72Bh6CCKOaJMyJvD4hIQe+B0rur4e33Ly83KzRpr0nBhPF3jRWuBs11I
         3Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697775417; x=1698380217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq2GHe4S8Tx96jWYrK8W2I7QeV1dNeA11hm6wpM3tp4=;
        b=cpJ1vyer60wuDI4bFlw8PGR4qQVHzrpQfVQJXL9AvIwp3+ecKoEeX5IMuLd4u2OjPD
         P3IhNts6kM17KUVtQvAAUkbjC8L/zcvI3b91tBufm/ie5RKcC8mJVhK2rMwaj5BjFzqn
         v2TnC9Fqn/DO+1/JGFlVQyIaAYLuyGyYZvdDCbsql0HZP6YXsFcnq8/BcEg1fVST94gT
         WoHO3qhK0rJKfYks4P3+cPRs6SjaQiMGHQ6Af2SAYUxWJqtdaoUKMUpLLx412J7Ns2ec
         WgptjV+86ZsmiNoCkdXRCbn+EKBSxmY6JUXRKTADt7TVG1YoURHlEg3jKB4SDKTGEtpY
         v/dg==
X-Gm-Message-State: AOJu0YxA72kIq/yRlBTwayjpDa49mbDaLH68T42zthCdoQzIrFcf3oF3
	S1+zEjVpi0i51PxFIanEQHAJcMMyzf3MFhcxBPE=
X-Google-Smtp-Source: AGHT+IHy2TNgSOL8g18C52dgy5qs4n8ppcNo+OAu9yOihdXqOOdNEv7ANBv8LcrGgSDb/7EHGOPt0XwsKvzwzLbS0uA=
X-Received: by 2002:a5d:5705:0:b0:32d:a369:1820 with SMTP id
 a5-20020a5d5705000000b0032da3691820mr426273wrv.64.1697775416523; Thu, 19 Oct
 2023 21:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018113343.2446300-1-houtao@huaweicloud.com>
 <20231018113343.2446300-3-houtao@huaweicloud.com> <ZTH9c2kj2jpP0SDD@snowbird>
In-Reply-To: <ZTH9c2kj2jpP0SDD@snowbird>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Oct 2023 21:16:45 -0700
Message-ID: <CAADnVQJ10m1N0zQL-u2UYYnn9yL+RZz4QQgjXxkNrOcBLHu4XA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] mm/percpu.c: introduce pcpu_alloc_size()
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

On Thu, Oct 19, 2023 at 9:09=E2=80=AFPM Dennis Zhou <dennis@kernel.org> wro=
te:
>
> On Wed, Oct 18, 2023 at 07:33:38PM +0800, Hou Tao wrote:
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
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  include/linux/percpu.h |  1 +
> >  mm/percpu.c            | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >
> > diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> > index 68fac2e7cbe6..8c677f185901 100644
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
> > index 76b9c5e63c56..b0cea2dc16a9 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -2244,6 +2244,36 @@ static void pcpu_balance_workfn(struct work_stru=
ct *work)
> >       mutex_unlock(&pcpu_alloc_mutex);
> >  }
> >
> > +/**
> > + * pcpu_alloc_size - the size of the dynamic percpu area
> > + * @ptr: pointer to the dynamic percpu area
> > + *
> > + * Return the size of the dynamic percpu area @ptr.
> > + *
>
> Alexei, can you modify the above comment to:
>
> Returns the size of the @ptr allocation.  This is undefined for staticall=
y
> defined percpu variables as there is no corresponding chunk->bound_map.

Good point! Will do.

Thanks for the quick review!

