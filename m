Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A2C3221D7
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 22:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBVVxx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 16:53:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230444AbhBVVxd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 16:53:33 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MLa7fT090050;
        Mon, 22 Feb 2021 16:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=npavZ8VklFaqBPuHtGSh/g2Kaf4f/YPH7OnOTV3B9+w=;
 b=V4kvG3ElirR12mRS8A+y+3lZnq3Z2Y/n/80nQMSoNc6dEe0JmjLtMyd/l3l30ZjZjo9C
 ER0afVf3gljqlgCKJYscutyfwYmKgvkd57qNo5JM+YjQ+ueHrYkxIvGhlKhWbCUG8k3P
 I1oaS34eG/FosEblKP66AFGDuWvNtMvslGv14Y6nQj1KvZPRxp97aeruNNJIU0rPPXk5
 PpqRQVI01fTKKxD4bY9iG51o6lOKHRzvesHho2tXy2dKhIo3DF6xmpl5sHYdG3vJf3U/
 vYEhdcHhPoTodnjc46XK326qnSUHJYK5yfO17OgQbxXEyMWTmsynJrvHBYG6JbYwPsBr eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkf730d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:52:39 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MLaip8092184;
        Mon, 22 Feb 2021 16:52:39 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkf730c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:52:38 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MLq4Ro018401;
        Mon, 22 Feb 2021 21:52:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt2821ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 21:52:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MLqXmn52953544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 21:52:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD5CBA404D;
        Mon, 22 Feb 2021 21:52:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BF87A4040;
        Mon, 22 Feb 2021 21:52:33 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Feb 2021 21:52:33 +0000 (GMT)
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
Subject: [PATCH v4 bpf-next 7/7] bpf: Document BTF_KIND_FLOAT in btf.rst
Date:   Mon, 22 Feb 2021 22:49:17 +0100
Message-Id: <20210222214917.83629-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210222214917.83629-1-iii@linux.ibm.com>
References: <20210222214917.83629-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_07:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220187
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Also document the expansion of the kind bitfield.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/btf.rst | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 44dc789de2b4..846354cd2d69 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -84,6 +84,7 @@ sequentially and type id is assigned to each recognized type starting from id
     #define BTF_KIND_FUNC_PROTO     13      /* Function Proto       */
     #define BTF_KIND_VAR            14      /* Variable     */
     #define BTF_KIND_DATASEC        15      /* Section      */
+    #define BTF_KIND_FLOAT          16      /* Floating point       */
 
 Note that the type section encodes debug info, not just pure types.
 ``BTF_KIND_FUNC`` is not a type, and it represents a defined subprogram.
@@ -95,8 +96,8 @@ Each type contains the following common data::
         /* "info" bits arrangement
          * bits  0-15: vlen (e.g. # of struct's members)
          * bits 16-23: unused
-         * bits 24-27: kind (e.g. int, ptr, array...etc)
-         * bits 28-30: unused
+         * bits 24-28: kind (e.g. int, ptr, array...etc)
+         * bits 29-30: unused
          * bit     31: kind_flag, currently used by
          *             struct, union and fwd
          */
@@ -452,6 +453,18 @@ map definition.
   * ``offset``: the in-section offset of the variable
   * ``size``: the size of the variable in bytes
 
+2.2.16 BTF_KIND_FLOAT
+~~~~~~~~~~~~~~~~~~~~~
+
+``struct btf_type`` encoding requirement:
+ * ``name_off``: any valid offset
+ * ``info.kind_flag``: 0
+ * ``info.kind``: BTF_KIND_FLOAT
+ * ``info.vlen``: 0
+ * ``size``: the size of the float type in bytes: 2, 4, 8, 12 or 16.
+
+No additional type data follow ``btf_type``.
+
 3. BTF Kernel API
 *****************
 
-- 
2.29.2

