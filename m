Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B880222158F
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 21:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGOTvy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 15:51:54 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:53816 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgGOTvx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 15:51:53 -0400
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id C17492E15E1;
        Wed, 15 Jul 2020 22:51:50 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 68OmjYXD2C-pnsaP8Ii;
        Wed, 15 Jul 2020 22:51:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1594842710; bh=Nsz2wNODzC+RLJdSyj6I7YJV6sb/UttprFT4VAmd/Lc=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=ycb9eW2GmqCCqhF+oDcHtcqbeh8oaXyXG7cAUfYywTdBiL6MkYMuF9MkFWRD3cTM7
         ngZTpiZ0T0fbeZKpBoxih9m/w4QlPymtaUiBj8kLsLfCntXaV4P78coOlgQodCBO19
         3xCCzluvPmq2xdjsvALcQmnVWZ//zA99IklNvXIM=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 37.9.121.196-vpn.dhcp.yndx.net (37.9.121.196-vpn.dhcp.yndx.net [37.9.121.196])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id kLmvqU3zdD-pniKgGX6;
        Wed, 15 Jul 2020 22:51:49 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Yakunin <zeil@yandex-team.ru>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     sdf@google.com
Subject: [PATCH bpf-next v3 4/4] bpf: try to use existing cgroup storage in bpf_prog_test_run_skb
Date:   Wed, 15 Jul 2020 22:51:32 +0300
Message-Id: <20200715195132.4286-5-zeil@yandex-team.ru>
In-Reply-To: <20200715195132.4286-1-zeil@yandex-team.ru>
References: <20200715195132.4286-1-zeil@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now we cannot check results in cgroup storage after running
BPF_PROG_TEST_RUN command because it allocates dummy cgroup storage
during test. This patch implements simple logic for searching already
allocated cgroup storage through iterating effective programs of current
cgroup and finding the first match. If match is not found fallback to
temporary storage is happened.

v2:
  - fix build without CONFIG_CGROUP_BPF (kernel test robot <lkp@intel.com>)

Signed-off-by: Dmitry Yakunin <zeil@yandex-team.ru>
---
 net/bpf/test_run.c                                 | 64 +++++++++++++++++-
 .../selftests/bpf/prog_tests/cgroup_skb_prog_run.c | 78 ++++++++++++++++++++++
 2 files changed, 139 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_prog_run.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 050390d..7382b22 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -15,15 +15,67 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/bpf_test_run.h>
 
+#ifdef CONFIG_CGROUP_BPF
+
+static struct bpf_prog_array_item *bpf_prog_find_active(struct bpf_prog *prog,
+							struct bpf_prog_array *effective)
+{
+	struct bpf_prog_array_item *item;
+	struct bpf_prog_array *array;
+	struct bpf_prog *p;
+
+	array = rcu_dereference(effective);
+	if (!array)
+		return NULL;
+
+	item = &array->items[0];
+	while ((p = READ_ONCE(item->prog))) {
+		if (p == prog)
+			return item;
+		item++;
+	}
+
+	return NULL;
+}
+
+static struct bpf_cgroup_storage **bpf_prog_find_active_storage(struct bpf_prog *prog)
+{
+	struct bpf_prog_array_item *item;
+	struct cgroup *cgrp;
+
+	if (prog->type != BPF_PROG_TYPE_CGROUP_SKB)
+		return NULL;
+
+	cgrp = task_dfl_cgroup(current);
+
+	item = bpf_prog_find_active(prog,
+				    cgrp->bpf.effective[BPF_CGROUP_INET_INGRESS]);
+	if (!item)
+		item = bpf_prog_find_active(prog,
+					    cgrp->bpf.effective[BPF_CGROUP_INET_EGRESS]);
+
+	return item ? item->cgroup_storage : NULL;
+}
+
+#else
+
+static struct bpf_cgroup_storage **bpf_prog_find_active_storage(struct bpf_prog *prog)
+{
+	return NULL;
+}
+
+#endif
+
 static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 			u32 *retval, u32 *time, bool xdp)
 {
-	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { NULL };
+	struct bpf_cgroup_storage *dummy_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { NULL };
+	struct bpf_cgroup_storage **storage = dummy_storage;
 	u64 time_start, time_spent = 0;
 	int ret = 0;
 	u32 i;
 
-	ret = bpf_cgroup_storages_alloc(storage, prog);
+	ret = bpf_cgroup_storages_alloc(dummy_storage, prog);
 	if (ret)
 		return ret;
 
@@ -31,6 +83,9 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 		repeat = 1;
 
 	rcu_read_lock();
+	storage = bpf_prog_find_active_storage(prog);
+	if (!storage)
+		storage = dummy_storage;
 	migrate_disable();
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
@@ -54,6 +109,9 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 			cond_resched();
 
 			rcu_read_lock();
+			storage = bpf_prog_find_active_storage(prog);
+			if (!storage)
+				storage = dummy_storage;
 			migrate_disable();
 			time_start = ktime_get_ns();
 		}
