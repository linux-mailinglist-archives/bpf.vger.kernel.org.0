Return-Path: <bpf+bounces-70337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A53BB7F30
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 21:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5593E4EEC8E
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A691DE8BB;
	Fri,  3 Oct 2025 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db1xH1E+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B82985260
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518163; cv=none; b=DMqBJzD4Uw/WAbPnhS5S1qjUb4Y3Va8W4Jv/CONi/USEswCMerjyNeA3yAnSy+4ZcFUVIVHJQVi1lPdyrG35CXxD5ZukI/VCrMCLH7qe3dq77j+YtjCnjH9dDM8LHknCgpRKjJLp3JMmkqy5m6Ut0nmrZuWbHGEe0fKboYllFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518163; c=relaxed/simple;
	bh=aNvqNkT5Habi6s8YHYtkgT2tZNgOToqzldxt1NLJSy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpxDv0SOZg0Jlha2eqU3bqr3lYkGXY8PU9IVsQ+/H6rrC3LOEZiWzSkg+b12iVsFI/1dolxPnr8FjI7zVYhIhzwUfgL6t6/SAdFRFbs50bqfCUUZ/60vBmtVoexg3Uo7a6VwbXhmSTbH6LZDDoLBo7AXwd/xucKy0xSsivmSMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db1xH1E+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD413C4CEFD
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759518162;
	bh=aNvqNkT5Habi6s8YHYtkgT2tZNgOToqzldxt1NLJSy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Db1xH1E+8uzR9hXa2wHPZd7Io9zTjdrVJap3ibN4nch824G8VTdJoUQhN4FgkbIu2
	 88896kJidX8r0wSismtnplUiOhwIGaOJ+7bskFpE1Ek2WyosNU4PmmXBoDQyiQh8rm
	 GYhpSeh+qkkRHuWybDCJWtXAuwS4lZ4e5A7FNAdyV8XUuGGF04ukghA2LkgA9bVy7j
	 5+t/fixSUv6iAeZxjd1j0cEcRoNT+cGv6aah7cT4gizBS8Tsw4J7iy2oO3nJdwCaCn
	 uTKPepc2/xVrwwm/9gEdQlXwGcDaKzBFDn3JgwayQC7n1TL1afwWS7inmruB1iUikv
	 g/7VJ8gC3KhCw==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-41174604d88so1399510f8f.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 12:02:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTDwEUcwCMkTAlZYY39m7WNbBJbhuCC1I3Pd43EV0/x07ArWiQswoxcD7Bm73li8pZKxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsHeoDqsr86moxmhRxy6bAv88EAO32+icIeyZT81AKjgTGhwN
	yIl9PK64QfwD4bpPyRM5R4gHSWDxklHb0ghNwdybxwmVy03r3qm2xJkGlB0uW9P8nihuKT+FH1y
	eWbP4Nm1aDDW9zqmauzfRapeT2EJmp9lbKCMdy5YN
X-Google-Smtp-Source: AGHT+IFjcoClIXjqWuHwPuFpTuc9prkzQ3jPOykGjzSm4s2ipT01a6z3ViHn1uMUhO1GIi4WAcYrA1/E0mXqa46FYIY=
X-Received: by 2002:a05:6000:420a:b0:424:2275:63c7 with SMTP id
 ffacd0b85a97d-425671d6c24mr2621306f8f.56.1759518161289; Fri, 03 Oct 2025
 12:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <871pnlysx1.fsf@microsoft.com> <CACYkzJ7F6ax2AcWNFxnAkyVb26Dr2mwdBnW=HFVFeJ1pC-BObg@mail.gmail.com>
 <87y0pryhs8.fsf@microsoft.com>
In-Reply-To: <87y0pryhs8.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 3 Oct 2025 21:02:30 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6k_3DKKDh8Da87x5jAgP_En5T8VZ8DnYcZ3vJ9SGaUWA@mail.gmail.com>
X-Gm-Features: AS18NWDhALx-hEC1gejjZQYikQhjyuRlw4Kb0VPtpbEyQGPJxHss_2jI1H56zH4
Message-ID: <CACYkzJ6k_3DKKDh8Da87x5jAgP_En5T8VZ8DnYcZ3vJ9SGaUWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, Linus Torvalds <torvalds@linux-foundation.org>, ast@kernel.org, 
	james.bottomley@hansenpartnership.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kys@microsoft.com, 
	daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com, 
	qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 8:14=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> > On Thu, Oct 2, 2025 at 10:01=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> KP Singh <kpsingh@kernel.org> writes:

