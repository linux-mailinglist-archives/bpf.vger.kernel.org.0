Return-Path: <bpf+bounces-60321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950E3AD56E5
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 15:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5459E17DC8C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12D6288503;
	Wed, 11 Jun 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPXxBxIQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478201E485
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648311; cv=none; b=VxZvsVdP+H03U0/1AWsJOoM4ZD7w5hfHwMCfyoMJ8AoCOcbh1bZap2XD4vKg7iepf2GbWXWn84F07UDnwATVydLGgDawGwHaeheG4vqMfg9xVoiqU/XxNKXe6z6IJz9+vf9Pj/9lWtqjG30398/rvmsfgst7OLstiJDKfwrHigA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648311; c=relaxed/simple;
	bh=65kslE6qYV3dzV4TzXBWDQ0E+yOHagxY2R/q066gasY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWCxYgfjWhY1BPLDMy8MJrOkUqIV8x96JKGaBQfOKJ65P8sM/IBEYiqQAgWLcc74moCEWiyZtlQ03Pn120ZEZF3/Hyr6PhHSL9pqzuBaPYcg9GUR00bEpjTYSf2n+jy93e+iNkiwJIMw2hQzNzpLaWrIEppGX6w9aJbMaNRGIE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPXxBxIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A32C4CEF5
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648310;
	bh=65kslE6qYV3dzV4TzXBWDQ0E+yOHagxY2R/q066gasY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hPXxBxIQze8qkz9hQKtX0VbyQ2+gO5bGsODEl45hF6hnwdaOxxv/pFXTuZIGY9S73
	 BzmWn79paXwNVzWG+fFL+W7qaHDJTR/p6G811LxTIm8riykEXi5fMin/ftw4RjP6Bk
	 3LPomFbtzYtQqfCZEfqHPcjgRG0kwmlEU7rF2boNduPEhZx/D7cCgQ53sCzea8VvlP
	 CcF+6VfFoAgQof0BRmlKsFZBvk0CfxhsATtdG/GRtuLLfxuTE2LUA8uXQ81G/f93JS
	 jrxHFCwZF1bvmAq+YqAEnYMJVIhJ7mutPB3U1QtZGEXl02EgSEFp9D30O1KWPzBnbi
	 f3soD9+U58cGg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso7420760a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 06:25:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgpCYRPF05VQYPO77JrDYRsTmjdSL7WqHt2MvSv6p3sZ6gzUgZR19T82d0pKGOWkRU2Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFYEULvth47I5GuVRzdVJDkVph/7qUghBKYVskTUcrbhxNUe/
	NtgE3FOz9A1ZwIcIqfTKgRR+U0TJl02RKc2u5gv6FMNt0RvtBcd9AoK+V9JE8l7lcZ1pazBm33j
	V/B6JgKSjvRGoZnuvDAkYF0isLeX53teskcKwnWbf
X-Google-Smtp-Source: AGHT+IGhE6M6Y2hLMscAsD/sYn6L9tLVA3I6Ph+Q9G80ZZhNmESb7rLDXSnc0RBlKXVe4bB2gJoS3ANvXv//CMj5ihM=
X-Received: by 2002:a05:6402:13d0:b0:601:6c34:5ed2 with SMTP id
 4fb4d7f45d1cf-60846aa5910mr2531159a12.4.1749648308992; Wed, 11 Jun 2025
 06:25:08 -0700 (PDT)
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
 <CACYkzJ6yNjFOTzC04uOuCmFn=+51_ie2tB9_x-u2xbcO=yobTw@mail.gmail.com>
 <6f8e0d217d02dc8327a2a21e8787d3aec9693c2c.camel@HansenPartnership.com>
 <CACYkzJ4T5ZFuY5PDKp1VZmsdEyEYUbbajAbhqr+5FE6tqy195A@mail.gmail.com> <12d7049f41675a087b254c853b4c5d50969e68fd.camel@HansenPartnership.com>
