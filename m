Return-Path: <bpf+bounces-40401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E3988234
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 12:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFADC288FE8
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F36B1BC067;
	Fri, 27 Sep 2024 10:03:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD521BB69C;
	Fri, 27 Sep 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431423; cv=none; b=J9ybn4CofvFLBP5PYACTC+nIZgmB4nOnmtDKi6TtEoguRUqDDtdlfLIt96OHMqaS9F2j9IBjMuKTp389kVJb4wfkORoNFlJUInaG/7Fqf8lLmVkVutQnavdSWWKXPL4Teuyc5NWyzqVbG7zAY4KhFab2M+g4EilRBoLDDVYk5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431423; c=relaxed/simple;
	bh=VLYVdA9CFzvQ1GWLMkyg1fZOhSaxwyP/2kJeom4cG1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcF4ajZkoafm6nIjoE5W2UhKA8carbRZqq+z8PX+PlZt6COuiZ/hd95hdwx0e55lDWdbvabncJ1i9ejfsYoMkKkl/cpmiQ3FD3cwWsPgbIIpp2WDfwNo7L34koSFcnbei8/SkRP1CT/7/TkKOr9EzsSXt87ZZ/o+bhj8dk5l4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XFQwK0nYmzWf35;
	Fri, 27 Sep 2024 18:01:21 +0800 (CST)
