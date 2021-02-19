Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2791F31F403
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 03:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhBSC1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 21:27:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229468AbhBSC1E (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 21:27:04 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11J21CJH160730;
        Thu, 18 Feb 2021 21:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=v/XP+J/igOFu9WSi1wLecefMAPeEnKbAWAfsm+S8e7E=;
 b=EfcKMFNxgIqc5baZy79e56AxBfjwCPNiBXBh9KiEV8l2NJnV9Ax4Ww60ZPazBF4G32Jf
 G0czE2Xkd8LdRyKYVueXyGTrXmAaKXVM3PoDVdjsrcmO5Npjvpf6EXN6lQYrAB05iIMi
 00A4a6K1qVSFZFzZppWmamdaGwsrseyrnpS2cqP2zWNSCQYKfRi4loCh3y2n0NVODHZu
 wgdMfa9Gdrt6kfn7TJ2zTBB3Di1JBkYQrF9iWEniLydpYEuONMjfcVDojALrCK0BPGjI
 kvjrQVWzfbrvs8a41bOV0Y5fOlBFsHzxfghxrO0O9/z8mTkjLQgnJ3EHKanILqkQdOcj CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36t3vx0su2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:26:09 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11J2IasZ038421;
        Thu, 18 Feb 2021 21:26:09 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36t3vx0stm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 21:26:09 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11J2MfDq012477;
        Fri, 19 Feb 2021 02:26:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 36p6d8jqa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 02:26:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11J2Pqw032440718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 02:25:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE18A4040;
        Fri, 19 Feb 2021 02:26:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E807A4055;
        Fri, 19 Feb 2021 02:26:03 +0000 (GMT)
Received: from vm.lan (unknown [9.145.178.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 02:26:03 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 1/6] bpf: Add BTF_KIND_FLOAT to uapi
Date:   Fri, 19 Feb 2021 03:25:38 +0100
Message-Id: <20210219022543.20893-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219022543.20893-1-iii@linux.ibm.com>
References: <20210219022543.20893-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_14:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190007
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new kind value and expand the kind bitfield.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/uapi/linux/btf.h       | 5 +++--
 tools/include/uapi/linux/btf.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 5a667107ad2c..d27b1708efe9 100644
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
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 5a667107ad2c..d27b1708efe9 100644
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
-- 
2.29.2

