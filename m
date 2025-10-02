Return-Path: <bpf+bounces-70220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D40BB4B63
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 19:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759C42A5E42
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC27275114;
	Thu,  2 Oct 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWOT/loD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D481236A70;
	Thu,  2 Oct 2025 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426675; cv=none; b=cQ/B5KFKdfi4PzqrIf6xxLMSTD3nOUYlvbqy9J3xAwYJ4V+lmgX0EEVqUwCTmTbGJSly23yC8to5q5KyTkDEZIOgLTwVw0i/oLEGBRHyvvzK+WkMViB54L3Qp3ygd4MEpih70npbUeCK0NpJ9uh9p3o8Asa46j4cXq5llWEZKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426675; c=relaxed/simple;
	bh=o2a6H88/BZxrnf0y+8hUKNtDsH9D/7ZzhhKPMH9mUOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTnc889AEkCQeZnz4E5Tnm2xQzV7up4veiIyodN2R7v4rkmcfWeTk63iDTglT2KHmp3jGVffM2W87YQRD3+01RObSioW+S+BAt0OCQ0XSOcNdvGNLWtg6qcQFKWabJWK6AGd4noO63ohmZBjtJKy5CT6OaXEjimtHo95avLjM14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWOT/loD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57B6C4CEF5;
	Thu,  2 Oct 2025 17:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759426674;
	bh=o2a6H88/BZxrnf0y+8hUKNtDsH9D/7ZzhhKPMH9mUOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWOT/loD+5wO7CMcjca1y0so15p5X9BUQn+Aj9+8+jEjQ7qwfFj34zO5IT13IEa8v
	 Z/GqAzSLVJKCg2sjK2eEmE5a6hQhQv/6TmvxO6kDpLwqSBc6yB+RGLKnZ4YjUJ1X8K
	 SVt2ZGagEqV5unK3g9czT6h5ys3t1vJFTPjHoeakpSbAQ7B3Qe/lLlI89Ifj0i9Af1
	 yaHbad6DuMdyhUdCfoPL/492TjhCAqvuQBPj/YN6U4FjhV3rBvp5cAM4i9/vb2BE3H
	 zJ6gxl5wFQ8WrMNL1Qq636w1S7IPpoejQKuErLbYmMVPtw3tmhWO+8M8FMe8QOhVUJ
	 dxqvzR0G3oLGw==
Date: Thu, 2 Oct 2025 10:36:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	bpf <bpf@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1
 code instead of AF_ALG
Message-ID: <20251002173630.GD1697@sol>
References: <20250929194648.145585-1-ebiggers@kernel.org>
 <CAADnVQKKQEjZjz21e_639XkttoT4NvXYxUb8oTQ4X7hZKYLduQ@mail.gmail.com>
 <20251001233304.GB2760@quark>
 <CAADnVQL=zs-n1s-0emSuDmpfnU7QzMFo+92D3b4tqa3sG+uiQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL=zs-n1s-0emSuDmpfnU7QzMFo+92D3b4tqa3sG+uiQw@mail.gmail.com>

On Thu, Oct 02, 2025 at 10:12:12AM -0700, Alexei Starovoitov wrote:
> On Wed, Oct 1, 2025 at 4:33 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Wed, Oct 01, 2025 at 03:59:31PM -0700, Alexei Starovoitov wrote:
> > > On Mon, Sep 29, 2025 at 12:48 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy.c use
> > > > it to calculate SHA-1 digests instead of the previous AF_ALG-based code.
> > > >
> > > > This eliminates the dependency on AF_ALG, specifically the kernel config
> > > > options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
> > > >
> > > > Over the years AF_ALG has been very problematic, and it is also not
> > > > supported on all kernels.  Escalating to the kernel's privileged
> > > > execution context merely to calculate software algorithms, which can be
> > > > done in userspace instead, is not something that should have ever been
> > > > supported.  Even on kernels that support it, the syscall overhead of
> > > > AF_ALG means that it is often slower than userspace code.
> > >
> > > Help me understand the crusade against AF_ALG.
> > > Do you want to deprecate AF_ALG altogether or when it's used for
> > > sha-s like sha1 and sha256 ?
> >
> > Altogether, when possible.  AF_ALG has been (and continues to be)
> > incredibly problematic, for both security and maintainability.
> 
> Could you provide an example of a security issue with AF_ALG ?
> Not challenging the statement. Mainly curious what is going
> to understand it better and pass the message.

It's a gold mine for attackers looking to exploit the kernel.  Here are
some examples from the CVE list when searching for "AF_ALG":

https://nvd.nist.gov/vuln/detail/CVE-2025-38079

    In the Linux kernel, the following vulnerability has been resolved:
    crypto: algif_hash - fix double free in hash_accept If accept(2) is
    called on socket type algif_hash with MSG_MORE flag set and
    crypto_ahash_import fails, sk2 is freed. However, it is also freed
    in af_alg_release, leading to slab-use-after-free error.

https://nvd.nist.gov/vuln/detail/CVE-2025-37808

    In the Linux kernel, the following vulnerability has been resolved:
    crypto: null - Use spin lock instead of mutex As the null algorithm
    may be freed in softirq context through af_alg, use spin locks
    instead of mutexes to protect the default null algorithm. 

https://nvd.nist.gov/vuln/detail/CVE-2024-26824

    In the Linux kernel, the following vulnerability has been resolved:
    crypto: algif_hash - Remove bogus SGL free on zero-length error path
    When a zero-length message is hashed by algif_hash, and an error is
    triggered, it tries to free an SG list that was never allocated in
    the first place. Fix this by not freeing the SG list on the
    zero-length error path.

