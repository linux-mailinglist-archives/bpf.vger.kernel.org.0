Return-Path: <bpf+bounces-65912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED7CB2AEE4
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 19:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9B7621461
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864103570A0;
	Mon, 18 Aug 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G6Jd/6cP"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E2341AC3;
	Mon, 18 Aug 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536564; cv=none; b=GMc1d3lPGJ5ldRO/+O0gysTfQv5YXhuhi5m2TaXbPJWkbM7wItmo5ZZjkdtU9I9AGRlegOOEGulR5SGKXrjrGMOCFdoDrDU0TzHnZxcFx7OEefs12Y1vzwbKpOFFoEOM7LpCmpA4Yn3CQEywQAgn7DpS65638SHSUoLNcl95cQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536564; c=relaxed/simple;
	bh=RToAh4b/e30wrE6mNGIluyf8QImkEZphYBn0FkizgYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Of8jQsTXHVaFRV7hUbUmIUCej9SbKVTTXo56rqlvo206zuDkjfSLySI98gQ/7WMMhv5Wa3pOZA6iaSMrc1Wo4I2CbrgyByJDc78lujOOo+dYubGG3v2jTBFUfGoxOZACY9kbYB4DAdPCtaBUpKrawnofSmmXUg9WwTKgP6S91bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G6Jd/6cP; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755536560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWT242NgNZP3jc1GQRw8o49/i2gTFgutb9b4mEZjMpA=;
	b=G6Jd/6cPEKn36h3z3JKcou8qMKVTIQVTjk1XJJAqMSHviLXKnseiiF4s+ycNlEVF4gmEs8
	vrd0Hjv0FBdhFuXJqncBC5vwr4nz7aXsRXeFQlIuDqRnz3Mj1mmg9zCQ3L7TRAc1Uh9ikm
	xEoVctnSxZw0eWXBb+JWHvbr37zDzs8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 14/14] bpf: selftests: psi struct ops test
Date: Mon, 18 Aug 2025 10:01:36 -0700
Message-ID: <20250818170136.209169-15-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-1-roman.gushchin@linux.dev>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a psi struct ops test.

The test creates a cgroup with two child sub-cgroups, sets up
memory.high for one of those and puts there a memory hungry
process (initially frozen).

Then it creates 2 psi triggers from within a init() bpf callback and
attaches them to these cgroups.  Then it deletes the first cgroup and
runs the memory hungry task.  The task is creating a high memory
pressure, which triggers the psi event. The psi bpf handler declares
a memcg oom in the corresponding cgroup.  Finally the checks that both
handle_cgroup_free() and handle_psi_event() handlers were executed,
the correct process was killed and oom counters were updated.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 .../selftests/bpf/prog_tests/test_psi.c       | 224 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_psi.c  |  76 ++++++
 2 files changed, 300 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_psi.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_psi.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_psi.c b/tools/testing/selftests/bpf/prog_tests/test_psi.c
