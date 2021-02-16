Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C509131C4E6
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 02:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBPBON (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 20:14:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhBPBOM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Feb 2021 20:14:12 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11G131W5065460;
        Mon, 15 Feb 2021 20:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hNO2t+vsKNLvMJdjjrp2ZETkXNDQ0RUkEvJ1fX0caZc=;
 b=ADU4aJYkvXVrPh3uHQAeCQr/vorKqapTaHbucyVUOubLTglMVMphLMaiMjGaGDoCh4rB
 zR3gyb5nnTqTs8i8v1zXZuLr0Ahxlvc/aJsaJuibLGwWxYeO2aW3EfnRZEYQBPgJUC8j
 bk+/ajylO6d+wkzV3tcUFQZSJX7Bn4+L+wZg/lGI1LefL9W0Obuz3ZKadn58MeMt4clJ
 xjz1bPxrbM8VaHHfgR1ZU0JA35crOYArer+PRufwQgxcJeVPjwT5MJwMK5I6DDE/I7I4
 K4OIer86VH1yrq5/TWD9VObTDaopiHOmlCE4BiiUSA6p85qdU7127E3tmg/htDvpAG1j 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r40u0a8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:13:20 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11G139wm065936;
        Mon, 15 Feb 2021 20:13:19 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r40u0a7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:13:19 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11G1BoU8012001;
        Tue, 16 Feb 2021 01:13:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 36p6d8aab3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 01:13:17 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11G1DEIW38928888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 01:13:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18D3811C04A;
        Tue, 16 Feb 2021 01:13:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F9C411C04C;
        Tue, 16 Feb 2021 01:13:13 +0000 (GMT)
Received: from vm.lan (unknown [9.171.16.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Feb 2021 01:13:13 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 6/6] bpf: Document BTF_KIND_FLOAT in btf.rst
Date:   Tue, 16 Feb 2021 02:12:16 +0100
Message-Id: <20210216011216.3168-7-iii@linux.ibm.com>
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

Also document the expansion of the kind bitfield.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 Documentation/bpf/btf.rst | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 44dc789de2b4..4f25c992d442 100644
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
+ * ``size``: the size of the float type in bytes.
+
+No additional type data follow ``btf_type``.
+
 3. BTF Kernel API
 *****************
 
-- 
2.29.2

