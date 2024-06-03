Return-Path: <bpf+bounces-31274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739058FA650
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 01:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80E81C20BF8
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E15483CB2;
	Mon,  3 Jun 2024 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOiuVEhX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6DD80056
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456645; cv=none; b=DTjFfp5lf8nbpqLV0ptN3qIPjjxEAZ0v6UEinE2qHBSio+dRd8+VMH9kElqOTtxTaoPYSN0/IosD+nGegZYXPqcTsmPEqsiv1nUdwkrvkCeZERh0v8olBUNr6MhoSjXg19UpmZ6Dwwid3WUAeUKzxFJZDI3lAB+sZm1qFeGxXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456645; c=relaxed/simple;
	bh=tm8btat2IO2qDf9lqgZRC8PfcjSHAXfa1BpZaSX+UJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWwIwQp/g6F/Wd4pgMAC/2E3rAbSIvwV47Wxm0/kHVO7BuFeaLyMTe+JQ9PhNyc8SZ2CQ82IniRALGv6hk6Mw0RfIf3C6Def1iX9NOSxMl1Q2TOWifDSMuSB36LzwlcUDOgtaT+1+yOthv1pcuMmXEfDfpCicA2gG13o/UVG8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOiuVEhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D45C2BD10;
	Mon,  3 Jun 2024 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456645;
	bh=tm8btat2IO2qDf9lqgZRC8PfcjSHAXfa1BpZaSX+UJE=;
	h=From:To:Cc:Subject:Date:From;
	b=vOiuVEhXFnz111L0dqopioGeDG7xjW76imBTpI+9RPEE8lRPq0dPUSmuYnYCqid08
	 upitjYATd60uV4/oiJLNfEVEOcvLfsDFxjjRbtfJDMHrtIJ3HkaJqohCSWsaTulMzR
	 PGwJUSfoqP3LLW4qrjZEUZELpCXTYwBbsOTw6h7Z4L7tUqVCx/H6+RNtJZzjP88WVk
	 5GNNDzsURj+b0NPKZUH6NwiotUUopebaay5tZW1taTp0PfB36tFrGjbGXqfzqb8p24
	 TqGXvybtj3K3/JMjTNHaKgtTTMckOdEudAFghTa797p98X4W4rSyaWfzE7YBtPlffv
	 E7raMaOnOWLPQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: alan.maguire@oracle.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 0/5] libbpf: BTF field iterator
Date: Mon,  3 Jun 2024 16:17:14 -0700
Message-ID: <20240603231720.1893487-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BTF field (type and string fields, right now) iterator support instead of
using existing callback-based approaches, which make it harder to understand
and support BTF-processing code.

rfcv1->v1:
  - check errors when initializing iterators (Jiri);
  - split RFC patch into separate patches.

Andrii Nakryiko (5):
  libbpf: add BTF field iterator
  libbpf: make use of BTF field iterator in BPF linker code
  libbpf: make use of BTF field iterator in BTF handling code
  bpftool: use BTF field iterator in btfgen
  libbpf: remove callback-based type/string BTF field visitor helpers

 tools/bpf/bpftool/gen.c         |  16 +-
 tools/lib/bpf/btf.c             | 328 +++++++++++++++++++-------------
 tools/lib/bpf/libbpf_internal.h |  26 ++-
 tools/lib/bpf/linker.c          |  60 +++---
 4 files changed, 264 insertions(+), 166 deletions(-)

-- 
2.43.0


