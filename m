Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417CD68F925
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 21:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjBHU5X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 15:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjBHU5U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 15:57:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713373D908
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 12:57:10 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318J0XVV027806;
        Wed, 8 Feb 2023 20:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BnrI1IbPwgyusWtORTVWyVEgBOwwq9wI6q3/RAecw+g=;
 b=PLbgf96mHomlwc/gw4CL+bcHJu6wAIr3hTAcISvO1ReZWeSEoeb3UhyuHBNILxnvlsiw
 m+E0HGTUgYAuXXCO1m81ThtozmEGAXQuOPf1S/cjiDo8Zw+VpVs8G91Gvf5b5MfFZjkb
 gi6RUSt/kSETcFsCrb0JqPazPDQGOvjNVaNATf60MaAe/KklkVjqP1M5eLryslEAijmW
 2nf5evOEdJecKBAYm5F6qA+R/mHzM6X8jN9c4FrWsGP8hf1ClYS1oQL+bJS0fyQpGfSj
 EyW5udl5UE7iwc7IV04YOLNAIwKVQvnDYq0wW/li/kMHoKIP9rNTlMYkjLJ2x6uHb+O0 JQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmf6pybex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:56:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318JMWhA021016;
        Wed, 8 Feb 2023 20:56:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nhemfncbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:56:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318Kuo8u44564972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 20:56:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B9AE20049;
        Wed,  8 Feb 2023 20:56:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1471120043;
        Wed,  8 Feb 2023 20:56:50 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.24.149])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 20:56:49 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 3/9] selftests/bpf: Split SAN_CFLAGS and SAN_LDFLAGS
Date:   Wed,  8 Feb 2023 21:56:36 +0100
Message-Id: <20230208205642.270567-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208205642.270567-1-iii@linux.ibm.com>
References: <20230208205642.270567-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MYn3tQN6j9V7jjJnfAgIBBLNKWnEU8En
X-Proofpoint-ORIG-GUID: MYn3tQN6j9V7jjJnfAgIBBLNKWnEU8En
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=842 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080175
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Memory Sanitizer requires passing different options to CFLAGS and
LDFLAGS: besides the mandatory -fsanitize=memory, one needs to pass
header and library paths, and passing -L to a compilation step
triggers -Wunused-command-line-argument. So introduce a separate
variable for linker flags. Use $(SAN_CFLAGS) as a default in order to
avoid complicating the ASan usage.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 49bc1ba12d3a..9b5786ac676e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -22,10 +22,11 @@ endif
 
 BPF_GCC		?= $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=
+SAN_LDFLAGS	?= $(SAN_CFLAGS)
 CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
-LDFLAGS += $(SAN_CFLAGS)
+LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang
-- 
2.39.1

