Return-Path: <bpf+bounces-74990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 160D2C6A630
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 16:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5E07E2BC7A
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8EC368266;
	Tue, 18 Nov 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="dC1UnRN+";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="nK3ol9lc"
X-Original-To: bpf@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F8368271
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480847; cv=none; b=XvtdAVF7BaGrWRfNVNd8/G2rVpseKpjWZ+IYsHwF0DwS9CVh2/h0/D7yPc72jz8HgER4hBh+TGYvReO00AIyrdustQ49Ej/e/LWDQ7TyFIyntIl2KYGYXuvpKyhMvjk/3A2OIOGAq5Kb0or8hjctVrjQbvRqf/OC1y4kRJG5Y7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480847; c=relaxed/simple;
	bh=WEK3pece/MrmgiHrZPqwM3Ylf2JmM4z/+MARuA32ISA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+tjYCC93hj+bvAUWnIr0IG3SuWuSbbUm/vbvstXEcx0xdn9vW7zz9xjM0gKUrP5a+bXK5HQM9S8/Gd8uG1as/Vegt1Yz1Ef3LsBXwVaSPqOtxKlci/jzUhdu93ZNwE64g4TL/TGUFSjkBLyjHEofF3v90JeurTsPZXbsep8Kks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=dC1UnRN+; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=nK3ol9lc; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1763480678; bh=ALeKj7xMhiKF+PNjK0gL9yL
	GS6b2b2BqSy1D3+k0YcE=; b=dC1UnRN+F0wl7DwqfIc2Yin+3EdtsBn/mOYMKBJR02s0U0kTPu
	O3p8m8oCwhVHC3WCNlXAA0zd6QxhivCrgq5xOEC+npeC6exFk5T7NUOlcdoVwjMDODKgd/rxmVm
	R0grQKWGN0NE2QPoJC9mU/GUqW4VLQSOCbyezhwgozcOnpnJ0woq3YeFVMK83kf9IhNxmN5wfde
	+SyC7x4Lw8lV3lFgUxKX9ZPY4bOzEtQlMoUp4AYDGxVEon2RjSpZD+5IbTUyHAwpFmHdCQFhhiI
	I0wc+58rqArt9zmEiTkRPrWs19Z6g+995m9WSRjYu+qX5/woKyVC/jKMC+/69YpzKIw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1763480678; bh=ALeKj7xMhiKF+PNjK0gL9yL
	GS6b2b2BqSy1D3+k0YcE=; b=nK3ol9lc5D7punc2fljhnwIpesvMY6xjQAT35O8GN5gLNw6QYu
	+BuRERBeIm5KFIJS1YES4yop6rvsImCpMaBQ==;
Date: Tue, 18 Nov 2025 10:44:38 -0500
From: Daniel Hodges <daniel@danielhodges.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Daniel Hodges <git@danielhodges.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/4] Add cryptographic hash and signature
 verification kfuncs to BPF
Message-ID: <h7yazc4zxmzu3p4pklswaxeviu2skevsdxdqvyc5734p7bwmjx@dvxvlaepvo62>
References: <20251117211413.1394-1-git@danielhodges.dev>
 <241e7845-fa5e-47d1-b4d8-da901c1f0f5e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <241e7845-fa5e-47d1-b4d8-da901c1f0f5e@linux.dev>

