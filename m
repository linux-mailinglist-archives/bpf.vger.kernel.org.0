Return-Path: <bpf+bounces-44241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2389C9C07E9
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD09A286B3D
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D0212634;
	Thu,  7 Nov 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WIcyux+j"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB865DDBE
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987171; cv=none; b=XkQuU52TOlRcvKo8XdhQNexAeRrKQnXDCE4Arc6iSio2nB+IsyhDE8sSbSYQUNnZQWXTuIk8ClDL0ekwN1VHGAKHDBLg3bJKP6Lr3BdPA2CKBA4tR+XpGC2vsT6JeEQAOWyvXfGlio2CMCqUiSXep4hl/66s03DDcW/0PYb0K8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987171; c=relaxed/simple;
	bh=NsneTWHaNAudkLZw3xEHQSD5S/ruJjI6YG8hAd0+rxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WicXHqIqZ5f4gN98U1SJVYVb4F4BzMaKvJVNUZ6INb/u9fSLYSmUVIX0gdq5d0t4oyiiWCGpKFLK/a2CGMXtNjU0dMMlqh1Dnc/x7Vv/RqUkTI2BVaSFnoqBVo1AR6N5fhIqfVKhBdoTDvmrlj2IoHKso6DaWylucoMvFkdeY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WIcyux+j; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730987166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yTdJ5j7kdgzcd8gsdAJi9jZygNsNnc4vRsKJ9NYEFng=;
	b=WIcyux+jY2dFYumXG9D7eC3UkiGk1/nEi22kxhPrKDpzmA2ZvW32xTfANqZIaD05yPhRy4
	zXF7TaNpUECBcg7keudmLpBr4sqH+gqhooEIiPs8Y9ArzdgO8z+ir3rLSTfaEz9qu7J6xM
	BbUHLOId3sCIRdqHTamMKOjOZCCl7d0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 0/2] bpf, x64: Introduce two tailcall enhancements
Date: Thu,  7 Nov 2024 21:45:27 +0800
Message-ID: <20241107134529.8602-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch set introduces two enhancements aimed at improving tailcall
handling in the x64 JIT:

1. Tailcall info is propagated only for subprogs.
2. Tailcall info is propagated through the trampoline only when the target
   is a subprog and it is tail_call_reachable.

Changes:
v2 -> v3:
  * Add Yonghong's ACK.

v1 -> v2:
  * Address comment from Alexei:
    * Rather live with tail call inefficiency than abuse insns fields
      further.

Leon Hwang (2):
  bpf, x64: Propagate tailcall info only for subprogs
  bpf, verifier: Check trampoline target is tail_call_reachable subprog

 arch/x86/net/bpf_jit_comp.c | 3 ++-
 include/linux/bpf.h         | 1 +
 kernel/bpf/verifier.c       | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.44.0


