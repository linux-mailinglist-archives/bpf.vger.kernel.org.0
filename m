Return-Path: <bpf+bounces-52083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD3A3DB9D
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 14:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00021764E7
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE4B1F6679;
	Thu, 20 Feb 2025 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBUR3bPa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BB1FBC89;
	Thu, 20 Feb 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059129; cv=none; b=Wdi5Mx5zJKjwXFPBfAjYGfLDwyNy4/pHLFtrLKKRXA10hjMIAj/A/qM+Z7lQ54F9OP8nBhexrZ3LurFGGviUsWN3zwwAzHUaWb2fI+9+ydOnQ22Z+L8Wd02n0KPboI6T4I7aY464pIFIE2GmMZLbsQ44nZGLnyTM6OuLBleUpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059129; c=relaxed/simple;
	bh=5fj7mFPrfSNstxUkY6VTZHCkWduWWJVFcL0TwY04dWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrOKK8h91vS/SzyCE1HiTyo8AhO6d0wy1Fg9ukm85YI2u9N1nPSruO9Q6lukX2bO2XA8uXiLUNHq3zI4Y8idD1JgB10dwF4piunQTwtsRRaoMTsRKa1mMiD4GZatuXZUQ8hyLi9WLkXWbqzEltwg03W8oLJXKBzIJKHvrzqrLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBUR3bPa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740059128; x=1771595128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fj7mFPrfSNstxUkY6VTZHCkWduWWJVFcL0TwY04dWQ=;
  b=FBUR3bPagA0WuWDDEW4bUhuq9UtA5JsZqaTpHEE1LTyDCxI1RjoKLAni
   9zrAGgX/lumdsMAepD0z1ujPj4cXllAkePGCgZpTyRx3RzDTMPtNZDl7F
   ffngAzrRxh2FYJuyXC/FZvWvXiLgcXW/CQIAGZRv6DulhONdwVep0+DC8
   O1mbcsfEA/bDKH4+ujFeh7NGcvqwCohCM1llxGA384N71Tp9HGe7X1VjO
   IOGDTgQ7LliLvzDw457GdPpK1LcRSRAE/2ykXm9zEbiJSwZ1zStmmdji2
   9zEex0ep+UEAet0hARG/4RfTwC/1ywWYPPfoeYS0JqwBdnMy/ehzd2tne
   Q==;
X-CSE-ConnectionGUID: uTZmziaLTwKO2+IgRZxrHQ==
X-CSE-MsgGUID: vPjVxNRnTR2uRgvQht3ItA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51479231"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="51479231"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 05:45:27 -0800
X-CSE-ConnectionGUID: zRbntPTvT+2KVa7fQY7hXQ==
X-CSE-MsgGUID: SFDwJGMrRx2dGwkvxBahVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119146274"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 20 Feb 2025 05:45:25 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	martin.lau@linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next 3/3] selftests: bpf: implement test case for skb kptr map storage
Date: Thu, 20 Feb 2025 14:45:03 +0100
Message-Id: <20250220134503.835224-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to exercise kptrs behavior against sk_buff structs
stored in eBPF map.

Let us have two programs, one for store and other for retrieving
sk_buffs from pinned map. Load first prog and run as many times as size
of map so that second program will see the map full and will be able to
retrieve each of sk_buff that bpf_prog_test_run_skb() created for us.

Reason for running the progs MAX_ENTRIES times from user space instead
of utilizing @repeat argument of is that we would like to have unique
skbs handled in map. With @repeat usage it would result in storing the
same skb.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/skb_map_kptrs.c  | 75 ++++++++++++++++++
 .../selftests/bpf/progs/skb_map_kptrs.c       | 77 +++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skb_map_kptrs.c
 create mode 100644 tools/testing/selftests/bpf/progs/skb_map_kptrs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_map_kptrs.c b/tools/testing/selftests/bpf/prog_tests/skb_map_kptrs.c
