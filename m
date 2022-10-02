Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0235F2159
	for <lists+bpf@lfdr.de>; Sun,  2 Oct 2022 07:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJBFMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Oct 2022 01:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiJBFMO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Oct 2022 01:12:14 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2305072C
        for <bpf@vger.kernel.org>; Sat,  1 Oct 2022 22:12:14 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 291Nnfwu004662
        for <bpf@vger.kernel.org>; Sat, 1 Oct 2022 22:12:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=i01NmLPIFOUlWCPYtyI7PCkDUgAVJGEMBgBQ2uTJNrw=;
 b=D7cdmg4l+8+Ja8ZoOIXWyUsIov6G3SFH3rWP6+A1+2d5qpDGTW3AbzyBbEkHmrFZFas5
 VT3qN0wpTaGPsWlqItyZP+hi9DzbR4RonFjepUoccKf3f0FUiB+qJpdVCxNGnPghYnck
 DnBJOeSmXSpa6CA9+ZEO5AngHoxga8WBgCs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jxk303daq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Oct 2022 22:12:13 -0700
Received: from twshared15978.04.prn5.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 1 Oct 2022 22:12:09 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id 6140110F44C8D; Sat,  1 Oct 2022 22:11:52 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v4 3/3] bpf: add selftests for lsh, rsh, arsh with reg operand
Date:   Sat, 1 Oct 2022 22:11:43 -0700
Message-ID: <20221002051143.831029-4-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221002051143.831029-1-jmeng@fb.com>
References: <20220927185801.1824838-1-jmeng@fb.com>
 <20221002051143.831029-1-jmeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ziu9hQ_iA2KifGIjkX1WR8i04wR2Jb5t
X-Proofpoint-ORIG-GUID: ziu9hQ_iA2KifGIjkX1WR8i04wR2Jb5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_15,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current tests cover only shifts with an immediate as the source
operand/shift counts; add a new test case to cover register operand.

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 tools/testing/selftests/bpf/verifier/jit.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/s=
elftests/bpf/verifier/jit.c
index 79021c30e51e..8bf37e5207f1 100644
--- a/tools/testing/selftests/bpf/verifier/jit.c
+++ b/tools/testing/selftests/bpf/verifier/jit.c
@@ -20,6 +20,30 @@
 	.result =3D ACCEPT,
 	.retval =3D 2,
 },
+{
+	"jit: lsh, rsh, arsh by reg",
+	.insns =3D {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_MOV64_IMM(BPF_REG_4, 1),
+	BPF_MOV64_IMM(BPF_REG_1, 0xff),
+	BPF_ALU64_REG(BPF_LSH, BPF_REG_1, BPF_REG_0),
+	BPF_ALU32_REG(BPF_LSH, BPF_REG_1, BPF_REG_4),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x3fc, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_RSH, BPF_REG_1, BPF_REG_4),
+	BPF_MOV64_REG(BPF_REG_4, BPF_REG_1),
+	BPF_ALU32_REG(BPF_RSH, BPF_REG_4, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0xff, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_ARSH, BPF_REG_4, BPF_REG_4),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D ACCEPT,
+	.retval =3D 2,
+},
 {
 	"jit: mov32 for ldimm64, 1",
 	.insns =3D {
--=20
2.30.2

