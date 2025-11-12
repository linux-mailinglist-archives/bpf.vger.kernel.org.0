Return-Path: <bpf+bounces-74329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3CC54739
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 21:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CC9C4F160A
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5FA2D131D;
	Wed, 12 Nov 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQSFzRYI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769C27B359;
	Wed, 12 Nov 2025 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979048; cv=none; b=WUEUiCHDgULlvrhjQkz8joz/aaDCW+iX/RpxYSMMJ6VC3RxYoLrwaB9zarS0Ce7Cq2zEBqGTrWCmcAm1Bj4aYBSfgjp2xulrqH7MFybG8oEuuthZlfi2IobECKusfDOH0IISb3bhosblvbRYHspK+/ENQ4pNy8iZaXE1Fk7wtfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979048; c=relaxed/simple;
	bh=V7Viu4MHlojVqnJ12RNQpm9DyfbuvHsqxBrF6sBFiRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/iHEtJl9FNbcBubNNYpjYaULagGv9Wn1/vsBHuDVOQ8SwsKD9fdcHSfKViefOU3hXZH5hQ03EHtSyV3EDreiUxuEqF/F/4QWDKX/n2oFOYiPSoDJmcUy3lJ7tr99ivcJzA3lwIkZg1C+rKy583tehnscCEVbksGsoT7Ys3DLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQSFzRYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F2C4CEF5;
	Wed, 12 Nov 2025 20:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762979046;
	bh=V7Viu4MHlojVqnJ12RNQpm9DyfbuvHsqxBrF6sBFiRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQSFzRYI9dEBuYpJYxBr7pyiPHx/cRWWYOs4tDdA1IqO6Q9EBpfwrad+jgXqFol9D
	 iaMIDlxzzlOKr67fOuSvZ24a3yNhudTefFp/yVynWSV6rLVIkrEMlC/FeUvfwKP6iy
	 CGN04HLsi/T1rbczApWoQocq2o559D8DAa1CCVkeZXzSwuktBoOB9ZIcVDTUkJksVY
	 f4nUMiL4EwcshakDdw41t40mUPEMgSA6PCO4o15dsO9ELKWizawSnwcJsKybeKJnpe
	 ObawuvA9V989S5mQKcQBT6GsKHSzzaoJHDo9O+tSpBtcqSBn22tpuDXFM9TdeBsnTA
	 jJ2ORlThR19ZA==
Date: Wed, 12 Nov 2025 12:22:25 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1
 code instead of AF_ALG
Message-ID: <20251112202225.GA1760@sol>
References: <20250929194648.145585-1-ebiggers@kernel.org>
 <20251112121212.66e15a2d@phoenix>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112121212.66e15a2d@phoenix>

On Wed, Nov 12, 2025 at 12:12:12PM -0800, Stephen Hemminger wrote:
> On Mon, 29 Sep 2025 12:46:48 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > diff --git a/lib/sha1.c b/lib/sha1.c
> > new file mode 100644
> > index 00000000..1aa8fd83
> > --- /dev/null
> > +++ b/lib/sha1.c
> > @@ -0,0 +1,108 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * SHA-1 message digest algorithm
> > + *
> > + * Copyright 2025 Google LLC
> > + */
> 
> Not a big fan of having actual crypto in iproute2.
> It creates even more technical debt.
> Is there another crypto library that could be used?

Currently iproute2 doesn't depend on OpenSSL.  You can make it do that,
if you want, and then you could use SHA-1 from there.  I suspect that
doing that would be much more trouble than just adding this SHA-1 code.

If you happen to be planning to pull in OpenSSL as a dependency for
other reasons, it might make sense then.

> Better yet, is there a reason legacy BPF code needs to still exist
> in current iproute2? When was the cut over.

No idea.  That's a question for the BPF folks.

- Eric

