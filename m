Return-Path: <bpf+bounces-74799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F769C663E9
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 22:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4D774E5ED5
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 21:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BE231283F;
	Mon, 17 Nov 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="G+hUb3jA";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="yOB21SAE"
X-Original-To: bpf@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024E523A
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414200; cv=none; b=GBdwl8P64ROijlKZnZJ8eMcAr+ix6pTkWyHzCddGVMBG4DUU4TNS+Ss8+46Vg0kpXmwv5mExeqN0x2/GSdv8nDlq0Hdng91nxXkCRXxrqxl1+A5v65iL4zH8T/evt+vVso6F28HsjFTIaeCGjIPIlBpEAuXUJ4n7I1puDTz85LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414200; c=relaxed/simple;
	bh=JKu6akZuge7fBxUL0RAqJFqJKnvuDIikNNVCbIkug90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LrjUuuS2kc8iHnxd5Ht/+vL7CVcfQDKRZgtxvXZYpxfs59IbIqIHaGctZI8Hm9UR9UgqapZ9UQS9jPItOWxgfbFva+66xwic7eKvD2g/ajBl+o/BwYqecuoz+FGJTnP5L5O4ANLE6Mw+m/Ri7OD1tHJhNgYfUW8baOkyyMd6SnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=G+hUb3jA; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=yOB21SAE; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1763414069; bh=NtAYZiUrmqR32puiyu4vGUX
	Ao0t2hIqopftPC6yNNqk=; b=G+hUb3jA5DrkwOGGZXqaBrVTZVmo2Chrifa6a6WBmoSHr0SfcS
	C+puQEP3HEYJZQAC3enHpBssAq2oeeG0+3uNXaTOSgl/TVQaTHEDz3TvXGjV59llo+iagTqXSKS
	A3Jc+D3zpsXKN3ou2xP+ExzaJzj4C1DnxFvzkQomZERujmAF0sxJph5LdWgf3mT3D+bdy7RYTbC
	UhyJ0lNpsC5vp+hhc5jwhrZxQ8Jbey2MpcDEXrMiD9vdJcLZaecRwKZXD2kunBxS2eC2AjZN7Uw
	LPPK4V+G5V7tMWcgrOLrACRBQcPHef3hE4K0ZFugHI2v8RjFCTEMJdOvwtzaaxO0e9Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1763414069; bh=NtAYZiUrmqR32puiyu4vGUX
	Ao0t2hIqopftPC6yNNqk=; b=yOB21SAEYx337mbgFafIN03DEhzBQ9HOmi57xaiTsouuWD11jR
	8Zo6Md22drna4Ru9ke/xcxZY3FQeHsKJuzCw==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Cc: Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next 0/4] Add cryptographic hash and signature verification kfuncs to BPF
Date: Mon, 17 Nov 2025 16:13:57 -0500
Message-ID: <20251117211413.1394-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends BPF's cryptographic capabilities by adding kfuncs for
SHA hashing and ECDSA signature verification. These functions enable BPF
programs to perform cryptographic operations for use cases such as content
verification, integrity checking, and data authentication.

BPF programs increasingly need to verify data integrity and authenticity in
networking, security, and observability contexts. While BPF already supports
symmetric encryption/decryption, it lacks support for:

1. Cryptographic hashing - needed for content verification, fingerprinting,
   and preparing message digests for signature operations
2. Asymmetric signature verification - needed to verify signed data without
   requiring the signing key in the datapath

These capabilities enable use cases such as:
- Verifying signed network packets or application data in XDP/TC programs
- Implementing integrity checks in tracing and security monitoring
- Building zero-trust security models where BPF programs verify credentials
- Content-addressed storage and deduplication in BPF-based filesystems

Implementation:

The implementation follows BPF's existing crypto patterns:
1. Uses bpf_dynptr for safe memory access without page fault risks
2. Leverages the kernel's existing crypto library (lib/crypto/sha256.c and
   crypto/ecdsa.c) rather than reimplementing algorithms
3. Provides context-based API for ECDSA to enable key reuse and support
   multiple program types (syscall, XDP, TC)
4. Includes comprehensive selftests with NIST test vectors

Patch 1: Add SHA-256, SHA-384, and SHA-512 hash kfuncs
  - Adds three kfuncs for computing cryptographic hashes
  - Uses kernel's crypto library implementations
  - Validates buffer sizes and handles read-only checks

Patch 2: Add selftests for SHA hash kfuncs
  - Tests basic functionality with NIST "abc" test vectors
  - Validates error handling for invalid parameters
  - Ensures correct hash output for all three algorithms

Patch 3: Add ECDSA signature verification kfuncs
  - Context-based API: create/acquire/release pattern
  - Supports NIST curves (P-256, P-384, P-521)
  - Includes both verification and signing operations
  - Enables use in non-sleepable contexts via pre-allocated contexts

Patch 4: Add selftests for ECDSA signature verification
  - Tests valid signature acceptance
  - Tests invalid signature rejection
  - Tests sign-then-verify workflow
  - Tests size query functions
  - Uses RFC 6979 test vectors for P-256


Example programs demonstrating usage of these kfuncs can be found at:
https://github.com/hodgesds/cryptbpf

All tests pass on x86_64:

  # ./test_progs -t crypto_hash
  #1/1     crypto_hash/sha256_basic:OK
  #1/2     crypto_hash/sha384_basic:OK
  #1/3     crypto_hash/sha512_basic:OK
  #1/4     crypto_hash/sha256_invalid_params:OK
  #1       crypto_hash:OK

  # ./test_progs -t ecdsa_verify
  #2/1     ecdsa_verify/verify_valid_signature:OK
  #2/2     ecdsa_verify/verify_invalid_signature:OK
  #2/3     ecdsa_verify/sign_and_verify:OK
  #2/4     ecdsa_verify/size_queries:OK
  #2       ecdsa_verify:OK

Configuration Requirements:
- SHA kfuncs require CONFIG_CRYPTO_LIB_SHA256=y (default in most configs)
- ECDSA kfuncs require CONFIG_CRYPTO_ECDSA=y|m

Future extensions could include:
- Additional hash algorithms (SHA3, BLAKE2)
- RSA signature verification
- Additional NIST curves (P-192, P-521)
- Hardware acceleration support where available

Daniel Hodges (4):
  bpf: Add SHA hash kfuncs for cryptographic hashing
  selftests/bpf: Add tests for SHA hash kfuncs
  bpf: Add ECDSA signature verification kfuncs
  selftests/bpf: Add tests for ECDSA signature verification kfuncs

 kernel/bpf/crypto.c                           | 483 +++++++++++++++++-
 .../selftests/bpf/prog_tests/crypto_hash.c    | 129 +++++
 .../selftests/bpf/prog_tests/ecdsa_verify.c   |  96 ++++
 .../testing/selftests/bpf/progs/crypto_hash.c |  83 +++
 .../selftests/bpf/progs/ecdsa_verify.c        | 228 +++++++++
 5 files changed, 1018 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ecdsa_verify.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/ecdsa_verify.c

--
2.51.0

