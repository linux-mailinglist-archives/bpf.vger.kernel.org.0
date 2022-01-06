Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC644863D5
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 12:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiAFLq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 06:46:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51854 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231423AbiAFLq1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 06:46:27 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206BhMRV032795;
        Thu, 6 Jan 2022 11:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vCd5iRoDw6Ta6bmviJIMFyXyS5zjlNhF0fq4FXiTRak=;
 b=FOCb3Zp9F0P1k6/Ly+FMijtEjrwMZpZnUfl0trr1QUxDzyd6e+Y1cmZMOPairPnFJr0B
 bNXq6bAaQL/ig0+p0Tp0ZxMvLYgeeGrv/oYsJ3U57QKhc41JVlH1hY7M2/s8KUeT/lG5
 dI1norb1gFARKlPNkpOJFlfBgCkvN4LW5TM94EvklEyimf5i4txio3nsvOdk4+qZ/Nuz
 bnQLGcyU0v6AkU+/qw9zVRPoCdHdvianPfkMqVhDUUw6Lvozq7pLWg9+ROh43KcF88U1
 3x17kVHiGYkFYIKi0/vwtoIWFP9ec6Rk30jB+GfB4XLQTWRfkN4RwycqQeIyaIsBlxhD Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddw73u097-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:07 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 206BRSg5013387;
        Thu, 6 Jan 2022 11:46:06 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ddw73u08k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:06 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206BgUPu005787;
        Thu, 6 Jan 2022 11:46:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3ddngr48hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206Bk00M35651950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 11:46:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D52AEA4062;
        Thu,  6 Jan 2022 11:46:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04B86A4068;
        Thu,  6 Jan 2022 11:45:58 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.91.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 11:45:57 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 02/13] powerpc32/bpf: Fix codegen for bpf-to-bpf calls
Date:   Thu,  6 Jan 2022 17:15:06 +0530
Message-Id: <52d8fe51f7620a6f27f377791564d79d75463576.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cTf2VuqCabndsyru4Mf2VrxgsosAx8F-
X-Proofpoint-ORIG-GUID: mdlxUawzfA6fS0IFqmdc8SstaSlfHyJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_04,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2112160000 definitions=main-2201060081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pad instructions emitted for BPF_CALL so that the number of instructions
generated does not change for different function addresses. This is
especially important for calls to other bpf functions, whose address
will only be known during extra pass.

Fixes: 51c66ad849a703 ("powerpc/bpf: Implement extended BPF on PPC32")
Cc: stable@vger.kernel.org # v5.13+
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index d3a52cd42f5346..997a47fa615b30 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -191,6 +191,9 @@ void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 fun
 
 	if (image && rel < 0x2000000 && rel >= -0x2000000) {
 		PPC_BL_ABS(func);
+		EMIT(PPC_RAW_NOP());
+		EMIT(PPC_RAW_NOP());
+		EMIT(PPC_RAW_NOP());
 	} else {
 		/* Load function address into r0 */
 		EMIT(PPC_RAW_LIS(_R0, IMM_H(func)));
-- 
2.34.1

