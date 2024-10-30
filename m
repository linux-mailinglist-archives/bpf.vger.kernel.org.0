Return-Path: <bpf+bounces-43504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A89B5C75
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB8A284308
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 07:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE601E25E3;
	Wed, 30 Oct 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UT499LAc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF31E1324;
	Wed, 30 Oct 2024 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272188; cv=none; b=PjpKF0jPNk79PMnDgwc+sXP8uSJFH21QMv/W7yBMPblv6JbW5n3CCc0cwGiJPFtxP7qWG8r5ktT/Ns+4TIHWfRTRz2mvkWayxYCjxn42ar7g3kVWcxe4uMpa0UVDnYoAnuFWqs+OFJS4FvJMNqLoosZ821t6yGbIcOvxcAZGKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272188; c=relaxed/simple;
	bh=kmXND9GWUzfaSOnjTYcSawmSbJC47RzbZRXwhzS09gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnsG9LCxxDiigPz6jJdVEvTI1M9YYT9Srmk1FXkMtFp3bHVAup6pE58j4HwY6/CEZykyZv/hcA0MWygkkIrrcfmUt1fh9Oyv0yvHU404h5LVAPacvAe3HOWXb7O+j4Wiofu1+uWHxvEl24/0xc9i4HxLCVnCUdDQAXL/BRXuTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UT499LAc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2d2Ra029999;
	Wed, 30 Oct 2024 07:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SKma3CRH4og/h26/j
	eEWVdCKsDhHjJllnomQxBVXmRU=; b=UT499LAc7JaUXUsHw+5EaAayo6QWLPkNu
	qc88X9CiFyuL6oPZfU9Ly8DopNIZBM97gKNFxdMZvxcuoQPJaNUujJXsfOGPSolE
	LJzLn9wHFl3Qtc034hyMIPHomF47ia/PU8ox3CAimJY4IAu8q8NxfCh5S4tAMQZZ
	wjGegCvdg1olNnrIi8c4iySvqUe2yOQFKwulG883RNSVu+7u521GlfmEhaO/sjC2
	uc5ZmEBnYelhEmXFfnFnNgWk8ik7UcvNLJPEaGXUGqj8I9eVh+YHS5j/Ge4d8elR
	wVv4v/fooOHu3xIWaosWxiRJmkvOLsK3oMa0Jc3XFEdMLwJJ2yJpA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h7420-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49U767Tv026143;
	Wed, 30 Oct 2024 07:09:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h741v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49U6Fq7Y017313;
	Wed, 30 Oct 2024 07:09:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42harsf3np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49U79Fjf50921754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:09:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76C152004B;
	Wed, 30 Oct 2024 07:09:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C24FD20043;
	Wed, 30 Oct 2024 07:09:11 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 07:09:11 +0000 (GMT)
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
Subject: [PATCH v7 05/17] powerpc/module_64: Convert #ifdef to IS_ENABLED()
Date: Wed, 30 Oct 2024 12:38:38 +0530
Message-ID: <20241030070850.1361304-6-hbathini@linux.ibm.com>
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
X-Proofpoint-GUID: XhCjbUiaYspDCXDhxvwn5Zzh-6cd6vlP
X-Proofpoint-ORIG-GUID: UaQWORdicmHI1L85O4dkv8fKmEp0mL7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300051

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


