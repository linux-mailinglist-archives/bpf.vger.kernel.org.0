Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167AC31F400
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 03:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhBSC15 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 21:27:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229620AbhBSC1v (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 21:27:51 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11J2CrFC165079;
        Thu, 18 Feb 2021 21:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+fqOk9boZszxNcebirRZR5OMCAKA4ZHMlKulJiuN42g=;
 b=AHvVOh25BPvxvWHU7VFM+I2jzu5Uogfz0XGXFN8nDUgQ/XI/b42Cdfrf9ylgsjPXUXw3
 shz5JbFNlcENbrqUF9ro8YomYHLvHU6YuJqFwa1AEzfVCDUjEkNzn0Ecw9kROO2zTCcn
 hrOFledsTckQsyRaaDVIr0cfx5jej5bqeJC+WwQhnmTedPiSNDaLI17eet4PDLszoc5Q
 wfbD+ANozLLhgJjtEb4eqSWd6dxBg8Q4MzMJk62UrfIHIKmMUIPy/fgOolHZtgUhYSLt
 UR/JYnCZDa/KsbI+3o1QHT5dEIfLOsKNR4uuifrRTI9shHR0uIdO8b71zcxxAegmYsOy bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36t4bfr7ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:26:58 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11J2F5oV173610;
        Thu, 18 Feb 2021 21:26:58 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36t4bfr7w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:26:57 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11J2LkRj022074;
        Fri, 19 Feb 2021 02:26:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 36p61hd5x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 02:26:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11J2Qf1315729038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 02:26:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6778AA4053;
        Fri, 19 Feb 2021 02:26:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEA44A4040;
        Fri, 19 Feb 2021 02:26:52 +0000 (GMT)
Received: from vm.lan (unknown [9.145.178.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 02:26:52 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 5/6] selftest/bpf: Add BTF_KIND_FLOAT tests
Date:   Fri, 19 Feb 2021 03:25:42 +0100
Message-Id: <20210219022543.20893-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219022543.20893-1-iii@linux.ibm.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_14:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190007
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test the good variants as well as the potential malformed ones.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/btf_helpers.c    |   4 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 122 +++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |   3 +
 3 files changed, 129 insertions(+)

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
index 6a7ee7420701..4be14d853cc3 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3531,6 +3531,127 @@ static struct btf_raw_test raw_tests[] = {
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
+		BTF_STRUCT_ENC(35, 4, 32),			/* [6] */
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 3, 32),
+		BTF_MEMBER_ENC(NAME_TBD, 4, 64),
+		BTF_MEMBER_ENC(NAME_TBD, 5, 128),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0_Float16\0float\0double\0long_double\0floats"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "float_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 32,
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
+		BTF_STRUCT_ENC(7, 1, 2),			/* [3] */
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),
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
+{
+	.descr = "float test #5, member is not properly aligned",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_FLOAT_ENC(1, 4),			/* [2] */
+		BTF_STRUCT_ENC(7, 1, 8),			/* [3] */
+		BTF_MEMBER_ENC(NAME_TBD, 2, 8),
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
+	.err_str = "Member is not properly aligned",
+},
+{
+	.descr = "float test #6, invalid size",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_FLOAT_ENC(1, 6),			/* [2] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0float"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "float_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 6,
+	.key_type_id = 1,
+	.value_type_id = 2,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid type_size",
+},
+
 }; /* struct btf_raw_test raw_tests[] */
 
 static const char *get_next_str(const char *start, const char *end)
@@ -6632,6 +6753,7 @@ static int btf_type_size(const struct btf_type *t)
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

