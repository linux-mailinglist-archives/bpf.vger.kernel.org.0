Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8861E686D
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405341AbgE1RM4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 13:12:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59572 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405336AbgE1RMy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 May 2020 13:12:54 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SH5XRU010329
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 10:12:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JfEyNFtXvQs+vT7icUWbvwhGv9lXDmp7BZhGgSEmsbY=;
 b=flHOiBfmFrDZaElEGh7a7rxiNnyyL/6BpMs7WeQWzZK61UpUen7Dr5VvT9po9zLBXEMc
 AsNbaSkfxv8ivmt//RkbFkL0p1uTtq3b2Xsdf+tcYG3BUCFRFfjDHjopj8TbSxCG8WIr
 OOqUSaZg/Z7soIrc01+iC9SuqbOpwRsh/rA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 319bqcv1ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 10:12:48 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 May 2020 10:12:47 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id C36C437053B1; Thu, 28 May 2020 09:50:44 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 2/2] tools/bpf: add a verifier test for assigning 32bit reg states to 64bit ones
Date:   Thu, 28 May 2020 09:50:44 -0700
Message-ID: <20200528165044.1568896-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200528165043.1568623-1-yhs@fb.com>
References: <20200528165043.1568623-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_03:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=13 mlxlogscore=562 spamscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280119
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added a verifier test for assigning 32bit reg states to
64bit where 32bit reg holds a constant value of 0.

Without previous kernel verifier.c fix, the test in
this patch will fail.

Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/verifier/bounds.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testin=
g/selftests/bpf/verifier/bounds.c
index a253a064e6e0..e2739ca2abec 100644
--- a/tools/testing/selftests/bpf/verifier/bounds.c
+++ b/tools/testing/selftests/bpf/verifier/bounds.c
@@ -539,3 +539,25 @@
 	},
 	.result =3D ACCEPT
 },
+{
+	"assigning 32bit bounds to 64bit for wA =3D 0, wB =3D wA",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_MOV32_IMM(BPF_REG_9, 0),
+	BPF_MOV32_REG(BPF_REG_2, BPF_REG_9),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_2),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 8),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_8, 1),
+	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_6, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+	.result =3D ACCEPT,
+	.flags =3D F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
--=20
2.24.1

