Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB40A424657
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhJFS6q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5120 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231826AbhJFS6p (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:45 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196HJggV020184
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wirgFunwvdS7DPl3QJAA8HXAFCEIDbS4Hquqw28tEFU=;
 b=XPiZS9H15ZezTfjefgJ1jycgypCWaMlIz0bbCCb9X1pwqeB8yCFcbqkMQcOkagq+3tKA
 jvKVMaAO8L26Qe7lXk6yXt8Tevh4BuiGvt1Ls+EpQfmfEn8sb2/MGB3p6roNGPhM1mCV
 h7Eqm8cB2grzDeyuIJX/Mx++dDPNWmtAOFA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhg3n0u83-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:52 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:27 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 539F04BDB5C7; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 14/14] selfetest/bpf: make some tests serial
Date:   Wed, 6 Oct 2021 11:56:19 -0700
Message-ID: <20211006185619.364369-15-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Rk5C2DxMxXfPQoQEKyyQVB3N4d5jB9VH
X-Proofpoint-ORIG-GUID: Rk5C2DxMxXfPQoQEKyyQVB3N4d5jB9VH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

Change tests that often fails in parallel execution mode to serial.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c            | 2 +-
 tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c      | 2 +-
 .../selftests/bpf/prog_tests/cgroup_attach_autodetach.c        | 2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c   | 2 +-
 .../testing/selftests/bpf/prog_tests/cgroup_attach_override.c  | 2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_link.c           | 2 +-
 tools/testing/selftests/bpf/prog_tests/check_mtu.c             | 2 +-
 tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c         | 3 ++-
 .../selftests/bpf/prog_tests/flow_dissector_load_bytes.c       | 2 +-
 .../testing/selftests/bpf/prog_tests/flow_dissector_reattach.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c             | 3 ++-
 tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c     | 2 +-
 tools/testing/selftests/bpf/prog_tests/modify_return.c         | 3 ++-
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c   | 3 ++-
 tools/testing/selftests/bpf/prog_tests/perf_buffer.c           | 2 +-
 tools/testing/selftests/bpf/prog_tests/perf_link.c             | 3 ++-
 tools/testing/selftests/bpf/prog_tests/probe_user.c            | 3 ++-
 .../selftests/bpf/prog_tests/raw_tp_writable_test_run.c        | 3 ++-
 tools/testing/selftests/bpf/prog_tests/select_reuseport.c      | 2 +-
 .../selftests/bpf/prog_tests/send_signal_sched_switch.c        | 3 ++-
 tools/testing/selftests/bpf/prog_tests/sk_storage_tracing.c    | 2 +-
 tools/testing/selftests/bpf/prog_tests/snprintf_btf.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/sock_fields.c           | 2 +-
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c        | 2 +-
 tools/testing/selftests/bpf/prog_tests/timer.c                 | 3 ++-
 tools/testing/selftests/bpf/prog_tests/timer_mim.c             | 2 +-
 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/trace_printk.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/trace_vprintk.c         | 2 +-
 tools/testing/selftests/bpf/prog_tests/trampoline_count.c      | 3 ++-
 tools/testing/selftests/bpf/prog_tests/xdp_attach.c            | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c           | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c     | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c     | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_info.c              | 2 +-
 tools/testing/selftests/bpf/prog_tests/xdp_link.c              | 2 +-
 38 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c=
 b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
index 85babb0487b3..b52ff8ce34db 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
@@ -179,7 +179,7 @@ static void do_bpf_iter_setsockopt(struct bpf_iter_se=
tsockopt *iter_skel,
 	free_fds(est_fds, nr_est);
 }
