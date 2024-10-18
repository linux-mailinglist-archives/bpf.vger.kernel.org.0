Return-Path: <bpf+bounces-42452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A2A9A450F
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E6D1C2314B
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A1E20C028;
	Fri, 18 Oct 2024 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jWXD4Tvp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFEF204082;
	Fri, 18 Oct 2024 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273086; cv=none; b=fjPg3KIO0BdxUEVyHlyGQPamWk+mz/Znv+NC0qNti41DlfaHCH5S65aCRFG90ldq82MOidWCeiCZ7Omk4l5woxzAMoczEOAmOe5FdX4JCfjlLb/QV/6eXpCFdbcdDS4dx971BHStTCgQj6wVlieNvnopQUjL33BgRivtnx4ExHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273086; c=relaxed/simple;
	bh=BzAbkglg8kMc+NLpQ1Lmlf6GiD/g0N2DRCVaOp7VcLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlrtvMZLGgvg/MfnLo9/yxlyntvlAG9OATRSb6xwggb4scQ2KrvKaciyFM6xDhk/kzpFS5E5mcfluUlEiVH0S3SWOI9HsJOS8h6YysEDdQmQYpdht23IAgYfpQhOvyfJOpOhURUcQ5WRNmVp8r/FMUcNO8phqSLeuv4rvjaajGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jWXD4Tvp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I5ZnGw012506;
	Fri, 18 Oct 2024 17:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LICnuxYU0Ym1+cMk4
	MP8LSbBT3j5mVwLr7BjvtOwads=; b=jWXD4TvpZR5IXvj1x1jxj9V9VTOehZQEy
	T6S4YETi/Cz+FRlOmNChevH6omFJyvBr+X/eYNzUzdppcMu+v8Y4aYqEQldaEt6k
	GUJGQA00826+V9BTn0QpPmMqySwUBMMwlg/i5ILvmLF8wfvEP0K8eQN3uXGFyNId
	N8oddMrCj1FHM9reFnmvv0yEtAmY+bsE2cS+sPFzeHjD3gEonDdUitToPfhoEbVi
	ttHIG+tU0tP4kX2k+7PHQbSuCgwvIr6bZWWxWHLajr6VcIvnkLA8q9JsFptv1bwU
	y0AW5MBKE0MAUrbTeD9W8OEwO5gt+eRlm9cUME/ZUusMvRde32TWA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42bhnfbs3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49IHbfLB024782;
	Fri, 18 Oct 2024 17:37:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42bhnfbs3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IHRq7U002343;
	Fri, 18 Oct 2024 17:37:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284en6029-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IHbZSE54133010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:37:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBBA72004B;
	Fri, 18 Oct 2024 17:37:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 475D820040;
	Fri, 18 Oct 2024 17:37:32 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.99.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 17:37:32 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH v6 13/17] powerpc64/ftrace: Support .text larger than 32MB with out-of-line stubs
Date: Fri, 18 Oct 2024 23:06:28 +0530
Message-ID: <20241018173632.277333-14-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018173632.277333-1-hbathini@linux.ibm.com>
References: <20241018173632.277333-1-hbathini@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x7rfRFkpabC98UqahOYqVQK8wC1b30p1
X-Proofpoint-ORIG-GUID: U2BBu8k5boYzFTpFtZX7Q_9WWdtUUt5v
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180111

From: Naveen N Rao <naveen@kernel.org>

We are restricted to a .text size of ~32MB when using out-of-line
function profile sequence. Allow this to be extended up to the previous
limit of ~64MB by reserving space in the middle of .text.

A new config option CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE is
introduced to specify the number of function stubs that are reserved in
.text. On boot, ftrace utilizes stubs from this area first before using
the stub area at the end of .text.

