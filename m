Return-Path: <bpf+bounces-62946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3080B008F7
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAA61CA2533
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751D22F0042;
	Thu, 10 Jul 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S6cm0X1A"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC82EFDB5;
	Thu, 10 Jul 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165375; cv=none; b=TjhGhhdrZqN5C2Qm3FkNNT6pq89hIrvpFRrn+S0Huy5rIhI09fMiC/BIfhbfg5K8ppTUFi9kh5lMYgd2ginv55zfPpd11uhAKUYi4SB+NMWIxKFzPZqt3y+yLrNrTFSo+IWdcGy81yRv8hGG3rBJYE1Z1kuHxiDIBViP5UGMnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165375; c=relaxed/simple;
	bh=HDpOlHn07MCMCz6ZR8ox5wRqbGV6hjvdNacy386wcRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2Eo7eWfHADqvb9Mjs/s6tgcy3j5n55hh3GXlgHNxHgzZVfF5k4GY1RqSag03AcPv5Vy+GP6XJzppZWbPMC2pxelFxzoy26mznt6MZtQVEuNexZoxNV2ajkbK9Muj1bYvZ9VYtS9kXONkr0j70iRZwPXQ8xEV7n0TiURYdj4szM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S6cm0X1A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9r57e021381;
	Thu, 10 Jul 2025 16:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WH8heYNKI41hEAvvl
	+y/eA+1PA5Xi2h4EcmcEcVNNBk=; b=S6cm0X1A1xlkSX9Sw/09DI4AO1VkyFBGZ
	LognVdNkerM9R7wjnuYMFSDRbEHq/N/letCBjalJtx9WYeQ+SxS8I2KErbuW1V2B
	CBRoSJ7w8gHltOM6R8nQb2rUSTWSVSVkcBvJOuu5vSiWuCsoj38rOCiDnCnqXEPL
	TZXR8duE+VNGSUFI0qiYBoEc1je20tyiO+6IM3LMYCVffcluhudTfVgy5A6N00mq
	PEncxHdQdeqedYhn6putCQYu8iaAi7Ht6yp+xYVobKMkL77mrUeFJbNHDzIgkR+F
	4vdsERtStkILwE4+l7slrNqJAyyhZoM693+ONqBbg1GzLPddnkazw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pusse6aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADFbx4021531;
	Thu, 10 Jul 2025 16:35:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectxrn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZSsD12714316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A696520063;
	Thu, 10 Jul 2025 16:35:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B7442004D;
	Thu, 10 Jul 2025 16:35:28 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:28 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 16/16] WIP: fixup! s390/unwind_user/sframe: Enable HAVE_UNWIND_USER_SFRAME
Date: Thu, 10 Jul 2025 18:35:22 +0200
Message-ID: <20250710163522.3195293-17-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250710163522.3195293-1-jremus@linux.ibm.com>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686febd5 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=91u_FrifZQu3ZdA2h5kA:9
X-Proofpoint-GUID: 0aJBZvD1035smR9ojazV5kefpBfgylH6
X-Proofpoint-ORIG-GUID: 0aJBZvD1035smR9ojazV5kefpBfgylH6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX/XBsHHfW/+nP ZOVtoweC1xqyeGxov+zkxVoXXuotXBggIBdkrhTgduybXumWwEDy4mK1f6WgqySQtWHHHWatxR3 gcwOx/dCN0sFN2ck+51Ci2fRWIIxfBjdMx0Lev0JHU9Dw8AFkvGzu7lz9cCYGvrnyEze5kkOY0/
 wQ6wq+YoOerWfieplJP/LXXcoB+PDxuppnI10zBFd4rqNEB3Hid3ej3ucmldwyo72m3NcTQc05e yzcrL9u2/eTlK5xcgSASgRQZY/AEaZFEJQTz8bUw7BQz/bfEJo2tAOYlXiCjZFSBZB+zthi5yey BfdxqIAm/7/M2up39CrwGYtG288/Ymed9OsmOetjw2y2d0WjXsWfpioIHWy8QyUMtN4+EryV3MR
 lYzJVvjfBQKLnO9TWLmI8nvSYeG4JXYRaUHU4yNgnEjyvXYn02z7jey3IV35b+ACmcpcFmux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=713 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Add s390-specific SFrame format definitions.  Note that SFRAME_ABI_*
(and thus SFRAME_ABI_S390_ENDIAN_BIG) is currently unused.

