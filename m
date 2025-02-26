Return-Path: <bpf+bounces-52697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451C6A46E05
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 23:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C533A9B45
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 22:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD7F269AEA;
	Wed, 26 Feb 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmVWKMC3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A595122425A;
	Wed, 26 Feb 2025 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607344; cv=none; b=jHLzoU8Mk7NlqQd9/iTftNNHJA88SMKod8IxhHXj/Q3SQvhBPPCMPfO+gvuoX4VPJgU167Rap5qjKXO2IW93LJWUSBdj5sIyWfz0JsrmTzL+QhOvlk1x+89IIYb95yE7nYijj6kOwoUNckOCoocWKyuK9HM4wB7tz6+r3il+Vpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607344; c=relaxed/simple;
	bh=HcGovQDGE4BqvsArC5and/FvCf5uqHO7axy7rZfiDQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jt1X/LkI2C6RreDOl8sfFDxI6j9RwZnMCDgKj0pQMShxXZPCEOIZyV1f/I+gcythKVLRKB5ZUDelkpOxUS5bUVajfrrELM/dPmWhbUxLM1oRMVHi1+2aMYznI5pToK3HuqtmisPIH24jwEAeB+OsBBMSzTDFBlwq3eV7LN83pTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmVWKMC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1343EC4AF09;
	Wed, 26 Feb 2025 22:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740607344;
	bh=HcGovQDGE4BqvsArC5and/FvCf5uqHO7axy7rZfiDQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZmVWKMC3rsbx1KFyxD9w+PJU186QyKnQzHX4Xm8J6JmLWGygsI5SpeZjQWkLUDiDh
	 wLIwdQwcJb7nlWhki+sK5QSY26E03e2JwPjJANEapXLgpmG7SzGBJJdOvF01qpLwTx
	 F0CJmSv5Pc5K95kzwufIGYcb9UBzhVaRGRuuTXdlE6CuvNspAa5m3eyWtPFz6hJezl
	 q+1cGJZ5cxRPYBK80PlETbXWivNaBJ41wgZiR+7cw+zoxoLv5RDVYC/huuWeXg+PES
	 0O2+Y578qwE5O5WfsSJBH/yrH4EWhJS3ka9O4BzWLZFJ+Q5ZUUme57sM4QqaxisEI3
	 XSF8lkSFR1jcA==
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-855bb9fa914so7837439f.1;
        Wed, 26 Feb 2025 14:02:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8eDTozv1NF8spQVqpdF2u7o1CRfa6ehblWQCNNQzSSnhlzkWxx+g9WmbdqOt9dXjxfeKP1QmKlhWSjvQ4c8lqpfMFuEgd@vger.kernel.org, AJvYcCVq29IlnEdMlcXgudA4m/huO+gYMP3+BrqJrKpVcxUe0hXIOdnV66mhYMh97CZog4vx3icQ4BeetQ==@vger.kernel.org, AJvYcCXeIUVryhV+LDSjVewiX0qLyCqH6IxdKWgqOVkbP5YrGRKvMeEZjVzEH89TObBvPU/zD4bKSI9h9cHdl7Hv@vger.kernel.org, AJvYcCXiLSbxToyaJnVRg7x+5uQLaDVBVL+6ccmCxY16OI7LRKa2mmuYhjlvbMpLMAiF026KZ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbu+ZOSFnvJ5hLyh8XeoEXQimnrUTWy8eJ00RpMURpFip9TKg
	PAnSpiD1hruSnkPMoMDtFvrBuaXdMzzukKyEQlTJQP3Ob/1Ku8MVUNgrjxtX/4zbiNQmeUMOpPG
	6mRTs1z5wqW+jkIl96mvI7zftbks=
X-Google-Smtp-Source: AGHT+IF56aMtVC9kgzhrEn1BazaQuVa1V57LakSmtHHshyBopSU62FSVL1llGe6JYotFsOu+WB8yT45gFYnnGg9VS9A=
X-Received: by 2002:a05:6e02:3103:b0:3d2:6f1e:8a4b with SMTP id
 e9e14a558f8ab-3d2cb5151ccmr202103765ab.16.1740607343398; Wed, 26 Feb 2025
 14:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226003055.1654837-1-bboscaccy@linux.microsoft.com>
 <20250226003055.1654837-2-bboscaccy@linux.microsoft.com> <CAPhsuW7=uALYiLfKfApvSG0V+RV+M20w5x3myTZVLNRyYnBFnQ@mail.gmail.com>
 <CAADnVQJWMBRspP-srQwe8_B1smGG1hs3kVbpeiuYo-0mLWAnUA@mail.gmail.com>
In-Reply-To: <CAADnVQJWMBRspP-srQwe8_B1smGG1hs3kVbpeiuYo-0mLWAnUA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 26 Feb 2025 14:02:12 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5Xzv7hsuG9RzO+KdxMXO3JCpC6UOTFDZiYGf_Vnfpo5g@mail.gmail.com>
X-Gm-Features: AQ5f1JpLtpxSTDy_e-G9cvkC70zZHFez1SttCvfnEJ5lwovdBr4h5ckbHaT__AY
Message-ID: <CAPhsuW5Xzv7hsuG9RzO+KdxMXO3JCpC6UOTFDZiYGf_Vnfpo5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] security: Propagate universal pointer data in bpf hooks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	LSM List <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 8:00=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 25, 2025 at 11:06=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> >
> > On Tue, Feb 25, 2025 at 4:31=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> > >
> > > Certain bpf syscall subcommands are available for usage from both
> > > userspace and the kernel. LSM modules or eBPF gatekeeper programs may
> > > need to take a different course of action depending on whether or not
> > > a BPF syscall originated from the kernel or userspace.
> > >
> > > Additionally, some of the bpf_attr struct fields contain pointers to
> > > arbitrary memory. Currently the functionality to determine whether or
> > > not a pointer refers to kernel memory or userspace memory is exposed
> > > to the bpf verifier, but that information is missing from various LSM
> > > hooks.
> > >
> > > Here we augment the LSM hooks to provide this data, by simply passing
> > > the corresponding universal pointer in any hook that contains already
> > > contains a bpf_attr struct that corresponds to a subcommand that may
> > > be called from the kernel.
> >
> > I think this information is useful for LSM hooks.
> >
> > Question: Do we need a full bpfptr_t for these hooks, or just a boolean
> > "is_kernel or not"?
>
> +1
> Just passing the bool should do.
> Passing uattr is a footgun. Last thing we need is to open up TOCTOU conce=
rns.

Shall we also replace uattr with bool is_kernel in verifier.c? It appears t=
o be
a good cleanup.

Thanks,
Song

