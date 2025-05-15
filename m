Return-Path: <bpf+bounces-58330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B5AB8C47
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 18:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C246A05DAA
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D421D5BD;
	Thu, 15 May 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgtpFgFr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB121CC46;
	Thu, 15 May 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326244; cv=none; b=TtaafiYFvAnIVXo56otgeXWKIkfOftAXE38tFE87hWyL2qkzB6u22uppE7yFPyC7te0Cq6KJ5iC5DXLPWAwkQdG6cTo1VxcqXsm3PqT3iPdUgZVA/5GycMxVkz8wDq/zqHFs2n2puYBEaTbVDCnbMAM68iUarXCaZR/8O9ChFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326244; c=relaxed/simple;
	bh=se9EXUVKBwSg4FhegCi5R+wYWLgRn6AqCTMjOA1vMrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD7obCvzu8cq8pDQI0cwzde+GpVu/UaJodJf1jDR5Pj3Xcjy+KsW8Z/JuB46I9RUUai38rRFGcUlEpPW30+/RCnWYXiijg5dfOpNDukk71s9af/wV1Goj7inbozoymPFCyc5AR+63RkSWwAcAc1eC2IiI1kQAqyoazBoIw5Ding=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgtpFgFr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30a894cc07cso1121793a91.2;
        Thu, 15 May 2025 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747326242; x=1747931042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSSLU5jUV72K3/zMV5itWSXDtvetINJNPemI18+QmMw=;
        b=AgtpFgFr0YEvxPIblZcQaUqpVDKVDJ8z9gaN+iUETxzc2gGkB1i4caEACcO+wYNtWa
         G7JsIRs1sy7ZL1w6XNL5ncQQ7wa1W1HTsJZJWDZ9UzMc70DQiuNCHQI1VXYNSykfpABC
         lxeB+T8rVSmgct1nuTtKfrh/0k4M9ocgAzaqX+bCmVOsGpILEvwUQB9zsg2HhsBJz33g
         ZD2BWzC7b9w21TOG/pk58RxYxRc19GFUcW0nS2ppwuXXP1pLacpCLOaDwB+gDIg8WabQ
         kSkxcTUTTR54yGdRgTNmpY1KZ03zezDs0Bt8pUYYSXPhqzuwcrfCBjzm5C2mb6ZUhM+b
         JoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747326242; x=1747931042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSSLU5jUV72K3/zMV5itWSXDtvetINJNPemI18+QmMw=;
        b=X2pFniK2seG7RlcFG7bs+7h/yo2MtNDYvbLIdb4mEWoN+OQRWfAREMiLiFX+NnFPXN
         TB8GtUSFZKCTR9ekSNApbzvCZhTQztdKmTRbpg/Pn5xOWNSeHw913LJjAeBklAKbSlpn
         26cidQRsFsliSi7LxRq/wb39a7cWWhGVw0E4Lg1RWUyVe/6MLlubBweyc7K1pwq3EnTE
         Vgpznb9B9u/vNc45CJgd3a/BGnaCRBTMfIOuXCWqYuCWdsG4hKA6S4MbVkmw5rLWMpvu
         gCaCeL875Yo/rnYEqgDP3re4ij7ljrUJgbM9My1wHN8+mgbBOykA3mXbeGbXChOHTeCr
         Idfg==
X-Forwarded-Encrypted: i=1; AJvYcCWHs4+6UPEqCF32rscN15rNoyszqmK8zBV5yjo6lmysJghxf7mRwTZYVmt5HtKIk7WpE9tgC8i6VA==@vger.kernel.org, AJvYcCX6DDGOdAxMtTNpf6A4CkiIiSBUpkwn9TMQyN6KwJ6gd95k4rFCtrDMo7OPYtntFq26DBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQEc1vEt0ru6rxXSkqo16WAcj5KbLHA2+wq5ga6Y+AR/fnlx6
	zhuTxqz5D27gQWWNyFP9T1YSlpSvgzS6Y0EzxaX25RkjFSShGSrofFPt9csZIdnz7qfK+pqx+pM
	cJAinHYFhCFR/l/GSMaSBoHB0YsWt69Y=
