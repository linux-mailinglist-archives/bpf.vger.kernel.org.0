Return-Path: <bpf+bounces-42445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CE59A44F7
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 19:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314BA286335
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E4205AB5;
	Fri, 18 Oct 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nxeY29mF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38153204036;
	Fri, 18 Oct 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273057; cv=none; b=OZNRF1eZCLRKc/xt3u9SQrRTk7qMW2KjLgVlrORBMtDbVI2H3e9OOl1z3vINgjeptct8bgrHnyQpMB47S8on3I1b1+V8XmTJAuEJ5rETYWA9a9rDHc+bh2ofQ2rLa8jf3jw0w64Zcs0qOkwpiiP+2p5CLmX+UmpRTVuQAWjW//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273057; c=relaxed/simple;
	bh=Lf47ZGisG3tlV+pfCUAcp86luQQ7IsobpjlUbKm12sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GawG1Nv/3F1Ta4Or5cf3tmgRhcgnobSUuEf3NEhXkXb/cpdBd2ULdJn2gyZ/yr5saKA/w3qvpfVgIlkfn7K3ZhF+m/yNuP2FdYpZVxpsBCeX+HDa5ptdyfc4CvyEfOuBZMKcj8lPYrdhblzch9br6dBU3Ze8pz00pXe8saeXMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nxeY29mF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IC8WI0026749;
	Fri, 18 Oct 2024 17:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3NxYv02vuxaMO5r29
	ohIPPG4f4pCCqbUWFgSHUSuV0c=; b=nxeY29mF2w0t7Ui3Cp/MrjjvEYiEohcoP
	OZgD5fVTUo8gugoZWBto5Pp2OqDeVxYAkReEqFQKdlR+KqvAM+EBQWX2ZW/TWkey
	nU3MshG7agaTfFhYkW7sNAK+Oh4LgdolLtgPJeayGKk9uA3nUOb51oFZimF2W5sx
	AAToiyu+scFdTZdpOVtBKLWNIxC/kR3T6r+ckTTQT2UFLSccietd7VrTYMdcqtt5
	2nRp0KKyHNw+ofvdpdWIDUHh3KrjkAKUuNi7IYBtXkqnkOi9fWBImMMH1LXlWQmZ
	ZcqKQLdjVIMq+Z4RGB9a1GW1U6sITCCFVSsveG1UYMqs2ZhaeLQ3w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbdar89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49IHau2j014159;
	Fri, 18 Oct 2024 17:37:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbdar83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IFpmkX005951;
	Fri, 18 Oct 2024 17:37:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428651dkbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IHb4UK38928720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:37:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87B9220040;
	Fri, 18 Oct 2024 17:37:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1B892004B;
	Fri, 18 Oct 2024 17:37:00 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.99.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 17:37:00 +0000 (GMT)
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
Subject: [PATCH v6 06/17] powerpc/ftrace: Remove pointer to struct module from dyn_arch_ftrace
Date: Fri, 18 Oct 2024 23:06:21 +0530
Message-ID: <20241018173632.277333-7-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018173632.277333-1-hbathini@linux.ibm.com>
References: <20241018173632.277333-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0p8dl5BKbZGH4PMcd7JrmHi2fynwCo_S
X-Proofpoint-GUID: VZOR1CgpUD2pgfu5YaQ5kKeE1O1KUx7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180111

From: Naveen N Rao <naveen@kernel.org>

