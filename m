Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3031C4E4
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 02:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhBPBN5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 20:13:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhBPBN4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Feb 2021 20:13:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11G12r8U078813;
        Mon, 15 Feb 2021 20:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nC0vyV4nVFTiRoylxm/gAPFxzV58LQfet+fHGZSB66A=;
 b=M5xCu9VGq7e/RxLo2/UR6PQuDQNWo0gLFiu0fKLU3pt8HZIQCfSELZ4sLfWny9kmZ2m1
 RH2blnklV0AfO8DNcyxjkIdw5Rbfh3m7aLSi5ixrRI5H03PznVhMS9vH24pf4GDkcAWn
 ne8bxIh9rN/5dC2pNM3sDwTLM5/QKJSuGLwb3PqLA2koBVXwGgwofDJbBz2492uLGCmE
 0jNV7z5dsQpJxICq43knyscw7/UA1rv3/aR6rKSBqOjnitNc+YBuBRMdf6Dj+Wl/mhGN
 xApRCsctj+72LbdwfWC0w6Y1T1t8OO11QhRit6Fpy9efqp6vBEv1xdQjV4gU0V65AezU LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r3u20fsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:13:02 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11G18EOL101295;
        Mon, 15 Feb 2021 20:13:02 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r3u20frn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:13:02 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11G1C8Lj020434;
        Tue, 16 Feb 2021 01:12:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 36p6d896qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 01:12:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11G1CuL63015386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 01:12:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADAFF11C04C;
        Tue, 16 Feb 2021 01:12:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 058D611C04A;
        Tue, 16 Feb 2021 01:12:56 +0000 (GMT)
Received: from vm.lan (unknown [9.171.16.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Feb 2021 01:12:55 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 4/6] bpf: Add BTF_KIND_FLOAT support
Date:   Tue, 16 Feb 2021 02:12:14 +0100
Message-Id: <20210216011216.3168-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210216011216.3168-1-iii@linux.ibm.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160008
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On the kernel side, introduce a new btf_kind_operations. It is
similar to that of BTF_KIND_INT, however, it does not need to
handle encodings and bit offsets. Do not implement printing, since
the kernel does not know how to format floating-point values.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/btf.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2efeb5f4b343..6c73e5484409 100644
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
@@ -3675,6 +3678,64 @@ static const struct btf_kind_operations datasec_ops = {
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
+	u64 end_offset_bytes;
+	u64 end_offset_bits;
+	u64 offset_bits;
+	u64 size_bits;
+
+	size_bits = member_type->size * BITS_PER_BYTE;
+	offset_bits = member->offset;
+	end_offset_bits = offset_bits + size_bits;
+	end_offset_bytes = BITS_ROUNDUP_BYTES(end_offset_bits);
+
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
@@ -3808,6 +3869,7 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
 	[BTF_KIND_FUNC_PROTO] = &func_proto_ops,
 	[BTF_KIND_VAR] = &var_ops,
 	[BTF_KIND_DATASEC] = &datasec_ops,
+	[BTF_KIND_FLOAT] = &float_ops,
 };
 
 static s32 btf_check_meta(struct btf_verifier_env *env,
-- 
2.29.2

