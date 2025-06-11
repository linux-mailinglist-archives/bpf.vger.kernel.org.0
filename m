Return-Path: <bpf+bounces-60314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F8AD559C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381ED3A5B82
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFEC27FB27;
	Wed, 11 Jun 2025 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL1NA0m3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1CE235044
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645195; cv=none; b=ArGunGrcflW4jAgV8IG2h+3+pKVUD+PejzbKbkhUUNYWT36J1oWp5X5sAf2Ts542D9Bz1iJwgn32r9++KKwlPeYN6bxv+LcVGRadVeeam/ke3Z0rOLayTOB3hyIP8Td6KbznZ8SNgDzn+nLMDpYXdoCYXQTcWs+zwgBkRtSBjMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645195; c=relaxed/simple;
	bh=5LplqxcjvsXWXyULlG+fwCr5loIPsnByI2A9V+2TZdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7vw662C9BQuCNQJ5ey+sXFI1wQerv4UNoOBqdcFpKbH+UE3HiXREpxwXXcJGw1bIP6g1kqBX9uKwoVOuxUwyvAIdFbz0VEN5g3ptnQONZ9W2kKv8KEslMcRYsQnLyuNx7Kuxj2QvxvG+csgSdtThc4ggvUjhK/eC95MSVzsMpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL1NA0m3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7365BC4CEF3
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645195;
	bh=5LplqxcjvsXWXyULlG+fwCr5loIPsnByI2A9V+2TZdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lL1NA0m3AeI+Qc/rOtPk3Yr+s53wFblEYvK5uKfqe8IFcUsVpw8+SDCV4kDaFGlhY
	 sIHyq8RSVehqNbYBE0dma3DaOt3IFIbLke2ANDwaplzO9n74FhTMwJxVsFhZau1q3V
	 sdTCX4xl5zjLBe1mPLM/BVhJN2QjjmuvMxDwU02VIkCdP0To+dNxeC3kyBRFZWd53b
	 yPfocxxuHPZ9IWX6bDlDLskzzcHCRNEhOoEkFrE45IBs7xaEDOeV+kqXM14yrByzY0
	 8NLyhIZqaFX3MIXdD6mc3Il7FV8NRUK29fNet+D/Pg2pIPo8YLCeO6xmy0+mP8zHs5
	 6tUEbqw3snR1g==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso7322606a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 05:33:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4aJ7DDJm09gElPsBDJPzFlfOVkPFeu/9p4iFmk4IxNetrawiiReBVwrYqeq04DaIgAEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCIAHSsIBV0yyObkMA35I8IzzVle2Wqe/JPWR9o7s/Iiziu+7
	Re7sZb2kabEB03IjJyIfKnDhMXXRTnWeYWozIs96wF1ynj/Uowy6e9uduFaVleDvEDU2G4OEry1
	fdNey7RvDxA5CdnRbpf6b5/AWf7+SM3b8ua2NNguJ
X-Google-Smtp-Source: AGHT+IHnHo1sp65gTeHjFWrjyecYP4KUKXYXAirIMn3mz+yHmyss73COzFYIVqA+WU566YCXi6ePCiqo5KTjaXQq2Ac=
X-Received: by 2002:a05:6402:120d:b0:602:1b8b:2902 with SMTP id
 4fb4d7f45d1cf-60846b2f16bmr2054905a12.15.1749645193964; Wed, 11 Jun 2025
 05:33:13 -0700 (PDT)
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
 <CACYkzJ6yNjFOTzC04uOuCmFn=+51_ie2tB9_x-u2xbcO=yobTw@mail.gmail.com> <6f8e0d217d02dc8327a2a21e8787d3aec9693c2c.camel@HansenPartnership.com>
