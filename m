Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502AB6249CB
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 19:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiKJSoK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 13:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiKJSny (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 13:43:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7054D5D6
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:43:53 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAIHfSm032856;
        Thu, 10 Nov 2022 18:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MbWpQYNtoBHhdsmm1zUDa2KE6cVvNkaEI21e4ppL3qo=;
 b=ag7UChb7AbvNff2NjebksclkgHUwBh9ZB0KVMHkcdegwdCH4wIPhpSGejHcnAlVriJNB
 W5NNRQhoNnb9vvVgxy9oMIAZu/9G7Wrlxob+jlfb2wo25DUwztIwnn1PScdIxffW8Jai
 AFHNvbqfby703xkdZElcGo7koe+LyhtwQb/Awn9Jr+RfPOgckWo7+rqKPi6FycvZnoNk
 F3SujMI+m90j2AOf0xSdWvm9QSHN6v4CxKj/reLYPohIEHG7BhoaIX+2yuVJM03UIp2I
 S6A3ypfqUpesFSrqIgDJsckwRsvrofcTfAzAB9/H2IFilKt0/exHoROSvN7zCm7cSGy4 OQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ks6eyrt0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:43:34 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AAIb3OS016877;
        Thu, 10 Nov 2022 18:43:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3kngmqnj4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:43:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AAIhTRQ43057524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 18:43:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 151D1A404D;
        Thu, 10 Nov 2022 18:43:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 156DCA4040;
        Thu, 10 Nov 2022 18:43:25 +0000 (GMT)
Received: from hbathini-workstation.ibm.com.com (unknown [9.163.72.10])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Nov 2022 18:43:24 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC PATCH 2/3] powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
Date:   Fri, 11 Nov 2022 00:13:02 +0530
Message-Id: <20221110184303.393179-3-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110184303.393179-1-hbathini@linux.ibm.com>
References: <20221110184303.393179-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wWXt6SOA_8lkl9QQEqOPptXDP_SJppJB
X-Proofpoint-GUID: wWXt6SOA_8lkl9QQEqOPptXDP_SJppJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 mlxlogscore=946 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100129
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
 arch/powerpc/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7383e0effad2..f925755cd249 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -26,6 +26,33 @@ static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
 	memset32(area, BREAKPOINT_INSTRUCTION, size / 4);
 }
 
+/*
+ * Patch 'len' bytes with trap instruction at addr, one instruction
+ * at a time. Returns addr on success. ERR_PTR(-EINVAL), otherwise.
+ */
+static void *bpf_patch_ill_insns(void *addr, size_t len)
+{
+	void *ret = ERR_PTR(-EINVAL);
+	size_t patched = 0;
+	u32 *start = addr;
+
+	if (WARN_ON_ONCE(core_kernel_text((unsigned long)addr)))
+		return ret;
+
+	mutex_lock(&text_mutex);
+	while (patched < len) {
+		if (patch_instruction(start++, ppc_inst(PPC_RAW_TRAP())))
+			goto error;
+
+		patched += 4;
+	}
+
+	ret = addr;
+error:
+	mutex_unlock(&text_mutex);
+	return ret;
+}
+
 /*
  * Patch 'len' bytes of instructions from opcode to addr, one instruction
  * at a time. Returns addr on success. ERR_PTR(-EINVAL), otherwise.
@@ -394,3 +421,8 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	return bpf_patch_instructions(dst, src, len);
 }
+
+int bpf_arch_text_invalidate(void *dst, size_t len)
+{
+	return IS_ERR(bpf_patch_ill_insns(dst, len));
+}
-- 
2.37.3

