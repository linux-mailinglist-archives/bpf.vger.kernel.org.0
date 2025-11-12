Return-Path: <bpf+bounces-74268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FD4C507AE
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 05:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE4464E9D7B
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 04:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF412D5C97;
	Wed, 12 Nov 2025 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsQa5b7u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0C2820DB;
	Wed, 12 Nov 2025 04:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920443; cv=none; b=k8ZEdbGtCrzHMQFkMtFBd833VEf4kxyoN75njzXcV3vVGideGaGcLeYkJQ0YFmBrMvtfjSJ/SeCSRLCg4FVKQPWywDeB7XXhDIwYhK7RtAJO387qrAlxv9Z2rtN9rDwVwe/QXhHdp6JuNYxGMIpVszen+9K6HyJvtZjz2DNifEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920443; c=relaxed/simple;
	bh=m3plAV8OHJtWBsWMLz9UPId3Nq/viGgfVBH4/ctoAG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKZRhOGOvNb9arvUcsplMU2bNFolZ1jIV4/TANVOVNUOAgPaNHj0pOCNWuUhx8rbSk0Qngj08AKb0bZqkj1STzWIKGU5n6FydsuPgtWUuMtHe3HjYZHaq7MyCxZVNDWGJSS4hcjzXWzpmk4Jz5LGidYv8Gl8i5ToPB8fVgKt54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsQa5b7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E819C116B1;
	Wed, 12 Nov 2025 04:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762920441;
	bh=m3plAV8OHJtWBsWMLz9UPId3Nq/viGgfVBH4/ctoAG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsQa5b7u3/JQQxE2ic9zBaNt/Ct3YlRuJiMdgvg2qjVjZBe6UXk+ab23VSlVEH7Rn
	 x56n6rgTiqDJSH2zMgqQCmXTSWkTrwBKaHaGMPFZCYV1cuCKQqCsNF2w2kNjWSTqsC
	 Q2/q59MDofR4D+WiIlCgj7onOhmOi6mr7vC7y8OKANfTf8+Kqyi3/kX7O+ON2Un98c
	 NrZcl3egV7u1m9tj05LTrvmYZkolMlz8Dx3Kqm3fxB4X8EvH2Rhhi97Hk1RBLOVRv6
	 gLMJiFyh2rvh0kxTUK2tIJ+U5yOxtwf6JDtaQLyQnREbQItr1j9563lR2hhzZyRMPV
	 slKlaPfyk+GFA==
Date: Wed, 12 Nov 2025 04:07:19 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Cc: linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1
 code instead of AF_ALG
Message-ID: <20251112040719.GB2832160@google.com>
References: <20250929194648.145585-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929194648.145585-1-ebiggers@kernel.org>

[Adding David Ahern.  I overlooked that iproute2 has separate
maintainers for the main tree and the next tree.]

On Mon, Sep 29, 2025 at 12:46:48PM -0700, Eric Biggers wrote:
> Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy.c use
> it to calculate SHA-1 digests instead of the previous AF_ALG-based code.
> 
> This eliminates the dependency on AF_ALG, specifically the kernel config
> options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
> 
> Over the years AF_ALG has been very problematic, and it is also not
> supported on all kernels.  Escalating to the kernel's privileged
> execution context merely to calculate software algorithms, which can be
> done in userspace instead, is not something that should have ever been
> supported.  Even on kernels that support it, the syscall overhead of
> AF_ALG means that it is often slower than userspace code.
> 
> Let's do the right thing here, and allow people to disable AF_ALG
> support (or not enable it) on systems where iproute2 is the only user.
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Stephen and David, any interest in applying this patch?

- Eric

