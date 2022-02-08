Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52B04AD0E6
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347311AbiBHFdC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiBHFRT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:17:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D4CC0401E9
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:17:18 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2182vtBu025085;
        Tue, 8 Feb 2022 05:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OfZ2A8pNBUxjU7a573k+SrAK7tklcNFpvz8Dy+qmXxg=;
 b=plojP7d+CDDbHXx1vZ40Bq5G2NbZXEwxcoa6Ju8T+nXl4C2DWrHZGZgZPq4vRFr2dAtY
 gjUa6CQ4MmOxXseK4PlxIbBMYYAWe8G6wvWCElfB1bBrG+9jgRQxBPU00gGBTcYV3UL1
 MVQX34slOCkI57cos6dz9kmU27dE/4b6nyfURi2ZLFGImKmkR/DT417d1OKCM/KEh34j
 LIGhrQdb5+UG6jrbfhR3aJH2FPjDuyG5SSDUIAtBYcoyVHM5b09XgPv+eZdybVgDWplj
 /Q2+ulE5N9DFU2kVo1UIV8IhvzFYaNnq/EV6nKooW37bP+QrxjuFnMcpo1QLlK3TLlW4 Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22tr82ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:59 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2184tgIw029292;
        Tue, 8 Feb 2022 05:16:59 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22tr82mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:58 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2185CRio022062;
        Tue, 8 Feb 2022 05:16:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggjtf45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2185GqXZ44630360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 05:16:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D38A11C04C;
        Tue,  8 Feb 2022 05:16:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 947C711C05E;
        Tue,  8 Feb 2022 05:16:51 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 05:16:51 +0000 (GMT)
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
Subject: [PATCH bpf-next v4 14/14] arm64: add a comment that warns that orig_x0 should not be moved
Date:   Tue,  8 Feb 2022 06:16:35 +0100
Message-Id: <20220208051635.2160304-15-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208051635.2160304-1-iii@linux.ibm.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u7QAttY4CSw2Aae2-pKpJ8QkLlbubvmE
X-Proofpoint-GUID: JekFZZVgywvkQ5RZ4S1qWww6fZxDAPpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=983
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

orig_x0's location is used by libbpf tracing macros, therefore it
should not be moved.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/arm64/include/asm/ptrace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 41b332c054ab..7e34c3737839 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -185,6 +185,10 @@ struct pt_regs {
 			u64 pstate;
 		};
 	};
+	/*
+	 * orig_x0 is not exposed via struct user_pt_regs, but its location is
+	 * assumed by libbpf's tracing macros, so it should not be moved.
+	 */
 	u64 orig_x0;
 #ifdef __AARCH64EB__
 	u32 unused2;
-- 
2.34.1

