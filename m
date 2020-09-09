Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154A9263AE7
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 04:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIJCsc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 22:48:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728442AbgIJB7V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:59:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089NYoAm006178;
        Wed, 9 Sep 2020 19:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=F5yY13Ku9Oa07L6Qh1v3rTNCa/VIRzaa0yl9PlZh610=;
 b=IZUUiDcQN70Ie5g/juCoYjGFLS+9Hlbf3y+Op0VzV6ZHp8HuwM50T9s4HtWXssTWkRMd
 mauVtV8NzvG/9LRTBNPbA4ybKCRZomlLkv+lSMX9/PTdAV4jMNceLF16GY9dZ1ECfMA3
 eAowa3TDdmTcS2ubV7fsRoAksVOxIKhkzVM14Vr+iFozdgRU0FgR+x2fzEg3Tw147tx8
 A5s29orKso8D8jX+FevAN1GrmaklSs5S29KHw9YzjxgiqadCb9ksbYGnuyHDcn0fD13v
 NOm4NQyHnudtACvu1kwjTQCmAtFqPJjVEGDGAyEurEo9DaywW+cnspyL+bFuwkVxhA9X ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f8re841x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:36:17 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089NYuAq007107;
        Wed, 9 Sep 2020 19:36:17 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f8re8418-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:36:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NWalo023856;
        Wed, 9 Sep 2020 23:36:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8dbbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:36:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NYdSQ64225600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:34:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECD88A4040;
        Wed,  9 Sep 2020 23:36:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A414A4051;
        Wed,  9 Sep 2020 23:36:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 23:36:11 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 3/5] bpf: Make adjust_subprog_starts() accept variable number of old insns
Date:   Thu, 10 Sep 2020 01:34:37 +0200
Message-Id: <20200909233439.3100292-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200909233439.3100292-1-iii@linux.ibm.com>
References: <20200909233439.3100292-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090207
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simply adjust the fast path condition and the delta. No renaming needed
in this case.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 077919ac3826..6791a6e1bf76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9614,17 +9614,18 @@ static int adjust_insns_aux_data(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
+static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off,
+				  u32 len_old, u32 len)
 {
 	int i;
 
-	if (len == 1)
+	if (len == len_old)
 		return;
 	/* NOTE: fake 'exit' subprog should be updated as well. */
 	for (i = 0; i <= env->subprog_cnt; i++) {
 		if (env->subprog_info[i].start <= off)
 			continue;
-		env->subprog_info[i].start += len - 1;
+		env->subprog_info[i].start += len - len_old;
 	}
 }
 
@@ -9643,7 +9644,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	}
 	if (adjust_insns_aux_data(env, new_prog, off, 1, len))
 		return NULL;
-	adjust_subprog_starts(env, off, len);
+	adjust_subprog_starts(env, off, 1, len);
 	return new_prog;
 }
 
-- 
2.25.4

