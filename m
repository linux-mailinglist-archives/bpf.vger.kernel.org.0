Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E20581828
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiGZRL6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGZRL5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 13:11:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50E113F85
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:11:56 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QGtQUk012140
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:11:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=hZGvQPYIDtsNxLbVmfzmqVqDuTF5iehhIOecZNPxwEg=;
 b=ndJJFzExrXVK2T5soTo4ZVy63MP5090RIXzOsQtM1B5ig+RYUWaEgNFZlPrA8wbpdbO1
 WueB3Yks2o1uUKvLIFSQVdXq4/AjUGUMMd8wDki79P/uuDdfqUl4aP4+kpH6Q/iSqu1y
 zGB8MkKUa18JZUnwr7Rz7QdA4OqXjyxm7KI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hhxbwr2y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:11:56 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 10:11:55 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 523ADD40E958; Tue, 26 Jul 2022 10:11:46 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 3/7] bpf: x86: Rename stack_size to regs_off in {save,restore}_regs()
Date:   Tue, 26 Jul 2022 10:11:46 -0700
Message-ID: <20220726171146.710941-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726171129.708371-1-yhs@fb.com>
References: <20220726171129.708371-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gZOzY25r719MlfZyHWa9q7ebJxuMjX2S
X-Proofpoint-ORIG-GUID: gZOzY25r719MlfZyHWa9q7ebJxuMjX2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rename argument 'stack_size' to 'regs_off' in save_regs() and
restore_regs() since in reality 'stack_size' represents a particular
stack offset and 'regs_off' is the one in the caller argument.
Leter, another stack offset will be added to these two functions
for saving and restoring struct argument values.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c1f6c1c51d99..2657b58001cf 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1749,7 +1749,7 @@ st:			if (is_imm8(insn->off))
 }
=20
 static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_=
args,
-		      int stack_size)
+		      int regs_off)
 {
 	int i;
 	/* Store function arguments to stack.
@@ -1761,11 +1761,11 @@ static void save_regs(const struct btf_func_model=
 *m, u8 **prog, int nr_args,
 		emit_stx(prog, bytes_to_bpf_size(m->arg_size[i]),
 			 BPF_REG_FP,
 			 i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
-			 -(stack_size - i * 8));
+			 -(regs_off - i * 8));
 }
=20
 static void restore_regs(const struct btf_func_model *m, u8 **prog, int =
nr_args,
-			 int stack_size)
+			 int regs_off)
 {
 	int i;
=20
@@ -1778,7 +1778,7 @@ static void restore_regs(const struct btf_func_mode=
l *m, u8 **prog, int nr_args,
 		emit_ldx(prog, bytes_to_bpf_size(m->arg_size[i]),
 			 i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
 			 BPF_REG_FP,
-			 -(stack_size - i * 8));
+			 -(regs_off - i * 8));
 }
=20
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
--=20
2.30.2

