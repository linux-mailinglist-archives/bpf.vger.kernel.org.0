Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D92F437F2B
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhJVUQI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 22 Oct 2021 16:16:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232750AbhJVUQI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 16:16:08 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19MIPKku007751
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 13:13:50 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3buktt869m-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 13:13:50 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 13:13:46 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 565BF70B2FE6; Fri, 22 Oct 2021 13:13:44 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: make perf_buffer selftests work on 4.9 kernel again
Date:   Fri, 22 Oct 2021 13:13:42 -0700
Message-ID: <20211022201342.3490692-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: BzABqH2d4uVZ729dGf2DMzpfx1LhmKWe
X-Proofpoint-ORIG-GUID: BzABqH2d4uVZ729dGf2DMzpfx1LhmKWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110220113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recent change to use tp/syscalls/sys_enter_nanosleep for perf_buffer
selftests causes this selftest to fail on 4.9 kernel in libbpf CI ([0]):

  libbpf: prog 'handle_sys_enter': failed to attach to perf_event FD 6: Invalid argument
  libbpf: prog 'handle_sys_enter': failed to attach to tracepoint 'syscalls/sys_enter_nanosleep': Invalid argument

It's not exactly clear why, because perf_event itself is created for
this tracepoint, but I can't even compile 4.9 kernel locally, so it's
hard to figure this out. If anyone has better luck and would like to
help investigating this, I'd really appreciate this.

For now, unblock CI by switching back to raw_syscalls/sys_enter, but reduce
amount of unnecessary samples emitted by filter by process ID. Use
explicit ARRAY map for that to make it work on 4.9 as well, because
global data isn't yet supported there.

Cc: Jiri Olsa <jolsa@kernel.org>
Fixes: aa274f98b269 ("selftests/bpf: Fix possible/online index mismatch in perf_buffer test")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/perf_buffer.c    |  5 +++++
 .../selftests/bpf/progs/test_perf_buffer.c    | 20 +++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
index 0b0cd045979b..4e32f3586a75 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
@@ -46,6 +46,7 @@ int trigger_on_cpu(int cpu)
 void serial_test_perf_buffer(void)
 {
 	int err, on_len, nr_on_cpus = 0, nr_cpus, i, j;
+	int zero = 0, my_pid = getpid();
 	struct perf_buffer_opts pb_opts = {};
 	struct test_perf_buffer *skel;
 	cpu_set_t cpu_seen;
@@ -71,6 +72,10 @@ void serial_test_perf_buffer(void)
 	if (CHECK(!skel, "skel_load", "skeleton open/load failed\n"))
 		goto out_close;
 
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.my_pid_map), &zero, &my_pid, 0);
+	if (!ASSERT_OK(err, "my_pid_update"))
+		goto out_close;
+
 	/* attach probe */
 	err = test_perf_buffer__attach(skel);
 	if (CHECK(err, "attach_kprobe", "err %d\n", err))
diff --git a/tools/testing/selftests/bpf/progs/test_perf_buffer.c b/tools/testing/selftests/bpf/progs/test_perf_buffer.c
index a08874c5bdf2..17d5b67744d5 100644
--- a/tools/testing/selftests/bpf/progs/test_perf_buffer.c
+++ b/tools/testing/selftests/bpf/progs/test_perf_buffer.c
@@ -6,20 +6,36 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+} my_pid_map SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
 	__type(key, int);
 	__type(value, int);
 } perf_buf_map SEC(".maps");
 
-SEC("tp/syscalls/sys_enter_nanosleep")
+SEC("tp/raw_syscalls/sys_enter")
 int handle_sys_enter(void *ctx)
 {
+	int zero = 0, *my_pid, cur_pid;
 	int cpu = bpf_get_smp_processor_id();
 
+	my_pid = bpf_map_lookup_elem(&my_pid_map, &zero);
+	if (!my_pid)
+		return 1;
+
+	cur_pid = bpf_get_current_pid_tgid() >> 32;
+	if (cur_pid != *my_pid)
+		return 1;
+
 	bpf_perf_event_output(ctx, &perf_buf_map, BPF_F_CURRENT_CPU,
 			      &cpu, sizeof(cpu));
-	return 0;
+	return 1;
 }
 
 char _license[] SEC("license") = "GPL";
-- 
2.30.2

