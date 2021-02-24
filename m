Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD2732479F
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhBXXqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:46:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233804AbhBXXqv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 18:46:51 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ONY1iS169929;
        Wed, 24 Feb 2021 18:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=r7oG9f7cFCsVBhJOpyPEe6H5z2YB6ZeOuQNTJP/y6Jw=;
 b=ixgnvJ61RcCCsuB02RitQt5zq6gWNQeRtnbhb4iFWjEyMhHK3mMclOuNc11KQaqdIepO
 342ZqVHYUhS11RpHAOScH000G4j0v1flk6BQiClr3+3OMBAK2hrTtKDy1t2yMRe1Ly6e
 4rJYWitoyc1cZAxvpQgl3HnU4BquXBdIuqFNk2OShdTBNw5ubwxftaKsNdR4GZ90vtaY
 kUr2oda1MxFGuGk5LwYVLYNnoZnK/Cb6qbdmfYWD87G9PVXflfwKXoo6qk6vhKps9UlR
 oV6GcvwjaDvh86igATr3lIsLKxRKL5SOGoWbn0yUdSa2cROULM8me0yQoWthJYsm3VIM pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wwntnbv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:57 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11ONYUeQ174659;
        Wed, 24 Feb 2021 18:45:57 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wwntnbu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:56 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ONhal4013766;
        Wed, 24 Feb 2021 23:45:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 36tt28a2nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 23:45:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ONjpYC46334314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 23:45:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B25342042;
        Wed, 24 Feb 2021 23:45:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC5214203F;
        Wed, 24 Feb 2021 23:45:50 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 23:45:50 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v6 bpf-next 6/9] bpf: Add BTF_KIND_FLOAT support
Date:   Thu, 25 Feb 2021 00:45:32 +0100
Message-Id: <20210224234535.106970-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224234535.106970-1-iii@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240184
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On the kernel side, introduce a new btf_kind_operations. It is
similar to that of BTF_KIND_INT, however, it does not need to
handle encodings and bit offsets. Do not implement printing, since
the kernel does not know how to format floating-point values.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/btf.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2efeb5f4b343..c405edc8e615 100644
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
@@ -3675,6 +3678,77 @@ static const struct btf_kind_operations datasec_ops = {
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
+	if (t->size != 2 && t->size != 4 && t->size != 8 && t->size != 12 &&
+	    t->size != 16) {
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
+	u64 misalign_bits;
+	u64 align_bytes;
+	u64 align_bits;
+
+	align_bytes = min_t(u64, sizeof(void *), member_type->size);
+	align_bits = align_bytes * BITS_PER_BYTE;
+	div64_u64_rem(member->offset, align_bits, &misalign_bits);
+	if (misalign_bits) {
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
@@ -3808,6 +3882,7 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
 	[BTF_KIND_FUNC_PROTO] = &func_proto_ops,
 	[BTF_KIND_VAR] = &var_ops,
 	[BTF_KIND_DATASEC] = &datasec_ops,
+	[BTF_KIND_FLOAT] = &float_ops,
 };
 
 static s32 btf_check_meta(struct btf_verifier_env *env,
-- 
2.29.2