Include <asm/unwind_user_sframe.h> after "sframe.h" to make those
s390-specific definitions available to architecture-specific unwind
user sframe code, particularly the s390-specific one.

Use the s390-specific definitions in the s390-specific unwind user
sframe code to get rid of all the magic numbers.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Alternatively the s390-specific definitions could also be added to the
    s390-specific unwind user sframe header.  The current implementation
    follows Binutils approach to have all SFrame format definitions in one
    central header file.

 arch/s390/include/asm/unwind_user_sframe.h |  8 ++++----
 kernel/unwind/sframe.c                     |  2 +-
 kernel/unwind/sframe.h                     | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/unwind_user_sframe.h b/arch/s390/include/asm/unwind_user_sframe.h
index 2216e6921fd8..e5139cc2ba5a 100644
--- a/arch/s390/include/asm/unwind_user_sframe.h
+++ b/arch/s390/include/asm/unwind_user_sframe.h
@@ -7,16 +7,16 @@
 
 static inline s32 arch_sframe_cfa_offset_decode(s32 offset)
 {
-	return (offset << 3) + 160;
+	return SFRAME_V2_S390X_CFA_OFFSET_DECODE(offset);
 }
 
 static inline void arch_sframe_set_frame_reginfo(
 	struct unwind_user_reginfo *reginfo,
 	s32 offset)
 {
-	if (offset & 1) {
+	if (SFRAME_V2_S390X_OFFSET_IS_REGNUM(offset)) {
 		reginfo->loc = UNWIND_USER_LOC_REG;
-		reginfo->regnum = offset >> 1;
+		reginfo->regnum = SFRAME_V2_S390X_OFFSET_DECODE_REGNUM(offset);
 	} else if (offset) {
 		reginfo->loc = UNWIND_USER_LOC_STACK;
 		reginfo->frame_off = offset;
@@ -27,7 +27,7 @@ static inline void arch_sframe_set_frame_reginfo(
 
 static inline s32 arch_sframe_sp_val_off(void)
 {
-	return -160;
+	return SFRAME_S390X_SP_VAL_OFFSET;
 }
 
 #define sframe_cfa_offset_decode arch_sframe_cfa_offset_decode
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index e8658401a286..cd82de310c58 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -12,11 +12,11 @@
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
-#include <asm/unwind_user_sframe.h>
 #include <linux/unwind_user_types.h>
 
 #include "sframe.h"
 #include "sframe_debug.h"
+#include <asm/unwind_user_sframe.h>
 
 struct sframe_fre {
 	unsigned int	size;
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
index e9bfccfaf5b4..3e60b6e30b51 100644
--- a/kernel/unwind/sframe.h
+++ b/kernel/unwind/sframe.h
@@ -17,6 +17,7 @@
 #define SFRAME_ABI_AARCH64_ENDIAN_BIG		1
 #define SFRAME_ABI_AARCH64_ENDIAN_LITTLE	2
 #define SFRAME_ABI_AMD64_ENDIAN_LITTLE		3
+#define SFRAME_ABI_S390X_ENDIAN_BIG		4	/* s390 64-bit (s390x) */
 
 #define SFRAME_FDE_TYPE_PCINC			0
 #define SFRAME_FDE_TYPE_PCMASK			1
@@ -68,4 +69,19 @@ struct sframe_fde {
 #define SFRAME_FRE_OFFSET_SIZE(data)		((data >> 5) & 0x3)
 #define SFRAME_FRE_MANGLED_RA_P(data)		((data >> 7) & 0x1)
 
+/* s390 64-bit (s390x) */
+
+#define SFRAME_S390X_SP_VAL_OFFSET			(-160)
+
+#define SFRAME_S390X_CFA_OFFSET_ADJUSTMENT		SFRAME_S390X_SP_VAL_OFFSET
+#define SFRAME_S390X_CFA_OFFSET_ALIGNMENT_FACTOR	8
+#define SFRAME_V2_S390X_CFA_OFFSET_DECODE(offset) \
+  (((offset) * SFRAME_S390X_CFA_OFFSET_ALIGNMENT_FACTOR) \
+   - SFRAME_S390X_CFA_OFFSET_ADJUSTMENT)
+
+#define SFRAME_V2_S390X_OFFSET_IS_REGNUM(offset) \
+  ((offset) & 1)
+#define SFRAME_V2_S390X_OFFSET_DECODE_REGNUM(offset) \
+  ((offset) >> 1)
+
 #endif /* _SFRAME_H */
-- 
2.48.1


