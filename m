Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1761267BECA
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbjAYVkB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbjAYVjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:54 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101DC47EC9
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:49 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLdGc031899;
        Wed, 25 Jan 2023 21:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QlsN8AQYhSjXsgsdW18FPRNDRMxSJxlHr4Jl3d3wlvI=;
 b=IpwJbWZezLIzKQHs4N/8tMUmxlM3jt6OsDNHLbvyhNosKvtwnvfNDXFUHBYIBr2aAk6o
 F6QFU5EPubF7W37QWZsVxxy/75RxGX08AvFYeOYgCgrZzB3rR5jWNjHEueCM5ud2ML+s
 98xJH8Td2QaWVQVXWi5V/xR8IavA2rXG3EIKTinfox4YQjYkH4E2mPt9QZP/MC2iC/1N
 +vTtAdKhpHioRDGhu4o9g0i+nFU3VQV1yYNW1nyktATCvLG/1yYq32lWfGZBfO3Da3hL
 1+hnRmB0DEHCdGyC8lFO8fZ0kseGut8+Y/UpPL8myz2ccMVmHnTJu2w+sT6Fqw3e2bxw 6A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vd4acu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PIIWnC019104;
        Wed, 25 Jan 2023 21:39:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6nm0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdVrY49349102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7892B2004D;
        Wed, 25 Jan 2023 21:39:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 451DD20043;
        Wed, 25 Jan 2023 21:39:31 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:31 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 20/24] s390/bpf: Implement bpf_arch_text_poke()
Date:   Wed, 25 Jan 2023 22:38:13 +0100
Message-Id: <20230125213817.1424447-21-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dl4xDkI-CzLSbKLrgTA6jh2uLoFj05DR
X-Proofpoint-ORIG-GUID: dl4xDkI-CzLSbKLrgTA6jh2uLoFj05DR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_arch_text_poke() is used to hotpatch eBPF programs and trampolines.
s390x has a very strict hotpatching restriction: the only thing that is
allowed to be hotpatched is conditional branch mask.

