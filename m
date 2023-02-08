Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E17268FAF2
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 00:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBHXMf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 18:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBHXMe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 18:12:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA08420E
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 15:12:33 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318MjpGQ031925;
        Wed, 8 Feb 2023 23:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=sRr9vUz8ODHIP2GisNOPdicBxIOIGrIuD56wwFXBXGs=;
 b=l0SKn539A+tU4bEu79Tn7pgx95BA0vdBTf1UhPgQ4DsqDBEx58g44w7Q+Q1JreMOH79E
 TaANhj0Z0Rc4VXR34joLu8KOnvA+o8rmigmrdwcbhJEm2menjk+8b4io9XCb7OcEH/+t
 +lev+v3D9q/5ztN3nHIgjRXBS3sSS3oZfYjNR+lFEoo2tZ2PD2EkwpCbM6SS0s65b6Zw
 Q0mqmj9gAsvYBNNiIgxaebJiTyozV3jq6fLeew1qYwg1PMuUMxRFrcv4dp6XcU2lK3y4
 BUMySDtp2OpvB8WT3fqMlQ3I7umFrMlhPt51jCChuZiDj69/BeFot2F0q+MKioovSWdL Cw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmmtp0gty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 23:12:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318KLZG9021050;
        Wed, 8 Feb 2023 23:12:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nhemfnfkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 23:12:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318NCDQb21955006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 23:12:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73C3D20043;
        Wed,  8 Feb 2023 23:12:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E2520040;
        Wed,  8 Feb 2023 23:12:12 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.24.149])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 23:12:12 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix out-of-srctree build
Date:   Thu,  9 Feb 2023 00:12:11 +0100
Message-Id: <20230208231211.283606-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v5gtjRQoOtqvaFEU7tEktsAYbkVcu8Xs
X-Proofpoint-GUID: v5gtjRQoOtqvaFEU7tEktsAYbkVcu8Xs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Building eBPF selftests out of srctree fails with:

    make: *** No rule to make target '/linux-build//ima_setup.sh', needed by 'ima_setup.sh'.  Stop.

The culprit is the rule that defines convenient shorthands like
"make test_progs", which builds $(OUTPUT)/test_progs. These shorthands
make sense only for binaries that are built though; scripts that live
in the source tree do not end up in $(OUTPUT).

Therefore drop $(TEST_PROGS) and $(TEST_PROGS_EXTENDED) from the rule.

The issue exists for a while, but it became a problem only after
commit d68ae4982cb7 ("selftests/bpf: Install all required files to run
selftests"), which added dependencies on these scripts.

Fixes: 03dcb78460c2 ("selftests/bpf: Add simple per-test targets to Makefile")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b2eb3201b85a..5182c0044dbb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -151,8 +151,6 @@ endif
 # NOTE: Semicolon at the end is critical to override lib.mk's default static
 # rule for binaries.
 $(notdir $(TEST_GEN_PROGS)						\
-	 $(TEST_PROGS)							\
-	 $(TEST_PROGS_EXTENDED)						\
 	 $(TEST_GEN_PROGS_EXTENDED)					\
 	 $(TEST_CUSTOM_PROGS)): %: $(OUTPUT)/% ;
 
-- 
2.39.1

