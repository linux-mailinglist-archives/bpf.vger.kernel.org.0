Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1904F4B4DDD
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350455AbiBNLN7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:13:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350350AbiBNLNu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:13:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37473EBDE5
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:43:07 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EAGO8p004198;
        Mon, 14 Feb 2022 10:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YunodSmrIMXAQ10JIy1AZFr6/O9HirSXq4a9B+d2V6o=;
 b=Ae3b08SHg4TET7HCd9hfEDNb5fGQtyWLZ/SxIA2jjNF+FfkPXTTzbaKiCPGxDiluCBwo
 Oh7hFnzN39siScfXtYc/1FD1tkMB1xzg7XE/tII4wcDUuDaTBNDY2isgMw8HjPmVBxwo
 /dgfgUkQEefYSatGoZM3/U+V4gqSpLEAK/2RoCT8x940OATessOAvf2jCjKNNp1fJOUE
 VjbpqKejMIK8lch8ClXpxA+hqgPeCYtDGhRVGH6p8eWMvPv7/OgFgC/krsgmupdkwNuS
 v5iWfK3hK19Hy3HKHPxHmtevHSTgPe49wRbMUVuWc7eNUL72iIxcVu/ZUyoqYWIJQERm Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e7cjdu5qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:40 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EAb3Ri015291;
        Mon, 14 Feb 2022 10:42:39 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e7cjdu5q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:39 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAXs0K014881;
        Mon, 14 Feb 2022 10:42:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3e645jb9xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EAgYnG33423858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:42:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F8E8AE045;
        Mon, 14 Feb 2022 10:42:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00F64AE055;
        Mon, 14 Feb 2022 10:42:32 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.124.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 10:42:31 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <bpf@vger.kernel.org>
Subject: [PATCH powerpc/next 10/17] powerpc/bpf: Rename PPC_BL_ABS() to PPC_BL()
Date:   Mon, 14 Feb 2022 16:11:44 +0530
Message-Id: <f0e57b6c7a6ee40dba645535b70da46f46e8af5e.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mTzbHhuWoNwPvheG5x329oHxwFJy8MRE
X-Proofpoint-ORIG-GUID: VhmIh-o0zHFnB4TTr26OGcn-rbJ_H59v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PPC_BL_ABS() is just doing a relative branch with link. The name
suggests that it is for branching to an absolute address, which is
incorrect. Rename the macro to a more appropriate PPC_BL().

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        | 6 +++---
 arch/powerpc/net/bpf_jit_comp32.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 5cb3efd76715a9..0832235a274983 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -34,9 +34,9 @@
 		EMIT(PPC_RAW_BRANCH(offset));				      \
 	} while (0)
 
-/* blr; (unconditional 'branch' with link) to absolute address */
-#define PPC_BL_ABS(dest)	EMIT(PPC_INST_BL |			      \
-				     (((dest) - (unsigned long)(image + ctx->idx)) & 0x03fffffc))
+/* bl (unconditional 'branch' with link) */
+#define PPC_BL(dest)	EMIT(PPC_INST_BL | (((dest) - (unsigned long)(image + ctx->idx)) & 0x03fffffc))
+
 /* "cond" here covers BO:BI fields. */
 #define PPC_BCC_SHORT(cond, dest)					      \
 	do {								      \
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 014cf893ce90d6..cf66b25ed7c865 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -190,7 +190,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func
 	s32 rel = (s32)func - (s32)(image + ctx->idx);
 
 	if (image && rel < 0x2000000 && rel >= -0x2000000) {
-		PPC_BL_ABS(func);
+		PPC_BL(func);
 		EMIT(PPC_RAW_NOP());
 		EMIT(PPC_RAW_NOP());
 		EMIT(PPC_RAW_NOP());
-- 
2.35.1

