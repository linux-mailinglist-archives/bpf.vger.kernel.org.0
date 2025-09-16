Return-Path: <bpf+bounces-68526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 434DCB59C8D
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CFB1896841
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D43570B4;
	Tue, 16 Sep 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YiOO7uSO"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD21FE44B
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037949; cv=none; b=k/a95gKD42aslEqVY7f7Uo5V7oMdoSCgZU9WfKy9tCrRSC6tU/sMirCSO0fYTHryawmazIdMC68Vod8/k0RFoghGY1WO+I3VHyhVsh3HkSB17yN0Dl9hbJj4Xz12Jju95nuDKbFjm7N6PH7GAULQS8y2JHMg23hiXpCkIKlWfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037949; c=relaxed/simple;
	bh=aM/DH//YQFaeNNDBLGAMYqTAgdJMThO51KwmyXtDxmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0D5S2MmfNxzPGNXi3UhgOV72by4R1qrQbzPGS6E7a6s77amm4IBv+vry/ymEJLiUJB3gGbSqXBBhMSstE2E8SYVSQqaGMQm1RoHEnpZptIyzsS+ReLkwLI6n4NQloJToT0L6t6lmR7iuB9dA2O2btovGnE9EbCUr+zSDuOqZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YiOO7uSO; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758037945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3BCfSb7FMofITDT10phLCv9ZCQ2IaRDKYTeP6xtp9sk=;
	b=YiOO7uSOjhfBj4SeLQFmPcSiPrCBsFLIVSuHIzKaM/BHeMoMxtRrwTUUOyyV4Ox/QARKZd
	yow08v0pZJuM3L/CQXPEwAIuq2+wV3x/kg4hE1zgCTpDh7BN4FQzW7cCyPCn+iNXvMn21c
	H0AYaRLPanmFPqn65w/tlHRdxD5G6fA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	yatsenko@meta.com,
	puranjay@kernel.org,
	davidzalman.101@gmail.com,
	cheick.traore@foss.st.com,
	chen.dylane@linux.dev,
	mika.westerberg@linux.intel.com,
	ameryhung@gmail.com,
	menglong8.dong@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 0/3] bpf: Allow union argument in trampoline based programs
Date: Tue, 16 Sep 2025 23:52:08 +0800
Message-ID: <20250916155211.61083-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

While tracing 'release_pages' with bpfsnoop[0], the verifier reports:

The function release_pages arg0 type UNION is unsupported.

However, it should be acceptable to trace functions that have 'union'
arguments.

This patch set enables such support in the verifier by allowing 'union'
as a valid argument type.

Changes:
v1 -> v2:
* Add 16B 'union' argument support in x86_64 trampoline.
* Update selftests using bpf_testmod.
* Add test case about 16-bytes 'union' argument.
* Address comments from Alexei:
  * Study the patch set about 'struct' argument support.
  * Update selftests to cover more cases.
v1: https://lore.kernel.org/bpf/20250905133226.84675-1-leon.hwang@linux.dev/

Links:
[0] https://github.com/bpfsnoop/bpfsnoop

Leon Hwang (3):
  bpf: Allow union argument in trampoline based programs
  bpf, x64: Add union argument support in trampoline
  selftests/bpf: Add union argument tests using fexit programs

 arch/x86/net/bpf_jit_comp.c                   |  2 +-
 include/linux/bpf.h                           |  3 ++
 include/linux/btf.h                           |  5 +++
 kernel/bpf/btf.c                              |  8 +++--
 .../selftests/bpf/prog_tests/tracing_struct.c | 29 ++++++++++++++++
 .../selftests/bpf/progs/tracing_struct.c      | 33 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 31 +++++++++++++++++
 7 files changed, 107 insertions(+), 4 deletions(-)

--
2.50.1


