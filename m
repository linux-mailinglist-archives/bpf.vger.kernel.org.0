Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAC64AD0E4
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbiBHFc7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiBHFRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:17:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC1AC0401F0
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:17:15 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21858jmQ015969;
        Tue, 8 Feb 2022 05:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dMbyH2Z4ecASSiIwPCMuVBECi5JSlT96nxGowBgANpk=;
 b=QhZa59ldmzH98C5RViHitlK5AlAGa6iUv+bTKvntu+t4WM72VCugcvyLOC0JTE6Pr/Ce
 6xurVxmKbmfKFmOXjxFdBXnUAGXxRdDoE87pJDERl6J/5crOCPP8GYROE9hQJl9ImlxK
 CNE9BroBUQnXTDlkyGRRmYO2l2C6DiMKuZERWCuCGMgBSfFTbFStmdo8vjGNFgyRKT8/
 P7IMY7Z5cOLSGcx6YniPc4CDgOFQZNghNWnqiAUFl9z3GIKvrPjg0zXYZlnvzLI5zYjS
 k05cPJzLI9pwmm1BZyQ1rsj5pa8gsl4i3lggZkb67YX7a2gFevjqLm9TeeIIRBXeT5PE rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3e1tcttq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:57 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2184s8hI017160;
        Tue, 8 Feb 2022 05:16:57 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3e1tctsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:57 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2185CTfb022070;
        Tue, 8 Feb 2022 05:16:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggjtf41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2185GnmT37290272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 05:16:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C39DD11C058;
        Tue,  8 Feb 2022 05:16:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2328811C04A;
        Tue,  8 Feb 2022 05:16:49 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 05:16:49 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v4 12/14] s390: add a comment that warns that orig_gpr2 should not be moved
Date:   Tue,  8 Feb 2022 06:16:33 +0100
Message-Id: <20220208051635.2160304-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208051635.2160304-1-iii@linux.ibm.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7gz8XkxM81BmU8iKLsbEDvyb-cEltnpf
X-Proofpoint-ORIG-GUID: EVftoteCgMrTMzDMF4dn9NRm4iBKZkG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=876 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

orig_gpr2's location is used by libbpf tracing macros, therefore it
should not be moved.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 4ffa8e7f0ed3..3c356ec59abc 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -85,6 +85,10 @@ struct pt_regs {
 			unsigned long gprs[NUM_GPRS];
 		};
 	};
+	/*
+	 * orig_gpr2 is not exposed via user_pt_regs, but its location is
+	 * assumed by libbpf's tracing macros, so it should not be moved.
+	 */
 	unsigned long orig_gpr2;
 	union {
 		struct {
-- 
2.34.1

