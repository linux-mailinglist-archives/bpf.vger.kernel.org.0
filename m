Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261046D9081
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 09:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjDFHfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 03:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjDFHfy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 03:35:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E8D10CE
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 00:35:52 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3366trxI001821;
        Thu, 6 Apr 2023 07:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=68FiRhdqBi4eTvCkmna3YrQrWiYyuf0nXs7m/onL81k=;
 b=KH/cVIoCrSAaZWmNsn6m4kdM9tAmiQHSQsuE5tZv4zF57kZVDOlqWwaDzpghMslK19vc
 qp/b6MA08hBA9xGTTaY69sdM5uk/3t/3NVP3kG9KkTrVqqbxwBzPAhtaXEdg5HFBCdEB
 wqG73pYFPaJvdQmoSCevFM1aHIew7maZjHsnJbC85f3gZaBTBZIsy8oc5dPRGchqe2AJ
 9iYcIwG4NkgoHSBuKMNJl8FeQ3cMqB1+YOaHe7odI4UoNYo4Lws4Z+HfKmHGVIDmf+28
 B/TmL2VcNWVeOpwU3ExZfp/GKi0LkbkEgb1jS1+7rbnvXGZwrL1qXtSbGgRcB5IYfHzz 2g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps9un5psv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 07:35:26 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3362nGQP031485;
        Thu, 6 Apr 2023 07:35:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ppc86u2cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 07:35:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3367ZMiT47055506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Apr 2023 07:35:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 724D220040;
        Thu,  6 Apr 2023 07:35:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CD4E2004E;
        Thu,  6 Apr 2023 07:35:20 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.75.58])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  6 Apr 2023 07:35:20 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/bpf: populate extable entries only during the last pass
Date:   Thu,  6 Apr 2023 13:05:19 +0530
Message-Id: <20230406073519.75059-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NM1fhSz9bzykPrhVPYkm9QjJX5s2sWYV
X-Proofpoint-GUID: NM1fhSz9bzykPrhVPYkm9QjJX5s2sWYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_02,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=848 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060066
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since commit 85e031154c7c ("powerpc/bpf: Perform complete extra passes
to update addresses"), two additional passes are performed to avoid
space and CPU time wastage on powerpc. But these extra passes led to
WARN_ON_ONCE() hits in bpf_add_extable_entry(). Fix it by not adding
extable entries during the extra pass.

Fixes: 85e031154c7c ("powerpc/bpf: Perform complete extra passes to update addresses")
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 7f91ea064c08..e788b1fbeee6 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -977,7 +977,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (size != BPF_DW && !fp->aux->verifier_zext)
 				EMIT(PPC_RAW_LI(dst_reg_h, 0));
 
-			if (BPF_MODE(code) == BPF_PROBE_MEM) {
+			if (BPF_MODE(code) == BPF_PROBE_MEM && !extra_pass) {
 				int insn_idx = ctx->idx - 1;
 				int jmp_off = 4;
 
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 8dd3cabaa83a..1cc2777ec846 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -921,7 +921,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (size != BPF_DW && insn_is_zext(&insn[i + 1]))
 				addrs[++i] = ctx->idx * 4;
 
-			if (BPF_MODE(code) == BPF_PROBE_MEM) {
+			if (BPF_MODE(code) == BPF_PROBE_MEM && !extra_pass) {
 				ret = bpf_add_extable_entry(fp, image, pass, ctx, ctx->idx - 1,
 							    4, dst_reg);
 				if (ret)
-- 
2.39.2

