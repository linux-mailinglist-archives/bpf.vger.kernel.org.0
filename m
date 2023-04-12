Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304096DF579
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjDLMh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 08:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjDLMhU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 08:37:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F917EF4;
        Wed, 12 Apr 2023 05:36:54 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CBtaHM032043;
        Wed, 12 Apr 2023 12:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=U6WUPreyjcO4opuyIz4xH9p+gbFh6AifVWqgRrcvYOc=;
 b=h4VeNtEuF5Dvu/drQeFseV980GO8/0g2NR3EPHia8mIIrYN0IexV9Jd8t62mAczMsRBy
 yi1kZ3UHoF8OA7l3r6x1O/zAbHJLyAxT+6bjqHe5MHeS/z4qTf7cV3VSwG5NylprzE2c
 ikbDW+W3WXJncDzr3ajOjqHhhUWC9L9o7ReCwSvHVUujHf+PDnvxlNHjsmW9ah1oK/4V
 R0NpLn6+Jb6eNPFjH//oiVNVNyUHuQMxYEOGeIgbQao+QPyQw6CK3XaO1z3BOnXH1yJU
 nmFy65cSUXbGBP3p0tq5+Upkx0mU6iV3EMbArUiDCXD2kc+H+H/RPL1KES3BZWKuZdxs dw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwv6wsjfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 12:36:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C0kmBr028714;
        Wed, 12 Apr 2023 12:36:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m22c5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 12:36:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33CCalAf43188868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 12:36:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C56020043;
        Wed, 12 Apr 2023 12:36:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50D7F20040;
        Wed, 12 Apr 2023 12:36:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Apr 2023 12:36:47 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     quentin@isovalent.com, hca@linux.ibm.com, bpf@vger.kernel.org,
        linux-next@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] bpftool: fix broken compile on s390 for linux-next repository
Date:   Wed, 12 Apr 2023 14:36:36 +0200
Message-Id: <20230412123636.2358949-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p2KgPj-vFFUZ7Fz13q8ei_qPvH1I8eNy
X-Proofpoint-ORIG-GUID: p2KgPj-vFFUZ7Fz13q8ei_qPvH1I8eNy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_04,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 9fd496848b1c ("bpftool: Support inline annotations when dumping the CFG of a program")
breaks the build of the perf tool on s390 in the linux-next repository.
Here is the make output:

make -C tools/perf
....
btf_dumper.c: In function 'dotlabel_puts':
DEBUG: btf_dumper.c:838:25: error: '__fallthrough' undeclared \
		(first use in this function); did you mean 'fallthrough'?
DEBUG:   838 |                         __fallthrough;
DEBUG:       |                         ^~~~~~~~~~~~~
DEBUG:       |                         fallthrough
DEBUG: btf_dumper.c:838:25: note: each undeclared identifier is reported \
		only once for each function it appears in
DEBUG: btf_dumper.c:837:25: warning: this statement may fall through \
                [-Wimplicit-fallthrough=]
DEBUG:   837 |                         putchar('\\');
DEBUG:       |                         ^~~~~~~~~~~~~
DEBUG: btf_dumper.c:839:17: note: here
DEBUG:   839 |                 default:
DEBUG:       |                 ^~~~~~~
DEBUG: make[3]: *** [Makefile:247: /builddir/build/BUILD/kernel-6.2.fc37/\
		        linux-6.2/tools/perf/util/bpf_skel/ \
		        .tmp/bootstrap/btf_dumper.o] Error 1

The compile fails because symbol __fallthrough unknown, but symbol
fallthrough is known and works fine.

Fix this and replace __fallthrough by fallthrough.

With this change, the compile works.

Output after:

 # make -C tools/perf
 ....
 CC      util/bpf-filter.o
 CC      util/bpf-filter-flex.o
 LD      util/perf-in.o
 LD      perf-in.o
 LINK    perf
 make: Leaving directory '/root/mirror-linux-next/tools/perf'
 #

Fixes: 9fd496848b1c ("bpftool: Support inline annotations when dumping the CFG of a program")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/bpf/bpftool/btf_dumper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 6c5e0e82da22..1b7f69714604 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -835,7 +835,7 @@ static void dotlabel_puts(const char *s)
 		case '|':
 		case ' ':
 			putchar('\\');
-			__fallthrough;
+			fallthrough;
 		default:
 			putchar(*s);
 		}
-- 
2.39.2

