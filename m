Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057146E5CA7
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjDRIz4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDRIzz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 04:55:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBD3729D;
        Tue, 18 Apr 2023 01:55:48 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I7P2ME013943;
        Tue, 18 Apr 2023 08:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=U6WUPreyjcO4opuyIz4xH9p+gbFh6AifVWqgRrcvYOc=;
 b=ghKEhwZXC3CIeMGSfNuSKQRyy7i4FEuTzs16Kn2JWGg/RhDz5liOPCe8q+C0eof3OBcg
 FREw5KpRvR2gUVPiegL8muJFOhI5vyRLUVdlY2XjL+WyNREJCkRKgFOblJ4JXx4BpCjH
 9nAXH1gXeRFiKGsMpV9oWaHMgWswOeC2h8TR8GPpqoJLOWPZTC1gYt3TzcunJvap51Od
 MOwXeZewhq6AswKf+r9gBiuK2E10BAgsgu5DitJ0pmnTl9GKXm9iSIXvKGyZh4VPbhH6
 MDGuo4bTW+Dxzbc2A5+8d2n/3udjfMepNSiB2EGrSqDFhjOkpalD2SZvVJpUIsz1aWHi nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1psxaj09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 08:55:27 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33I8d1oc026435;
        Tue, 18 Apr 2023 08:55:27 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1psxahy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 08:55:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6YjC3004335;
        Tue, 18 Apr 2023 08:55:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pyk6fhvww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 08:55:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33I8tLRi13435536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 08:55:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C81020043;
        Tue, 18 Apr 2023 08:55:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 013E120040;
        Tue, 18 Apr 2023 08:55:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Apr 2023 08:55:20 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     broonie@kernel.org, hca@linux.ibm.com, sfr@canb.auug.org.au,
        liam.howlett@oracle.com, acme@redhat.com, ast@kernel.org,
        bpf@vger.kernel.org, linux-next@vger.kernel.org,
        quentin@isovalent.com
Cc:     Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] bpftool: fix broken compile on s390 for linux-next repository
Date:   Tue, 18 Apr 2023 10:55:16 +0200
Message-Id: <20230418085516.1104514-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b9aBxCBUHP3EKtS2jXtQ1nL2sd7Un27v
X-Proofpoint-ORIG-GUID: 1DXDd7M9cNp-HQKMKlLpykQ8NjnGXVlL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_04,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

