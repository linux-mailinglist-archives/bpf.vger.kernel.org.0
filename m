Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7305458BC1D
	for <lists+bpf@lfdr.de>; Sun,  7 Aug 2022 19:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiHGRve (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Aug 2022 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiHGRvc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Aug 2022 13:51:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16755FC7
        for <bpf@vger.kernel.org>; Sun,  7 Aug 2022 10:51:31 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 277DR1fU001046
        for <bpf@vger.kernel.org>; Sun, 7 Aug 2022 10:51:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wM2JykMaqBkqcD8bYFA4Dc3w1MA5CPTTb9Nix03SiOM=;
 b=dsNlk1WMySTPCOeOTTcEDfTIaE5v7IM2XuQuemaSee3lnVVNMjgTH/7UDXgbO0CWGmsd
 NOnVji3cmBetKDg2bKqvKAX6mgRFHwU4YHIJL2p1KTXcy/qA+RUzI1QjPqxwMKeRrR6c
 U1BNcnssBYoEslS461XMBz0izbJrM8CCZt0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hskmndyk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Aug 2022 10:51:31 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 10:51:30 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 02194DC759C4; Sun,  7 Aug 2022 10:51:27 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add tests with u8/s16 kfunc return types
Date:   Sun, 7 Aug 2022 10:51:26 -0700
Message-ID: <20220807175126.4179877-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220807175111.4178812-1-yhs@fb.com>
References: <20220807175111.4178812-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Zo2DvCL0wPmYUfModJt8brimn6AXSeQ9
X-Proofpoint-GUID: Zo2DvCL0wPmYUfModJt8brimn6AXSeQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_11,2022-08-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two program tests with kfunc return types u8/s16.
With previous patch, xlated codes looks like below:
  ...
  ; return bpf_kfunc_call_test4((struct sock *)sk, (1 << 16) + 0xff00, (1=
 << 16) + 0xff);
     5: (bf) r1 =3D r0
     6: (b4) w2 =3D 130816
     7: (b4) w3 =3D 65791
     8: (85) call bpf_kfunc_call_test4#8931696
     9: (67) r0 <<=3D 48
    10: (c7) r0 s>>=3D 48
    11: (bc) w6 =3D w0
  ; }
    12: (bc) w0 =3D w6
    13: (95) exit
  ...
  ; return bpf_kfunc_call_test5((struct sock *)sk, (1 << 8) + 1, (1 << 8)=
 + 2);
     5: (bf) r1 =3D r0
     6: (b4) w2 =3D 257
     7: (b4) w3 =3D 258
     8: (85) call bpf_kfunc_call_test5#8931712
     9: (67) r0 <<=3D 56
    10: (77) r0 >>=3D 56
    11: (bc) w6 =3D w0
  ; }
    12: (bc) w0 =3D w6
    13: (95) exit

For return type s16, proper sign extension for the return value is done
for kfunc bpf_kfunc_call_test4(). For return type s8, proper zero
extension for the return value is done for bpf_kfunc_call_test5().

Without the previous patch, the test kfunc_call will fail with
  ...
  test_main:FAIL:test4-retval unexpected test4-retval: actual 196607 !=3D=
 expected 4294967295
  ...
  test_main:FAIL:test5-retval unexpected test5-retval: actual 515 !=3D ex=
pected 3

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 net/bpf/test_run.c                            | 12 +++++++
 .../selftests/bpf/prog_tests/kfunc_call.c     | 10 ++++++
 .../selftests/bpf/progs/kfunc_call_test.c     | 32 +++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index cbc9cd5058cb..3a17ab4107f5 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -551,6 +551,16 @@ struct sock * noinline bpf_kfunc_call_test3(struct s=
ock *sk)
 	return sk;
 }
=20
+s16 noinline bpf_kfunc_call_test4(struct sock *sk, u32 a, u32 b)
+{
+	return a + b;
+}
+
+u8 noinline bpf_kfunc_call_test5(struct sock *sk, u32 a, u32 b)
+{
+	return a + b;
+}
+
 struct prog_test_member1 {
 	int a;
 };
@@ -703,6 +713,8 @@ BTF_SET8_START(test_sk_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL=
)
 BTF_ID_FLAGS(func, bpf_kfunc_call_memb_acquire, KF_ACQUIRE | KF_RET_NULL=
)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_release, KF_RELEASE)
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/=
testing/selftests/bpf/prog_tests/kfunc_call.c
index c00eb974eb85..a355c98080f2 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -35,6 +35,16 @@ static void test_main(void)
 	ASSERT_OK(err, "bpf_prog_test_run(test_ref_btf_id)");
 	ASSERT_EQ(topts.retval, 0, "test_ref_btf_id-retval");
=20
+	prog_fd =3D skel->progs.kfunc_call_test4.prog_fd;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run(test4)");
+	ASSERT_EQ(topts.retval, 0xffffffff, "test4-retval");
+
+	prog_fd =3D skel->progs.kfunc_call_test5.prog_fd;
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run(test5)");
+	ASSERT_EQ(topts.retval, 3, "test5-retval");
+
 	kfunc_call_test_lskel__destroy(skel);
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/=
testing/selftests/bpf/progs/kfunc_call_test.c
index 5aecbb9fdc68..0636cb13e574 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -6,6 +6,8 @@
 extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksy=
m;
 extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				  __u32 c, __u64 d) __ksym;
+extern __s16 bpf_kfunc_call_test4(struct sock *sk, __u32 a, __u32 b) __k=
sym;
+extern __u8 bpf_kfunc_call_test5(struct sock *sk, __u32 a, __u32 b) __ks=
ym;
=20
 extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned =
long *sp) __ksym;
 extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) _=
_ksym;
@@ -30,6 +32,36 @@ int kfunc_call_test2(struct __sk_buff *skb)
 	return bpf_kfunc_call_test2((struct sock *)sk, 1, 2);
 }
=20
+SEC("tc")
+int kfunc_call_test4(struct __sk_buff *skb)
+{
+	struct bpf_sock *sk =3D skb->sk;
+
+	if (!sk)
+		return -1;
+
+	sk =3D bpf_sk_fullsock(sk);
+	if (!sk)
+		return -1;
+
+	return bpf_kfunc_call_test4((struct sock *)sk, (1 << 16) + 0xff00, (1 <=
< 16) + 0xff);
+}
+
+SEC("tc")
+int kfunc_call_test5(struct __sk_buff *skb)
+{
+	struct bpf_sock *sk =3D skb->sk;
+
+	if (!sk)
+		return -1;
+
+	sk =3D bpf_sk_fullsock(sk);
+	if (!sk)
+		return -1;
+
+	return bpf_kfunc_call_test5((struct sock *)sk, (1 << 8) + 1, (1 << 8) +=
 2);
+}
+
 SEC("tc")
 int kfunc_call_test1(struct __sk_buff *skb)
 {
--=20
2.30.2

