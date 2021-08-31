Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FFC3FC188
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 05:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbhHaDfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 23:35:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24118 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237314AbhHaDfC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 23:35:02 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17V3Xq8p025761
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 20:34:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=zTq1PTtC1cN/SVWNCK6qUqGysaJurAVTDTcvFvOzZuY=;
 b=hns+yT8haZSCdDNcSUJ0oeL1k2bjqA8UIujNz11c3k6Do8HSSi50vVJGKFn0prB+E7pi
 aE+QgV+/91HUbGQijPWiu+VBrN4JL3khrkjw/UTir+qw9WbadsZKYgsMXSqR+0HeH7Mf
 N7L9tKdZCRXaT014Jrg5JW90FQfdwx754Ms= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aryqs4t63-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Aug 2021 20:34:08 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 20:34:07 -0700
Received: by devvm2049.vll0.facebook.com (Postfix, from userid 197479)
        id 240C93288941; Mon, 30 Aug 2021 20:34:02 -0700 (PDT)
From:   Neil Spring <ntspring@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Neil Spring <ntspring@fb.com>
Subject: [PATCH bpf-next v3] bpf testing: permit ingress_ifindex in bpf_prog_test_run_xattr
Date:   Mon, 30 Aug 2021 20:33:56 -0700
Message-ID: <20210831033356.1459316-1-ntspring@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: mJHBkR9YR_xV-gT2hZaVGsKgzOYpEJsA
X-Proofpoint-ORIG-GUID: mJHBkR9YR_xV-gT2hZaVGsKgzOYpEJsA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-30_06:2021-08-30,2021-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310018
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
v3 - correct faulty check in self-test=20
v2 - correct mistaken removal of a prior test of ifindex

 net/bpf/test_run.c                               | 8 +++-----
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c | 5 +++++
 tools/testing/selftests/bpf/progs/test_skb_ctx.c | 4 ++++
 3 files changed, 12 insertions(+), 5 deletions(-)

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
index fafeddaad6a9..2bf8c687348b 100644
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
@@ -97,6 +98,10 @@ void test_skb_ctx(void)
 		   "ctx_out_ifindex",
 		   "skb->ifindex =3D=3D %d, expected %d\n",
 		   skb.ifindex, 1);
+	CHECK_ATTR(skb.ingress_ifindex !=3D 11,
+		   "ctx_out_ingress_ifindex",
+		   "skb->ingress_ifindex =3D=3D %d, expected %d\n",
+		   skb.ingress_ifindex, 11);
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

