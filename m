Return-Path: <bpf+bounces-76815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77312CC6037
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 06:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B7963031CEC
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 05:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A9E263C8A;
	Wed, 17 Dec 2025 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VEGC0JhL"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0C255F57
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948377; cv=none; b=AcxdCEh0KGAQV3wINnSuhr66goGrzMy5FOR5pql+nE2UknT/gBDdm7sO+fRKR4uvtpVF+hid2gHf3115oohKtR2zqQCh2p66VsRPu4UJC3aO6Iq/xB7k3pn30xrRojKujAagLtZg80y7Bc8DpaY1M/q1KXK/pTxuz9tgDmbh2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948377; c=relaxed/simple;
	bh=aRLI+YqwVHMF3D0VslZGuO+RkAm0zwioigHPwY9Ks40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAkU7OW0ddVOO8qhwgwj3mSGx8ecMc25AXNCco6o9/cSX9R/0mgoh0e3xJy58JjASiiY7DGQE8QQDvDzDuyC7i38TidU4XhxJ1uuxP1efMiTClCvm1zUpqx/m5dfwt71UBikjrCBLoVKpF2bpyqMEY0d9JLaNP9s3Sj+9WRmq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VEGC0JhL; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765948363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x+G9R0iiLndyw6ppk44l1debId7zW9u7tSzJlQEKdiE=;
	b=VEGC0JhLdSqY2QZuIP62G5qQSlaXO0LyWGKDo5cUae6mBLF5UonK4uEhh6LaM7+5NmKjHO
	iDToIq+9Bv+KqZDBn6whNitpYSEeMqajESC0Ihi72LwYpf4weshUam5zbvIglCf5YJ/GdN
	+VCizlOGff22pfjsK+k+w/ZAg3x6ShA=
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
Subject: [PATCH bpf-next v7 0/2] Pass external callchain entry to get_perf_callchain
Date: Wed, 17 Dec 2025 13:12:00 +0800
Message-ID: <20251217051203.1738517-1-chen.dylane@linux.dev>
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
 - v6: https://lore.kernel.org/bpf/20251112163148.100949-1-chen.dylane@linux.dev

Tao Chen (2):
  perf: Refactor get_perf_callchain
  bpf: Hold the perf callchain entry until used completely

 include/linux/perf_event.h |  9 +++++
 kernel/bpf/stackmap.c      | 67 +++++++++++++++++++++++++++-------
 kernel/events/callchain.c  | 73 ++++++++++++++++++++++++--------------
 3 files changed, 111 insertions(+), 38 deletions(-)

-- 
2.48.1


