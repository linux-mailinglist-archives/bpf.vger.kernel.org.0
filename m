Return-Path: <bpf+bounces-43500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E79B5C61
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E052B1F20EF1
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 07:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F11B1DD0CE;
	Wed, 30 Oct 2024 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bNSELzfj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA281E0E00;
	Wed, 30 Oct 2024 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272185; cv=none; b=rfOaW0sKjgFKFI/jtWBlzCHLe2GS3iIQ8kpIRflcLawxUXpfnXDqT+d/5VKwZh6siSMFC/ciRNceuBAfQruOlzcA5TAscXip3/e/4DfJnuYuf4mhLrg7yUE1X8og5Ec0E+vcl07zmp1MbPBbbpvXZx+59aA1yOq/NroOR5l08RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272185; c=relaxed/simple;
	bh=+W95hfalgBx+aCZjq4y20IiUOmE+GTOeYOkNUDcxi8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrVVFg6P1n5q8c/UckHiSpHnYyispMjuDtcK6Bx8lIW2iNnbk5KEfeesIDnehJ5/cYTpsMP4N3MK+POPjskZtdSeubhficGmUU2YjSAQVT0cE5jyLeExsHBhCOAiSDbr+3xCAdsBXlwlzc5XjrjLxYjpiMDjqfw1Bd5OWQpOwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bNSELzfj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2d4tG025654;
	Wed, 30 Oct 2024 07:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s0FRCiVrpvEhkqmos
	saMa+/8pdEQ0r3/FwKVmEn10sc=; b=bNSELzfjoop8ROkSfvOdzwpBxVg3ihwXG
	o4UYvy15ZJi0yOLoZGYmUbdkh/VJQ/K+qF5f1Zf+oxD3W26Dv5w4uxcah2+T3wlM
	q+uzc+GeHJGwIZcrDbdFkJ7J9pRFlr3EhTtDCfz01CTxilaNB4u8hcRwgtRqNEP0
	vP8LfvIkck4lvuqssML+DvxpDImfvmZjyWYK8xd5gen4+Oaaf0t13b/r9tWOPOvc
	EGkE3BSY5RNCPqUGYXX3fqzlpLYQutUI+woM8OWqX/tEj+PAfzCqywCfdvTmduCZ
	8YVMewBODNLuEOlYtiujptts+TpAHiH4CQ+sv1wGpYt4siefszk6Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb65h2xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49U79F7D018962;
	Wed, 30 Oct 2024 07:09:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb65h2xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49U6WrvN017410;
	Wed, 30 Oct 2024 07:09:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42harsf3nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49U79BpE17105220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:09:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 601662004B;
	Wed, 30 Oct 2024 07:09:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0B0D20043;
	Wed, 30 Oct 2024 07:09:07 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 07:09:07 +0000 (GMT)
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
Subject: [PATCH v7 04/17] powerpc32/ftrace: Unify 32-bit and 64-bit ftrace entry code
Date: Wed, 30 Oct 2024 12:38:37 +0530
Message-ID: <20241030070850.1361304-5-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030070850.1361304-1-hbathini@linux.ibm.com>
References: <20241030070850.1361304-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xEK9_mj46FhoXGBHGnh-LC3EpLPhFI9g
X-Proofpoint-GUID: X6v5Xhr9a9WzsB0MWhS3BtSSm_qp0PR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300051

From: Naveen N Rao <naveen@kernel.org>

On 32-bit powerpc, gcc generates a three instruction sequence for
function profiling:
	mflr	r0
	stw	r0, 4(r1)
	bl	_mcount

On kernel boot, the call to _mcount() is nop-ed out, to be patched back
in when ftrace is actually enabled. The 'stw' instruction therefore is
not necessary unless ftrace is enabled. Nop it out during ftrace init.

When ftrace is enabled, we want the 'stw' so that stack unwinding works
properly. Perform the same within the ftrace handler, similar to 64-bit
powerpc.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/trace/ftrace.c       | 6 ++++--
 arch/powerpc/kernel/trace/ftrace_entry.S | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 2ef504700e8d..8c3e523e4f96 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -240,8 +240,10 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	} else if (IS_ENABLED(CONFIG_PPC32)) {
 		/* Expected sequence: 'mflr r0', 'stw r0,4(r1)', 'bl _mcount' */
 		ret = ftrace_validate_inst(ip - 8, ppc_inst(PPC_RAW_MFLR(_R0)));
-		if (!ret)
-			ret = ftrace_validate_inst(ip - 4, ppc_inst(PPC_RAW_STW(_R0, _R1, 4)));
+		if (ret)
+			return ret;
+		ret = ftrace_modify_code(ip - 4, ppc_inst(PPC_RAW_STW(_R0, _R1, 4)),
+					 ppc_inst(PPC_RAW_NOP()));
 	} else if (IS_ENABLED(CONFIG_MPROFILE_KERNEL)) {
 		/* Expected sequence: 'mflr r0', ['std r0,16(r1)'], 'bl _mcount' */
 		ret = ftrace_read_inst(ip - 4, &old);
diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 76dbe9fd2c0f..244a1c7bb1e8 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -33,6 +33,8 @@
  * and then arrange for the ftrace function to be called.
  */
 .macro	ftrace_regs_entry allregs
+	/* Save the original return address in A's stack frame */
+	PPC_STL		r0, LRSAVE(r1)
 	/* Create a minimal stack frame for representing B */
 	PPC_STLU	r1, -STACK_FRAME_MIN_SIZE(r1)
 
@@ -44,8 +46,6 @@
 	SAVE_GPRS(3, 10, r1)
 
 #ifdef CONFIG_PPC64
-	/* Save the original return address in A's stack frame */
-	std	r0, LRSAVE+SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE(r1)
 	/* Ok to continue? */
 	lbz	r3, PACA_FTRACE_ENABLED(r13)
 	cmpdi	r3, 0
-- 
2.47.0