=20
-void test_bpf_iter_setsockopt(void)
+void serial_test_bpf_iter_setsockopt(void)
 {
 	struct bpf_iter_setsockopt *iter_skel =3D NULL;
 	struct bpf_cubic *cubic_skel =3D NULL;
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_obj_id.c
index 284d5921c345..eb8eeebe6935 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
@@ -3,7 +3,7 @@
=20
 #define nr_iters 2
=20
-void test_bpf_obj_id(void)
+void serial_test_bpf_obj_id(void)
 {
 	const __u64 array_magic_value =3D 0xfaceb00c;
 	const __u32 array_key =3D 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/=
tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 876be0ecb654..621c57222191 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -363,7 +363,7 @@ static void test_shared(int parent_cgroup_fd, int chi=
ld_cgroup_fd)
 	cg_storage_multi_shared__destroy(obj);
 }
=20
-void test_cg_storage_multi(void)
+void serial_test_cg_storage_multi(void)
 {
 	int parent_cgroup_fd =3D -1, child_cgroup_fd =3D -1;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodet=
ach.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
index 70e94e783070..5de485c7370f 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
@@ -21,7 +21,7 @@ static int prog_load(void)
 			       bpf_log_buf, BPF_LOG_BUF_SIZE);
 }
=20
-void test_cgroup_attach_autodetach(void)
+void serial_test_cgroup_attach_autodetach(void)
 {
 	__u32 duration =3D 0, prog_cnt =3D 4, attach_flags;
 	int allow_prog[2] =3D {-1};
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c=
 b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index 20bb8831dda6..731bea84d8ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -74,7 +74,7 @@ static int prog_load_cnt(int verdict, int val)
 	return ret;
 }
=20
-void test_cgroup_attach_multi(void)
+void serial_test_cgroup_attach_multi(void)
 {
 	__u32 prog_ids[4], prog_cnt =3D 0, attach_flags, saved_prog_id;
 	int cg1 =3D 0, cg2 =3D 0, cg3 =3D 0, cg4 =3D 0, cg5 =3D 0, key =3D 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_overrid=
e.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
index 9e96f8d87fea..10d3c33821a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
@@ -23,7 +23,7 @@ static int prog_load(int verdict)
 			       bpf_log_buf, BPF_LOG_BUF_SIZE);
 }
=20
-void test_cgroup_attach_override(void)
+void serial_test_cgroup_attach_override(void)
 {
 	int drop_prog =3D -1, allow_prog =3D -1, foo =3D -1, bar =3D -1;
 	__u32 duration =3D 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_link.c b/tools=
/testing/selftests/bpf/prog_tests/cgroup_link.c
index 9091524131d6..9e6e6aad347c 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
@@ -24,7 +24,7 @@ int ping_and_check(int exp_calls, int exp_alt_calls)
 	return 0;
 }
=20
-void test_cgroup_link(void)
+void serial_test_cgroup_link(void)
 {
 	struct {
 		const char *path;
diff --git a/tools/testing/selftests/bpf/prog_tests/check_mtu.c b/tools/t=
esting/selftests/bpf/prog_tests/check_mtu.c
index 012068f33a0a..f73e6e36b74d 100644
--- a/tools/testing/selftests/bpf/prog_tests/check_mtu.c
+++ b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
@@ -195,7 +195,7 @@ static void test_check_mtu_tc(__u32 mtu, __u32 ifinde=
x)
 	test_check_mtu__destroy(skel);
 }
=20
-void test_check_mtu(void)
+void serial_test_check_mtu(void)
 {
 	__u32 mtu_lo;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 2839f4270a26..9cff14a23bb7 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -380,7 +380,8 @@ static void test_func_map_prog_compatibility(void)
 				     "./test_attach_probe.o");
 }
=20
-void test_fexit_bpf2bpf(void)
+/* NOTE: affect other tests, must run in serial mode */
+void serial_test_fexit_bpf2bpf(void)
 {
 	if (test__start_subtest("target_no_callees"))
 		test_target_no_callees();
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_b=
ytes.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes=
.c
index 0e8a4d2f023d..6093728497c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 #include <network_helpers.h>
=20
-void test_flow_dissector_load_bytes(void)
+void serial_test_flow_dissector_load_bytes(void)
 {
 	struct bpf_flow_keys flow_keys;
 	__u32 duration =3D 0, retval, size;
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reatta=
ch.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
index 3931ede5c534..f0c6c226aba8 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
@@ -628,7 +628,7 @@ static void run_tests(int netns)
 	}
 }
=20
-void test_flow_dissector_reattach(void)
+void serial_test_flow_dissector_reattach(void)
 {
 	int err, new_net, saved_net;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c=
 b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
index 67e86f8d8677..4ef4f284b462 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
@@ -49,7 +49,7 @@ static void close_perf_events(void)
 	free(pfd_array);
 }