Take the same approach as commit de5012b41e5c ("s390/ftrace: implement
hotpatching"): create a conditional jump to a "plt", which loads the
target address from memory and jumps to it; then first patch this
address, and then the mask.

Trampolines (introduced in the next patch) respect the ftrace calling
convention: the return address is in %r0, and %r1 is clobbered. With
that in mind, bpf_arch_text_poke() does not differentiate between jumps
and calls.

However, there is a simple optimization for jumps (for the epilogue_ip
case): if a jump already points to the destination, then there is no
"plt" and we can just flip the mask.

For simplicity, the "plt" template is defined in assembly, and its size
is used to define C arrays. There doesn't seem to be a way to convey
this size to C as a constant, so it's hardcoded and double-checked
during runtime.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 97 ++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 8400a06c926e..c72eb3fc1f98 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -30,6 +30,7 @@
 #include <asm/facility.h>
 #include <asm/nospec-branch.h>
 #include <asm/set_memory.h>
+#include <asm/text-patching.h>
 #include "bpf_jit.h"
 
 struct bpf_jit {
@@ -50,6 +51,8 @@ struct bpf_jit {
 	int r14_thunk_ip;	/* Address of expoline thunk for 'br %r14' */
 	int tail_call_start;	/* Tail call start offset */
 	int excnt;		/* Number of exception table entries */
+	int prologue_plt_ret;	/* Return address for prologue hotpatch PLT */
+	int prologue_plt;	/* Start of prologue hotpatch PLT */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -506,6 +509,36 @@ static void bpf_skip(struct bpf_jit *jit, int size)
 	}
 }
 
+/*
+ * PLT for hotpatchable calls. The calling convention is the same as for the
+ * ftrace hotpatch trampolines: %r0 is return address, %r1 is clobbered.
+ */
+extern const char bpf_plt[];
+extern const char bpf_plt_ret[];
+extern const char bpf_plt_target[];
+extern const char bpf_plt_end[];
+#define BPF_PLT_SIZE 32
+asm(
+	".pushsection .rodata\n"
+	"	.align 8\n"
+	"bpf_plt:\n"
+	"	lgrl %r0,bpf_plt_ret\n"
+	"	lgrl %r1,bpf_plt_target\n"
+	"	br %r1\n"
+	"	.align 8\n"
+	"bpf_plt_ret: .quad 0\n"
+	"bpf_plt_target: .quad 0\n"
+	"bpf_plt_end:\n"
+	"	.popsection\n"
+);
+
+static void bpf_jit_plt(void *plt, void *ret, void *target)
+{
+	memcpy(plt, bpf_plt, BPF_PLT_SIZE);
+	*(void **)((char *)plt + (bpf_plt_ret - bpf_plt)) = ret;
+	*(void **)((char *)plt + (bpf_plt_target - bpf_plt)) = target;
+}
+
 /*
  * Emit function prologue
  *
@@ -514,6 +547,11 @@ static void bpf_skip(struct bpf_jit *jit, int size)
  */
 static void bpf_jit_prologue(struct bpf_jit *jit, u32 stack_depth)
 {
+	/* No-op for hotpatching */
+	/* brcl 0,prologue_plt */
+	EMIT6_PCREL_RILC(0xc0040000, 0, jit->prologue_plt);
+	jit->prologue_plt_ret = jit->prg;
+
 	if (jit->seen & SEEN_TAIL_CALL) {
 		/* xc STK_OFF_TCCNT(4,%r15),STK_OFF_TCCNT(%r15) */
 		_EMIT6(0xd703f000 | STK_OFF_TCCNT, 0xf000 | STK_OFF_TCCNT);
@@ -589,6 +627,13 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 		/* br %r1 */
 		_EMIT2(0x07f1);
 	}
+
+	jit->prg = ALIGN(jit->prg, 8);
+	jit->prologue_plt = jit->prg;
+	if (jit->prg_buf)
+		bpf_jit_plt(jit->prg_buf + jit->prg,
+			    jit->prg_buf + jit->prologue_plt_ret, NULL);
+	jit->prg += BPF_PLT_SIZE;
 }
 
 static int get_probe_mem_regno(const u8 *insn)
@@ -1776,6 +1821,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	struct bpf_jit jit;
 	int pass;
 
+	if (WARN_ON_ONCE(bpf_plt_end - bpf_plt != BPF_PLT_SIZE))
+		return orig_fp;
+
 	if (!fp->jit_requested)
 		return orig_fp;
 
@@ -1867,3 +1915,52 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 					   tmp : orig_fp);
 	return fp;
 }
+
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
+		       void *old_addr, void *new_addr)
+{
+	struct {
+		u16 opc;
+		s32 disp;
+	} __packed insn;
+	char expected_plt[BPF_PLT_SIZE];
+	char current_plt[BPF_PLT_SIZE];
+	char *plt;
+	int err;
+
+	/* Verify the branch to be patched. */
+	err = copy_from_kernel_nofault(&insn, ip, sizeof(insn));
+	if (err < 0)
+		return err;
+	if (insn.opc != (0xc004 | (old_addr ? 0xf0 : 0)))
+		return -EINVAL;
+
+	if (t == BPF_MOD_JUMP &&
+	    insn.disp == ((char *)new_addr - (char *)ip) >> 1) {
+		/*
+		 * The branch already points to the destination,
+		 * there is no PLT.
+		 */
+	} else {
+		/* Verify the PLT. */
+		plt = (char *)ip + (insn.disp << 1);
+		err = copy_from_kernel_nofault(current_plt, plt, BPF_PLT_SIZE);
+		if (err < 0)
+			return err;
+		bpf_jit_plt(expected_plt, (char *)ip + 6, old_addr);
+		if (memcmp(current_plt, expected_plt, BPF_PLT_SIZE))
+			return -EINVAL;
+		/* Adjust the call address. */
+		s390_kernel_write(plt + (bpf_plt_target - bpf_plt),
+				  &new_addr, sizeof(void *));
+	}
+
+	/* Adjust the mask of the branch. */
+	insn.opc = 0xc004 | (new_addr ? 0xf0 : 0);
+	s390_kernel_write((char *)ip + 1, (char *)&insn.opc + 1, 1);
+
+	/* Make the new code visible to the other CPUs. */
+	text_poke_sync_lock();
+
+	return 0;
+}
-- 
2.39.1

