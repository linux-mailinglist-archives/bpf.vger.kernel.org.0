Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60264863D8
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 12:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbiAFLqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 06:46:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238456AbiAFLqf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 06:46:35 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2069HpYi025311;
        Thu, 6 Jan 2022 11:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GPXS1Dimz8xAOOpH+0lqqD8YZlQFkbcXwd7KT60w3PI=;
 b=AMntmjhh2CpGmb1g2wPPB+Mxqy3OaTYSkvmeE2iEKpY7U3kfGH3olnAW5xEZS6JvvBSK
 jA02LQE5lP0wZpk/p+MtFkIqr72pQTjxwQPLMmfOc2neHGVm+Dl1YdZ+VXfbE+Ah4+cv
 s0n2XUs1LRTDpikJGsQlxLbYMLhMZfp5LUCgqa41KEe4Faq7TkGWTVkautY+rdlP+ORA
 gzpFD4wyPmul/kqfB+yMZ4sgk6fY2TMyaIImw4esTJhwUTIP6aJeuuozFJFfjzSTis5H
 jJqKiv1e5r2Tb6zNvLRf2IT3AhthuLC2pPvubBzPKYQgRt71pCtCO5euzXF6ulnLiaoN nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ddwnvteng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:16 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 206Bceqe030774;
        Thu, 6 Jan 2022 11:46:16 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ddwnvtemv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:16 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206BhoUH024823;
        Thu, 6 Jan 2022 11:46:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ddmsvmrhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206BkBgp43647232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 11:46:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05E13A4054;
        Thu,  6 Jan 2022 11:46:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4303A4062;
        Thu,  6 Jan 2022 11:46:07 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.91.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 11:46:07 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 05/13] powerpc/bpf: Skip branch range validation during first pass
Date:   Thu,  6 Jan 2022 17:15:09 +0530
Message-Id: <aeabfaa4651acd30edd0b99fdd13d598d91c9f5f.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rzHjESrtERy_jaIcq_uXEf5IeWCOORTO
X-Proofpoint-GUID: 0t3rusSu8XbVZMXp0UxYvET6iEaMN7kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_04,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During the first pass, addrs[] is still being populated. So, all
branches to following instructions will appear to be going to the start
of the JIT program. Ignore branch range validation for such instructions
and assume those to be in range. Branch range validation will happen
during the second pass after addrs[] is setup properly.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index b20a2a83a6e75b..9cdd33d6be4cc0 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -27,7 +27,7 @@
 #define PPC_JMP(dest)							      \
 	do {								      \
 		long offset = (long)(dest) - (ctx->idx * 4);		      \
-		if (!is_offset_in_branch_range(offset)) {		      \
+		if ((dest) != 0 && !is_offset_in_branch_range(offset)) {		      \
 			pr_err_ratelimited("Branch offset 0x%lx (@%u) out of range\n", offset, ctx->idx);			\
 			return -ERANGE;					      \
 		}							      \
@@ -41,7 +41,7 @@
 #define PPC_BCC_SHORT(cond, dest)					      \
 	do {								      \
 		long offset = (long)(dest) - (ctx->idx * 4);		      \
-		if (!is_offset_in_cond_branch_range(offset)) {		      \
+		if ((dest) != 0 && !is_offset_in_cond_branch_range(offset)) {		      \
 			pr_err_ratelimited("Conditional branch offset 0x%lx (@%u) out of range\n", offset, ctx->idx);		\
 			return -ERANGE;					      \
 		}							      \
-- 
2.34.1

