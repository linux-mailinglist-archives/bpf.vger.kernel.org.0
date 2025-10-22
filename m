Return-Path: <bpf+bounces-71826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F88BFD5A8
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 18:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7426218C7408
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC0272E6E;
	Wed, 22 Oct 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DglCSK7/"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843FA35B155
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151576; cv=none; b=G00B7Q+wiMirD2cdXc2CLh+lDGWlU3qbYd2IzETloto7MUBtR4JJEiiuokYDRP9AQqNAORIWCdLQRuIh/OsYNIGRCe6DKqvhtnWdLWEI0iJuKsJw6Mjtp9wcSp8YqyOYpbEwTCFk95thxdWFYpXw0P58/bZLWvnMQauIrGcG10o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151576; c=relaxed/simple;
	bh=kHipxjPKdfKyZjusmW/Xen/+cggiUczv4HaoaLIzec4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3/J9pWpxH8hfRtghH1kSW9NuU/igC3uZ5n4T1xGqcl8hRZFdzkB38sv58rjBSyxisvhlr/nLF3fU4qsOX+G+Y0IKezGEokIdjSJ4FPzJA1t16YlfbieJh3xrt7Yao7VqDg5ZewTKrPkeIvN3YAOC3C57/OoQeixZL9HiqccTSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DglCSK7/; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761151571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YR3WnEjvrHHzguVdZ+7J/zHY0xABiTWzZ7eMT7M8+Do=;
	b=DglCSK7/VAhxn7bUjD72797plehx2OIH1weyvIRcgUYCfvrG/Xa2C5H1ADDd+geZrS3grI
	sAxp1WAOBdxuaxSPhxH5JlVTsuopnm/x0zh2fwb4Q9d3uzgOm2YeoJ0iI3r2YfCPXvOyXE
	Fg8WURLOUskyp2geh7U9T36eIACet50=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	m.shachnai@gmail.com,
	luis.gerhorst@fau.de,
	colin.i.king@gmail.com,
	harishankar.vishwanathan@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH bpf-next 0/2] bpf: Skip bounds adjustment for conditional jumps on same register
Date: Thu, 23 Oct 2025 00:44:55 +0800
Message-ID: <20251022164457.1203756-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid verifier bug warning when conditional
 jumps on same register when the register holds a scalar with range.

---
KaFai Wan (2):
  bpf: Skip bounds adjustment for conditional jumps on same register
  selftests/bpf: Add test for conditional jumps on same register

 kernel/bpf/verifier.c                           |  4 ++++
 .../selftests/bpf/progs/verifier_bounds.c       | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.43.0


