Return-Path: <bpf+bounces-76310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC3BCADE64
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97E633009DBA
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FB83195E0;
	Mon,  8 Dec 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KfImEoqZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4EF3164DE;
	Mon,  8 Dec 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214213; cv=none; b=IP3UBJCGT27zKybONwgLWJqdWzzqBriyFrYvaHbIzeAxhb+j3lGoU/lCDZaAq8Vk0LxP1ADVfYvS8FhaFArPsenASmqJdWRqj6rJwthkKVwzOt7uTxT7oSvJINXRw2T4EG4LKyI4uSyZpgHMbmzThsoE2kw9QAikro9FUTFkFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214213; c=relaxed/simple;
	bh=GY8oDqmIiK4+Ah4DkE346nJvkjoYUSHhp3dw5fWc8AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNWaLjAuNV9gnJ4Zjo6GDpN59zm/WT/lf6/gRiVAhoo5xlmitCmWB3cvGLepRccHVMxJUZ+LV4JWnBOT89s0eJdNen/u9+ZKUUQnmZtf9QwDjo7a2kTvdA3CTavqPpHsUFon8JcyUzXJfff6XvMMp4JmK5GKgAqTAy+4w2lBZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KfImEoqZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8DgxKI004373;
	Mon, 8 Dec 2025 17:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e+6+ERWdo8+23tSAw
	OftYMDiAY88CjmzYDra/V/CXx8=; b=KfImEoqZKZmSLZKF6uPX86U2YRxZLrZMz
	jBX6C16LDzSSGoacNpBsXX5ug2bt7O53lwphZWU91HgalcXizb+88txBu0UE0z5J
	HG8pP9xkF+FvKWHqSHwd9fDQkVsHvVNgDqWtD0IEB82V+og1ac+rGnO9I4dYQKTP
	Hb3tZd/6puVyIgHFzDGPjejn5g4xfKKqPmAF2dikwK2aANii2Wfa3PWQ7pAoFrKE
	suUEDEwuyEwRWeufcJf986veWL5uMLZuy581FT7kRcDcq6JhrB9Ox0b48E0AMFIE
	QQDU9tGBkTCiEZmUxDA6Rlqqn+pd5nkSI0bPpbL7EzDYUnkeNWRfw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc618x5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HGDkF010688;
	Mon, 8 Dec 2025 17:16:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc618x5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8FKDZ2012862;
	Mon, 8 Dec 2025 17:16:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ajpp32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG8oM42729788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33FEA20040;
	Mon,  8 Dec 2025 17:16:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D05C32004B;
	Mon,  8 Dec 2025 17:16:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:07 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v3 16/17] unwind_user/fp: Use arch-specific helper to initialize FP frame
Date: Mon,  8 Dec 2025 18:15:58 +0100
Message-ID: <20251208171559.2029709-17-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208171559.2029709-1-jremus@linux.ibm.com>
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX7dSuPZONQqMd
 Y18giEopKdQ3J9PXwMAuIp9nO4voG7RM9ktQojkfs10VX3g/aqBoRS/rYAOtr5McIjBfFzj9/Cx
 8D5e4H5CUBkt9QeN/kiWh6cyLe/Lr1Izpqf3yQya3Rgm4WpgVNgRZPsqHYOHf9XHqZE/wKphOKu
 dIixr5BGmpPCOwE3/R/Z/TPcaqp198Xhi/LAJKxLpsYAPy9fKwNXzNXMCxj0TKdJKjQ1cAZrG08
 6fNyz0zieQx1WyKb4Gv2NbF6/YHoy5bKLNgnSvXaVLceqgYj4wawE0otbmF7XdKnoKO/ki2VJto
 ZJKlskXxmTi3HXNmzThsXBQMgXTxerc4Fen/OXebVAT79IQCXnE2qZ4feZcbSjFXPW3QJghVAdH
 1UN7BQplOZp+nxlDj/bknB7DcpAtGw==
