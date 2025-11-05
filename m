Return-Path: <bpf+bounces-73658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0F0C36577
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 16:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E033B6956
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CCD334C29;
	Wed,  5 Nov 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="imR9MuJp"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC633346BC
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355777; cv=none; b=d5/+lc7Rh9ukL2W+eXYs8T9DUNvQIoxBqnCPJqYdc9EXMU+zyEMrXq+zSGHO8KlaaKK5Zkvtev6J4T6aSCHSOPtP6ZQBwdSCbPjkjHLVqq9FK9XQq2DwDRf1SKzN51K8yQUpVgkcM0GqIQFZt0OZwUaCaOSk/lYiw3g1UFzW0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355777; c=relaxed/simple;
	bh=KwVGKyItxwHcDbibJdy6RGzeEt9wjoeI1M8MUoQKS7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQodnIEm4CzxFTvOr3/WXvqZYtt/uUT3HOCpxD+zUJmR64okcPg6FTOmQgIMBmDqXCs8/o5iSdJut79hKBBRwvKVIqL/2KEo12FE8VrPxpHHHbQGyYwdmeYIjCxPc8uIKyHH6nxL7hJhfhKu3VVm6hoKBNW/uw7NzWa7j6xf80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=imR9MuJp; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762355763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MJsT9hlhLTsvCKavMiWN98EUIoevbIGcLS4c0FMpc4g=;
	b=imR9MuJpbtsgtdJyzlLIO0rXuzIEOPtTjDHCPPqsMoc3C4reloOxKTXeWx9R8R3Y9Izq49
	X45/USNluFUT5/gEl6+OHDlCK8B9jf0eFhtykxrrax1RSEW/dm9LB0iav9FEiY6lHqQyy6
	BXAefAoAE34JY6OF97u5dq6Dc/pltqI=
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
	ameryhung@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v6 0/2] bpf: Free special fields when update [lru_,]percpu_hash maps
Date: Wed,  5 Nov 2025 23:14:05 +0800
Message-ID: <20251105151407.12723-1-leon.hwang@linux.dev>
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

Similar case happens when update local storage maps with BPF_F_LOCK.

This series fixes the cases where BPF_F_LOCK is not involved by
properly calling bpf_obj_free_fields() after copy_map_value[,_long](),
and adds a selftest to verify the fix.

The remaining cases involving BPF_F_LOCK will be addressed in a
separate patch set after the series
"bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps"
is applied.

Changes:
v5 -> v6:
* Update the test name to include "refcounted_kptr".
* Update some local variables' name in the test (per Alexei).
* v5: https://lore.kernel.org/bpf/20251104142714.99878-1-leon.hwang@linux.dev/

v4 -> v5:
* Use a local variable to store the this_cpu_ptr()/per_cpu_ptr() result,
  and reuse it between copy_map_value[,_long]() and
  bpf_obj_free_fields() in patch #1 (per Andrii).
* Drop patch #2 and #3, because the combination of BPF_F_LOCK with other
  special fields (except for BPF_SPIN_LOCK) will be disallowed on the
  UAPI side in the future (per Alexei).
* v4: https://lore.kernel.org/bpf/20251030152451.62778-1-leon.hwang@linux.dev/

v3 -> v4:
* Target bpf-next tree.
* Address comments from Amery:
  * Drop 'bpf_obj_free_fields()' in the path of updating local storage
    maps without BPF_F_LOCK.
  * Drop the corresponding self test.
  * Respin the other test of local storage maps using syscall BPF
    programs.
* v3: https://lore.kernel.org/bpf/20251026154000.34151-1-leon.hwang@linux.dev/

v2 -> v3:
* Free special fields when update local storage maps without BPF_F_LOCK.
* Add test to verify decrementing refcount when update cgroup local
  storage maps without BPF_F_LOCK.
* Address review from AI bot:
  * Slow path with BPF_F_LOCK (around line 642-646) in
    'bpf_local_storage.c'.
* v2: https://lore.kernel.org/bpf/20251020164608.20536-1-leon.hwang@linux.dev/

v1 -> v2:
* Add test to verify decrementing refcount when update cgroup local
  storage maps with BPF_F_LOCK.
* Address review from AI bot:
  * Fast path without bucket lock (around line 610) in
    'bpf_local_storage.c'.
* v1: https://lore.kernel.org/bpf/20251016145801.47552-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Free special fields when update [lru_,]percpu_hash maps
  selftests/bpf: Add test to verify freeing the special fields when
    update [lru_,]percpu_hash maps

 kernel/bpf/hashtab.c                          | 10 +++-
 .../bpf/prog_tests/refcounted_kptr.c          | 57 ++++++++++++++++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 60 +++++++++++++++++++
 3 files changed, 125 insertions(+), 2 deletions(-)

--
2.51.2


