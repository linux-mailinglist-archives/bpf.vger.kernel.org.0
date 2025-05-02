Return-Path: <bpf+bounces-57296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FA9AA7C29
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 00:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717B61732F9
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609721A428;
	Fri,  2 May 2025 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSrAZ1GK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A091E32D5;
	Fri,  2 May 2025 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746224761; cv=none; b=Bpn8ECMfAOC1JRHx+wKTFRpt8hBVvnSBxGQQM1zFrrpalspYhoctVyYC8GL1c3NgXjd1SdqUgUt5GQDVb3rY7jfylDkLSBtsMDp9Bsnj9FH2Ipq4qYrM6lCtmXL6q9eT9N4K/UIuE8YK4jRnxiSzjHNz5Eqgk4Sec/X67mm6NW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746224761; c=relaxed/simple;
	bh=YSdmhLhG8KrobaZfywtAbZBouJ+Bne6ACUrBx0W+rCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSkzyLr9pSBYDdM5Hy5cdskW/3jz+YnAIHYRVsqxpHDADBR2G0uo6Xd6zkuxlmh22Tm1BM2M5iQdIca32wqgvhiC2iFZh/vBLlaE/EVK6U09OUxhh7FfS3bKBsCS5VUqfZe0FWFdr5DrficJ0a6QpyDzn4hfN3o5CjL9wX1LfCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSrAZ1GK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso2725143a91.3;
        Fri, 02 May 2025 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746224759; x=1746829559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSdmhLhG8KrobaZfywtAbZBouJ+Bne6ACUrBx0W+rCs=;
        b=fSrAZ1GKjdFEzPJ07wBX2RMc60Rpn9XGyWkt05v/FXzx/7VUzKYaGFZqMN320d7EgO
         8gzpzedu66azrO2BIumkWgcKduepT9IgvicDeIzOuwmJsh5OgArENnBM3vQ2BgmNGekf
         rJWXxoTXGxzUSDwzRoRVr9CTqcil1kie0/WDB2Qy1ZkIkxbtCdvuk3tCozW0Q3HmBjLD
         T+vxLr9xbHy6pnt3aa4+fhW7gtOp04djmQJQk9Z69Iy5mcDQVis1M1UFP1EiLU3FIZ9z
         JR2pU51uWByh1uWXNzY1S3kpOCrLkacNsoo9rq7bJFN1+eDJ7HdJ/1VaUXQBlDPlSnoB
         5hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746224759; x=1746829559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSdmhLhG8KrobaZfywtAbZBouJ+Bne6ACUrBx0W+rCs=;
        b=MWn9UGWlKhXa5MbDb3k3tgwgbZ+xuh8MIQLSyhjv5VpOXKafegzS6euTViAmLpMru7
         Ot01tSjxrmsgbyIgInXlXomSck1Qz1THEPrSEoGmGzKxHVxf0eI4B8pDSvm7amw78rcp
         6rPn3g3HrqfYc7GCy0OhMRqs9DqOf+1csXnvmXeGKblW2t7faJ1SN839i3e5zNpbDvq0
         oojG1SiLrGFTU2ZCMfh21Sm6HSuMRrrnsAF8xSGuMGTsWSH4hOhrDo+vVksQdTt2Ckhr
         H8nyux1S3Bs8O2NxMGHJfAzxhNLRk2MK0zc0iZ/GzKHLxMlGjzUpdFCJtNSaQqAbyXcq
         oQcg==
X-Forwarded-Encrypted: i=1; AJvYcCUR75k0+tNHOjvhzGtUJSM9Z3zUoSLMxtvd8D9cA4t4BVkP7+mtUmx03QSjfHJbZkUt7Nz1l2pH@vger.kernel.org, AJvYcCVHXnORXtWFehMRKi4YYuauJveffVOuQJ1rCEPsrZ5JN4WDxZub0F3q2TZonsy7kAX0S+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRTMtwUIdPfNBtLRJ2xFoZmjO5NcS+Q/VVgKM82sCw7i57t9Tu
	0oX1B6oPZQNeWKf7XVjTeOhdgJBpIMsTanxFgkY57+J3Ze2a+uU+YTsmtq5GPa1oNtXBBzo3+nn
	FFVWJbrxTdBwSqugBB165IXlHSXk=
X-Gm-Gg: ASbGncvFMHAcUOOzXeM0Wrc+EzqKBB9V+S5/5FK/+rWm1HG2gaf9qcGNL0ujmgDTSX4
	jzMMzi64z/6U3QzsCdN/PWTF3VIEFJ9CQUXVSZLUnualAnjuvaZ73OApHMxU0c5rlploU+i5NFq
	HfVg1gcR4+Pz/YUqeHBR8B1uhhsC2VnpFis+j7QaKp7ZKLk8fd