new file mode 100644
index 000000000000..4f3c91bd6606
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_psi.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/bpf.h>
+
+#include "cgroup_helpers.h"
+#include "test_psi.skel.h"
+
+enum psi_res {
+	PSI_IO,
+	PSI_MEM,
+	PSI_CPU,
+	PSI_IRQ,
+	NR_PSI_RESOURCES,
+};
+
+struct cgroup_desc {
+	const char *path;
+	unsigned long long id;
+	int pid;
+	int fd;
+	size_t target;
+	size_t high;
+	bool victim;
+};
+
+#define MB (1024 * 1024)
+
+static struct cgroup_desc cgroups[] = {
+	{ .path = "/oom_test" },
+	{ .path = "/oom_test/cg1" },
+	{ .path = "/oom_test/cg2", .target = 500 * MB,
+	  .high = 40 * MB, .victim = true },
+};
+
+static int spawn_task(struct cgroup_desc *desc)
+{
+	char *ptr;
+	int pid;
+
+	pid = fork();
+	if (pid < 0)
+		return pid;
+
+	if (pid > 0) {
+		/* parent */
+		desc->pid = pid;
+		return 0;
+	}
+
+	/* child */
+	ptr = (char *)malloc(desc->target);
+	if (!ptr)
+		return -ENOMEM;
+
+	memset(ptr, 'a', desc->target);
+
+	while (1)
+		sleep(1000);
+
+	return 0;
+}
+
+static void setup_environment(void)
+{
+	int i, err;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(cgroups); i++) {
+		cgroups[i].fd = create_and_get_cgroup(cgroups[i].path);
+		if (!ASSERT_GE(cgroups[i].fd, 0, "create_and_get_cgroup"))
+			goto cleanup;
+
+		cgroups[i].id = get_cgroup_id(cgroups[i].path);
+		if (!ASSERT_GT(cgroups[i].id, 0, "get_cgroup_id"))
+			goto cleanup;
+
+		/* Freeze the top-level cgroup and enable the memory controller */
+		if (i == 0) {
+			err = write_cgroup_file(cgroups[i].path, "cgroup.freeze", "1");
+			if (!ASSERT_OK(err, "freeze cgroup"))
+				goto cleanup;
+
+			err = write_cgroup_file(cgroups[i].path, "cgroup.subtree_control",
+						"+memory");
+			if (!ASSERT_OK(err, "enable memory controller"))
+				goto cleanup;
+		}
+
+		/* Set memory.high */
+		if (cgroups[i].high) {
+			char buf[256];
+
+			snprintf(buf, sizeof(buf), "%lu", cgroups[i].high);
+			err = write_cgroup_file(cgroups[i].path, "memory.high", buf);
+			if (!ASSERT_OK(err, "set memory.high"))
+				goto cleanup;
+
+			snprintf(buf, sizeof(buf), "0");
+			write_cgroup_file(cgroups[i].path, "memory.swap.max", buf);
+		}
+
+		/* Spawn tasks creating memory pressure */
+		if (cgroups[i].target) {
+			char buf[256];
+
+			err = spawn_task(&cgroups[i]);
+			if (!ASSERT_OK(err, "spawn task"))
+				goto cleanup;
+
+			snprintf(buf, sizeof(buf), "%d", cgroups[i].pid);
+			err = write_cgroup_file(cgroups[i].path, "cgroup.procs", buf);
+			if (!ASSERT_OK(err, "put child into a cgroup"))
+				goto cleanup;
+		}
+	}
+
+	return;
+
+cleanup:
+	cleanup_cgroup_environment();
+}
+
+static int run_and_wait_for_oom(void)
+{
+	int ret = -1;
+	bool first = true;
+	char buf[4096] = {};
+	size_t size;
+
+	/* Unfreeze the top-level cgroup */
+	ret = write_cgroup_file(cgroups[0].path, "cgroup.freeze", "0");
+	if (!ASSERT_OK(ret, "unfreeze cgroup"))
+		return -1;
+
+	for (;;) {
+		int i, status;
+		pid_t pid = wait(&status);
+
+		if (pid == -1) {
+			if (errno == EINTR)
+				continue;
+			/* ECHILD */
+			break;
+		}
+
+		if (!first)
+			continue;
+		first = false;
+
+		/* Check which process was terminated first */
+		for (i = 0; i < ARRAY_SIZE(cgroups); i++) {
+			if (!ASSERT_OK(cgroups[i].victim !=
+				       (pid == cgroups[i].pid),
+				       "correct process was killed")) {
+				ret = -1;
+				break;
+			}
+
+			if (!cgroups[i].victim)
+				continue;
+
+			/* Check the memcg oom counter */
+			size = read_cgroup_file(cgroups[i].path, "memory.events",
+						buf, sizeof(buf));
+			if (!ASSERT_OK(size <= 0, "read memory.events")) {
+				ret = -1;
+				break;
+			}
+
+			if (!ASSERT_OK(strstr(buf, "oom_kill 1") == NULL,
+				       "oom_kill count check")) {
+				ret = -1;
+				break;
+			}
+		}
+
+		/* Kill all remaining tasks */
+		for (i = 0; i < ARRAY_SIZE(cgroups); i++)
+			if (cgroups[i].pid && cgroups[i].pid != pid)
+				kill(cgroups[i].pid, SIGKILL);
+	}
+
+	return ret;
+}
+
+void test_psi(void)
+{
+	struct test_psi *skel;
+	u64 freed_cgroup_id;
+	int err;
+
+	setup_environment();
+
+	skel = test_psi__open_and_load();
+	err = libbpf_get_error(skel);
+	if (CHECK_FAIL(err))
+		goto cleanup;
+
+	skel->bss->deleted_cgroup_id = cgroups[1].id;
+	skel->bss->high_pressure_cgroup_id = cgroups[2].id;
+
+	err = test_psi__attach(skel);
+	if (CHECK_FAIL(err))
+		goto cleanup;
+
+	/* Delete the first cgroup, it should trigger handle_cgroup_free() */
+	remove_cgroup(cgroups[1].path);
+
+	/* Unfreeze all child tasks and create the memory pressure */
+	err = run_and_wait_for_oom();
+	CHECK_FAIL(err);
+
+	/* Check the result of the handle_cgroup_free() handler */
+	freed_cgroup_id = skel->bss->deleted_cgroup_id;
+	ASSERT_EQ(freed_cgroup_id, cgroups[1].id, "freed cgroup id");
+
+cleanup:
+	cleanup_cgroup_environment();
+	test_psi__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_psi.c b/tools/testing/selftests/bpf/progs/test_psi.c
new file mode 100644
index 000000000000..2c36c05a3065
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_psi.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct mem_cgroup *bpf_get_mem_cgroup(struct cgroup_subsys_state *css) __ksym;
+void bpf_put_mem_cgroup(struct mem_cgroup *memcg) __ksym;
+int bpf_out_of_memory(struct mem_cgroup *memcg, int order, bool wait_on_oom_lock,
+		      const char *constraint_text__nullable) __ksym;
+int bpf_psi_create_trigger(struct bpf_psi *bpf_psi, u64 cgroup_id,
+			   u32 res, u32 threshold_us, u32 window_us) __ksym;
+
+#define PSI_FULL 0x80000000
+
+/* cgroup which will experience the high memory pressure */
+u64 high_pressure_cgroup_id;
+
+/* cgroup which will be deleted */
+u64 deleted_cgroup_id;
+
+/* cgroup which was actually freed */
+u64 freed_cgroup_id;
+
+char constraint_name[] = "CONSTRAINT_BPF_PSI_MEM";
+
+SEC("struct_ops.s/init")
+int BPF_PROG(psi_init, struct bpf_psi *bpf_psi)
+{
+	int ret;
+
+	ret = bpf_psi_create_trigger(bpf_psi, high_pressure_cgroup_id,
+				     PSI_MEM | PSI_FULL, 100000, 1000000);
+	if (ret)
+		return ret;
+
+	return bpf_psi_create_trigger(bpf_psi, deleted_cgroup_id,
+				      PSI_IO, 100000, 1000000);
+}
+
+SEC("struct_ops.s/handle_psi_event")
+void BPF_PROG(handle_psi_event, struct psi_trigger *t)
+{
+	u64 cgroup_id = t->cgroup_id;
+	struct mem_cgroup *memcg;
+	struct cgroup *cgroup;
+
+	cgroup = bpf_cgroup_from_id(cgroup_id);
+	if (!cgroup)
+		return;
+
+	memcg = bpf_get_mem_cgroup(&cgroup->self);
+	if (!memcg) {
+		bpf_cgroup_release(cgroup);
+		return;
+	}
+
+	bpf_out_of_memory(memcg, 0, true, constraint_name);
+
+	bpf_put_mem_cgroup(memcg);
+	bpf_cgroup_release(cgroup);
+}
+
+SEC("struct_ops.s/handle_cgroup_free")
+void BPF_PROG(handle_cgroup_free, u64 cgroup_id)
+{
+	freed_cgroup_id = cgroup_id;
+}
+
+SEC(".struct_ops.link")
+struct bpf_psi_ops test_bpf_psi = {
+	.init = (void *)psi_init,
+	.handle_psi_event = (void *)handle_psi_event,
+	.handle_cgroup_free = (void *)handle_cgroup_free,
+};
-- 
2.50.1


