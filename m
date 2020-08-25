Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3569D251249
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 08:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgHYGqR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 02:46:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7380 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729076AbgHYGqQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Aug 2020 02:46:16 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P6V13W010684
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 23:46:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LBe1l3d5f6SkPeVfYDrHE3IziOGKXvQ2fF3XZpp0PR8=;
 b=o+nDEmxeketqK96Zz5N9fcY0ui9VeBcB8SgeKHbbYfK282GKgeAeNEjdSxFm68l86CsX
 CmH975jAxh4GoXJso0MyM9QJt/wQ6xJyb6OR9GJb0dJmPOCtITjuA/ZdPkGIKbcd3ejP
 GOQ+0tJhbvffx7d/ru6D4O4JPp0HHXdkong= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 333jv9s5xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2020 23:46:15 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 23:46:14 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 9426F370546C; Mon, 24 Aug 2020 23:46:09 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/2] selftests/bpf: add verifier tests for xor operation
Date:   Mon, 24 Aug 2020 23:46:09 -0700
Message-ID: <20200825064609.2018077-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200825064608.2017878-1-yhs@fb.com>
References: <20200825064608.2017878-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=13 mlxlogscore=624 lowpriorityscore=0 clxscore=1015
 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250049
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added some test_verifier bounds check test cases for
xor operations.
  $ ./test_verifier
  ...
  #78/u bounds check for reg =3D 0, reg xor 1 OK
  #78/p bounds check for reg =3D 0, reg xor 1 OK
  #79/u bounds check for reg32 =3D 0, reg32 xor 1 OK
  #79/p bounds check for reg32 =3D 0, reg32 xor 1 OK
  #80/u bounds check for reg =3D 2, reg xor 3 OK
  #80/p bounds check for reg =3D 2, reg xor 3 OK
  #81/u bounds check for reg =3D any, reg xor 3 OK
  #81/p bounds check for reg =3D any, reg xor 3 OK
  #82/u bounds check for reg32 =3D any, reg32 xor 3 OK
  #82/p bounds check for reg32 =3D any, reg32 xor 3 OK
  #83/u bounds check for reg > 0, reg xor 3 OK
  #83/p bounds check for reg > 0, reg xor 3 OK
  #84/u bounds check for reg32 > 0, reg32 xor 3 OK
  #84/p bounds check for reg32 > 0, reg32 xor 3 OK
  ...

Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/verifier/bounds.c | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testin=
g/selftests/bpf/verifier/bounds.c
index 4d6645f2874c..dac40de3f868 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -557,3 +557,149 @@
 	.result =3D ACCEPT,
 	.flags =3D F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
+{
+	"bounds check for reg =3D 0, reg xor 1",
+	.insns =3D {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 1),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_8b =3D { 3 },
+	.result =3D ACCEPT,
+},
+{
+	"bounds check for reg32 =3D 0, reg32 xor 1",
+	.insns =3D {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV32_IMM(BPF_REG_1, 0),
+	BPF_ALU32_IMM(BPF_XOR, BPF_REG_1, 1),
+	BPF_JMP32_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_8b =3D { 3 },
+	.result =3D ACCEPT,
+},
+{
+	"bounds check for reg =3D 2, reg xor 3",
+	.insns =3D {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_1, 2),
+	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 3),
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_8b =3D { 3 },
+	.result =3D ACCEPT,
+},
+{
+	"bounds check for reg =3D any, reg xor 3",
+	.insns =3D {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
+	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 3),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_8b =3D { 3 },
+	.result =3D REJECT,
+	.errstr =3D "invalid access to map value",
+	.errstr_unpriv =3D "invalid access to map value",
+},
+{
+	"bounds check for reg32 =3D any, reg32 xor 3",
+	.insns =3D {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
+	BPF_ALU32_IMM(BPF_XOR, BPF_REG_1, 3),
+	BPF_JMP32_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_8b =3D { 3 },
+	.result =3D REJECT,
+	.errstr =3D "invalid access to map value",
+	.errstr_unpriv =3D "invalid access to map value",
+},
+{
+	"bounds check for reg > 0, reg xor 3",
+	.insns =3D {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_1, 0, 3),
+	BPF_ALU64_IMM(BPF_XOR, BPF_REG_1, 3),
+	BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_8b =3D { 3 },
+	.result =3D ACCEPT,
+},
+{
+	"bounds check for reg32 > 0, reg32 xor 3",
+	.insns =3D {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
+	BPF_JMP32_IMM(BPF_JLE, BPF_REG_1, 0, 3),
+	BPF_ALU32_IMM(BPF_XOR, BPF_REG_1, 3),
+	BPF_JMP32_IMM(BPF_JGE, BPF_REG_1, 0, 1),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_8b =3D { 3 },
+	.result =3D ACCEPT,
+},
--=20
2.24.1

