Return-Path: <bpf+bounces-51456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D2A34C42
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C549188B26F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9622241661;
	Thu, 13 Feb 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJcm7I66"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8B28A2AB;
	Thu, 13 Feb 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468743; cv=none; b=buKOwgbaQ/8WeSaTfPp/gJ9YVg50m0Mwui/3v7rdHuxRAY7KrDOKEcSHol5ToCkw+Tyq9TPJ9e4TafGj7AAquQWHIH430rF+n80BdwIb3ajKeFv9lnQA2Yvallze0s8Zq8QL1nwYEfOdZuyW7QKBJRvp+QqQrpVDO7wj8gUrsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468743; c=relaxed/simple;
	bh=PmAdWEbi90xoXbqeyhZd9i11ObSkywA5DyrbKNqngoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO/IJHs6rDA8hK9I4SNklE8W9IRvLQo8Jd4zyIeJkJeYU1yVKvBiGyt8ZHFAf7AChP/Pah8oDKxjgvue6TKoXQgOnFoVony3iliwugSey8iN58g+2ZEG94oKsvZKEAFpUh2tlXakSbyYLp8vfD26hlbLkaqOgMx6RzEBrfz3STg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJcm7I66; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7b80326cdso221291266b.3;
        Thu, 13 Feb 2025 09:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739468740; x=1740073540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DxAeba9M2XA2A0lJ5DQh+1tf+Q3Gd7KjdbaW+Nt1Yo=;
        b=fJcm7I66ysjF1ave9jCY4fBikPQutwNXtCWWT8sLa4eKOGxn/HprI8tlBY3OXhUsEP
         GTkKaSldEQooezFyggXZjk7n0BA+ZO8ShnUO/a9OsC4HzoViSnU+uhtSWKuJMmhqc1Tj
         S/jCCwXw4SP7f7aOr7QSNRnuBbqZye0dCz1qhd6kFeITHiyFwcVQhGG57L0rzr7OoZ51
         IBIr3VDTwNvLGrTPrmhWjZ6/mh2OcmnP0xXorJfyKBXTj+IcIOf4nE2mR2ac4PSNEq+G
         2oPLjh2qOQX/4MUH4idBJLkEk1DSDYNVcx+PxKXUNQw4WD7VYhGnr5xFqxuKuQAg+JEo
         om+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468740; x=1740073540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DxAeba9M2XA2A0lJ5DQh+1tf+Q3Gd7KjdbaW+Nt1Yo=;
        b=ZQILLvz3AjFDX/yfzhQVX+6zmbf9kSVs6HnRqdo2MgPn2QBS6GR4r4aClfEKDRaE5E
         CKixGaO1Rz2TveF/Zv6x2te5VG91dMthn/LsokSLIKJGmuowai5Ewko128sP62MTeTc5
         0Jg7/flLxHceNBbdspxld6xu+HsAab/5M4yY8Zc0cv8SMSL7v2AJEkmwTgTgwMciEdx5
         TtQSmVWgnwVcWBUnrx4Nn0ksJa76NhR0zyIlKQdM+oaymdYrLwmF5FEeceFRxuOCYy/8
         lDY8TQEGlG3GKAPA5u7zgbENjkqi0vXWLEd+NmkUh1mY856wBIrWJf1dNOU7xveS5gE+
         D/cg==
X-Forwarded-Encrypted: i=1; AJvYcCXDO7ZMzqEY6hoil2APwvn7cYDY81xMO5a0OLjfusGF4WTZMauH7oA6bFLoljY7ipQPsvNdZ/yWji5/qMy4@vger.kernel.org, AJvYcCXz43yBAEQvsVa8si+DpfrIKj00a90L3xKk3QbwQqtNg+Zlv4ksFKW6N64+4BsUGnludcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhT336rzVrcqods5tH4mCJsWWzG09ZHYN4pKz6YdIcCFegtfsb
	NBdSXmvrglYJltLPBA+2ayUMsveMv0igTCWpA2V9gj7p/mB4hymKKWYoKF/zVbKPQ3m0ozbgTH9
	xKy+3esqI7ZHL53WicTYDCyWFq20=
X-Gm-Gg: ASbGncst1ECKNyB6AVmwaURHIX14eo7fMXDgHYg+argLphfQqG8IDGwapEbBxEnpEQ5
	Al7K915nuHO3ryAOtpxhX/R/ncI05eP+/WYLzx6UlG4fkyU1dH2Rf84eyqwaQ2v197tX4i4D/PS
	a6dkLVI6lIz6FE5/cRaRaa6wAvpyxk
X-Google-Smtp-Source: AGHT+IHqeY5d+52cUyWchdA3Vyx85e0DJbAPSnBMk7d3/pOwkPFNLrSVtTvldPrjQfjfxc1TpwrAhxbSoV5cG/cv57g=
X-Received: by 2002:a17:907:d0f:b0:ab7:d87:50f2 with SMTP id
 a640c23a62f3a-aba5018c398mr418557766b.44.1739468739508; Thu, 13 Feb 2025
 09:45:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212084851.150169-1-changwoo@igalia.com>
In-Reply-To: <20250212084851.150169-1-changwoo@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 09:45:26 -0800
X-Gm-Features: AWEUYZk0AK_5uP6Hf6gl3zD-S3O24aXnOI3BDH9qrEu9XNHWmPV9rS-7BIWOISE
Message-ID: <CAADnVQLRrhyOHGPb1O0Ju=7YVCNexdhwtoJaGYrfU9Vh2cBbgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add a retry after refilling the free list
 when unit_alloc() fails
To: Changwoo Min <changwoo@igalia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, kernel-dev@igalia.com, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 12:49=E2=80=AFAM Changwoo Min <changwoo@igalia.com>=
 wrote:
>
> (e.g., bpf_cpumask_create), allocate the additional free entry in an atom=
ic
> manner (atomic =3D true in alloc_bulk).

...
> +       if (unlikely(!llnode && !retry)) {
> +               int cpu =3D smp_processor_id();
> +               alloc_bulk(c, 1, cpu_to_node(cpu), true);

This is broken.
Passing atomic doesn't help.
unit_alloc() can be called from any context
including NMI/IRQ/kprobe deeply nested in slab internals.
kmalloc() is not safe from there.
The whole point of bpf_mem_alloc() is to be safe from
unknown context. If we could do kmalloc(GFP_NOWAIT)
everywhere bpf_mem_alloc() would be needed.

But we may do something.
Draining free_by_rcu_ttrace and waiting_for_gp_ttrace can be done,
but will it address your case?
The commit log is too terse to understand what exactly is going on.
Pls share the call stack. What is the allocation size?
How many do you do in a sequence?
Why irq-s are disabled? Isn't this for scx ?

pw-bot: cr

