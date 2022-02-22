Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537074C013A
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiBVS0y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 13:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiBVS0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 13:26:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65914EB31D
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 10:26:27 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MHpxl1010610;
        Tue, 22 Feb 2022 18:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d4xkgyvBxguK183yHjauIDJ7VjAgP2s6U8+TYg7IhMI=;
 b=SrzAE69NFvt6iO0tCr9w2aNB1wCQc0Nbpvl3Txr712A2Gzp+mFDSc/3kGGbOll2ZbHja
 Bt0KOeZ7IpBYyOksAg1GGJv0xYkQnytYNsG0aUyKlSm3tNFlK7jXvKSUUMPsHlv2hE1C
 GWchgJr/3tcE7eIj2RDPLspMLJlzmzlRIaRu9tS4WaokjL3rAZ6a5WZ8w7QlhXHE6GrS
 CXi3f8vCAF0BY5F3p+MMCCd8nxGM6DZLhRxSJlp5eD7lhlLMoSGAjBHTFXyTULF/Db8y
 ghfQ1gjCmmBl6OxlYjJ182RcKfHkmdnsfAd7QaO8SfALxiC4PISOWQqrPJNfE7fVC7tS Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed4kx8ta3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:08 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MIAk0w008831;
        Tue, 22 Feb 2022 18:26:08 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed4kx8t9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:08 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MIPixn011198;
        Tue, 22 Feb 2022 18:26:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3eaqtj556n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 18:26:06 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MIQ2De53346582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 18:26:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C07CC4C046;
        Tue, 22 Feb 2022 18:26:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A1B34C04A;
        Tue, 22 Feb 2022 18:26:02 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 18:26:02 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 1/3] bpf: Fix certain narrow loads with offsets
Date:   Tue, 22 Feb 2022 19:25:57 +0100
Message-Id: <20220222182559.2865596-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222182559.2865596-1-iii@linux.ibm.com>
References: <20220222182559.2865596-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vwLTsD5smHKb3IJRIB1SMmVE4QduRhsd
X-Proofpoint-GUID: jPneaK7A30nN8L6Cjw-KR2mHYkgLsfKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_05,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verifier treats bpf_sk_lookup.remote_port as a 32-bit field for
backward compatibility, regardless of what the uapi headers say.
This field is mapped onto the 16-bit bpf_sk_lookup_kern.sport field.
Therefore, accessing the most significant 16 bits of
bpf_sk_lookup.remote_port must produce 0, which is currently not
the case.

The problem is that narrow loads with offset - commit 46f53a65d2de
("bpf: Allow narrow loads with offset > 0"), don't play nicely with
the masking optimization - commit 239946314e57 ("bpf: possibly avoid
extra masking for narrower load in verifier"). In particular, when we
suppress extra masking, we suppress shifting as well, which is not
correct.

Fix by moving the masking suppression check to BPF_AND generation.

Fixes: 46f53a65d2de ("bpf: Allow narrow loads with offset > 0")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d7473fee247c..195f2e9b5a47 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12848,7 +12848,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		if (is_narrower_load && size < target_size) {
+		if (is_narrower_load) {
 			u8 shift = bpf_ctx_narrow_access_offset(
 				off, size, size_default) * 8;
 			if (shift && cnt + 1 >= ARRAY_SIZE(insn_buf)) {
@@ -12860,15 +12860,19 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
 									insn->dst_reg,
 									shift);
-				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
-								(1 << size * 8) - 1);
+				if (size < target_size)
+					insn_buf[cnt++] = BPF_ALU32_IMM(
+						BPF_AND, insn->dst_reg,
+						(1 << size * 8) - 1);
 			} else {
 				if (shift)
 					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
 									insn->dst_reg,
 									shift);
-				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
-								(1ULL << size * 8) - 1);
+				if (size < target_size)
+					insn_buf[cnt++] = BPF_ALU64_IMM(
+						BPF_AND, insn->dst_reg,
+						(1ULL << size * 8) - 1);
 			}
 		}
 
-- 
2.34.1

