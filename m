Return-Path: <bpf+bounces-70117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B7BB1546
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 19:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724E11C7438
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185832D29AA;
	Wed,  1 Oct 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHTzAqyx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902CF208961
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338809; cv=none; b=q+RyEMBsuhdJQnEX5FYNxMWZxNV2NNt4xSYIkpRMJyYWv5qR2tMEctQ/iHAPk7+uDNUGp4TYj8xy3IBck9oIkbNTDD5IlY+ke/IiYJE2wrTrVeUb8y/mNmW0G5eA1JLK4oaa9gi+ncQRtkJleLmqsidBjY+vAruEcbxfNTSoSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338809; c=relaxed/simple;
	bh=AetdIK8QOTTGcfORf9tgwsgELbtNeRn39L8VAT+Uj+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVX7yhogCpPTJF3geOJWqGyQNQjJjo6VSf7Q/aEhBSC3R1SXKW7S3KxeiSgxIFT7Y7VRv11A4buu5qqzsugEsO6u89DgtsY2F63QwyVuPrN/2hXuy2FBgYoHbELsY4HysnLOi53kwPwCWFwU7F5ZTm1lS4BIXzsB8UL52eo6DZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHTzAqyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB8BC4CEF1;
	Wed,  1 Oct 2025 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759338809;
	bh=AetdIK8QOTTGcfORf9tgwsgELbtNeRn39L8VAT+Uj+c=;
	h=From:To:Cc:Subject:Date:From;
	b=pHTzAqyxDkW0l+0rJaHkBGNhzBhNjM+uvZfv9atfJfPwjIxrvw5bESALrv12PPUOG
	 s3oBhbTKQEDr9KN7C+SCp6Tnz4iNo+JK4SmV8lPm503KArDVc8qvdoj+AmI1dz/HdX
	 nKajpJoGn/Dskn0jSWdz0x72io2UQ46FM+N8MzbmXDJzrU0qujaKyGAKBfLDGQIwpr
	 7NcVGs3YVrkZ4kzs7cy3evPKBAxKzAqA2ijt4Hw8kQHO1xYaEMW+DTBhHxtQlZGdZ1
	 qnavHWCUknySyhZCy+allSbqVjeyUzzHGct8iMIpE4AKOXvp9w6YuDHY7jo0smvB79
	 cqRvv+RfguyKA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf 0/5] libbpf: fix libbp_sha256() for Github compatibility
Date: Wed,  1 Oct 2025 10:13:21 -0700
Message-ID: <20251001171326.3883055-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent reimplementation of libbpf_sha256() introduced issues for libbpf's
Github mirror due to reliance on linux/unaligned.h header. This patch set
fixes those issues to make libbpf source code compatible with Github mirror
setup.

This patch set starts with a bit of organization: we introduce libbpf_utils.c
as a place for generic internal helpers like libbpf_errstr() and
libbpf_sha256(), and move a few existing helpers there. We also clean up
libbpf_strerror_r(), which seems to be a leftover of some previous
refactorings.

And finally, we move libbpf_sha256() from huge libbpf.c into libbpf_utils.c,
following up with fix ups to make its code more Github-friendly.

v1->v2:
- add missed cpu_to_be32() and be32_to_cpu() conversions inside
  {get/put}_unaligned_be32() macros;
- target bpf tree (Alexei);
- applied Eric's libbpf_sha256 selftest locally and verified it works;

v1:
https://lore.kernel.org/bpf/20250930212619.1645410-1-andrii@kernel.org/

Andrii Nakryiko (5):
  libbpf: make libbpf_errno.c into more generic libbpf_utils.c
  libbpf: remove unused libbpf_strerror_r and STRERR_BUFSIZE
  libbpf: move libbpf_errstr() into libbpf_utils.c
  libbpf: move libbpf_sha256() implementation into libbpf_utils.c
  libbpf: remove linux/unaligned.h dependency for libbpf_sha256()

 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/btf.c             |   1 -
 tools/lib/bpf/btf_dump.c        |   1 -
 tools/lib/bpf/elf.c             |   1 -
 tools/lib/bpf/features.c        |   1 -
 tools/lib/bpf/gen_loader.c      |   3 +-
 tools/lib/bpf/libbpf.c          | 101 -------------
 tools/lib/bpf/libbpf_errno.c    |  75 ----------
 tools/lib/bpf/libbpf_internal.h |  15 ++
 tools/lib/bpf/libbpf_utils.c    | 251 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/linker.c          |   1 -
 tools/lib/bpf/relo_core.c       |   1 -
 tools/lib/bpf/ringbuf.c         |   1 -
 tools/lib/bpf/str_error.c       | 104 -------------
 tools/lib/bpf/str_error.h       |  19 ---
 tools/lib/bpf/usdt.c            |   1 -
 16 files changed, 268 insertions(+), 310 deletions(-)
 delete mode 100644 tools/lib/bpf/libbpf_errno.c
 create mode 100644 tools/lib/bpf/libbpf_utils.c
 delete mode 100644 tools/lib/bpf/str_error.c
 delete mode 100644 tools/lib/bpf/str_error.h

-- 
2.47.3


