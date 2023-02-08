Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2E68F924
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 21:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjBHU5O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 15:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjBHU5L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 15:57:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE9B13D7F
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 12:57:08 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KckAn025572;
        Wed, 8 Feb 2023 20:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ez1fkSKBP0sIIQwZswrizp/tJO3VfkjUaw1LYsV3tTo=;
 b=Z4H3l9qBRLY7C+pEKeBJy65Lipljq2yeK2h+1N+E7gB9jtKrcS2RG0SIXc+Awoj4Ovyh
 1RJHr8/S2goL/w4N8+2tOIEIcSnd2G+fFs+N42ujiJQwdip6RQBvnCCgKWH7gGiCMXGG
 GGneLRvCvhdlWB23s6VWfR7ToRrLJOcc8vIjdkrid7axRb5IiICWVUf0EBEt+FgwuD4g
 bpIQfqirqiOqb0mCYZ5Dq4uLYkWXt79NDVXYOLWKjgNK9Fnaunt6cJOvxvenw9CNErnM
 W8SI/JQg83VUyRnbs3oTJ7j08cQSNJBjwD2XENYWjQRFN8oAcfKRtdEpTHM0XyXAuUMS iA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmjjg8s72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:56:55 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3186FtDY001926;
        Wed, 8 Feb 2023 20:56:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06nbek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:56:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318KunJ446399756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 20:56:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 160222004B;
        Wed,  8 Feb 2023 20:56:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE0EF20049;
        Wed,  8 Feb 2023 20:56:47 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.24.149])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 20:56:47 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/9] tools: runqslower: Add EXTRA_CFLAGS and EXTRA_LDFLAGS support
Date:   Wed,  8 Feb 2023 21:56:35 +0100
Message-Id: <20230208205642.270567-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208205642.270567-1-iii@linux.ibm.com>
References: <20230208205642.270567-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KD0Ke6DPciX3goFofbhCFBoo4HDN1uPh
X-Proofpoint-ORIG-GUID: KD0Ke6DPciX3goFofbhCFBoo4HDN1uPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 mlxlogscore=804 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080175
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This makes it possible to add sanitizer flags.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/bpf/runqslower/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 8b3d87b82b7a..4ff4eed6c01d 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -13,6 +13,12 @@ BPF_DESTDIR := $(BPFOBJ_OUTPUT)
 BPF_INCLUDE := $(BPF_DESTDIR)/include
 INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../include/uapi)
 CFLAGS := -g -Wall $(CLANG_CROSS_FLAGS)
+ifneq ($(EXTRA_CFLAGS),)
+CFLAGS += $(EXTRA_CFLAGS)
+endif
+ifneq ($(EXTRA_LDFLAGS),)
+LDFLAGS += $(EXTRA_LDFLAGS)
+endif
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
-- 
2.39.1

