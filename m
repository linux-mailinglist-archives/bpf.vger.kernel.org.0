Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A37DD1F67
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 06:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfJJEPX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 10 Oct 2019 00:15:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732252AbfJJEPW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Oct 2019 00:15:22 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9A4Ap2o018306
        for <bpf@vger.kernel.org>; Wed, 9 Oct 2019 21:15:21 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vhnsj9t2y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 21:15:21 -0700
Received: from 2401:db00:2050:5076:face:0:9:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Oct 2019 21:15:20 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 870F5760CF9; Wed,  9 Oct 2019 21:15:19 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <x86@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 08/12] bpf: add support for BTF pointers to interpreter
Date:   Wed, 9 Oct 2019 21:14:59 -0700
Message-ID: <20191010041503.2526303-9-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010041503.2526303-1-ast@kernel.org>
References: <20191010041503.2526303-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_01:2019-10-08,2019-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=1
 adultscore=0 mlxlogscore=813 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910100037
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pointer to BTF object is a pointer to kernel object or NULL.
The memory access in the interpreter has to be done via probe_kernel_read
to avoid page faults.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/filter.h |  3 +++
 kernel/bpf/core.c      | 19 +++++++++++++++++++
 kernel/bpf/verifier.c  |  8 ++++++++
 3 files changed, 30 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index d3d51d7aff2c..22ebea2e64ea 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -65,6 +65,9 @@ struct ctl_table_header;
 /* unused opcode to mark special call to bpf_tail_call() helper */
 #define BPF_TAIL_CALL	0xf0
 
+/* unused opcode to mark special load instruction. Same as BPF_ABS */
+#define BPF_PROBE_MEM	0x20
+
 /* unused opcode to mark call to interpreter with arguments */
 #define BPF_CALL_ARGS	0xe0
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 66088a9e9b9e..8a765bbd33f0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1291,6 +1291,11 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
+u64 __weak bpf_probe_read(void * dst, u32 size, const void * unsafe_ptr)
+{
+	memset(dst, 0, size);
+	return -EFAULT;
+}
 /**
  *	__bpf_prog_run - run eBPF program on a given context
  *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
@@ -1310,6 +1315,10 @@ static u64 __no_fgcse ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u6
 		/* Non-UAPI available opcodes. */
 		[BPF_JMP | BPF_CALL_ARGS] = &&JMP_CALL_ARGS,
 		[BPF_JMP | BPF_TAIL_CALL] = &&JMP_TAIL_CALL,
+		[BPF_LDX | BPF_PROBE_MEM | BPF_B] = &&LDX_PROBE_MEM_B,
+		[BPF_LDX | BPF_PROBE_MEM | BPF_H] = &&LDX_PROBE_MEM_H,
+		[BPF_LDX | BPF_PROBE_MEM | BPF_W] = &&LDX_PROBE_MEM_W,
+		[BPF_LDX | BPF_PROBE_MEM | BPF_DW] = &&LDX_PROBE_MEM_DW,
 	};
 #undef BPF_INSN_3_LBL
 #undef BPF_INSN_2_LBL
@@ -1542,6 +1551,16 @@ static u64 __no_fgcse ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u6
 	LDST(W,  u32)
 	LDST(DW, u64)
 #undef LDST
+#define LDX_PROBE(SIZEOP, SIZE)						\
+	LDX_PROBE_MEM_##SIZEOP:						\
+		bpf_probe_read(&DST, SIZE, (const void *)(long) SRC);	\
+		CONT;
+	LDX_PROBE(B,  1)
+	LDX_PROBE(H,  2)
+	LDX_PROBE(W,  4)
+	LDX_PROBE(DW, 8)
+#undef LDX_PROBE
+
 	STX_XADD_W: /* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
 		atomic_add((u32) SRC, (atomic_t *)(unsigned long)
 			   (DST + insn->off));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8246275704aa..2ade5193b76c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7526,6 +7526,7 @@ static bool reg_type_mismatch_ok(enum bpf_reg_type type)
 	case PTR_TO_TCP_SOCK:
 	case PTR_TO_TCP_SOCK_OR_NULL:
 	case PTR_TO_XDP_SOCK:
+	case PTR_TO_BTF_ID:
 		return false;
 	default:
 		return true;
@@ -8667,6 +8668,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		case PTR_TO_XDP_SOCK:
 			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
 			break;
+		case PTR_TO_BTF_ID:
+			if (type == BPF_WRITE) {
+				verbose(env, "Writes through BTF pointers are not allowed\n");
+				return -EINVAL;
+			}
+			insn->code = BPF_LDX | BPF_PROBE_MEM | BPF_SIZE((insn)->code);
+			continue;
 		default:
 			continue;
 		}
-- 
2.23.0

