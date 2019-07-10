Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBE6454F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2019 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfGJKn5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jul 2019 06:43:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727346AbfGJKn4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Jul 2019 06:43:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6AAft6Y043757
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2019 06:43:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tnegag1m7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2019 06:43:55 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <gor@linux.ibm.com>;
        Wed, 10 Jul 2019 11:43:52 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Jul 2019 11:43:49 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6AAhlSX43122698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 10:43:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BA7BAE045;
        Wed, 10 Jul 2019 10:43:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FF4EAE051;
        Wed, 10 Jul 2019 10:43:47 +0000 (GMT)
Received: from localhost (unknown [9.152.212.168])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Jul 2019 10:43:47 +0000 (GMT)
Date:   Wed, 10 Jul 2019 12:43:45 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: update BPF JIT S390 maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
x-cbid: 19071010-4275-0000-0000-0000034B524A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071010-4276-0000-0000-0000385B55BF
Message-Id: <patch.git-d365382dfc69.your-ad-here.call-01562755343-ext-3127@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=817 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100128
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich is joining as s390 bpf maintainer. With his background
as gcc developer he would be valuable for the team and community as a
whole. Ilya, have fun!

Since there is now enough eyes on s390 bpf, relieve Christian Borntraeger,
so that he could focus on his maintainer tasks for other components.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 558acf24ea1e..98e7411dfe56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3066,9 +3066,9 @@ S:	Maintained
 F:	arch/riscv/net/
 
 BPF JIT for S390
+M:	Ilya Leoshkevich <iii@linux.ibm.com>
 M:	Heiko Carstens <heiko.carstens@de.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
-M:	Christian Borntraeger <borntraeger@de.ibm.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
-- 
2.21.0