On Tue, Nov 18, 2025 at 02:41:58PM +0000, Vadim Fedorenko wrote:
> On 17/11/2025 21:13, Daniel Hodges wrote:
> > This series extends BPF's cryptographic capabilities by adding kfuncs for
> > SHA hashing and ECDSA signature verification. These functions enable BPF
> > programs to perform cryptographic operations for use cases such as content
> > verification, integrity checking, and data authentication.
> > 
> > BPF programs increasingly need to verify data integrity and authenticity in
> > networking, security, and observability contexts. While BPF already supports
> > symmetric encryption/decryption, it lacks support for:
> > 
> > 1. Cryptographic hashing - needed for content verification, fingerprinting,
> >     and preparing message digests for signature operations
> > 2. Asymmetric signature verification - needed to verify signed data without
> >     requiring the signing key in the datapath
> > 
> > These capabilities enable use cases such as:
> > - Verifying signed network packets or application data in XDP/TC programs
> > - Implementing integrity checks in tracing and security monitoring
> > - Building zero-trust security models where BPF programs verify credentials
> > - Content-addressed storage and deduplication in BPF-based filesystems
> > 
> > Implementation:
> > 
> > The implementation follows BPF's existing crypto patterns:
> > 1. Uses bpf_dynptr for safe memory access without page fault risks
> > 2. Leverages the kernel's existing crypto library (lib/crypto/sha256.c and
> >     crypto/ecdsa.c) rather than reimplementing algorithms
> > 3. Provides context-based API for ECDSA to enable key reuse and support
> >     multiple program types (syscall, XDP, TC)
> > 4. Includes comprehensive selftests with NIST test vectors
> > 
> > Patch 1: Add SHA-256, SHA-384, and SHA-512 hash kfuncs
> >    - Adds three kfuncs for computing cryptographic hashes
> >    - Uses kernel's crypto library implementations
> >    - Validates buffer sizes and handles read-only checks
> > 
> > Patch 2: Add selftests for SHA hash kfuncs
> >    - Tests basic functionality with NIST "abc" test vectors
> >    - Validates error handling for invalid parameters
> >    - Ensures correct hash output for all three algorithms
> > 
> > Patch 3: Add ECDSA signature verification kfuncs
> >    - Context-based API: create/acquire/release pattern
> >    - Supports NIST curves (P-256, P-384, P-521)
> >    - Includes both verification and signing operations
> >    - Enables use in non-sleepable contexts via pre-allocated contexts
> > 
> > Patch 4: Add selftests for ECDSA signature verification
> >    - Tests valid signature acceptance
> >    - Tests invalid signature rejection
> >    - Tests sign-then-verify workflow
> >    - Tests size query functions
> >    - Uses RFC 6979 test vectors for P-256
> > 
> > 
> > Example programs demonstrating usage of these kfuncs can be found at:
> > https://github.com/hodgesds/cryptbpf
> > 
> > All tests pass on x86_64:
> > 
> >    # ./test_progs -t crypto_hash
> >    #1/1     crypto_hash/sha256_basic:OK
> >    #1/2     crypto_hash/sha384_basic:OK
> >    #1/3     crypto_hash/sha512_basic:OK
> >    #1/4     crypto_hash/sha256_invalid_params:OK
> >    #1       crypto_hash:OK
> > 
> >    # ./test_progs -t ecdsa_verify
> >    #2/1     ecdsa_verify/verify_valid_signature:OK
> >    #2/2     ecdsa_verify/verify_invalid_signature:OK
> >    #2/3     ecdsa_verify/sign_and_verify:OK
> >    #2/4     ecdsa_verify/size_queries:OK
> >    #2       ecdsa_verify:OK
> > 
> > Configuration Requirements:
> > - SHA kfuncs require CONFIG_CRYPTO_LIB_SHA256=y (default in most configs)
> > - ECDSA kfuncs require CONFIG_CRYPTO_ECDSA=y|m
> > 
> > Future extensions could include:
> > - Additional hash algorithms (SHA3, BLAKE2)
> > - RSA signature verification
> > - Additional NIST curves (P-192, P-521)
> > - Hardware acceleration support where available
> 
> I might be a better idea to implement hashing type and register it, like
> it's done for crypto algorithms. Currently, the only type is encryption/
> decryption type. You can add hash type, extend callbacks to have hash(),
> and let user choose the hash algo? That will make code without any
> duplication just because of new algo...

Yeah, that makes a lot of sense. Let me get that working for v2.