@@ -65,7 +123,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	do_div(time_spent, repeat);
 	*time = time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
 
-	bpf_cgroup_storages_free(storage);
+	bpf_cgroup_storages_free(dummy_storage);
 
 	return ret;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_skb_prog_run.c b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_prog_run.c
new file mode 100644
index 0000000..12ca881
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_skb_prog_run.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+static char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
+void test_cgroup_skb_prog_run(void)
+{
+	struct bpf_insn prog[] = {
+		BPF_LD_MAP_FD(BPF_REG_1, 0), /* map fd */
+		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_MOV64_IMM(BPF_REG_1, 1),
+		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
+
+		BPF_MOV64_IMM(BPF_REG_0, 1), /* r0 = 1 */
+		BPF_EXIT_INSN(),
+	};
+	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+	int storage_fd = -1, prog_fd = -1, cg_fd = -1;
+	struct bpf_cgroup_storage_key key;
+	__u32 duration, retval, size;
+	char buf[128];
+	__u64 value;
+	int err;
+
+	storage_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+				    sizeof(struct bpf_cgroup_storage_key),
+				    8, 0, 0);
+	if (CHECK(storage_fd < 0, "create_map", "%s\n", strerror(errno)))
+		goto out;
+
+	prog[0].imm = storage_fd;
+
+	prog_fd = bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
+				   prog, insns_cnt, "GPL", 0,
+				   bpf_log_buf, BPF_LOG_BUF_SIZE);
+	if (CHECK(prog_fd < 0, "prog_load",
+		  "verifier output:\n%s\n-------\n", bpf_log_buf))
+		goto out;
+
+	if (CHECK_FAIL(setup_cgroup_environment()))
+		goto out;
+
+	cg_fd = create_and_get_cgroup("/cg");
+	if (CHECK_FAIL(cg_fd < 0))
+		goto out;
+
+	if (CHECK_FAIL(join_cgroup("/cg")))
+		goto out;
+
+	if (CHECK(bpf_prog_attach(prog_fd, cg_fd, BPF_CGROUP_INET_EGRESS, 0),
+		  "prog_attach", "%s\n", strerror(errno)))
+		goto out;
+
+	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v4, sizeof(pkt_v4),
+				buf, &size, &retval, &duration);
+	CHECK(err || retval != 1, "prog_test_run",
+	      "err %d errno %d retval %d\n", err, errno, retval);
+
+	/* check that cgroup storage results are available after test run */
+
+	err = bpf_map_get_next_key(storage_fd, NULL, &key);
+	CHECK(err, "map_get_next_key", "%s\n", strerror(errno));
+
+	err = bpf_map_lookup_elem(storage_fd, &key, &value);
+	CHECK(err || value != NUM_ITER,
+	      "map_lookup_elem",
+	      "err %d errno %d cnt %lld(%d)\n", err, errno, value, NUM_ITER);
+out:
+	close(storage_fd);
+	close(prog_fd);
+	close(cg_fd);
+	cleanup_cgroup_environment();
+}
-- 
2.7.4