new file mode 100644
index 000000000000..993beac6c344
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/skb_map_kptrs.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#define SKB_KPTR_MAP_PATH "/sys/fs/bpf/skb_kptr_map"
+
+static void skb_map_kptrs(void)
+{
+	int err, prog_fd, store_fd, get_fd, map_fd;
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	char buff[128] = {};
+	struct bpf_map *map;
+	int i;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = buff,
+		.data_size_in = sizeof(buff),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_load("skb_map_kptrs.bpf.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
+				 &prog_fd);
+	if (CHECK_FAIL(err))
+		return;
+
+	map = bpf_object__find_map_by_name(obj, "skb_map");
+	if (CHECK_FAIL(!map))
+		goto map_err;
+
+	map_fd = bpf_map__fd(map);
+	if (map_fd < 0)
+		goto map_err;
+
+	err = bpf_obj_pin(map_fd, SKB_KPTR_MAP_PATH);
+	if (err < 0)
+		goto map_err;
+
+	prog = bpf_object__find_program_by_name(obj, "tc_skb_map_store");
+	if (CHECK_FAIL(!prog))
+		goto out;
+
+	store_fd = bpf_program__fd(prog);
+	if (CHECK_FAIL(store_fd < 0))
+		goto out;
+
+	// store skbs
+	for (i = 0; i < bpf_map__max_entries(map); i++) {
+		err = bpf_prog_test_run_opts(store_fd, &topts);
+		ASSERT_OK(err, "skb kptr store");
+	}
+
+	prog = bpf_object__find_program_by_name(obj, "tc_skb_map_get");
+	if (CHECK_FAIL(!prog))
+		goto out;
+
+	get_fd = bpf_program__fd(prog);
+	if (CHECK_FAIL(get_fd < 0))
+		goto out;
+
+	// get skbs
+	for (i = 0; i < bpf_map__max_entries(map); i++) {
+		err = bpf_prog_test_run_opts(get_fd, &topts);
+		ASSERT_OK(err, "skb kptr get");
+	}
+
+out:
+	unlink(SKB_KPTR_MAP_PATH);
+map_err:
+	bpf_object__close(obj);
+}
+
+void test_skb_map_kptrs(void)
+{
+	skb_map_kptrs();
+}
+
diff --git a/tools/testing/selftests/bpf/progs/skb_map_kptrs.c b/tools/testing/selftests/bpf/progs/skb_map_kptrs.c
new file mode 100644
index 000000000000..f4972978cb04
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/skb_map_kptrs.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+struct sk_buff *bpf_skb_acquire(struct sk_buff *skb) __ksym;
+void bpf_skb_release(struct sk_buff *skb) __ksym;
+
+struct skb_map_val {
+	struct sk_buff __kptr * skb;
+};
+
+static __u32 get_idx;
+static __u32 store_idx;
+
+#define MAX_ENTRIES 100
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, struct skb_map_val);
+	__uint(max_entries, MAX_ENTRIES);
+} skb_map SEC(".maps");
+
+static __always_inline __u32 idx_bump(__u32 idx)
+{
+	return idx >= MAX_ENTRIES ? 0 : idx + 1;
+}
+
+SEC("tc") int tc_skb_map_store(struct __sk_buff *ctx)
+{
+	struct sk_buff *skbk = bpf_cast_to_kern_ctx(ctx);
+	struct skb_map_val *map_entry, tmp_entry;
+	struct sk_buff *tmp;
+
+	tmp_entry.skb = NULL;
+	bpf_map_update_elem(&skb_map, &store_idx, &tmp_entry, BPF_ANY);
+	map_entry = bpf_map_lookup_elem(&skb_map, &store_idx);
+	if (!map_entry)
+		return -1;
+
+	skbk = bpf_skb_acquire(skbk);
+	if (!skbk)
+		return -2;
+
+	tmp = bpf_kptr_xchg(&map_entry->skb, skbk);
+	if (tmp)
+		bpf_skb_release(tmp);
+
+	store_idx = idx_bump(store_idx);
+
+	return 0;
+}
+
+SEC("tc") int tc_skb_map_get(struct __sk_buff *ctx)
+{
+	struct sk_buff *stored_skb = NULL;
+	struct skb_map_val *map_entry;
+	struct sk_buff *tmp = NULL;
+
+	(void)ctx;
+
+	map_entry = bpf_map_lookup_elem(&skb_map, &get_idx);
+	if (!map_entry)
+		return -1;
+
+	stored_skb = bpf_kptr_xchg(&map_entry->skb, tmp);
+	if (!stored_skb)
+		return -2;
+
+	bpf_skb_release(stored_skb);
+	get_idx = idx_bump(get_idx);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


