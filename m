Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3DB67F2BB
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjA1AH7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjA1AHu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9695486609
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:39 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNrZGp021400;
        Sat, 28 Jan 2023 00:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=poNmgWCReGREq9fa1Wj3UqJYe/i7wciCBL7DQzxouR4=;
 b=tgYeTYbU19M6fKhUsNoK1WLQb/mf9IlnD13KdqQH8+w3+oMPyOnyHNQECBJES9H/0wbQ
 8D8puWAnWaZHTxkNyqxhKWxqZelrCjMx0GGS3JdnArptJXTQ1Fu8nKmYCt96sidGvjz8
 XZSU5TSGycvtb4ruUksXTCBvrjGMHxPPnBM2NJNMnIUrMwTQfOPL1pu9vhiCLKtRcT9S
 2TqnNEPRkjqGDBp4agPyfSuxlI0UNICod2fPYiB0ld2mifq9E+DvQ/ctuPWM1ANzXX84
 zHV1pvl6gdA8FtoYNSAeMl7809oUxWxC4pdnCCgaX8mZUWUAnKmptU3VcSv7Ec8JXij2 RQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncrpf0a09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:26 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNEgFT007800;
        Sat, 28 Jan 2023 00:07:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dtku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07LkW49807826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 094582004B;
        Sat, 28 Jan 2023 00:07:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82EAB20040;
        Sat, 28 Jan 2023 00:07:20 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:20 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 23/31] libbpf: Fix BPF_PROBE_READ{_STR}_INTO() on s390x
Date:   Sat, 28 Jan 2023 01:06:42 +0100
Message-Id: <20230128000650.1516334-24-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pm3tj5q-l0fVbW61t2CY8Zp1WQxpNRIA
X-Proofpoint-GUID: pm3tj5q-l0fVbW61t2CY8Zp1WQxpNRIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=787 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270220
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF_PROBE_READ_INTO() and BPF_PROBE_READ_STR_INTO() should map to
bpf_probe_read() and bpf_probe_read_str() respectively in order to work
correctly on architectures with !ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_core_read.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 496e6a8ee0dc..1ac57bb7ac55 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -364,7 +364,7 @@ enum bpf_enum_value_kind {
 
 /* Non-CO-RE variant of BPF_CORE_READ_INTO() */
 #define BPF_PROBE_READ_INTO(dst, src, a, ...) ({			    \
-	___core_read(bpf_probe_read, bpf_probe_read,			    \
+	___core_read(bpf_probe_read_kernel, bpf_probe_read_kernel,	    \
 		     dst, (src), a, ##__VA_ARGS__)			    \
 })
 
@@ -400,7 +400,7 @@ enum bpf_enum_value_kind {
 
 /* Non-CO-RE variant of BPF_CORE_READ_STR_INTO() */
 #define BPF_PROBE_READ_STR_INTO(dst, src, a, ...) ({			    \
-	___core_read(bpf_probe_read_str, bpf_probe_read,		    \
+	___core_read(bpf_probe_read_kernel_str, bpf_probe_read_kernel,	    \
 		     dst, (src), a, ##__VA_ARGS__)			    \
 })
 
-- 
2.39.1

