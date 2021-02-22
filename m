Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2083221CA
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 22:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBVVvT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 16:51:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230081AbhBVVvS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 16:51:18 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MLYLce101406;
        Mon, 22 Feb 2021 16:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5gcNVhgwE8a8Un1oTxtz/+28bdT3cwXZPfN9P+1KC7g=;
 b=ImDT5MTOphvzOGwX284RZ2l/uvxjVG+qVcTWOuc5XQJgMjjpD6CIKRuHmmhtSsfxSSYe
 K8r1dYCZYbFi6Hh4M0MHlzARDPG3Cnqb6wPTe51gcT8U4ifIezZavQoC6uln7CUj99wX
 EKFjXWMqgJCXyRQWtJXjlbL7N5M7VFVHfdreBVfVdr0L8RuK+hKK97tLFvPyZQ05ynEL
 HnNAQCNshhdnNPhEgSGCxPlIO6rGKMvItZ2peYHJ4SuI68dxQyPr/Dtx1SLgPY4IkFjU
 fe92hoqALdr2pNQ3HdrsVKwr2M4h1sXcMrJOwwVMKzZuNU9b3g2zFtx+eYVffehhCQmN WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkn0jej7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:50:25 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MLZ4pF112615;
        Mon, 22 Feb 2021 16:50:24 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkn0jeht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:50:24 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MLmIVr016355;
        Mon, 22 Feb 2021 21:50:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 36tt28a1en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 21:50:22 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MLoJfm43057578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 21:50:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D439EA4053;
        Mon, 22 Feb 2021 21:50:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D51DA404D;
        Mon, 22 Feb 2021 21:50:19 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Feb 2021 21:50:19 +0000 (GMT)
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
Subject: [PATCH v4 bpf-next 1/7] bpf: Add BTF_KIND_FLOAT to uapi
Date:   Mon, 22 Feb 2021 22:49:11 +0100
Message-Id: <20210222214917.83629-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210222214917.83629-1-iii@linux.ibm.com>
References: <20210222214917.83629-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_07:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220187
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new kind value and expand the kind bitfield.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Yonghong Song <yhs@fb.com>
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