In-Reply-To: <12d7049f41675a087b254c853b4c5d50969e68fd.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 11 Jun 2025 15:24:57 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4-0WFs+GHw3n+W_EVRM7+JTy=ZVZZ0a+t7tTM_j+z2JQ@mail.gmail.com>
X-Gm-Features: AX0GCFsOFslGXD5idWaVsBY78vnqvx_rruIq7PTVA1_RpI2mq8uliQxFe-UKUzM
Message-ID: <CACYkzJ4-0WFs+GHw3n+W_EVRM7+JTy=ZVZZ0a+t7tTM_j+z2JQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:12=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2025-06-11 at 14:33 +0200, KP Singh wrote:
> > On Wed, Jun 11, 2025 at 1:59=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Wed, 2025-06-11 at 00:35 +0200, KP Singh wrote:
> > > > On Tue, Jun 10, 2025 at 11:24=E2=80=AFPM James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > >
> > > > > On Tue, 2025-06-10 at 21:47 +0200, KP Singh wrote:
> > > > > > It's been repeatedly mentioned that trusted loaders (whether
> > > > > > kernel or BPF programs) are the only way because a large
> > > > > > number
> > > > > > of BPF use-cases dynamically generate BPF programs.
> > > > >
> > > > > You keep asserting this, but it isn't supported by patches
> > > > > already
> > > >
> > > > This is supported for sure. But it's not what the patches are
> > > > providing a reference implementation for. The patches provide a
> > > > stand alone reference implementation using in-kernel / BPF
> > > > loaders but you can surely implement this (see below):
> > > >
> > > > > proposed.  Specifically, there already exists a patch set:
> > > > >
> > > > > https://lore.kernel.org/all/20250528215037.2081066-1-bboscaccy@li=
nux.microsoft.com/
> > > >
> > > > The patch-set takes a very narrow view by adding additional UAPI
> > > > and ties us into an implementation.
> > >
> > > What do you mean by this?  When kernel people say UAPI, they think
> > > of the contract between the kernel and userspace.  So for both
> > > patch sets the additional attr. entries which user space adds and
> > > the kernel parses for the signature would conventionally be thought
> > > to extend the UAPI.
> > >
> > > Additionally, the content of the signature (what it's over) is a
> > > UAPI contract.  When adding to the kernel UAPI we don't look not to
> > > change it, we look to change it in a way that is extensible.  It
> > > strikes me that actually only the linked patch does this because
> > > the UAPI addition for your signature scheme doesn't seem to be that
> > > extensible.
> >
> > James, I am adding less attributes, it's always extensible, adding
> > more UAPI than strictly needed is what's not flexible.
>
> To repeat: the object should be extensibility not minimization.  If an
> API is extensible it doesn't tie you to a specific implementation
> regardless of how many arguments it adds.  The attr structure uses the
> standard kernel way of doing this: it can grow but may never lose
> elements and  features added at the end are always optional so an older
> kernel that doesn't see them can still process everything it does
> understand.
>
> > The attributes I proposed remain valid in a world where the BPF
> > instruction set is stable at compile time, for trusted user space
> > loaders (applications like Cilium) that can already have a stable
> > instruction buffer, the attributes Blaise proposed do not.
>
> I don't follow.  For stable compilation (I'm more familiar with the way
> systemd does this but I presume cilium does the same: by constructing
> ebpf byte code on the fly that doesn't require relocation and then
> inserting it directly) you simply program the loader to do the
> restrictions (about insertion point and the like) and sign it, correct?

There is no loader program if the instruction buffer is stable.

> That's covered in the linked patch in the !attr->signature_maps_size
> case, so what Blaise proposed most definitely does do this.
>
> > I believe we have discussed this enough. Let's have the BPF
> > maintainers decide.
>
> But this is obviously an important point otherwise you wouldn't be
> arguing about it.  If pure minimization were all that's required then
> it's easy to do since we're using pkcs7 signatures, the signature can
> contain a data structure with authenticatedAttributes that are
> validated by the signature, so I could do the Blaise patch with fewer
> attr elements than you simply by moving the maps and their count into
> the athenticatedAttributes element of the pkcs7 signature.  I could

Can we discuss this as a follow up as Paul proposed? I have limited
bandwidth to work on this, so this only delays what I think is a solid
baseline implementation.

- KP

> also do the same with your keyring_id and, bonus, it would be integrity
> validated.  Then each of you adds the same number of UAPI attr's so
> there's no argument about who adds fewer attributes.
>
> Regards,
>
> James
>

