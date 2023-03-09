Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392ED6B1AE2
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 06:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCIFkg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 9 Mar 2023 00:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCIFkc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 00:40:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A2F82367
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 21:40:28 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3293A0W1002850
        for <bpf@vger.kernel.org>; Wed, 8 Mar 2023 21:40:28 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6ffthdf3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 21:40:27 -0800
Received: from twshared13785.14.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 8 Mar 2023 21:40:27 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9FA1129AA209F; Wed,  8 Mar 2023 21:40:22 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: fix lots of silly mistakes pointed out by compiler
Date:   Wed, 8 Mar 2023 21:40:14 -0800
Message-ID: <20230309054015.4068562-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309054015.4068562-1-andrii@kernel.org>
References: <20230309054015.4068562-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 93jNzGngEHh31lPBAaC6sSxxfrOURSul
X-Proofpoint-ORIG-GUID: 93jNzGngEHh31lPBAaC6sSxxfrOURSul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_02,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Once we enable -Wall for BPF sources, compiler will complain about lots
of unused variables, variables that are set but never read, etc.

Fix all these issues first before enabling -Wall in Makefile.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/bpf_iter_ksym.c       |  1 -
 .../selftests/bpf/progs/bpf_iter_setsockopt.c |  1 -
 tools/testing/selftests/bpf/progs/bpf_loop.c  |  2 -
 tools/testing/selftests/bpf/progs/cb_refs.c   |  1 -
 .../bpf/progs/cgroup_skb_sk_lookup_kern.c     |  1 -
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  1 +
 .../bpf/progs/cgrp_ls_attach_cgroup.c         |  1 -
 .../selftests/bpf/progs/cgrp_ls_sleepable.c   |  1 -
 tools/testing/selftests/bpf/progs/core_kern.c |  2 +-
 .../selftests/bpf/progs/cpumask_failure.c     |  3 ++
 .../selftests/bpf/progs/cpumask_success.c     |  1 -
 .../testing/selftests/bpf/progs/dynptr_fail.c |  5 ++-
 .../selftests/bpf/progs/dynptr_success.c      |  5 +--
 .../selftests/bpf/progs/fexit_bpf2bpf.c       |  2 -
 .../bpf/progs/freplace_attach_probe.c         |  2 +-
 tools/testing/selftests/bpf/progs/iters.c     | 11 +++--
 .../selftests/bpf/progs/linked_funcs1.c       |  3 ++
 .../selftests/bpf/progs/linked_funcs2.c       |  3 ++
 .../testing/selftests/bpf/progs/linked_list.c |  4 --
 .../selftests/bpf/progs/linked_list_fail.c    |  1 -
 .../selftests/bpf/progs/local_storage.c       |  1 -
 tools/testing/selftests/bpf/progs/map_kptr.c  |  3 --
 .../testing/selftests/bpf/progs/netcnt_prog.c |  1 -
 .../selftests/bpf/progs/netif_receive_skb.c   |  1 -
 .../selftests/bpf/progs/perfbuf_bench.c       |  1 -
 tools/testing/selftests/bpf/progs/pyperf.h    |  2 +-
 .../progs/rbtree_btf_fail__wrong_node_type.c  | 11 -----
 .../testing/selftests/bpf/progs/rbtree_fail.c |  3 +-
 .../selftests/bpf/progs/rcu_read_lock.c       |  4 --
 .../bpf/progs/read_bpf_task_storage_busy.c    |  1 -
 .../selftests/bpf/progs/recvmsg4_prog.c       |  2 -
 .../selftests/bpf/progs/recvmsg6_prog.c       |  2 -
 .../selftests/bpf/progs/sendmsg4_prog.c       |  2 -
 .../bpf/progs/sockmap_verdict_prog.c          |  4 ++
 .../testing/selftests/bpf/progs/strobemeta.h  |  1 -
 .../selftests/bpf/progs/tailcall_bpf2bpf3.c   | 11 +++++
 .../selftests/bpf/progs/tailcall_bpf2bpf6.c   |  3 ++
 .../selftests/bpf/progs/task_kfunc_failure.c  |  1 +
 .../selftests/bpf/progs/task_kfunc_success.c  |  6 ---
 .../testing/selftests/bpf/progs/test_bpf_nf.c |  1 -
 .../bpf/progs/test_cls_redirect_dynptr.c      |  1 -
 .../progs/test_core_reloc_bitfields_probed.c  |  1 -
 .../selftests/bpf/progs/test_global_func1.c   |  4 ++
 .../selftests/bpf/progs/test_global_func2.c   |  4 ++
 .../selftests/bpf/progs/test_hash_large_key.c |  2 +-
 .../bpf/progs/test_ksyms_btf_write_check.c    |  1 -
 .../selftests/bpf/progs/test_legacy_printk.c  |  2 +-
 .../selftests/bpf/progs/test_map_lock.c       |  2 +-
 .../testing/selftests/bpf/progs/test_obj_id.c |  2 +
 .../bpf/progs/test_parse_tcp_hdr_opt.c        |  1 -
 .../bpf/progs/test_parse_tcp_hdr_opt_dynptr.c |  2 +-
 .../selftests/bpf/progs/test_pkt_access.c     |  5 +++
 .../selftests/bpf/progs/test_ringbuf.c        |  1 -
 .../bpf/progs/test_ringbuf_map_key.c          |  1 +
 .../selftests/bpf/progs/test_ringbuf_multi.c  |  1 -
 .../bpf/progs/test_select_reuseport_kern.c    |  2 +-
 .../selftests/bpf/progs/test_sk_assign.c      |  4 +-
 .../selftests/bpf/progs/test_sk_lookup.c      |  9 +---
 .../selftests/bpf/progs/test_sk_lookup_kern.c |  2 -
 .../selftests/bpf/progs/test_sock_fields.c    |  2 +-
 .../selftests/bpf/progs/test_sockmap_kern.h   | 14 ++++--
 .../selftests/bpf/progs/test_spin_lock.c      |  3 ++
 .../selftests/bpf/progs/test_tc_dtime.c       |  4 +-
 .../selftests/bpf/progs/test_tc_neigh.c       |  4 +-
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |  2 -
 .../selftests/bpf/progs/test_tunnel_kern.c    |  6 ---
 .../selftests/bpf/progs/test_usdt_multispec.c |  2 -
 .../selftests/bpf/progs/test_verif_scale1.c   |  2 +-
 .../selftests/bpf/progs/test_verif_scale2.c   |  2 +-
 .../selftests/bpf/progs/test_verif_scale3.c   |  2 +-
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |  2 -
 .../selftests/bpf/progs/test_xdp_bpf2bpf.c    |  2 -
 .../selftests/bpf/progs/test_xdp_dynptr.c     |  2 -
 .../selftests/bpf/progs/test_xdp_noinline.c   | 43 -------------------
 .../selftests/bpf/progs/test_xdp_vlan.c       | 13 ------
 tools/testing/selftests/bpf/progs/type_cast.c |  1 -
 tools/testing/selftests/bpf/progs/udp_limit.c |  2 -
 .../bpf/progs/user_ringbuf_success.c          |  6 ---
 .../selftests/bpf/progs/xdp_features.c        |  1 -
 .../testing/selftests/bpf/progs/xdping_kern.c |  2 -
 tools/testing/selftests/bpf/progs/xdpwall.c   |  1 -
 81 files changed, 90 insertions(+), 187 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
index 9ba14c37bbcc..5ddcc46fd886 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
@@ -33,7 +33,6 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
 	__u32 seq_num = ctx->meta->seq_num;
 	unsigned long value;
 	char type;
-	int ret;
 
 	if (!iter)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
index b77adfd55d73..ec7f91850dec 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
@@ -42,7 +42,6 @@ int change_tcp_cc(struct bpf_iter__tcp *ctx)
 	char cur_cc[TCP_CA_NAME_MAX];
 	struct tcp_sock *tp;
 	struct sock *sk;