X-Google-Smtp-Source: AGHT+IEAvBwSPL2GnSmo2ePWLc3d01jv1CzdHrQvMcC1uCQZ0BVfOo/bwvng8FolBxqy1PL3xQ5KOo5w/h+SDXaUpJY=
X-Received: by 2002:a17:90b:1f8f:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-30a4e411e56mr8512184a91.0.1746224758818; Fri, 02 May 2025
 15:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214039.2919818-1-ameryhung@gmail.com> <CAEf4BzYUNckc9pXcE7BawxWFVfY--p12c3ax8ySP1P+BEww91w@mail.gmail.com>
 <CAMB2axMbAjYVB3+bMuwOszqAn153_9S_vG6iN26-J-n67NGwPQ@mail.gmail.com>
 <CAEf4BzZ=HORw6JnQz=pguoaUSc=swFiaG9mzQLxqLZgTamc1qA@mail.gmail.com>
 <aBUQpPFemrUYxyO6@slm.duckdns.org> <CAEf4BzYMvYN5aPrdE6i=CTv8dfb1zoDQqngxN6Aj33XN_ryUZg@mail.gmail.com>
 <CAMB2axPBsi=D3c+ddH0wcmOCC1SV=oMyZPM=+WXCqCnuDforsQ@mail.gmail.com>
In-Reply-To: <CAMB2axPBsi=D3c+ddH0wcmOCC1SV=oMyZPM=+WXCqCnuDforsQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 May 2025 15:25:46 -0700
X-Gm-Features: ATxdqUFvlwwSICPGVgrj-XKi2KzfxPwN6f-EIyqJoAmXNDSn3jq_rBttoPl66uI
Message-ID: <CAEf4Bza=7s7kBA882YWKoZSfgaeYTXaAO2DXfDdHhm4P-kPMWA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/2] Task local data API
To: Amery Hung <ameryhung@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 2:23=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Fri, May 2, 2025 at 1:11=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, May 2, 2025 at 11:36=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > Hello,
> > >
> > > On Fri, May 02, 2025 at 09:14:47AM -0700, Andrii Nakryiko wrote:
> > > > > The advantage of no memory wasted for threads that are not using =
TLD
> > > > > doesn't seem to be that definite to me. If users add per-process
> > > > > hints, then this scheme can potentially use a lot more memory (i.=
e.,
> > > > > PAGE_SIZE * number of threads). Maybe we need another uptr for
> > > > > per-process data? Or do you think this is out of the scope of TLD=
 and
> > > > > we should recommend other solutions?
> > > >
> > > > I'd keep it simple. One page per thread isn't a big deal at all, in=
 my
> > > > mind. If the application has a few threads, then a bunch of kilobyt=
es
> > > > is not a big deal. If the application has thousands of threads, the=
n a
> > > > few megabytes for this is the least of that application's concern,
> > > > it's already heavy-weight as hell. I think we are overpivoting on
> > > > saving a few bytes here.
> > >
> > > It could well be that 4k is a price worth paying but there will be ca=
ses
> > > where this matters. With 100k threads - not common but not unheard of
> > > either, that's ~400MB. If the data needed to be shared is small and m=
ost of
> > > that is wasted, that's not an insignificant amount. uptr supports sub=
-page
> > > sizing, right? If keeping sizing dynamic is too complex, can't a proc=
ess
> > > just set the max size to what it deems appropriate?
> > >
> >
> > One page was just a maximum supportable size due to uptr stuff. But it
> > can absolutely be (much) smaller than that, of course. The main
> > simplification from having a single fixed-sized data area allocation
> > is that an application can permanently cache an absolute pointer
> > returned from tld_resolve_key(). If we allow resizing the data area,
> > all previously returned pointers could be invalidated. So that's the
> > only thing. But yeah, if we know that we won't need more than, say 64
> > bytes, nothing prevents us from allocating just those 64 bytes (per
> > participating thread) instead of an entire page.
> >
>
> Since users can add keys on the fly, I feel it is natural to also
> allocate data area dynamically. Otherwise, there is going to be this
> hard trade-off between data size limit and waste of memory.
>
> We can tweak the implementation to make it allocate data dynamically.
> The two user space APIs can remain almost the same, but users should
> not cache the pointer returned from tld_resolve_ptr(). The only
> difference is changing tld_off_t to the metadata index.
>
> void *tld_resolve_ptr(tld_off_t idx) will allocate data area lazily.
> - Record total tld data size in tld_metadata, data_sz.
> - Use a __thread variable, th_data_sz, to keep track of allocated
> memory for the thread (can be a small number or 0 initially)
> - If offs[idx] + szs[idx] > th_data_sz, resize the memory based on sum
> (can be exactly the same or roundup to the next power of 2 to prevent
> frequent reallocation)
> - If offs[idx] + szs[idx] <=3D th_data_sz, return tld->data + offs[idx]
> (fast path)
>
> The downside is data access overhead as pointers cannot be cached, but
> I think it is an okay middle ground.

If it's for something like hinting whether the lock is held or not,
I'd prioritize caching of this pointer and performance, over trying to
save a few bytes.

>
> > > Thanks.
> > >
> > > --
> > > tejun

