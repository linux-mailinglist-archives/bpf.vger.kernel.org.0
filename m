Return-Path: <bpf+bounces-35253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B0A939396
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C497280C6D
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2BA16D9B2;
	Mon, 22 Jul 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I6OtOWCF"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DEA2907
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673076; cv=none; b=sRDH2MI3r1nb4rNMLGltTm542IkIMhtm+dDp5FI3nlqreqdaEJ/A5eHyGJkMqY4LankMeY+6uWsqEvFT62q9jcoFh5ZpeG/WgFwtvTFO+Tx4I0jgPwQNLV/+kvxTfBKZNEgLmltZKgqIcO7mgbIfBQ39zJinuMRioA1nsPKVuL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673076; c=relaxed/simple;
	bh=NNvPkctq0cVLpxsCuAEhzH6GpAPBrFLOAXUxwB1TUp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DotrVi+2/XPBCNWh+6MEUbQJVquOYZiIPoQnDBDin/mtrqZWQpo+1wT3oOmJw/8HcusNrpiX+1sOwSxTxHxNraFzOcxLCyw29hUJi9aZfSD/YqLbMYUYULL7TRRLApADJDIkSHYftEBi7AuCHE5qgC7CMr1NqoQJpN7Z8wmTYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I6OtOWCF; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721673073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qc6nAFxHr5f4SwNK08uANt9etncwk8ztWX7u0A8q91A=;
	b=I6OtOWCFJ2sOAmU4W1zwZ2k0MbzZ7NriDykoJDhxilLUqYcMtH2/PHo6d8DuJwm7Zhl48i
	j1vWIxB/SINhLjhpoMrjANchrSBahgdTC22xyeBWu3D3q68kqFU/aUgMTtQIadyw5+e/KJ
	jvF6Mycwo2Uq38OKd+koI2Q8cgGhqdo=
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@meta.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/3] bpf: Retire the unsupported_ops usage in struct_ops
Date: Mon, 22 Jul 2024 11:30:44 -0700
Message-ID: <20240722183049.2254692-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This series retires the unsupported_ops usage and depends on the
null-ness check on the cfi_stubs instead.

Please see individual patches for details.

v2:
- Fixed a gcc compiler warning on Patch 1.

Martin KaFai Lau (3):
  bpf: Check unsupported ops from the bpf_struct_ops's cfi_stubs
  selftests/bpf: Fix the missing tramp_1 to tramp_40 ops in cfi_stubs
  selftests/bpf: Ensure the unsupported struct_ops prog cannot be loaded

 include/linux/bpf.h                           |  5 ++++
 kernel/bpf/bpf_struct_ops.c                   |  7 +++++
 kernel/bpf/verifier.c                         | 10 ++++++-
 net/ipv4/bpf_tcp_ca.c                         | 26 -------------------
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 14 ++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  1 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  2 ++
 .../selftests/bpf/progs/unsupported_ops.c     | 22 ++++++++++++++++
 8 files changed, 60 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/unsupported_ops.c

-- 
2.43.0


