Return-Path: <bpf+bounces-72250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4256FC0ACCA
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 16:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EE018A01BC
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB62253B58;
	Sun, 26 Oct 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X16MDmJh"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12D26ED56
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493245; cv=none; b=pi60UFqP5LwBYZmhrglJjn9uVF3C24CP4l3yNzu1V6I8GKJjDHEIaVz6wW3UQJt0i1Ig38K7jsyP97BIvVo2wc4xAPuyk+H08DUlP7DnMDQwHsDQ+Zz46rJcSIldi4HQ7oO/Zg0YBdbpUo95Lg9pviDKtcI54GYYwHge6sYe4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493245; c=relaxed/simple;
	bh=dz1M6D9fsk5u2D1NH7RozLbg+MvXKtepO3skZdzY9DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlOpPWC/LqozDc5KVVGEfU/KLjzvdn9zAWnRT/cyVDAJgZSDpvZ1a4id4tRgv0mS8KBZNB5xJ3CvQTSOjHPhqJSNogTnqB1QsbXjwdJL+YYJxaapXIx6AV15nUZ4uP/IRm0uQcICFcuiYd6+rq5k46VPTWf0exmILlRX4Qv0tjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X16MDmJh; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761493230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c6h+Zn8ht8TyNdWjST5iIEW7Oxjr35Bqx9NXKCm8Gug=;
	b=X16MDmJhjzpdi6/Zk+mfSjg4LL3NXcNKW4LAV6yDC7W05vkpJ6gVk9IF6TYG2arsnUyGNL
	Tdam8AKfLYQkzZBnZPujpurJz4OM+yG3xguInHqoZITbLlmELbZaLNARWM8fHD7/Smpnah
	4AdudzoM/yMcrUWwBzxMHjRzBsSZrtg=
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
Subject: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and local storage maps
Date: Sun, 26 Oct 2025 23:39:56 +0800
Message-ID: <20251026154000.34151-1-leon.hwang@linux.dev>
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
it was pointed out that missing calls to bpf_obj_free_fields() could
lead to memory leaks.

A selftest was added to confirm that this is indeed a real issue - the
refcount of BPF_KPTR_REF field is not decremented when
bpf_obj_free_fields() is missing after copy_map_value[,_long]().

Further inspection of copy_map_value[,_long]() call sites revealed two
locations affected by this issue:

1. pcpu_copy_value()
2. htab_map_update_elem() when used with BPF_F_LOCK

Similar cases happen when update local storage maps.

This series fixes the issues by properly calling bpf_obj_free_fields()
(or check_and_free_fields()) after copy_map_value[,_long]() and adds
selftests to verify the fix.

Changes:
v2 -> v3:
* Free special fields when update local storage maps without BPF_F_LOCK.
* Add test to verify decrementing refcount when update cgroup local
  storage maps without BPF_F_LOCK.
* Address review from AI bot:
  * Slow path with BPF_F_LOCK (around line 642-646) in
    'bpf_local_storage.c'.
* https://lore.kernel.org/bpf/20251020164608.20536-1-leon.hwang@linux.dev/

v1 -> v2:
* Add test to verify decrementing refcount when update cgroup local
  storage maps with BPF_F_LOCK.
* Address review from AI bot:
  * Fast path without bucket lock (around line 610) in
    'bpf_local_storage.c'.
* https://lore.kernel.org/bpf/20251016145801.47552-1-leon.hwang@linux.dev/

Leon Hwang (4):
  bpf: Free special fields when update [lru_,]percpu_hash maps
  bpf: Free special fields when update hash maps with BPF_F_LOCK
  bpf: Free special fields when update local storage maps
  selftests/bpf: Add tests to verify freeing the special fields when
    update hash and local storage maps

 kernel/bpf/bpf_local_storage.c                |   3 +
 kernel/bpf/hashtab.c                          |   4 +
 .../bpf/prog_tests/refcounted_kptr.c          | 178 +++++++++++++++++-
 .../selftests/bpf/progs/refcounted_kptr.c     | 160 ++++++++++++++++
 4 files changed, 344 insertions(+), 1 deletion(-)

--
2.51.0


