Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB82D4AE69C
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbiBICjf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244853AbiBICSO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 21:18:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ADDC06157B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 18:18:14 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219030Sq028590;
        Wed, 9 Feb 2022 02:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+RxM4WAgD7FiS+sMcPljhyYNN5eGD2Vi54r5vVzaNeI=;
 b=cZ5loLzoY08NIA/uMvZKUsIFuIEV4RScKN4PAb+Xm2llbqD0xd92HjdHnJNfkNdoVO/7
 y/oiWuAsguPoQnH/J42v3fVRI2uDKBR9CwoP/qHlQiBLbHrNCJd+5btrueSJv6y7lgva
 PxN5r6hZWkmZ0sSwPdDfql3VUpUfK0ejHb/I1kPhW/TZ6jme0RrkGyCefMdG/yxcEt/S
 bEMGq3XP9pl7UKzNMuGmw2ga64ErUCHIOc8UJVTNgArO3gK7X2XN1Xc34n2GFOsREIPp
 ECj3ttPiNlceYGIxIxzdvA8Ed8nEcZbJiu1CsDZsicd21VyUX71KydqI/G++KFuXaqkI 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e3s8fh4ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:18:01 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2192HsMC025148;
        Wed, 9 Feb 2022 02:18:01 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e3s8fh4q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:18:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2192CwU1002801;
        Wed, 9 Feb 2022 02:17:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggk2m4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21927oCS49938920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 02:07:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A939A405C;
        Wed,  9 Feb 2022 02:17:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8AB8A405B;
        Wed,  9 Feb 2022 02:17:55 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 02:17:55 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v5 08/10] libbpf: Allow overriding PT_REGS_PARM1{_CORE}_SYSCALL
Date:   Wed,  9 Feb 2022 03:17:43 +0100
Message-Id: <20220209021745.2215452-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209021745.2215452-1-iii@linux.ibm.com>
References: <20220209021745.2215452-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TvVsmdc2gNUXusOE3ME2a0ukPxuaSC-O
X-Proofpoint-ORIG-GUID: F4s7iJ9AjrIZMW3ZgIQPgmO64oQD2_sQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_08,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

arm64 and s390 need a special way to access the first syscall argument.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 41a015ee6bfb..f364f1f4710e 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -269,7 +269,9 @@ struct pt_regs;
 
 #endif
 
+#ifndef PT_REGS_PARM1_SYSCALL
 #define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
+#endif
 #define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
 #define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
 #ifdef __PT_PARM4_REG_SYSCALL
@@ -279,7 +281,9 @@ struct pt_regs;
 #endif
 #define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
 
+#ifndef PT_REGS_PARM1_CORE_SYSCALL
 #define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
+#endif
 #define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
 #define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
 #ifdef __PT_PARM4_REG_SYSCALL
-- 
2.34.1

