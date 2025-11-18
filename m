Return-Path: <bpf+bounces-74987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB74C6A1AA
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 15:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77A6C4F6B4F
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D8F3559F9;
	Tue, 18 Nov 2025 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MfPQjbkh"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C782299943
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476929; cv=none; b=XURsYqFULsF2BKyDyVXZhtUkRjdZ3WHdvO2Q25nfievLr2zpB9Fo5ioMBKclemo1mEUsJep8YZj9mSsYxUw6mCc/dSA+L4r4a1V0iNcoTGSmkazPR7s9sAbLHYvsDQvGv1LEP9ycRRGw/IJxb99E4U4m1X0nYfDmZYQsMo5dN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476929; c=relaxed/simple;
	bh=6/7fuoc8yZaR2J272NjBoU2HMJZummVj66lqJA+thYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ZTMVFrtTpWVlwQsLavFM4FSgyYbivgAWrDOOrTzDwinw4ODEtuCmnT8OCDy9Di+ENLHYktxvGY49VkGd/nqQkWLVxzN91McHb3l4d2E77k3DlP+OU6eq2Y4Butp5B+LCUKNHk0EGlxlrDYDNOABbanCb8QqpMF2TThccVliqbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MfPQjbkh; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <241e7845-fa5e-47d1-b4d8-da901c1f0f5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763476923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xo0X1DMKYhDh7SHsObr+zucu5v73PWu7vt2XR0Moyis=;
	b=MfPQjbkhzOwXqcIib75XPGEJHeAzIZF9+10mDqVkWa3BVkcvfXLJ0ZmYg7+BgDQSm5AtPT
	8ycL4bkF/lejstnjnY6rHAmfh1po32iav5nQ7OMi82C8dhvXzhSxder5FKUEj/xA4S+oJP
	dYO1jBENU7md1cTjGMpJrNB54RJcPTc=
Date: Tue, 18 Nov 2025 14:41:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] Add cryptographic hash and signature
 verification kfuncs to BPF
To: Daniel Hodges <git@danielhodges.dev>, Alexei Starovoitov
 <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
References: <20251117211413.1394-1-git@danielhodges.dev>
Content-Language: en-US
Cc: bpf <bpf@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251117211413.1394-1-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/11/2025 21:13, Daniel Hodges wrote:
> This series extends BPF's cryptographic capabilities by adding kfuncs for
> SHA hashing and ECDSA signature verification. These functions enable BPF
> programs to perform cryptographic operations for use cases such as content
> verification, integrity checking, and data authentication.
> 
> BPF programs increasingly need to verify data integrity and authenticity in
> networking, security, and observability contexts. While BPF already supports
> symmetric encryption/decryption, it lacks support for:
> 
> 1. Cryptographic hashing - needed for content verification, fingerprinting,
>     and preparing message digests for signature operations
> 2. Asymmetric signature verification - needed to verify signed data without
>     requiring the signing key in the datapath
> 
> These capabilities enable use cases such as:
> - Verifying signed network packets or application data in XDP/TC programs
> - Implementing integrity checks in tracing and security monitoring
> - Building zero-trust security models where BPF programs verify credentials
> - Content-addressed storage and deduplication in BPF-based filesystems
> 
> Implementation:
> 
> The implementation follows BPF's existing crypto patterns:
> 1. Uses bpf_dynptr for safe memory access without page fault risks
> 2. Leverages the kernel's existing crypto library (lib/crypto/sha256.c and
>     crypto/ecdsa.c) rather than reimplementing algorithms
> 3. Provides context-based API for ECDSA to enable key reuse and support
>     multiple program types (syscall, XDP, TC)
> 4. Includes comprehensive selftests with NIST test vectors
> 
> Patch 1: Add SHA-256, SHA-384, and SHA-512 hash kfuncs
>    - Adds three kfuncs for computing cryptographic hashes
>    - Uses kernel's crypto library implementations
>    - Validates buffer sizes and handles read-only checks
> 
> Patch 2: Add selftests for SHA hash kfuncs
>    - Tests basic functionality with NIST "abc" test vectors
>    - Validates error handling for invalid parameters
>    - Ensures correct hash output for all three algorithms
> 
> Patch 3: Add ECDSA signature verification kfuncs
>    - Context-based API: create/acquire/release pattern
>    - Supports NIST curves (P-256, P-384, P-521)
>    - Includes both verification and signing operations
>    - Enables use in non-sleepable contexts via pre-allocated contexts
> 
> Patch 4: Add selftests for ECDSA signature verification
>    - Tests valid signature acceptance
>    - Tests invalid signature rejection
>    - Tests sign-then-verify workflow
>    - Tests size query functions
>    - Uses RFC 6979 test vectors for P-256
> 
> 
> Example programs demonstrating usage of these kfuncs can be found at:
> https://github.com/hodgesds/cryptbpf
> 
> All tests pass on x86_64:
> 
>    # ./test_progs -t crypto_hash
>    #1/1     crypto_hash/sha256_basic:OK
>    #1/2     crypto_hash/sha384_basic:OK
>    #1/3     crypto_hash/sha512_basic:OK
>    #1/4     crypto_hash/sha256_invalid_params:OK
>    #1       crypto_hash:OK
> 
>    # ./test_progs -t ecdsa_verify
>    #2/1     ecdsa_verify/verify_valid_signature:OK
>    #2/2     ecdsa_verify/verify_invalid_signature:OK
>    #2/3     ecdsa_verify/sign_and_verify:OK
>    #2/4     ecdsa_verify/size_queries:OK
>    #2       ecdsa_verify:OK
> 
> Configuration Requirements:
> - SHA kfuncs require CONFIG_CRYPTO_LIB_SHA256=y (default in most configs)
> - ECDSA kfuncs require CONFIG_CRYPTO_ECDSA=y|m
> 
> Future extensions could include:
> - Additional hash algorithms (SHA3, BLAKE2)
> - RSA signature verification
> - Additional NIST curves (P-192, P-521)
> - Hardware acceleration support where available

I might be a better idea to implement hashing type and register it, like
it's done for crypto algorithms. Currently, the only type is encryption/
decryption type. You can add hash type, extend callbacks to have hash(),
and let user choose the hash algo? That will make code without any
duplication just because of new algo...

