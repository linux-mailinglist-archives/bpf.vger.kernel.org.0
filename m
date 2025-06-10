Return-Path: <bpf+bounces-60251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6254AD460B
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 00:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B112189E608
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8402874E8;
	Tue, 10 Jun 2025 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sznl3CkJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4927D27FD73
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594932; cv=none; b=eFS3WEuUQuOKrEBp+zs6w3gm+zqsCt7c9hMl7+Rj1gp2cTPgJcUK3dFwUDTq5QuzdBmXMDm0svbhi4X1u8eLqhdm0gscAUtsWfqsorszRXci0TZ7zI++mKfNkWaIMY8YBQ4jaaGOF1sJTYq4At+BIb7dpUnsa6FIQz+HOHuXsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594932; c=relaxed/simple;
	bh=zhgFQwk1GFMLOuRnapR4kecbgdYNBQvJrsBkPLPvflU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCEI8zIOwMZ1AIemqY5YeDWh42NjOBe1eZ//4RNk7O6e4rrut3xFfy/AOP7dcIIDC7sy/duarv0R9n9m7h0cmV8uNHMPN4Q01ctAXGGEgfzU6uA9wXA8aa0RmRccFNdSORiObwLCGBnRaqWpOqkeCGoHztSAPlCjYI554N9GM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sznl3CkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0489C4CEF0
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 22:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749594931;
	bh=zhgFQwk1GFMLOuRnapR4kecbgdYNBQvJrsBkPLPvflU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sznl3CkJZ1dIwunELRCZqN8DJmg7ahvHxbcCosaT9BvGr+SjaB7c61l4aO+CfgPY8
	 Xygcg8s4Y0//iDnU/mhABvMNRE+ME1OKGdrB7Re+kjPjnAG+lpwpDCwEZEINLGMSua
	 HGCBwjmINsZwIj9DyHwsieqiDHf2z6Hrj6NUaO18/J7povCBZWDH/azoEn58hTfLDW
	 f+ibPnfeZjYXCBWgrDmFr7Jzl0ku91dYqiwqUs6mVD0Ro2MkSs4LFzIioaL1+WqBwu
	 vGXtsEgMDe0OAApOyFW7NIgAoTq/UdpHfJWrgrclrSJhsEA2KN1S9rs4BETf6azO0K
	 q3KjLuh4RBV7Q==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso6046077a12.0
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 15:35:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7NZWkeEfsjew0eyyMjC7nP9jHNE9wlFNLivjnqLUbJHE6SdIW5lnuRL/nOV71pJU73dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxzkq9Kyfs350zwJa2ym76mVJTMH5HSOuuBWnMUZfO5MccOE7
	B8EC8/0YhJfga5/NK9q+g2XlqKdztg8ja6D0zMPrO6f7RC4feL6JRwBaBwPXuI4ZOoOFDjczwFV
	ZFba8phe9uVcKPGfczow29w0jV7TtaFJhYI5rbNxX
X-Google-Smtp-Source: AGHT+IG0qvlGOKsN2bIglY2IYmdvTTXKsfP6l6rvTZGU4hJXJ8xMLM4zScrg1l4mXHegvH5no7mNTkVnpdCHssuYtkk=
X-Received: by 2002:a05:6402:42c8:b0:608:42f9:a5cb with SMTP id
 4fb4d7f45d1cf-6084683d8d9mr845177a12.10.1749594930421; Tue, 10 Jun 2025
 15:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-11-kpsingh@kernel.org>
 <87qzzrleuw.fsf@microsoft.com> <CACYkzJ6M7kA7Se4=AXWNVF1UyeHK3t+3Y_8Ap1L9pkUTbqys9Q@mail.gmail.com>
 <87o6uvlaxs.fsf@microsoft.com> <CACYkzJ74MJkwejki7kFNR4RWh+EnJ++0Vop8eRkSwY6pJepMEQ@mail.gmail.com>
 <8cf2c1cc15e0c5e4b87a91a2cb42e04f38ac1094.camel@HansenPartnership.com>