-	int ret;
 
 	if (!bpf_tcp_sk(ctx->sk_common))
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/bpf_loop.c b/tools/testing/selftests/bpf/progs/bpf_loop.c
index de1fc82d2710..1d194455b109 100644
--- a/tools/testing/selftests/bpf/progs/bpf_loop.c
+++ b/tools/testing/selftests/bpf/progs/bpf_loop.c
@@ -138,8 +138,6 @@ static int callback_set_0f(int i, void *ctx)
 SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int prog_non_constant_callback(void *ctx)
 {
-	struct callback_ctx data = {};
-
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 0;
 
diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
index ce96b33e38d6..50f95ec61165 100644
--- a/tools/testing/selftests/bpf/progs/cb_refs.c
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -52,7 +52,6 @@ int leak_prog(void *ctx)
 {
 	struct prog_test_ref_kfunc *p;
 	struct map_value *v;
-	unsigned long sl;
 
 	v = bpf_map_lookup_elem(&array_map, &(int){0});
 	if (!v)
diff --git a/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
index 88638315c582..ac86a8a61605 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_skb_sk_lookup_kern.c
@@ -66,7 +66,6 @@ static inline int is_allowed_peer_cg(struct __sk_buff *skb,
 SEC("cgroup_skb/ingress")
 int ingress_lookup(struct __sk_buff *skb)
 {
-	__u32 serv_port_key = 0;
 	struct ipv6hdr ip6h;
 	struct tcphdr tcph;
 
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index b42291ed9586..807fb0ac41e9 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -109,6 +109,7 @@ int BPF_PROG(cgrp_kfunc_acquire_unreleased, struct cgroup *cgrp, const char *pat
 	acquired = bpf_cgroup_acquire(cgrp);
 
 	/* Acquired cgroup is never released. */
+	__sink(acquired);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c b/tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c
index 6652d18465b2..8aeba1b75c83 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_attach_cgroup.c
@@ -84,7 +84,6 @@ int BPF_PROG(update_cookie_tracing, struct socket *sock,
 	     struct sockaddr *uaddr, int addr_len, int flags)
 {
 	struct socket_cookie *p;
-	struct tcp_sock *tcp_sk;
 
 	if (uaddr->sa_family != AF_INET6)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
index 7615dc23d301..4c7844e1dbfa 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
@@ -24,7 +24,6 @@ void bpf_rcu_read_unlock(void) __ksym;
 SEC("?iter.s/cgroup")
 int cgroup_iter(struct bpf_iter__cgroup *ctx)
 {
-	struct seq_file *seq = ctx->meta->seq;
 	struct cgroup *cgrp = ctx->cgroup;
 	long *ptr;
 
diff --git a/tools/testing/selftests/bpf/progs/core_kern.c b/tools/testing/selftests/bpf/progs/core_kern.c
index 2715fe27d4cf..004f2acef2eb 100644
--- a/tools/testing/selftests/bpf/progs/core_kern.c
+++ b/tools/testing/selftests/bpf/progs/core_kern.c
@@ -77,7 +77,7 @@ int balancer_ingress(struct __sk_buff *ctx)
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
 	void *ptr;
-	int ret = 0, nh_off, i = 0;
+	int nh_off, i = 0;
 
 	nh_off = 14;
 
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index c16f7563b84e..cfe83f0ef9e2 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -23,6 +23,7 @@ int BPF_PROG(test_alloc_no_release, struct task_struct *task, u64 clone_flags)
 	struct bpf_cpumask *cpumask;
 
 	cpumask = create_cpumask();
+	__sink(cpumask);
 
 	/* cpumask is never released. */
 	return 0;
@@ -51,6 +52,7 @@ int BPF_PROG(test_acquire_wrong_cpumask, struct task_struct *task, u64 clone_fla
 
 	/* Can't acquire a non-struct bpf_cpumask. */
 	cpumask = bpf_cpumask_acquire((struct bpf_cpumask *)task->cpus_ptr);
+	__sink(cpumask);
 
 	return 0;
 }
@@ -63,6 +65,7 @@ int BPF_PROG(test_mutate_cpumask, struct task_struct *task, u64 clone_flags)
 
 	/* Can't set the CPU of a non-struct bpf_cpumask. */
 	bpf_cpumask_set_cpu(0, (struct bpf_cpumask *)task->cpus_ptr);
+	__sink(cpumask);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 1d38bc65d4b0..97ed08c4ff03 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -353,7 +353,6 @@ SEC("tp_btf/task_newtask")
 int BPF_PROG(test_insert_leave, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
-	struct __cpumask_map_value *v;
 
 	cpumask = create_cpumask();
 	if (!cpumask)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 20ce920d891d..759eb5c245cd 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -271,7 +271,7 @@ SEC("?raw_tp")
 __failure __msg("value is outside of the allowed memory range")
 int data_slice_out_of_bounds_map_value(void *ctx)
 {
-	__u32 key = 0, map_val;
+	__u32 map_val;
 	struct bpf_dynptr ptr;
 	void *data;
 
@@ -388,7 +388,6 @@ int data_slice_missing_null_check2(void *ctx)
 		/* this should fail */
 		*data2 = 3;
 
-done:
 	bpf_ringbuf_discard_dynptr(&ptr, 0);
 	return 0;
 }
@@ -440,6 +439,7 @@ int invalid_write1(void *ctx)
 
 	/* this should fail */
 	data = bpf_dynptr_data(&ptr, 0, 1);
+	__sink(data);
 
 	return 0;
 }
@@ -1374,6 +1374,7 @@ int invalid_slice_rdwr_rdonly(struct __sk_buff *skb)
 	 * changing packet data
 	 */
 	hdr = bpf_dynptr_slice_rdwr(&ptr, 0, buffer, sizeof(buffer));
+	__sink(hdr);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index c8358a7c7924..b2fa6c47ecc0 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -35,7 +35,7 @@ SEC("?tp/syscalls/sys_enter_nanosleep")
 int test_read_write(void *ctx)
 {
 	char write_data[64] = "hello there, world!!";
-	char read_data[64] = {}, buf[64] = {};
+	char read_data[64] = {};
 	struct bpf_dynptr ptr;
 	int i;
 
@@ -170,7 +170,6 @@ int test_skb_readonly(struct __sk_buff *skb)
 {
 	__u8 write_data[2] = {1, 2};
 	struct bpf_dynptr ptr;
-	__u64 *data;
 	int ret;
 
 	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
@@ -191,10 +190,8 @@ int test_skb_readonly(struct __sk_buff *skb)
 SEC("?cgroup_skb/egress")
 int test_dynptr_skb_data(struct __sk_buff *skb)
 {
-	__u8 write_data[2] = {1, 2};
 	struct bpf_dynptr ptr;
 	__u64 *data;
-	int ret;
 
 	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
 		err = 1;
diff --git a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
index 4547b059d487..983b7c233382 100644
--- a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
@@ -120,8 +120,6 @@ int new_get_skb_ifindex(int val, struct __sk_buff *skb, int var)
 	void *data = (void *)(long)skb->data;
 	struct ipv6hdr ip6, *ip6p;
 	int ifindex = skb->ifindex;
-	__u32 eth_proto;
-	__u32 nh_off;
 
 	/* check that BPF extension can read packet via direct packet access */
 	if (data + 14 + sizeof(ip6) > data_end)
diff --git a/tools/testing/selftests/bpf/progs/freplace_attach_probe.c b/tools/testing/selftests/bpf/progs/freplace_attach_probe.c
index bb2a77c5b62b..370a0e1922e0 100644
--- a/tools/testing/selftests/bpf/progs/freplace_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/freplace_attach_probe.c
@@ -23,7 +23,7 @@ struct {
 SEC("freplace/handle_kprobe")
 int new_handle_kprobe(struct pt_regs *ctx)
 {
-	struct hmap_elem zero = {}, *val;
+	struct hmap_elem *val;
 	int key = 0;
 
 	val = bpf_map_lookup_elem(&hash_map, &key);
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 84e5dc10243c..6b9b3c56f009 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -45,7 +45,6 @@ __failure __msg("unbounded memory access")
 int iter_err_unsafe_asm_loop(const void *ctx)
 {
 	struct bpf_iter_num it;
-	int *v, i = 0;
 
 	MY_PID_GUARD();
 
@@ -88,7 +87,7 @@ __success
 int iter_while_loop(const void *ctx)
 {
 	struct bpf_iter_num it;
-	int *v, i;
+	int *v;
 
 	MY_PID_GUARD();
 
@@ -106,7 +105,7 @@ __success
 int iter_while_loop_auto_cleanup(const void *ctx)
 {
 	__attribute__((cleanup(bpf_iter_num_destroy))) struct bpf_iter_num it;
-	int *v, i;
+	int *v;
 
 	MY_PID_GUARD();
 
@@ -124,7 +123,7 @@ __success
 int iter_for_loop(const void *ctx)
 {
 	struct bpf_iter_num it;
-	int *v, i;
+	int *v;
 
 	MY_PID_GUARD();
 
@@ -192,7 +191,7 @@ __success
 int iter_manual_unroll_loop(const void *ctx)
 {
 	struct bpf_iter_num it;
-	int *v, i;
+	int *v;
 
 	MY_PID_GUARD();
 
@@ -621,7 +620,7 @@ __success
 int iter_stack_array_loop(const void *ctx)
 {
 	long arr1[16], arr2[16], sum = 0;
-	int *v, i;
+	int i;
 
 	MY_PID_GUARD();
 
diff --git a/tools/testing/selftests/bpf/progs/linked_funcs1.c b/tools/testing/selftests/bpf/progs/linked_funcs1.c
index b05571bc67d5..c4b49ceea967 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs1.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs1.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
 
 /* weak and shared between two files */
 const volatile int my_tid __weak;
@@ -51,6 +52,7 @@ __weak int set_output_weak(int x)
 	 * cause problems for BPF static linker
 	 */
 	whatever = bpf_core_type_size(struct task_struct);
+	__sink(whatever);
 
 	output_weak1 = x;
 	return x;
@@ -71,6 +73,7 @@ int BPF_PROG(handler1, struct pt_regs *regs, long id)
 
 	/* make sure we have CO-RE relocations in main program */
 	whatever = bpf_core_type_size(struct task_struct);
+	__sink(whatever);
 
 	set_output_val2(1000);
 	set_output_ctx2(ctx); /* ctx definition is hidden in BPF_PROG macro */
diff --git a/tools/testing/selftests/bpf/progs/linked_funcs2.c b/tools/testing/selftests/bpf/progs/linked_funcs2.c
index ee7e3848ee4f..013ff0645f0c 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs2.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs2.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
 
 /* weak and shared between both files */
 const volatile int my_tid __weak;
@@ -51,6 +52,7 @@ __weak int set_output_weak(int x)
 	 * cause problems for BPF static linker
 	 */
 	whatever = 2 * bpf_core_type_size(struct task_struct);
+	__sink(whatever);
 
 	output_weak2 = x;
 	return 2 * x;
@@ -71,6 +73,7 @@ int BPF_PROG(handler2, struct pt_regs *regs, long id)
 
 	/* make sure we have CO-RE relocations in main program */
 	whatever = bpf_core_type_size(struct task_struct);
+	__sink(whatever);
 
 	set_output_val1(2000);
 	set_output_ctx1(ctx); /* ctx definition is hidden in BPF_PROG macro */
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 4fa4a9b01bde..53ded51a3abb 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -313,7 +313,6 @@ SEC("tc")
 int map_list_push_pop_multiple(void *ctx)
 {
 	struct map_value *v;
-	int ret;
 
 	v = bpf_map_lookup_elem(&array_map, &(int){0});
 	if (!v)
@@ -326,7 +325,6 @@ int inner_map_list_push_pop_multiple(void *ctx)
 {
 	struct map_value *v;
 	void *map;
-	int ret;
 
 	map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
 	if (!map)
@@ -352,7 +350,6 @@ SEC("tc")
 int map_list_in_list(void *ctx)
 {
 	struct map_value *v;
-	int ret;
 
 	v = bpf_map_lookup_elem(&array_map, &(int){0});
 	if (!v)
@@ -365,7 +362,6 @@ int inner_map_list_in_list(void *ctx)
 {
 	struct map_value *v;
 	void *map;
-	int ret;
 
 	map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
 	if (!map)
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index 69cdc07cba13..41978b46f58e 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -557,7 +557,6 @@ SEC("?tc")
 int incorrect_head_off2(void *ctx)
 {
 	struct foo *f;
-	struct bar *b;
 
 	f = bpf_obj_new(typeof(*f));
 	if (!f)
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 19423ed862e3..01c74bc870ae 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -77,7 +77,6 @@ int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
 	     struct inode *new_dir, struct dentry *new_dentry,
 	     unsigned int flags)
 {
-	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct local_storage *storage;
 	int err;
 
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index 3903d30217b8..dae5dab1bbf7 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -515,7 +515,6 @@ int test_ls_map_kptr_ref1(void *ctx)
 {
 	struct task_struct *current;
 	struct map_value *v;
-	int ret;
 
 	current = bpf_get_current_task_btf();
 	if (!current)
@@ -534,7 +533,6 @@ int test_ls_map_kptr_ref2(void *ctx)
 {
 	struct task_struct *current;
 	struct map_value *v;
-	int ret;
 
 	current = bpf_get_current_task_btf();
 	if (!current)
@@ -550,7 +548,6 @@ int test_ls_map_kptr_ref_del(void *ctx)
 {
 	struct task_struct *current;
 	struct map_value *v;
-	int ret;
 
 	current = bpf_get_current_task_btf();
 	if (!current)
diff --git a/tools/testing/selftests/bpf/progs/netcnt_prog.c b/tools/testing/selftests/bpf/progs/netcnt_prog.c
index f718b2c212dc..f9ef8aee56f1 100644
--- a/tools/testing/selftests/bpf/progs/netcnt_prog.c
+++ b/tools/testing/selftests/bpf/progs/netcnt_prog.c
@@ -26,7 +26,6 @@ SEC("cgroup/skb")
 int bpf_nextcnt(struct __sk_buff *skb)
 {
 	union percpu_net_cnt *percpu_cnt;
-	char fmt[] = "%d %llu %llu\n";
 	union net_cnt *cnt;
 	__u64 ts, dt;
 	int ret;
diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index 1d8918dfbd3f..c0062645fc68 100644
--- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
+++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
@@ -53,7 +53,6 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
 	do {								\
 		static const char _expectedval[EXPECTED_STRSIZE] =	\
 							_expected;	\
-		static const char _ptrtype[64] = #_type;		\
 		__u64 _hflags = _flags | BTF_F_COMPACT;			\
 		static _type _ptrdata = __VA_ARGS__;			\
 		static struct btf_ptr _ptr = { };			\
diff --git a/tools/testing/selftests/bpf/progs/perfbuf_bench.c b/tools/testing/selftests/bpf/progs/perfbuf_bench.c
index 45204fe0c570..29c1639fc78a 100644
--- a/tools/testing/selftests/bpf/progs/perfbuf_bench.c
+++ b/tools/testing/selftests/bpf/progs/perfbuf_bench.c
@@ -22,7 +22,6 @@ long dropped __attribute__((aligned(128))) = 0;
 SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int bench_perfbuf(void *ctx)
 {
-	__u64 *sample;
 	int i;
 
 	for (i = 0; i < batch_cnt; i++) {
diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
index f2e7a31c8d75..026d573ce179 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -345,7 +345,7 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 SEC("raw_tracepoint/kfree_skb")
 int on_event(struct bpf_raw_tracepoint_args* ctx)
 {
-	int i, ret = 0;
+	int ret = 0;
 	ret |= __on_event(ctx);
 	ret |= __on_event(ctx);
 	ret |= __on_event(ctx);
diff --git a/tools/testing/selftests/bpf/progs/rbtree_btf_fail__wrong_node_type.c b/tools/testing/selftests/bpf/progs/rbtree_btf_fail__wrong_node_type.c
index 340f97da1084..7651843f5a80 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_btf_fail__wrong_node_type.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_btf_fail__wrong_node_type.c
@@ -16,17 +16,6 @@ struct node_data {
 	struct bpf_list_node node;
 };
 
-static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
-{
-	struct node_data *node_a;
-	struct node_data *node_b;
-
-	node_a = container_of(a, struct node_data, node);
-	node_b = container_of(b, struct node_data, node);
-
-	return node_a->key < node_b->key;
-}
-
 #define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
 private(A) struct bpf_spin_lock glock;
 private(A) struct bpf_rb_root groot __contains(node_data, node);
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 1ced900f3fce..46d7d18a218f 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=2 alloc_insn=11")
+__failure __msg("Unreleased reference id=2 alloc_insn=10")
 long rbtree_api_remove_no_drop(void *ctx)
 {
 	struct bpf_rb_node *res;
@@ -119,6 +119,7 @@ long rbtree_api_remove_no_drop(void *ctx)
 	res = bpf_rbtree_remove(&groot, res);
 
 	n = container_of(res, struct node_data, node);
+	__sink(n);
 	bpf_spin_unlock(&glock);
 
 	/* bpf_obj_drop(n) is missing here */
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index 7250bb76d18a..6a8c88e58df2 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -179,8 +179,6 @@ SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 int miss_lock(void *ctx)
 {
 	struct task_struct *task;
-	struct css_set *cgroups;
-	struct cgroup *dfl_cgrp;
 
 	/* missing bpf_rcu_read_lock() */
 	task = bpf_get_current_task_btf();
@@ -195,8 +193,6 @@ SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 int miss_unlock(void *ctx)
 {
 	struct task_struct *task;
-	struct css_set *cgroups;
-	struct cgroup *dfl_cgrp;
 
 	/* missing bpf_rcu_read_unlock() */
 	task = bpf_get_current_task_btf();
diff --git a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c b/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
index a47bb0120719..76556e0b42b2 100644
--- a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
+++ b/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
@@ -23,7 +23,6 @@ SEC("raw_tp/sys_enter")
 int BPF_PROG(read_bpf_task_storage_busy)
 {
 	int *value;
-	int key;
 
 	if (!CONFIG_PREEMPT)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/recvmsg4_prog.c b/tools/testing/selftests/bpf/progs/recvmsg4_prog.c
index 3d1ae8b3402f..59748c95471a 100644
--- a/tools/testing/selftests/bpf/progs/recvmsg4_prog.c
+++ b/tools/testing/selftests/bpf/progs/recvmsg4_prog.c
@@ -17,8 +17,6 @@ SEC("cgroup/recvmsg4")
 int recvmsg4_prog(struct bpf_sock_addr *ctx)
 {
 	struct bpf_sock *sk;
-	__u32 user_ip4;
-	__u16 user_port;
 
 	sk = ctx->sk;
 	if (!sk)
diff --git a/tools/testing/selftests/bpf/progs/recvmsg6_prog.c b/tools/testing/selftests/bpf/progs/recvmsg6_prog.c
index 27dfb21b21b4..d9a4016596d5 100644
--- a/tools/testing/selftests/bpf/progs/recvmsg6_prog.c
+++ b/tools/testing/selftests/bpf/progs/recvmsg6_prog.c
@@ -20,8 +20,6 @@ SEC("cgroup/recvmsg6")
 int recvmsg6_prog(struct bpf_sock_addr *ctx)
 {
 	struct bpf_sock *sk;
-	__u32 user_ip4;
-	__u16 user_port;
 
 	sk = ctx->sk;
 	if (!sk)
diff --git a/tools/testing/selftests/bpf/progs/sendmsg4_prog.c b/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
index ea75a44cb7fc..351e79aef2fa 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg4_prog.c
@@ -21,8 +21,6 @@
 SEC("cgroup/sendmsg4")
 int sendmsg_v4_prog(struct bpf_sock_addr *ctx)
 {
-	int prio;
-
 	if (ctx->type != SOCK_DGRAM)
 		return 0;
 
diff --git a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
index e2468a6d01a5..0660f29dca95 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
@@ -1,6 +1,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include "bpf_misc.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
@@ -40,6 +41,9 @@ int bpf_prog2(struct __sk_buff *skb)
 	__u8 *d = data;
 	__u8 sk, map;
 
+	__sink(lport);
+	__sink(rport);
+
 	if (data + 8 > data_end)
 		return SK_DROP;
 
diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index e562be6356f3..e02cfd380746 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -391,7 +391,6 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 	struct strobe_map_raw map;
 	void *location;
 	uint64_t len;
-	int i;
 
 	descr->tag_len = 0; /* presume no tag is set */
 	descr->cnt = -1; /* presume no value is set */
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
index 7fab39a3bb12..99c8d1d8a187 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
@@ -2,6 +2,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_legacy.h"
+#include "bpf_misc.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
@@ -20,6 +21,8 @@ int subprog_tail2(struct __sk_buff *skb)
 	else
 		bpf_tail_call_static(skb, &jmp_table, 1);
 
+	__sink(arr[sizeof(arr) - 1]);
+
 	return skb->len;
 }
 
@@ -30,6 +33,8 @@ int subprog_tail(struct __sk_buff *skb)
 
 	bpf_tail_call_static(skb, &jmp_table, 0);
 
+	__sink(arr[sizeof(arr) - 1]);
+
 	return skb->len * 2;
 }
 
@@ -38,6 +43,8 @@ int classifier_0(struct __sk_buff *skb)
 {
 	volatile char arr[128] = {};
 
+	__sink(arr[sizeof(arr) - 1]);
+
 	return subprog_tail2(skb);
 }
 
@@ -46,6 +53,8 @@ int classifier_1(struct __sk_buff *skb)
 {
 	volatile char arr[128] = {};
 
+	__sink(arr[sizeof(arr) - 1]);
+
 	return skb->len * 3;
 }
 
@@ -54,6 +63,8 @@ int entry(struct __sk_buff *skb)
 {
 	volatile char arr[128] = {};
 
+	__sink(arr[sizeof(arr) - 1]);
+
 	return subprog_tail(skb);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
index 41ce83da78e8..4a9f63bea66c 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 #define __unused __attribute__((unused))
 
@@ -36,6 +37,8 @@ int entry(struct __sk_buff *skb)
 	/* Have data on stack which size is not a multiple of 8 */
 	volatile char arr[1] = {};
 
+	__sink(arr[0]);
+
 	return subprog_tail(skb);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index f19d54eda4f1..002c7f69e47f 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -109,6 +109,7 @@ int BPF_PROG(task_kfunc_acquire_unreleased, struct task_struct *task, u64 clone_
 	acquired = bpf_task_acquire(task);
 
 	/* Acquired task is never released. */
+	__sink(acquired);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index 9f359cfd29e7..aebc4bb14e7d 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -171,8 +171,6 @@ static void lookup_compare_pid(const struct task_struct *p)
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_task_from_pid_arg, struct task_struct *task, u64 clone_flags)
 {
-	struct task_struct *acquired;
-
 	if (!is_test_kfunc_task())
 		return 0;
 
@@ -183,8 +181,6 @@ int BPF_PROG(test_task_from_pid_arg, struct task_struct *task, u64 clone_flags)
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_task_from_pid_current, struct task_struct *task, u64 clone_flags)
 {
-	struct task_struct *current, *acquired;
-
 	if (!is_test_kfunc_task())
 		return 0;
 
@@ -208,8 +204,6 @@ static int is_pid_lookup_valid(s32 pid)
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_task_from_pid_invalid, struct task_struct *task, u64 clone_flags)
 {
-	struct task_struct *acquired;
-
 	if (!is_test_kfunc_task())
 		return 0;
 
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 9fc603c9d673..77ad8adf68da 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -75,7 +75,6 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 	struct bpf_ct_opts___local opts_def = { .l4proto = IPPROTO_TCP, .netns_id = -1 };
 	struct bpf_sock_tuple bpf_tuple;
 	struct nf_conn *ct;
-	int err;
 
 	__builtin_memset(&bpf_tuple, 0, sizeof(bpf_tuple.ipv4));
 
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
index f45a7095de7a..f41c81212ee9 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
@@ -455,7 +455,6 @@ static ret_t forward_to_next_hop(struct __sk_buff *skb, struct bpf_dynptr *dynpt
 
 static ret_t skip_next_hops(__u64 *offset, int n)
 {
-	__u32 res;
 	switch (n) {
 	case 1:
 		*offset += sizeof(struct in_addr);
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_bitfields_probed.c b/tools/testing/selftests/bpf/progs/test_core_reloc_bitfields_probed.c
index ab1e647aeb31..b86fdda2a6ea 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_bitfields_probed.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_bitfields_probed.c
@@ -42,7 +42,6 @@ int test_core_bitfields(void *ctx)
 {
 	struct core_reloc_bitfields *in = (void *)&data.in;
 	struct core_reloc_bitfields_output *out = (void *)&data.out;
-	uint64_t res;
 
 	out->ub1 = BPF_CORE_READ_BITFIELD_PROBED(in, ub1);
 	out->ub2 = BPF_CORE_READ_BITFIELD_PROBED(in, ub2);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c b/tools/testing/selftests/bpf/progs/test_global_func1.c
index 23970a20b324..b85fc8c423ba 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func1.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
@@ -18,6 +18,8 @@ int f1(struct __sk_buff *skb)
 {
 	volatile char buf[MAX_STACK] = {};
 
+	__sink(buf[MAX_STACK - 1]);
+
 	return f0(0, skb) + skb->len;
 }
 
@@ -34,6 +36,8 @@ int f3(int val, struct __sk_buff *skb, int var)
 {
 	volatile char buf[MAX_STACK] = {};
 
+	__sink(buf[MAX_STACK - 1]);
+
 	return skb->ifindex * val * var;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func2.c b/tools/testing/selftests/bpf/progs/test_global_func2.c
index 3dce97fb52a4..2beab9c3b68a 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func2.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func2.c
@@ -18,6 +18,8 @@ int f1(struct __sk_buff *skb)
 {
 	volatile char buf[MAX_STACK] = {};
 
+	__sink(buf[MAX_STACK - 1]);
+
 	return f0(0, skb) + skb->len;
 }
 
@@ -34,6 +36,8 @@ int f3(int val, struct __sk_buff *skb, int var)
 {
 	volatile char buf[MAX_STACK] = {};
 
+	__sink(buf[MAX_STACK - 1]);
+
 	return skb->ifindex * val * var;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_hash_large_key.c b/tools/testing/selftests/bpf/progs/test_hash_large_key.c
index 473a22794a62..8b438128f46b 100644
--- a/tools/testing/selftests/bpf/progs/test_hash_large_key.c
+++ b/tools/testing/selftests/bpf/progs/test_hash_large_key.c
@@ -28,7 +28,7 @@ struct bigelement {
 SEC("raw_tracepoint/sys_enter")
 int bpf_hash_large_key_test(void *ctx)
 {
-	int zero = 0, err = 1, value = 42;
+	int zero = 0, value = 42;
 	struct bigelement *key;
 
 	key = bpf_map_lookup_elem(&key_map, &zero);
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
index a72a5bf3812a..27109b877714 100644
--- a/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
@@ -35,7 +35,6 @@ SEC("raw_tp/sys_enter")
 int handler2(const void *ctx)
 {
 	int *active;
-	__u32 cpu;
 
 	active = bpf_this_cpu_ptr(&bpf_prog_active);
 	write_active(active);
diff --git a/tools/testing/selftests/bpf/progs/test_legacy_printk.c b/tools/testing/selftests/bpf/progs/test_legacy_printk.c
index 64c2d9ced529..42718cd8e6a4 100644
--- a/tools/testing/selftests/bpf/progs/test_legacy_printk.c
+++ b/tools/testing/selftests/bpf/progs/test_legacy_printk.c
@@ -56,7 +56,7 @@ int handle_legacy(void *ctx)
 SEC("tp/raw_syscalls/sys_enter")
 int handle_modern(void *ctx)
 {
-	int zero = 0, cur_pid;
+	int cur_pid;
 
 	cur_pid = bpf_get_current_pid_tgid() >> 32;
 	if (cur_pid != my_pid_var)
diff --git a/tools/testing/selftests/bpf/progs/test_map_lock.c b/tools/testing/selftests/bpf/progs/test_map_lock.c
index acf073db9e8b..1c02511b73cd 100644
--- a/tools/testing/selftests/bpf/progs/test_map_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_map_lock.c
@@ -33,7 +33,7 @@ struct {
 SEC("cgroup/skb")
 int bpf_map_lock_test(struct __sk_buff *skb)
 {
-	struct hmap_elem zero = {}, *val;
+	struct hmap_elem *val;
 	int rnd = bpf_get_prandom_u32();
 	int key = 0, err = 1, i;
 	struct array_elem *q;
diff --git a/tools/testing/selftests/bpf/progs/test_obj_id.c b/tools/testing/selftests/bpf/progs/test_obj_id.c
index ded71b3ff6b4..2850ae788a91 100644
--- a/tools/testing/selftests/bpf/progs/test_obj_id.c
+++ b/tools/testing/selftests/bpf/progs/test_obj_id.c
@@ -4,6 +4,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -19,6 +20,7 @@ int test_obj_id(void *ctx)
 	__u64 *value;
 
 	value = bpf_map_lookup_elem(&test_map_id, &key);
+	__sink(value);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
index 79bab9b50e9e..d9b2ba7ac340 100644
--- a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
+++ b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
@@ -87,7 +87,6 @@ int xdp_ingress_v6(struct xdp_md *xdp)
 	__u8 tcp_hdr_opt_len = 0;
 	struct tcphdr *tcp_hdr;
 	__u64 tcp_offset = 0;
-	__u32 off;
 	int err;
 
 	tcp_offset = sizeof(struct ethhdr) + sizeof(struct ipv6hdr);
diff --git a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
index d3b319722e30..dc6e43bc6a62 100644
--- a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c
@@ -30,7 +30,7 @@ __u32 server_id;
 static int parse_hdr_opt(struct bpf_dynptr *ptr, __u32 *off, __u8 *hdr_bytes_remaining,
 			 __u32 *server_id)
 {
-	__u8 *tcp_opt, kind, hdr_len;
+	__u8 kind, hdr_len;
 	__u8 buffer[sizeof(kind) + sizeof(hdr_len) + sizeof(*server_id)];
 	__u8 *data;
 
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index 5cd7c096f62d..bce7173152c6 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -13,6 +13,7 @@
 #include <linux/pkt_cls.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include "bpf_misc.h"
 
 /* llvm will optimize both subprograms into exactly the same BPF assembly
  *
@@ -51,6 +52,8 @@ int get_skb_len(struct __sk_buff *skb)
 {
 	volatile char buf[MAX_STACK] = {};
 
+	__sink(buf[MAX_STACK - 1]);
+
 	return skb->len;
 }
 
@@ -73,6 +76,8 @@ int get_skb_ifindex(int val, struct __sk_buff *skb, int var)
 {
 	volatile char buf[MAX_STACK] = {};
 
+	__sink(buf[MAX_STACK - 1]);
+
 	return skb->ifindex * val * var;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf.c b/tools/testing/selftests/bpf/progs/test_ringbuf.c
index 5bdc0d38efc0..501cefa97633 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf.c
@@ -41,7 +41,6 @@ int test_ringbuf(void *ctx)
 {
 	int cur_pid = bpf_get_current_pid_tgid() >> 32;
 	struct sample *sample;
-	int zero = 0;
 
 	if (cur_pid != pid)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
index 2760bf60d05a..21bb7da90ea5 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
@@ -53,6 +53,7 @@ int test_ringbuf_mem_map_key(void *ctx)
 	/* test using 'sample' (PTR_TO_MEM | MEM_ALLOC) as map key arg
 	 */
 	lookup_val = (int *)bpf_map_lookup_elem(&hash_map, sample);
+	__sink(lookup_val);
 
 	/* workaround - memcpy is necessary so that verifier doesn't
 	 * complain with:
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
index e416e0ce12b7..9626baa6779c 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
@@ -59,7 +59,6 @@ int test_ringbuf(void *ctx)
 	int cur_pid = bpf_get_current_pid_tgid() >> 32;
 	struct sample *sample;
 	void *rb;
-	int zero = 0;
 
 	if (cur_pid != pid)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
index 7d56ed47cd4d..5eb25c6ad75b 100644
--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -64,7 +64,7 @@ SEC("sk_reuseport")
 int _select_by_skb_data(struct sk_reuseport_md *reuse_md)
 {
 	__u32 linum, index = 0, flags = 0, index_zero = 0;
-	__u32 *result_cnt, *linum_value;
+	__u32 *result_cnt;
 	struct data_check data_check = {};
 	struct cmd *cmd, cmd_copy;
 	void *data, *data_end;
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 21b19b758c4e..3079244c7f96 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -15,6 +15,7 @@
 #include <sys/socket.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include "bpf_misc.h"
 
 #if defined(IPROUTE2_HAVE_LIBBPF)
 /* Use a new-style map definition. */
@@ -57,7 +58,6 @@ get_tuple(struct __sk_buff *skb, bool *ipv4, bool *tcp)
 	void *data = (void *)(long)skb->data;
 	struct bpf_sock_tuple *result;
 	struct ethhdr *eth;
-	__u64 tuple_len;
 	__u8 proto = 0;
 	__u64 ihl_len;
 
@@ -94,6 +94,7 @@ get_tuple(struct __sk_buff *skb, bool *ipv4, bool *tcp)
 		return NULL;
 
 	*tcp = (proto == IPPROTO_TCP);
+	__sink(ihl_len);
 	return result;
 }
 
@@ -173,7 +174,6 @@ int bpf_sk_assign_test(struct __sk_buff *skb)
 	struct bpf_sock_tuple *tuple;
 	bool ipv4 = false;
 	bool tcp = false;
-	int tuple_len;
 	int ret = 0;
 
 	tuple = get_tuple(skb, &ipv4, &tcp);
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index 6058dcb11b36..71f844b9b902 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -391,7 +391,6 @@ SEC("sk_lookup")
 int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
-	int err, family;
 	__u32 val_u32;
 	bool v4;
 
@@ -645,9 +644,7 @@ static __always_inline int select_server_a(struct bpf_sk_lookup *ctx)
 SEC("sk_lookup")
 int multi_prog_redir1(struct bpf_sk_lookup *ctx)
 {
-	int ret;
-
-	ret = select_server_a(ctx);
+	(void)select_server_a(ctx);
 	bpf_map_update_elem(&run_map, &KEY_PROG1, &PROG_DONE, BPF_ANY);
 	return SK_PASS;
 }
@@ -655,9 +652,7 @@ int multi_prog_redir1(struct bpf_sk_lookup *ctx)
 SEC("sk_lookup")
 int multi_prog_redir2(struct bpf_sk_lookup *ctx)
 {
-	int ret;
-
-	ret = select_server_a(ctx);
+	(void)select_server_a(ctx);
 	bpf_map_update_elem(&run_map, &KEY_PROG2, &PROG_DONE, BPF_ANY);
 	return SK_PASS;
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
index 6ccf6d546074..e9efc3263022 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
@@ -110,7 +110,6 @@ int err_modify_sk_pointer(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
 	struct bpf_sock *sk;
-	__u32 family;
 
 	sk = bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple), BPF_F_CURRENT_NETNS, 0);
 	if (sk) {
@@ -125,7 +124,6 @@ int err_modify_sk_or_null_pointer(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
 	struct bpf_sock *sk;
-	__u32 family;
 
 	sk = bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple), BPF_F_CURRENT_NETNS, 0);
 	sk += 1;
diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
index 9f4b8f9f1181..bbad3c2d9aa5 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -121,7 +121,7 @@ static void tpcpy(struct bpf_tcp_sock *dst,
 SEC("cgroup_skb/egress")
 int egress_read_sock_fields(struct __sk_buff *skb)
 {
-	struct bpf_spinlock_cnt cli_cnt_init = { .lock = 0, .cnt = 0xeB9F };
+	struct bpf_spinlock_cnt cli_cnt_init = { .lock = {}, .cnt = 0xeB9F };
 	struct bpf_spinlock_cnt *pkt_out_cnt, *pkt_out_cnt10;
 	struct bpf_tcp_sock *tp, *tp_ret;
 	struct bpf_sock *sk, *sk_ret;
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
index 6c85b00f27b2..baf9ebc6d903 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
@@ -14,6 +14,7 @@
 #include <sys/socket.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include "bpf_misc.h"
 
 /* Sockmap sample program connects a client and a backend together
  * using cgroups.
@@ -111,12 +112,15 @@ int bpf_prog2(struct __sk_buff *skb)
 	int len, *f, ret, zero = 0;
 	__u64 flags = 0;
 
+	__sink(rport);
 	if (lport == 10000)
 		ret = 10;
 	else
 		ret = 1;
 
 	len = (__u32)skb->data_end - (__u32)skb->data;
+	__sink(len);
+
 	f = bpf_map_lookup_elem(&sock_skb_opts, &zero);
 	if (f && *f) {
 		ret = 3;
@@ -180,7 +184,6 @@ int bpf_prog3(struct __sk_buff *skb)
 	if (err)
 		return SK_DROP;
 	bpf_write_pass(skb, 13);
-tls_out:
 	return ret;
 }
 
@@ -188,8 +191,7 @@ SEC("sockops")
 int bpf_sockmap(struct bpf_sock_ops *skops)
 {
 	__u32 lport, rport;
-	int op, err = 0, index, key, ret;
-
+	int op, err, ret;
 
 	op = (int) skops->op;
 
@@ -228,6 +230,8 @@ int bpf_sockmap(struct bpf_sock_ops *skops)
 		break;
 	}
 
+	__sink(err);
+
 	return 0;
 }
 
@@ -321,6 +325,10 @@ int bpf_prog8(struct sk_msg_md *msg)
 	} else {
 		return SK_DROP;
 	}
+
+	__sink(data_end);
+	__sink(data);
+
 	return SK_PASS;
 }
 SEC("sk_msg4")
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock.c b/tools/testing/selftests/bpf/progs/test_spin_lock.c
index 5bd10409285b..b2440a0ff422 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock.c
@@ -3,6 +3,7 @@
 #include <linux/bpf.h>
 #include <linux/version.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct hmap_elem {
 	volatile int cnt;
@@ -89,6 +90,8 @@ int bpf_spin_lock_test(struct __sk_buff *skb)
 	credit = q->credit;
 	bpf_spin_unlock(&q->lock);
 
+	__sink(credit);
+
 	/* spin_lock in cgroup local storage */
 	cls = bpf_get_local_storage(&cls_map, 0);
 	bpf_spin_lock(&cls->lock);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_dtime.c b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
index 125beec31834..74ec09f040b7 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_dtime.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
@@ -163,9 +163,9 @@ static int skb_get_type(struct __sk_buff *skb)
 		ip6h = data + sizeof(struct ethhdr);
 		if (ip6h + 1 > data_end)
 			return -1;
-		if (v6_equal(ip6h->saddr, (struct in6_addr)ip6_src))
+		if (v6_equal(ip6h->saddr, (struct in6_addr){{ip6_src}}))
 			ns = SRC_NS;
-		else if (v6_equal(ip6h->saddr, (struct in6_addr)ip6_dst))
+		else if (v6_equal(ip6h->saddr, (struct in6_addr){{ip6_dst}}))
 			ns = DST_NS;
 		inet_proto = ip6h->nexthdr;
 		trans = ip6h + 1;
diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh.c b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
index 3e32ea375ab4..de15155f2609 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_neigh.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
@@ -94,7 +94,7 @@ int tc_dst(struct __sk_buff *skb)
 		redirect = is_remote_ep_v4(skb, __bpf_constant_htonl(ip4_src));
 		break;
 	case __bpf_constant_htons(ETH_P_IPV6):
-		redirect = is_remote_ep_v6(skb, (struct in6_addr)ip6_src);
+		redirect = is_remote_ep_v6(skb, (struct in6_addr){{ip6_src}});
 		break;
 	}
 
@@ -119,7 +119,7 @@ int tc_src(struct __sk_buff *skb)
 		redirect = is_remote_ep_v4(skb, __bpf_constant_htonl(ip4_dst));
 		break;
 	case __bpf_constant_htons(ETH_P_IPV6):
-		redirect = is_remote_ep_v6(skb, (struct in6_addr)ip6_dst);
+		redirect = is_remote_ep_v6(skb, (struct in6_addr){{ip6_dst}});
 		break;
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index 3ded05280757..cf7ed8cbb1fe 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -46,8 +46,6 @@ int bpf_testcb(struct bpf_sock_ops *skops)
 	struct bpf_sock_ops *reuse = skops;
 	struct tcphdr *thdr;
 	int window_clamp = 9216;
-	int good_call_rv = 0;
-	int bad_call_rv = 0;
 	int save_syn = 1;
 	int rv = -1;
 	int v = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 95b4aa0928ba..9ab2d55ab7c0 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -209,7 +209,6 @@ int erspan_get_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
 	struct erspan_metadata md;
-	__u32 index;
 	int ret;
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
@@ -289,7 +288,6 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key;
 	struct erspan_metadata md;
-	__u32 index;
 	int ret;
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
@@ -405,8 +403,6 @@ int vxlan_get_tunnel_src(struct __sk_buff *skb)
 	int ret;
 	struct bpf_tunnel_key key;
 	struct vxlan_metadata md;
-	__u32 orig_daddr;
-	__u32 index = 0;
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_FLAGS);
@@ -443,9 +439,7 @@ int veth_set_outer_dst(struct __sk_buff *skb)
 	void *data_end = (void *)(long)skb->data_end;
 	struct udphdr *udph;
 	struct iphdr *iph;
-	__u32 index = 0;
 	int ret = 0;
-	int shrink;
 	__s64 csum;
 
 	if ((void *)eth + sizeof(*eth) > data_end) {
diff --git a/tools/testing/selftests/bpf/progs/test_usdt_multispec.c b/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
index aa6de32b50d1..962f3462066a 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
@@ -18,8 +18,6 @@ int usdt_100_sum;
 SEC("usdt//proc/self/exe:test:usdt_100")
 int BPF_USDT(usdt_100, int x)
 {
-	long tmp;
-
 	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
 		return 0;
 
diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale1.c b/tools/testing/selftests/bpf/progs/test_verif_scale1.c
index ac6135d9374c..323a73fb2e8c 100644
--- a/tools/testing/selftests/bpf/progs/test_verif_scale1.c
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale1.c
@@ -11,7 +11,7 @@ int balancer_ingress(struct __sk_buff *ctx)
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
 	void *ptr;
-	int ret = 0, nh_off, i = 0;
+	int nh_off, i = 0;
 
 	nh_off = 14;
 
diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale2.c b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
index f90ffcafd1e8..f5318f757084 100644
--- a/tools/testing/selftests/bpf/progs/test_verif_scale2.c
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale2.c
@@ -11,7 +11,7 @@ int balancer_ingress(struct __sk_buff *ctx)
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
 	void *ptr;
-	int ret = 0, nh_off, i = 0;
+	int nh_off, i = 0;
 
 	nh_off = 14;
 
diff --git a/tools/testing/selftests/bpf/progs/test_verif_scale3.c b/tools/testing/selftests/bpf/progs/test_verif_scale3.c
index ca33a9b711c4..2e06dbb1ad5c 100644
--- a/tools/testing/selftests/bpf/progs/test_verif_scale3.c
+++ b/tools/testing/selftests/bpf/progs/test_verif_scale3.c
@@ -11,7 +11,7 @@ int balancer_ingress(struct __sk_buff *ctx)
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
 	void *ptr;
-	int ret = 0, nh_off, i = 0;
+	int nh_off, i = 0;
 
 	nh_off = 32;
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
index 297c260fc364..81bb38d72ced 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
@@ -5,8 +5,6 @@
 SEC("xdp")
 int _xdp_adjust_tail_grow(struct xdp_md *xdp)
 {
-	void *data_end = (void *)(long)xdp->data_end;
-	void *data = (void *)(long)xdp->data;
 	int data_len = bpf_xdp_get_buff_len(xdp);
 	int offset = 0;
 	/* SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) */
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c b/tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
index 3379d303f41a..ee48c4963971 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
@@ -45,8 +45,6 @@ SEC("fentry/FUNC")
 int BPF_PROG(trace_on_entry, struct xdp_buff *xdp)
 {
 	struct meta meta;
-	void *data_end = (void *)(long)xdp->data_end;
-	void *data = (void *)(long)xdp->data;
 
 	meta.ifindex = xdp->rxq->dev->ifindex;
 	meta.pkt_len = bpf_xdp_get_buff_len((struct xdp_md *)xdp);
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
index 7521a805b506..25ee4a22e48d 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
@@ -82,7 +82,6 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xd
 	struct iptnl_info *tnl;
 	struct ethhdr *new_eth;
 	struct ethhdr *old_eth;
-	__u32 transport_hdr_sz;
 	struct iphdr *iph;
 	__u16 *next_iph;
 	__u16 payload_len;
@@ -165,7 +164,6 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_dynptr *xd
 	struct iptnl_info *tnl;
 	struct ethhdr *new_eth;
 	struct ethhdr *old_eth;
-	__u32 transport_hdr_sz;
 	struct ipv6hdr *ip6h;
 	__u16 payload_len;
 	struct vip vip = {};
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
index ba48fcb98ab2..42c8f6ded0e4 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
@@ -371,45 +371,6 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
 	return true;
 }
 
-static __attribute__ ((noinline))
-bool decap_v6(struct xdp_md *xdp, void **data, void **data_end, bool inner_v4)
-{
-	struct eth_hdr *new_eth;
-	struct eth_hdr *old_eth;
-
-	old_eth = *data;
-	new_eth = *data + sizeof(struct ipv6hdr);
-	memcpy(new_eth->eth_source, old_eth->eth_source, 6);
-	memcpy(new_eth->eth_dest, old_eth->eth_dest, 6);
-	if (inner_v4)
-		new_eth->eth_proto = 8;
-	else
-		new_eth->eth_proto = 56710;
-	if (bpf_xdp_adjust_head(xdp, (int)sizeof(struct ipv6hdr)))
-		return false;
-	*data = (void *)(long)xdp->data;
-	*data_end = (void *)(long)xdp->data_end;
-	return true;
-}
-
-static __attribute__ ((noinline))
-bool decap_v4(struct xdp_md *xdp, void **data, void **data_end)
-{
-	struct eth_hdr *new_eth;
-	struct eth_hdr *old_eth;
-
-	old_eth = *data;
-	new_eth = *data + sizeof(struct iphdr);
-	memcpy(new_eth->eth_source, old_eth->eth_source, 6);
-	memcpy(new_eth->eth_dest, old_eth->eth_dest, 6);
-	new_eth->eth_proto = 8;
-	if (bpf_xdp_adjust_head(xdp, (int)sizeof(struct iphdr)))
-		return false;
-	*data = (void *)(long)xdp->data;
-	*data_end = (void *)(long)xdp->data_end;
-	return true;
-}
-
 static __attribute__ ((noinline))
 int swap_mac_and_send(void *data, void *data_end)
 {
@@ -430,7 +391,6 @@ int send_icmp_reply(void *data, void *data_end)
 	__u16 *next_iph_u16;
 	__u32 tmp_addr = 0;
 	struct iphdr *iph;
-	__u32 csum1 = 0;
 	__u32 csum = 0;
 	__u64 off = 0;
 
@@ -662,7 +622,6 @@ static int process_l3_headers_v4(struct packet_description *pckt,
 				 void *data_end)
 {
 	struct iphdr *iph;
-	__u64 iph_len;
 	int action;
 
 	iph = data + off;
@@ -696,7 +655,6 @@ static int process_packet(void *data, __u64 off, void *data_end,
 	struct packet_description pckt = { };
 	struct vip_definition vip = { };
 	struct lb_stats *data_stats;
-	struct eth_hdr *eth = data;
 	void *lru_map = &lru_cache;
 	struct vip_meta *vip_info;
 	__u32 lru_stats_key = 513;
@@ -704,7 +662,6 @@ static int process_packet(void *data, __u64 off, void *data_end,
 	__u32 stats_key = 512;
 	struct ctl_value *cval;
 	__u16 pkt_bytes;
-	__u64 iph_len;
 	__u8 protocol;
 	__u32 vip_num;
 	int action;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
index 4ddcb6dfe500..f3ec8086482d 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
@@ -209,19 +209,6 @@ int  xdp_prognum2(struct xdp_md *ctx)
 	return XDP_PASS;
 }
 
-static __always_inline
-void shift_mac_4bytes_16bit(void *data)
-{
-	__u16 *p = data;
-
-	p[7] = p[5]; /* delete p[7] was vlan_hdr->h_vlan_TCI */
-	p[6] = p[4]; /* delete p[6] was ethhdr->h_proto */
-	p[5] = p[3];
-	p[4] = p[2];
-	p[3] = p[1];
-	p[2] = p[0];
-}
-
 static __always_inline
 void shift_mac_4bytes_32bit(void *data)
 {
diff --git a/tools/testing/selftests/bpf/progs/type_cast.c b/tools/testing/selftests/bpf/progs/type_cast.c
index eb78e6f03129..a9629ac230fd 100644
--- a/tools/testing/selftests/bpf/progs/type_cast.c
+++ b/tools/testing/selftests/bpf/progs/type_cast.c
@@ -63,7 +63,6 @@ SEC("?tp_btf/sys_enter")
 int BPF_PROG(untrusted_ptr, struct pt_regs *regs, long id)
 {
 	struct task_struct *task, *task_dup;
-	long *ptr;
 
 	task = bpf_get_current_task_btf();
 	task_dup = bpf_rdonly_cast(task, bpf_core_type_id_kernel(struct task_struct));
diff --git a/tools/testing/selftests/bpf/progs/udp_limit.c b/tools/testing/selftests/bpf/progs/udp_limit.c
index 165e3c2dd9a3..4767451b59ac 100644
--- a/tools/testing/selftests/bpf/progs/udp_limit.c
+++ b/tools/testing/selftests/bpf/progs/udp_limit.c
@@ -17,7 +17,6 @@ SEC("cgroup/sock_create")
 int sock(struct bpf_sock *ctx)
 {
 	int *sk_storage;
-	__u32 key;
 
 	if (ctx->type != SOCK_DGRAM)
 		return 1;
@@ -46,7 +45,6 @@ SEC("cgroup/sock_release")
 int sock_release(struct bpf_sock *ctx)
 {
 	int *sk_storage;
-	__u32 key;
 
 	if (ctx->type != SOCK_DGRAM)
 		return 1;
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_success.c b/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
index 0ade1110613b..dd3bdf672633 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
@@ -162,8 +162,6 @@ SEC("fentry/" SYS_PREFIX "sys_prctl")
 int test_user_ringbuf_protocol(void *ctx)
 {
 	long status = 0;
-	struct sample *sample = NULL;
-	struct bpf_dynptr ptr;
 
 	if (!is_test_process())
 		return 0;
@@ -183,10 +181,6 @@ int test_user_ringbuf_protocol(void *ctx)
 SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int test_user_ringbuf(void *ctx)
 {
-	int status = 0;
-	struct sample *sample = NULL;
-	struct bpf_dynptr ptr;
-
 	if (!is_test_process())
 		return 0;
 
diff --git a/tools/testing/selftests/bpf/progs/xdp_features.c b/tools/testing/selftests/bpf/progs/xdp_features.c
index 87c247d56f72..67424084a38a 100644
--- a/tools/testing/selftests/bpf/progs/xdp_features.c
+++ b/tools/testing/selftests/bpf/progs/xdp_features.c
@@ -70,7 +70,6 @@ xdp_process_echo_packet(struct xdp_md *xdp, bool dut)
 	struct tlv_hdr *tlv;
 	struct udphdr *uh;
 	__be16 port;
-	__u8 *cmd;
 
 	if (eh + 1 > (struct ethhdr *)data_end)
 		return -EINVAL;
diff --git a/tools/testing/selftests/bpf/progs/xdping_kern.c b/tools/testing/selftests/bpf/progs/xdping_kern.c
index 4ad73847b8a5..54cf1765118b 100644
--- a/tools/testing/selftests/bpf/progs/xdping_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdping_kern.c
@@ -89,7 +89,6 @@ static __always_inline int icmp_check(struct xdp_md *ctx, int type)
 SEC("xdp")
 int xdping_client(struct xdp_md *ctx)
 {
-	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
 	struct pinginfo *pinginfo = NULL;
 	struct ethhdr *eth = data;
@@ -153,7 +152,6 @@ int xdping_client(struct xdp_md *ctx)
 SEC("xdp")
 int xdping_server(struct xdp_md *ctx)
 {
-	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
 	struct ethhdr *eth = data;
 	struct icmphdr *icmph;
diff --git a/tools/testing/selftests/bpf/progs/xdpwall.c b/tools/testing/selftests/bpf/progs/xdpwall.c
index 7a891a0c3a39..c2dd0c28237a 100644
--- a/tools/testing/selftests/bpf/progs/xdpwall.c
+++ b/tools/testing/selftests/bpf/progs/xdpwall.c
@@ -321,7 +321,6 @@ int edgewall(struct xdp_md *ctx)
 	void *data = (void *)(long)(ctx->data);
 	struct fw_match_info match_info = {};
 	struct pkt_info info = {};
-	__u8 parse_err = NO_ERR;
 	void *transport_hdr;
 	struct ethhdr *eth;
 	bool filter_res;
-- 
2.34.1

