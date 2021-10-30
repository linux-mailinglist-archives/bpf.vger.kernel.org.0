Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088F244078E
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 07:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhJ3FCn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 30 Oct 2021 01:02:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2728 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231596AbhJ3FCn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 Oct 2021 01:02:43 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19U1cACw029386
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3c0vj1gnj6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:13 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 22:00:11 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D7E0D7830593; Fri, 29 Oct 2021 22:00:03 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 10/14] selftests/bpf: fix non-strict SEC() program sections
Date:   Fri, 29 Oct 2021 21:59:37 -0700
Message-ID: <20211030045941.3514948-11-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211030045941.3514948-1-andrii@kernel.org>
References: <20211030045941.3514948-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: sA_NqUetbyzm5DLXBbppTDsL6ersFo7c
X-Proofpoint-ORIG-GUID: sA_NqUetbyzm5DLXBbppTDsL6ersFo7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-30_01,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=992
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110300025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix few more SEC() definitions that were previously missed.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_l4lb.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_l4lb_noinline.c   | 2 +-
 tools/testing/selftests/bpf/progs/test_map_lock.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_queue_stack_map.h | 2 +-
 tools/testing/selftests/bpf/progs/test_skb_ctx.c         | 2 +-
 tools/testing/selftests/bpf/progs/test_spin_lock.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_tcp_estats.c      | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_l4lb.c b/tools/testing/selftests/bpf/progs/test_l4lb.c
index 04fee08863cb..c26057ec46dc 100644
--- a/tools/testing/selftests/bpf/progs/test_l4lb.c
+++ b/tools/testing/selftests/bpf/progs/test_l4lb.c
@@ -448,7 +448,7 @@ static __always_inline int process_packet(void *data, __u64 off, void *data_end,
 	return bpf_redirect(ifindex, 0);
 }
 
-SEC("l4lb-demo")
+SEC("tc")
 int balancer_ingress(struct __sk_buff *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
diff --git a/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c b/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
index b9e2753f4f91..19e4d2071c60 100644
--- a/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
@@ -447,7 +447,7 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
 	return bpf_redirect(ifindex, 0);
 }
 
-SEC("l4lb-demo")
+SEC("tc")
 int balancer_ingress(struct __sk_buff *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
diff --git a/tools/testing/selftests/bpf/progs/test_map_lock.c b/tools/testing/selftests/bpf/progs/test_map_lock.c
index b5c07ae7b68f..acf073db9e8b 100644
--- a/tools/testing/selftests/bpf/progs/test_map_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_map_lock.c
@@ -30,7 +30,7 @@ struct {
 	__type(value, struct array_elem);
 } array_map SEC(".maps");
 
-SEC("map_lock_demo")
+SEC("cgroup/skb")
 int bpf_map_lock_test(struct __sk_buff *skb)
 {
 	struct hmap_elem zero = {}, *val;
diff --git a/tools/testing/selftests/bpf/progs/test_queue_stack_map.h b/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
index 0fcd3ff0e38a..648e8cab7a23 100644
--- a/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
+++ b/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
@@ -24,7 +24,7 @@ struct {
 	__uint(value_size, sizeof(__u32));
 } map_out SEC(".maps");
 
-SEC("test")
+SEC("tc")
 int _test(struct __sk_buff *skb)
 {
 	void *data_end = (void *)(long)skb->data_end;
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
index 1d61b36e6067..c482110cfc95 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_ctx.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -5,7 +5,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-SEC("skb_ctx")
+SEC("tc")
 int process(struct __sk_buff *skb)
 {
 	#pragma clang loop unroll(full)
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock.c b/tools/testing/selftests/bpf/progs/test_spin_lock.c
index 0d31a3b3505f..7e88309d3229 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock.c
@@ -45,7 +45,7 @@ struct {
 
 #define CREDIT_PER_NS(delta, rate) (((delta) * rate) >> 20)
 
-SEC("spin_lock_demo")
+SEC("tc")
 int bpf_sping_lock_test(struct __sk_buff *skb)
 {
 	volatile int credit = 0, max_credit = 100, pkt_len = 64;
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_estats.c b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
index 2c5c602c6011..e2ae049c2f85 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_estats.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
@@ -244,7 +244,7 @@ static __always_inline void send_basic_event(struct sock *sk,
 	bpf_map_update_elem(&ev_record_map, &key, &ev, BPF_ANY);
 }
 
-SEC("dummy_tracepoint")
+SEC("tp/dummy/tracepoint")
 int _dummy_tracepoint(struct dummy_tracepoint_args *arg)
 {
 	if (!arg->sock)
-- 
2.30.2

