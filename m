Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE96688B26
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 00:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjBBXyB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 18:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjBBXyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 18:54:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2946B000
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 15:54:00 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312NHmYX003057;
        Thu, 2 Feb 2023 23:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=aWFvXS9+mqXkfVDQuF+wiulWVR9yxHk2CYOSz8WQxfw=;
 b=pMnasspt0BBFV2e6n8hPcTQOQoUky5AWqqzw9X+/W2fluDZ3KQhzwOTfAWwBTJAIHutM
 a5vL1HinMSOL3kFS4didda39yM95S/HERonyXCMNoh1XVXyQc9ym6EGNDrmpeKTgjoUE
 m9doTNtwBT5cwK2E6UGFSWbG/h1yRkypScqTWtR8++E+6+rwE7Pb1gwP6B5o7SegefHG
 I8NXawP+B5te0pfnGLmVZdHNerW2EXO/u99Rg6rCTA4FvICZAi73JLWt/E0mze/Bnbs2
 Sjhqyx88JcZlUz5vqv7jR26S0UyeWEadL9EQCQUe8yxnHekM+1VfwV15J82cQvKikpT3 gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngpqnrk17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 23:53:45 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312Nrj43019971;
        Thu, 2 Feb 2023 23:53:45 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngpqnrk0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 23:53:45 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312JfjSo021107;
        Thu, 2 Feb 2023 23:53:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ncvugmud4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 23:53:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312NrdDU22872766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 23:53:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01E6E20040;
        Thu,  2 Feb 2023 23:53:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69F7E20043;
        Thu,  2 Feb 2023 23:53:38 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.0.211])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 23:53:38 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Initialize tc in xdp_synproxy
Date:   Fri,  3 Feb 2023 00:53:35 +0100
Message-Id: <20230202235335.3403781-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NCH2RX2MQCpUbS3O3UZAoUdBz2XU0wa1
X-Proofpoint-GUID: ROlkdIiJKy7F0px9EZw3Vir1JQDLyX56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_15,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020209
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

xdp_synproxy/xdp fails in CI with:

    Error: bpf_tc_hook_create: File exists

The XDP version of the test should not be calling bpf_tc_hook_create();
the reason it's happening anyway is that if we don't specify --tc on the
command line, tc variable remains uninitialized.

Fixes: 784d5dc0efc2 ("selftests/bpf: Add selftests for raw syncookie helpers in TC mode")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/xdp_synproxy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/xdp_synproxy.c b/tools/testing/selftests/bpf/xdp_synproxy.c
index 410a1385a01d..6dbe0b745198 100644
--- a/tools/testing/selftests/bpf/xdp_synproxy.c
+++ b/tools/testing/selftests/bpf/xdp_synproxy.c
@@ -116,6 +116,7 @@ static void parse_options(int argc, char *argv[], unsigned int *ifindex, __u32 *
 	*tcpipopts = 0;
 	*ports = NULL;
 	*single = false;
+	*tc = false;
 
 	while (true) {
 		int opt;
-- 
2.39.1

