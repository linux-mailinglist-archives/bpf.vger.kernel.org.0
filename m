Return-Path: <bpf+bounces-74675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2AC619DB
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 18:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A7B3B34EB
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071530FC16;
	Sun, 16 Nov 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWNTQiM4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2511CD15;
	Sun, 16 Nov 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763315149; cv=none; b=rePWZRl2GY61ecfA5VSAtPCUQzhIx7rNJoRWYUBDdGZgoijyrzaIgn4EbWWvZTGyyfVZyHB933MBh5h7dQcs/GzVhdXJz8rg4ILYjf15nHlWj6/AGbwQ8SWowg8TPbtGHMoCeCKQMkHFuEcqyTFrxrKGk6/PSCtraX2a19vGb/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763315149; c=relaxed/simple;
	bh=mIMof+j6xW8EbtWWouxNGS8h1imgmKlIsYXitSco97I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3CeAwEjwgHNnir6c/4gyc1cDnMHUJlt+WSVwpRVPIhlaFRFKYecSpzSlQKg+0T9EpCB4/La2ErkoMOpDu4Aon7xlBwKsAJ/t4wieox6z7MxfB5/qG1Tn9cUv1mu8ddTo4l37w1j7j9Bv4AxO/cywNB1XE00DuUucEHu+mh59Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWNTQiM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E8EC4CEFB;
	Sun, 16 Nov 2025 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763315149;
	bh=mIMof+j6xW8EbtWWouxNGS8h1imgmKlIsYXitSco97I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GWNTQiM4QKHL1hTXslK0h0UIB+ahqAweF4kMbt8g6fpGq4sp/jQ+bXRloojTBtUR6
	 4cr/uBAGL9uzQ6RnWR9jo4BJrSzu5W7/dM0HOebdgORuszGIAsP9zDunSLbW7NftiS
	 lMY/ZTCTpHt2OmyCTEWS0+P24oPVSQVjO1rFG9sfySiK35/O7o9cEqw0ks9Xy/vW6K
	 ly5QvYRlsCZNPBhfzZruRNjIFqmNPWojhglGlM5y/lTSsjks1G9gIxwuiXfMhjm5wd
	 rEaLgqqA5C3J0VD/eehKCk+GpiyMCJ1TiZFL89DGqmfnaxOkImHR8V+C418CUKScKK
	 y3FwdbDiXp7gQ==
Message-ID: <59755b49-fb81-41bf-8875-17e0215f1d8e@kernel.org>
Date: Sun, 16 Nov 2025 10:45:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250929194648.145585-1-ebiggers@kernel.org>
 <20251112040719.GB2832160@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251112040719.GB2832160@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 9:07 PM, Eric Biggers wrote:
> [Adding David Ahern.  I overlooked that iproute2 has separate
> maintainers for the main tree and the next tree.]
> 
> On Mon, Sep 29, 2025 at 12:46:48PM -0700, Eric Biggers wrote:
>> Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy.c use
>> it to calculate SHA-1 digests instead of the previous AF_ALG-based code.
>>
>> This eliminates the dependency on AF_ALG, specifically the kernel config
>> options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
>>
>> Over the years AF_ALG has been very problematic, and it is also not
>> supported on all kernels.  Escalating to the kernel's privileged
>> execution context merely to calculate software algorithms, which can be
>> done in userspace instead, is not something that should have ever been
>> supported.  Even on kernels that support it, the syscall overhead of
>> AF_ALG means that it is often slower than userspace code.
>>
>> Let's do the right thing here, and allow people to disable AF_ALG
>> support (or not enable it) on systems where iproute2 is the only user.
>>
>> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> Stephen and David, any interest in applying this patch?
> 
> - Eric

I do not have a strong opinion in either direction.

If we are going to entertain removing AF_ALG code, we should apply the
patch to iproute2-next at the beginning of a dev cycle to give maximum
time for testing before it rolls out.

