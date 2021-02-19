Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AEF31F3FF
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 03:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhBSC1m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 21:27:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229746AbhBSC1m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 21:27:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11J2KgxN004207;
        Thu, 18 Feb 2021 21:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=15EVPnv43T+raAtbvrlRk4Ei6VauUfuv6BLBSDAxZlA=;
 b=QXANkGaWwIO09ESWMZfCq2hKKG+bIPzKT/QGh9HLx1rLta/XIWF1NoHiPn5kGx/YR7Ws
 5GI5tmKJooQV01YfxprzfplhZN2bIcWIZLiiyFlK0YdXigSAaLnGHbnSeX168E6PV7Ag
 xLOoTwwi+wOPvC5NIj+ojE9nz5YJA1YM2x5EoyA/x5+FodXKFq55NAnhBK62jNT9apwJ
 0lYLhpriUfdIiIuT3XDjLuIhK22Ziao5aEVruvH7wSyPhOUUe/G7rFy0J/LV4JPZUTFh
 8Gsn6F+rsPzakvx1PXhZc7oSR9TiSPj2fF5tqZsw7U18XgJFcF9a3cbH8NQuGk0Zlg9o 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t4fcr21h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:26:46 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11J2P9Ww034039;
        Thu, 18 Feb 2021 21:26:46 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t4fcr20t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:26:45 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11J2MBFo012047;
        Fri, 19 Feb 2021 02:26:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 36p6d8jqab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 02:26:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11J2QeY135520988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 02:26:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA5C0A4053;
        Fri, 19 Feb 2021 02:26:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E484A404D;
        Fri, 19 Feb 2021 02:26:40 +0000 (GMT)
Received: from vm.lan (unknown [9.145.178.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 02:26:40 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next 4/6] bpf: Add BTF_KIND_FLOAT support
Date:   Fri, 19 Feb 2021 03:25:41 +0100
Message-Id: <20210219022543.20893-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219022543.20893-1-iii@linux.ibm.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_14:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190007
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On the kernel side, introduce a new btf_kind_operations. It is
similar to that of BTF_KIND_INT, however, it does not need to
handle encodings and bit offsets. Do not implement printing, since
the kernel does not know how to format floating-point values.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/btf.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2efeb5f4b343..0e7555077570 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -173,7 +173,7 @@
 #define BITS_ROUNDUP_BYTES(bits) \
 	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
 
-#define BTF_INFO_MASK 0x8f00ffff
+#define BTF_INFO_MASK 0x9f00ffff
 #define BTF_INT_MASK 0x0fffffff
 #define BTF_TYPE_ID_VALID(type_id) ((type_id) <= BTF_MAX_TYPE)
 #define BTF_STR_OFFSET_VALID(name_off) ((name_off) <= BTF_MAX_NAME_OFFSET)
@@ -280,6 +280,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
 	[BTF_KIND_VAR]		= "VAR",
 	[BTF_KIND_DATASEC]	= "DATASEC",
+	[BTF_KIND_FLOAT]	= "FLOAT",
 };
 
 static const char *btf_type_str(const struct btf_type *t)
@@ -574,6 +575,7 @@ static bool btf_type_has_size(const struct btf_type *t)
 	case BTF_KIND_UNION:
 	case BTF_KIND_ENUM:
 	case BTF_KIND_DATASEC:
+	case BTF_KIND_FLOAT:
 		return true;
 	}
 
@@ -1704,6 +1706,7 @@ __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 		case BTF_KIND_STRUCT:
 		case BTF_KIND_UNION:
 		case BTF_KIND_ENUM:
+		case BTF_KIND_FLOAT:
 			size = type->size;
 			goto resolved;
 
@@ -1849,7 +1852,7 @@ static int btf_df_check_kflag_member(struct btf_verifier_env *env,
 	return -EINVAL;
 }
 
-/* Used for ptr, array and struct/union type members.
+/* Used for ptr, array struct/union and float type members.
  * int, enum and modifier types have their specific callback functions.
  */
 static int btf_generic_check_kflag_member(struct btf_verifier_env *env,
@@ -3675,6 +3678,74 @@ static const struct btf_kind_operations datasec_ops = {
 	.show			= btf_datasec_show,
 };
 
+static s32 btf_float_check_meta(struct btf_verifier_env *env,
+				const struct btf_type *t,
+				u32 meta_left)
+{
+	if (btf_type_vlen(t)) {
+		btf_verifier_log_type(env, t, "vlen != 0");
+		return -EINVAL;
+	}
+
+	if (btf_type_kflag(t)) {
+		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
+		return -EINVAL;
+	}
+
+	if (t->size != 2 && t->size % 4) {
+		btf_verifier_log_type(env, t, "Invalid type_size");
+		return -EINVAL;
+	}
+
+	btf_verifier_log_type(env, t, NULL);
+
+	return 0;
+}
+
+static int btf_float_check_member(struct btf_verifier_env *env,
+				  const struct btf_type *struct_type,
+				  const struct btf_member *member,
+				  const struct btf_type *member_type)
+{
+	u64 start_offset_bytes;
+	u64 end_offset_bytes;
+	u64 align_bytes;
+	u64 align_bits;
+
+	align_bytes = min_t(u64, sizeof(void *), member_type->size);
+	align_bits = align_bytes * BITS_PER_BYTE;
+	if (member->offset % align_bits) {
+		btf_verifier_log_member(env, struct_type, member,
+					"Member is not properly aligned");
+		return -EINVAL;
+	}
+
+	start_offset_bytes = member->offset / BITS_PER_BYTE;
+	end_offset_bytes = start_offset_bytes + member_type->size;
+	if (end_offset_bytes > struct_type->size) {
+		btf_verifier_log_member(env, struct_type, member,
+					"Member exceeds struct_size");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void btf_float_log(struct btf_verifier_env *env,
+			  const struct btf_type *t)
+{
+	btf_verifier_log(env, "size=%u", t->size);
+}
+
+static const struct btf_kind_operations float_ops = {
+	.check_meta = btf_float_check_meta,
+	.resolve = btf_df_resolve,
+	.check_member = btf_float_check_member,
+	.check_kflag_member = btf_generic_check_kflag_member,
+	.log_details = btf_float_log,
+	.show = btf_df_show,
+};
+
 static int btf_func_proto_check(struct btf_verifier_env *env,
 				const struct btf_type *t)
 {
@@ -3808,6 +3879,7 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
 	[BTF_KIND_FUNC_PROTO] = &func_proto_ops,
 	[BTF_KIND_VAR] = &var_ops,
 	[BTF_KIND_DATASEC] = &datasec_ops,
+	[BTF_KIND_FLOAT] = &float_ops,
 };
 
 static s32 btf_check_meta(struct btf_verifier_env *env,
-- 
2.29.2

