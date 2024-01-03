Return-Path: <bpf+bounces-18907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE21E823602
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D961C2429E
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E01CFBB;
	Wed,  3 Jan 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/Jtd0Jy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D381CF94;
	Wed,  3 Jan 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-556aa7fe765so1816851a12.2;
        Wed, 03 Jan 2024 12:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704312030; x=1704916830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TZyheqiNkbw62Y0lKZ5a4PKzC93VCVktsjcoDVNmvE=;
        b=X/Jtd0JyN+xOU39Dw1Cucg8jGdjy546nUnm45t7pWca00auwZpGEJGFcCjxtM7kM5H
         mLXDLFW8imNgCa4CAPenf23ldQB+EjbxkvJzkMrhgRPLrY8p+ESavf5KZJWYjuMZRGdh
         F+IxTeItwiW5XQKrXscrimsUf8YntYw6efAMReThDMYemJmIiDbY8GWqUK9IdBw5TEzl
         nuckpnbBo1m2u0vxdKDybhrYbDk9FEc7NeqB9jZG5pTAPV0tx3P32kF2wlG+1ax+N9KM
         h1iujI/ZwzUqGYiGPap7fs4uWWAF39RWHzZ0kjCjbAG7cNJ10jmzUvI0zCbunYuYNE1M
         axPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704312030; x=1704916830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TZyheqiNkbw62Y0lKZ5a4PKzC93VCVktsjcoDVNmvE=;
        b=R5tT4Jc8RAB+PDgOgZDyAT8MH/wSDRrZ5TpiKRAzZGB43NDvo3zo//bnNoyeOBOhZe
         +PM+5gAMtfA5IMUInHud6yt4C7sPUze4K5SkHxzI4+XKwKsgy2dtZDwQfkIjOKPendDB
         9/ObeKw4sXPA4pQQRj6bpKXlTo47uR0mVv/B/BMi54Fr47qdFXknBvyVe5DiVhMLvRDS
         YKs0v4EeiB0XJyHs9H+T3nPw+AYKT9RZ6ufgf/3zT+HdAbygib1hPpbe3BQBIeaeWEqm
         7uincB9pyHO0HlBqiQ2x/Ij3SiIeuY0szyLWcaUy41fySYUAnpBZ6m+xmpfkrULSe9c0
         Ss5A==
X-Gm-Message-State: AOJu0Yz2MYeLNoIOeCz90MU57WdCn+Erp6O819lL3mMrw0QiCchwzxLs
	wh5cG+5ct34jd2aB7KxOW2EJuR4V5iN5wTst3Fc=
X-Google-Smtp-Source: AGHT+IHaEe5+qHFmlW6FBLBtz87lTR4XmPxAift41tboK57p3YGpFsssad+fbzVcJ3TTr+HAeJnpyYdbnxY/TnOMz+s=
X-Received: by 2002:a17:906:2309:b0:a28:15c0:4dad with SMTP id
 l9-20020a170906230900b00a2815c04dadmr2048480eja.120.1704312030511; Wed, 03
 Jan 2024 12:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103185403.610641-1-brho@google.com> <20240103185403.610641-2-brho@google.com>
 <CAEf4Bzbyn8VaMz8jWCShDDMtwif5Qt+YTEih0GEzULFeAAS2LQ@mail.gmail.com> <d2f30155-ba00-4f10-9d05-c6cba3bcb1ef@google.com>
In-Reply-To: <d2f30155-ba00-4f10-9d05-c6cba3bcb1ef@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 12:00:18 -0800
Message-ID: <CAEf4BzbcP55H=8krt8tujFyyWZaKwJKQ0n8rB0ujpXO4WOb=NA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: add helpers for mmapping maps
To: Barret Rhoden <brho@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:45=E2=80=AFAM Barret Rhoden <brho@google.com> wro=
te:
>
> On 1/3/24 14:42, Andrii Nakryiko wrote:
> > this is specifically ARRAY map's rules, it might differ for other map
> > types (e.g., RINGBUF has different logic)
>
> good to know.  will drop it.


please give other people a bit more time to review your current
revision, don't rapid-fire new revisions immediately after getting
feedback

