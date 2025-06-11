Return-Path: <bpf+bounces-60323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7371AD5767
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 15:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1226A3A2E33
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05928B41A;
	Wed, 11 Jun 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEQV99lG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E421C28313D
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649303; cv=none; b=IphcFmcQ1Xy1AHbLwuc3crM92fWHRKn1j/LHBxg2kyll0DWnIlcOBX2sUAns8w1yPyjN/IUAxy+uLzh0uvOyl5ji0TvhEGMHAflxfYZpJaWY2dMeBG+5Nq87OPpVkWuTjQFfnh78M5cQKCVxVopoT5cc+s9tJOBw4waL9b/FzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649303; c=relaxed/simple;
	bh=4tmp676+IQ949gs6/CrHDkVmXb8eSg5m8lRI4y1hgYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xu08iYfglsqzQ4blwRrzfaBsvxcIsjxlAJ/11waSQG+YfzXQLHg6AwyUGe6loC2NX81zcQ+gzDNawom7IcZsucwVQ67ENceIvcVbkjiANgM8Zcq/Gk8lQS6SxCpQXHHqW9dbsTBjCcxYd0mTY1oVZh+A/enWlPF6r0uhU2FKZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEQV99lG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A12C4AF09
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749649302;
	bh=4tmp676+IQ949gs6/CrHDkVmXb8eSg5m8lRI4y1hgYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NEQV99lG2FAjSgOVKrFlK4KaUiHRv1Q+ymZh9IjtSqdf7X09GUJj9M6mKwL61PcYg
	 qKOQFVOTY/8uLUIPU8fYtbE5n9lkfpWr/bXHupcioDTw6q9V0p5opJHQfCKx8fnmpG
	 nFLO1ggDRU0vmDAGey8YLwf6G7HRSEG5wZj4thOkqXe9eJSszKSPwLF0Hql9Dg+edV
	 wDqS9Obmg2GnQd0uGVYjn24yNu/4aF5pKNkOJZ6/qob/jjFQUvPh1gk8Y7BQeZd5lA
	 a2GF+RVWsGpEcTYNignyPRV5j2m0ca2NcYm9w7PeASvtFvBRpf+06wlIiTY1b1xfsm
	 gdAi83HYwHIjg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so10255391a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 06:41:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXH1wKJv2LZ4btMSgFJzuhzbchnKGo5LEBMw4z166qULCI8JwcMXS0OBTGD/JuVkopVdGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTYfEmI3Yt7NX7V3kJwpgbqXC8wqI/CR8+/mvLoCzE1uiS2WP
	hjPaa4WFZOB+BVFUivhRvQ14ZMWYCK0uLXKKjR1I3tcfnLaWaC+1Be46qXYvfvyGG+isjFGz6Zv
	h04tDyg0IYsewk2w9LH2SGnXRJ40RJrndma/NExsX
X-Google-Smtp-Source: AGHT+IGHC4d+/ja02Pdc6Uwk6I+BZyyFjpYdMueX68hcAmX9GCs+uYJpN1/hb62pYNuX1Ph3Ln8s8ahhhzXhfr915dw=
X-Received: by 2002:aa7:d985:0:b0:608:50ab:7e38 with SMTP id
 4fb4d7f45d1cf-60850abc0d2mr1700831a12.14.1749649301001; Wed, 11 Jun 2025
 06:41:41 -0700 (PDT)
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
 <CACYkzJ4T5ZFuY5PDKp1VZmsdEyEYUbbajAbhqr+5FE6tqy195A@mail.gmail.com> <fa526e6ed52e2c5f72aeb24fa24f3731bac6f74d.camel@HansenPartnership.com>
In-Reply-To: <fa526e6ed52e2c5f72aeb24fa24f3731bac6f74d.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 11 Jun 2025 15:41:30 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4JYDXEkYpN=XBn4bOmv6Fg7bSgV-YAKHfEL2NxJiMh0A@mail.gmail.com>
X-Gm-Features: AX0GCFv86LhfY9bz8qjJjWyl5JM6Chhze6kRDIuvQLuHxjxt-POwDqAw8UiU5E8
Message-ID: <CACYkzJ4JYDXEkYpN=XBn4bOmv6Fg7bSgV-YAKHfEL2NxJiMh0A@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:18=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2025-06-11 at 14:33 +0200, KP Singh wrote:
> > [...]
> > I have read and understood the code, there is no technical
> > misalignment.
> >
> > I am talking about a trusted user space loader. You seem to confuse
> > the trusted BPF loader program as userspace, no this is not
> > userspace, it runs in the kernel context.
>
> So your criticism isn't that it doesn't cover your use case from the
> signature point of view but that it didn't include a loader for it?
>
> The linked patch was a sketch of how to verify signatures not a full

It was a non functional sketch that did not address much of the
feedback that was given, that's not how collaboration works.

> implementation.  The pieces like what the loader looks like and which
> keyring gets used are implementation details which can be filled in
> later by combining the patch series with review and discussion.  It's
> not a requirement that one person codes everyone's use case before they
> get theirs in, it's usually a collaborative effort ... I mean, why

Yeah, it's surely a collaborative effort, but the collaboration has
been aggressive and tied to a specific implementation (at least from
some folks). Rather than working with the feedback received it has
been accusational of mandating and forcing. If the intent is to really
collaborate, let's land this base implementation and discuss further.
I am not willing to add additional stuff into this base
implementation.

> would you want Microsoft coding up the loader?  If they don't have a
> use case for it they don't have much incentive to test it thoroughly
> whereas you do.

It seems that your incentives are purely aligned with Microsoft and
not that of the BPF community at large (this is also visible from the
patches and the engagement). FWIW, There is no urgency for my employer
to have signed BPF programs, yet I am working on this purely to help
you and the community.

- KP

>
> Regards,
>
> James
>