Pointer to struct module is only relevant for ftrace records belonging
to kernel modules. Having this field in dyn_arch_ftrace wastes memory
for all ftrace records belonging to the kernel. Remove the same in
favour of looking up the module from the ftrace record address, similar
to other architectures.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/include/asm/ftrace.h        |  1 -
 arch/powerpc/kernel/trace/ftrace.c       | 49 +++++++++--------
 arch/powerpc/kernel/trace/ftrace_64_pg.c | 69 ++++++++++--------------
 3 files changed, 56 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 559560286e6d..278d4548e8f1 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -24,7 +24,6 @@ unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
 struct module;
 struct dyn_ftrace;
 struct dyn_arch_ftrace {
-	struct module *mod;
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 8c3e523e4f96..fe0546fbac8e 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -106,28 +106,43 @@ static unsigned long find_ftrace_tramp(unsigned long ip)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
+static unsigned long ftrace_lookup_module_stub(unsigned long ip, unsigned long addr)
+{
+	struct module *mod = NULL;
+
+	preempt_disable();
+	mod = __module_text_address(ip);
+	preempt_enable();
+
+	if (!mod)
+		pr_err("No module loaded at addr=%lx\n", ip);
+
+	return (addr == (unsigned long)ftrace_caller ? mod->arch.tramp : mod->arch.tramp_regs);
+}
+#else
+static unsigned long ftrace_lookup_module_stub(unsigned long ip, unsigned long addr)
+{
+	return 0;
+}
+#endif
+
 static int ftrace_get_call_inst(struct dyn_ftrace *rec, unsigned long addr, ppc_inst_t *call_inst)
 {
 	unsigned long ip = rec->ip;
 	unsigned long stub;
 
-	if (is_offset_in_branch_range(addr - ip)) {
+	if (is_offset_in_branch_range(addr - ip))
 		/* Within range */
 		stub = addr;
-#ifdef CONFIG_MODULES
-	} else if (rec->arch.mod) {
-		/* Module code would be going to one of the module stubs */
-		stub = (addr == (unsigned long)ftrace_caller ? rec->arch.mod->arch.tramp :
-							       rec->arch.mod->arch.tramp_regs);
-#endif
-	} else if (core_kernel_text(ip)) {
+	else if (core_kernel_text(ip))
 		/* We would be branching to one of our ftrace stubs */
 		stub = find_ftrace_tramp(ip);
-		if (!stub) {
-			pr_err("0x%lx: No ftrace stubs reachable\n", ip);
-			return -EINVAL;
-		}
-	} else {
+	else
+		stub = ftrace_lookup_module_stub(ip, addr);
+
+	if (!stub) {
+		pr_err("0x%lx: No ftrace stubs reachable\n", ip);
 		return -EINVAL;
 	}
 
@@ -262,14 +277,6 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	if (ret)
 		return ret;
 
-	if (!core_kernel_text(ip)) {
-		if (!mod) {
-			pr_err("0x%lx: No module provided for non-kernel address\n", ip);
-			return -EFAULT;
-		}
-		rec->arch.mod = mod;
-	}
-
 	/* Nop-out the ftrace location */
 	new = ppc_inst(PPC_RAW_NOP());
 	addr = MCOUNT_ADDR;
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 12fab1803bcf..8a551dfca3d0 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -116,6 +116,20 @@ static unsigned long find_bl_target(unsigned long ip, ppc_inst_t op)
 }
 
 #ifdef CONFIG_MODULES
+static struct module *ftrace_lookup_module(struct dyn_ftrace *rec)
+{
+	struct module *mod;
+
+	preempt_disable();
+	mod = __module_text_address(rec->ip);
+	preempt_enable();
+
+	if (!mod)
+		pr_err("No module loaded at addr=%lx\n", rec->ip);
+
+	return mod;
+}
+
 static int
 __ftrace_make_nop(struct module *mod,
 		  struct dyn_ftrace *rec, unsigned long addr)
@@ -124,6 +138,12 @@ __ftrace_make_nop(struct module *mod,
 	unsigned long ip = rec->ip;
 	ppc_inst_t op, pop;
 
+	if (!mod) {
+		mod = ftrace_lookup_module(rec);
+		if (!mod)
+			return -EINVAL;
+	}
+
 	/* read where this goes */
 	if (copy_inst_from_kernel_nofault(&op, (void *)ip)) {
 		pr_err("Fetching opcode failed.\n");
@@ -366,27 +386,6 @@ int ftrace_make_nop(struct module *mod,
 		return -EINVAL;
 	}
 
-	/*
-	 * Out of range jumps are called from modules.
-	 * We should either already have a pointer to the module
-	 * or it has been passed in.
-	 */
-	if (!rec->arch.mod) {
-		if (!mod) {
-			pr_err("No module loaded addr=%lx\n", addr);
-			return -EFAULT;
-		}
-		rec->arch.mod = mod;
-	} else if (mod) {
-		if (mod != rec->arch.mod) {
-			pr_err("Record mod %p not equal to passed in mod %p\n",
-			       rec->arch.mod, mod);
-			return -EINVAL;
-		}
-		/* nothing to do if mod == rec->arch.mod */
-	} else
-		mod = rec->arch.mod;
-
 	return __ftrace_make_nop(mod, rec, addr);
 }
 
@@ -411,7 +410,10 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	ppc_inst_t op[2];
 	void *ip = (void *)rec->ip;
 	unsigned long entry, ptr, tramp;
-	struct module *mod = rec->arch.mod;
+	struct module *mod = ftrace_lookup_module(rec);
+
+	if (!mod)
+		return -EINVAL;
 
 	/* read where this goes */
 	if (copy_inst_from_kernel_nofault(op, ip))
@@ -533,16 +535,6 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		return -EINVAL;
 	}
 
-	/*
-	 * Out of range jumps are called from modules.
-	 * Being that we are converting from nop, it had better
-	 * already have a module defined.
-	 */
-	if (!rec->arch.mod) {
-		pr_err("No module loaded\n");
-		return -EINVAL;
-	}
-
 	return __ftrace_make_call(rec, addr);
 }
 
@@ -555,7 +547,10 @@ __ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	ppc_inst_t op;
 	unsigned long ip = rec->ip;
 	unsigned long entry, ptr, tramp;
-	struct module *mod = rec->arch.mod;
+	struct module *mod = ftrace_lookup_module(rec);
+
+	if (!mod)
+		return -EINVAL;
 
 	/* If we never set up ftrace trampolines, then bail */
 	if (!mod->arch.tramp || !mod->arch.tramp_regs) {
@@ -668,14 +663,6 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		return -EINVAL;
 	}
 
-	/*
-	 * Out of range jumps are called from modules.
-	 */
-	if (!rec->arch.mod) {
-		pr_err("No module loaded\n");
-		return -EINVAL;
-	}
-
 	return __ftrace_modify_call(rec, old_addr, addr);
 }
 #endif
-- 
2.47.0


