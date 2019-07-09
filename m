Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19863885
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2019 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGIPVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jul 2019 11:21:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbfGIPVL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Jul 2019 11:21:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x69FHNww033057
        for <bpf@vger.kernel.org>; Tue, 9 Jul 2019 11:21:10 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tmtvq7gd4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2019 11:19:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 9 Jul 2019 16:19:02 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Jul 2019 16:18:59 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x69FIw8G50200580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jul 2019 15:18:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B4194203F;
        Tue,  9 Jul 2019 15:18:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD70042042;
        Tue,  9 Jul 2019 15:18:57 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.145.146.163])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jul 2019 15:18:57 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     sdf@fomichev.me, ys114321@gmail.com, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 bpf-next 4/4] selftests/bpf: fix compiling loop{1,2,3}.c on s390
Date:   Tue,  9 Jul 2019 17:18:09 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709151809.37539-1-iii@linux.ibm.com>
References: <20190709151809.37539-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070915-0016-0000-0000-00000290AA19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070915-0017-0000-0000-000032EE5E62
Message-Id: <20190709151809.37539-5-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=8 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=587 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090180
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use PT_REGS_RC(ctx) instead of ctx->rax, which is not present on s390.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/loop1.c | 2 +-
 tools/testing/selftests/bpf/progs/loop2.c | 2 +-
 tools/testing/selftests/bpf/progs/loop3.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/loop1.c b/tools/testing/selftests/bpf/progs/loop1.c
index dea395af9ea9..7cdb7f878310 100644
--- a/tools/testing/selftests/bpf/progs/loop1.c
+++ b/tools/testing/selftests/bpf/progs/loop1.c
@@ -18,7 +18,7 @@ int nested_loops(volatile struct pt_regs* ctx)
 	for (j = 0; j < 300; j++)
 		for (i = 0; i < j; i++) {
 			if (j & 1)
-				m = ctx->rax;
+				m = PT_REGS_RC(ctx);
 			else
 				m = j;
 			sum += i * m;
diff --git a/tools/testing/selftests/bpf/progs/loop2.c b/tools/testing/selftests/bpf/progs/loop2.c
index 0637bd8e8bcf..9b2f808a2863 100644
--- a/tools/testing/selftests/bpf/progs/loop2.c
+++ b/tools/testing/selftests/bpf/progs/loop2.c
@@ -16,7 +16,7 @@ int while_true(volatile struct pt_regs* ctx)
 	int i = 0;
 
 	while (true) {
-		if (ctx->rax & 1)
+		if (PT_REGS_RC(ctx) & 1)
 			i += 3;
 		else
 			i += 7;
diff --git a/tools/testing/selftests/bpf/progs/loop3.c b/tools/testing/selftests/bpf/progs/loop3.c
index 30a0f6cba080..d727657d51e2 100644
--- a/tools/testing/selftests/bpf/progs/loop3.c
+++ b/tools/testing/selftests/bpf/progs/loop3.c
@@ -16,7 +16,7 @@ int while_true(volatile struct pt_regs* ctx)
 	__u64 i = 0, sum = 0;
 	do {
 		i++;
-		sum += ctx->rax;
+		sum += PT_REGS_RC(ctx);
 	} while (i < 0x100000000ULL);
 	return sum;
 }
-- 
2.21.0

