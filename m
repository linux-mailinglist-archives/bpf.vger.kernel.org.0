Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE1048CBF7
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbiALT1v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345315AbiALT0h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:26:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4317DC034000
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:26:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h2-20020a5b0a82000000b0061192499188so6400175ybq.9
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VsFFxxwANtIrhwRpJUE2VY/wPWYvmyT5gfi+R44pAG0=;
        b=ENdmOdatY4zEiRnYojm/ITEfSN1H8OKJs2sqMObJUrQuyAnQL29NnS6KfPbj2g5Qnd
         YJ+SI7OApM3JzYQWWA+m4+OkEkHa/ifyxZz7TRpORAoFVUh+f19+ll3idvlJaWwGiz0x
         RVymw0RpjRv0pKuGBsvbyaeCwNn6/X1qgBlbISYnKEkSNkqUOS8ytGWS6J/F5bujUfv7
         ZsmSPauNSBF8Yp7zauBJ52KmJM9Hw3zNQxAkmXOPFpVWGa8yGzEIKyXYD3slkNmAU5BR
         GA5MN9JR+rZw2Tv4z/zRY11br063GYBf0z3PDIiQfW3F/AdoLSjSnfI1SdcWK7ORR5EH
         bdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VsFFxxwANtIrhwRpJUE2VY/wPWYvmyT5gfi+R44pAG0=;
        b=EupQspUWxcCpVrYtmqFY+4hD/fY43dD3L5NBBXbiTRsLAfwPLvHoUPDQa3wm02EvfX
         0nVe5oLbiB42wolwHzjQRZaFLA68SZONLcA/FBBmLuDeEsy/Wco/etXIGccTWXayl8nQ
         NSq2SygOVHRsvInetek9/++IgqD8FmJ85X4Xo4KA+nSghzkOhzCtsVDHxBHPwiqJbZAw
         mALojXvjo+VHdJ12AVZNOoJz1HKCPb4RRdIAlWccZEegYXQXcl6iWwGvXOyxPH4liP5E
         QxsQ/HyQc/vcc0sYp3tTKT8oN1vT+aU4R3ub1AAu3mA5Q5gYpwwlQ2Fql7gw4SSLhf4A
         E8jw==
X-Gm-Message-State: AOAM5307hktJ8KzUeoNhCkj97VOn2zrxb024SrgX/rfPTVy6tDLrJkdI
        Ukp5GvW2eIuK94cJ1znjySdcnFJ/G3w=
X-Google-Smtp-Source: ABdhPJz8qpgAQmgwYbd9zW1gXEAdsK0dh9ecxoggPUKYUrNtALfc2eMBc/Rst1BQvOSd8nJ964YzuHP40Lo=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a25:248a:: with SMTP id k132mr1659355ybk.282.1642015568531;
 Wed, 12 Jan 2022 11:26:08 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:25:47 -0800
In-Reply-To: <20220112192547.3054575-1-haoluo@google.com>
Message-Id: <20220112192547.3054575-9-haoluo@google.com>
Mime-Version: 1.0
References: <20220112192547.3054575-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 8/8] selftests/bpf: Test exposing bpf
 objects in kernfs
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, Joe@google.com,
        Burton@google.com, jevburton.kernel@gmail.com,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftests for exposing bpf objects in kernfs. Basically the added
test tests two functionalities:

  1. the ability to expose generic bpf objects in kernfs.
  2. the ability to expose bpf_view programs to cgroup file system and
     read from the created cgroupfs entry.

The test assumes cgroup v2 is mounted at /sys/fs/cgroup/ and bpffs is
mounted at /sys/fs/bpf/

Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../selftests/bpf/prog_tests/pinning_kernfs.c | 245 ++++++++++++++++++
 .../selftests/bpf/progs/pinning_kernfs.c      |  72 +++++
 2 files changed, 317 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_kernfs.c
 create mode 100644 tools/testing/selftests/bpf/progs/pinning_kernfs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pinning_kernfs.c b/tools/testing/selftests/bpf/prog_tests/pinning_kernfs.c