X-Gm-Gg: ASbGncuTo3Tude7Lww+1FtfPU7LQnwNVLaWpV08KNXcE3xpAXypUNrSF+2N/XhcuKJ5
	H7YX9Lfx/ZKUZA01jL23e2hf8030+IPxb77K1YWAshulT3BuHelE1irATlujBt/c1TVgmetbAnl
	88tG4c18MhEf9D0LCjymiUqEv6IJbUhijOhQT/GVuh0Kng4sHk
X-Google-Smtp-Source: AGHT+IF/YlLlKsL34MJi9somM0yMkKefXpFqmi/UrwSRvCNSnfMKDMr2czK3ren6STR3i4WwsBggwNXo4mZkyr5hywY=
X-Received: by 2002:a17:90b:3f4c:b0:2ee:f677:aa14 with SMTP id
 98e67ed59e1d1-30e7d5220dcmr79582a91.13.1747326240853; Thu, 15 May 2025
 09:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
 <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>
 <aCG8kz1eZjjw+sSU@kodidev-ubuntu> <4bc9b6c3-4e02-48d3-9b07-c7b1069bfd35@oracle.com>
 <CAEf4BzZoWiBqSBhmxviQ21hQ21m5eKQ=CUYk9AMAB+Z3xFkpGw@mail.gmail.com> <aCWfjGXbLCiGxSf8@kodidev-ubuntu>
In-Reply-To: <aCWfjGXbLCiGxSf8@kodidev-ubuntu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 09:23:48 -0700
X-Gm-Features: AX0GCFsokdU9306Qaedk8p9RsW53scD5Qa8ci0yK2b6LDrDWzLBwOmLtLvlz584
Message-ID: <CAEf4BzbeXEpz4bcjXeRaLUHLiWAsERrSfZqCOrLjb5vKLNmrhQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/3] bpf: handle 0-sized structs properly
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, martin.lau@linux.dev, ast@kernel.org, 
	andrii@kernel.org, alexis.lothore@bootlin.com, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 1:02=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> On Wed, May 14, 2025 at 09:22:00AM -0700, Andrii Nakryiko wrote:
> > On Wed, May 14, 2025 at 3:31=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> > >
> > > On 12/05/2025 10:17, Tony Ambardar wrote:
> > > > On Fri, May 09, 2025 at 11:40:47AM -0700, Andrii Nakryiko wrote:
> > > >> On Thu, May 8, 2025 at 6:22=E2=80=AFAM Alan Maguire <alan.maguire@=
oracle.com> wrote:
>
> [...]
>
> Hi Alan, Andrii,
>
> > > > Given pahole (and my related patch) assume pass-by-value for well-s=
ized
> > > > structs, I'd like to see this too. But while the pahole patch works=
 on
> > > > 64/32-bit archs, I noticed from patch #1 that e.g. ___bpf_treg_cnt(=
)
> > > > seems to hard-code a 64-bit register size. Perhaps we can fix that =
too?
> > > >
> > >
> > > So I think your concern is the assumptions
> > >
> > >
> > >         __builtin_choose_expr(sizeof(t) =3D=3D 8, 1,        \
> > >         __builtin_choose_expr(sizeof(t) =3D=3D 16, 2,        \
> > >
> > > ? We may need arch-specific macros that specify register size that we
> > > can use here, or is there a better way?
> >
> > we know the target architecture, so this shouldn't be hard to define
> > the word size accordingly and use that here?
> >
>
> Well, I'm now unsure if this is a problem after reading the code more
> closely.  The ctx is a u64 array and the PROG2-related macros process ctx
> elems within the BPF VM using 64-bit regs. Does this mean the macro/union
> magic all works OK then?

I'd think that it's still a problem, because on 32-bit architecture if
argument is 8 byte long, we'll use 2 registers, and each register will
get their ctx[i] and ctx[i + 1] slot, so we need to take into account
32-bit vs 64-bit distinction when calculating how many ctx[] slots we
need to use/skip.

>
> Unfortunately, I cannot test a 32-bit host easily since JIT trampoline
> support is still a WIP in my arm32 test setup. But perhaps someone can
> share tracing experience with ppc32 JIT, which supports trampoline?
>
> Thanks,
> Tony
>
> [...]