=20
-void test_get_branch_snapshot(void)
+void serial_test_get_branch_snapshot(void)
 {
 	struct get_branch_snapshot *skel =3D NULL;
 	int err;
diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/t=
esting/selftests/bpf/prog_tests/kfree_skb.c
index ddfb6bf97152..032a322d51f2 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -48,7 +48,8 @@ static void on_sample(void *ctx, int cpu, void *data, _=
_u32 size)
 	*(bool *)ctx =3D true;
 }
=20
-void test_kfree_skb(void)
+/* TODO: fix kernel panic caused by this test in parallel mode */
+void serial_test_kfree_skb(void)
 {
 	struct __sk_buff skb =3D {};
 	struct bpf_prog_test_run_attr tattr =3D {
diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b=
/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
index 59adb4715394..7589c03fd26b 100644
--- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
@@ -541,7 +541,7 @@ static void run_test(struct migrate_reuseport_test_ca=
se *test_case,
 	}
 }
=20
-void test_migrate_reuseport(void)
+void serial_test_migrate_reuseport(void)
 {
 	struct test_migrate_reuseport *skel;
 	int i;
diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/too=
ls/testing/selftests/bpf/prog_tests/modify_return.c
index 97fec70c600b..b772fe30ce9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -53,7 +53,8 @@ static void run_test(__u32 input_retval, __u16 want_sid=
e_effect, __s16 want_ret)
 	modify_return__destroy(skel);
 }
=20
-void test_modify_return(void)
+/* TODO: conflict with get_func_ip_test */
+void serial_test_modify_return(void)
 {
 	run_test(0 /* input_retval */,
 		 1 /* want_side_effect */,
diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c=
 b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index 2535788e135f..24d493482ffc 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -78,7 +78,8 @@ static void test_ns_current_pid_tgid_new_ns(void)
 		return;
 }
=20
-void test_ns_current_pid_tgid(void)
+/* TODO: use a different tracepoint */
+void serial_test_ns_current_pid_tgid(void)
 {
 	if (test__start_subtest("ns_current_pid_tgid_root_ns"))
 		test_current_pid_tgid(NULL);
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c b/tools=
/testing/selftests/bpf/prog_tests/perf_buffer.c
index 6490e9673002..6979aff4aab2 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
@@ -43,7 +43,7 @@ int trigger_on_cpu(int cpu)
 	return 0;
 }
=20
-void test_perf_buffer(void)
+void serial_test_perf_buffer(void)
 {
 	int err, on_len, nr_on_cpus =3D 0, nr_cpus, i;
 	struct perf_buffer_opts pb_opts =3D {};
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/t=
esting/selftests/bpf/prog_tests/perf_link.c
index 74e5bd5f1c19..513b5349539c 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -23,7 +23,8 @@ static void burn_cpu(void)
 		++j;
 }
=20
-void test_perf_link(void)
+/* TODO: often fails in concurrent mode */
+void serial_test_perf_link(void)
 {
 	struct test_perf_link *skel =3D NULL;
 	struct perf_event_attr attr;
diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/=
testing/selftests/bpf/prog_tests/probe_user.c
index 52fe157e2a90..abf890d066eb 100644
--- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
=20
-void test_probe_user(void)
+/* TODO: corrupts other tests uses connect() */
+void serial_test_probe_user(void)
 {
 	const char *prog_name =3D "handle_sys_connect";
 	const char *obj_file =3D "./test_probe_user.o";
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_=
run.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
index 5c45424cac5f..ddefa1192e5d 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
@@ -3,7 +3,8 @@
 #include <test_progs.h>
 #include <linux/nbd.h>
=20
-void test_raw_tp_writable_test_run(void)
+/* NOTE: conflict with other tests. */
+void serial_test_raw_tp_writable_test_run(void)
 {
 	__u32 duration =3D 0;
 	char error[4096];
diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/=
tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index d40e9156c48d..3cfc910ab3c1 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -858,7 +858,7 @@ void test_map_type(enum bpf_map_type mt)
 	cleanup();
 }
=20
-void test_select_reuseport(void)
+void serial_test_select_reuseport(void)
 {
 	saved_tcp_fo =3D read_int_sysctl(TCP_FO_SYSCTL);
 	if (saved_tcp_fo < 0)
diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal_sched_swi=
tch.c b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
index 189a34a7addb..15dacfcfaa6d 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal_sched_switch.c
@@ -25,7 +25,8 @@ static void *worker(void *p)
 	return NULL;
 }
=20
-void test_send_signal_sched_switch(void)
+/* NOTE: cause events loss */
+void serial_test_send_signal_sched_switch(void)
 {
 	struct test_send_signal_kern *skel;
 	pthread_t threads[THREAD_COUNT];
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_storage_tracing.c =
b/tools/testing/selftests/bpf/prog_tests/sk_storage_tracing.c
index 2b392590e8ca..547ae53cde74 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_storage_tracing.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_storage_tracing.c
@@ -105,7 +105,7 @@ static void do_test(void)
 		close(listen_fd);
 }
=20
-void test_sk_storage_tracing(void)
+void serial_test_sk_storage_tracing(void)
 {
 	struct test_sk_storage_trace_itself *skel_itself;
 	int err;
diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c b/tool=
s/testing/selftests/bpf/prog_tests/snprintf_btf.c
index 76e1f5fe18fa..dd41b826be30 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
@@ -6,7 +6,7 @@
 /* Demonstrate that bpf_snprintf_btf succeeds and that various data type=
s
  * are formatted correctly.
  */
-void test_snprintf_btf(void)
+void serial_test_snprintf_btf(void)
 {
 	struct netif_receive_skb *skel;
 	struct netif_receive_skb__bss *bss;
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/tools=
/testing/selftests/bpf/prog_tests/sock_fields.c
index 577d619fb07e..fae40db4d81f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
@@ -329,7 +329,7 @@ static void test(void)
 		close(listen_fd);
 }
=20
-void test_sock_fields(void)
+void serial_test_sock_fields(void)
 {
 	struct bpf_link *egress_link =3D NULL, *ingress_link =3D NULL;
 	int parent_cg_fd =3D -1, child_cg_fd =3D -1;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 5c5979046523..102c73a00402 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -2037,7 +2037,7 @@ static void run_tests(struct test_sockmap_listen *s=
kel, struct bpf_map *map,
 	test_udp_unix_redir(skel, map, family);
 }
=20
-void test_sockmap_listen(void)
+void serial_test_sockmap_listen(void)
 {
 	struct test_sockmap_listen *skel;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testi=
ng/selftests/bpf/prog_tests/timer.c
index 25f40e1b9967..0f4e49e622cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -39,7 +39,8 @@ static int timer(struct timer *timer_skel)
 	return 0;
 }
=20
-void test_timer(void)
+/* TODO: use pid filtering */
+void serial_test_timer(void)
 {
 	struct timer *timer_skel =3D NULL;
 	int err;
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_mim.c b/tools/t=
esting/selftests/bpf/prog_tests/timer_mim.c
index ced8f6cf347c..949a0617869d 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_mim.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
@@ -52,7 +52,7 @@ static int timer_mim(struct timer_mim *timer_skel)
 	return 0;
 }
=20
-void test_timer_mim(void)
+void serial_test_timer_mim(void)
 {
 	struct timer_mim_reject *timer_reject_skel =3D NULL;
 	libbpf_print_fn_t old_print_fn =3D NULL;
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/t=
ools/testing/selftests/bpf/prog_tests/tp_attach_query.c
index fb095e5cd9af..8652d0a46c87 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
=20
-void test_tp_attach_query(void)
+void serial_test_tp_attach_query(void)
 {
 	const int num_progs =3D 3;
 	int i, j, bytes, efd, err, prog_fd[num_progs], pmu_fd[num_progs];
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tool=
s/testing/selftests/bpf/prog_tests/trace_printk.c
index e47835f0a674..3f7a7141265e 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
@@ -8,7 +8,7 @@
 #define TRACEBUF	"/sys/kernel/debug/tracing/trace_pipe"
 #define SEARCHMSG	"testing,testing"
=20
-void test_trace_printk(void)
+void serial_test_trace_printk(void)
 {
 	int err =3D 0, iter =3D 0, found =3D 0;
 	struct trace_printk__bss *bss;
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c b/too=
ls/testing/selftests/bpf/prog_tests/trace_vprintk.c
index 61a24e62e1a0..46101270cb1a 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
@@ -8,7 +8,7 @@
 #define TRACEBUF	"/sys/kernel/debug/tracing/trace_pipe"
 #define SEARCHMSG	"1,2,3,4,5,6,7,8,9,10"
=20
-void test_trace_vprintk(void)
+void serial_test_trace_vprintk(void)
 {
 	int err =3D 0, iter =3D 0, found =3D 0;
 	struct trace_vprintk__bss *bss;
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/=
tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index d7f5a931d7f3..fc146671b20a 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -41,7 +41,8 @@ static struct bpf_link *load(struct bpf_object *obj, co=
nst char *name)
 	return bpf_program__attach_trace(prog);
 }
=20
-void test_trampoline_count(void)
+/* TODO: use different target function to run in concurrent mode */
+void serial_test_trampoline_count(void)
 {
 	const char *fentry_name =3D "fentry/__set_task_comm";
 	const char *fexit_name =3D "fexit/__set_task_comm";
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/=
testing/selftests/bpf/prog_tests/xdp_attach.c
index 15ef3531483e..4c4057262cd8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
@@ -4,7 +4,7 @@
 #define IFINDEX_LO 1
 #define XDP_FLAGS_REPLACE		(1U << 4)
=20
-void test_xdp_attach(void)
+void serial_test_xdp_attach(void)
 {
 	__u32 duration =3D 0, id1, id2, id0 =3D 0, len;
 	struct bpf_object *obj1, *obj2, *obj3;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools=
/testing/selftests/bpf/prog_tests/xdp_bonding.c
index ad3ba81b4048..faa22b84f2ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -519,7 +519,7 @@ static struct bond_test_case bond_test_cases[] =3D {
 	{ "xdp_bonding_xor_layer34", BOND_MODE_XOR, BOND_XMIT_POLICY_LAYER34, }=
,
 };
=20
-void test_xdp_bonding(void)
+void serial_test_xdp_bonding(void)
 {
 	libbpf_print_fn_t old_print_fn;
 	struct skeletons skeletons =3D {};
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b=
/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index 8755effd80b0..fd812bd43600 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -7,7 +7,7 @@
=20
 #define IFINDEX_LO	1
=20
-void test_xdp_cpumap_attach(void)
+void serial_test_xdp_cpumap_attach(void)
 {
 	struct test_xdp_with_cpumap_helpers *skel;
 	struct bpf_prog_info info =3D {};
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b=
/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index c72af030ff10..d4e9a9972a67 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -72,7 +72,7 @@ void test_neg_xdp_devmap_helpers(void)
 }
=20
=20
-void test_xdp_devmap_attach(void)
+void serial_test_xdp_devmap_attach(void)
 {
 	if (test__start_subtest("DEVMAP with programs in entries"))
 		test_xdp_with_devmap_helpers();
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_info.c b/tools/te=
sting/selftests/bpf/prog_tests/xdp_info.c
index d2d7a283d72f..4e2a4fd56f67 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_info.c
@@ -4,7 +4,7 @@
=20
 #define IFINDEX_LO 1
=20
-void test_xdp_info(void)
+void serial_test_xdp_info(void)
 {
 	__u32 len =3D sizeof(struct bpf_prog_info), duration =3D 0, prog_id;
 	const char *file =3D "./xdp_dummy.o";
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/te=
sting/selftests/bpf/prog_tests/xdp_link.c
index 46eed0a33c23..983ab0b47d30 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
@@ -6,7 +6,7 @@
=20
 #define IFINDEX_LO 1
=20
-void test_xdp_link(void)
+void serial_test_xdp_link(void)
 {
 	__u32 duration =3D 0, id1, id2, id0 =3D 0, prog_fd1, prog_fd2, err;
 	DECLARE_LIBBPF_OPTS(bpf_xdp_set_link_opts, opts, .old_fd =3D -1);
--=20
2.30.2

