Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5486865E7
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 13:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjBAM0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 07:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBAM0W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 07:26:22 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D60C44BCC
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 04:26:20 -0800 (PST)
X-QQ-mid: bizesmtp67t1675254362tvp9a3of
Received: from localhost.localdomain ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 01 Feb 2023 20:25:59 +0800 (CST)
X-QQ-SSF: 0100000000000080B000000A0000000
X-QQ-FEAT: LE7C6P2vL8S0m5t6Gy4nCViug1qPYf2ThzWBxv7NSzNQbgdEgQtRbqGJAI9nO
        D/dAQaaVflCwz1KHpN2NZvk2THxMN/MNQ0ZjP0HoDJokx/JMQJh1jDXbWSTExqAmkMDrryH
        gN9kBep1kTcjN7g1VmKf6rMEjcWXxp+1rot6uPehK2I5jjDiY0OoBvLOia3AGU6y1SBPzbH
        j9o7VE4vqR4b+BxBRqBz3XvOZlEU7Ey9fq07vuuXFr2CfXq6Rku090b7NOTBRl+HJ8Kghzt
        v+MnCaCaC60JSlRsLUsXEJ7SJ2z1y5UMyZkRvOTsdmgSEZ4i/QD53I6mJ1JEAG3x2nLa6JC
        O0RsGZjv9HyQSqD9km4eCcK226Jx6gGFHkWTHADTFovJ/E8cMZ9qlZdrsdelQ==
X-QQ-GoodBg: 0
From:   tong@infragraf.org
To:     bpf@vger.kernel.org, quentin@isovalent.com
Cc:     Tonghao Zhang <tong@infragraf.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [bpf-next v2] bpftool: profile online CPUs instead of possible
Date:   Wed,  1 Feb 2023 20:24:04 +0800
Message-Id: <20230201122404.4256-1-tong@infragraf.org>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:infragraf.org:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tonghao Zhang <tong@infragraf.org>

The number of online cpu may be not equal to possible cpu.
bpftool prog profile, can not create pmu event on possible
but on online cpu.

$ dmidecode -s system-product-name
PowerEdge R620
$ cat /sys/devices/system/cpu/online
0-31
$ cat /sys/devices/system/cpu/possible
0-47

BTW, we can disable CPU dynamically:
$ echo 0 > /sys/devices/system/cpu/cpuX/online

If CPU is offline, perf_event_open will return ENODEV.
To fix this issue, check the value returned and skip
offline CPU.

Signed-off-by: Tonghao Zhang <tong@infragraf.org>
Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
v1:
https://patchwork.kernel.org/project/netdevbpf/patch/20230117044902.98938-1-tong@infragraf.org/
https://patchwork.kernel.org/project/netdevbpf/patch/20230117044902.98938-2-tong@infragraf.org/
---
 tools/bpf/bpftool/prog.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index cfc9fdc1e863..f48067cb0496 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2233,10 +2233,36 @@ static void profile_close_perf_events(struct profiler_bpf *obj)
 	profile_perf_event_cnt = 0;
 }
 
+static int profile_open_perf_event(int mid, int cpu, int map_fd)
+{
+	int pmu_fd;
+
+	pmu_fd = syscall(__NR_perf_event_open, &metrics[mid].attr,
+			 -1/*pid*/, cpu, -1/*group_fd*/, 0);
+	if (pmu_fd < 0) {
+		if (errno == ENODEV) {
+			p_info("cpu %d may be offline, skip %s metric profiling.",
+				cpu, metrics[mid].name);
+			profile_perf_event_cnt++;
+			return 0;
+		}
+		return -1;
+	}
+
+	if (bpf_map_update_elem(map_fd,
+				&profile_perf_event_cnt,
+				&pmu_fd, BPF_ANY) ||
+	    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0))
+		return -1;
+
+	profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
+	return 0;
+}
+
 static int profile_open_perf_events(struct profiler_bpf *obj)
 {
 	unsigned int cpu, m;
-	int map_fd, pmu_fd;
+	int map_fd;
 
 	profile_perf_events = calloc(
 		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
@@ -2255,17 +2281,11 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 		if (!metrics[m].selected)
 			continue;
 		for (cpu = 0; cpu < obj->rodata->num_cpu; cpu++) {
-			pmu_fd = syscall(__NR_perf_event_open, &metrics[m].attr,
-					 -1/*pid*/, cpu, -1/*group_fd*/, 0);
-			if (pmu_fd < 0 ||
-			    bpf_map_update_elem(map_fd, &profile_perf_event_cnt,
-						&pmu_fd, BPF_ANY) ||
-			    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0)) {
+			if (profile_open_perf_event(m, cpu, map_fd)) {
 				p_err("failed to create event %s on cpu %d",
 				      metrics[m].name, cpu);
 				return -1;
 			}
-			profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
 		}
 	}
 	return 0;
-- 
2.27.0

