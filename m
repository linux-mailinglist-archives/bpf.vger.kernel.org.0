Return-Path: <bpf+bounces-57045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C373AA4DC1
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 15:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D9C4E2A07
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15525CC48;
	Wed, 30 Apr 2025 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F7Er8CFp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E525D526
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020628; cv=none; b=anomryEiJuRtTpSNgdpfOe9FoP9cuAof9kb7mA0/dGYLMYpS9572s00tn4TQBumpOc73Gb8qaTa43u8UZ4jkTPq9qUKZWHIdSmfJrTGDKV8L04gQ/2sr0rf+0F/1hEzsK4z3Qej3X074YHbx3/A5zboLWA3Gs4LHvDZEtuIA9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020628; c=relaxed/simple;
	bh=JmKx87o1lXESOgh/9HcrOViZVsbtrwDH0iP1zd+BkVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4LKsGQRk8BJJHTu+kpEGRLUeS1mPq3XH+bsjb7lyLFoXm8Iw5hAAy7GuEa/KRUEnaGvFv+SBxUQoVe+Dep8gttkzy434+28dNWDPTJI/TwQZMwCyH4S0lqt8ek43j9ilmFNETC5r1kS8ckbKDoQQjwxTkSHfgg6PKjxFL0GYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F7Er8CFp; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDaenF004588;
	Wed, 30 Apr 2025 13:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=PL1nNgIdrZiIKfzuAcX4W3i6bYZ/p
	yco7Rr8sF+p5go=; b=F7Er8CFpvQOybTi3Gg4MKdwQ4lxJJ/Ooyhy3gT4TTTp+t
	mJVRjpz1VtOjvAoxhAXWBSPPbp3cUSV35QvvnvjJqxJGQVIqhEtMcs9CyVN6UNww
	KJYYnHsM0RS5R0grzh1eOjqLJJjNLviiy1o1qFcW9oPHa1vagIrBU2I0uj+vOpqF
	MBcv59ksPnBWYKRM/K/kcjnfidc7k6wh6hn7LYPZdeNDFL/W7hopKehtfogWblZK
	U50eHpOrwFhLIDYX4JsQ+LU5VVrW6d8o50s4A+R0oCAj21nF9x+4VqrXROJ+N6/N
	ZNPH17tLWfDPxsdPKucQtmapcK4zeg+cgbhGSkqiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uks77g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 13:43:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDfNQ9013889;
	Wed, 30 Apr 2025 13:43:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbbgmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 13:43:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53UDhI4P006259;
	Wed, 30 Apr 2025 13:43:18 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-61-220.vpn.oracle.com [10.154.61.220])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 468nxbbg39-1;
	Wed, 30 Apr 2025 13:43:18 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] selftests/bpf: add btf dedup test covering module BTF dedup
Date: Wed, 30 Apr 2025 14:42:49 +0100
Message-ID: <20250430134249.2451066-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA5NyBTYWx0ZWRfX0ibXEgcv2c+1 8QyW4mSi1dcNIqLZaMxCKwLHHgfWmKiJS2Zffv67cEj/pZQEYXLPOxeWUXkcDIjoV74CIFnDfmu GkTeq/O/AT4fVQfHWzNeD3KcgdnSLBEI2c5c27Qmm91deiyHEkTAEJAmRb1FZt0BKpkwLVaSN8k
 /nELtt6ZKDRcgA28zFaHJVWZpMO8Pf9C/KCZAYZzCpGXM7ToEK6gfIQfMSwjuyz+VWB4F4tJNM+ lEcR3oVOOEtd+FXti1MFmSf2sOAs6L17ORM/MNfMBBLYEhRbA4mm6TK0/ye+HqIiecKyux3E6Go 5yONkVH9tPV5qWrkJYpIbuEiRLOgKVPXv3NyiaeLqtYRQRA/bViR3dExal8+aKs3k1/OCxGgsbl
 JopsQh8tvQsKzAU7RCoq/L3GnrMknln1TYpnoDNd+gzbWU6s8rNgKc+YfAPrQwM/eHT6ISuL
X-Proofpoint-GUID: KX1xyL91T78nxweLEGHPb3iL1_G1zWO0
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=681228fe b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=jTnpDDsp8MPth1Gh5K4A:9
X-Proofpoint-ORIG-GUID: KX1xyL91T78nxweLEGHPb3iL1_G1zWO0

Recently issues were observed with module BTF deduplication failures
[1].  Add a dedup selftest that ensures that core kernel types are
referenced from split BTF as base BTF types.  To do this use bpf_testmod
functions which utilize core kernel types, specifically

ssize_t
bpf_testmod_test_write(struct file *file, struct kobject *kobj,
                       struct bin_attribute *bin_attr,
                       char *buf, loff_t off, size_t len);

__bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk);

__bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb);

