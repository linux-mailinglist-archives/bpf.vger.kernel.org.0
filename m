Return-Path: <bpf+bounces-39959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F4B979900
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 23:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055F3280F96
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE41311A7;
	Sun, 15 Sep 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kMOLSVEB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FB12EBE1;
	Sun, 15 Sep 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433895; cv=none; b=UGT298+2IELLGsNWIz6NG6+5mDD4RYRO4zbniFd932ensn+oqGyK12qKJDBJeB+gvH3G/B3x5YtX4J0KuXHMf6OA5qhnYB9md5ArZXIZ+F5qdoe5sj2uG+1YHc8iy1QffWibdVXBZzcc0OCpz6lBPH1ZldPzFLM21k3tOTEdi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433895; c=relaxed/simple;
	bh=sxJTn0FDMGZrbnhDuA758hf7PmR90F9ikphplWyu4PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcJtqkKwYNwLlr960OJZ2XMGrJ7GLg7UkdqbI2vm5KAVlS8SfRKCl0DjJmQozvZpvlXIie57QKjd+XZ6AULDGj/Qpz8ETHc6Qi8HnLS8otoEq985sFq16Z+cnpNpkaPlA0UEtPfgKLqAkG+qsTdO/0LS88rPtdz+2RwjEIa8WlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kMOLSVEB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48F7sChN006091;
	Sun, 15 Sep 2024 20:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=4vzp2ko+lm4Y1
	C3ac5YEyva9XBE27ToW3glhdMB9tnA=; b=kMOLSVEBAPEvM5mtP2/RGr4UvhDwc
	xFSE8IHcaPZTPl3wCaDLePbGdSAyLkOT8v5PTfiq6kdum+rv9r/ZKY47I3atzVwR
	4XuaKEC2qymtz+QlEf41s3Me119DDNQJckJ3aJd/jQGa9JEMegPs0vm6cX+hlJPY
	euArgNRojKKirUed6Sj07BpOkRL+frx7jZqY6oP8AKteeux3rjJJ42fdHGErKBJw
	AtTTM3loBp2PpLMe0uNjlFwEyikUCIv5v1gvVmkm2JfnEp4SICTQxhizabn1848f
	o9EFp+d6eEoD5b8Iy8FHJwkunhQbIrTYO8ryA66go3OH1N5noG+j0MqGg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uhxdxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48FKvq8L028362;
	Sun, 15 Sep 2024 20:57:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uhxdxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48FKrOuR025033;
	Sun, 15 Sep 2024 20:57:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mkfrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48FKvm3754395278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 20:57:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EA8C20049;
	Sun, 15 Sep 2024 20:57:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8812A20040;
	Sun, 15 Sep 2024 20:57:44 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.68.55])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Sep 2024 20:57:44 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: "Naveen N. Rao" <naveen@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v5 13/17] powerpc64/ftrace: Support .text larger than 32MB with out-of-line stubs
Date: Mon, 16 Sep 2024 02:26:44 +0530
Message-ID: <20240915205648.830121-14-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915205648.830121-1-hbathini@linux.ibm.com>
References: <20240915205648.830121-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7prbGMIuTuZTtK-rpyOA5amn9nEaKQPw
X-Proofpoint-GUID: pJrYxvy1Zou96vUV_Ztis4oL2XfiaExX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_12,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409150159

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

Changes in v5:
* num_ool_stubs_text_end used for setting up ftrace_ool_stub_text_end
  set to zero instead of computing to some random negative value when
  not required.

 arch/powerpc/Kconfig                       | 12 ++++++++++++
 arch/powerpc/include/asm/ftrace.h          |  6 ++++--
 arch/powerpc/kernel/trace/ftrace.c         | 21 +++++++++++++++++----
 arch/powerpc/kernel/trace/ftrace_entry.S   |  8 ++++++++
 arch/powerpc/tools/Makefile                |  2 +-
 arch/powerpc/tools/ftrace-gen-ool-stubs.sh | 16 ++++++++++++----
 6 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index bae96b65f295..a0ce00368bab 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -573,6 +573,18 @@ config PPC_FTRACE_OUT_OF_LINE
 	depends on PPC64
 	select ARCH_WANTS_PRE_LINK_VMLINUX
 
+config PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE
+	int "Number of ftrace out-of-line stubs to reserve within .text"
+	default 32768 if PPC_FTRACE_OUT_OF_LINE
+	default 0
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
index 3a389526498e..9eeb6edf02fe 100644
--- a/arch/powerpc/tools/Makefile
+++ b/arch/powerpc/tools/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 quiet_cmd_gen_ftrace_ool_stubs = GEN     $@
-      cmd_gen_ftrace_ool_stubs = $< vmlinux.o $@
+      cmd_gen_ftrace_ool_stubs = $< $(CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE) vmlinux.o $@
 
 $(obj)/.vmlinux.arch.S: $(src)/ftrace-gen-ool-stubs.sh vmlinux.o FORCE
 	$(call if_changed,gen_ftrace_ool_stubs)
diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
index 8e0a6d4ea202..d6bd834e0868 100755
--- a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
+++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
@@ -8,8 +8,9 @@ is_enabled() {
 	grep -q "^$1=y" include/config/auto.conf
 }
 
-vmlinux_o=${1}
-arch_vmlinux_S=${2}
+vmlinux_o=${2}
+arch_vmlinux_S=${3}
+arch_vmlinux_o=$(dirname ${arch_vmlinux_S})/$(basename ${arch_vmlinux_S} .S).o
 
 RELOCATION=R_PPC64_ADDR64
 if is_enabled CONFIG_PPC32; then
@@ -21,15 +22,22 @@ num_ool_stubs_text=$(${CROSS_COMPILE}objdump -r -j __patchable_function_entries
 num_ool_stubs_inittext=$(${CROSS_COMPILE}objdump -r -j __patchable_function_entries ${vmlinux_o} |
 			 grep ".init.text" | grep "${RELOCATION}" | wc -l)
 
+num_ool_stubs_text_builtin=${1}
+if [ ${num_ool_stubs_text} -gt ${num_ool_stubs_text_builtin} ]; then
+	num_ool_stubs_text_end=$(expr ${num_ool_stubs_text} - ${num_ool_stubs_text_builtin})
+else
+	num_ool_stubs_text_end=0
+fi
+
 cat > ${arch_vmlinux_S} <<EOF
 #include <asm/asm-offsets.h>
 #include <linux/linkage.h>
 
 .pushsection .tramp.ftrace.text,"aw"
-SYM_DATA(ftrace_ool_stub_text_end_count, .long ${num_ool_stubs_text})
+SYM_DATA(ftrace_ool_stub_text_end_count, .long ${num_ool_stubs_text_end})
 
 SYM_CODE_START(ftrace_ool_stub_text_end)
-	.space ${num_ool_stubs_text} * FTRACE_OOL_STUB_SIZE
+	.space ${num_ool_stubs_text_end} * FTRACE_OOL_STUB_SIZE
 SYM_CODE_END(ftrace_ool_stub_text_end)
 .popsection
 
-- 
2.46.0


