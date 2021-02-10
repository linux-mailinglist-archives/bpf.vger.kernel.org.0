Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7C315DB0
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhBJDE6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:04:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231350AbhBJDEd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 22:04:33 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11A33Gi2107206;
        Tue, 9 Feb 2021 22:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u7gFXBIMbDr8inMKJYjEiCAjjYkZSzHwiTGg2ieH/PY=;
 b=DGZaVq7ob/OoilQSG4A31obvh4XCxIRuP03Ii2NFkfRxuL9I4bTLj6wJTzZTU4bpZZ8U
 vk5kevFT65B+QK9lmtbKqd0dMW8qaIE1yKeY2+qIlJhH9lSBUdt7PSkYfZ3824o4cv/Y
 SAWtvdqiO+e9I+vbZaOGs1f/LdLzsIIBhb2nYR6V7uaJDzqpin/F8WT1KqG4EsnU7zDQ
 IDFu5TQ2ZGRrQnKU653BRk2Fdxq9hJFE+EakN4Ohg+9q4EgSv/pNwDns/XgxvlAm0xsS
 RwjW9jrjIyb1QXrTPdvmwKuH0EUPKseNVqrjmudYkCEXPsDvJrLIq24hN0/6vQc3P3aT fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m72x8789-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:03:39 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11A33cMm108827;
        Tue, 9 Feb 2021 22:03:38 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m72x877q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:03:38 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11A33bRn007283;
        Wed, 10 Feb 2021 03:03:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 36hjr8265e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 03:03:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11A33YLY45744634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 03:03:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 166F3A4055;
        Wed, 10 Feb 2021 03:03:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5E14A4051;
        Wed, 10 Feb 2021 03:03:33 +0000 (GMT)
Received: from vm.lan (unknown [9.171.67.27])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 03:03:33 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC 1/6] bpf: Add BTF_KIND_FLOAT to uapi
Date:   Wed, 10 Feb 2021 04:03:12 +0100
Message-Id: <20210210030317.78820-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210210030317.78820-1-iii@linux.ibm.com>
References: <20210210030317.78820-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100031
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new kind value, expand the kind bitfield, add a macro for
parsing the additional u32.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/uapi/linux/btf.h       | 10 ++++++++--
 tools/include/uapi/linux/btf.h | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 5a667107ad2c..e713430cb033 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -52,7 +52,7 @@ struct btf_type {
 	};
 };
 
-#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x0f)
+#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x1f)
 #define BTF_INFO_VLEN(info)	((info) & 0xffff)
 #define BTF_INFO_KFLAG(info)	((info) >> 31)
 
@@ -72,7 +72,8 @@ struct btf_type {
 #define BTF_KIND_FUNC_PROTO	13	/* Function Proto	*/
 #define BTF_KIND_VAR		14	/* Variable	*/
 #define BTF_KIND_DATASEC	15	/* Section	*/
-#define BTF_KIND_MAX		BTF_KIND_DATASEC
+#define BTF_KIND_FLOAT		16	/* Floating point	*/
+#define BTF_KIND_MAX		BTF_KIND_FLOAT
 #define NR_BTF_KINDS		(BTF_KIND_MAX + 1)
 
 /* For some specific BTF_KIND, "struct btf_type" is immediately
@@ -169,4 +170,9 @@ struct btf_var_secinfo {
 	__u32	size;
 };
 
+/* BTF_KIND_FLOAT is followed by a u32 and the following
+ * is the 32 bits arrangement:
+ */
+#define BTF_FLOAT_BITS(VAL)	((VAL)  & 0x000000ff)
+
 #endif /* _UAPI__LINUX_BTF_H__ */
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 5a667107ad2c..e713430cb033 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -52,7 +52,7 @@ struct btf_type {
 	};
 };
 
-#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x0f)
+#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x1f)
 #define BTF_INFO_VLEN(info)	((info) & 0xffff)
 #define BTF_INFO_KFLAG(info)	((info) >> 31)
 
@@ -72,7 +72,8 @@ struct btf_type {
 #define BTF_KIND_FUNC_PROTO	13	/* Function Proto	*/
 #define BTF_KIND_VAR		14	/* Variable	*/
 #define BTF_KIND_DATASEC	15	/* Section	*/
-#define BTF_KIND_MAX		BTF_KIND_DATASEC
+#define BTF_KIND_FLOAT		16	/* Floating point	*/
+#define BTF_KIND_MAX		BTF_KIND_FLOAT
 #define NR_BTF_KINDS		(BTF_KIND_MAX + 1)
 
 /* For some specific BTF_KIND, "struct btf_type" is immediately
@@ -169,4 +170,9 @@ struct btf_var_secinfo {
 	__u32	size;
 };
 
+/* BTF_KIND_FLOAT is followed by a u32 and the following
+ * is the 32 bits arrangement:
+ */
+#define BTF_FLOAT_BITS(VAL)	((VAL)  & 0x000000ff)
+
 #endif /* _UAPI__LINUX_BTF_H__ */
-- 
2.29.2

