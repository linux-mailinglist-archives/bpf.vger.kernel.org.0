Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A050225C86
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 12:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgGTKTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 06:19:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728169AbgGTKTD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Jul 2020 06:19:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KA4mND086903;
        Mon, 20 Jul 2020 06:18:50 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32cea0x3nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 06:18:49 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06KAA6TY006142;
        Mon, 20 Jul 2020 10:18:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7tjwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 10:18:19 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06KAIHRN23396826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 10:18:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 103E511C054;
        Mon, 20 Jul 2020 10:18:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7224811C04A;
        Mon, 20 Jul 2020 10:18:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.6.1])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 10:18:16 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: fix test_lwt_seg6local.sh hangs
Date:   Mon, 20 Jul 2020 12:18:10 +0200
Message-Id: <20200720101810.84299-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_05:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007200074
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

OpenBSD netcat (Debian patchlevel 1.195-2) does not seem to react to
SIGINT for whatever reason, causing prefix.pl to hang after
test_lwt_seg6local.sh exits due to netcat inheriting
test_lwt_seg6local.sh's file descriptors.

Fix by using SIGTERM instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/test_lwt_seg6local.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_lwt_seg6local.sh b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
index 785eabf2a593..5620919fde9e 100755
--- a/tools/testing/selftests/bpf/test_lwt_seg6local.sh
+++ b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
@@ -140,7 +140,7 @@ ip netns exec ns6 sysctl net.ipv6.conf.veth10.seg6_enabled=1 > /dev/null
 ip netns exec ns6 nc -l -6 -u -d 7330 > $TMP_FILE &
 ip netns exec ns1 bash -c "echo 'foobar' | nc -w0 -6 -u -p 2121 -s fb00::1 fb00::6 7330"
 sleep 5 # wait enough time to ensure the UDP datagram arrived to the last segment
-kill -INT $!
+kill -TERM $!
 
 if [[ $(< $TMP_FILE) != "foobar" ]]; then
 	exit 1
-- 
2.25.4

