Return-Path: <bpf+bounces-74010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9BC4426D
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 17:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D6B188B3AB
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D501303A2A;
	Sun,  9 Nov 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TXvEO6m4"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6D2036E9
	for <bpf@vger.kernel.org>; Sun,  9 Nov 2025 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762706184; cv=none; b=IFJVfgD0MwLo3+pRT6y9sPr4EwmPaGa48QuaSp7iCrFsz1SMdE1HWFgf/MsdmHspSrcsFsMbkdGlBPENRfSSu1Cj7QOaOtJ2PGvaSH+3Jh5HLdm85uxA4EZSwA3B6pcpjptNermGAtO13nALtCrhPtz8fry0K+gQaoOe19QSZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762706184; c=relaxed/simple;
	bh=xS9OyXDsV6sEP+l+dxW1QyhGsfoyKaJmzSCEJoMthSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1V7lQyzWBplJHo68gB6SyMWtmcG2750tKIEj07IOXC+xM2MvjTSqVBbSLmC1gLuQmR2Cwd0fsZhULxc02eQ6ksBcsfeeETxK1rEOmVNg3iMxPJu9jrHt2DKFd+lE6T6ae+zDOFXKm/BmGHmU0S/6UwFa21tPW2AlWMN4uw6eHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TXvEO6m4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762706180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zSIF66S8Iw2Yjrzagiy23Q2vHg4tjgghLWyJ1qxHEOA=;
	b=TXvEO6m4XK9ZartZHiMMFes/7fnOmGzKtbeVU6D3ZqDKtg3MelrWkRWvfCWnC2Z0uh6JE6
	4mlDi9ICODC3RvOsc/gh0stPFn4QBarZOr7oCz2ChbSNTnc/j2EvtDgXtY6hjoWAUG9rca
	Y706dXEuxjGZ0oddQQAU5jW5PPyQ/O4=
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
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v5 0/3] Pass external callchain entry to get_perf_callchain
Date: Mon, 10 Nov 2025 00:35:56 +0800
Message-ID: <20251109163559.4102849-1-chen.dylane@linux.dev>
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

Tao Chen (3):
  perf: Refactor get_perf_callchain
  perf: Add atomic operation in get_recursion_context
  bpf: Hold the perf callchain entry until used completely

 include/linux/perf_event.h |  9 +++++
 kernel/bpf/stackmap.c      | 62 +++++++++++++++++++++++++-------
 kernel/events/callchain.c  | 73 ++++++++++++++++++++++++--------------
 kernel/events/internal.h   |  5 +--
 4 files changed, 107 insertions(+), 42 deletions(-)

-- 
2.48.1


