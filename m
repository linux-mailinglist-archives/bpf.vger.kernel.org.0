Return-Path: <bpf+bounces-79683-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJLUMnDQb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79683-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:58:56 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFE449EA0
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2940FA8ADBD
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208E47799E;
	Tue, 20 Jan 2026 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="dkE4KXEG";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="Pjyzp+YC"
X-Original-To: bpf@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52328472795;
	Tue, 20 Jan 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934892; cv=none; b=HOfoBodB1rL+JObM+KX2EXe9wUWcMYXLVHEpFsptdQCEYAM5Q4Ql1WyChbHUDqrxKO3zXAwWt6R+oTNevJoJACzZMEdI2ADYeUct0muyomJ/LKtnzmnobdFCsLUqYjqGBYwtZ0RwCSmfUdDjL/Igeg1VycUBVMdEK3yZpV02b2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934892; c=relaxed/simple;
	bh=aPfUT2IBk4L0FNgR3TLob4IKtM/Pswie+93u9HHgK1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZCdz7oT3vpCb51k8L97ugOyGpylG51LFxkPPKHjDXjr3YDGyidVYPv9vst36UV6+PdlFPcgbkf81lOj2HfTY4rfIW2qG8PUTFhOjYXuqCinh6nda/FSUyVOhWqVbMU+MpUIc4svHA4oTj0ECddb6JF/sWtTWUKuOloYO9dzu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=dkE4KXEG; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=Pjyzp+YC; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768934821; bh=/3+H7ZrSXrEdksyTiq7nd6Z
	BJcOF97RS0v3A01tmu5w=; b=dkE4KXEGPpKchR00C2TKlEVjiQb9KMpfwxU23ejoHlh7iNRaZY
	sGkjcmoXZP2IeuZ/O8ORmMftWVsEs9BYi6v8OeMfe/f1lpIPqLh7L+ocdGTGF1VSSmTRdyu/R+o
	BRfOgiH/mllbEW2xclnosYsnS8KgTYhgfR9CxHs6HKzJAuBBkkYUFyOb1dd1ka9J6dzak6u2Wwf
	oJyZUJhdoX5FMDLv9BYC1CZ2ThzfBaljw4Yb4n9V0KJgL1BuKZXUakrcG/gugOExy/rWkKHN3qE
	DOQC8ssnud7anGgQQ4IeFzQZq4QyvGBMX9luxDwU5AevZOcoqcHgmFOzhFDnQRdrbRQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768934821; bh=/3+H7ZrSXrEdksyTiq7nd6Z
	BJcOF97RS0v3A01tmu5w=; b=Pjyzp+YCfjPu+sLFxDd0jp8b15PJc8vKdduvJ9wq/uNrTvYGgU
	o5FbnO0BapW2pLs946YXzXGvikvjJYi6XOBQ==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Song Liu <song@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v5 0/7] Add cryptographic hash and signature verification kfuncs to BPF
