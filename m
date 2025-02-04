Return-Path: <bpf+bounces-50462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9DA27FD6
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB5F1886FFA
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A440F21CFFF;
	Wed,  5 Feb 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGhU6V0J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DAC21C9E1;
	Wed,  5 Feb 2025 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713607; cv=none; b=Z3YhdowFipSlznJRvoE1632CV3SSu/77pwHoKr/cpV0iGl4O3gYhcrxXCTmvTnXvoXaXQ9eaLynwLklmRxwyPGWwsHlcIygytycNf2DyiVHFHA4J8e9EmcNcgzFGurAcn1M0L+SE2fDThFaWN0hbrPinIMCY4DcvAxWZLeuzg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713607; c=relaxed/simple;
	bh=V7Zi/iyAoCK+XZf5LpkEKAQrMiDEAjFGuyxaF5EdJu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZN9Jg7Vh53eHUyJRO0AT707sCU4w+sYE25ktqVFbGNKohak0+zDsIPmZeaaARgSXkQzuN9yE6fUQX6VQV0shtbAnELd5JORyDUS9Dn+AnhmxXnrsGXUGqqmWtZL2FP5uSpvLggZKWy6OxEZxENy/VkIjTaYrK2po7UmXn0DdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGhU6V0J; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso43059525e9.3;
        Tue, 04 Feb 2025 16:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738713603; x=1739318403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6OYG00+towej2n1JZaA+A6mEnGlJkoM6YIHta1QLfo=;
        b=IGhU6V0JqvzYZkbSL4kSk1gwavcZdO7zDbqYCjshhpdnsc4ytfdZfNLDd2gJUpkPm9
         En3dxxqQa/cUiZa82ziNvPGleSVlH4dcO1aKQXxT+D/PPPgduRi4ECjnI4QNbUv5Wp3O
         gsJ8lieUtQXXSbsikvBaZBMQIad1iPg5+J7aTBgBPXmukn3uS9o9jDnVoe7SUqoYM+42
         JjFgjF8nC701rpKhBkxXicXAMqR6uTkMSstDOfPTyXew6tQnVtLGJnEJ1Jd84wZ3RC0q
         49a0djiXm8SshSXMJjGz+mCO7h75Fzr06EkQt/IgSrhNpJhNQbTr7+BOyJZ/lQchmQ2u
         3B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738713603; x=1739318403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6OYG00+towej2n1JZaA+A6mEnGlJkoM6YIHta1QLfo=;
        b=J4jzh9yiiTKUCiC03YskSablmtSqfZlC6aWhE1W+Ch8bVJysbxYSZ8uy1bTjtmav86
         Gpmig0MxIwxYKP8inoo9Y/n7CdRUjOGs4+tBNVpJR25Ci839S5reFWQ7uesfUcCAEO0y
         P7JLIct3CQj/khXjGRz1aKzpvP1o997Q69mUESve6jChYVellwGgL/3a9v3xdn485vF+
         V+Hji6MjOkcUZShIkwAoxz3tJR5F+ZFVMAv07NhATNh8GGGOge4sJYJw4hWeR10b0zwP
         70USCwexG9Sj9Oda0AzRqPbzJG4t7n49jvInZYUb1dKIJjag9BNDi1IMV35cNiof7681
         eKSA==
X-Forwarded-Encrypted: i=1; AJvYcCX/VzZuynBxDxy0di6rjHa+8M34AXK1vtgGPzRShdCK0aFg8Wr/uvb4KJQlSLibkjOPtY+PstiHF+L/jwmf@vger.kernel.org, AJvYcCX1AqDKfNghU6HO9UHNEFkR3VpHQs38o1QGaT3M+UkI3D3D+h+ODlX5a9Wtp32OYWW32KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGlrrl/ugZCJDciKjM28GPnAlI+hMj7LcOqyNxOKcW4zxMED5
	LFY64ACe1HirJuTpmErz6Ho4yr8QOXQQJOaHI9wl4d50kGXe5T3+OiCEZie+je6DV8QxsJqJf9V
	VtAwdtZbLzk+652ZFU8f1KTnFiQneUM6k
X-Gm-Gg: ASbGncsstoScVGEJsjvD8sOfzW5zN3jkwwLePMfaf5XKzQevTDAfP4FGLGEPZdZoURA
	qXoyPTVh2ZtAR/JidOdVrFaLBnTekci0PoMINgc7mXXY3AX3jZl+1YGLvER6M0tpTUpGjVeBnWg
	==
