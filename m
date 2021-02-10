Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73211315DB8
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhBJDGm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:06:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230420AbhBJDGk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 22:06:40 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11A33GvM107194;
        Tue, 9 Feb 2021 22:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VUUUID4jinb8YxHa9ULGgHx/wMq8Yn4W3OE/J3/UjtQ=;
 b=QIvj9Wzb/QHfnXhv0uVGJQhiplFj/6cz96gcmYTAe1xqSI3UdOtQMXMUMqS1nAt/AH9o
 qgznSYrU69CnT9qPsPv50BQrouR5UTQY3VCW9PdPOIRonFMgbDSm0ALCyaVbyfAMHrph
 dSyvkjXoDyzDze9s45htL2Re71O3+cTru/cwI1ysX53lXkbUejPLtaT4rymN6R3DIoJD
 Zese1dmrMKP6JpuH7D3MUamOY6PQ0hj4o86vsJw9yQ3N2ASehv2juwUXfneEvhX8LhYn
 oAEoqKha2xOv0W4DY9Mc4YnKGWfzUHH/lkDSHfLuE7RKV3txzLDvXUQ8LKUDtanu98ki hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m72x8a3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:05:44 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11A33NFN108026;
        Tue, 9 Feb 2021 22:04:41 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m72x884f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:04:41 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11A349uX005542;
        Wed, 10 Feb 2021 03:04:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 36hjr7t5vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 03:04:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11A33vrI33948008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 03:03:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD6FCA4040;
        Wed, 10 Feb 2021 03:04:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72A13A404D;
        Wed, 10 Feb 2021 03:04:07 +0000 (GMT)
Received: from vm.lan (unknown [9.171.67.27])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 03:04:07 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC 6/6] bpf: Document BTF_KIND_FLOAT in btf.rst
Date:   Wed, 10 Feb 2021 04:03:17 +0100
Message-Id: <20210210030317.78820-7-iii@linux.ibm.com>
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

The description is based on BTF_KIND_INT. Also document the expansion
of the kind bitfield.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 Documentation/bpf/btf.rst | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 44dc789de2b4..d1d88d3a5d3f 100644
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
@@ -452,6 +453,20 @@ map definition.
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
+``btf_type`` is followed by a ``u32`` with the following bits arrangement::
+
+  #define BTF_FLOAT_BITS(VAL)     ((VAL)  & 0x000000ff)
+
 3. BTF Kernel API
 *****************
 
-- 
2.29.2

