Return-Path: <bpf+bounces-57289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF4AA7B59
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B150F3B013F
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12934202C46;
	Fri,  2 May 2025 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGEPYJjB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0829408;
	Fri,  2 May 2025 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221029; cv=none; b=IHAqRy0RuatdsYmefkk/nbQKt39w/9UeSVnr4D7HSOQBdEV/cnpPj8lcFQ4/fT55BcodCRhC5ASJWoesRguw4fcR98WoybeTqth6YAPi3aiQcpRpfr2Ict8eNfL8MW3TxYyopS6ghHStzD3hxbz56iGcHDb9SFhhXNEXZRAgl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221029; c=relaxed/simple;
	bh=FyN1Jxvx9vWF/1rHBCBRBSb/jRwJ0LrUfPuIFZ02pnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWnKFc6KvE/AvDsHGHVDislGySRgt9bdRJxu78ZVEGlvOSbJ0HVeizF/Qlqrk0VdoM5YUhr8G78SuNMDVxAGJG8Q4OWTRsdwK+C5iBugs1iEDsnE/oIDtXS9aND3L7QUAQDGuhOodWzv3ydbTMF2DtsN5D6dkMRbX95ivR69+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGEPYJjB; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-708d90aa8f9so6983247b3.3;
        Fri, 02 May 2025 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746221027; x=1746825827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyN1Jxvx9vWF/1rHBCBRBSb/jRwJ0LrUfPuIFZ02pnQ=;
        b=GGEPYJjBARq4v62941Yi3q1lHW986cMAqraE7qJ9qOVpcY3Cn+xNA15W4mbqSOwCb0
         EZy/Dlyc6smPTwbsdnNpH9UXxehCIcBP91bJCM7Mfhpg+lKcYwp90qps8mI4q1DkCIRR
         GysrsthnHfaLH7eDjs2CiLh1MgtHNFhwEwpBcvsQjI/r98g66Aymix+zkYFAp5iB1eaY
         owxPnZNhkQgVXjscELrU45pxxLuPACDf8a/qlO5yuTxAcsu6ZmMzey17XPWkDfsuFXIG
         B+ZWGg64mIAGHTFWP2y7YjUJTQLU4Y59YVCBZEmfVj0TWkZo4QHjK9sKXPmEgKuBHn5L
         61tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746221027; x=1746825827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyN1Jxvx9vWF/1rHBCBRBSb/jRwJ0LrUfPuIFZ02pnQ=;
        b=L75aDMEKy8rEkRtd+mrbh6DbGM3OiSp6QyQh6zmx5HL/6mHmj/jonWu6v434qKr039
         DOUCJC8qcx5rVzmqa93UMRwR5thGXRFyuUKzhtN+fNATthGmSvpmqoTemNhx9BWpaDqk
         vQFTZeghgftuKw/yPe2i48HH8EkLiuUKHBKCMSNmADuPsfuVP2t7pI9wZDJzUJ1uQrG0
         N0b02WbnsTMUxlDKKgWJLZJ74xuCCWO14+FuVEECSXDCgSSWb8VIsh2Um9w1nqHjkxBY
         2u7M6d5vDyyp288NsXwVG2aiWFcTXSXSNvygGez9WhL+ebNhcze19l1vIjKGnSK71nhn
         H/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvZppm8BnDQW/elxYyD7StspGFRHiFHKwfffZURl/yavbYSsIDQElpdk6HedBa5zXIezh4WhcB@vger.kernel.org, AJvYcCXAkoB87smoZmybduA2bS8hie6uAMn6099I1uv19cUFytcXbS1h3ZYH8fJIJOpZJ1M1Li0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfj+0OV9seTZG8xfVZiGyBEezlGPDeGv54wa/tsqshY2KCYCyx
	h4gSKFqBhnhyXO0KleAWx1TZk63v8gn0k55V2udgAhYMFVZL7k2Igt9VD1M+yd12rHmsenVpwLs
	2rH+SymK4tMKuioLVnru5XlG4L+A=
