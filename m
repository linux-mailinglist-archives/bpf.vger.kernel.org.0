Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2EB221878
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 01:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGOXfl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 19:35:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726770AbgGOXfk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 19:35:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FNW60X018494;
        Wed, 15 Jul 2020 19:35:28 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329dhxnbuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 19:35:28 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FNJj4N014441;
        Wed, 15 Jul 2020 23:35:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 327527w34m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 23:35:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FNY9BR57803174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 23:34:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05522A4060;
        Wed, 15 Jul 2020 23:34:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C875A405B;
        Wed, 15 Jul 2020 23:34:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.186.215])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 23:34:08 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 3/4] s390/bpf: implement BPF_PROBE_MEM
Date:   Thu, 16 Jul 2020 01:33:00 +0200
Message-Id: <20200715233301.933201-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200715233301.933201-1-iii@linux.ibm.com>
References: <20200715233301.933201-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=2 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150171
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a s390 port of x86 commit 3dec541b2e63 ("bpf: Add support for BTF
pointers to x86 JIT").

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 139 ++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index f4242b894cf2..8fe7bdfc8d15 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -49,6 +49,7 @@ struct bpf_jit {
 	int r1_thunk_ip;	/* Address of expoline thunk for 'br %r1' */
 	int r14_thunk_ip;	/* Address of expoline thunk for 'br %r14' */
 	int tail_call_start;	/* Tail call start offset */
+	int excnt;		/* Number of exception table entries */
 	int labels[1];		/* Labels for local jumps */
 };
 
@@ -588,6 +589,84 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	}
 }
 
+static int get_probe_mem_regno(const u8 *insn)
+{
+	/*
+	 * insn must point to llgc, llgh, llgf or lg, which have destination
+	 * register at the same position.
+	 */
+	if (insn[0] != 0xe3) /* common llgc, llgh, llgf and lg prefix */
+		return -1;
+	if (insn[5] != 0x90 && /* llgc */
+	    insn[5] != 0x91 && /* llgh */
+	    insn[5] != 0x16 && /* llgf */
+	    insn[5] != 0x04) /* lg */
+		return -1;
+	return insn[1] >> 4;
+}
+
+static bool ex_handler_bpf(const struct exception_table_entry *x,
+			   struct pt_regs *regs)
+{
+	int regno;
+	u8 *insn;
+
+	regs->psw.addr = extable_fixup(x);
+	insn = (u8 *)__rewind_psw(regs->psw, regs->int_code >> 16);
+	regno = get_probe_mem_regno(insn);
+	if (WARN_ON_ONCE(regno < 0))
+		/* JIT bug - unexpected instruction. */
+		return false;
+	regs->gprs[regno] = 0;
+	return true;
+}
+
+static int bpf_jit_probe_mem(struct bpf_jit *jit, struct bpf_prog *fp,
+			     int probe_prg, int nop_prg)
+{
+	struct exception_table_entry *ex;
+	s64 delta;
+	u8 *insn;
+	int prg;
+	int i;
+
+	if (!fp->aux->extable)
+		/* Do nothing during early JIT passes. */
+		return 0;
+	insn = jit->prg_buf + probe_prg;
+	if (WARN_ON_ONCE(get_probe_mem_regno(insn) < 0))
+		/* JIT bug - unexpected probe instruction. */
+		return -1;
+	if (WARN_ON_ONCE(probe_prg + insn_length(*insn) != nop_prg))
+		/* JIT bug - gap between probe and nop instructions. */
+		return -1;
+	for (i = 0; i < 2; i++) {
+		if (WARN_ON_ONCE(jit->excnt >= fp->aux->num_exentries))
+			/* Verifier bug - not enough entries. */
+			return -1;
+		ex = &fp->aux->extable[jit->excnt];
+		/* Add extable entries for probe and nop instructions. */
+		prg = i == 0 ? probe_prg : nop_prg;
+		delta = jit->prg_buf + prg - (u8 *)&ex->insn;
+		if (WARN_ON_ONCE(delta < INT_MIN || delta > INT_MAX))
+			/* JIT bug - code and extable must be close. */
+			return -1;
+		ex->insn = delta;
+		/*
+		 * Always land on the nop. Note that extable infrastructure
+		 * ignores fixup field, it is handled by ex_handler_bpf().
+		 */
+		delta = jit->prg_buf + nop_prg - (u8 *)&ex->fixup;
+		if (WARN_ON_ONCE(delta < INT_MIN || delta > INT_MAX))
+			/* JIT bug - landing pad and extable must be close. */
+			return -1;
+		ex->fixup = delta;
+		ex->handler = (u8 *)ex_handler_bpf - (u8 *)&ex->handler;
+		jit->excnt++;
+	}
+	return 0;
+}
+
 /*
  * Compile one eBPF instruction into s390x code
  *
@@ -604,7 +683,14 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	u32 *addrs = jit->addrs;
 	s32 imm = insn->imm;
 	s16 off = insn->off;
+	int probe_prg = -1;
 	unsigned int mask;
+	int nop_prg;
+	int err;
+
+	if (BPF_CLASS(insn->code) == BPF_LDX &&
+	    BPF_MODE(insn->code) == BPF_PROBE_MEM)
+		probe_prg = jit->prg;
 
 	switch (insn->code) {
 	/*
@@ -1119,6 +1205,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	 * BPF_LDX
 	 */
 	case BPF_LDX | BPF_MEM | BPF_B: /* dst = *(u8 *)(ul) (src + off) */
