Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E241F67F2BF
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjA1AIE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjA1AH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB8E8BBA5
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:42 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30S076qP026466;
        Sat, 28 Jan 2023 00:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=b14FwBP8CDrEEzbwvMX/y7yoA6BkN1AgjWD6umGP6a4=;
 b=DSIbbca0iDQRfyJvKVNtDrPYy+eBSiU+qwlHhONlxTSInPeU672yvXBcEOdEUfRQU+FK
 9ui5+u8EgwO0/DJY0psIKcU1BGbXUUi1CQb54aFMe+ZX+KRTf1QrKc3C+mIxcnI+yah9
 c65kGdPpmQGI4dcCoS6FAk+y/x2PNNnqlXbM8HPI0IoVQX/lbIxgw5AXhX2vjXP9l0lR
 3W13RjfdCeXXJV+B2zEF29FHHyOGbNHnpu/bJiiEbnMOqDQTNHAQTCX+KFCOa7Mqi8W0
 ZcTSrlpVNxu4qtKGcuBh3qEy9GAl47u69AlXFYmg/iunCzASbVFujiY+aQ8yjrRcRkjG qA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncrvs008c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:30 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFpFOg032034;
        Sat, 28 Jan 2023 00:07:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n87p65te6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07OoB15860316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D4F82004D;
        Sat, 28 Jan 2023 00:07:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12FE42004B;
        Sat, 28 Jan 2023 00:07:24 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:23 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 27/31] s390/bpf: Add expoline to tail calls
Date:   Sat, 28 Jan 2023 01:06:46 +0100
Message-Id: <20230128000650.1516334-28-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IHerkHRxahwnfIghhEzDKr85rpveIdR9
X-Proofpoint-GUID: IHerkHRxahwnfIghhEzDKr85rpveIdR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270220
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All the indirect jumps in the eBPF JIT already use expolines, except
for the tail call one.

Fixes: de5cb6eb514e ("s390: use expoline thunks in the BPF JIT")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index eb1a78c0e6a8..8400a06c926e 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1393,8 +1393,16 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* lg %r1,bpf_func(%r1) */
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_1, REG_1, REG_0,
 			      offsetof(struct bpf_prog, bpf_func));
-		/* bc 0xf,tail_call_start(%r1) */
-		_EMIT4(0x47f01000 + jit->tail_call_start);
+		if (nospec_uses_trampoline()) {
+			jit->seen |= SEEN_FUNC;
+			/* aghi %r1,tail_call_start */
+			EMIT4_IMM(0xa70b0000, REG_1, jit->tail_call_start);
+			/* brcl 0xf,__s390_indirect_jump_r1 */
+			EMIT6_PCREL_RILC(0xc0040000, 0xf, jit->r1_thunk_ip);
+		} else {
+			/* bc 0xf,tail_call_start(%r1) */
+			_EMIT4(0x47f01000 + jit->tail_call_start);
+		}
 		/* out: */
 		if (jit->prg_buf) {
 			*(u16 *)(jit->prg_buf + patch_1_clrj + 2) =
-- 
2.39.1

