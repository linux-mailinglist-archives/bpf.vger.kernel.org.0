Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1076D4EF8
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjDCRaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjDCRaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 13:30:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCAAB4
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 10:30:08 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333Gpkip004370;
        Mon, 3 Apr 2023 17:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5AQDdRk3WbCReW6p3tXW6JbAc/IYKgfsgoFJabXq6bk=;
 b=B4rJMaQh7fJTXN0tMaS6FDJNi3zHNirE67C+UOjo/i9tz9VqOa9WKf7EL5CFhOEhiYQJ
 0HMc4WvWvoomOShG4RjBfWlNtZPmLqm7Fn6PKT383lqQ9hXTVWucxVcCnGaUWRXjiDv5
 6adkMewyHBer3pPo5vRFKI4S53xhnCRmCnvU6gtyGHMX8FBNWENtx2XxjkpRsvcaE0DA
 X0/C7e0QCKeD81ZTQxA+9Q0dLImojGvy5Y0995G9dc2Fi62KdSi/wg1C04sUaU2naN6r
 l5JOwdIqPAKse5zfexXCfO03W0AtCHSCH0QTFTvd3lYyO5BWiB00pFi9TLWQFlW0k5uZ 7w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ppxern97s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 17:29:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3331H6w0005343;
        Mon, 3 Apr 2023 17:29:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ppc871vwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 17:29:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 333HTkbj51773948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Apr 2023 17:29:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 869BE20043;
        Mon,  3 Apr 2023 17:29:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0C7420040;
        Mon,  3 Apr 2023 17:29:45 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.72.121])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Apr 2023 17:29:45 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Add RESOLVE_BTFIDS dependency to bpf_testmod.ko
Date:   Mon,  3 Apr 2023 19:29:35 +0200
Message-Id: <20230403172935.1553022-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XS4Hfy62W2X3H5-dTa_V8wnvoV1nvoC3
X-Proofpoint-GUID: XS4Hfy62W2X3H5-dTa_V8wnvoV1nvoC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_14,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030123
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_testmod.ko sometimes fails to build from a clean checkout:

    BTF [M] linux/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.ko
    /bin/sh: 1: linux-build//tools/build/resolve_btfids/resolve_btfids: not found

The reason is that RESOLVE_BTFIDS may not yet be built. Fix by adding a
dependency.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4a8ef118fd9d..febd1dae6c88 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -201,7 +201,7 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 		  $< -o $@ \
 		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
-$(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
+$(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
 	$(Q)$(RM) bpf_testmod/bpf_testmod.ko # force re-compilation
 	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_testmod
-- 
2.39.2

