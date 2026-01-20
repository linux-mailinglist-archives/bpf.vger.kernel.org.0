Return-Path: <bpf+bounces-79558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF0D3C035
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FFF03A3FF3
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791BF3B7A8;
	Tue, 20 Jan 2026 07:04:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F722E62B4
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892671; cv=none; b=NkUEDvSHPKh1WIST0BCr5XOtFCdiOcu16gpZ1lYo6mAwp2CaU4oppurSrXCSWAiCtVgKO03C6l6BOXNhPYGS8xktd6XHLgt/AXEq1/9taN5boC4aKciX1uYWibeAs4+hR/pUgGNnazc6i8uUOHFaknC4WzIWwGoI6JDckfoKS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892671; c=relaxed/simple;
	bh=kSgZ9nDF/jLEUDCwlX6Z+6MHmOPmi1voAUQJpLbzaJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eguXs9UZOrXav3NP03sM9W0gg5lgI4hYHGIe+5kUWe3XYhjAVAD6dfYFm08p2+fRxYn5P2mfvgqzrx1ZVV2HDdqK/dNPDruT9V63sNCu74VJNaKP6/vMscoQEHDufCrzhQfXq55JveqFWU4C8382xHTEIT32NrQzb9IIbtQ6N40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: jPfl2u84RZ2e7Gs8G/dX5A==
X-CSE-MsgGUID: eu6pVxl1Qc+zvjIogwAWbw==
X-IPAS-Result: =?us-ascii?q?A2EtBQDJJ29p/zcImYJaglkCm3yeHYF/BgkBAQEBAQEBA?=
 =?us-ascii?q?QFaBAEBhQeMfCc1CA4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEBBQEBAQEBA?=
 =?us-ascii?q?QYDAQECAoEdhglTSQEQAYZAAUaEUoJ0sSyBAd16LVSBMhWBOI1ScYU6gg2Ef?=
 =?us-ascii?q?YQadoV3BIINFXoUlA5IgR4DWSwBE0ITDQoLBwVqYQIZAzUSKhVuCBEZHYEZC?=
 =?us-ascii?q?j4XgQobBwWBIgaCFYZpD4kygV8DCxgNSBEsNxQbQm4HkX8HAWIsKlAOgSCPE?=
 =?us-ascii?q?weHd48PoRGEJoRRH5xoTaprLphYpFmGUQGCFE04gyNRGQ/aRIElAgcLAQEDC?=
 =?us-ascii?q?YZ+imyBfwEB?=
IronPort-Data: A9a23:/dA0lqqrprqzq6o0FhqBteW1s/JeBmK+ZBIvgKrLsJaIsI4StFCzt
 garIBnVaf2DZ2ahKIpzPNmy8UtQsZKAydU1TFc6+CpkRH4SoJacVYWSI27OZB+ff5bJJK5FA
 2TySTViwOQcFCK0SsKFa+C5xZVE/fjWAOK6U6icZnwZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsfvrRC9H5qyo5mtB5ARmPJingXeH/5UrJMNHTU2OByagKmVkNrbSb
 /rOyri/4lTY838FYvu5kqz2e1E9WbXbOw6DkBJ+A8BOVTAb+0Teeo5iXBYtQR8/Zwehxrid+
 /0U3XCEcjrFC4WX8Agrv7m0JAklVUFO0OevzXFSKqV/xWWeG5fn66wG4E3boeT0Uwu4aI1D3
 aVwFdwDUvyMr+COzrbhV7kwvPZ5IZbEJ9Mw/X1QkBiMWJ7KQbibK0nLzdpImTs9gsFQEOzPI
 dcUYnxmZ1LCe3WjOH9OU8p4xbrzwCm5LmAwRFG9/MLb50DS1wxwwbHoOfLVYtfMRN4Tg0uT4
 GvNuWbhav0fHIXHl2vdqSzz3ocjmwv2RdwKKq28r8dhw0+NxE0UBwI/alGk9KzRZkmWAYsFd
 BNNq0LCt5Ma9VerT8j0WhSQoGaP+B8HHcddGKsz40eP0sLpDx2xA3hBQjNFacIrrt5sAyEn3
 RmAlJXrHVSDrYF5V1qfzrmQ9y7iZRInd2JdSjRUYkwJ04TK9dRbYg30cjp1LEKipv/NcQwcL
 hiPvG0yirESk8MRxv/94F3MxTun4JrRJuLU2uk1dj/6hu+aTNf6D2BN1bQ8xawYRLt1tnHb4
 BA5dzG2tYjjzfilzURhutnh441FF97faWeD3gc+d3XQ3yit9ja+e4FO7StlJVt4esEKMTLtb
 UTPowQU75hWOWasbKR+f4O2Dd9C8JUN1L3NCJjpUza5SsEtL1XdrX4/Ox/4MqKEuBFErJzT8
 KyzKa6EZUv2w4w+pNZqb4/xCYMW+x0=
IronPort-HdrOrdr: A9a23:+5BsoauTX7sPk4T6WzmhbA5h7skDUNV00zEX/kB9WHVpm6uj5q
 STdZUgpHrJYVMqM03I9uruBEDtexnhHP1OkOss1MmZPDUO0VHARL2KhrGP/9SPIUDD398Y+L
 t6c6B4TP38ZGIK7vrS0U2UD80hyN7C1KipgMjEyXMFd29XQpAlwhtjCg6dVnZ9XRR6A/MCda
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3Ap79xhmjX4Z00d1c8zoT84F4BwjJucEXTyC3NcxO?=
 =?us-ascii?q?COzxkF5KOGXDX9JM5up87?=
X-Talos-MUID: 9a23:HKdkngnaduruMSDkfr+LdnpvKZlw3bSqUXkG0ocYueiDOjNZBD2C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="106903671"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery2.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.55])
  by esa1.cc.uec.ac.jp with ESMTP; 20 Jan 2026 16:04:24 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 0C6211839FB9;
	Tue, 20 Jan 2026 16:04:24 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v3 0/2] bpf: Add kfunc bpf_strncasecmp()
Date: Tue, 20 Jan 2026 16:03:34 +0900
Message-ID: <20260120070336.188850-1-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces bpf_strncasecmp to allow case-insensitive and
limited-length string comparison. This is useful for parsing protocol
headers like HTTP.

---

Changes in v3:
- Use ternary operator to maintain style consistency
- Reverted unnecessary doc comment about XATTR_SIZE_MAX

Changes in v2:
- Compute max_sz upfront and remove len check from the loop body
- Document that @len is limited by XATTR_SIZE_MAX

Yuzuki Ishiyama (2):
  bpf: add bpf_strncasecmp kfunc
  selftests/bpf: Test kfunc bpf_strncasecmp

 kernel/bpf/helpers.c                          | 34 +++++++++++++++----
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  1 +
 .../bpf/progs/string_kfuncs_failure1.c        |  6 ++++
 .../bpf/progs/string_kfuncs_failure2.c        |  1 +
 .../bpf/progs/string_kfuncs_success.c         |  7 ++++
 5 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.52.0


