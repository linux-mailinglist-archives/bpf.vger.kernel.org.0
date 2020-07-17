Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B722240D4
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 18:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGQQyg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 12:54:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgGQQyg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jul 2020 12:54:36 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06HGWRxl049095;
        Fri, 17 Jul 2020 12:54:23 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32as6epf43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 12:54:23 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06HGpjeI014515;
        Fri, 17 Jul 2020 16:54:22 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3274pgxpp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 16:54:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06HGsJNw3211740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 16:54:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECF02A4062;
        Fri, 17 Jul 2020 16:54:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 719B4A4054;
        Fri, 17 Jul 2020 16:54:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.6.1])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jul 2020 16:54:18 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/5] selftests: bpf: test_kmod.sh: fix running out of srctree
Date:   Fri, 17 Jul 2020 18:53:22 +0200
Message-Id: <20200717165326.6786-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717165326.6786-1-iii@linux.ibm.com>
References: <20200717165326.6786-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_08:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=975 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170115
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When running out of srctree, relative path to lib/test_bpf.ko is
different than when running in srctree. Check $building_out_of_srctree
environment variable and use a different relative path if needed.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/test_kmod.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmod.sh b/tools/testing/selftests/bpf/test_kmod.sh
index 9df0d2ac45f8..4f6444bcd53f 100755
--- a/tools/testing/selftests/bpf/test_kmod.sh
+++ b/tools/testing/selftests/bpf/test_kmod.sh
@@ -10,7 +10,13 @@ if [ "$(id -u)" != "0" ]; then
 	exit $ksft_skip
 fi
 
-SRC_TREE=../../../../
+if [ "$building_out_of_srctree" ]; then
+	# We are in linux-build/kselftest/bpf
+	OUTPUT=../../
+else
+	# We are in linux/tools/testing/selftests/bpf
+	OUTPUT=../../../../
+fi
 
 test_run()
 {
@@ -19,8 +25,8 @@ test_run()
 
 	echo "[ JIT enabled:$1 hardened:$2 ]"
 	dmesg -C
-	if [ -f ${SRC_TREE}/lib/test_bpf.ko ]; then
-		insmod ${SRC_TREE}/lib/test_bpf.ko 2> /dev/null
+	if [ -f ${OUTPUT}/lib/test_bpf.ko ]; then
+		insmod ${OUTPUT}/lib/test_bpf.ko 2> /dev/null
 		if [ $? -ne 0 ]; then
 			rc=1
 		fi
-- 
2.25.4

