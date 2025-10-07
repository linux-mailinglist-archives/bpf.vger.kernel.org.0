Return-Path: <bpf+bounces-70511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBEBBC1941
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469E53B30F4
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39F1DF99A;
	Tue,  7 Oct 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjpIXVZG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD2255E27
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845206; cv=none; b=gCjXbWucSJYBJ63fQZFs57aOAUMDwEnDPpeYf/PmZzOam615x0sATWaMxlhCs5pdhalPAtYwx3xdgtBhZC6MgLsYxoeKo9EWuKuLBHTyID/1fsGGKFOaFBbKsbwqQDjgn4lHSY/xA7pYXYCeQJnGH70zObE69WeHPrbwSXqxF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845206; c=relaxed/simple;
	bh=QaSDtcntn727F1xJQE/5vwQmxzv9e+QEa3rjbFOgMLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZ/evMzgBAAxYBH7GyVjAd1yWNEh2We2HsibavrMxW8piuCJEZ8vAoqBeVRtybaQqhWEOkPKt1qDPWxhkQ1jT++Cw9jlLa1BBSF0rsTg7/hQpazsFWxvoQrfnpK0LRKCbe8vPd7KKmuT2C0mWf4KMat91I0tYQ2NrvhChvXWjiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjpIXVZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B98AC16AAE
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759845206;
	bh=QaSDtcntn727F1xJQE/5vwQmxzv9e+QEa3rjbFOgMLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HjpIXVZGFGfTZgZkitPtR5WSjOBFkOGZnNl/NvFFufEzUaAaS9dQaDC1Ry2wtWcoS
	 eNxZMtyLQoiMa8/d2xA4W10p1w+2Ewp+e6C2zkjFN51ZpicvLakVGIlRxxTLJaBpsR
	 d8pmDIwBif9jHn+Ujxz7+Qa+VzyP0nfeBIfQXg4z00yG0agl0Z58nMrjlEBAEV7XuR
	 ikH/0/FDXfJ/E9Yjf17P/5E51edfZcmVrKbclPFXnyN4ls5yZDG/9tm03BaKSxJPzf
	 w/oYKtZwCt37T7xjgySLElQ5aJMHvLTIPcKzSittTPRxN6cURti0Y+SUs65NhPvnBz
	 MwOf0Zq54GiqQ==
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4256866958bso2781250f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 06:53:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdWyTspEJahfKP8rkT7jVUps8/jphjVnrjGd77z41o4JaD9fHFEp75S/SK8ooMyO6pchE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3uOn/KLjcOezz64Zy3P9MlDVDQZOLQIS792LiDhy2Oa6bmPnk
	KhJisGZkkDyXdYgwCj7SlWXswfrhAEooDPo1u32Tm3wXTEjVfNsTqk5PNk+PooxUKyQeWbpuJp1
	pYDmpcEfjieNOfclNN2mLJj1seVcX5dWMRW5CY4tK
X-Google-Smtp-Source: AGHT+IHhEp4dRiHd5aig+27PK3lSSwRIUvsv/+mm2GJ85kJTbL0Rsb+RrqIrPLZCctwVj0UA1gRJaTtZIIqTSqufybk=
X-Received: by 2002:a05:6000:603:b0:3ee:147a:9df with SMTP id
 ffacd0b85a97d-4256719d346mr11851692f8f.39.1759845204612; Tue, 07 Oct 2025
 06:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com> <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 7 Oct 2025 15:53:13 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
X-Gm-Features: AS18NWCfD8e4R1UBvbNgud9_fOkOn-PQJnYkDwGPnfa8uRNvzd2ULoLQ_4wXAHg
Message-ID: <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, ast@kernel.org, 
	james.bottomley@hansenpartnership.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kys@microsoft.com, 
	daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com, 
	qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 5:08=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Oct 3, 2025 at 12:25=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > On Fri, Oct 3, 2025 at 4:36=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Thu, Oct 2, 2025 at 9:48=E2=80=AFAM KP Singh <kpsingh@kernel.org> =
wrote:
> > > > On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
>
> ...
>
> > > > > To make it clear at the start, Blaise's patchset does not change,
> > > > > block, or otherwise prevent the BPF program signature scheme
> > > > > implemented in KP's patchset.  Blaise intentionally designed his
> > > > > patches such that the two signature schemes can coexist together =
in
> > > >
> > > > We cannot have multiple signature schemes, this is not the experien=
ce
> > > > we want for BPF users.
> > >
> > > In a perfect world there would be a singular BPF signature scheme
> > > which would satisfy all the different use cases, but the sad reality
> > > is that your signature scheme which Alexei sent to Linus during this
> > > merge window falls short of that goal.  Blaise's patch is an attempt
> > > to provide a solution for the BPF use cases that are not sufficiently
> > > addressed by your signature scheme.
> >
> > I am failing to understand your security requirements.
>
> I'll be honest, given the months of discussion on this topic already,
> I do worry that claiming a lack of understanding at this point is
> simply a tactic to drag this discussion out or dismiss our arguments,
> but if this is an honest admission let me try and better understand
> the point where you are getting lost ...

No, there is no clear security policy that you have proposed that you
want to implement and this prevents you from implementing the policy.

>
> * You've commented on Blaise's patch, so I'm assuming you have a
> reasonable understanding of Blaise's patch, if not, please speak up.
>
> * Similarly, are you comfortable in your understanding of the
> differences between your BPF signature scheme and what Blaise has been
> proposing in this patchset?
>
> * Do you understand how Blaise's signature scheme verifies the
> signature of both the loader BPF program and the original BPF program
> before the security_bpf_prog_load() LSM hook?
>
> * Do you understand how your signature scheme only verifies the loader
> BPF program before the security_bpf_prog_load() LSM hook, meaning the
> original BPF program has had no integrity or provenance verification
> when security_bpf_prog_load() is called?

Yeah, this loader is signed to load only specific trusted payload. You
are wrong about it not having integrity. The integrity checking
happens in the loader that the very entity that signed the payload of
the loader which contains:

* The hash of the loaded programs and metadata.
* An integrity check that verifies this hash before loading the programs.

I feel we will keep going in circles on this and I will leave it up to
the maintainers to resolve this.



>
> > > > You keep mentioning having visibility  in the LSM code and I again
> > > > ask, to implement what specific security policy and there is no cle=
ar
> > > > answer?
> > >
> > > No one policy can satisfy the different security requirements of all
> > > known users, simply look at all of the LSMs (including the BPF LSM)
> > > which support different security policies as a real world example of
> > > this.  Even the presence of the LSM framework as an abstract layer is
> > > an admission that no one policy, or model, solves all problems.
> > > Instead, the goal is to ensure we have mechanisms in place which are
> > > flexible enough to support a number of different policies and models.
> >
> > Please share concrete policies you would like to implement, this is ver=
y vague.
>
> Please understand that this is the wrong question, for all the reasons
> mentioned above.  A better question would be to ask what primitives
> are necessary to ensure that a LSM has the necessary visibility to
> record the state of the BPF signature verification and make an access
> control decision based on that state.  Blaise's scheme verifies the
> provenance and integrity of both the loader and original BPF program
> prior to the LSM call, your scheme only verifies the loader before the
> LSM call.
>
> --
> paul-moore.com

