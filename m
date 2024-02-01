Return-Path: <bpf+bounces-20970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C5845E61
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A8D1F21655
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45155B031;
	Thu,  1 Feb 2024 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ess1LZ+g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603435B02C
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808069; cv=none; b=bC/k5uovMbSpFPvOGUioMIipyuVaRUL1Hpl70O1z0coOiW519jFKanaLCmZ7zxIlOwUYBNYeKJJcIbgbJG38gs/zPcMJRvMIOYnLIgifT/V1/nZQSvLidHuLSPbZcabX2Ofh4yJJIZO9gNz3cF9jnPb4IOacXJiZo067XNY/WZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808069; c=relaxed/simple;
	bh=sSvQxrZrMytN0XP1/MGhLA57IGdfebzLQiu3seUyd7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h7PlbDgJcrupmscs4O2x+RkXBpGBZHZ5k3rrdlHxFnfQMdDx7Tqz+a9ZRpuE4r3V6qam4u+lVdob5SBK6q2/Pld8QObSwXO5PKNxTbKN2H+q0Bt4BoSHHA90kkfXbtHjpjBR/J9ba1PnYrZjrbZPDlB3c2ywuTskUynRzTH4WLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ess1LZ+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1E2C433F1;
	Thu,  1 Feb 2024 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808069;
	bh=sSvQxrZrMytN0XP1/MGhLA57IGdfebzLQiu3seUyd7M=;
	h=From:To:Cc:Subject:Date:From;
	b=Ess1LZ+ggj3bk2ZNaJudm247Q9IZnLvVYQ4OOgX70n8ote6G4zH1RytO9DVO0OzPC
	 Stpl8xGFBMfTdKg0GHE8/ZzSFdcf74Ye2Ugyt4O23f+XCjtKSPjN5Yozg1gp6pFk6U
	 EWZku1Z3wML5MQr969PmTLcaOFGP7UiY0TyGLzuwLTrSLhCbsqusmKmBm2SiMGF6rS
	 YR2Lao6lf23sINDoF49uoutlDQVhrOCW+aGRZiHrCdne6vaPBFWPbAmj3oAkiy8wkx
	 /iagv09IoYvqKLdHY86VWd98LKz4mzcGk8VBOx3WiPoJH28BMgM9MUwbGFtr7SLugD
	 XTmSgh/zU1fsQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/5] Libbpf API and memfd_create() fixes
Date: Thu,  1 Feb 2024 09:20:22 -0800
Message-Id: <20240201172027.604869-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Few small fixes identified over last few days. Main fix is for memfd_create()
which causes problems on Android platforms. See individual patches for
details.

v1->v2:
  - added extra Fixes tag in patch #2 (Yonghong);
  - improved commit message in patch #5 (Yonghong).

Andrii Nakryiko (5):
  libbpf: call memfd_create() syscall directly
  libbpf: add missing LIBBPF_API annotation to libbpf_set_memlock_rlim
    API
  libbpf: add btf__new_split() API that was declared but not implemented
  libbpf: add missed btf_ext__raw_data() API
  selftests/bpf: fix bench runner SIGSEGV

 tools/lib/bpf/bpf.h                 |  2 +-
 tools/lib/bpf/btf.c                 | 11 ++++++++++-
 tools/lib/bpf/libbpf.c              | 11 ++++++++++-
 tools/lib/bpf/libbpf.map            |  5 +++--
 tools/lib/bpf/linker.c              |  2 +-
 tools/testing/selftests/bpf/bench.c | 12 ++++++++++--
 6 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.34.1