X-Proofpoint-GUID: UYMmzlhKmyvMb3nnzhPuVkuMOOTimAFx
X-Proofpoint-ORIG-GUID: FSWfkUKz0vMVYkMHbVMTC1PmRuY-Lf1L
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=693707de cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Rlq6_WvGfIKZnD4uTv0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

This enables more sophisticated initialization of the FP frame, for
instance to implement support for unwinding of user space using back
chain on s390 with a subsequent commit.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v3:
    - New patch.  Prerequirement to implement unwind user fp using back
      chain on s390.

 arch/x86/include/asm/unwind_user.h | 20 +++++++++++++++++---
 include/linux/unwind_user.h        | 20 +++++++-------------
 kernel/unwind/user.c               | 16 ++++------------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 2480d86a405e..ca581edecb9d 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -46,11 +46,25 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	.use_fp		= false,			\
 	.outermost	= false,
 
-static inline bool unwind_user_at_function_start(struct pt_regs *regs)
+static inline int unwind_user_fp_get_frame(struct unwind_user_state *state,
+					   struct unwind_user_frame *frame)
 {
-	return is_uprobe_at_func_entry(regs);
+	struct pt_regs *regs = task_pt_regs(current);
+
+	if (state->topmost && is_uprobe_at_func_entry(regs)) {
+		const struct unwind_user_frame fp_entry_frame = {
+			ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
+		};
+		*frame = fp_entry_frame;
+	} else {
+		const struct unwind_user_frame fp_frame = {
+			ARCH_INIT_USER_FP_FRAME(state->ws)
+		};
+		*frame = fp_frame;
+	}
+	return 0;
 }
-#define unwind_user_at_function_start unwind_user_at_function_start
+#define unwind_user_fp_get_frame unwind_user_fp_get_frame
 
 #endif /* CONFIG_HAVE_UNWIND_USER_FP */
 
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 61fd5c05d0f0..4adab1a612a6 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -7,21 +7,15 @@
 
 #ifndef CONFIG_HAVE_UNWIND_USER_FP
 
-#define ARCH_INIT_USER_FP_FRAME(ws)
-
-#endif
-
-#ifndef ARCH_INIT_USER_FP_ENTRY_FRAME
-#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)
-#endif
-
-#ifndef unwind_user_at_function_start
-static inline bool unwind_user_at_function_start(struct pt_regs *regs)
+static inline int unwind_user_fp_get_frame(struct unwind_user_state *state,
+					   struct unwind_user_frame *frame)
 {
-	return false;
+	WARN_ON_ONCE(1);
+	return -EINVAL;
 }
-#define unwind_user_at_function_start unwind_user_at_function_start
-#endif
+#define unwind_user_fp_get_frame unwind_user_fp_get_frame
+
+#endif /* CONFIG_HAVE_UNWIND_USER_FP */
 
 #ifndef unwind_user_get_ra_reg
 static inline int unwind_user_get_ra_reg(unsigned long *val)
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 7d06bdbc7f0d..6877242ceae3 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -111,19 +111,11 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 
 static int unwind_user_next_fp(struct unwind_user_state *state)
 {
-	struct pt_regs *regs = task_pt_regs(current);
-
-	if (state->topmost && unwind_user_at_function_start(regs)) {
-		const struct unwind_user_frame fp_entry_frame = {
-			ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
-		};
-		return unwind_user_next_common(state, &fp_entry_frame);
-	}
+	struct unwind_user_frame frame;
 
-	const struct unwind_user_frame fp_frame = {
-		ARCH_INIT_USER_FP_FRAME(state->ws)
-	};
-	return unwind_user_next_common(state, &fp_frame);
+	if (unwind_user_fp_get_frame(state, &frame))
+		return -ENOENT;
+	return unwind_user_next_common(state, &frame);
 }
 
 static int unwind_user_next_sframe(struct unwind_user_state *state)
-- 
2.51.0