X-Gm-Gg: ASbGncszDjxwssEb2ekgyEVWYk2emY0fGFHseskSw82CD9OcJNgup9+zMDyo4AUg5Zx
	mz1oKRI+mFXlFpFiDbYQSkLj8t/VWfsD8x4CbBHBa/pBqpKcudOx9kcokhqVn3AIoiSbwjXRJNa
	mJxuLTjwp+UvFHf0NaPk0PIw==
X-Google-Smtp-Source: AGHT+IH9mmZ04BzDBsqABy5EIDb0pYDBrR/hgs0DaFu5Gu7HcfGFB8uW6wVKeXJmZ/HdNAZrW+XVgsLhncs5uUxpuro=
X-Received: by 2002:a05:690c:b15:b0:703:d7a6:6266 with SMTP id
 00721157ae682-708e11b531amr9275217b3.10.1746221026857; Fri, 02 May 2025
 14:23:46 -0700 (PDT)
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
In-Reply-To: <CAEf4BzYMvYN5aPrdE6i=CTv8dfb1zoDQqngxN6Aj33XN_ryUZg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 2 May 2025 14:23:35 -0700
X-Gm-Features: ATxdqUF_BncPl1_JMxTKSlDRd5NzAMjaORegBCJgCuxvfbhv5sJB1ychdSQr6S8
Message-ID: <CAMB2axPBsi=D3c+ddH0wcmOCC1SV=oMyZPM=+WXCqCnuDforsQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/2] Task local data API
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 1:11=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, May 2, 2025 at 11:36=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Fri, May 02, 2025 at 09:14:47AM -0700, Andrii Nakryiko wrote:
> > > > The advantage of no memory wasted for threads that are not using TL=
D
> > > > doesn't seem to be that definite to me. If users add per-process
> > > > hints, then this scheme can potentially use a lot more memory (i.e.=
,
> > > > PAGE_SIZE * number of threads). Maybe we need another uptr for
> > > > per-process data? Or do you think this is out of the scope of TLD a=
nd
> > > > we should recommend other solutions?
> > >
> > > I'd keep it simple. One page per thread isn't a big deal at all, in m=
y
> > > mind. If the application has a few threads, then a bunch of kilobytes
> > > is not a big deal. If the application has thousands of threads, then =
a
> > > few megabytes for this is the least of that application's concern,
> > > it's already heavy-weight as hell. I think we are overpivoting on
> > > saving a few bytes here.
> >
> > It could well be that 4k is a price worth paying but there will be case=
s
> > where this matters. With 100k threads - not common but not unheard of
> > either, that's ~400MB. If the data needed to be shared is small and mos=
t of
> > that is wasted, that's not an insignificant amount. uptr supports sub-p=
age
> > sizing, right? If keeping sizing dynamic is too complex, can't a proces=
s
> > just set the max size to what it deems appropriate?
> >
>
> One page was just a maximum supportable size due to uptr stuff. But it
> can absolutely be (much) smaller than that, of course. The main
> simplification from having a single fixed-sized data area allocation
> is that an application can permanently cache an absolute pointer
> returned from tld_resolve_key(). If we allow resizing the data area,
> all previously returned pointers could be invalidated. So that's the
> only thing. But yeah, if we know that we won't need more than, say 64
> bytes, nothing prevents us from allocating just those 64 bytes (per
> participating thread) instead of an entire page.
>

Since users can add keys on the fly, I feel it is natural to also
allocate data area dynamically. Otherwise, there is going to be this
hard trade-off between data size limit and waste of memory.

We can tweak the implementation to make it allocate data dynamically.
The two user space APIs can remain almost the same, but users should
not cache the pointer returned from tld_resolve_ptr(). The only
difference is changing tld_off_t to the metadata index.

void *tld_resolve_ptr(tld_off_t idx) will allocate data area lazily.
- Record total tld data size in tld_metadata, data_sz.
- Use a __thread variable, th_data_sz, to keep track of allocated
memory for the thread (can be a small number or 0 initially)
- If offs[idx] + szs[idx] > th_data_sz, resize the memory based on sum
(can be exactly the same or roundup to the next power of 2 to prevent
frequent reallocation)
- If offs[idx] + szs[idx] <=3D th_data_sz, return tld->data + offs[idx]
(fast path)

The downside is data access overhead as pointers cannot be cached, but
I think it is an okay middle ground.

> > Thanks.
> >
> > --
> > tejun