In-Reply-To: <6f8e0d217d02dc8327a2a21e8787d3aec9693c2c.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 11 Jun 2025 14:33:03 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4T5ZFuY5PDKp1VZmsdEyEYUbbajAbhqr+5FE6tqy195A@mail.gmail.com>
X-Gm-Features: AX0GCFuFQjcGWCNNEXoMDm4GJGMvIlT26_y09n7QBUmNReGXQjm22TvJL8ihqRE
Message-ID: <CACYkzJ4T5ZFuY5PDKp1VZmsdEyEYUbbajAbhqr+5FE6tqy195A@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 1:59=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2025-06-11 at 00:35 +0200, KP Singh wrote:
> > On Tue, Jun 10, 2025 at 11:24=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Tue, 2025-06-10 at 21:47 +0200, KP Singh wrote:
> > > > It's been repeatedly mentioned that trusted loaders (whether
> > > > kernel or BPF programs) are the only way because a large number
> > > > of BPF use-cases dynamically generate BPF programs.
> > >
> > > You keep asserting this, but it isn't supported by patches already
> >
> > This is supported for sure. But it's not what the patches are
> > providing a reference implementation for. The patches provide a stand
> > alone reference implementation using in-kernel / BPF loaders but you
> > can surely implement this (see below):
> >
> > > proposed.  Specifically, there already exists a patch set:
> > >
> > > https://lore.kernel.org/all/20250528215037.2081066-1-bboscaccy@linux.=
microsoft.com/
> >
> > The patch-set takes a very narrow view by adding additional UAPI and
> > ties us into an implementation.
>
> What do you mean by this?  When kernel people say UAPI, they think of
> the contract between the kernel and userspace.  So for both patch sets
> the additional attr. entries which user space adds and the kernel
> parses for the signature would conventionally be thought to extend the
> UAPI.
>
> Additionally, the content of the signature (what it's over) is a UAPI
> contract.  When adding to the kernel UAPI we don't look not to change
> it, we look to change it in a way that is extensible.  It strikes me
> that actually only the linked patch does this because the UAPI addition
> for your signature scheme doesn't seem to be that extensible.

James, I am adding less attributes, it's always extensible, adding
more UAPI than strictly needed is what's not flexible.

The attributes I proposed remain valid in a world where the BPF
instruction set is stable at compile time, for trusted user space
loaders (applications like Cilium) that can already have a stable
instruction buffer, the attributes Blaise proposed do not.

I believe we have discussed this enough. Let's have the BPF maintainers dec=
ide.

>
> >  Whereas the current approach keeps the UAPI clean while still
> > meeting all the use-cases and keeps the implementation flexible
> > should it need to change. (no tie into the hash chain approach, if we
> > are able to move to stable BPF instruction buffers in the future).
> >
> > Blaise's patches also do not handle the trusted user-space loader
> > space and the "signature_maps" are not relevant to dynamic generation
> > or simple BPF programs like networking, see below.
>
> OK, is this just a technical misreading?  I missed the fact that it
> supported both schemes on first reading as well.  If you look in this
> patch:
>
> https://lore.kernel.org/all/20250528215037.2081066-2-bboscaccy@linux.micr=
osoft.com/
>
> It's this addition in bpf_check_signature():
>
> > +     if (!attr->signature_maps_size) {
> > +             sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_=
insn), (u8 *)&hash);
> > +             err =3D verify_pkcs7_signature(hash, sizeof(hash), signat=
ure, attr->signature_size,
> > +                                  VERIFY_USE_SECONDARY_KEYRING,
> > +                                  VERIFYING_EBPF_SIGNATURE,
> > +                                  NULL, NULL);
> > +     } else {
> > +             used_maps =3D kmalloc_array(attr->signature_maps_size,
> > +                                       sizeof(*used_maps), GFP_KERNEL)=
;
> > [...]
>
> The first leg of the if is your use case: a zero map size means the
> signature is a single hash of the loader only.  The else clause
> encompasses a hash chain over the maps as well.  This means the signer
> can choose which scheme they want.

I have read and understood the code, there is no technical misalignment.

I am talking about a trusted user space loader. You seem to confuse
the trusted BPF loader program as userspace, no this is not userspace,
it runs in the kernel context.

- KP

>
> I'll skip responding to the rest since it seems to be assuming that
> Blaise's patch excludes your use case (which the above should
> demonstrate it doesn't) and we'd be talking past each other.
>
> Regards,
>
> James
>

