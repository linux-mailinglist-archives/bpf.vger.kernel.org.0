Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8EE3F675A
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbhHXRdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Aug 2021 13:33:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47730 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241859AbhHXRbC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Aug 2021 13:31:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17OHTxhK000732
        for <bpf@vger.kernel.org>; Tue, 24 Aug 2021 10:30:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mAarDSrOXh67BgF0GOh8xEYrVVU4/RyN3kff3u/LDg8=;
 b=XshBXljZfU1OTJptgkfBSAd7PHArbfIGPG3QN1OZBba2CZ6CXrTPl5cVRXu3mZ9CfFem
 r9h3u8YDhJLi0/pyJhch4fgD0G6KhBpDJoOWhwPjyraGFonVuRhiJCVM3omWXskyTDJX
 0RI5Gb6JDVcszmdqCqE1NKs27SPB3mGJ39s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3amek7redv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 24 Aug 2021 10:30:16 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 10:30:15 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 8D43C2940D05; Tue, 24 Aug 2021 10:30:13 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Subject: [PATCH v2 bpf-next 2/4] bpf: selftests: Add sk_state to bpf_tcp_helpers.h
Date:   Tue, 24 Aug 2021 10:30:13 -0700
Message-ID: <20210824173013.3977316-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210824173000.3976470-1-kafai@fb.com>
References: <20210824173000.3976470-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: DDgVydsNum6E4WQ81VSJm5CTd-2xHU2i
X-Proofpoint-ORIG-GUID: DDgVydsNum6E4WQ81VSJm5CTd-2xHU2i
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_05:2021-08-24,2021-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108240115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add sk_state define to bpf_tcp_helpers.h.  Rename the existing
global variable "sk_state" in the kfunc_call test to "sk_state_res".

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h               | 1 +
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c         | 2 +-
 tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_tcp_helpers.h
index c9f9bdad60c7..b1ede6f0b821 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -31,6 +31,7 @@ enum sk_pacing {
=20
 struct sock {
 	struct sock_common	__sk_common;
+#define sk_state		__sk_common.skc_state
 	unsigned long		sk_pacing_rate;
 	__u32			sk_pacing_status; /* see enum sk_pacing */
 } __attribute__((preserve_access_index));
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/=
testing/selftests/bpf/prog_tests/kfunc_call.c
index 30a7b9b837bf..9611f2bc50df 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -44,7 +44,7 @@ static void test_subprog(void)
 	ASSERT_OK(err, "bpf_prog_test_run(test1)");
 	ASSERT_EQ(retval, 10, "test1-retval");
 	ASSERT_NEQ(skel->data->active_res, -1, "active_res");
-	ASSERT_EQ(skel->data->sk_state, BPF_TCP_CLOSE, "sk_state");
+	ASSERT_EQ(skel->data->sk_state_res, BPF_TCP_CLOSE, "sk_state_res");
=20
 	kfunc_call_test_subprog__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c =
b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
index b2dcb7d9cb03..5fbd9e232d44 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
@@ -9,7 +9,7 @@ extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 =
a, __u64 b,
 				  __u32 c, __u64 d) __ksym;
 extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
 int active_res =3D -1;
-int sk_state =3D -1;
+int sk_state_res =3D -1;
=20
 int __noinline f1(struct __sk_buff *skb)
 {
@@ -28,7 +28,7 @@ int __noinline f1(struct __sk_buff *skb)
 	if (active)
 		active_res =3D *active;
=20
-	sk_state =3D bpf_kfunc_call_test3((struct sock *)sk)->__sk_common.skc_s=
tate;
+	sk_state_res =3D bpf_kfunc_call_test3((struct sock *)sk)->sk_state;
=20
 	return (__u32)bpf_kfunc_call_test1((struct sock *)sk, 1, 2, 3, 4);
 }
--=20
2.30.2

