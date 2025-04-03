Return-Path: <bpf+bounces-55233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7572A7A59D
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895F5188EE27
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051062505CD;
	Thu,  3 Apr 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX3xf5ND"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6724F5A6;
	Thu,  3 Apr 2025 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691527; cv=none; b=jCmWiB6TlsZ9vd2eboJFoaN+xJU810ivDt/UBBVzOKtKNzHk+Uhm/YNHvyrWKVVROSO0hMoAmRICM4LkgJozQW/p2kaq5s+3AxKXlfrTGSynJleMBJVSbgstwg3DrkbXNrYKCaO+k7YaOcXyUZFko4Sv3l1clwo6FhcjHWx6eNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691527; c=relaxed/simple;
	bh=UTQihElZQ5slBzHwnMe9XjlMj4GC7cZtIpl186iaDmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBeCigheZvdoScy1s4Xi4ZcpN55ojrvCEZx1/ShdxxuB1rym9WiYU7c65JSadYVc1aH1qjhoV2/2cZrKQWy4i0IyoWr46m/NpkeDzZVSrMho8jToc0xNQXWXbVipB8jD57OnnarfbN55jqoDq9uM5CVL9L8iWdPz+tLjp4n2MlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aX3xf5ND; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso673710f8f.2;
        Thu, 03 Apr 2025 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743691524; x=1744296324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAXcEeCo52+sxV42Segun77dZyr6wVKhub4LOcewIv0=;
        b=aX3xf5NDwZPFHWpUirvRROnlQT91x5J5auqZxKIocjNNWqN6DGlrsQLTiK43cqmIbZ
         lnAmOUzewEUvRqkZIzQMvhyuUm3DE2TbIrTw/rfyLqQtaGdaBJFk2E0IH/02d3TJGhd9
         BoI+F4+UN5rCx5DorD50EoI7PZXyfkVZUsjMfdNqlpuZ5mSuS84b4uP3+HXp56TB3MX9
         tDa/jbjpL2VwCp7eSnUlndt4VfGKg6cRArdf8OO+QC6y4e8uoLvaCpSF7CUWWd2XVeyQ
         dZL9cVcI5MWarzJsfnXXFjjJiOHB4awIm9ZzhlF+5jOJupIWkhi5ANZk+qRdLSudGQUp
         Mfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743691524; x=1744296324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAXcEeCo52+sxV42Segun77dZyr6wVKhub4LOcewIv0=;
        b=f+GjX0sTVnulgN/Jv3Uvp1A7fzKZ4m5rNDbGqZka2Gz7Xua455QvPMokMQjjimn7C8
         BkhD0V6KRK+wVr9HSyBIuKno77sqKK9ogDO4/RuZsfgexuWhZhYM13vrAZUsbBzW40Ij
         NRRR7ZubRJXZvZKrLlX1G4CRPTbr3lUNh1z4o13bwxRObe2T8b8U7+M3GLMs6DpQaLJU
         L7lZK2Zi+ULqCTrES7lET1lgu7n6vjKI4bverlECu3bp+44o1P02R7rwS8XdblySuNPW
         8wfCb5DFAO2ebXBuGPKlE7TLXPDzTLd06GK8/W7lfmUbfkzsJp63cQo4Snnmv3UpGJn6
         Jzdw==
X-Forwarded-Encrypted: i=1; AJvYcCUILjicIa6EvbOabgjjJlgTu2oRSArtuTVZVC6P4rmHSJvNDOYnszMyHu2B87hdNaLUJ+95a/lLRzPWUjRZ@vger.kernel.org, AJvYcCXUOfIicSlVPPe65qPmKUzomyhsfdaO3OqoLRca4xLaaa8H58lCCMQ89/djgcMTiZOzvUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy21/9XF9yeazPuc79S/ZAbnm3aYGJ62t8CX9ED57OaYyW69QlI
	zrSdoIz+6Ps+YESeXCBDE1UdculbeKAmHfIYhdtnSBB3YpsTooVGNqX3hj2yZvs2vTiYC9AVYAv
	HCY9iMFUg59qYr442vfxA6Jh18xs=
