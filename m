Return-Path: <bpf+bounces-78664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D80D16C49
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 07:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 996D1301FB60
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 06:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F70366DCD;
	Tue, 13 Jan 2026 06:10:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D59363C41
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284635; cv=none; b=DUVyZqsY35qmYD3+n3LVM2lN4EwfnWEfTHLUweH5l79bjriyFpqz+4Sifx+2VDZbdxIGq15H56lQje5/lq/sq2+GNH0GC/tmddO87pMB4YBsTXjwuEgxB0CLXDdTZdugiHOydXscLjGkQ3c5bgK+yiMQbkl12ynk2l2NPZzmIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284635; c=relaxed/simple;
	bh=5EcSDWbJzM9k4ZzDFAnD1qLix4dcvoR9upKEX/z1mEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHcZsX83cB0hZ/PzenXnAHo+pI9dDwP4I8pnBy9jbhndIkdUeR9HUhHTjsOFxRVfPawASle8cMF+r4mdQU5wMte7+npiUG9r9cSMkiQ/pDNEQT9syQcIaVHn+Z+baHKpuOAEXqKAU3i84vTJYo99az4AsXxiHBVvFE8HDHDlX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5BF7F18C4C5DF; Mon, 12 Jan 2026 22:10:18 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 0/3] Fix a few selftest failure due to 64K page
Date: Mon, 12 Jan 2026 22:10:18 -0800
Message-ID: <20260113061018.3797051-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a few arm64 selftest failures due to 64K page. Please see each
indvidual patch for why the test failed and how the test gets fixed.

Yonghong Song (3):
  selftests/bpf: Fix dmabuf_iter/lots_of_buffers failure with 64K page
  selftests/bpf: Fix sk_bypass_prot_mem failure with 64K page
  selftests/bpf: Fix verifier_arena_globals1 failure with 64K page

 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c       | 2 +-
 .../testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c  | 7 ++++++-
 .../testing/selftests/bpf/progs/verifier_arena_globals1.c  | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

--=20
2.47.3