For each of these ensure that the types they reference -
struct file, struct kobject, struct bin_attr etc - are in base BTF.
Note that because bpf_testmod.ko is built with distilled base BTF
the associated reference types - i.e. the PTR that points at a
"struct file" - will be in split BTF.  As a result the test resolves
typedef and pointer references and verifies the pointed-at or
typedef'ed type is in base BTF.  Because we use BTF from
/sys/kernel/btf/bpf_testmod relocation has occurred for the
referenced types and they will be base - not distilled base - types.

For large-scale dedup issues, we see such types appear in split BTF and
as a result this test fails.  Hence it is proposed as a test which will
fail when large-scale dedup issues have occurred.

[1] https://lore.kernel.org/dwarves/CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/prog_tests/btf_dedup_split.c          | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index d9024c7a892a..5bc15bb6b7ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -440,6 +440,105 @@ static void test_split_dup_struct_in_cu()
 	btf__free(btf1);
 }
 
+/* Ensure module split BTF dedup worked correctly; when dedup fails badly
+ * core kernel types are in split BTF also, so ensure that references to
+ * such types point at base - not split - BTF.
+ *
+ * bpf_testmod_test_write() has multiple core kernel type parameters;
+ *
+ * ssize_t
+ * bpf_testmod_test_write(struct file *file, struct kobject *kobj,
+ *                        struct bin_attribute *bin_attr,
+ *                        char *buf, loff_t off, size_t len);
+ *
+ * Ensure each of the FUNC_PROTO params is a core kernel type.
+ *
+ * Do the same for
+ *
+ * __bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk);
+ *
+ * ...and
+ *
+ * __bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb);
+ *
+ */
+const char *mod_funcs[] = {
+	"bpf_testmod_test_write",
+	"bpf_kfunc_call_test3",
+	"bpf_kfunc_call_test_pass_ctx"
+};
+
+static void test_split_module(void)
+{
+	struct btf *vmlinux_btf, *btf1 = NULL;
+	int i, nr_base_types;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "vmlinux_btf"))
+		return;
+	nr_base_types = btf__type_cnt(vmlinux_btf);
+	if (!ASSERT_GT(nr_base_types, 0, "nr_base_types"))
+		goto cleanup;
+
+	btf1 = btf__parse_split("/sys/kernel/btf/bpf_testmod", vmlinux_btf);
+	if (!ASSERT_OK_PTR(btf1, "split_btf"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(mod_funcs); i++) {
+		const struct btf_param *p;
+		const struct btf_type *t;
+		__u16 vlen;
+		__u32 id;
+		int j;
+
+		id = btf__find_by_name_kind(btf1, mod_funcs[i], BTF_KIND_FUNC);
+		if (!ASSERT_GE(id, nr_base_types, "func_id"))
+			goto cleanup;
+		t = btf__type_by_id(btf1, id);
+		if (!ASSERT_OK_PTR(t, "func_id_type"))
+			goto cleanup;
+		t = btf__type_by_id(btf1, t->type);
+		if (!ASSERT_OK_PTR(t, "func_proto_id_type"))
+			goto cleanup;
+		if (!ASSERT_EQ(btf_is_func_proto(t), true, "is_func_proto"))
+			goto cleanup;
+		vlen = btf_vlen(t);
+
+		for (j = 0, p = btf_params(t); j < vlen; j++, p++) {
+			/* bpf_testmod uses resilient split BTF, so any
+			 * reference types will be added to split BTF and their
+			 * associated targets will be base BTF types; for example
+			 * for a "struct sock *" the PTR will be in split BTF
+			 * while the "struct sock" will be in base.
+			 *
+			 * In some cases like loff_t we have to resolve
+			 * multiple typedefs hence the while() loop below.
+			 *
+			 * Note that resilient split BTF generation depends
+			 * on pahole version, so we do not assert that
+			 * reference types are in split BTF, as if pahole
+			 * does not support resilient split BTF they will
+			 * also be base BTF types.
+			 */
+			id = p->type;
+			do {
+				t = btf__type_by_id(btf1, id);
+				if (!ASSERT_OK_PTR(t, "param_ref_type"))
+					goto cleanup;
+				if (!btf_is_mod(t) && !btf_is_ptr(t) && !btf_is_typedef(t))
+					break;
+				id = t->type;
+			} while (true);
+
+			if (!ASSERT_LT(id, nr_base_types, "verify_base_type"))
+				goto cleanup;
+		}
+	}
+cleanup:
+	btf__free(btf1);
+	btf__free(vmlinux_btf);
+}
+
 void test_btf_dedup_split()
 {
 	if (test__start_subtest("split_simple"))
@@ -450,4 +549,6 @@ void test_btf_dedup_split()
 		test_split_fwd_resolve();
 	if (test__start_subtest("split_dup_struct_in_cu"))
 		test_split_dup_struct_in_cu();
+	if (test__start_subtest("split_module"))
+		test_split_module();
 }
-- 
2.39.3


