Return-Path: <bpf+bounces-76933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8943CCC9D25
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B52FB303974D
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 23:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9341330656;
	Wed, 17 Dec 2025 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNOL7TKS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360C81732;
	Wed, 17 Dec 2025 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015090; cv=none; b=qlWxPXv7Rv2Yh7cjftP5V5swHy1PDixcIR6aMo17YGYup8LjPwiVzMg9iH8lqm8qbARKKOYSjzIwX/U1GrnO49MG82NXfaeMBmuvUmm4sXa1urU0LDaRohwJa9KvaHyjl52k4JDLu77t9Az0AA3N+yumFpGR5+tsvwNn2tRsN4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015090; c=relaxed/simple;
	bh=VUAafnoaqbtHyXLgpU6Otv3PPLrn+szmWYJeszdskFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4Re33Yho9GwG5Mo7q6n7H+pcG3sW9lgUTF4EY1blroMmpkY+SKoBS0KRszeLH8NI2PzuIPiXYXbW2JbBdIfL21NPo9DGSoE/RPHZmNrdSXLdE5mjsZqw3QpJ8+A3HM1u8vMZjiXysRWFJltjWoitHWbXW3BSQeEMCKNWGQYVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNOL7TKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8182DC4CEF5;
	Wed, 17 Dec 2025 23:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766015089;
	bh=VUAafnoaqbtHyXLgpU6Otv3PPLrn+szmWYJeszdskFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNOL7TKSCM8jbS+7WIvchfQnx6yI86ubBK75XFYj5311Cf8ACXti0apcIionfQgb8
	 Jye1yGUb8cSpW2wpfQTtSl11TefhEyZg2HRqUwQyCS4nX/8k/Kponv7tQMdQM3Kmr3
	 4Iur+XyjLuztf/5LONuxAe33SygksoXrbrF9x+32KCe8qCkV72FVYpVt7puss2gsGG
	 U1hKZpfVc+HT8SsurMrr3ghB1MLLbi6HNTALsXFOGHQTguSeHqWUFfZjdQDInUo9/n
	 f4+1cLIjgF3uavJwFtP59XoPWvKAWgzxKdCPm6j66fISufUk8fuNXGQw21nAf6KJ/P
	 PJyAsCghJWt3g==
Date: Wed, 17 Dec 2025 23:44:47 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1
 code instead of AF_ALG
Message-ID: <20251217234447.GA89113@google.com>
References: <20250929194648.145585-1-ebiggers@kernel.org>
 <20251112040719.GB2832160@google.com>
 <59755b49-fb81-41bf-8875-17e0215f1d8e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59755b49-fb81-41bf-8875-17e0215f1d8e@kernel.org>

On Sun, Nov 16, 2025 at 10:45:47AM -0700, David Ahern wrote:
> On 11/11/25 9:07 PM, Eric Biggers wrote:
> > [Adding David Ahern.  I overlooked that iproute2 has separate
> > maintainers for the main tree and the next tree.]
> > 
> > On Mon, Sep 29, 2025 at 12:46:48PM -0700, Eric Biggers wrote:
> >> Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy.c use
> >> it to calculate SHA-1 digests instead of the previous AF_ALG-based code.
> >>
> >> This eliminates the dependency on AF_ALG, specifically the kernel config
> >> options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
> >>
> >> Over the years AF_ALG has been very problematic, and it is also not
> >> supported on all kernels.  Escalating to the kernel's privileged
> >> execution context merely to calculate software algorithms, which can be
> >> done in userspace instead, is not something that should have ever been
> >> supported.  Even on kernels that support it, the syscall overhead of
> >> AF_ALG means that it is often slower than userspace code.
> >>
> >> Let's do the right thing here, and allow people to disable AF_ALG
> >> support (or not enable it) on systems where iproute2 is the only user.
> >>
> >> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > 
> > Stephen and David, any interest in applying this patch?
> > 
> > - Eric
> 
> I do not have a strong opinion in either direction.
> 
> If we are going to entertain removing AF_ALG code, we should apply the
> patch to iproute2-next at the beginning of a dev cycle to give maximum
> time for testing before it rolls out.

Any insight into when that would be?

- Eric

