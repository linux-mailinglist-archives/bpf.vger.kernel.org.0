Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E9A31C4E1
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 02:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBPBNj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 20:13:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbhBPBNa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Feb 2021 20:13:30 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11G1310v065507;
        Mon, 15 Feb 2021 20:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=v/XP+J/igOFu9WSi1wLecefMAPeEnKbAWAfsm+S8e7E=;
 b=Mp+aZG/AQwcWMo/syTeEidfBoCbH2IqlX1CNkQ8Sjrys5UXc90tn/8nc2+x2ojG2S11G
 9hw0/NXAoMbpeA8n0zqU6ehOwfTEsyLaJpcnmFdVCxmSBzzXBy5pOgFdJECNaR+N+yFN
 eNgQ0oH09MtVvshkPBq2Lf2Nhr/3AEDBD6OTkWmtV3PnfwQadjRVj4oyvLYol/xy8vNj
 mqdU9vimcoD3cYgbyEKZtBkg7tEiJQyZU1JG6StYtVsso+4/fuaFyY0vaGNIdzuzgjeY
 fqtb9Pk2P7ZszL3zGHRK6TS1vLXIv9Vw87GDi8NYNk203y0yuau1uZOrfiiAE4uEd5wb 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r40u09r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:12:35 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11G131w5065508;
        Mon, 15 Feb 2021 20:12:35 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r40u09qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:12:34 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11G1C48p022770;
        Tue, 16 Feb 2021 01:12:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 36p6d8aanm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 01:12:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11G1CThR34341324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 01:12:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8A8511C052;
        Tue, 16 Feb 2021 01:12:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 067BB11C054;
        Tue, 16 Feb 2021 01:12:29 +0000 (GMT)
Received: from vm.lan (unknown [9.171.16.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Feb 2021 01:12:28 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/6] bpf: Add BTF_KIND_FLOAT to uapi
Date:   Tue, 16 Feb 2021 02:12:11 +0100
Message-Id: <20210216011216.3168-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210216011216.3168-1-iii@linux.ibm.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160008
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

