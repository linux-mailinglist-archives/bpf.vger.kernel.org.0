Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111676B2C8F
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCISCz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCISCy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:02:54 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD40FCBC9
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:02:52 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329GHhu0029762;
        Thu, 9 Mar 2023 18:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l5EzRfVW37ujuGj5kIADgIvR2souW09W9s/PhNaNJtM=;
 b=ZYARETjgGglKJUZkn9owS8Si+N+CAqlB+ereaPwMJPLb8g+yd2OTXcfMmIHvpePGbAiU
 9iU8c3Yq4/YXmrCahzsRKNqOj0ocB9+XH9qkR7TnvPtOSdPToMXQvtQByvztegEoDH88
 6iWyg+tSSdwELWInpZQYoab40+ZTwIRmVbn+70pFBXfyUe9wnf8C6ugXqUdnTq8/JFne
 so037kLnq+rx+MhCu/ScnVZnlTbxqX2D7V5XFo/m0QZh/v4AfQae9aDSFTkzohO+qE4R
 TDOFL1lB7L0tVQq4ap/kxkUFrFq9wT+u+CtdHW/vJjbMHYlb8e1q6KRjobEQotnDbphk 0A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6qyqv1g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:02:30 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329GsMrj030398;
        Thu, 9 Mar 2023 18:02:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p6g862pqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:02:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329I2QmV54198642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 18:02:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A11D2004F;
        Thu,  9 Mar 2023 18:02:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCF0F20040;
        Thu,  9 Mar 2023 18:02:22 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.13.46])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 18:02:22 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 3/4] powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
Date:   Thu,  9 Mar 2023 23:32:12 +0530
Message-Id: <20230309180213.180263-4-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309180213.180263-1-hbathini@linux.ibm.com>
References: <20230309180213.180263-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8wOpse0bt-nXi6q1j8A6M02gC7tjxIos
X-Proofpoint-ORIG-GUID: 8wOpse0bt-nXi6q1j8A6M02gC7tjxIos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_09,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement bpf_arch_text_invalidate and use it to fill unused part of
the bpf_prog_pack with trap instructions when a BPF program is freed.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 0a70319116d1..d1794d9f0154 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -293,3 +293,18 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 
 	return ret;
 }
+
+int bpf_arch_text_invalidate(void *dst, size_t len)
+{
+	u32 inst = BREAKPOINT_INSTRUCTION;
+	int ret = -EINVAL;
+
+	if (WARN_ON_ONCE(core_kernel_text((unsigned long)dst)))
+		return ret;
+
+	mutex_lock(&text_mutex);
+	ret = patch_instructions(dst, &inst, true, len);
+	mutex_unlock(&text_mutex);
+
+	return ret;
+}
-- 
2.39.2