X-Google-Smtp-Source: AGHT+IE15lPz2vl/Ev7gc5s/OrrCz4qJC0cA3THIRIUUUeWG45vHMIhtFuZeD/ME96YK8uHiPdeeBkgJmozYYBl0yYk=
X-Received: by 2002:a05:6000:1561:b0:38d:b18d:8ee7 with SMTP id
 ffacd0b85a97d-38db4920930mr327630f8f.49.1738713603120; Tue, 04 Feb 2025
 16:00:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080392CC36DB66E8EA202DE99F42@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5080392CC36DB66E8EA202DE99F42@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Feb 2025 23:59:51 +0000
X-Gm-Features: AWEUYZl9x2Tmu0KHKOSiDT_80No2JLr7K07BgpIWaEaGZF1A3M9cz85eVjq85DU
Message-ID: <CAADnVQLb--LzFmXZPLPa5V+cD1A9YzTnZSgno9ftcA4-GGTi8w@mail.gmail.com>
Subject: Re: [RFC] bpf: Rethinking BPF safety, BPF open-coded iterators, and
 possible improvements (runtime protection)
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:35=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> This discussion comes from the patch series open-coded BPF file
> iterator, which was Nack-ed and thus ended [0].
>
> Thanks for the feedback from Christian, Linus, and Al, all very helpful.
>
> The problems encountered in this patch series may also be encountered in
> other BPF open-coded iterators to be added in the future, or in other
> BPF usage scenarios.
>
> So maybe this is a good opportunity for us to discuss all of this and
> rethink BPF safety, BPF open coded iterators, and possible improvements.
>
> [0]:
> https://lore.kernel.org/bpf/AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR0=
3MB5080.eurprd03.prod.outlook.com/T/#t
>
> What do we expect from BPF safety?
> ----------------------------------
>
> Christian points out the important fact that BPF programs can hold
> references for a long time and cause weird issues.
>
> This is an inherent flaw in BPF. Since the addition of bpf_loop and
> BPF open-code iterators, the myth that BPF is "absolutely" safe has
> been broken.
>
> The BPF verifier is a static verifier and has no way of knowing how
> long a BPF program will actually run.
>
> For example, the following BPF program can freeze your computer, but
> can pass the BPF verifier smoothly.
>
> SEC("raw_tp/sched_switch")
> int BPF_PROG(on_switch)
> {
>         struct bpf_iter_num it;
>         int *v;
>         bpf_iter_num_new(&it, 0, 100000);
>         while ((v =3D bpf_iter_num_next(&it))) {
>                 struct bpf_iter_num it2;
>                 bpf_iter_num_new(&it2, 0, 100000);
>                 while ((v =3D bpf_iter_num_next(&it2))) {
>                         bpf_printk("BPF Bomb\n");
>                 }
>                 bpf_iter_num_destroy(&it2);
>         }
>         bpf_iter_num_destroy(&it);
>         return 0;
> }
>
> This BPF program runs a huge loop at each schedule.
>
> bpf_iter_num_new is a common iterator that we can use in almost any
> context, including LSM, sched-ext, tracing, etc.
>
> We can run large, long loops on any critical code path and freeze the
> system, since the BPF verifier has no way of knowing how long the
> iteration will run.

This is completely orthogonal to the issue that Christian explained.
The long runtime of *malicious* bpf progs is a known issue and
there are wip patches to address that.

> Then holding references or holding locks in BPF programs doesn't seem
> to be a problem?

It's a known issue.

> This brings us back to the question at the beginning, what do we expect
> from BPF safety?

Safety is paramount.

> What do we expect from BPF and BPF open coded iterators?

They are not special. All progs can be exploited if bad actors
try hard enough. Including unprivileged progs like tcpdump.
That's why unpriv is disabled by default.

> Would we expect BPF programs to have flexible access to more information
> in the kernel?

yes, but the tracing progs must be free of side effects.

> Would we expect to have more BPF open-coded iterators allowing BPF
> programs to iterate through various data structures in the kernel?

true, but it's nuanced.

> What are the boundaries of what we expect BPF to be able to do?

Tracing bpf progs are readonly. If they cause side effects
they must be fixed.

> Of course, there may be risks, but maybe those risks can be solved by
> improving BPF?

Please help by contributing patches instead of screaming "fire fire".

