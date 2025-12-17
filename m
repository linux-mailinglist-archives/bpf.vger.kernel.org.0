Return-Path: <bpf+bounces-76841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A55BCC6D05
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6C9230198D4
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F433C191;
	Wed, 17 Dec 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fikt6Sk2"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B733B95A;
	Wed, 17 Dec 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964033; cv=none; b=aYAQrC7Vr7FmL0yzNLTLypyLmbq2p69aGiMaWxnh4B2WKdPoSD5WDVbr8Zuu1dQ9CQyxASP2iyYnzQnrC2LMmw0HuazUrS5WQPcHmlPiGFWx9cyYjpsDkLOuBSYr3LP8rlNEPPIJHHR2GrnRC7HHU9QXBYP3rdYkVSDfpuUcLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964033; c=relaxed/simple;
	bh=cQg0g3c7FoMddCAuUdoQuLTA9R42Hif3uskaw5G5s9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5iMusat2jTp6XeV7KleRi8xFJ1BsnW0V6joyzyVdzGawxM778IdIRCFPNihUi9ypGuoZNwID0yx7BwwBB56GOzik68ijrTjIXCmKVywlT3Wz5iY3eQ6SNMeznswFDDkRncb6wt35yqLJnj6WR+symlm8ebhO8kXV4sh3A3VozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fikt6Sk2; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765964029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/ButwXcXAYoe8oZpXrOH3tSrXvw2y4zyvDcp+XtLJXc=;
	b=Fikt6Sk2bEfF4DZTd+gVVTLmgbsOicDyP+I7iyc67pnheRhBGZyMJaAzCAQEBM7EdtPgZ9
	Qn5U7o74Tw8nCpJygx9YY3fZhvFR4bwjgNzQ/rLd+7/0+TIEr6+Fc80iRZdBZzsaFYU5le
	APpsmA2D9HfPbzqDUKHmJl0pCXyjQts=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH RESEND bpf-next v7 0/2] Pass external callchain entry to get_perf_callchain
Date: Wed, 17 Dec 2025 17:33:24 +0800
Message-ID: <20251217093326.1745307-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Background
==========
Alexei noted we should use preempt_disable to protect get_perf_callchain
in bpf stackmap.
https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com

A previous patch was submitted to attempt fixing this issue. And Andrii
suggested teach get_perf_callchain to let us pass that buffer directly to
avoid that unnecessary copy.
https://lore.kernel.org/bpf/20250926153952.1661146-1-chen.dylane@linux.dev

Proposed Solution
=================
Add external perf_callchain_entry parameter for get_perf_callchain to
allow us to use external buffer from BPF side. The biggest advantage is
that it can reduce unnecessary copies.

Todo
====
But I'm not sure if this modification is appropriate. After all, the
implementation of get_callchain_entry in the perf subsystem seems much more
complex than directly using an external buffer.

Comments and suggestions are always welcome.

Change list:
 - v1 -> v2
   From Jiri
   - rebase code, fix conflict
 - v1: https://lore.kernel.org/bpf/20251013174721.2681091-1-chen.dylane@linux.dev

 - v2 -> v3:
   From Andrii
   - entries per CPU used in a stack-like fashion
 - v2: https://lore.kernel.org/bpf/20251014100128.2721104-1-chen.dylane@linux.dev

 - v3 -> v4:
   From Peter
   - refactor get_perf_callchain and add three new APIs to use perf
     callchain easily.
   From Andrii
   - reuse the perf callchain management.

   - rename patch1 and patch2.
 - v3: https://lore.kernel.org/bpf/20251019170118.2955346-1-chen.dylane@linux.dev

 - v4 -> v5:
   From Yonghong
   - keep add_mark false in stackmap when refactor get_perf_callchain in
     patch1.
   - add atomic operation in get_recursion_context in patch2.
   - rename bpf_put_callchain_entry with bpf_put_perf_callchain in
     patch3.
   - rebase bpf-next master.
 - v4: https://lore.kernel.org/bpf/20251028162502.3418817-1-chen.dylane@linux.dev

 - v5 -> v6:
   From Peter
   - disable preemption from BPF side in patch2.
   From AI
   - use ctx->entry->nr instead of ctx->nr in patch1.
 - v5: https://lore.kernel.org/bpf/20251109163559.4102849-1-chen.dylane@linux.dev

 - v6 -> v7:
   From yonghong
   - Add ack in patch2
   From AI
   - resolve conflict
 - v6: https://lore.kernel.org/bpf/20251112163148.100949-1-chen.dylane@linux.dev

Tao Chen (2):
  perf: Refactor get_perf_callchain
  bpf: Hold the perf callchain entry until used completely

 include/linux/perf_event.h | 10 ++++
 kernel/bpf/stackmap.c      | 68 +++++++++++++++++++++-----
 kernel/events/callchain.c  | 99 +++++++++++++++++++++++---------------
 3 files changed, 126 insertions(+), 51 deletions(-)

-- 
2.48.1


