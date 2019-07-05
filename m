Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59379609B9
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2019 17:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfGEPua (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Jul 2019 11:50:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10410 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728151AbfGEPu3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Jul 2019 11:50:29 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65FmuMl028551
        for <bpf@vger.kernel.org>; Fri, 5 Jul 2019 08:50:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=gmJ3Ww64nIC0eN9Aoi+uNs3Il4pcq7m6YpvGThhq5aM=;
 b=Dbf84trzJwZcdiwitA6Qvw8WDw/iGzIcYO7o+Zli1/j53k2p1b7AUalbbvYiH/kxA2Zt
 Riysm2GETgOqF1M9MPILbW/bmY15owQKSssh9b7napOY64ndhGClH/qdDjU+P5KC6M2H
 6IkaTAAY/M44HipIm9CUoNLRJX7I1tMYW7k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2thtd92tq7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2019 08:50:28 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 5 Jul 2019 08:50:25 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 61A9686162B; Fri,  5 Jul 2019 08:50:24 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v5 bpf-next 4/4] selftests/bpf: convert legacy BPF maps to BTF-defined ones
Date:   Fri, 5 Jul 2019 08:50:12 -0700
Message-ID: <20190705155012.3539722-5-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190705155012.3539722-1-andriin@fb.com>
References: <20190705155012.3539722-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050193
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert selftests that were originally left out and new ones added
recently to consistently use BTF-defined maps.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/progs/get_cgroup_id_kern.c  |  26 ++---
 tools/testing/selftests/bpf/progs/pyperf.h    |  90 +++++++-------
 .../bpf/progs/sockmap_verdict_prog.c          |  48 ++++----
 .../testing/selftests/bpf/progs/strobemeta.h  |  68 +++++------
 .../selftests/bpf/progs/test_map_in_map.c     |  30 ++---
 .../testing/selftests/bpf/progs/test_obj_id.c |  12 +-
 .../selftests/bpf/progs/test_xdp_loop.c       |  26 ++---
 .../selftests/bpf/progs/xdp_redirect_map.c    |  12 +-
 .../testing/selftests/bpf/progs/xdping_kern.c |  12 +-
 .../selftests/bpf/test_queue_stack_map.h      |  30 ++---
 .../testing/selftests/bpf/test_sockmap_kern.h | 110 +++++++++---------
 11 files changed, 228 insertions(+), 236 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c b/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c
index 014dba10b8a5..16c54ade6888 100644
--- a/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c
+++ b/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c
@@ -4,19 +4,19 @@
 #include <linux/bpf.h>
 #include "bpf_helpers.h"
 
-struct bpf_map_def SEC("maps") cg_ids = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(__u32),
-	.value_size = sizeof(__u64),
-	.max_entries = 1,
-};
-
-struct bpf_map_def SEC("maps") pidmap = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(__u32),
-	.value_size = sizeof(__u32),
-	.max_entries = 1,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} cg_ids SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} pidmap SEC(".maps");
 
 SEC("tracepoint/syscalls/sys_enter_nanosleep")
 int trace(void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
index abf6224649be..003fe106fc70 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -58,14 +58,6 @@ typedef struct {
 } Event;
 
 
-struct bpf_elf_map {
-	__u32 type;
-	__u32 size_key;
-	__u32 size_value;
-	__u32 max_elem;
-	__u32 flags;
-};
-
 typedef int pid_t;
 
 typedef struct {
@@ -118,47 +110,47 @@ static __always_inline bool get_frame_data(void *frame_ptr, PidData *pidData,
 	return true;
 }
 
-struct bpf_elf_map SEC("maps") pidmap = {
-	.type = BPF_MAP_TYPE_HASH,
-	.size_key = sizeof(int),
-	.size_value = sizeof(PidData),
-	.max_elem = 1,
-};
-
-struct bpf_elf_map SEC("maps") eventmap = {
-	.type = BPF_MAP_TYPE_HASH,
-	.size_key = sizeof(int),
-	.size_value = sizeof(Event),
-	.max_elem = 1,
-};
-
-struct bpf_elf_map SEC("maps") symbolmap = {
-	.type = BPF_MAP_TYPE_HASH,
-	.size_key = sizeof(Symbol),
-	.size_value = sizeof(int),
-	.max_elem = 1,
-};
-
-struct bpf_elf_map SEC("maps") statsmap = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.size_key = sizeof(Stats),
-	.size_value = sizeof(int),
-	.max_elem = 1,
-};
-
-struct bpf_elf_map SEC("maps") perfmap = {
-	.type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
-	.size_key = sizeof(int),
-	.size_value = sizeof(int),
-	.max_elem = 32,
-};
-
-struct bpf_elf_map SEC("maps") stackmap = {
-	.type = BPF_MAP_TYPE_STACK_TRACE,
-	.size_key = sizeof(int),
-	.size_value = sizeof(long long) * 127,
-	.max_elem = 1000,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, PidData);
+} pidmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, Event);
+} eventmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, Symbol);
+	__type(value, int);
+} symbolmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, Stats);
+} statsmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(max_entries, 32);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} perfmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 1000);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(long long) * 127);
+} stackmap SEC(".maps");
 
 static __always_inline int __on_event(struct pt_regs *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
index d85c874ef25e..433e23918a62 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
@@ -4,33 +4,33 @@
 
 int _version SEC("version") = 1;
 
-struct bpf_map_def SEC("maps") sock_map_rx = {
-	.type = BPF_MAP_TYPE_SOCKMAP,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 20,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 20);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} sock_map_rx SEC(".maps");
 