+	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
 		/* llgc %dst,0(off,%src) */
 		EMIT6_DISP_LH(0xe3000000, 0x0090, dst_reg, src_reg, REG_0, off);
 		jit->seen |= SEEN_MEM;
@@ -1126,6 +1213,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			insn_count = 2;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
+	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
 		/* llgh %dst,0(off,%src) */
 		EMIT6_DISP_LH(0xe3000000, 0x0091, dst_reg, src_reg, REG_0, off);
 		jit->seen |= SEEN_MEM;
@@ -1133,6 +1221,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			insn_count = 2;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
+	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 		/* llgf %dst,off(%src) */
 		jit->seen |= SEEN_MEM;
 		EMIT6_DISP_LH(0xe3000000, 0x0016, dst_reg, src_reg, REG_0, off);
@@ -1140,6 +1229,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			insn_count = 2;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
+	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
 		/* lg %dst,0(off,%src) */
 		jit->seen |= SEEN_MEM;
 		EMIT6_DISP_LH(0xe3000000, 0x0004, dst_reg, src_reg, REG_0, off);
@@ -1485,6 +1575,23 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		pr_err("Unknown opcode %02x\n", insn->code);
 		return -1;
 	}
+
+	if (probe_prg != -1) {
+		/*
+		 * Handlers of certain exceptions leave psw.addr pointing to
+		 * the instruction directly after the failing one. Therefore,
+		 * create two exception table entries and also add a nop in
+		 * case two probing instructions come directly after each
+		 * other.
+		 */
+		nop_prg = jit->prg;
+		/* bcr 0,%0 */
+		_EMIT2(0x0700);
+		err = bpf_jit_probe_mem(jit, fp, probe_prg, nop_prg);
+		if (err < 0)
+			return err;
+	}
+
 	return insn_count;
 }
 
@@ -1527,6 +1634,7 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	jit->lit32 = jit->lit32_start;
 	jit->lit64 = jit->lit64_start;
 	jit->prg = 0;
+	jit->excnt = 0;
 
 	bpf_jit_prologue(jit, stack_depth);
 	if (bpf_set_addr(jit, 0) < 0)
@@ -1551,6 +1659,12 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 		jit->lit64_start = ALIGN(jit->lit64_start, 8);
 	jit->size = jit->lit64_start + lit64_size;
 	jit->size_prg = jit->prg;
+
+	if (WARN_ON_ONCE(fp->aux->extable &&
+			 jit->excnt != fp->aux->num_exentries))
+		/* Verifier bug - too many entries. */
+		return -1;
+
 	return 0;
 }
 
@@ -1565,6 +1679,29 @@ struct s390_jit_data {
 	int pass;
 };
 
+static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
+					       struct bpf_prog *fp)
+{
+	struct bpf_binary_header *header;
+	u32 extable_size;
+	u32 code_size;
+
+	/* We need two entries per insn. */
+	fp->aux->num_exentries *= 2;
+
+	code_size = roundup(jit->size,
+			    __alignof__(struct exception_table_entry));
+	extable_size = fp->aux->num_exentries *
+		sizeof(struct exception_table_entry);
+	header = bpf_jit_binary_alloc(code_size + extable_size, &jit->prg_buf,
+				      8, jit_fill_hole);
+	if (!header)
+		return NULL;
+	fp->aux->extable = (struct exception_table_entry *)
+		(jit->prg_buf + code_size);
+	return header;
+}
+
 /*
  * Compile eBPF program "fp"
  */
@@ -1631,7 +1768,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	/*
 	 * Final pass: Allocate and generate program
 	 */
-	header = bpf_jit_binary_alloc(jit.size, &jit.prg_buf, 8, jit_fill_hole);
+	header = bpf_jit_alloc(&jit, fp);
 	if (!header) {
 		fp = orig_fp;
 		goto free_addrs;
-- 
2.25.4

