Return-Path: <bpf+bounces-66618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5817B37863
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 04:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DC65E8355
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 02:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56232304BDB;
	Wed, 27 Aug 2025 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLTv8qKg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6A30277F;
	Wed, 27 Aug 2025 02:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756263498; cv=none; b=eCmgoiIBk+qAvrTnW0E3JUklqjGrb6TEGxYyu8b6RXoF7JdT4OkHHP2V6a45ADLnmkCMY82ViFQKl4HTM3h9NaZNMMlhkUcXkgm16Qx/FDvpTupClKPYA+PlyDFLd0c8R+aOVH0r+hsUeVp+Hhw1srmYvfpZ1IXyc4WxZOaGYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756263498; c=relaxed/simple;
	bh=fVClkvmIX03IY/vlxWeO8DaGfhbAKH3eW2FVqRDCbbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOnS125Y6D/r6IRl5ABltJ2NYe6Xf/gRUcQ2hHfG6Y9Sx7JPuU7E/eWvoljnLbgdI82gsrZphxVMNXhDnF9fVrXQ5KCBJPjbZetfq9nubOWVbIdNELfqTQR0xb7MAg61hRkOi77S4jf9jDfUZ9ONVTxnQhF99uZ/bUYOyfQ7p3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLTv8qKg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso55163525e9.3;
        Tue, 26 Aug 2025 19:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756263493; x=1756868293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7HWX5shL+lSFP4hb4DhlB5G29uSLpNosEFj6BYC/Hs=;
        b=jLTv8qKguox3dxsWZmcfjB/9D/Ids5trLmOySNn9M2VRImweVOHjacQbQNx6dUuT1l
         hivY84/IYI5inpndEOlPYYa7/PZkB+42k93SZaSp/TrPcqnzmLtT1221FP1XUHe1kYZw
         YCRYdvSonIrvpzzGL0GAnPjDaMud2BfuwbqVlJSoPs2tNhTV4NVHGraFKGoeY2UrOYK1
         lLJicRDC7eTcSIgKO8dgKUQZsI28YEBA7Ud/zCVNsZ1mFKZAimGraNa9qhB6x2fin4f+
         9/WvytSfJPQ/UU2PY9Ao83gJ1ttEqKZffsOtIIfs9GLujczsJg/5q9cThxUmg6RMXx2b
         nQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756263493; x=1756868293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7HWX5shL+lSFP4hb4DhlB5G29uSLpNosEFj6BYC/Hs=;
        b=jBgE495LdJZMnnl+EiuT2kk4uVT9T7WG7EAZF+4EENRfQSgiO1JJzJYiZ+JXxB0cFJ
         6bTYEv3VKC5/7TntZgG+ia+BKTgI3xJAUeOZNWavc7awxeoaC9M4bAE7kOUt5an417QQ
         9T9u/PYI94d3X7Wq+Fw3+IG1QnrnNZPTDB7eItaZm+djDpnaaWvS70e3w9AmQrLxd1vW
         1WnrVbzgAYMmcRKNUqRqj8o2dYbLQ8jRxULLWD6WajkmjmRC/w/CNziTG/x1kSjniy2I
         NQtiB6NiyI/rDoYWF/zXa/g4MgDprXGe0eYBFR96awtTjysFoQiCiZLpxtuoGoiCwKs1
         dXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkqFa5UNu4KbBzAo/BSIKvgGyHyDwcDEExHOk6fWBJYbnSjs+tZqQEm9a8+76VYT1t304=@vger.kernel.org, AJvYcCXSGv7uy8dD4eMKS8jnU3XRfItjLRq/A1GXN22Rd5K8V8qIPGhu3YtPWXZ09ZRWKSPDDWM4sEyxvlAWn7a4@vger.kernel.org
X-Gm-Message-State: AOJu0YzydaCiCQwCvgkGvfZQgh7d2knl+VY2m9Q2046kdTnXpyDZL+pP
	tlqciW8GmqiIBzomHsGHQZ9SucM0Qslemd6R0TO8phBR8x9bu13NQI0hrqVVmnkgiGqCK2hTTHo
	JTtd0ISiGBgjgFfx5WLhSmk9/5aj4vtA=
X-Gm-Gg: ASbGnctux1LHH17SxhmX/HysSok28gMA5m74Vqz1Ofm7/ylgsm7gXFNO24QAAyDc+RK
	l1/YtnrBPS43jwxOOgpTY4fDaGAG1wcz/Y2ppfFy4wpDpI2CVYsX7Jl/EdS8Bj9GRfRysAOQrPz
	Cj5PI2D5CHE8/r5OTmlqlwyczQ8+ctM2KnKaQjpv8LpbH3bWvhKzm/BGdGSiRvKMyjY4TxwZlXj
	zywpC8Zf/juQyBIRiPtDW7rvT8xrgyQipsjRLqOkWkZvlU=
X-Google-Smtp-Source: AGHT+IEFqnTqZ5Kp38zIbC41kgZiyM4ofvxc3raq5XPiTE+SFaBxmOSIXkbiM6EhK+HWWSQHQbkaqnW7oD31MR2KeDA=
X-Received: by 2002:a05:600c:c4a6:b0:45a:269f:3a29 with SMTP id
 5b1f17b1804b1-45b688bc0b2mr29188825e9.12.1756263493422; Tue, 26 Aug 2025
 19:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821093807.49750-1-dongml2@chinatelecom.cn> <20250821093807.49750-3-dongml2@chinatelecom.cn>
In-Reply-To: <20250821093807.49750-3-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Aug 2025 19:58:02 -0700
X-Gm-Features: Ac12FXw0emCj52PCXZBLE1wQayRlPDGC945m2fbkx2k5tZFAf89Lg-iXiSIxbP8
Message-ID: <CAADnVQL0oWnQM2AJh=yzNtRmH2Mx=B-hM2xsvgEx2uqLEBQ5Dw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sched: make migrate_enable/migrate_disable inline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	tzimmermann@suse.de, simona.vetter@ffwll.ch, 
	Jani Nikula <jani.nikula@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:38=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> +
> +#ifndef CREATE_MIGRATE_DISABLE
> +static inline void migrate_disable(void)
> +{
> +       __migrate_disable();
> +}
> +
> +static inline void migrate_enable(void)
> +{
> +       __migrate_enable();
> +}
> +#else /* CREATE_MIGRATE_DISABLE */
> +extern void migrate_disable(void);
> +extern void migrate_enable(void);
> +#endif /* CREATE_MIGRATE_DISABLE */

I think the explanation from the commit log is better to be
copy pasted here as a comment, since the need for the macro
is quite hard to understand.

> +
> +#else /* MODULE */
> +extern void migrate_disable(void);
> +extern void migrate_enable(void);
> +#endif /* MODULE */
> +

...
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index be00629f0ba4..58164a69449d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7,6 +7,8 @@
>   *  Copyright (C) 1991-2002  Linus Torvalds
>   *  Copyright (C) 1998-2024  Ingo Molnar, Red Hat
>   */
> +#define CREATE_MIGRATE_DISABLE
> +#include <linux/sched.h>

Also how about calling it
#define INSTANTIATE_EXPORTED_MIGRATE_DISABLE

When I asked AI what "instantiate exported migrate_disable"
means it guessed it nicely :)
while "create migrate_disable" had a vague answer.

