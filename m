Return-Path: <bpf+bounces-52620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B63A4565C
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 08:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED6B16CE0A
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 07:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203926AAAF;
	Wed, 26 Feb 2025 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV70/dOj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE625D537;
	Wed, 26 Feb 2025 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553603; cv=none; b=Y/lauEVJk3DgN4/lClzgAZrsel2FW1QIwUDImWTMfJOgs/vH+Fkqm/I9uNcs+cC48p0+Sbm68I/vM/ZYT3cawku+ca/KqeZpOwDebyepzv5Tqh4XbhW9C0tMonlgRK94qIejJLQsq3jgQCeO95T07PMrqbj7bStMmWjIIKpfkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553603; c=relaxed/simple;
	bh=mWyo/N8+DDNXUg5/NyVlWyuBe6c73l9NTi/yTouqFF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9V5YRFXTr5WOC9UwOo5bREK48gHy9AEwltRKeD40t5hvcVh4L6gf3ESOLem6QkxTfGmbCCrbi+XiPwoX05ahcOla5Qd7n+PVNebOCEgGdzsAKW2f4i1eb3s8hP691kp62tWIo5IHFKy6PboYnC7Cm2ClKvYbjX5pgUhMpj4ijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV70/dOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F16EC4CEED;
	Wed, 26 Feb 2025 07:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740553601;
	bh=mWyo/N8+DDNXUg5/NyVlWyuBe6c73l9NTi/yTouqFF4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TV70/dOjBQpAP9cvSXh3cLIU9bu5XLmWT0qDZyQ2tDkVx8D1Nb7lJT9HUibqNOldu
	 CfzgBnMqoYsoxOIMsHTihHH82ZF3LdNPKol5y+LWt4L4cMtMt5QmpIVw03c0wLfEBX
	 I8PrltAzLeffROhDBR7hfWZQZ6pnTheGDzyGbe9GwvC5ZWc0BEIEdqFdq2/evHluV1
	 YiIPiclNyTS7gagvMcRqUCBB8GegATNJ5qIZbrWaV3nhYrln6BM/lOzwZ+XMg3sU/m
	 oC+ges9YKhuuiNKKgRo1rf/6u6xpW2EJ9AQucCB2lFUNKcO2xx3bmU2QRT99fPeTpL
	 XrRjZ8fp0RIwA==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d2b6ed8128so1954125ab.0;
        Tue, 25 Feb 2025 23:06:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnTHNVf2zPXewWQSrxBXfghHlVZuJVK9BLnR1OaznOErPnPObrqGQrMSL6S95fgAHMupSqpLE4TA==@vger.kernel.org, AJvYcCV0DdpFKZfIefw2UAFKQWwi4hA5BUgFiHdeoMH8yzpzILwdQbxnZAdkNZlLJH9SnmNuwQWXNjH4Dol+5/7l@vger.kernel.org, AJvYcCVc/twlzJduaSkCfGxcr8b38JoSb4nQJQi/bHbko+fAuvjj46gi9ohGjF7tqArNpGMTZOEP8Y5oJo/h0KI9L64aJODzE4So@vger.kernel.org, AJvYcCWnWLzwnaIZzomY2mVpQOBZva+IVdiuUBznpM3uwkT0Yg78CuZ4RSDyZLJu00yrUn8rLF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cnABYHDxP1MALd8DNBWJPlHtHvHk8eyZaaedho9T6gysFtTf
	1EBKb1yEazISBiBLeHDgz3MANo5NV4y/T0GHaobu0+f5W9qF+NKYd/39RCEEQANwZoU9opK10hq
	UL/2cZ/Qw+sejXmCKTvAbvlKL/lY=
X-Google-Smtp-Source: AGHT+IEcdOl98oXKlXxePv3jLOaWtXiDN+kmLxVG+wppb9FMPoMqDpGYB5LiymeF8aw5tl3Fb5pRrkiVl+Tsje8J7oM=
X-Received: by 2002:a05:6e02:1aaf:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d2cad53783mr161545385ab.8.1740553600762; Tue, 25 Feb 2025
 23:06:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226003055.1654837-1-bboscaccy@linux.microsoft.com> <20250226003055.1654837-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250226003055.1654837-2-bboscaccy@linux.microsoft.com>
From: Song Liu <song@kernel.org>
Date: Tue, 25 Feb 2025 23:06:29 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7=uALYiLfKfApvSG0V+RV+M20w5x3myTZVLNRyYnBFnQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrQbQVFIc9h30vn4-9xqbLwmuveTiAWwZ-YCxa69xS_lPBL2nuj90MTZaQ
Message-ID: <CAPhsuW7=uALYiLfKfApvSG0V+RV+M20w5x3myTZVLNRyYnBFnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] security: Propagate universal pointer data in bpf hooks
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 4:31=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Certain bpf syscall subcommands are available for usage from both
> userspace and the kernel. LSM modules or eBPF gatekeeper programs may
> need to take a different course of action depending on whether or not
> a BPF syscall originated from the kernel or userspace.
>
> Additionally, some of the bpf_attr struct fields contain pointers to
> arbitrary memory. Currently the functionality to determine whether or
> not a pointer refers to kernel memory or userspace memory is exposed
> to the bpf verifier, but that information is missing from various LSM
> hooks.
>
> Here we augment the LSM hooks to provide this data, by simply passing
> the corresponding universal pointer in any hook that contains already
> contains a bpf_attr struct that corresponds to a subcommand that may
> be called from the kernel.

I think this information is useful for LSM hooks.

Question: Do we need a full bpfptr_t for these hooks, or just a boolean
"is_kernel or not"?

Thanks,
Song

> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

