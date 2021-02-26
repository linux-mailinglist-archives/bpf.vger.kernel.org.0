Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649A73268B3
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBZU0L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 15:26:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32944 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230525AbhBZUYJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 15:24:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QK4MWl066697;
        Fri, 26 Feb 2021 15:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=npavZ8VklFaqBPuHtGSh/g2Kaf4f/YPH7OnOTV3B9+w=;
 b=igNOKkEB1WmSaz8EYYvh87UI9L+4vTRjhv3g2Ts1KCzeCsbWBqxnE9q4RJ93KjeFs2/T
 hEre3Id8vO3q/JI3M4Sva/Kif+23euY2SV3ExhjUcJZm2SPU7lDx8nEslu3w93m0TpvX
 guTz0Uu6qktETjtmghoSawdW4FiKqRVIUcGwki03lREmhPAnk0yxmnzgWIOIdlhLyiso
 vcLHuwFUD7g0UT1t5Hz28Z9dxGE2jrdqm9X9Zm5N/cN5qC6HF/z3/XYo4IIEPKBFwU8e
 Bl7/ZLc8x79/8YlBYjuuqNOuLMURvfPqPh8Rt8C12fHP65O/8WzZ3VZ2KsQMq7Tx/QTE TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xseqm256-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:23:15 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QK5YVT070502;
        Fri, 26 Feb 2021 15:23:15 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xseqm24h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:23:14 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QKNDqq024261;
        Fri, 26 Feb 2021 20:23:13 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 36tt28dkns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 20:23:13 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QKNAsm39846176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:23:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7774411C054;
        Fri, 26 Feb 2021 20:23:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E675F11C052;
        Fri, 26 Feb 2021 20:23:09 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 20:23:09 +0000 (GMT)
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
Subject: [PATCH v7 bpf-next 10/10] bpf: Document BTF_KIND_FLOAT in btf.rst
Date:   Fri, 26 Feb 2021 21:22:56 +0100
Message-Id: <20210226202256.116518-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210226202256.116518-1-iii@linux.ibm.com>
References: <20210226202256.116518-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_07:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260143
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

