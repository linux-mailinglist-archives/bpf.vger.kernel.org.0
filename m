Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57D03FA2A4
	for <lists+bpf@lfdr.de>; Sat, 28 Aug 2021 02:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhH1BAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Aug 2021 21:00:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1808 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232903AbhH1BAV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Aug 2021 21:00:21 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17S0vfGn002315
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 17:59:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=++JXxVWZ1PwGFLVj4ROQyqBFv2VzHv1++VmnjFu28is=;
 b=UD2ncgjyC2mzaVtau6LMUIDlP2E87K6B0nlyRXVL/qaMPls8pmyz6xzYmZx4RrHXwCj+
 WVvo/keaPqbpSLngQsv6eDfIL1LS0DVraT1tct+xBhY40VGd3FdULNF20+o0pciwRQjx
 EFA1CCn/zS9S1UqrOjKcMwiH2o7XY69hN7Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aq70js99b-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 17:59:31 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 27 Aug 2021 17:59:29 -0700
Received: by devvm2049.vll0.facebook.com (Postfix, from userid 197479)
        id 31CDA2CBCD94; Fri, 27 Aug 2021 17:59:28 -0700 (PDT)
From:   Neil Spring <ntspring@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Neil Spring <ntspring@fb.com>
Subject: [PATCH bpf-next] bpf testing: permit ingress_ifindex in bpf_prog_test_run_xattr
Date:   Fri, 27 Aug 2021 17:55:29 -0700
Message-ID: <20210828005529.2814025-1-ntspring@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: IkgymxfBfumhpdxq_5H1qMkCU-4Ht_sQ
X-Proofpoint-GUID: IkgymxfBfumhpdxq_5H1qMkCU-4Ht_sQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_07:2021-08-27,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108280004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_prog_test_run_xattr takes a struct __sk_buff, but did not permit
that __skbuff to include an nonzero ingress_ifindex.

This patch updates to allow ingress_ifindex, convert the __sk_buff field =
to
sk_buff (skb_iif) and back, and test that the value is present from
tested bpf.  The test sets an unlikely distinct value for ingress_ifindex
(11) from ifindex (1), but that seems in keeping with the rest of the
synthetic fields.

Adding this support allows testing BPF that operates differently on
incoming and outgoing skbs by discriminating on this field.

Signed-off-by: Neil Spring <ntspring@fb.com>
---
 net/bpf/test_run.c                               | 8 +++-----
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c | 5 +----
 tools/testing/selftests/bpf/progs/test_skb_ctx.c | 4 ++++
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4b855af267b1..a322578efa5f 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -483,11 +483,7 @@ static int convert___skb_to_skb(struct sk_buff *skb,=
 struct __sk_buff *__skb)
 		return -EINVAL;
=20
 	/* priority is allowed */
-
-	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, priority),
-			   offsetof(struct __sk_buff, ifindex)))
-		return -EINVAL;
-
+	/* ingress_ifindex is allowed */
 	/* ifindex is allowed */
=20
 	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, ifindex),
@@ -516,6 +512,7 @@ static int convert___skb_to_skb(struct sk_buff *skb, =
struct __sk_buff *__skb)
=20
 	skb->mark =3D __skb->mark;
 	skb->priority =3D __skb->priority;
+	skb->skb_iif =3D __skb->ingress_ifindex;
 	skb->tstamp =3D __skb->tstamp;
 	memcpy(&cb->data, __skb->cb, QDISC_CB_PRIV_LEN);
=20
@@ -545,6 +542,7 @@ static void convert_skb_to___skb(struct sk_buff *skb,=
 struct __sk_buff *__skb)
=20
 	__skb->mark =3D skb->mark;
 	__skb->priority =3D skb->priority;
+	__skb->ingress_ifindex =3D skb->skb_iif;
 	__skb->ifindex =3D skb->dev->ifindex;
 	__skb->tstamp =3D skb->tstamp;
 	memcpy(__skb->cb, &cb->data, QDISC_CB_PRIV_LEN);
diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/tes=
ting/selftests/bpf/prog_tests/skb_ctx.c
index fafeddaad6a9..606da5335363 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -11,6 +11,7 @@ void test_skb_ctx(void)
 		.cb[3] =3D 4,
 		.cb[4] =3D 5,
 		.priority =3D 6,
+		.ingress_ifindex =3D 11,
 		.ifindex =3D 1,
 		.tstamp =3D 7,
 		.wire_len =3D 100,
@@ -93,10 +94,6 @@ void test_skb_ctx(void)
 		   "ctx_out_priority",
 		   "skb->priority =3D=3D %d, expected %d\n",
 		   skb.priority, 7);
-	CHECK_ATTR(skb.ifindex !=3D 1,
-		   "ctx_out_ifindex",
-		   "skb->ifindex =3D=3D %d, expected %d\n",
-		   skb.ifindex, 1);
 	CHECK_ATTR(skb.tstamp !=3D 8,
 		   "ctx_out_tstamp",
 		   "skb->tstamp =3D=3D %lld, expected %d\n",
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/tes=
ting/selftests/bpf/progs/test_skb_ctx.c
index b02ea589ce7e..bbd5a9c1c4df 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_ctx.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -25,6 +25,10 @@ int process(struct __sk_buff *skb)
 		return 1;
 	if (skb->gso_size !=3D 10)
 		return 1;
+	if (skb->ingress_ifindex !=3D 11)
+		return 1;
+	if (skb->ifindex !=3D 1)
+		return 1;
=20
 	return 0;
 }
--=20
2.30.2

