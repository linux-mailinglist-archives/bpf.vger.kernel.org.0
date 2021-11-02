Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B10442740
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 07:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKBGsY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 02:48:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36308 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229931AbhKBGsX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 02:48:23 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A25BhYM015653
        for <bpf@vger.kernel.org>; Mon, 1 Nov 2021 23:45:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ImH5BLKTqdZKxroXvvLpP3a3aLysjTbO7t2QaIEafyw=;
 b=ph+6ZyEvzhOQtyswD7AIbDtE5MkUWuByXf0Dh9Qu2giqAfcQTDGSXJobblJcwQfUpgFf
 ng0KkItC7jqZqVIVoY3hfXyOLBmBLgHydPLeF2F8pbBXEc+PiaChFO+V9TFhVIfILe2o
 OMCF3KCV0gJIm+1yTaie0sEkHy9KLpyQ6LE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c2xy6rcqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 23:45:49 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 23:45:47 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id AFDC51C668AA; Mon,  1 Nov 2021 23:45:41 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 2/2] bpf: selftest: verifier test on refill from a smaller spill
Date:   Mon, 1 Nov 2021 23:45:41 -0700
Message-ID: <20211102064541.316414-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102064528.315637-1-kafai@fb.com>
References: <20211102064528.315637-1-kafai@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: J97NK2V5P7RuoZy3uBPU-Ar6Tlv6B5XQ
X-Proofpoint-ORIG-GUID: J97NK2V5P7RuoZy3uBPU-Ar6Tlv6B5XQ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_05,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=675 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a verifier test to ensure the verifier
can read 8 bytes from the stack after two 32bit write at
fp-4 and fp-8.  The test is similar to the reported case from bcc [0].

[0]: https://github.com/iovisor/bcc/pull/3683

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 .../testing/selftests/bpf/verifier/spill_fill.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/spill_fill.c b/tools/test=
ing/selftests/bpf/verifier/spill_fill.c
index c9991c3f3bd2..7ab3de108761 100644
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ b/tools/testing/selftests/bpf/verifier/spill_fill.c
@@ -265,3 +265,20 @@
 	.result =3D ACCEPT,
 	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 },
+{
+	"Spill a u32 scalar at fp-4 and then at fp-8",
+	.insns =3D {
+	/* r4 =3D 4321 */
+	BPF_MOV32_IMM(BPF_REG_4, 4321),
+	/* *(u32 *)(r10 -4) =3D r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -4),
+	/* *(u32 *)(r10 -8) =3D r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 =3D *(u64 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D ACCEPT,
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+},
--=20
2.30.2

