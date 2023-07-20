Return-Path: <bpf+bounces-5397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB8175A30B
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9E2281BC8
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4953F4422;
	Thu, 20 Jul 2023 00:02:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E83FDC
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:02:34 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC20172D
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:33 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMZwWD031335
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=dCNFxCMda+TMYapX30mkHwrZCZ4/rQW5RLYkdhRn5Yk=;
 b=NtUW96AE/iK1GWtKtDHTAk+M7EF+cUgcoi5Yj0dn03itrDicybqmyow3QRMJE0r878Ts
 05FC0WV3UnQExhQvyadZEDjImr0ynluiotFN0c8lckjuEekFt33hQDeHKRjJTRVJ+MMq
 nZtoRCGlzOWU/gWA+6O09OuhuKSv2UWwMr8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxbc6q1c5-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:32 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:02:03 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2B99B2354E915; Wed, 19 Jul 2023 17:01:52 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 09/17] selftests/bpf: Fix a test_verifier failure
Date: Wed, 19 Jul 2023 17:01:52 -0700
Message-ID: <20230720000152.107378-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cl9D4wa5ICJRVt4_sU2lfrWQ7MAfCHbl
X-Proofpoint-ORIG-GUID: cl9D4wa5ICJRVt4_sU2lfrWQ7MAfCHbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following test_verifier subtest failed due to
new encoding for BSWAP.

  $ ./test_verifier
  ...
  #99/u invalid 64-bit BPF_END FAIL
  Unexpected success to load!
  verification time 215 usec
  stack depth 0
  processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
  #99/p invalid 64-bit BPF_END FAIL
  Unexpected success to load!
  verification time 198 usec
  stack depth 0
  processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0

Tighten the test so it still reports a failure.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/verifier/basic_instr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/basic_instr.c b/tools/t=
esting/selftests/bpf/verifier/basic_instr.c
index 071dbc889e8c..bd928a72ad73 100644
--- a/tools/testing/selftests/bpf/verifier/basic_instr.c
+++ b/tools/testing/selftests/bpf/verifier/basic_instr.c
@@ -176,11 +176,11 @@
 	.retval =3D 1,
 },
 {
-	"invalid 64-bit BPF_END",
+	"invalid 64-bit BPF_END with BPF_TO_BE",
 	.insns =3D {
 	BPF_MOV32_IMM(BPF_REG_0, 0),
 	{
-		.code  =3D BPF_ALU64 | BPF_END | BPF_TO_LE,
+		.code  =3D BPF_ALU64 | BPF_END | BPF_TO_BE,
 		.dst_reg =3D BPF_REG_0,
 		.src_reg =3D 0,
 		.off   =3D 0,
@@ -188,7 +188,7 @@
 	},
 	BPF_EXIT_INSN(),
 	},
-	.errstr =3D "unknown opcode d7",
+	.errstr =3D "unknown opcode df",
 	.result =3D REJECT,
 },
 {
--=20
2.34.1


