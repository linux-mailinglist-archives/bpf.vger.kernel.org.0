Return-Path: <bpf+bounces-71734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC764BFC9D6
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96F634E391E
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA1331A76;
	Wed, 22 Oct 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oxC3ThjI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23435BDA9;
	Wed, 22 Oct 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144276; cv=none; b=uLEvx8WuMupJPu7y6EgY6xMGe9s6JUpNXOsCYeuJIwCH+YPwYjAFEG4a0yvHqsW+T7TXL578Oul3Kdt1FTjyEfa+ydhZPtz4dZ0Oy952I+qqK3nmraZjID5uasqeUiUS7hnTdQ9OnbuYq0LJRUopK5TIEHsRHLM24Zu/TciKv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144276; c=relaxed/simple;
	bh=EttRIFA6Dx23A3ZWfvW/FT2xwFyiiEdA40fn3cqa+Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq2fEr3pHVU7T8ngHQDnAwkTCjNToUuFHWRpCocbEUoOJQhALEZEoZPIonWWqLZ0Gsz/82LH/SZV4DkRmNVzwHU4I27BZBECJeU0fpLAXcPNQitL9jE874Ejj4g0XssIoXQsvfx4fo69RVjtFApMElytqWr34o1nSsw8C4n/5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oxC3ThjI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7oagA013852;
	Wed, 22 Oct 2025 14:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xhX8DUNoBhomPVY5+
	1YgQ4tvspnUYjXPFPmuzkX3zCI=; b=oxC3ThjIeGs6rwgQAlclwwNp1wQY2J1y6
	cKidPU3LDVOUxBy9396OFgl133nuYRAAUC5qmY39Qpk9MhhlWidnrSIk0U0mpaBn
	hZI9rdUziYPJlBHXMHOBJUrzrmuHIr2RTblbuIEK4NK20KTq1b7CPzkHUQ1s1NqL
	L2HVCwoZ+hSXQXEro2HET5SwXjvloi7alvMY/7yEoIYL+7DqFpb5xfE0zxwf6GvT
	UzzQ3mNCKlHsmNY5RKe2O1FsvsTq2FRtVnEfJXGmCynEqodVMi4VhBXR2GVubYji
	UyHtRRx4y8cilkdFrdRFieHCU0q+m7/7JZGYkGKPkRq6c4ou+KszQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vuuy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:43:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MEaAwd028211;
	Wed, 22 Oct 2025 14:43:37 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vuuy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:43:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MC1cJ4011030;
	Wed, 22 Oct 2025 14:43:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx18jv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:43:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MEhWOL6226202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 14:43:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C7F120043;
	Wed, 22 Oct 2025 14:43:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16F892004D;
	Wed, 22 Oct 2025 14:43:32 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 14:43:32 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
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
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v11 09/15] unwind_user: Stop when reaching an outermost frame
Date: Wed, 22 Oct 2025 16:43:20 +0200
Message-ID: <20251022144326.4082059-10-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022144326.4082059-1-jremus@linux.ibm.com>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AGX7kRANlnwklcfxxXI_3EamEqLjBtaY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5n6eDBHsj5GN
 kV7brKhM7II9kF9AVfv+/gecOrQx/3h7n7h/yV69Y2qCMFfT5RtB6nk97l9WSzVktxemwJ9nHP/
 7Z0iFp0z6irrxULT6+AcNBEq9O8G7LwIVuHWUAtWy2dVKQ5rm9hxoVFJ+hTXkNPHgJ0rUmfQ9OZ
 2tQZu5d1UiGg/DaRr1mc8qC8QDCmInH4sY7EiXffdUXfUwNDvtNNut/nT4oXJrFLBZrUuB5npP2
 zLlhuSUWJsdWEVCBEctMzofal5Uj9QDcDc8o5C5L6FooKysRd8KP5+Yw5/o2svCHzaXs90BU/Jq
 U76iEel8xtm1aSJ0cK6snbuNzJlAbkvhVhcLq0bkuGheoBEI5V9pvuGK4gpNPjCLixxPNyz9j/2
 PM30Lrka8Uj2eFxyWvhfix6VEkZT4Q==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f8ed9a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7d_E57ReAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=mDV3o1hIAAAA:8 a=yMhMjlubAAAA:8
 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=7mOBRU54AAAA:8
 a=_1qlYuAciRtwIPuEvDgA:9 a=jhqOcbufqs7Y1TYCrUUU:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=wa9RWnbW_A1YIeRBVszw:22 a=DXsff8QfwkrTrK3sU8N1:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-ORIG-GUID: Ieoa7oZhDiD0PHF60cjlNj87b-vbuB_T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Add an indication for an outermost frame to the unwind user frame
structure and stop unwinding when reaching an outermost frame.

This will be used by unwind user sframe, as SFrame may represent an
undefined return address as indication for an outermost frame.

Cc: Steven Rostedt <rostedt@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Sam James <sam@gentoo.org>
Cc: Kees Cook <kees@kernel.org>
Cc: "Carlos O'Donell" <codonell@redhat.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v11:
    - New patch. (Jens)

 arch/x86/include/asm/unwind_user.h | 3 ++-
 include/linux/unwind_user_types.h  | 1 +
 kernel/unwind/user.c               | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 5e0755ea3086..08684bbeff0c 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -6,6 +6,7 @@
 	.cfa_off	=  2*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= -2*(ws),			\
-	.use_fp		= true,
+	.use_fp		= true,				\
+	.outermost	= false,
 
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index ee0ce855e045..e07fee69d315 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -32,6 +32,7 @@ struct unwind_user_frame {
 	s32 ra_off;
 	s32 fp_off;
 	bool use_fp;
+	bool outermost;
 };
 
 struct unwind_user_state {
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index f6c543cb255b..c8034a447c16 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -33,6 +33,12 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 {
 	unsigned long cfa, fp, ra;
 
+	/* Stop unwinding when reaching an outermost frame. */
+	if (frame->outermost) {
+		state->done = true;
+		return 0;
+	}
+
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
 			return -EINVAL;
-- 
2.48.1


