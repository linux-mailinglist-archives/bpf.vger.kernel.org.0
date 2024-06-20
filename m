Return-Path: <bpf+bounces-32575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75130910025
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9111C210FF
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E185219FA7E;
	Thu, 20 Jun 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eDEIrtVR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240819DF6C
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875119; cv=none; b=C3TzvXcp0DscI7u6ZbIbIOmu0qUjQgYNsxYSMtGrYSBIY8uhb6c5Fai17aHabfcL+8evUAqImAjySplYQwV3SQVRJJKfSeSkItw20H/FnTECR8KXO1WBgfpnh4N1KONu/6kl2//ij0OrlhAuPCvIt8bFdPfflBOmBLM9QXdNME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875119; c=relaxed/simple;
	bh=b1w21aakMwRs8OtM/G6XdPkWDuxww4+brXiATTqwknU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwdeXfHuB7bzE6O/JNzqgLrZd18a28e0YEZHcdL+3Zbk3tDXAT47b4znDaYaT83c0Ma/V1Nf/3rk84+Zn7nSr/OlndgLurxgBQgZ4FsZsg/grGrVQ5nsnkiIuiga88/ZyU/AxMVKyZOyATtoecBIcz/WxcgplWVhN1yagcZo8kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eDEIrtVR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5FP1b005039;
	Thu, 20 Jun 2024 09:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=M
	js5cDwMJGOx/WvbFkr/FmkMuIlMqZneSjbAPTGAtmQ=; b=eDEIrtVRToCsX/bal
	2wSbJLRqC/tuejrgX8V436GuUU3g1koTuaAzFjOy2ThLGAzmXEKW4+rBNzSboJWX
	pCw32iMfXJ9bruWb/qzkqpQQdgo8v89/T4OIsDhixNOhaRoQ+61fH4ckwCLkpHIY
	4rIfvky3aixdJ1i4p6d7GbZADoC42+643EFdKV7vQ3M5J7A6wgrTmHaH8fUiMs34
	PldzZ+8ASy0NdVRLvoSJ+c1/dtMbwPO47+vPw3sa051Ak06/ydpJqpzuOY2HxaPb
	JCaQBZ8fM42xINs8EnaWJFwexTbjTew5oDhdjj/aeQAXlhjByK2CyCXOqTejOVNL
	6zhYw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9jtqkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:18:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45K7v5KW033150;
	Thu, 20 Jun 2024 09:18:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1da76ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:18:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45K9HdGP028275;
	Thu, 20 Jun 2024 09:18:11 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-186-70.vpn.oracle.com [10.175.186.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1da764t-7;
	Thu, 20 Jun 2024 09:18:11 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 6/6] selftests/bpf: add kfunc_call test for simple dtor in bpf_testmod
Date: Thu, 20 Jun 2024 10:17:33 +0100
Message-ID: <20240620091733.1967885-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620091733.1967885-1-alan.maguire@oracle.com>
References: <20240620091733.1967885-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200065
X-Proofpoint-ORIG-GUID: xcQQ3EwFYad00fs6zDGKeTffxKg-C6ba
X-Proofpoint-GUID: xcQQ3EwFYad00fs6zDGKeTffxKg-C6ba

add simple kfuncs to create/destroy a context type to bpf_testmod,
register them and add a kfunc_call test to use them.  This provides
test coverage for registration of dtor kfuncs from modules.

By transferring the context pointer to a map value as a __kptr
we also trigger the map-based dtor cleanup logic, improving test
coverage.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 46 +++++++++++++++++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  9 ++++
 .../selftests/bpf/prog_tests/kfunc_call.c     |  1 +
 .../selftests/bpf/progs/kfunc_call_test.c     | 37 +++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 49f9a311e49b..fa7f803ea9b5 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -159,6 +159,37 @@ __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 {
 }
 
