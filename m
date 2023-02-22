Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED40669FFAD
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBVXlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBVXlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:41:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C7A1CF56
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:41:06 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MLLCwb029922;
        Wed, 22 Feb 2023 22:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VJ+WXVioIO4x4h6dcD1hMwkpfonwEnakdRvqYDgD6l0=;
 b=nXveZAIkI83p1StctLpMskHBJe7vMsYWFqs5W4Y6mKJLpG8DKh0syc7C05zSyx6f3Y0+
 PXCqG+7p+iZFXfEs5X3Q7i2yaAb8+mEYEilbqllEh44oqxZu8OJGY2Z+N0i7KJNvE6qe
 qedKrQbcGijkQ2JagOx/N4acAGDivUHmGz2LMyazlrek+YN2Jy35neblSipiUwYILMdg
 EBGMOGqrFyQevVET9AtvkU5qoBJOISc8FiTp0hUOfiyTuOvUuNDfK5ROOIMLKsWx1DNJ
 zRwIfqTAoUZXWjcal4UfOsSXXVbNIn42GjQyyjZSqfuuUqbEK/FzvoX+Ypimdd0kcPY1 OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwtvysng0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:33 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMbCL0012833;
        Wed, 22 Feb 2023 22:37:33 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwtvysnf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MF6BVN019871;
        Wed, 22 Feb 2023 22:37:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ntnxf5wff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbRKO23134500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CD6F2005A;
        Wed, 22 Feb 2023 22:37:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A82320040;
        Wed, 22 Feb 2023 22:37:26 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:26 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH bpf-next v3 06/12] bpf: sparc64: Use 32-bit tail call index
Date:   Wed, 22 Feb 2023 23:37:08 +0100
Message-Id: <20230222223714.80671-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qkGnz_qE7mKphg_W0VUY7JyFs8g4UqS0
X-Proofpoint-GUID: QD4tscLp8nPS6CwhMwizbSZXtp7mCj8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The interpreter does the following:

  u32 index = BPF_R3;

and JITs should do the same.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 0a3c18e39199..6c482685dc6c 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -856,6 +856,7 @@ static void emit_tail_call(struct jit_ctx *ctx)
 
 	ctx->saw_tail_call = true;
 
+	emit_alu_K(SRL, bpf_index, 0, ctx);
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit(LD32 | IMMED | RS1(bpf_array) | S13(off) | RD(tmp), ctx);
 	emit_cmp(bpf_index, tmp, ctx);
-- 
2.39.1

