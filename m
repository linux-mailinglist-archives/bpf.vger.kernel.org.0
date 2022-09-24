Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EE05E86C9
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 02:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiIXAdZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 20:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIXAdY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 20:33:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BC5E7C21
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 17:33:23 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NM8xjM004641
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 17:33:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vddhZj21MWgpZQRKaOvJRA7yvb319058inROJEfRaUE=;
 b=oj4YpRF+nhy4HQFwd0ec8cNMAzeqHh+tPAx3de7vEhInZD9bSMCd1r45SIBhSPFl+ihb
 VLBYdgK4RMNuZKdVcYzfS26QquHvl3TDrz212BepJXiZdSdugMMbFbf7wbY22xDbbZiN
 wB0d3CizU7VLinYJg7xmUP23AWUhhVB4R54= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsb1pwcyj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 17:33:23 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:33:19 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id E039B1082E419; Fri, 23 Sep 2022 17:33:13 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v2 2/2] bpf: Add selftests for lsh, rsh, arsh with reg operand
Date:   Fri, 23 Sep 2022 17:32:11 -0700
Message-ID: <20220924003211.775483-3-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220924003211.775483-1-jmeng@fb.com>
References: <a6d54d1e-f525-0351-18bd-647ea3d4814f@iogearbox.net>
 <20220924003211.775483-1-jmeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZtZphlt_zewvgm3zuyXmFQU7VJ-8vDIr
X-Proofpoint-ORIG-GUID: ZtZphlt_zewvgm3zuyXmFQU7VJ-8vDIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current tests cover only shifts with an immediate as the source
operand/shift counts; add a new test case to cover register operand.

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 tools/testing/selftests/bpf/verifier/jit.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/s=
elftests/bpf/verifier/jit.c
index 79021c30e51e..44f2e0c614b8 100644
--- a/tools/testing/selftests/bpf/verifier/jit.c
+++ b/tools/testing/selftests/bpf/verifier/jit.c
@@ -20,6 +20,28 @@
 	.result =3D ACCEPT,
 	.retval =3D 2,
 },
+{
+	"jit: lsh, rsh, arsh by reg",
+	.insns =3D {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_MOV64_IMM(BPF_REG_1, 0xff),
+	BPF_ALU64_REG(BPF_LSH, BPF_REG_1, BPF_REG_0),
+	BPF_ALU32_REG(BPF_LSH, BPF_REG_1, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x3fc, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_RSH, BPF_REG_1, BPF_REG_0),
+	BPF_ALU32_REG(BPF_RSH, BPF_REG_1, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0xff, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_ARSH, BPF_REG_1, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x7f, 1),
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

