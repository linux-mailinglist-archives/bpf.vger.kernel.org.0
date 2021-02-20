Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF232039B
	for <lists+bpf@lfdr.de>; Sat, 20 Feb 2021 04:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBTDwZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 22:52:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhBTDwY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 22:52:24 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11K3ftUp048914;
        Fri, 19 Feb 2021 22:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RJV/nJnNfa6lzjbk3o7xDvcS3SL0Hzv6UL9QqFGzymQ=;
 b=Uvhh/Pme/4AE/qLFBwJxKsJ4dwM949PpU9/OzU/+ndPKqRYUgIa2G3XISSUDOsUd1X8W
 AkZUi4KaxtUFQEvY8dtFF63o+qJaFVGrHCacwO4VXcWv6lclsY4FzciEcBOU99QcJNI9
 jQ0V9uJtg48yKfPM/tegSHeJ2DOl1ag+8ankf/qNarxYv+EmX1FZ3LbROqZCJtsAVfbr
 pbGNoQj+s7NPV0JQ/SsRa26pxrVw+GJY6iZBpzcIFzbn5tb+DH8guQXgzgVU+yzCrtOH
 70pMOUKt6hH4KKDS/w981OApkXJ05qQ0gEQ6Ppx2cpzW7GWPRoXWkYx5iMdhYuuFCZp9 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ttrc84pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 22:51:31 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11K3g0l2048972;
        Fri, 19 Feb 2021 22:51:31 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ttrc84pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 22:51:31 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11K3nBUO005586;
        Sat, 20 Feb 2021 03:51:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt2800sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Feb 2021 03:51:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11K3pEIW33685786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Feb 2021 03:51:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F35EE52051;
        Sat, 20 Feb 2021 03:51:25 +0000 (GMT)
Received: from vm.lan (unknown [9.145.178.56])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 71E0D5204E;
        Sat, 20 Feb 2021 03:51:25 +0000 (GMT)
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
Subject: [PATCH v3 bpf-next 6/6] bpf: Document BTF_KIND_FLOAT in btf.rst
Date:   Sat, 20 Feb 2021 04:49:59 +0100
Message-Id: <20210220034959.27006-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210220034959.27006-1-iii@linux.ibm.com>
References: <20210220034959.27006-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200026
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Also document the expansion of the kind bitfield.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
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