Date: Tue, 20 Jan 2026 13:46:54 -0500
Message-ID: <20260120184701.23082-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,meta.com,gmail.com,google.com,fomichev.me,gondor.apana.org.au,davemloft.net,vger.kernel.org,danielhodges.dev];
	TAGGED_FROM(0.00)[bounces-79683-lists,bpf=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,bpf@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[danielhodges.dev,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[bpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6EFE449EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series enhances BPF's cryptographic functionality by introducing
kernel functions for SHA hashing and ECDSA signature verification. The changes
enable BPF programs to verify data integrity and authenticity across
networking, security, and observability use cases.

The series addresses two gaps in BPF's cryptographic toolkit:

1. Cryptographic hashing - supports content verification and message digest
   preparation
2. Asymmetric signature verification - allows validation of signed data
   without requiring private keys in the datapath

Use cases include:
- Verifying signed network packets or application data in XDP/TC programs
- Integrity checks within tracing and security monitoring
- Zero-trust security models with BPF-based credential verification
- Content-addressed storage in BPF-based filesystems

The implementation leverages existing BPF patterns: it uses bpf_dynptr for
memory safety, reuses kernel crypto libraries (lib/crypto/sha256.c and
crypto/ecdsa.c) rather than reimplementing algorithms, and provides
context-based APIs supporting multiple program types.

v1: https://lore.kernel.org/bpf/20251117211413.1394-1-git@danielhodges.dev/

v2: https://lore.kernel.org/bpf/20251205173923.31740-1-git@danielhodges.dev/
- Fixed redundant __bpf_dynptr_is_rdonly() checks (Vadim)
- Added BPF hash algorithm type registration module in crypto/ subsystem
- Added CONFIG_CRYPTO_HASH2 guards around bpf_crypto_hash() kfunc and its
  BTF registration, matching the pattern used for CONFIG_CRYPTO_ECDSA
- Added mandatory digestsize validation for hash operations

v3: https://lore.kernel.org/bpf/20251208030117.18892-1-git@danielhodges.dev/
- Fixed patch ordering - header changes now in separate first commit before
  crypto module to ensure bisectability (bot+bpf-ci)
- Fixed type mismatch - changed u32 to u64 for dynptr sizes in
  bpf_crypto_hash() to match __bpf_dynptr_size() return type (Mykyta)
- Added CONFIG_CRYPTO_ECDSA to selftest config (Song)
- Refactored test code duplication with setup_skel() helper (Song)
- Added copyright notices to all new files

v4: https://lore.kernel.org/bpf/20260105173755.22515-1-git@danielhodges.dev/
- Reused common bpf_crypto_ctx structure for hash and signature operations
  instead of separate context types (Song)
- Fixed integer truncation in bpf_crypto_hash when data_len > UINT_MAX
- Corrected KF_RCU flags for ECDSA kfuncs (only bpf_ecdsa_verify needs KF_RCU)
- Updated MAINTAINERS file in test patches
- Refactored selftests to use crypto_common.h for kfunc declarations

v5:
- Fixed bisectability: moved bpf_crypto_type_id enum and type_id field
  introduction to the hash module commit, before it's used by hash kfunc
- Renamed kfuncs from bpf_ecdsa_* to bpf_sig_* since signature verification
  is not ECDSA-specific (Vadim)
- Added NULL checks in bpf_crypto_sig wrapper functions for optional
  digest_size and max_size callbacks to prevent NULL pointer dereference
- Added extra validation in bpf_sig_digestsize/bpf_sig_maxsize kfuncs to
  return -EOPNOTSUPP when underlying algorithm returns 0
- Renamed test files from ecdsa_verify to sig_verify for consistency

Daniel Hodges (7):
  bpf: Extend bpf_crypto_type with hash operations
  crypto: Add BPF hash algorithm type registration module
  crypto: Add BPF signature algorithm type registration module
  bpf: Add hash kfunc for cryptographic hashing
  selftests/bpf: Add tests for bpf_crypto_hash kfunc
  bpf: Add signature verification kfuncs
  selftests/bpf: Add tests for signature verification kfuncs

 MAINTAINERS                                   |   6 +
 crypto/Makefile                               |   6 +
 crypto/bpf_crypto_shash.c                     |  96 ++++++
 crypto/bpf_crypto_sig.c                       |  89 ++++++
 crypto/bpf_crypto_skcipher.c                  |   1 +
 include/linux/bpf_crypto.h                    |  13 +
 kernel/bpf/crypto.c                           | 204 ++++++++++++-
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/crypto_hash.c    | 210 +++++++++++++
 .../selftests/bpf/prog_tests/sig_verify.c     | 163 ++++++++++
 .../selftests/bpf/progs/crypto_common.h       |   8 +
 .../testing/selftests/bpf/progs/crypto_hash.c | 235 ++++++++++++++
 .../testing/selftests/bpf/progs/sig_verify.c  | 286 ++++++++++++++++++
 13 files changed, 1310 insertions(+), 9 deletions(-)
 create mode 100644 crypto/bpf_crypto_shash.c
 create mode 100644 crypto/bpf_crypto_sig.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sig_verify.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/sig_verify.c

-- 
2.52.0