Received: from kwepemg200002.china.huawei.com (unknown [7.202.181.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 31AC41401E9;
	Fri, 27 Sep 2024 18:03:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200002.china.huawei.com
 (7.202.181.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Sep
 2024 18:03:38 +0800
From: Yipeng Zou <zouyipeng@huawei.com>
To: <linux-pm@vger.kernel.org>, <bpf@vger.kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
	<song@kernel.org>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>
CC: <zouyipeng@huawei.com>, <liaochang1@huawei.com>
Subject: [RFC PATCH 2/2] cpufreq_ext: Add bpf sample
Date: Fri, 27 Sep 2024 18:13:42 +0800
Message-ID: <20240927101342.3240263-3-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927101342.3240263-1-zouyipeng@huawei.com>
References: <20240927101342.3240263-1-zouyipeng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200002.china.huawei.com (7.202.181.29)

The cpufreq_ext sample implement the typical BPF governor, switch to
max cpufreq when VIP task is running on target cpu.

We can enable the sample in the following step:

1. First add target VIP task PID in samples/bpf/cpufreq_ext.bpf.c,
   append in vip_task_pid array.

	s32 vip_task_pid[] = {
		...
		@PID
		...
	}

2. Compile the sample.

	make -C samples/bpf/

3. Configure ext governor on all cpufreq policy.

	echo ext > /sys/devices/system/cpu/cpufreq/policy*/scaling_governor

4. Install the sample.

	./samples/bpf/cpufreq_ext

If everything works well, will have some message in kernel log.

	# dmesg
	cpufreq_ext: ext_reg: Register ext governor(VIP).

After BPF cpufreq governor loaded, we can see current BPF governor
information in ext/stat attribute.

	# cat /sys/devices/system/cpu/cpufreq/ext/stat
	Stat: CPUFREQ_EXT_LOADED
	BPF governor: VIP

The "VIP" is the BPF governor name.

And we can see some log in trace file.

	# cat /sys/kernel/debug/tracing/trace
	...
	bpf_trace_printk: VIP running Set Freq(2600000) On Policy0.
	bpf_trace_printk: No VIP Set Freq(200000) On Policy0.
	...

Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 samples/bpf/.gitignore         |   1 +
 samples/bpf/Makefile           |   8 ++-
 samples/bpf/cpufreq_ext.bpf.c  | 113 +++++++++++++++++++++++++++++++++
 samples/bpf/cpufreq_ext_user.c |  48 ++++++++++++++
 4 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 samples/bpf/cpufreq_ext.bpf.c
 create mode 100644 samples/bpf/cpufreq_ext_user.c

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index 9f36fe5e2208..85903156e7e7 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+cpufreq_ext
 cpustat
 fds_example
 hbm
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index bb4ab3a86b40..07b05d5cf748 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -46,6 +46,7 @@ tprogs-y += xdp_fwd
 tprogs-y += task_fd_query
 tprogs-y += ibumad
 tprogs-y += hbm
+tprogs-y += cpufreq_ext
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -96,6 +97,7 @@ xdp_fwd-objs := xdp_fwd_user.o
 task_fd_query-objs := task_fd_query_user.o $(TRACE_HELPERS)
 ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
+cpufreq_ext-objs := cpufreq_ext_user.o
 
 xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
 
@@ -149,6 +151,7 @@ always-y += task_fd_query_kern.o
 always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
+always-y += cpufreq_ext.bpf.o
 
 TPROGS_CFLAGS = $(TPROGS_USER_CFLAGS)
 TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
@@ -200,6 +203,7 @@ TPROGLDLIBS_trace_output	+= -lrt
 TPROGLDLIBS_trace_power		+= -lrt
 TPROGLDLIBS_map_perf_test	+= -lrt
 TPROGLDLIBS_test_overhead	+= -lrt
+TPROGLDLIBS_cpufreq_ext		+= -lrt
 
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 # make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
@@ -311,6 +315,7 @@ $(obj)/$(TRACE_HELPERS) $(obj)/$(CGROUP_HELPERS) $(obj)/$(XDP_SAMPLE): | libbpf_
 .PHONY: libbpf_hdrs
 
 $(obj)/xdp_router_ipv4_user.o: $(obj)/xdp_router_ipv4.skel.h
+$(obj)/cpufreq_ext_user.o: $(obj)/cpufreq_ext.skel.h
 
 $(obj)/tracex5.bpf.o: $(obj)/syscall_nrs.h
 $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
@@ -375,10 +380,11 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
 
-LINKED_SKELS := xdp_router_ipv4.skel.h
+LINKED_SKELS := xdp_router_ipv4.skel.h cpufreq_ext.skel.h
 clean-files += $(LINKED_SKELS)
 
 xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
+cpufreq_ext.skel.h-deps := cpufreq_ext.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/samples/bpf/cpufreq_ext.bpf.c b/samples/bpf/cpufreq_ext.bpf.c
new file mode 100644
index 000000000000..deba5813ce93
--- /dev/null
+++ b/samples/bpf/cpufreq_ext.bpf.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/*
+ * When VIP task is running switching to max speed
+ */
+static s32 vip_task_pid[] = {
+	324, // Stub, need to be replacing
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, int);
+	__uint(max_entries, 1);
+} exit_stat SEC(".maps");
+
+#define READ_KERNEL(P)								\
+	({									\
+		typeof(P) val;							\
+		bpf_probe_read_kernel(&val, sizeof(val), &(P));			\
+		val;								\
+	})
+
+#define TASK_RUNNING 0x00000000
+
+#define task_is_running(task)	(READ_KERNEL((task)->__state) == TASK_RUNNING)
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+bool ext_helper_is_cpu_in_policy(unsigned int cpu, struct cpufreq_policy *policy) __ksym;
+
+static bool is_vip_task_running_on_cpus(struct cpufreq_policy *policy)
+{
+	struct task_struct *task = NULL;
+	bool is_vip_running = false;
+	struct thread_info info;
+	s32 cpu;
+
+	for (unsigned int index = 0; index < ARRAY_SIZE(vip_task_pid); index++) {
+		task = bpf_task_from_pid(vip_task_pid[index]);
+		if (!task)
+			continue;
+
+		is_vip_running = task_is_running(task);
+		info = READ_KERNEL(task->thread_info);
+		cpu = READ_KERNEL(info.cpu);
+		bpf_task_release(task);
+
+		/* Only task running on target CPU can update policy freq */
+		if (is_vip_running && ext_helper_is_cpu_in_policy(cpu, policy))
+			return true;
+	}
+
+	return false;
+}
+
+SEC("struct_ops.s/get_next_freq")
+unsigned long BPF_PROG(update_next_freq, struct cpufreq_policy *policy)
+{
+	unsigned int max_freq = READ_KERNEL(policy->max);
+	unsigned int min_freq = READ_KERNEL(policy->min);
+	unsigned int cur_freq = READ_KERNEL(policy->cur);
+	unsigned int policy_cpu = READ_KERNEL(policy->cpu);
+
+	if (is_vip_task_running_on_cpus(policy) == false) {
+		if (cur_freq != min_freq)
+			bpf_printk("No VIP Set Freq(%d) On Policy%d.\n", min_freq, policy_cpu);
+		return min_freq;
+	}
+
+	if (cur_freq != max_freq)
+		bpf_printk("VIP running Set Freq(%d) On Policy%d.\n", max_freq, policy_cpu);
+	return max_freq;
+}
+
+SEC("struct_ops.s/get_sampling_rate")
+unsigned int BPF_PROG(update_sampling_rate, struct cpufreq_policy *policy)
+{
+	/* Return 0 means keep smapling_rate no modified */
+	return 0;
+}
+
+SEC("struct_ops.s/init")
+unsigned int BPF_PROG(ext_init)
+{
+	return 0;
+}
+
+SEC("struct_ops.s/exit")
+void BPF_PROG(ext_exit)
+{
+	unsigned int index = 0;
+	int code = 1;
+
+	bpf_map_update_elem(&exit_stat, &index, &code, BPF_EXIST);
+}
+
+SEC(".struct_ops.link")
+struct cpufreq_governor_ext_ops cpufreq_ext_demo_ops = {
+	.get_next_freq		= (void *)update_next_freq,
+	.get_sampling_rate	= (void *)update_sampling_rate,
+	.init			= (void *)ext_init,
+	.exit			= (void *)ext_exit,
+	.name			= "VIP"
+};
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/cpufreq_ext_user.c b/samples/bpf/cpufreq_ext_user.c
new file mode 100644
index 000000000000..7f058d8efae5
--- /dev/null
+++ b/samples/bpf/cpufreq_ext_user.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <time.h>
+#include <signal.h>
+#include <bpf/libbpf.h>
+#include <sys/mman.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <bpf/bpf.h>
+#include "cpufreq_ext.skel.h"
+
+static int exit_req;
+
+static void err_exit(int err)
+{
+	exit_req = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct bpf_link *link;
+	struct cpufreq_ext *skel;
+	int idx = 0;
+	int exit_stat;
+
+	signal(SIGINT, err_exit);
+	signal(SIGKILL, err_exit);
+	signal(SIGTERM, err_exit);
+
+	skel = cpufreq_ext__open_and_load();
+	bpf_map__set_autoattach(skel->maps.cpufreq_ext_demo_ops, false);
+	link = bpf_map__attach_struct_ops(skel->maps.cpufreq_ext_demo_ops);
+
+	while (!exit_req) {
+		exit_stat = 0;
+		bpf_map_lookup_elem(bpf_map__fd(skel->maps.exit_stat), &idx, &exit_stat);
+		if (exit_stat)
+			break;
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	cpufreq_ext__destroy(skel);
+	return 0;
+}
-- 
2.34.1


