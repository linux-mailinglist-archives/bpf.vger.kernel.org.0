Return-Path: <bpf+bounces-64328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A72CB11906
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF243BE675
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56F9293462;
	Fri, 25 Jul 2025 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3sRP6/o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FAF291C2F
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427662; cv=none; b=U4Mh5EN9PCFfKePDLXIm2unFBaH8WS2Wd+6jqS+ig1j6JJcsfEZt/9nBxJOtIuMqhGS16bOALO+oxK8FMnKq3BlVeaa+REhacKF1T7Jtp4EhUtGAQEun+6SJeEAnhdskOCfn32W9YhVftHBmC24mW8wnvgIS2qOMQcxr3sN3TVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427662; c=relaxed/simple;
	bh=E4YkhBRj1KR+XPLrBsHY5EKKqoJslsa67oYsFvhdDew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZJbvW3yISWqkyrD/Op/IBmOpuqd5sCWbHARhX4FVwQkDv4Ol1cExX+7L1wixDDBXXNUr1cYdd2jzQQj4cvemoB1+mgTwoTSBJwb+tuT8ruqrK6977zxeIrQWEu4ADBrB8lCw9XoQniTxAjaPylN520X4W5YZ3JThptDsGLnRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3sRP6/o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so20015025e9.1
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753427659; x=1754032459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9vHt5UXfKsv8YlchEcAgj1SPpwPqe3D7/osin4AnlY=;
        b=k3sRP6/obyvGWLd1Q6AGosndkTETfz2sdSF9CwFmyWN4t32775cHEFo6BbmKP3fnxD
         dAQYD9VanTxwHMfpXUn0Ka0geZR02cYfev94PBTxi48cm/IvhWXGJvqL4FRCSIksBHLz
         qILty51Crjf+Qh3utq2DD+evidx1hhgbYrduJjS9So+jYobpMCfl+KXQwu/M1LqMyd13
         7gJGGnHVvAtEyWG2Dc8Xtg/TRkxHWAoXnvFXPtOjjjyHresfFCiCzFAXZcpM1OotWS6I
         K3ArcUG21yRE4KrTknqgvduRuY0iIBymDThHAXPcC541gwvRulLRAvJSonpsr7NkTr4v
         Kg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753427659; x=1754032459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9vHt5UXfKsv8YlchEcAgj1SPpwPqe3D7/osin4AnlY=;
        b=f5Zam2uccgfSaYIhmm0K5FWtle15VdeK0iLW7JNhkbuCQ8xWhEgypNi3tAsOikcxz5
         wAlxDhwvb4srsdMLY/SGAiJkXq9dhS7N3+fC1S78CdFAyjpoKmyMev05F0uPUEBoaDym
         6/iUgOD0ZxMFQ4odKppK1QlI7kyEHIaFePz+IQPsF3TU7swHnqiLJr08RdEs6zPksXmi
         bySmst9E+UTDbWXqpWSxy9iqWJXDWQ1aC1plBZi03s7I25eJdvvwT3lYNy2V8smmUZz+
         8Gav1/qMaL6FC/0ojkcAqO3+g09mxC8W57TU82Sb0Es2IxWbn4hAE/xxjGKAHCi8jy0j
         Z9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc7opdR+/wdr5irYnuHmBgKdVi5HKcXk+7opfAxfbH0P/GdsCYqpLoXls0TLmO5OnNUcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyampwrOfZyFsSLYFkbUC50xEeM7P9Y7zRaRf87FeUQAuveaAJo
	SBMGHUzWLd+qCSEt7hrMRHbeGmZLQ2B/xT1oSEbMDkLt//N4CZLofr8SD/zHSY3fPCX8KqPodyg
	XYcJ+w4r0a4/064U4c1eg6vgQqoQkfch3ED8h1UVb
X-Gm-Gg: ASbGnctgaHm2cM3rY8vvEM/3dxp6RSA/FADeso8n0bNuB0ia86EiMEAREy1+BqnvYuL
	ZXtKBBd+IX6uZt7SWW4Y1UPYf9lkiOFbTN/E23lWlOi0w19naKJA6TMPsjGDNw8TZLyq24EJRp9
	8x3egP4fH8j3b2wmXKASkKpZfWCYTo3zhEbizOVePtuu3zFaqd3x/HB9wmjHfykLBdFMhOZ8tK3
	be0ApPXsjmVrm9ThMWyFVqfytALQEgqByIvzjdZ0sz1CKia
X-Google-Smtp-Source: AGHT+IE4kl/WAV/DJhHC0LW0odI/joljZCgor1iGezxfvCxEn51uKapoKTZqJK2GZ/JKTo8UOtRjEV7yfpgZ91zr4FI=
X-Received: by 2002:a05:600c:4f07:b0:456:58:1114 with SMTP id
 5b1f17b1804b1-45877447996mr3587685e9.9.1753427658863; Fri, 25 Jul 2025
 00:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se> <20250724135449.2cb6457b90926cce1b903481@linux-foundation.org>
In-Reply-To: <20250724135449.2cb6457b90926cce1b903481@linux-foundation.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 25 Jul 2025 09:14:05 +0200
X-Gm-Features: Ac12FXy3-hBwFSqnBK583mYkueFJy_LL2mllk3DPkZ3jUCXGxkbYOdiRiOuntB4
Message-ID: <CAH5fLgjatYenX_xPvRW11BnRw1wP_G19eY-7AqUctnuZ3rGBYA@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] support large align and nid in Rust allocators
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:54=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 15 Jul 2025 15:56:45 +0200 Vitaly Wool <vitaly.wool@konsulko.se> =
wrote:
>
> > The coming patches provide the ability for Rust allocators to set
> > NUMA node and large alignment.
> >
> > ...
> >
> >  fs/bcachefs/darray.c           |    2 -
> >  fs/bcachefs/util.h             |    2 -
> >  include/linux/bpfptr.h         |    2 -
> >  include/linux/slab.h           |   39 ++++++++++++++++++++++----------=
-----
> >  include/linux/vmalloc.h        |   12 ++++++++---
> >  lib/rhashtable.c               |    4 +--
> >  mm/nommu.c                     |    3 +-
> >  mm/slub.c                      |   64 ++++++++++++++++++++++++++++++++=
+++++++++--------------------
> >  mm/vmalloc.c                   |   29 ++++++++++++++++++++++-----
> >  rust/helpers/slab.c            |   10 +++++----
> >  rust/helpers/vmalloc.c         |    5 ++--
> >  rust/kernel/alloc.rs           |   54 ++++++++++++++++++++++++++++++++=
++++++++++++++-----
> >  rust/kernel/alloc/allocator.rs |   49 +++++++++++++++++++++-----------=
--------------
> >  rust/kernel/alloc/kbox.rs      |    4 +--
> >  rust/kernel/alloc/kvec.rs      |   11 ++++++++--
> >  15 files changed, 200 insertions(+), 90 deletions(-)
>
> I assume we're looking for a merge into mm.git?
>
> We're at -rc7 so let's target 6.17.  Please resend around the end of
> the upcoming merge window?

I think it would make sense for this to land through mm.git, so yes
that sounds like a good plan.

Alice