In-Reply-To: <8cf2c1cc15e0c5e4b87a91a2cb42e04f38ac1094.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 11 Jun 2025 00:35:19 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6yNjFOTzC04uOuCmFn=+51_ie2tB9_x-u2xbcO=yobTw@mail.gmail.com>
X-Gm-Features: AX0GCFvQT4-Dt9uvvG2HgnAZh8dl54TQK-uXw3uqe35VZQIYoEGbhRVyLPXc6hc
Message-ID: <CACYkzJ6yNjFOTzC04uOuCmFn=+51_ie2tB9_x-u2xbcO=yobTw@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 11:24=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2025-06-10 at 21:47 +0200, KP Singh wrote:
> > It's been repeatedly mentioned that trusted loaders (whether kernel
> > or BPF programs) are the only way because a large number of BPF
> > use-cases dynamically generate BPF programs.
>
> You keep asserting this, but it isn't supported by patches already

This is supported for sure. But it's not what the patches are
providing a reference implementation for. The patches provide a stand
alone reference implementation using in-kernel / BPF loaders but you
can surely implement this (see below):

> proposed.  Specifically, there already exists a patch set:
>
> https://lore.kernel.org/all/20250528215037.2081066-1-bboscaccy@linux.micr=
osoft.com/

The patch-set takes a very narrow view by adding additional UAPI and
ties us into an implementation. Whereas the current approach keeps the
UAPI clean while still meeting all the use-cases and keeps the
implementation flexible should it need to change. (no tie into the
hash chain approach, if we are able to move to stable BPF instruction
buffers in the future).

Blaise's patches also do not handle the trusted user-space loader
space and the "signature_maps" are not relevant to dynamic generation
or simple BPF programs like networking, see below.

>
> that supports both signed trusted loaders and exact hash chain
> verification of loaders plus program maps.  The core kernel code that

I have mentioned in various replies as to how the current design ends
up working for dynamic loaders. Here's it once again:

* The dynamic userspace loader is trusted, it's either compiled in
with libbpf statically or libbpf is also a trusted library.
* The BPF program is generated and all the relcoations are performed
at runtime, after which the BPF instruction buffer becomes stable and
can be signed which obviates the need for the loader program for
programs that have runtime relocations. And ofcourse, some BPF
programs don't have runtime relocations at all (e.g some networking
programs).
* The program is then signed with a derived credential at runtime and
this signature is passed in attr.signature and this signature is
verified by the kernel.

> does it is only about 10 lines and looks to me like it could easily be
> added to your current patch set.  This means BPF signing could support

I still don't understand the actual reasons for you needing this to
happen in the kernel.

Here's a summary of the reasons that have been thrown around:

Supply chain attacks
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I got vague answers about supply chain attacks. If one cannot trust
the build environment that builds the BPF programs, has signing keys,
generates and signs the loader, or that builds libbpf / kernel, then I
think one has other issues.

PS: You can also contribute code into LLVM / clang to generate loader
programs directly from a BPF object.

The loader code is hard to understand
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

So is the BPF JIT that lives in the kernel, I am sure there are
engineers who understand BPF assembly and JITs? Please remember the
user who uses BPF is different from the user who implements singing
for the BPF users, the latter (e.g. a distro, hyperscalar etc) needs
to be advanced and aware of BPF internals.

"having visibility" in the LSM code
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

To implement what specific security policy? There are security
policies and controls that need to be defined that are required by BPF
use-cases and one would expect the LSM experts to help here, none of
them require in kernel verification, here they are:

* LSM controls to reject programs that are not signed
* LSM controls that establish trust on userspace binaries and libraries.
* LSM policies that allow these components to either load programs
signed at runtime using a derived credential.
* LSM policies that allow certain signed BPF programs to be loaded
without requiring elevated privileges i.e CAP_BPF.

Auditing
=3D=3D=3D=3D=3D=3D

You can surely propose a follow up to my patches that adds audit
logging to the loader, that calls the audit code from using a BPF
kfunc, so this can be extended for auditing.

At this point, I am happy to discuss the actual security policy work
that is needed. For the discussion around the UAPI and in-kernel
verification, I rest it in the hands of the BPF maintainers.


- KP




> signer being in the position of deciding what they want and no loss of
> generality for either use case.
> >  So whatever we build needs to work for everyone and not just your
> > specific use-case or your affinity to an implementation.
>
> The linked patch supports both your trusted loader use case and the
> exact hash chain verification one the security people want.  Your
> current patch only seems to support your use case, which seems a little
> bit counter to the quote above.  However, it also seems that
> reconciling both patch sets to give everyone what they want is easily
> within reach so I think that's what we should all work towards.
>
> Regards,
>
> James
>