-struct bpf_map_def SEC("maps") sock_map_tx = {
-	.type = BPF_MAP_TYPE_SOCKMAP,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 20,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 20);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} sock_map_tx SEC(".maps");
 
-struct bpf_map_def SEC("maps") sock_map_msg = {
-	.type = BPF_MAP_TYPE_SOCKMAP,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 20,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 20);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} sock_map_msg SEC(".maps");
 
-struct bpf_map_def SEC("maps") sock_map_break = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 20,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 20);
+	__type(key, int);
+	__type(value, int);
+} sock_map_break SEC(".maps");
 
 SEC("sk_skb2")
 int bpf_prog2(struct __sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index 553bc3b62e89..8a399bdfd920 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -204,40 +204,40 @@ struct strobelight_bpf_sample {
 	char dummy_safeguard;
 };
 
-struct bpf_map_def SEC("maps") samples = {
-	.type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 32,
-};
-
-struct bpf_map_def SEC("maps") stacks_0 = {
-	.type = BPF_MAP_TYPE_STACK_TRACE,
-	.key_size = sizeof(uint32_t),
-	.value_size = sizeof(uint64_t) * PERF_MAX_STACK_DEPTH,
-	.max_entries = 16,
-};
-
-struct bpf_map_def SEC("maps") stacks_1 = {
-	.type = BPF_MAP_TYPE_STACK_TRACE,
-	.key_size = sizeof(uint32_t),
-	.value_size = sizeof(uint64_t) * PERF_MAX_STACK_DEPTH,
-	.max_entries = 16,
-};
-
-struct bpf_map_def SEC("maps") sample_heap = {
-	.type = BPF_MAP_TYPE_PERCPU_ARRAY,
-	.key_size = sizeof(uint32_t),
-	.value_size = sizeof(struct strobelight_bpf_sample),
-	.max_entries = 1,
-};
-
-struct bpf_map_def SEC("maps") strobemeta_cfgs = {
-	.type = BPF_MAP_TYPE_PERCPU_ARRAY,
-	.key_size = sizeof(pid_t),
-	.value_size = sizeof(struct strobemeta_cfg),
-	.max_entries = STROBE_MAX_CFGS,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(max_entries, 32);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} samples SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 16);
+	__uint(key_size, sizeof(uint32_t));
+	__uint(value_size, sizeof(uint64_t) * PERF_MAX_STACK_DEPTH);
+} stacks_0 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 16);
+	__uint(key_size, sizeof(uint32_t));
+	__uint(value_size, sizeof(uint64_t) * PERF_MAX_STACK_DEPTH);
+} stacks_1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, uint32_t);
+	__type(value, struct strobelight_bpf_sample);
+} sample_heap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, STROBE_MAX_CFGS);
+	__type(key, pid_t);
+	__type(value, struct strobemeta_cfg);
+} strobemeta_cfgs SEC(".maps");
 
 /* Type for the dtv.  */
 /* https://github.com/lattera/glibc/blob/master/nptl/sysdeps/x86_64/tls.h#L34 */
diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
index 2985f262846e..113226115365 100644
--- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
@@ -5,23 +5,23 @@
 #include <linux/types.h>
 #include "bpf_helpers.h"
 
-struct bpf_map_def SEC("maps") mim_array = {
-	.type = BPF_MAP_TYPE_ARRAY_OF_MAPS,
-	.key_size = sizeof(int),
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__uint(map_flags, 0);
+	__uint(key_size, sizeof(__u32));
 	/* must be sizeof(__u32) for map in map */
-	.value_size = sizeof(__u32),
-	.max_entries = 1,
-	.map_flags = 0,
-};
-
-struct bpf_map_def SEC("maps") mim_hash = {
-	.type = BPF_MAP_TYPE_HASH_OF_MAPS,
-	.key_size = sizeof(int),
+	__uint(value_size, sizeof(__u32));
+} mim_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, 1);
+	__uint(map_flags, 0);
+	__uint(key_size, sizeof(int));
 	/* must be sizeof(__u32) for map in map */
-	.value_size = sizeof(__u32),
-	.max_entries = 1,
-	.map_flags = 0,
-};
+	__uint(value_size, sizeof(__u32));
+} mim_hash SEC(".maps");
 
 SEC("xdp_mimtest")
 int xdp_mimtest0(struct xdp_md *ctx)
diff --git a/tools/testing/selftests/bpf/progs/test_obj_id.c b/tools/testing/selftests/bpf/progs/test_obj_id.c
index 726340fa6fe0..3d30c02bdae9 100644
--- a/tools/testing/selftests/bpf/progs/test_obj_id.c
+++ b/tools/testing/selftests/bpf/progs/test_obj_id.c
@@ -13,12 +13,12 @@
 
 int _version SEC("version") = 1;
 
-struct bpf_map_def SEC("maps") test_map_id = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(__u32),
-	.value_size = sizeof(__u64),
-	.max_entries = 1,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} test_map_id SEC(".maps");
 
 SEC("test_obj_id_dummy")
 int test_obj_id(struct __sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
index 7fa4677df22e..97175f73c3fe 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
@@ -18,19 +18,19 @@
 
 int _version SEC("version") = 1;
 
-struct bpf_map_def SEC("maps") rxcnt = {
-	.type = BPF_MAP_TYPE_PERCPU_ARRAY,
-	.key_size = sizeof(__u32),
-	.value_size = sizeof(__u64),
-	.max_entries = 256,
-};
-
-struct bpf_map_def SEC("maps") vip2tnl = {
-	.type = BPF_MAP_TYPE_HASH,
-	.key_size = sizeof(struct vip),
-	.value_size = sizeof(struct iptnl_info),
-	.max_entries = MAX_IPTNL_ENTRIES,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 256);
+	__type(key, __u32);
+	__type(value, __u64);
+} rxcnt SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, MAX_IPTNL_ENTRIES);
+	__type(key, struct vip);
+	__type(value, struct iptnl_info);
+} vip2tnl SEC(".maps");
 
 static __always_inline void count_tx(__u32 protocol)
 {
diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
index e87a985b9df9..1c5f298d7196 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
@@ -3,12 +3,12 @@
 #include <linux/bpf.h>
 #include "bpf_helpers.h"
 
-struct bpf_map_def SEC("maps") tx_port = {
-	.type = BPF_MAP_TYPE_DEVMAP,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 8,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP);
+	__uint(max_entries, 8);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} tx_port SEC(".maps");
 
 SEC("redirect_map_0")
 int xdp_redirect_map_0(struct xdp_md *xdp)
