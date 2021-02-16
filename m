Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B68831C4E5
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 02:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBPBOE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 20:14:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229710AbhBPBOD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Feb 2021 20:14:03 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11G11bVZ002062;
        Mon, 15 Feb 2021 20:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Vj/Bi+yR+usvs3XiqCs6IODUdBRFJ7Yw0/OOwNyTUHE=;
 b=Ha3wwmXqMsZpbwWIMW3aSeNEhplqx3gGZAHIqzk4BCHrXW4gjrLC0B1TLIIc8hyoNQe7
 2v8M9Jf9VFVqXoLCtN0/Cwbv/AAtFJ6mP8c428ZuiSBLue8/8WjsNTfcOzw8HNa4X2cp
 ncbMSxztu1jyEUA9PMT1xaS7H1pTxrHkpLEslbLBSjIWk7K6MvJEZrgQk8vs8ei5D9pQ
 1gRkad/o7dlnICjZaWJEx6w/KSMFTIB+v0CvY6bViP4+vb1WgK/f95yZL5yLILVNE5KK
 ZruZsKJT6scF2EYEZ/W3Bil8k80V8RXLy7vnICT5yBH7BPW6pF5rWkLxhWBRo2/T1sWY oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36r2dwabpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:13:09 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11G11owV003220;
        Mon, 15 Feb 2021 20:13:08 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36r2dwabp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:13:08 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11G1D6kD002247;
        Tue, 16 Feb 2021 01:13:06 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 36p6d8h6r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 01:13:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11G1D4wn66060786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 01:13:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E403E11C052;
        Tue, 16 Feb 2021 01:13:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43F3B11C04C;
        Tue, 16 Feb 2021 01:13:03 +0000 (GMT)
Received: from vm.lan (unknown [9.171.16.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Feb 2021 01:13:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 5/6] selftest/bpf: Add BTF_KIND_FLOAT tests
Date:   Tue, 16 Feb 2021 02:12:15 +0100
Message-Id: <20210216011216.3168-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210216011216.3168-1-iii@linux.ibm.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160003
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test the good variants as well as the potential malformed ones.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/btf_helpers.c    |  4 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 84 ++++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |  3 +
 3 files changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index 48f90490f922..b692e6ead9b5 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -23,6 +23,7 @@ static const char * const btf_kind_str_mapping[] = {
 	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
 	[BTF_KIND_VAR]		= "VAR",
 	[BTF_KIND_DATASEC]	= "DATASEC",
+	[BTF_KIND_FLOAT]	= "FLOAT",
 };
 
 static const char *btf_kind_str(__u16 kind)
@@ -173,6 +174,9 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
 		}
 		break;
 	}
+	case BTF_KIND_FLOAT:
+		fprintf(out, " size=%u", t->size);
+		break;
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 6a7ee7420701..a15a826e73b2 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3531,6 +3531,89 @@ static struct btf_raw_test raw_tests[] = {
 	.max_entries = 1,
 },
 
+{
+	.descr = "float test #1, well-formed",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_FLOAT_ENC(1, 2),			/* [2] */
+		BTF_TYPE_FLOAT_ENC(10, 4),			/* [3] */
+		BTF_TYPE_FLOAT_ENC(16, 8),			/* [4] */
+		BTF_TYPE_FLOAT_ENC(23, 16),			/* [5] */
+		BTF_STRUCT_ENC(35, 4, 30),			/* [6] */
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 3, 16),
+		BTF_MEMBER_ENC(NAME_TBD, 4, 48),
+		BTF_MEMBER_ENC(NAME_TBD, 5, 112),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0_Float16\0float\0double\0long_double\0floats"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "float_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 30,
+	.key_type_id = 1,
+	.value_type_id = 6,
+	.max_entries = 1,
+},
+{
+	.descr = "float test #2, invalid vlen",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 1), 4),
+								/* [2] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0float"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "float_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 2,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "vlen != 0",
+},
+{
+	.descr = "float test #3, invalid kind_flag",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FLOAT, 1, 0), 4),
+								/* [2] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0float"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "float_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 2,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid btf_info kind_flag",
+},
+{
+	.descr = "float test #4, member does not fit",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_FLOAT_ENC(1, 4),			/* [2] */
+		BTF_STRUCT_ENC(7, 1, 4),			/* [3] */
+		BTF_MEMBER_ENC(NAME_TBD, 2, 1),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0float\0floats"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "float_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 3,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Member exceeds struct_size",
+},
+
 }; /* struct btf_raw_test raw_tests[] */
 
 static const char *get_next_str(const char *start, const char *end)
@@ -6632,6 +6715,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_FUNC:
 		return base_size;
 	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
 		return base_size + sizeof(__u32);
 	case BTF_KIND_ENUM:
 		return base_size + vlen * sizeof(struct btf_enum);
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
index 2023725f1962..e2394eea4b7f 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -66,4 +66,7 @@
 #define BTF_FUNC_ENC(name, func_proto) \
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0), func_proto)
 
+#define BTF_TYPE_FLOAT_ENC(name, sz) \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
+
 #endif /* _TEST_BTF_H */
-- 
2.29.2

