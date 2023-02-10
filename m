Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54164691527
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 01:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBJAMu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 19:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBJAMs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 19:12:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038715C49F
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 16:12:48 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319NmeNn015460;
        Fri, 10 Feb 2023 00:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5qLR6pUJR9Y1ndxnWk/nkPa7KZA7Sg0QJo+SPSmkgRE=;
 b=lOKhTZ7iVEF26jFFA718sEix0O2enLBQ6FbiUFNOmiWvuREwyWl6niEaO63FOn6hOJBp
 1rFVP7P/ruS5tLL1cpvm8d36RmViW9/omHIZ0K4EdS7WgqG2plrFfVjRW+Aypm9KC9zH
 UP6shNOyr9nazaPiBbr2rFbtywkVIig9N3Bcn4C+AYbIQooyptHoCod0oXWI1v9Wt/xx
 cFsEi9X7Caf4ABQFE8DPhMxu1UDr1hyUXmifAWKIOW8evhCRQYztGB0PnPEyxzcb57mz
 00OADKuO0kybwb0HyC3ihrEn+33gZ2o9BM8x7EUtMv1c37zXZrdJqB6zfgaPG/X0xB1p Kw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnau4gvde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:35 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319NdDtN022813;
        Fri, 10 Feb 2023 00:12:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3nhemfmvcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A0CSdr26280516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:12:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCE5820043;
        Fri, 10 Feb 2023 00:12:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B88220040;
        Fri, 10 Feb 2023 00:12:28 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.74.186])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 00:12:28 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 02/16] tools: runqslower: Add EXTRA_CFLAGS and EXTRA_LDFLAGS support
Date:   Fri, 10 Feb 2023 01:11:56 +0100
Message-Id: <20230210001210.395194-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DIC_mAX0w-MsT2sQrhv1PwwaFDophy-1
X-Proofpoint-GUID: DIC_mAX0w-MsT2sQrhv1PwwaFDophy-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_16,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=823 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090217
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
 tools/bpf/runqslower/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 8b3d87b82b7a..47acf6936516 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -13,6 +13,8 @@ BPF_DESTDIR := $(BPFOBJ_OUTPUT)
 BPF_INCLUDE := $(BPF_DESTDIR)/include
 INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../include/uapi)
 CFLAGS := -g -Wall $(CLANG_CROSS_FLAGS)
+CFLAGS += $(EXTRA_CFLAGS)
+LDFLAGS += $(EXTRA_LDFLAGS)
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
-- 
2.39.1

