Return-Path: <bpf+bounces-39946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F25779798CC
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 22:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECBCCB21D4F
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 20:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D906F30E;
	Sun, 15 Sep 2024 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bmVAqrCu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543545023;
	Sun, 15 Sep 2024 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433852; cv=none; b=kG4ImfIGD8/T1zpzJn/aY08HAVxphTb4/vQiEDfbltsN82vU5YZTj/83O6OOpooST0FlWsmk8cIkL/f0eeW0EufskVQeoxwS3LEPw4GiMATqTpLlFoeVd++NfcNTeLmim/bwK5yylr0iXNxTfebBKzlrylFKMk1DPOqp/KzekmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433852; c=relaxed/simple;
	bh=zA/QsWa6q7LJTtE5ublcb3HICHudBVDInko7cvOFggU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEb0WhrZMzVXdWhQYninvrl8G/wrzQRlnTJzDo8rNaRN7KUFwy1+jQQw91FubOOxUXlmxc3XMHLyC1iuPE+FPpSjbSVQedZfEzRXyAe8CYKiTuwj+tNADZA+/SFgy2aCAxqyQLylhZ/SDESG7+7fbNyHHbEbFQjX6K8iyeZ+RKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bmVAqrCu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FKmRuF026980;
	Sun, 15 Sep 2024 20:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=zQA7iLTfCFqW2
	Uv7PmpE+IQDhTe/2DO2+wb/qAwSldk=; b=bmVAqrCungPA2O+pwXvERYAqffgdS
	7uz1oR3/7y7a0aIxyUJAOHvuQ4AlNmei3FEhdFlPLOv2QmHmTGa2qngYDHPn5ga3
	vIGje88C9N+Cxm6V+TarHdXC1jDKAIn54pbdUt69DuC0QUBqmWbYl2zzfFevw9+f
	i0Uj4AFYFaEcCu6V8MJ8ZEfmAy/0CCxOccISrzAhtwls3hTlAx29XgByg1d925AK
	vdkq8lYgt2eq4+79seEYf/cIy2DBU1e9PSviB5YTEXtcs9fY9e/eGMwYQDNNzq2D
	1L4OQ18nzbX/uS9gy3gByDc01N50uYEQaFNuJgWBD4AMJ0n1cCYxQiRFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41a682u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:06 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48FKv616010815;
	Sun, 15 Sep 2024 20:57:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41a682r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48FI3QWW001960;
	Sun, 15 Sep 2024 20:57:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nmtubyc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 20:57:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48FKv1BN54657404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 20:57:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D660020049;
	Sun, 15 Sep 2024 20:57:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F061520040;
	Sun, 15 Sep 2024 20:56:57 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.68.55])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Sep 2024 20:56:57 +0000 (GMT)
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
Subject: [PATCH v5 02/17] powerpc/kprobes: Use ftrace to determine if a probe is at function entry
Date: Mon, 16 Sep 2024 02:26:33 +0530
Message-ID: <20240915205648.830121-3-hbathini@linux.ibm.com>
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
X-Proofpoint-GUID: eyE_Tdvn-PAycfH2ToAXay_fjHRPGcBM
X-Proofpoint-ORIG-GUID: EnC10AeeZviH-DJ3W2DqeDRShj48SZLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_12,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409150159

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
2.46.0


