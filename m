Return-Path: <bpf+bounces-76446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C5CB4833
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 03:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA4533001630
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 02:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954142BD01B;
	Thu, 11 Dec 2025 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kxhnV3gw"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8558920A5C4;
	Thu, 11 Dec 2025 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419188; cv=none; b=Lx/O7BbsIQTNRo9O/0OF1DkgEdD4iqQFgN3Dp0m3g5wvnw31VTEc3cX26I657ax57vPbc7HBRwMvaMi0eO6IN9ofZ7tK7s36ob0mnSinu6LLNDZq7ELGP71tuRN4Iu5mrxoboFM66udo/Avxg2vJ4rSl/JAfcbwVioLdywxL/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419188; c=relaxed/simple;
	bh=A+RZm/3A7B3/te52P+F757ocU9d478kTxLmIgD7Kh1U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XdCLSmK04LpgUg2lEqx0w9HBVsQiUiS+bepRKDy4m4KG7WHBiElz/wLnVaKUPb1hfYIneYnCP7b7r6wRJYVbf7Vq1dvnDOnea2a/TSN9a9jXLGsuW+4Ggd3vPANsRdqaiijMSVp8LDWJV1v5Ky+uGo+ScosxhqcHvLym6lvkR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kxhnV3gw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 704A82116043;
	Wed, 10 Dec 2025 18:13:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 704A82116043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765419185;
	bh=jtSy7SRoWBP+0Yi3UQnD7+KQ3WJVxD10SYdpgFEpFyM=;
	h=From:To:Subject:Date:From;
	b=kxhnV3gwhjtYZg7QJExVo3m+6/WJrTLYbc0We5P5CDpIbEHFc+Rj9ChjRct0QLRFL
	 i1ZCbr2jo8kC+4ZyRl9SS8tkxND/b8GumQUcp1eRoOfJDmn8Q+EgWPigXRIjuBrTh5
	 oRHocod4XrboEyaSv+6Wp8Y3h6wgtyV3lULkx6YI=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC 00/11] Reintroduce Hornet LSM
Date: Wed, 10 Dec 2025 18:11:55 -0800
Message-ID: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces the next iteration of the Hornet LSM.
Hornet’s goal is to provide a secure and extensible in-kernel
signature verification mechanism for eBPF programs.  The purpose of
this RFC is to gather feedback on the LSM design and the newly added
downstream LSM hooks, as well as gauge community sentiment. The
userspace tooling still needs some refinement.  The currently accepted
loader-plus-map signature verification scheme, mandated by Alexei and
KP, is simple to implement and generally acceptable if users and
administrators are satisfied with it. However, verifying both the
loader and the maps offers additional benefits beyond verifying the
loader alone:

1. Security and Audit Integrity

A key advantage is that the LSM hook for authorizing BPF program loads
can operate after signature verification. This ensures:

* Access control decisions are based on verified signature status.
* Accurate system state measurement and logging.
* Log entries claiming a verified signature are truthful, avoiding
  misleading records where only the loader was verified while the actual
  BPF program verification occurs later without logging.

2. TOCTOU Attack Prevention

The current map hash implementation may be vulnerable to a TOCTOU
attack because it allows unfrozen maps to cache a previously
calculated hash. The accepted “trusted loader” scheme cannot detect
this and may permit loading altered maps.

This approach addresses concerns from users who require strict audit
trails and verification guarantees, especially in security-sensitive
environments. Map hashes for extended verification are passed via the
existing PKCS#7 UAPI and verified by the crypto subsystem. Hornet then
calculates the program’s verification state (full, partial, bad, etc.)
and invokes a new downstream LSM hook to delegate policy decisions.

Blaise Boscaccy (4):
  security: Hornet LSM
  hornet: Introduce gen_sig
  hornet: Add a light skeleton data extractor scripts
  selftests/hornet: Add a selftest for the Hornet LSM

James Bottomley (6):
  oid_registry: allow arbitrary size OIDs
  certs: break out pkcs7 check into its own function
  crypto: pkcs7: add flag for validated trust on a signed info block
  crypto: pkcs7: allow pkcs7_digest() to be called from pkcs7_trust
  crypto: pkcs7: add ability to extract signed attributes by OID
  crypto: pkcs7: add tests for pkcs7_get_authattr

Paul Moore (1):
  lsm: framework for BPF integrity verification

 Documentation/admin-guide/LSM/Hornet.rst     |  38 ++
 Documentation/admin-guide/LSM/index.rst      |   1 +
 MAINTAINERS                                  |   9 +
 certs/system_keyring.c                       |  76 ++--
 crypto/asymmetric_keys/Makefile              |   4 +-
 crypto/asymmetric_keys/pkcs7_aa.asn1         |  18 +
 crypto/asymmetric_keys/pkcs7_key_type.c      |  42 +-
 crypto/asymmetric_keys/pkcs7_parser.c        |  87 ++++
 crypto/asymmetric_keys/pkcs7_parser.h        |   4 +
 crypto/asymmetric_keys/pkcs7_trust.c         |   9 +
 crypto/asymmetric_keys/pkcs7_verify.c        |  13 +-
 include/crypto/pkcs7.h                       |   4 +
 include/linux/lsm_hook_defs.h                |   5 +
 include/linux/oid_registry.h                 |   3 +
 include/linux/security.h                     |  25 ++
 include/linux/verification.h                 |   2 +
 include/uapi/linux/lsm.h                     |   1 +
 lib/build_OID_registry                       |  26 +-
 scripts/Makefile                             |   1 +
 scripts/hornet/Makefile                      |   5 +
 scripts/hornet/extract-insn.sh               |  27 ++
 scripts/hornet/extract-map.sh                |  27 ++
 scripts/hornet/extract-skel.sh               |  27 ++
 scripts/hornet/gen_sig.c                     | 392 +++++++++++++++++++
 scripts/hornet/write-sig.sh                  |  27 ++
 security/Kconfig                             |   3 +-
 security/Makefile                            |   1 +
 security/hornet/Kconfig                      |  11 +
 security/hornet/Makefile                     |   7 +
 security/hornet/hornet.asn1                  |  13 +
 security/hornet/hornet_lsm.c                 | 201 ++++++++++
 security/security.c                          |  75 +++-
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/hornet/Makefile      |  63 +++
 tools/testing/selftests/hornet/loader.c      |  21 +
 tools/testing/selftests/hornet/trivial.bpf.c |  33 ++
 36 files changed, 1253 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
 create mode 100644 crypto/asymmetric_keys/pkcs7_aa.asn1
 create mode 100644 scripts/hornet/Makefile
 create mode 100755 scripts/hornet/extract-insn.sh
 create mode 100755 scripts/hornet/extract-map.sh
 create mode 100755 scripts/hornet/extract-skel.sh
 create mode 100644 scripts/hornet/gen_sig.c
 create mode 100755 scripts/hornet/write-sig.sh
 create mode 100644 security/hornet/Kconfig
 create mode 100644 security/hornet/Makefile
 create mode 100644 security/hornet/hornet.asn1
 create mode 100644 security/hornet/hornet_lsm.c
 create mode 100644 tools/testing/selftests/hornet/Makefile
 create mode 100644 tools/testing/selftests/hornet/loader.c
 create mode 100644 tools/testing/selftests/hornet/trivial.bpf.c

-- 
2.52.0