new file mode 100644
index 000000000000..aa702d05bf25
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/pinning_kernfs.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <test_progs.h>
+#include <time.h>
+#include <unistd.h>
+#include "pinning_kernfs.skel.h"
+
+/* remove pinned object from kernfs */
+static void do_unpin(const char *kernfs_path, const char *msg)
+{
+	struct stat statbuf = {};
+	const char cmd[] = "rm";
+	int fd;
+
+	fd = open(kernfs_path, O_WRONLY);
+	if (fd < 0)
+		return;
+	ASSERT_GE(write(fd, cmd, sizeof(cmd)), 0, "fail_unpin_cgroup_entry");
+	close(fd);
+
+	ASSERT_ERR(stat(kernfs_path, &statbuf), msg);
+}
+
+static void do_pin(int fd, const char *pinpath)
+{
+	struct stat statbuf = {};
+
+	if (!ASSERT_OK(bpf_obj_pin(fd, pinpath), "bpf_obj_pin"))
+		return;
+
+	ASSERT_OK(stat(pinpath, &statbuf), "stat");
+}
+
+static void check_pinning(const char *bpffs_rootpath,
+			  const char *kernfs_rootpath)
+{
+	const char msg[] = "xxx";
+	char buf[8];
+	struct pinning_kernfs *skel;
+	struct bpf_link *link;
+	int prog_fd, map_fd, link_fd;
+	char bpffs_path[64];
+	char kernfs_path[64];
+	struct stat statbuf = {};
+	int err, fd;
+
+	skel = pinning_kernfs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "pinning_kernfs__open_and_load"))
+		return;
+
+	snprintf(kernfs_path, 64, "%s/bpf_obj", kernfs_rootpath);
+	snprintf(bpffs_path, 64, "%s/bpf_obj", bpffs_rootpath);
+
+	prog_fd = bpf_program__fd(skel->progs.wait_show);
+
+	/* test 1:
+	 *
+	 *  - expose object in kernfs without pinning in bpffs in the first place.
+	 */
+	ASSERT_ERR(bpf_obj_pin(prog_fd, kernfs_path), "pin_kernfs_first");
+
+	/* test 2:
+	 *
+	 *  - expose bpf prog in kernfs.
+	 *  - read/write the newly creaded kernfs entry.
+	 */
+	do_pin(prog_fd, bpffs_path);
+	do_pin(prog_fd, kernfs_path);
+	fd = open(kernfs_path, O_RDWR);
+	err = read(fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(err, -1, "unexpected_successful_read"))
+		goto out;
+
+	err = write(fd, msg, sizeof(msg));
+	if (!ASSERT_EQ(err, -1, "unexpected_successful_write"))
+		goto out;
+
+	close(fd);
+	do_unpin(kernfs_path, "kernfs_unpin_prog");
+	ASSERT_OK(unlink(bpffs_path), "bpffs_unlink_prog");
+
+	/* test 3:
+	 *
+	 *  - expose bpf map in kernfs.
+	 *  - read/write the newly created kernfs entry.
+	 */
+	map_fd = bpf_map__fd(skel->maps.wait_map);
+	do_pin(map_fd, bpffs_path);
+	do_pin(map_fd, kernfs_path);
+	fd = open(kernfs_path, O_RDWR);
+	err = read(fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(err, -1, "unexpected_successful_read"))
+		goto out;
+
+	err = write(fd, msg, sizeof(msg));
+	if (!ASSERT_EQ(err, -1, "unexpected_successful_write"))
+		goto out;
+
+	close(fd);
+	do_unpin(kernfs_path, "kernfs_unpin_map");
+	ASSERT_OK(unlink(bpffs_path), "bpffs_unlink_map");
+
+	/* test 4:
+	 *
+	 *  - expose bpf link in kernfs.
+	 *  - read/write the newly created kernfs entry.
+	 *  - removing bpffs entry also removes kernfs entries.
+	 */
+	link = bpf_program__attach(skel->progs.wait_record);
+	link_fd = bpf_link__fd(link);
+	do_pin(link_fd, bpffs_path);
+	do_pin(link_fd, kernfs_path);
+	fd = open(kernfs_path, O_RDWR);
+	err = read(fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(err, -1, "unexpected_successful_read"))
+		goto destroy_link;
+
+	err = write(fd, msg, sizeof(msg));
+	if (!ASSERT_EQ(err, -1, "unexpected_successful_write"))
+		goto destroy_link;
+
+	ASSERT_OK(unlink(bpffs_path), "bpffs_unlink_link");
+	ASSERT_ERR(stat(kernfs_path, &statbuf), "unpin_bpffs_first");
+
+	/* cleanup */
+destroy_link:
+	bpf_link__destroy(link);
+out:
+	close(fd);
+	pinning_kernfs__destroy(skel);
+}
+
+static void spin_on_cpu(int seconds)
+{
+	time_t start, now;
+
+	start = time(NULL);
+	do {
+		now = time(NULL);
+	} while (now - start < seconds);
+}
+
+static void do_work(const char *cgroup)
+{
+	int cpu = 0, pid;
+	char cmd[128];
+
+	/* make cgroup threaded */
+	snprintf(cmd, 128, "echo threaded > %s/cgroup.type", cgroup);
+	system(cmd);
+
+	pid = fork();
+	if (pid == 0) {
+		/* attach to cgroup */
+		snprintf(cmd, 128, "echo %d > %s/cgroup.procs", getpid(), cgroup);
+		system(cmd);
+
+		/* pin process to target cpu */
+		snprintf(cmd, 128, "taskset -pc %d %d", cpu, getpid());
+		system(cmd);
+
+		spin_on_cpu(3); /* spin on cpu for 3 seconds */
+		exit(0);
+	}
+
+	/* pin process to target cpu */
+	snprintf(cmd, 128, "taskset -pc %d %d", cpu, getpid());
+	system(cmd);
+
+	spin_on_cpu(3); /* spin on cpu for 3 seconds */
+	wait(NULL);
+}
+
+void read_from_file(const char *path)
+{
+	int id = 0, lat;
+	char buf[64];
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return;
+	ASSERT_GE(read(fd, buf, sizeof(buf)), 0, "fail_read_cgroup_entry");
+	ASSERT_EQ(sscanf(buf, "%d %d", &id, &lat), 2, "unexpected_seq_show_output");
+	close(fd);
+}
+
+static void check_cgroup_seq_show(const char *bpffs_dir,
+				  const char *cgroup_dir)
+{
+	struct pinning_kernfs *skel;
+	char bpffs_path[64];
+	char cgroup_path[64];
+	int fd;
+
+	skel = pinning_kernfs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "pinning_kernfs__open_and_load"))
+		return;
+
+	pinning_kernfs__attach(skel);
+
+	snprintf(bpffs_path, 64, "%s/bpf_obj", bpffs_dir);
+	snprintf(cgroup_path, 64, "%s/bpf_obj", cgroup_dir);
+
+	/* generate wait events for the cgroup */
+	do_work(cgroup_dir);
+
+	/* expose wait_show prog to cgroupfs */
+	fd = bpf_link__fd(skel->links.wait_show);
+	ASSERT_OK(bpf_obj_pin(fd, bpffs_path), "pin_bpffs");
+	ASSERT_OK(bpf_obj_pin(fd, cgroup_path), "pin_cgroupfs");
+
+	/* read from cgroupfs and check results */
+	read_from_file(cgroup_path);
+
+	/* cleanup */
+	do_unpin(cgroup_path, "cgroup_unpin_seq_show");
+	ASSERT_OK(unlink(bpffs_path), "bpffs_unlink_seq_show");
+
+	pinning_kernfs__destroy(skel);
+}
+
+void test_pinning_kernfs(void)
+{
+	char kernfs_tmpl[] = "/sys/fs/cgroup/bpf_pinning_test_XXXXXX";
+	char bpffs_tmpl[] = "/sys/fs/bpf/pinning_test_XXXXXX";
+	char *kernfs_rootpath, *bpffs_rootpath;
+
+	kernfs_rootpath = mkdtemp(kernfs_tmpl);
+	bpffs_rootpath = mkdtemp(bpffs_tmpl);
+
+	/* check pinning map, prog and link in kernfs */
+	if (test__start_subtest("pinning"))
+		check_pinning(bpffs_rootpath, kernfs_rootpath);
+
+	/* check cgroup seq_show implemented using bpf */
+	if (test__start_subtest("cgroup_seq_show"))
+		check_cgroup_seq_show(bpffs_rootpath, kernfs_rootpath);
+
+	rmdir(kernfs_rootpath);
+	rmdir(bpffs_rootpath);
+}
diff --git a/tools/testing/selftests/bpf/progs/pinning_kernfs.c b/tools/testing/selftests/bpf/progs/pinning_kernfs.c
new file mode 100644
index 000000000000..ca03a9443794
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pinning_kernfs.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct bpf_map_def SEC("maps") wait_map = {
+	.type = BPF_MAP_TYPE_HASH,
+	.key_size = sizeof(__u64),
+	.value_size = sizeof(__u64),
+	.max_entries = 65532,
+};
+
+/* task_group() from kernel/sched/sched.h */
+static struct task_group *task_group(struct task_struct *p)
+{
+	return p->sched_task_group;
+}
+
+static struct cgroup *task_cgroup(struct task_struct *p)
+{
+	struct task_group *tg;
+
+	tg = task_group(p);
+	return tg->css.cgroup;
+}
+
+/* cgroup_id() from linux/cgroup.h */
+static __u64 cgroup_id(const struct cgroup *cgroup)
+{
+	return cgroup->kn->id;
+}
+
+SEC("tp_btf/sched_stat_wait")
+int BPF_PROG(wait_record, struct task_struct *p, __u64 delta)
+{
+	struct cgroup *cgrp;
+	__u64 *wait_ns;
+	__u64 id;
+
+	cgrp = task_cgroup(p);
+	if (!cgrp)
+		return 0;
+
+	id = cgroup_id(cgrp);
+	wait_ns = bpf_map_lookup_elem(&wait_map, &id);
+
+	/* record the max wait latency seen so far */
+	if (!wait_ns)
+		bpf_map_update_elem(&wait_map, &id, &delta, BPF_NOEXIST);
+	else if (*wait_ns < delta)
+		*wait_ns = delta;
+	return 0;
+}
+
+SEC("view/cgroup")
+int BPF_PROG(wait_show, struct seq_file *seq, struct cgroup *cgroup)
+{
+	__u64 id, *value;
+
+	id = cgroup_id(cgroup);
+	value = bpf_map_lookup_elem(&wait_map, &id);
+
+	if (value)
+		BPF_SEQ_PRINTF(seq, "%llu %llu\n", id, *value);
+	else
+		BPF_SEQ_PRINTF(seq, "%llu 0\n", id);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1.448.ga2b2bfdf31-goog

