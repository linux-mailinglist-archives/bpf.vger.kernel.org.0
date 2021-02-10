Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1C316927
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 15:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBJOaB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 09:30:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229731AbhBJOaA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Feb 2021 09:30:00 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11AE5xh8104183;
        Wed, 10 Feb 2021 09:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=34HdqTq9iA5KB3lZVW5/3RZklfQ5hSoUFuKwcQGazp8=;
 b=ZKfJ96qSd5Ff76bsJMP7gKYjFtunzy99PFErqBmFxYlbRQC+JCKL6GBBxwZVUOXsoHkW
 rVEKsquDh0c+iyfdujnJanK+pjW5YqcMbOBTFTDeRpYFDg/qb5zSd62bl/8p5/grnQqU
 8CpR8bUK+OWWfsoa8Q33xpr4ovHKHOYY13n5/ZRk+L2YJhWkKFVFuiE369FlLv4cobmC
 wjZj2mTW65zHy12hU6A4UnrIjaGcr43bIM7wa2tvA+PUwAPT0PZerqDv1pnOw0wjbiDm
 ikostY3mU5GalyQYA2417C3JerzF81obmvufXZ10JdnVO0T/7ksOFcDCZya/BpKOP9Kw 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mgtbsaqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 09:29:06 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11AE6HPK105884;
        Wed, 10 Feb 2021 09:29:06 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mgtbsanw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 09:29:06 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11AERReB012271;
        Wed, 10 Feb 2021 14:29:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 36hjch2hdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 14:29:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11AET09q23200090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 14:29:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6B52A405C;
        Wed, 10 Feb 2021 14:29:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58ECCA4054;
        Wed, 10 Feb 2021 14:29:00 +0000 (GMT)
Received: from vm.lan (unknown [9.171.67.27])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 14:29:00 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Brendan Jackman <jackmanb@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] docs: bpf: Clarify BPF_CMPXCHG wording
Date:   Wed, 10 Feb 2021 15:28:52 +0100
Message-Id: <20210210142853.82203-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100130
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Based on [1], BPF_CMPXCHG should always load the old value into R0. The
phrasing in bpf.rst is somewhat ambiguous in this regard, improve it to
make this aspect crystal clear.

  [1] https://lore.kernel.org/bpf/CAADnVQJFcFwxEz=wnV=hkie-EDwa8s5JGbBQeFt1TGux1OihJw@mail.gmail.com/

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 Documentation/networking/filter.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index b3f457802836..251c6bd73d15 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1076,8 +1076,8 @@ off``. ::
     BPF_CMPXCHG
 
 This atomically compares the value addressed by ``dst_reg + off`` with
-``R0``. If they match it is replaced with ``src_reg``, The value that was there
-before is loaded back to ``R0``.
+``R0``. If they match it is replaced with ``src_reg``. In either case, the
+value that was there before is zero-extended and loaded back to ``R0``.
 
 Note that 1 and 2 byte atomic operations are not supported.
 
-- 
2.29.2