X-Gm-Gg: ASbGncsllDFrdyei4yhBAcCo9cKGGvfpyRUrHfLElcbWIUNIo4XhQTMGl8hDoxRon4N
	kz5JHs3BFAVqgfRKMnaFkGdAXYZGu8bsuicrcimgWDx5RJs+IhojAFRblgNtHyrJHIC+BVHX5KL
	ht2Bhu/SzhqmAbfhS+9PoDFPjdDE2hPmMYTcIYh5AhSA==
X-Google-Smtp-Source: AGHT+IEuDq2JeknkTgtYMJm0vZRlgjuGmVz91fqykITW03ONam2Owqld+Uik23to+hzCk0cHIhF++j0NsNzcXsg4WEY=
X-Received: by 2002:a05:6000:1889:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-39c1211beabmr19748418f8f.46.1743691523922; Thu, 03 Apr 2025
 07:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401205245.70838-1-alexei.starovoitov@gmail.com>
 <umfukiohyxcxxw5g6ca5g7stq7oonnr3sbvjyjshnbqalzffeq@2nrwqsmwcrug>
 <CAADnVQLHakKsVEbKiENF8eV0fEAtbVbL0b_QbJO2b0dH9r7PSw@mail.gmail.com> <78c2d3be-aa8e-4bb7-8883-7f144a06f866@suse.cz>
In-Reply-To: <78c2d3be-aa8e-4bb7-8883-7f144a06f866@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Apr 2025 07:45:12 -0700
X-Gm-Features: ATxdqUE7tZW6yPfCiD1FSxwr1kqBj9tR4RS57JdjoIH8NsUBbesBsPHz1WvUpAo
Message-ID: <CAADnVQ+m12aU3qWJMTECOTa=B7A_UFSLk4v8MAcr4ZaN5EHdNg@mail.gmail.com>
Subject: Re: [PATCH v2] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Linus Torvalds <torvalds@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 2:26=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 4/2/25 23:40, Alexei Starovoitov wrote:
> > On Wed, Apr 2, 2025 at 1:56=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> >>
> >> On Tue, Apr 01, 2025 at 01:52:45PM -0700, Alexei Starovoitov wrote:
> >> > From: Alexei Starovoitov <ast@kernel.org>
> >> >
> >> > Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce=
 localtry_lock_t").
> >> > Remove localtry_*() helpers, since localtry_lock() name might
> >> > be misinterpreted as "try lock".
> >> >
> >> > Introduce local_trylock[_irqsave]() helpers that only work
> >> > with newly introduced local_trylock_t type.
> >> > Note that attempt to use local_trylock[_irqsave]() with local_lock_t
> >> > will cause compilation failure.
> >> >
> >> > Usage and behavior in !PREEMPT_RT:
> >> >
> >> > local_lock_t lock;                     // sizeof(lock) =3D=3D 0
> >> > local_lock(&lock);                     // preempt disable
> >> > local_lock_irqsave(&lock, ...);        // irq save
> >> > if (local_trylock_irqsave(&lock, ...)) // compilation error
> >> >
> >> > local_trylock_t lock;                  // sizeof(lock) =3D=3D 4
> >>
> >> Is there a reason for this 'acquired' to be int? Can it be uint8_t? No
> >> need to change anything here but I plan to change it later to compact =
as
> >> much as possible within one (or two) cachline for memcg stocks.
> >
> > I don't see any issue. I can make it u8 right away.
>
> Are you planning to put the lock near other <64bit sized values in memcg
> stock? Otherwise it will be padded anyway?
>
> I hope it won't hurt the performance though, AFAIK at least sub-word atom=
ics
> are much slower than using a full word. But we use only read/write once f=
or
> acquired so hopefully it's fine?

Sub-words atomics are slow, but these are not atomics.
Just plain load/store of u8. Should be fine.