+__bpf_kfunc struct bpf_testmod_ctx *
+bpf_testmod_ctx_create(int *err)
+{
+	struct bpf_testmod_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | GFP_ATOMIC);
+	if (!ctx) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+	refcount_set(&ctx->usage, 1);
+
+	return ctx;
+}
+
+static void testmod_free_cb(struct rcu_head *head)
+{
+	struct bpf_testmod_ctx *ctx;
+
+	ctx = container_of(head, struct bpf_testmod_ctx, rcu);
+	kfree(ctx);
+}
+
+__bpf_kfunc void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx)
+{
+	if (!ctx)
+		return;
+	if (refcount_dec_and_test(&ctx->usage))
+		call_rcu(&ctx->rcu, testmod_free_cb);
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -369,8 +400,14 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
+BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
+BTF_ID_LIST(bpf_testmod_dtor_ids)
+BTF_ID(struct, bpf_testmod_ctx)
+BTF_ID(func, bpf_testmod_ctx_release)
+
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &bpf_testmod_common_kfunc_ids,
@@ -904,6 +941,12 @@ extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
 {
+	const struct btf_id_dtor_kfunc bpf_testmod_dtors[] = {
+		{
+			.btf_id		= bpf_testmod_dtor_ids[0],
+			.kfunc_btf_id	= bpf_testmod_dtor_ids[1]
+		},
+	};
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_testmod_common_kfunc_set);
@@ -912,6 +955,9 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
+	ret = ret ?: register_btf_id_dtor_kfuncs(bpf_testmod_dtors,
+						 ARRAY_SIZE(bpf_testmod_dtors),
+						 THIS_MODULE);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index f9809517e7fa..e587a79f2239 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -80,6 +80,11 @@ struct sendmsg_args {
 	int msglen;
 };
 
+struct bpf_testmod_ctx {
+	struct callback_head	rcu;
+	refcount_t		usage;
+};
+
 struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
 void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
@@ -135,4 +140,8 @@ int bpf_kfunc_call_kernel_getsockname(struct addr_args *args) __ksym;
 int bpf_kfunc_call_kernel_getpeername(struct addr_args *args) __ksym;
 
 void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr, struct bpf_dynptr *ptr__nullable) __ksym;
+
+struct bpf_testmod_ctx *bpf_testmod_ctx_create(int *err) __ksym;
+void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 2eb71559713c..5b743212292f 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -78,6 +78,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	SYSCALL_TEST(kfunc_syscall_test, 0),
 	SYSCALL_NULL_CTX_TEST(kfunc_syscall_test_null, 0),
 	TC_TEST(kfunc_call_test_static_unused_arg, 0),
+	TC_TEST(kfunc_call_ctx, 0),
 };
 
 struct syscall_test_args {
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index cf68d1e48a0f..f502f755f567 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -177,4 +177,41 @@ int kfunc_call_test_static_unused_arg(struct __sk_buff *skb)
 	return actual != expected ? -1 : 0;
 }
 
+struct ctx_val {
+	struct bpf_testmod_ctx __kptr *ctx;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct ctx_val);
+} ctx_map SEC(".maps");
+
+SEC("tc")
+int kfunc_call_ctx(struct __sk_buff *skb)
+{
+	struct bpf_testmod_ctx *ctx;
+	int err = 0;
+
+	ctx = bpf_testmod_ctx_create(&err);
+	if (!ctx && !err)
+		err = -1;
+	if (ctx) {
+		int key = 0;
+		struct ctx_val *ctx_val = bpf_map_lookup_elem(&ctx_map, &key);
+
+		/* Transfer ctx to map to be freed via implicit dtor call
+		 * on cleanup.
+		 */
+		if (ctx_val)
+			ctx = bpf_kptr_xchg(&ctx_val->ctx, ctx);
+		if (ctx) {
+			bpf_testmod_ctx_release(ctx);
+			err = -1;
+		}
+	}
+	return err;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.31.1


