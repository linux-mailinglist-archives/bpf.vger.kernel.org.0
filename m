Return-Path: <bpf+bounces-76308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CBECADE70
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24B37307A215
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE873195F0;
	Mon,  8 Dec 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jK64uG+r"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024662E541E;
	Mon,  8 Dec 2025 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214212; cv=none; b=JWa3Fbs+PC0DA+uJ42vZs4+e7SAdlKp4+OGPAW9AZqKqpibF4q7gCGMapBANo/r7cHEcCBzJgNMsNJ2yJyfCPXt4UF1WCQEqzoIQzcPrH1f/E3dng+agHqbyvXf8yRzBayfYD9cqITrEVAeLIvu2WpmGlla+7h8zLy6GG2RETDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214212; c=relaxed/simple;
	bh=pskiul7wuQhnws55cHzQbPHcnioIsPs1Z5w3rGSBLy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAPW9+L/dluIeRgwjB1iqxhEJEqJYyg62wjtkbh+MhHETNLVHPFP2bdJhTsn34UNZuS84BgnZN5rbVmbLYFDuGWjsKhrm/PdReBxE8N747X6aHQSz6o66CjcWaAiF3G0cvakOOLYG8QIc0Ic2ZAbaC5x0iBKsDUThSp6BY9Ji58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jK64uG+r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8ChWP1025102;
	Mon, 8 Dec 2025 17:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Z5/UfwjvWZX1WG6/r
	xkMXyCmweuEMkm3uOtgOELVIDg=; b=jK64uG+rLWUz6li9S0Eurv67nOhiEM1WZ
	GGc5lB2C+wQqfknqm6jIimnv8p2yA7lVjosFpjtVISCYP3jzxycsdkNuHekWsKou
	O+xJm/4rTDqmkRpcozJrMsbjh2UPrNLdI5MH+sBt7o9zBPFVGeBJkUQVfbIxfgVD
	phTLtYdml8i5+QMtUgUy/P9PATFsxLEWKmxjacrEXJJcg5oCL1INa4SN6HB8QXbE
	GFRJYXXFz54pFu4b+9KVtQqSgP9gwwYiDuKb2T/sK33tm3mJjqym0B58o/oxZugk
	DeYGpSMkzaaX4yMDV+VDKyV8SNWKPKqqjsOtA6mt/iKWMs4CffMoA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc538dnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:13 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HGCkp026386;
	Mon, 8 Dec 2025 17:16:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc538dn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8Ek57Q028102;
	Mon, 8 Dec 2025 17:16:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6xpw94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG64F44827096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6FC420040;
	Mon,  8 Dec 2025 17:16:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52D142004D;
	Mon,  8 Dec 2025 17:16:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:06 +0000 (GMT)
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
Subject: [RFC PATCH v3 12/17] unwind_user/sframe: Enable archs with encoded SFrame CFA offsets
Date: Mon,  8 Dec 2025 18:15:54 +0100
Message-ID: <20251208171559.2029709-13-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX4ulFtPIMsMnd
 n0lN4X0iPrCkl1VcExJoIuYN/iqAhLqppOGqjT2VTN/F69hw2zPETUe6xVyDH1zjgnGtXt573GL
 LnZKuWhtrFo3H1ajudeWA5K1FkPHTxDnhxCCp+nWbEpRx6HvbQwImH/40OH6Y83N6eID4O6IAdA
 nX50F2ig2rRs3NnkjgVT20y/T3zH4Jh+1OPtQAVOfFIb13F1uQTxjmXAEwGn+XXkccN3pksdKpz
 krvTH7qwLMftGKm9TL8lqTyZvFmWfUvFL5qilUJ1UtWqqa3sPpPVIaNRrLfZFu2cODs8V4g+03c
 nX03yVBM2rmrRMieje/eV3WWb+u2MVmcmGfSQCSrwApsdWSKTICYbDVzwzhiXZPa/cgf2GMl9yf
 fypmX9tHVwCMrOgSYcns+C/EnfSCzw==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693707dd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Og4hOgGxDI197znzLmcA:9
X-Proofpoint-ORIG-GUID: j1cFiGjG-JjgXe0GVQaeUbPpxwj2kWTS
X-Proofpoint-GUID: 4i3zmLYnvV2DU_7tgMgCWL4naFKjb--l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Enable architectures, such as s390, which store SFrame CFA offset values
encoded, to e.g. make (better) use of unsigned 8-bit SFrame offsets.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Rename generic_sframe_cfa_offset_decode() to
      sframe_cfa_offset_decode(). (Josh)

 include/asm-generic/unwind_user_sframe.h | 8 ++++++++
 kernel/unwind/sframe.c                   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/include/asm-generic/unwind_user_sframe.h b/include/asm-generic/unwind_user_sframe.h
index fd71d6b1916b..ec68a77551f0 100644
--- a/include/asm-generic/unwind_user_sframe.h
+++ b/include/asm-generic/unwind_user_sframe.h
@@ -10,6 +10,14 @@
 #define SFRAME_SP_OFFSET 0
 #endif
 
+#ifndef sframe_cfa_offset_decode
+static inline s32 sframe_cfa_offset_decode(s32 offset)
+{
+	return offset;
+}
+#define sframe_cfa_offset_decode sframe_cfa_offset_decode
+#endif
+
 #ifndef sframe_init_reginfo
 static inline void
 sframe_init_reginfo(struct unwind_user_reginfo *reginfo, s32 offset)
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 45cd7380ac38..92f770fc21f6 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -226,6 +226,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 
 	UNSAFE_GET_USER_INC(cfa_off, cur, offset_size, Efault);
 	offset_count--;
+	cfa_off = sframe_cfa_offset_decode(cfa_off);
 
 	ra_off = sec->ra_off;
 	if (!ra_off && offset_count) {
-- 
2.51.0


