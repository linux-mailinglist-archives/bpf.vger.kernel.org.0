Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9215F66D571
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 05:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjAQEuh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 23:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjAQEuf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 23:50:35 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156B234FB
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 20:50:29 -0800 (PST)
X-QQ-mid: bizesmtp82t1673931018twi1c3g3
Received: from localhost.localdomain ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 17 Jan 2023 12:50:14 +0800 (CST)
X-QQ-SSF: 01000000000000709000000A0000000
X-QQ-FEAT: QityeSR92A2LRM9HbIp6yqtbbENnQhbRc6Lqy6GH6yiTMl5HRRGRVKcS2bdJf
        Dkximu1JZ/83DtHNYl6Q0qJRfT7fVgBFlYgu5xuB00aeHp2KOnPguk4xldRcZB1E9e4sfiv
        wcfGrN83o6wDpvS+w/8bXxgZ08tqyI1ZfRulpuCUKTYSG6JMXOgRJi34DnSZocDLX7Z18jM
        zge5ClwmPZx72OLLSVINiG72FCYWdcV5Cnz0v3M057jpcfWUOHw9BsT2SLUswXhMxn/p85w
        2sYav/k701dpt0tv0WluNHBgxaDOodCNNpsUdA5Pv49hqXOQgK7uE1oIJksgnu5db3FOpXq
        lh8cRk82tqE4HrzxusCxpsm8bTWsvFnKTxcVWakXycx03WgRVE=
X-QQ-GoodBg: 0
From:   tong@infragraf.org
To:     bpf@vger.kernel.org
Cc:     Tonghao Zhang <tong@infragraf.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [bpf-next v1 2/2] bpftool: profile online CPUs instead of possible
Date:   Tue, 17 Jan 2023 12:49:02 +0800
Message-Id: <20230117044902.98938-2-tong@infragraf.org>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20230117044902.98938-1-tong@infragraf.org>
References: <20230117044902.98938-1-tong@infragraf.org>
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
but not online cpu.

$ dmidecode -s system-product-name
PowerEdge R620
$ cat /sys/devices/system/cpu/online
0-31
$ cat /sys/devices/system/cpu/possible
0-47

To fix this issue, use online cpu instead of possible, to
create perf event and other resource.

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
 tools/bpf/bpftool/prog.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index cfc9fdc1e863..08b352dd799e 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2056,6 +2056,7 @@ static int profile_parse_metrics(int argc, char **argv)
 
 static void profile_read_values(struct profiler_bpf *obj)
 {
+	__u32 possible_cpus = libbpf_num_possible_cpus();
 	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
 	int reading_map_fd, count_map_fd;
 	__u64 counts[num_cpu];
@@ -2080,7 +2081,7 @@ static void profile_read_values(struct profiler_bpf *obj)
 		profile_total_count += counts[cpu];
 
 	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
-		struct bpf_perf_event_value values[num_cpu];
+		struct bpf_perf_event_value values[possible_cpus];
 
 		if (!metrics[m].selected)
 			continue;
@@ -2321,7 +2322,7 @@ static int do_profile(int argc, char **argv)
 	if (num_metric <= 0)
 		goto out;
 
-	num_cpu = libbpf_num_possible_cpus();
+	num_cpu = libbpf_num_online_cpus();
 	if (num_cpu <= 0) {
 		p_err("failed to identify number of CPUs");
 		goto out;
-- 
2.27.0

