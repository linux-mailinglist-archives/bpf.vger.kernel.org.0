Return-Path: <bpf+bounces-43501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25A9B5C67
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D0EB21C80
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 07:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D71E1A2B;
	Wed, 30 Oct 2024 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ao1KVDMM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A041E0E08;
	Wed, 30 Oct 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272186; cv=none; b=brYZ0KX/zkdum7rUDYSWN6nxx+n166Y5jhTdzISYUnNP12/n/lNTZMD9eH9IBJSP3hsDXfUtQhJeDtpPkoB5NQKUaVApzQwkhqa8Mm0D7GD5kE7eTfxf3ZR5GvG7tRqVzMp2sGI6aoIZoGFIegTc1GUMWEWaDiOvHhCOoERAJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272186; c=relaxed/simple;
	bh=pIR22lqg8pg9hsT1pgKfaYSCLQAG86rJjvc4Jfs7BCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTB9XL8vl8JyRxH2sdI7SOOp1KT2tbtcNjk3zD3/Ppq2bj+l5Hkv+Gy7n/OyCctM4GtFpIn27thzt3Q8ZjWtjqvO4L0DFPNTetKsvFFSq+TmUG16JrujDT55g0w1kvK0zW2CdTmW3Cor+wcH5Kn9LS/cPVspdhyOZZjTNaW/V6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ao1KVDMM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2d4Ws030078;
	Wed, 30 Oct 2024 07:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ke58AxBSPUQS3/T4M
	vvz9VCq7Eju0gHJsQVTBJZ8QTc=; b=ao1KVDMMdeiq4sO5jLKPzVHda9/tNhykD
	6vawX7spDa8QPpXCE14vLmzUq7MXTewG4zt6CsDSP+qrQriXiPbMQ1hsanmLzsPq
	qxhQITf8BKl7pWnUSjqHFPG+I5lcMPslFw3spsOC9XmDm30ouo6AqcdO25KBQIQ0
	TYqL9vCde/dT+KT7zwxke3kzmA5LR6TzbSjRw73ugofNd4nT3fjUPcBe79KMzK37
	O9wJ4o3MdV0xbsHAjt3B6Eea1cxbstgSDEp38QYXgs+2Z3Kch5Bz99Bda8eZtfro
	FOPGYFFmxeCQpBLTAfdbgKPPz4gThFuF4WJ5hg6rkiLBO8XeX0UOQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h7416-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49U7989L031650;
	Wed, 30 Oct 2024 07:09:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h7413-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2YNQl028216;
	Wed, 30 Oct 2024 07:09:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hb4xy11a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49U793Zb59769330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:09:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B2382004B;
	Wed, 30 Oct 2024 07:09:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A4C320043;
	Wed, 30 Oct 2024 07:09:00 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 07:08:59 +0000 (GMT)
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
Subject: [PATCH v7 02/17] powerpc/kprobes: Use ftrace to determine if a probe is at function entry
Date: Wed, 30 Oct 2024 12:38:35 +0530
Message-ID: <20241030070850.1361304-3-hbathini@linux.ibm.com>
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
X-Proofpoint-GUID: cSN_0BqS5GeqndSjdmeIvZ7sdqE_Awu0
X-Proofpoint-ORIG-GUID: pGq8L8qbR_SzWXHotwfv7uk117Nt34Sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300051

From: Naveen N Rao <naveen@kernel.org>

Rather than hard-coding the offset into a function to be used to
determine if a kprobe is at function entry, use ftrace_location() to
determine the ftrace location within the function and categorize all
instructions till that offset to be function entry.

For functions that cannot be traced, we fall back to using a fixed
offset of 8 (two instructions) to categorize a probe as being at
function entry for 64-bit elfv2, unless we are using pcrel.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/kprobes.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index f8aa91bc3b17..bf382c459e1f 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -105,24 +105,22 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 	return addr;
 }
 
-static bool arch_kprobe_on_func_entry(unsigned long offset)
+static bool arch_kprobe_on_func_entry(unsigned long addr, unsigned long offset)
 {
-#ifdef CONFIG_PPC64_ELF_ABI_V2
-#ifdef CONFIG_KPROBES_ON_FTRACE
-	return offset <= 16;
-#else
-	return offset <= 8;
-#endif
-#else
+	unsigned long ip = ftrace_location(addr);
+
+	if (ip)
+		return offset <= (ip - addr);
+	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && !IS_ENABLED(CONFIG_PPC_KERNEL_PCREL))
+		return offset <= 8;
 	return !offset;
-#endif
 }
 
 /* XXX try and fold the magic of kprobe_lookup_name() in this */
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
 					 bool *on_func_entry)
 {
-	*on_func_entry = arch_kprobe_on_func_entry(offset);
+	*on_func_entry = arch_kprobe_on_func_entry(addr, offset);
 	return (kprobe_opcode_t *)(addr + offset);
 }
 
-- 
2.47.0


