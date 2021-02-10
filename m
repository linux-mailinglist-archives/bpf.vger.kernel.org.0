Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D69315DB5
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhBJDFI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:05:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233471AbhBJDFF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 22:05:05 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11A32SYT146060;
        Tue, 9 Feb 2021 22:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=p9B2bUFQo4A+s+UmtcaLYLaDH8eRRYTK4+rCRfXg+yw=;
 b=gZWxoNtIv6rWkh2yoSWMDSSLa5qfKnWeOguUomBnWC2AVcOAaekeqgmdum7HjkJlHeoR
 J+BFpVETtu/a1sL0BTC6SRE95iXmwWDAXFqkqyc3YvOct5z1CKuxXB1JD0YJ1gJcw7xA
 BgIDfngD0t9YHjW/UKRyK28H5pVOJn586PEdpBZQYbssR7QOi+1zhuflRSJwZtIhJ+Ca
 oR4zf4QNra3beKWklTkXpUeTAPhCO6agZR8ViS7Sbx/i8jouEQed9l5PWiuoy09eYKCt
 oT14A3XfW8AnxilWqVK+m/sh6a0qetQzt/vGjTVEz2AVoUiFTTjUMMsaFtfAu3Kj5DJ6 XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36m74v86k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:04:10 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11A33QRx003281;
        Tue, 9 Feb 2021 22:04:09 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36m74v86da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:04:09 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11A33gbO007286;
        Wed, 10 Feb 2021 03:04:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 36hjr8265m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 03:04:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11A33oG032375104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 03:03:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDCCCA4051;
        Wed, 10 Feb 2021 03:04:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C3C4A4040;
        Wed, 10 Feb 2021 03:04:00 +0000 (GMT)
Received: from vm.lan (unknown [9.171.67.27])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 03:04:00 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC 5/6] selftest/bpf: Add BTF_KIND_FLOAT tests
Date:   Wed, 10 Feb 2021 04:03:16 +0100
Message-Id: <20210210030317.78820-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210210030317.78820-1-iii@linux.ibm.com>
References: <20210210030317.78820-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100025
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test the good variants as well as potential malformed ones.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/btf_helpers.c    |   4 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 145 +++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |   5 +
 3 files changed, 154 insertions(+)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index 48f90490f922..179ec89c4277 100644
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
+		fprintf(out, " size=%u nr_bits=%u", t->size, btf_float_bits(t));
+		break;
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 6a7ee7420701..d350577ee88a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3531,6 +3531,150 @@ static struct btf_raw_test raw_tests[] = {
 	.max_entries = 1,
 },
 
+{
+	.descr = "float test #1, well-formed",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_FLOAT_ENC(1, 16, 2),			/* [2] */
+		BTF_TYPE_FLOAT_ENC(10, 32, 4),			/* [3] */
+		BTF_TYPE_FLOAT_ENC(16, 64, 8),			/* [4] */
+		BTF_TYPE_FLOAT_ENC(23, 128, 16),		/* [5] */
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
+	.descr = "float test #2, truncated",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), 4),
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
+	.err_str = "meta_left:0 meta_needed:4",
+},
+{
+	.descr = "float test #3, invalid vlen",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 1), 4),
+		BTF_FLOAT_ENC(32),
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
+	.descr = "float test #4, invalid kind_flag",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FLOAT, 1, 0), 4),
+		BTF_FLOAT_ENC(32),
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
+	.descr = "float test #5, invalid float_data",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), 4),
+		BTF_FLOAT_ENC(32) | 0x100,
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
+	.err_str = "Invalid float_data:120",
+},
+{
+	.descr = "float test #6, invalid nr_bits",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), 4),
+		BTF_FLOAT_ENC(64),
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
+	.err_str = "nr_bits exceeds type_size",
+},
+{
+	.descr = "float test #7, member does not fit",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_FLOAT_ENC(1, 32, 4),			/* [2] */
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
@@ -6632,6 +6776,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_FUNC:
 		return base_size;
 	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
 		return base_size + sizeof(__u32);
 	case BTF_KIND_ENUM:
 		return base_size + vlen * sizeof(struct btf_enum);
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
index 2023725f1962..0585b4e31d6e 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -66,4 +66,9 @@
 #define BTF_FUNC_ENC(name, func_proto) \
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0), func_proto)
 
+#define BTF_FLOAT_ENC(nr_bits) nr_bits
+#define BTF_TYPE_FLOAT_ENC(name, bits, sz)				\
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz),	\
+	BTF_FLOAT_ENC(bits)
+
 #endif /* _TEST_BTF_H */
-- 
2.29.2

