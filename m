Return-Path: <bpf+bounces-42444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD2E9A44F1
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 19:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59521C232F2
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1238520513E;
	Fri, 18 Oct 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ebgEza5q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF5204F7C;
	Fri, 18 Oct 2024 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273053; cv=none; b=I9xqPmMhw3uBSJuOgPVQPPUYSPYB2/DhBD57zVEsM6MKIOdOQKjifhzy9l1soaE3QzwYjvCoxdk5eB8cDf/xnnV2Yml8l7wrXZKecmghckfIqfXiCbfUY9vGN+/Fjf1/p6jFQKVl30GIwcAlIeGasm+/VEA1JWn+KmDRsCZYkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273053; c=relaxed/simple;
	bh=kmXND9GWUzfaSOnjTYcSawmSbJC47RzbZRXwhzS09gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5SVBORlYqfis3roIASUMKJiGa8UwvJ9yp9EW4HV5Hi1GEz5zwcPzpGzz0MSNiJwxVZ39D/TS8OFO3mm4Tgby5zAs0AwnHL1r9BFzt9IOdzjsKc5vKTcUq9ipi0iO42COktceQ8P9+MaDuiEtC9O0eTCGNUL4qOG5qFPvjrmbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ebgEza5q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IA7pr1025135;
	Fri, 18 Oct 2024 17:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SKma3CRH4og/h26/j
	eEWVdCKsDhHjJllnomQxBVXmRU=; b=ebgEza5q90R0LvO6idenlAbmvCBfa1lA+
	tLuB2rDFQ/MOiTftF/D97gw/mTLNzK6HT6E/IWCdTw1bpf8DMGsB/jwJ/OsHEBdb
	759Y+wO4zxjKO58tH4grKBGJyke6l4WDtTPFK84xmBKW0jnBSl/ymnkgoJ0WJmZC
	CMHNIKL0xhoz2cxIesDHrWn7W/RhUUGmkr8zODpWgZjjmv5r2h6wV/ql6XuiSaGA
	EzKWsqBAt/l/Q3Gr5xTg48Vt71UhG3tohpy6olqhcZIpTgxZmArga/r8I/gJEVD1
	Fs8lbdYwtHGIMMEFPRX0hQQim2ahzbXtDpXNfqMa7ffmwIudc4eUg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbdar7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49IHb533014588;
	Fri, 18 Oct 2024 17:37:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbdar7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IH95il001991;
	Fri, 18 Oct 2024 17:37:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284en5yxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 17:37:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49IHb04w53477698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:37:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E72620043;
	Fri, 18 Oct 2024 17:37:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25ED620040;
	Fri, 18 Oct 2024 17:36:56 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.99.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 17:36:55 +0000 (GMT)
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
Subject: [PATCH v6 05/17] powerpc/module_64: Convert #ifdef to IS_ENABLED()
Date: Fri, 18 Oct 2024 23:06:20 +0530
Message-ID: <20241018173632.277333-6-hbathini@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: keU9RRyVyeIXL02h-2Faem9ZHmyvIwh_
X-Proofpoint-GUID: JviQE_gB3CP-YcSbg09S_45Rg4d7jwWf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180111

From: Naveen N Rao <naveen@kernel.org>

Minor refactor for converting #ifdef to IS_ENABLED().

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/module_64.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index e9bab599d0c2..1db88409bd95 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -241,14 +241,8 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 		}
 	}
 
-#ifdef CONFIG_DYNAMIC_FTRACE
-	/* make the trampoline to the ftrace_caller */
-	relocs++;
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	/* an additional one for ftrace_regs_caller */
-	relocs++;
-#endif
-#endif
+	/* stubs for ftrace_caller and ftrace_regs_caller */
+	relocs += IS_ENABLED(CONFIG_DYNAMIC_FTRACE) + IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS);
 
 	pr_debug("Looks like a total of %lu stubs, max\n", relocs);
 	return relocs * sizeof(struct ppc64_stub_entry);
-- 
2.47.0


