Return-Path: <bpf+bounces-71111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 606E6BE40C5
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 16:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2C5234CD3F
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA179342CAE;
	Thu, 16 Oct 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PiVYE9Ej"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6044E33A003
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626736; cv=none; b=tlom8N3el08HnHyyy/lHVcfpIvy8/jxQaz1RSCvRfSirAclgKA5U+mV6aBTCNEmu1wPIaElDUx7GRu3DYzfUOg23DFZjO6WMk57zKkFnlmZ/DSA/s0KQJG+QXfsUFR7LxEzW8t3pJKzKbepsS0zx6+XnXiU8tR1BIXWuG20sECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626736; c=relaxed/simple;
	bh=I7PaL4SREtzidov7I278edgTffWBcXGsgdgTLh4jSAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+txx/UUjaPMB3Bbrp0nsZ2MWUdFyOHHg3FP2R8l4H6lVYXarEellWSMawc0OvT7rPKmRyFuXSfEQVJ+P9oO5IGEjhfJgfNIWmXmLgSHvUCQUoaa67VPYiPHW9fvf5VLmTVMXToso9EqxARsg5JY1U5mjuGoVtk2DViVkC3KoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PiVYE9Ej; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760626731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5RU1RSBR337CCrGtAPGMTNU9aViQm/KbHnwvj3Uz7y8=;
	b=PiVYE9Ej/MH86a9h2C9B0swJ10Za3AVSVM3tD7L9DV/x/r7WgmryhFp/aRRIOmE9U9BEi5
	t8yXJ0ymwKnaxu1W2QQjvPanudprReOqpSUihvYG58bhBmz4qf6DECDclaHsQX6Jzc6Hsu
	u+Aij7r/cYPHcrNT1IiBozumNddsfiE=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf 0/3] bpf: Fix possible memleak when updating hash maps
Date: Thu, 16 Oct 2025 22:57:58 +0800
Message-ID: <20251016145801.47552-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the discussion thread
"[PATCH bpf-next v9 0/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps"[1],
it was pointed out that missing calls to bpf_obj_free_fields() could lead to memory leaks.

A selftest was added to confirm that this is indeed a real issue - the
memory referenced by BPF_KPTR_{REF,PERCPU} fields is not freed when
bpf_obj_free_fields() is missing after copy_map_value[,_long]().

Further inspection of copy_map_value[,_long]() call sites revealed two
locations affected by this issue:

1. pcpu_copy_value()
2. htab_map_update_elem() when used with BPF_F_LOCK

This series fixes the leaks by properly calling bpf_obj_free_fields()
(or check_and_free_fields()) after copy_map_value[,_long]() and adds two
selftests to verify the fix.

Link:
[1] https://lore.kernel.org/bpf/20250930153942.41781-1-leon.hwang@linux.dev/

Leon Hwang (3):
  bpf: Fix possible memleak in [lru_,]percpu_hash map update
  bpf: Fix possible memleak when updating hash maps with BPF_F_LOCK
  selftests/bpf: Add test to verify no memleak when updating hash maps

 kernel/bpf/hashtab.c                          |   4 +
 .../bpf/prog_tests/refcounted_kptr.c          |  93 ++++++++++++++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 101 ++++++++++++++++++
 3 files changed, 198 insertions(+)

--
2.51.0