A ppc64le defconfig has ~44k functions that can be traced. A more
conservative value of 32k functions is chosen as the default value of
PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE so that we do not allot more space
than necessary by default. If building a kernel that only has 32k
trace-able functions, we won't allot any more space at the end of .text
during the pass on vmlinux.o. Otherwise, only the remaining functions
get space for stubs at the end of .text. This default value should help
cover a .text size of ~48MB in total (including space reserved at the
end of .text which can cover up to 32MB), which should be sufficient for
most common builds. For a very small kernel build, this can be set to 0.
Or, this can be bumped up to a larger value to support vmlinux .text
size up to ~64MB.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v6:
* Updated with Masahiro's suggestions at
  https://lore.kernel.org/all/CAK7LNAREkj5OQ_HA2H=iV_32qdOcaguCOBKV1j+dJW0YaQh3UA@mail.gmail.com/


 arch/powerpc/Kconfig                       | 12 ++++++++++++
 arch/powerpc/include/asm/ftrace.h          |  6 ++++--
 arch/powerpc/kernel/trace/ftrace.c         | 21 +++++++++++++++++----
 arch/powerpc/kernel/trace/ftrace_entry.S   |  8 ++++++++
 arch/powerpc/tools/Makefile                |  3 ++-
 arch/powerpc/tools/ftrace-gen-ool-stubs.sh | 19 +++++++++++++------
 6 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 26e3060e44f4..2e347f682c15 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -573,6 +573,18 @@ config PPC_FTRACE_OUT_OF_LINE
 	def_bool PPC64 && ARCH_USING_PATCHABLE_FUNCTION_ENTRY
 	select ARCH_WANTS_PRE_LINK_VMLINUX
 