[...]

> >
> > I am sorry but this does not work, the UAPI here is
> >
> > + /* Pointer to a buffer containing the maps used in the signature
> > + * hash chain of the BPF program.
> > + */
> > + __aligned_u64   signature_maps;
> > + /* Size of the signature maps buffer. */
> > + __u32 signature_maps_size;
> >
> > This needs to be generically applicable and it's not, What happens if
> > the program is not a loader program / when the instruction buffer is
> > stable?
> >
>
> The map array is fully configurable by the signer. Signing any or all
> maps is optional. If the instruction buffer is stable, the signer can
> generate the signature without maps and the caller passes zero in
> those fields.
>
> > If you really want the property that all of the content is signed and
> > verified within the kernel,
>
> That's what code signing is.

Sorry, this is wrong, allowing signed and trusted code to verify
subsequent executions is established in security.

Also you folks keep saying you want in-kernel verification, the loader
runs in the kernel, the same as any kernel code, so that requirement
is met. What you want is the logic to be hard coded in the kernel and
this goes against the BPF approach of flexibility.

>
> > please explore approaches to make the
> > instruction buffer stable or feel free to deny any programs that do
> > relocations at load time for whatever "strict" security policy that
> > you want to implement.
> >
> > Please stop pursuing this extension as it adds cruft to the UAPI
> > that's too specific, encodes the hash chain in the kernel and we won't
> > need in the future.
> >
>
> If your primary complaint at this point is UAPI bloat, we'd be happy to
> rework the configurable hash-chain patch to use the existing signature
> buffer provided in your patchset.
>
> >> [...]
> >>
> >> >> conventions around the placement of LSM hooks, this "halfway" appro=
ach
> >> >> makes it difficult for LSMs to log anything about the signature sta=
tus

[...]

> >>
> >> We signed a program with your upstream tools and it failed to load on =
a
> >> vanilla kernel 6.16. The loader in your patchset is intepreting the
> >> first few fields of struct bpf_map as a byte array containing a sha256
> >> digest on older kernels.
> >
> > We can convert BPF_OBJ_GET_INFO_BY_FD to be called from loader
> > programs to not rely on the struct field. and or libbbf can call
> > BPF_OBJ_GET_INFO_BY_FD to check if map_get_hash is supported before it
> > generates the hash check.
> >
> > You should not expect bpftool -S -k -i to work on older kernels but it
> > should error out if the options are passed.
> >
>
> `bpftool gen` shouldn't have a priori knowledge of the target kernel
> version.

It can check whether the functionality is supported, it already does
it in many other places. I will follow-up with a fix for this.

- KP

>
> -blaise
>
>
> > - KP
> >
> >>
> >> -blaise
> >>
> >>
> >> > I had given detailed feedback to Blaise in
> >> > https://lore.kernel.org/bpf/CACYkzJ6yNjFOTzC04uOuCmFn=3D+51_ie2tB9_x=
-u2xbcO=3DyobTw@mail.gmail.com/
> >> > mentions also why we don't want any additional UAPI.
> >> >
> >> > You keep mentioning having visibility  in the LSM code and I again
> >> > ask, to implement what specific security policy and there is no clea=
r
> >> > answer? On a system where you would like to only allow signed BPF
> >> > programs, you can purely deny any programs where the signature is no=
t
> >> > provided and this can be implemented today.
> >> >
> >> > Stable programs work as it is, programs that require runtime
> >> > relocation work with loader programs. We don't want to add more UAPI
> >> > as, in the future, it's quite possible that we can make the
> >> > instruction buffer stable.
> >> >
> >> > - KP
> >> >
> >> >>

[...]

> >> >> --
> >> >> paul-moore.com