https://nvd.nist.gov/vuln/detail/CVE-2022-48781

    In the Linux kernel, the following vulnerability has been resolved:
    crypto: af_alg - get rid of alg_memory_allocated
    alg_memory_allocated does not seem to be really used. alg_proto does
    have a .memory_allocated field, but no corresponding .sysctl_mem.
    This means sk_has_account() returns true, but all
    sk_prot_mem_limits() users will trigger a NULL dereference

https://nvd.nist.gov/vuln/detail/CVE-2019-8912

    n the Linux kernel through 4.20.11, af_alg_release() in
    crypto/af_alg.c neglects to set a NULL value for a certain structure
    member, which leads to a use-after-free in sockfs_setattr.

https://nvd.nist.gov/vuln/detail/CVE-2018-14619

    A flaw was found in the crypto subsystem of the Linux kernel before
    version kernel-4.15-rc4. The "null skcipher" was being dropped when
    each af_alg_ctx was freed instead of when the aead_tfm was freed.
    This can cause the null skcipher to be freed while it is still in
    use leading to a local user being able to crash the system or
    possibly escalate privileges. 

https://nvd.nist.gov/vuln/detail/CVE-2017-18075

    crypto/pcrypt.c in the Linux kernel before 4.14.13 mishandles
    freeing instances, allowing a local user able to access the
    AF_ALG-based AEAD interface (CONFIG_CRYPTO_USER_API_AEAD) and pcrypt
    (CONFIG_CRYPTO_PCRYPT) to cause a denial of service (kfree of an
    incorrect pointer) or possibly have unspecified other impact by
    executing a crafted sequence of system calls. 

https://nvd.nist.gov/vuln/detail/CVE-2017-17806

    The HMAC implementation (crypto/hmac.c) in the Linux kernel before
    4.14.8 does not validate that the underlying cryptographic hash
    algorithm is unkeyed, allowing a local attacker able to use the
    AF_ALG-based hash interface (CONFIG_CRYPTO_USER_API_HASH) and the
    SHA-3 hash algorithm (CONFIG_CRYPTO_SHA3) to cause a kernel stack
    buffer overflow by executing a crafted sequence of system calls that
    encounter a missing SHA-3 initialization.

https://nvd.nist.gov/vuln/detail/CVE-2017-17805

    The Salsa20 encryption algorithm in the Linux kernel before 4.14.8
    does not correctly handle zero-length inputs, allowing a local
    attacker able to use the AF_ALG-based skcipher interface
    (CONFIG_CRYPTO_USER_API_SKCIPHER) to cause a denial of service
    (uninitialized-memory free and kernel crash) or have unspecified
    other impact by executing a crafted sequence of system calls that
    use the blkcipher_walk API. Both the generic implementation
    (crypto/salsa20_generic.c) and x86 implementation
    (arch/x86/crypto/salsa20_glue.c) of Salsa20 were vulnerable. 

https://nvd.nist.gov/vuln/detail/CVE-2016-10147

    crypto/mcryptd.c in the Linux kernel before 4.8.15 allows local
    users to cause a denial of service (NULL pointer dereference and
    system crash) by using an AF_ALG socket with an incompatible
    algorithm, as demonstrated by mcryptd(md5).

https://nvd.nist.gov/vuln/detail/CVE-2015-8970

    crypto/algif_skcipher.c in the Linux kernel before 4.4.2 does not
    verify that a setkey operation has been performed on an AF_ALG
    socket before an accept system call is processed, which allows local
    users to cause a denial of service (NULL pointer dereference and
    system crash) via a crafted application that does not supply a key,
    related to the lrw_crypt function in crypto/lrw.c.

https://nvd.nist.gov/vuln/detail/CVE-2015-3331

    The __driver_rfc4106_decrypt function in
    arch/x86/crypto/aesni-intel_glue.c in the Linux kernel before 3.19.3
    does not properly determine the memory locations used for encrypted
    data, which allows context-dependent attackers to cause a denial of
    service (buffer overflow and system crash) or possibly execute
    arbitrary code by triggering a crypto API call, as demonstrated by
    use of a libkcapi test program with an AF_ALG(aead) socket.

https://nvd.nist.gov/vuln/detail/CVE-2014-9644

    The Crypto API in the Linux kernel before 3.18.5 allows local users
    to load arbitrary kernel modules via a bind system call for an
    AF_ALG socket with a parenthesized module template expression in the
    salg_name field, as demonstrated by the vfat(aes) expression, a
    different vulnerability than CVE-2013-7421.

https://nvd.nist.gov/vuln/detail/CVE-2013-7421

    The Crypto API in the Linux kernel before 3.18.5 allows local users
    to load arbitrary kernel modules via a bind system call for an
    AF_ALG socket with a module name in the salg_name field, a different
    vulnerability than CVE-2014-9644.

https://nvd.nist.gov/vuln/detail/CVE-2011-4081

    crypto/ghash-generic.c in the Linux kernel before 3.1 allows local
    users to cause a denial of service (NULL pointer dereference and
    OOPS) or possibly have unspecified other impact by triggering a
    failed or missing ghash_setkey function call, followed by a (1)
    ghash_update function call or (2) ghash_final function call, as
    demonstrated by a write operation on an AF_ALG socket.

- Eric

