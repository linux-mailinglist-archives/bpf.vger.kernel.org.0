Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861A3680120
	for <lists+bpf@lfdr.de>; Sun, 29 Jan 2023 20:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjA2TFl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Jan 2023 14:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjA2TFi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 14:05:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B42005D
        for <bpf@vger.kernel.org>; Sun, 29 Jan 2023 11:05:35 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TDhWLs012455;
        Sun, 29 Jan 2023 19:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WIRMtVN3xzhmq1oRMq1i9ZtcALJANthplPMq/xMW//0=;
 b=oQkmE5hZr5aSEJrwEC53W270QCR+KUjeJ5LxPFz4ETxNO7Lfu35R140bCFlEwS6UgnWk
 Ime5bz3psCgZh7iobYDOAeQfYFGXLfvh0u6W304VkXmTUFjTFuizNBffWnt5egsxuIKa
 Gdhyt/KjBEGgnsmeIZlRJ6QQa7V+56IfK9TQfZx/dZ7fdAhPIf9c2AZW8lm7Txa4RSpG
 eG1uPPz3DgmssXigYnYtXJZV45hHwLXjhTyX8ucPktU9syHcQZqBSwHvKPI8VznyMTVy
 giFDTxqN8eRJP6E9FLAWwHCpaDrYSkdyjGu20sAtl6TilVYa6qOfi1iwxEO2axEmFa0L 8w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddv15943-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:16 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30T9rsrB027465;
        Sun, 29 Jan 2023 19:05:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ncvttsd7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30TJ5B2P21758564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 19:05:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2A9A2004B;
        Sun, 29 Jan 2023 19:05:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C91420040;
        Sun, 29 Jan 2023 19:05:11 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 29 Jan 2023 19:05:11 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 7/8] selftests/bpf: Fix s390x vmlinux path
Date:   Sun, 29 Jan 2023 20:05:00 +0100
Message-Id: <20230129190501.1624747-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129190501.1624747-1-iii@linux.ibm.com>
References: <20230129190501.1624747-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rGGjqiY799UakcrmwHRFlJUTnZK1w7hz
X-Proofpoint-GUID: rGGjqiY799UakcrmwHRFlJUTnZK1w7hz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=921 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After commit edd4a8667355 ("s390/boot: get rid of startup archive")
there is no more compressed/ subdirectory.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 316a56d680f2..685034528018 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -13,7 +13,7 @@ s390x)
 	QEMU_BINARY=qemu-system-s390x
 	QEMU_CONSOLE="ttyS1"
 	QEMU_FLAGS=(-smp 2)
-	BZIMAGE="arch/s390/boot/compressed/vmlinux"
+	BZIMAGE="arch/s390/boot/vmlinux"
 	;;
 x86_64)
 	QEMU_BINARY=qemu-system-x86_64
-- 
2.39.1

