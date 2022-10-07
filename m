Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3180B5F7EAA
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 22:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJGUYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 16:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJGUY0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 16:24:26 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FCD125866
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 13:24:24 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297I5Lq4010601
        for <bpf@vger.kernel.org>; Fri, 7 Oct 2022 13:24:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=i01NmLPIFOUlWCPYtyI7PCkDUgAVJGEMBgBQ2uTJNrw=;
 b=UDibo2ixDzbeacWcVHRHkedc1HSIbbhoWBCORns6Uv3ZPcvznN1u9ramwuvWAj32S2Lx
 JA6ZzmARPt6v2joPtjtaWd5Ha8NSP45YVl8RDrw/1cv9YRWQkct7W8IeGlKHktsjF2wv
 o5g2cZaPh8vzzCaNtDyyDIMpcH33w4q5fKM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k27evybet-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Oct 2022 13:24:23 -0700
Received: from twshared20183.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 13:24:22 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id 910BC1142F727; Fri,  7 Oct 2022 13:24:13 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <kpsingh@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
        <andrii@kernel.org>, <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v5 3/3] bpf: add selftests for lsh, rsh, arsh with reg operand
Date:   Fri, 7 Oct 2022 13:23:49 -0700
Message-ID: <20221007202348.1118830-4-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CACYkzJ7gz8Y0JXgfs2vKG5nF98iS+UdqpM9Vk0OOnSfYvMdK4g@mail.gmail.com>
References: <CACYkzJ7gz8Y0JXgfs2vKG5nF98iS+UdqpM9Vk0OOnSfYvMdK4g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0EFqmr7mh_56STPWATZU4NbkOJ97SXEM
X-Proofpoint-ORIG-GUID: 0EFqmr7mh_56STPWATZU4NbkOJ97SXEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

