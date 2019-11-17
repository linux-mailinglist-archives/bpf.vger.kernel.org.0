Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098E3FFB56
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2019 19:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfKQS1J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Nov 2019 13:27:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfKQS1J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 17 Nov 2019 13:27:09 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAHIDqEO015339
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2019 10:27:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qM5slAFLCoBQ1cEs+mAqecjT6P+aVBUZq0z2t0DI8Vs=;
 b=FzwmvoPheMgAcX1mRZewm6SyOE28g3mGxxLQFY87iHNj3WBWHbbeaMYAeelbuuoBk+yO
 ly+6O3XozRbHVxnYWfSLeF75BPwRgEekkc+bRc43NtAKu10Ag5cBmS46dlbpAw/lX96K
 X0trtSth7jWrp2RGEH+pGY7ryotJKwTqsDw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wb1pvk55m-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2019 10:27:08 -0800
Received: from 2401:db00:2050:5102:face:0:37:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Nov 2019 10:27:06 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 8FDB83701D60; Sun, 17 Nov 2019 10:27:05 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/2] [tools/bpf] add verifier test for s32/u32 helper return values
Date:   Sun, 17 Nov 2019 10:27:05 -0800
Message-ID: <20191117182705.656799-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191117182704.656602-1-yhs@fb.com>
References: <20191117182704.656602-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-17_04:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=486
 suspectscore=13 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911170175
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added two verifier tests for helper returning s32/u32.
The return value is refined with jmp32 instruction and
later the whole r0 is used. With the previous patch,
two tests will fail.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/verifier/helper_ret.c       | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/helper_ret.c

diff --git a/tools/testing/selftests/bpf/verifier/helper_ret.c b/tools/testing/selftests/bpf/verifier/helper_ret.c
new file mode 100644
index 000000000000..7850a52645a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/helper_ret.c
@@ -0,0 +1,50 @@
+{
+	"helper_ret: get_cgroup_classid: __u32",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_get_cgroup_classid),
+	BPF_JMP32_IMM(BPF_JGE, BPF_REG_0, 7, 2),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_0),
+	BPF_ST_MEM(BPF_B, BPF_REG_6, 0, 0),
+        BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_hash_48b = { 4 },
+	.result = ACCEPT,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
+{
+	"helper_ret: skb_pull_data: __s32",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_2, 4),
+	BPF_EMIT_CALL(BPF_FUNC_skb_pull_data),
+	BPF_JMP32_IMM(BPF_JSLT, BPF_REG_0, 1, 3),
+	BPF_JMP32_IMM(BPF_JSGE, BPF_REG_0, 7, 2),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_0),
+	BPF_ST_MEM(BPF_B, BPF_REG_6, 0, 0),
+        BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_hash_48b = { 4 },
+	.result = ACCEPT,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
-- 
2.17.1

