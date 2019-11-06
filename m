Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C00F2266
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 00:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfKFXMs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Nov 2019 18:12:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727462AbfKFXMr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Nov 2019 18:12:47 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xA6NCdHc023579
        for <bpf@vger.kernel.org>; Wed, 6 Nov 2019 15:12:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=JL++fvaC8FmfDQuaMXPMZlgTgm1EVUBKy7zpoUaWJ3U=;
 b=FEJGCX1RHmIU4/cyDR1rUN2n09cJDDp5UOJs2ULEU1YOGNyX1E4Y5DBKp/qd83absgCA
 VmHdIYgp5bSbo1yeBqd6qkdmFayXOJ0+JJ0ADVFEwuFAq/UGFtWwYMxji9Otg99rSFUW
 9VvNYucMYZkrZTiQp7B5RMsSel9Db2ljlCk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2w41vc9vmj-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2019 15:12:46 -0800
Received: from 2401:db00:30:600c:face:0:1f:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 6 Nov 2019 15:12:14 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id AEA2629431A0; Wed,  6 Nov 2019 15:12:13 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 2/2] bpf: Add cb access in kfree_skb test
Date:   Wed, 6 Nov 2019 15:12:13 -0800
Message-ID: <20191106231213.3616207-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106231210.3615828-1-kafai@fb.com>
References: <20191106231210.3615828-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_08:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 priorityscore=1501
 suspectscore=9 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911060223
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Access the skb->cb[] in the kfree_skb test.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 .../selftests/bpf/prog_tests/kfree_skb.c      | 54 +++++++++++++++----
 tools/testing/selftests/bpf/progs/kfree_skb.c | 25 +++++++--
 2 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index 430b50de1583..55d36856e621 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -1,15 +1,38 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 
