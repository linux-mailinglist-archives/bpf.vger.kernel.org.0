Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1376B2C7E
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCISBG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCISBF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:01:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D33FCBC3
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:01:04 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329GY65H029521;
        Thu, 9 Mar 2023 18:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l5EzRfVW37ujuGj5kIADgIvR2souW09W9s/PhNaNJtM=;
 b=B06E3l5Z+4c7k68s/S0YWbnQwvjUR3zDGMjfyJtpnH7Zn5buHD5RlM9+YxCGvc8Q2I3s
 kN2DmYwbprPYoC2BHIOxYOKEx+TVeKqwfgRx0mMuLRk/cMBqDa2auNnu8aF4x6HWrGj7
 lJjE5PuwueuwxDjBc8lyHtvhSlKhD5pTe6JBDfgtom+6XkPICnqMAajUTdW/Hw0uqHM7
 fO7E1IuxU22Al6mloR1rVJBCf2Ns0WL5Noie+/syrPmc3KQQ+80GKI/Dq79Ps5G+q0mg
 5b/lnS8/UPXt19iWW7RAKlYYftusnXra3n9oDKWBUXUy1WpypOjNcykBwiK1vvdRXXVi 1g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6t3c1tnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:00:43 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329GWwj3030374;
        Thu, 9 Mar 2023 18:00:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p6g862pmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:00:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329I0cC652560298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 18:00:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89CF720049;
        Thu,  9 Mar 2023 18:00:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77D1820040;
        Thu,  9 Mar 2023 18:00:36 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.13.46])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 18:00:36 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 3/4] powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
Date:   Thu,  9 Mar 2023 23:30:27 +0530
Message-Id: <20230309180028.180200-4-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309180028.180200-1-hbathini@linux.ibm.com>
References: <20230309180028.180200-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J5LLTBweYC2RG2Yl3TRGIVFARaGo-ipg
X-Proofpoint-ORIG-GUID: J5LLTBweYC2RG2Yl3TRGIVFARaGo-ipg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_09,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090141
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