+config PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE
+	int "Number of ftrace out-of-line stubs to reserve within .text"
+	depends on PPC_FTRACE_OUT_OF_LINE
+	default 32768
+	help
+	  Number of stubs to reserve for use by ftrace. This space is
+	  reserved within .text, and is distinct from any additional space
+	  added at the end of .text before the final vmlinux link. Set to
+	  zero to have stubs only be generated at the end of vmlinux (only
+	  if the size of vmlinux is less than 32MB). Set to a higher value
+	  if building vmlinux larger than 48MB.
+
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
 	depends on SMP && (PPC_PSERIES || \
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index bdbafc668b20..28f3590ca780 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -138,8 +138,10 @@ extern unsigned int ftrace_tramp_text[], ftrace_tramp_init[];
 struct ftrace_ool_stub {
 	u32	insn[4];
 };
-extern struct ftrace_ool_stub ftrace_ool_stub_text_end[], ftrace_ool_stub_inittext[];
-extern unsigned int ftrace_ool_stub_text_end_count, ftrace_ool_stub_inittext_count;
+extern struct ftrace_ool_stub ftrace_ool_stub_text_end[], ftrace_ool_stub_text[],
+			      ftrace_ool_stub_inittext[];
+extern unsigned int ftrace_ool_stub_text_end_count, ftrace_ool_stub_text_count,
+		    ftrace_ool_stub_inittext_count;
 #endif
 void ftrace_free_init_tramp(void);
 unsigned long ftrace_call_adjust(unsigned long addr);
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 1fee074388cc..bee2c54a8c04 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -168,7 +168,7 @@ static int ftrace_get_call_inst(struct dyn_ftrace *rec, unsigned long addr, ppc_
 static int ftrace_init_ool_stub(struct module *mod, struct dyn_ftrace *rec)
 {
 #ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
-	static int ool_stub_text_end_index, ool_stub_inittext_index;
+	static int ool_stub_text_index, ool_stub_text_end_index, ool_stub_inittext_index;
 	int ret = 0, ool_stub_count, *ool_stub_index;
 	ppc_inst_t inst;
 	/*
@@ -191,9 +191,22 @@ static int ftrace_init_ool_stub(struct module *mod, struct dyn_ftrace *rec)
 		ool_stub_index = &ool_stub_inittext_index;
 		ool_stub_count = ftrace_ool_stub_inittext_count;
 	} else if (is_kernel_text(rec->ip)) {
-		ool_stub = ftrace_ool_stub_text_end;
-		ool_stub_index = &ool_stub_text_end_index;
-		ool_stub_count = ftrace_ool_stub_text_end_count;
+		/*
+		 * ftrace records are sorted, so we first use up the stub area within .text
+		 * (ftrace_ool_stub_text) before using the area at the end of .text
+		 * (ftrace_ool_stub_text_end), unless the stub is out of range of the record.
+		 */
+		if (ool_stub_text_index >= ftrace_ool_stub_text_count ||
+		    !is_offset_in_branch_range((long)rec->ip -
+					       (long)&ftrace_ool_stub_text[ool_stub_text_index])) {
+			ool_stub = ftrace_ool_stub_text_end;
+			ool_stub_index = &ool_stub_text_end_index;
+			ool_stub_count = ftrace_ool_stub_text_end_count;
+		} else {
+			ool_stub = ftrace_ool_stub_text;
+			ool_stub_index = &ool_stub_text_index;
+			ool_stub_count = ftrace_ool_stub_text_count;
+		}
 #ifdef CONFIG_MODULES
 	} else if (mod) {
 		ool_stub = mod->arch.ool_stubs;
diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 5b2fc6483dce..a6bf7f841040 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -374,6 +374,14 @@ _GLOBAL(return_to_handler)
 	blr
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
+#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
+SYM_DATA(ftrace_ool_stub_text_count, .long CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE)
+
+SYM_CODE_START(ftrace_ool_stub_text)
+	.space CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE * FTRACE_OOL_STUB_SIZE
+SYM_CODE_END(ftrace_ool_stub_text)
+#endif
+
 .pushsection ".tramp.ftrace.text","aw",@progbits;
 .globl ftrace_tramp_text
 ftrace_tramp_text:
diff --git a/arch/powerpc/tools/Makefile b/arch/powerpc/tools/Makefile
index d2e7ecd5f46f..e1f7afcd9fdf 100644
--- a/arch/powerpc/tools/Makefile
+++ b/arch/powerpc/tools/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 quiet_cmd_gen_ftrace_ool_stubs = GEN     $@
-      cmd_gen_ftrace_ool_stubs = $< "$(CONFIG_64BIT)" "$(OBJDUMP)" vmlinux.o $@
+	cmd_gen_ftrace_ool_stubs = $< "$(CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE)" "$(CONFIG_64BIT)" \
+				   "$(OBJDUMP)" vmlinux.o $@
 
 $(obj)/vmlinux.arch.S: $(src)/ftrace-gen-ool-stubs.sh vmlinux.o FORCE
 	$(call if_changed,gen_ftrace_ool_stubs)
diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
index 96e1ca5803e4..3ea0f23f2501 100755
--- a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
+++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
@@ -4,10 +4,11 @@
 # Error out on error
 set -e
 
-is_64bit="$1"
-objdump="$2"
-vmlinux_o="$3"
-arch_vmlinux_S="$4"
+num_ool_stubs_text_builtin="$1"
+is_64bit="$2"
+objdump="$3"
+vmlinux_o="$4"
+arch_vmlinux_S="$5"
 
 RELOCATION=R_PPC64_ADDR64
 if [ -z "$is_64bit" ]; then
@@ -19,15 +20,21 @@ num_ool_stubs_text=$($objdump -r -j __patchable_function_entries "$vmlinux_o" |
 num_ool_stubs_inittext=$($objdump -r -j __patchable_function_entries "$vmlinux_o" |
 			 grep ".init.text" | grep -c "$RELOCATION")
 
+if [ "$num_ool_stubs_text" -gt "$num_ool_stubs_text_builtin" ]; then
+	num_ool_stubs_text_end=$((num_ool_stubs_text - num_ool_stubs_text_builtin))
+else
+	num_ool_stubs_text_end=0
+fi
+
 cat > "$arch_vmlinux_S" <<EOF
 #include <asm/asm-offsets.h>
 #include <linux/linkage.h>
 
 .pushsection .tramp.ftrace.text,"aw"
-SYM_DATA(ftrace_ool_stub_text_end_count, .long $num_ool_stubs_text)
+SYM_DATA(ftrace_ool_stub_text_end_count, .long $num_ool_stubs_text_end)
 
 SYM_CODE_START(ftrace_ool_stub_text_end)
-	.space $num_ool_stubs_text * FTRACE_OOL_STUB_SIZE
+	.space $num_ool_stubs_text_end * FTRACE_OOL_STUB_SIZE
 SYM_CODE_END(ftrace_ool_stub_text_end)
 .popsection
 
-- 
2.47.0