+struct meta {
+	int ifindex;
+	__u32 cb32_0;
+	__u8 cb8_0;
+};
+
+static union {
+	__u32 cb32[5];
+	__u8 cb8[20];
+} cb = {
+	.cb32[0] = 0x81828384,
+};
+
 static void on_sample(void *ctx, int cpu, void *data, __u32 size)
 {
-	int ifindex = *(int *)data, duration = 0;
-	struct ipv6_packet *pkt_v6 = data + 4;
+	struct meta *meta = (struct meta *)data;
+	struct ipv6_packet *pkt_v6 = data + sizeof(*meta);
+	int duration = 0;
 
-	if (ifindex != 1)
+	if (CHECK(size != 72 + sizeof(*meta), "check_size", "size %u != %zu\n",
+		  size, 72 + sizeof(*meta)))
+		return;
+	if (CHECK(meta->ifindex != 1, "check_meta_ifindex",
+		  "meta->ifindex = %d\n", meta->ifindex))
 		/* spurious kfree_skb not on loopback device */
 		return;
-	if (CHECK(size != 76, "check_size", "size %u != 76\n", size))
+	if (CHECK(meta->cb8_0 != cb.cb8[0], "check_cb8_0", "cb8_0 %x != %x\n",
+		  meta->cb8_0, cb.cb8[0]))
+		return;
+	if (CHECK(meta->cb32_0 != cb.cb32[0], "check_cb32_0",
+		  "cb32_0 %x != %x\n",
+		  meta->cb32_0, cb.cb32[0]))
 		return;
 	if (CHECK(pkt_v6->eth.h_proto != 0xdd86, "check_eth",
 		  "h_proto %x\n", pkt_v6->eth.h_proto))
@@ -26,6 +49,13 @@ static void on_sample(void *ctx, int cpu, void *data, __u32 size)
 
 void test_kfree_skb(void)
 {
+	struct __sk_buff skb = {};
+	struct bpf_prog_test_run_attr tattr = {
+		.data_in = &pkt_v6,
+		.data_size_in = sizeof(pkt_v6),
+		.ctx_in = &skb,
+		.ctx_size_in = sizeof(skb),
+	};
 	struct bpf_prog_load_attr attr = {
 		.file = "./kfree_skb.o",
 	};
@@ -36,11 +66,12 @@ void test_kfree_skb(void)
 	struct bpf_link *link = NULL;
 	struct bpf_map *perf_buf_map;
 	struct bpf_program *prog;
-	__u32 duration, retval;
-	int err, pkt_fd, kfree_skb_fd;
+	int err, kfree_skb_fd;
 	bool passed = false;
+	__u32 duration = 0;
 
-	err = bpf_prog_load("./test_pkt_access.o", BPF_PROG_TYPE_SCHED_CLS, &obj, &pkt_fd);
+	err = bpf_prog_load("./test_pkt_access.o", BPF_PROG_TYPE_SCHED_CLS,
+			    &obj, &tattr.prog_fd);
 	if (CHECK(err, "prog_load sched cls", "err %d errno %d\n", err, errno))
 		return;
 
@@ -66,11 +97,12 @@ void test_kfree_skb(void)
 	if (CHECK(IS_ERR(pb), "perf_buf__new", "err %ld\n", PTR_ERR(pb)))
 		goto close_prog;
 
-	err = bpf_prog_test_run(pkt_fd, 1, &pkt_v6, sizeof(pkt_v6),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "ipv6",
+	memcpy(skb.cb, &cb, sizeof(cb));
+	err = bpf_prog_test_run_xattr(&tattr);
+	duration = tattr.duration;
+	CHECK(err || tattr.retval, "ipv6",
 	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+	      err, errno, tattr.retval, duration);
 
 	/* read perf buffer */
 	err = perf_buffer__poll(pb, 100);
diff --git a/tools/testing/selftests/bpf/progs/kfree_skb.c b/tools/testing/selftests/bpf/progs/kfree_skb.c
index 489319ea1d6a..f769fdbf6725 100644
--- a/tools/testing/selftests/bpf/progs/kfree_skb.c
+++ b/tools/testing/selftests/bpf/progs/kfree_skb.c
@@ -43,6 +43,7 @@ struct sk_buff {
 	refcount_t users;
 	unsigned char *data;
 	char __pkt_type_offset[0];
+	char cb[48];
 };
 
 /* copy arguments from
@@ -57,28 +58,41 @@ struct trace_kfree_skb {
 	void *location;
 };
 
+struct meta {
+	int ifindex;
+	__u32 cb32_0;
+	__u8 cb8_0;
+};
+
 SEC("tp_btf/kfree_skb")
 int trace_kfree_skb(struct trace_kfree_skb *ctx)
 {
 	struct sk_buff *skb = ctx->skb;
 	struct net_device *dev;
-	int ifindex;
 	struct callback_head *ptr;
 	void *func;
 	int users;
 	unsigned char *data;
 	unsigned short pkt_data;
+	struct meta meta = {};
 	char pkt_type;
+	__u32 *cb32;
+	__u8 *cb8;
 
 	__builtin_preserve_access_index(({
 		users = skb->users.refs.counter;
 		data = skb->data;
 		dev = skb->dev;
-		ifindex = dev->ifindex;
 		ptr = dev->ifalias->rcuhead.next;
 		func = ptr->func;
+		cb8 = (__u8 *)&skb->cb;
+		cb32 = (__u32 *)&skb->cb;
 	}));
 
+	meta.ifindex = _(dev->ifindex);
+	meta.cb8_0 = cb8[8];
+	meta.cb32_0 = cb32[2];
+
 	bpf_probe_read_kernel(&pkt_type, sizeof(pkt_type), _(&skb->__pkt_type_offset));
 	pkt_type &= 7;
 
@@ -90,14 +104,15 @@ int trace_kfree_skb(struct trace_kfree_skb *ctx)
 		   _(skb->len), users, pkt_type);
 	bpf_printk("skb->queue_mapping %d\n", _(skb->queue_mapping));
 	bpf_printk("dev->ifindex %d data %llx pkt_data %x\n",
-		   ifindex, data, pkt_data);
+		   meta.ifindex, data, pkt_data);
+	bpf_printk("cb8_0:%x cb32_0:%x\n", meta.cb8_0, meta.cb32_0);
 
-	if (users != 1 || pkt_data != bpf_htons(0x86dd) || ifindex != 1)
+	if (users != 1 || pkt_data != bpf_htons(0x86dd) || meta.ifindex != 1)
 		/* raw tp ignores return value */
 		return 0;
 
 	/* send first 72 byte of the packet to user space */
 	bpf_skb_output(skb, &perf_buf_map, (72ull << 32) | BPF_F_CURRENT_CPU,
-		       &ifindex, sizeof(ifindex));
+		       &meta, sizeof(meta));
 	return 0;
 }
-- 
2.17.1