diff --git a/tools/testing/selftests/bpf/progs/xdping_kern.c b/tools/testing/selftests/bpf/progs/xdping_kern.c
index 87393e7c667c..112a2857f4e2 100644
--- a/tools/testing/selftests/bpf/progs/xdping_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdping_kern.c
@@ -17,12 +17,12 @@
 
 #include "xdping.h"
 
-struct bpf_map_def SEC("maps") ping_map = {
-	.type = BPF_MAP_TYPE_HASH,
-	.key_size = sizeof(__u32),
-	.value_size = sizeof(struct pinginfo),
-	.max_entries = 256,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 256);
+	__type(key, __u32);
+	__type(value, struct pinginfo);
+} ping_map SEC(".maps");
 
 static __always_inline void swap_src_dst_mac(void *data)
 {
diff --git a/tools/testing/selftests/bpf/test_queue_stack_map.h b/tools/testing/selftests/bpf/test_queue_stack_map.h
index 295b9b3bc5c7..0e014d3b2b36 100644
--- a/tools/testing/selftests/bpf/test_queue_stack_map.h
+++ b/tools/testing/selftests/bpf/test_queue_stack_map.h
@@ -10,21 +10,21 @@
 
 int _version SEC("version") = 1;
 
-struct bpf_map_def __attribute__ ((section("maps"), used)) map_in = {
-	.type = MAP_TYPE,
-	.key_size = 0,
-	.value_size = sizeof(__u32),
-	.max_entries = 32,
-	.map_flags = 0,
-};
-
-struct bpf_map_def __attribute__ ((section("maps"), used)) map_out = {
-	.type = MAP_TYPE,
-	.key_size = 0,
-	.value_size = sizeof(__u32),
-	.max_entries = 32,
-	.map_flags = 0,
-};
+struct {
+	__uint(type, MAP_TYPE);
+	__uint(max_entries, 32);
+	__uint(map_flags, 0);
+	__uint(key_size, 0);
+	__uint(value_size, sizeof(__u32));
+} map_in SEC(".maps");
+
+struct {
+	__uint(type, MAP_TYPE);
+	__uint(max_entries, 32);
+	__uint(map_flags, 0);
+	__uint(key_size, 0);
+	__uint(value_size, sizeof(__u32));
+} map_out SEC(".maps");
 
 SEC("test")
 int _test(struct __sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/test_sockmap_kern.h b/tools/testing/selftests/bpf/test_sockmap_kern.h
index 4e7d3da21357..d008b41b7d8d 100644
--- a/tools/testing/selftests/bpf/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/test_sockmap_kern.h
@@ -28,61 +28,61 @@
  * are established and verdicts are decided.
  */
 
-struct bpf_map_def SEC("maps") sock_map = {
-	.type = TEST_MAP_TYPE,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 20,
-};
-
-struct bpf_map_def SEC("maps") sock_map_txmsg = {
-	.type = TEST_MAP_TYPE,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 20,
-};
-
-struct bpf_map_def SEC("maps") sock_map_redir = {
-	.type = TEST_MAP_TYPE,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 20,
-};
-
-struct bpf_map_def SEC("maps") sock_apply_bytes = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 1
-};
-
-struct bpf_map_def SEC("maps") sock_cork_bytes = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 1
-};
-
-struct bpf_map_def SEC("maps") sock_bytes = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 6
-};
-
-struct bpf_map_def SEC("maps") sock_redir_flags = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 1
-};
-
-struct bpf_map_def SEC("maps") sock_skb_opts = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 1
-};
+struct {
+	__uint(type, TEST_MAP_TYPE);
+	__uint(max_entries, 20);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} sock_map SEC(".maps");
+
+struct {
+	__uint(type, TEST_MAP_TYPE);
+	__uint(max_entries, 20);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} sock_map_txmsg SEC(".maps");
+
+struct {
+	__uint(type, TEST_MAP_TYPE);
+	__uint(max_entries, 20);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} sock_map_redir SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sock_apply_bytes SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sock_cork_bytes SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 6);
+	__type(key, int);
+	__type(value, int);
+} sock_bytes SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sock_redir_flags SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sock_skb_opts SEC(".maps");
 
 SEC("sk_skb1")
 int bpf_prog1(struct __sk_buff *skb)
-- 
2.17.1

