Return-Path: <bpf+bounces-35148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54747937F27
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 08:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07151F21A27
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 06:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857217BDA;
	Sat, 20 Jul 2024 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hrTRRrjw"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96063125CC
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721456583; cv=none; b=XkCk4/0tDgEEX5/t8j51cOMr43NHd9/FAxdrKT6fz10Tf1t/9hJr7ZHH9HIEXmL2IdGaVSgccZTkRBFoVyIvEA+vrcveUpUf5J23cbhS2rm5e7JOXyrAvh7u9zmddT9LvdmQyL9sup8X+08X+CmvSI8jOUUqAEJVS8ATJYvjLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721456583; c=relaxed/simple;
	bh=n3S3RZP5ZQMvv9soDCO/BOHv1bgLoTNHcqagc3OOxmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvO6EFv1imjhXpqwyaGiw+GPsebD3GfI7KOdWT/vR5Uf4+OGu4ywGJD370qvPx2ddKdYcPpyHPyLYknfQC81lnpsSapH0AbDCWWy9hl1Snci+hFV7Xy3vDB1UpBiW9BK66S2MQm09dNxCcyiInvFw9avKMC2X3SNX24tS1uA/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hrTRRrjw; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721456579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TN7eTswhPObCDyAW9YJlLKUdgNElZXll7eQ0i/WNWzI=;
	b=hrTRRrjwzrSpOwHaICXXTLLHrz9KxD9SkDm7zjxKpe4tBWpXwDh4D1mZ5bjxm2z5KYUvjU
	ZWXc2VYjLNBjKJwzmryqboQvJKcotaAc/Xw15K6km9ugEOnlSI64QHlJ1XHxl8hoPgOcFG
	nmTQMuBT95jeFZSXXhiQGb89BEELn8c=
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
Subject: [PATCH bpf-next 0/3] bpf: Retire the unsupported_ops usage in struct_ops
Date: Fri, 19 Jul 2024 23:22:28 -0700
Message-ID: <20240720062233.2319723-1-martin.lau@linux.dev>
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


