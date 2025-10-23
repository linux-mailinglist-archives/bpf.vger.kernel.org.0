Return-Path: <bpf+bounces-71950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E53CC02519
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487183A3B01
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A581927A10F;
	Thu, 23 Oct 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WoCuBe3c"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C80257AC2;
	Thu, 23 Oct 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235618; cv=none; b=ayhJf59+eJhvJYMxBxDNrglEsgRo4fyp8pA5DnX111O1fXOEfh2AFNUDsy6xNqnrFckgj0k4vbCDNcjyD+Tls8d9oU0V1PDByG5rYpHG/gR7PbKr+3YMpFxDCz/P0D060CEyjqOSORikWkxwDJrGpQSTcSrPFxSSGx23HKqqD78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235618; c=relaxed/simple;
	bh=aqzqxxofGyhxlHGNe9LcalvEY+qu8wDWjxshr6DpaZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKi+a3b+8gIDsBhUDMpwUdc7uE3+B9djQ/FBGXntWAq6btzWQDz8G7NEc2x7yAQlqW9NRx/hZKGMNIQAISediHL2JYlwniYJQwz2MSUBA4wquwaLCBlccttWX0D+GVrigOuj3/+HF6m3xDv6cd/9A8pZS1a8DuGtzcE/MMuz090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WoCuBe3c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N8ag5n019834;
	Thu, 23 Oct 2025 16:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=la21jHGyplFfY/WqI
	0NwB81QN3IoQrvAGwqFdZz19w8=; b=WoCuBe3cdpv0Qp/Cy8XFOGFDzkt0Ykuu3
	OZAzckUuuLSXH55hSI4ITdUli115G20GWbopyDB6DB+Zyodyx8D4aXrnMStNwf/8
	aSdVJn+/LZmA3VxcpdhdqeOHQ9RZBwWkMe8v5KFxOlTQuFAzed3B+t98WBBs17v4
	UkIOO83VkJ9i7b/bsebptCI1AysbQHJd0mEcBbWVRSzlHdO/qptf+p+KI5tKIHju
	US10jWpxJ05AyvBpSuuCPkMATSISNnBmunkw2WR+FV0OMBxq8iN4AAU+hEybUaLH
	Ax7j9iy+5faC221/iWcCt60nuZYsVCTrqf/38lxMuZxEHW3lHIDtQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32737m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 16:05:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NFquOD015411;
	Thu, 23 Oct 2025 16:05:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32737kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 16:05:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEZr49011075;
	Thu, 23 Oct 2025 16:05:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1ebh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 16:05:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NG5nBC41943430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 16:05:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA21C2004B;
	Thu, 23 Oct 2025 16:05:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 650F520043;
	Thu, 23 Oct 2025 16:05:48 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 16:05:48 +0000 (GMT)
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
Subject: [RFC PATCH 1/2] fixup! unwind_user/sframe: Add support for reading .sframe contents
Date: Thu, 23 Oct 2025 18:05:44 +0200
Message-ID: <20251023160545.549532-1-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa5263 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=-WfIxybQAAAA:8
 a=X3WeMxAik4tzwCrV5JEA:9 a=KbVuYVxSu7xg536452LQ:22 a=DXsff8QfwkrTrK3sU8N1:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=p-dnK0njbqwfn1k4-x12:22 a=7aar8cbMflRChVwg8ngv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1kKTN45NkES8
 O7kLYBREj69VgRgaSEQYHdwjj+Jj2/EzbR3pKk+u6gXqxZJVO/BP91uvQeTMR4GCD+n8V5A5zOP
 Fovn+aZWpS6YQvUB3p57rWoGV1DQIsAkEworIw8+9UfKei7W0N2Jyw/kxaYUsXsk1YBK5VXxb9P
 LOcius+HLl3TvCRHrQQduRJ9n6Mo5gxKJd4yRTXXMaScibLf0ZoHA6YCuuD8mQm0l7wZgXRYG3F
 DBy/CmgR68z+gM3ZrKladsBtiP/G5ilNO0iBpPUNI2xAFOdc9kwNDkYaMZIDiy9aoB9YDk8vX0Z
 mhaQNk5zrbeTmJKh4axANfMGx/YSgYqYI9DjQ9dWQx7jvpyyB66KwKLo5BOXUWkBOEKI0g65vDw
 lyEXlZKBsNM1NwTAuZIBk5jOxU9wsg==
X-Proofpoint-GUID: 9Msq37G1ETcHHt-9gnjmOS_imd65E8Mg
X-Proofpoint-ORIG-GUID: LQ1J1-wRJ1EQj61I8t4Ke7MvJqOSujkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

This RFC fixup is POC to demonstrate how the SFrame reading code
could benefit from introducing an internal FDE representation (struct
sframe_fde_internal) similar to the used internal FRE representation
(struct sframe_fre).  The goal is to eliminate the passing through of
fde_start_base in many places as well as the various computations of the
effective function start address (= *fde_start_base + fde->start_addr)
throughout this module.  The internal FDE representation simply conveys
the effective function start address via the "unsigned long
func_start_addr" field.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 kernel/unwind/sframe.c | 52 ++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 3d7ac4eaa8b7..f88fc2c92c58 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -17,6 +17,15 @@
 #include "sframe.h"
 #include "sframe_debug.h"
 
+struct sframe_fde_internal {
+	unsigned long	func_start_addr;
+	u32		func_size;
+	u32		fres_off;
+	u32		fres_num;
+	u8		info;
+	u8		rep_size;
+};
+
 struct sframe_fre {
 	unsigned int	size;
 	u32		ip_off;
@@ -45,20 +54,26 @@ static __always_inline unsigned char offset_size_enum_to_size(unsigned char off_
 
 static __always_inline int __read_fde(struct sframe_section *sec,
 				      unsigned int fde_num,
-				      struct sframe_fde *fde,
-				      unsigned long *fde_start_base)
+				      struct sframe_fde_internal *fde)
 {
-	unsigned long fde_addr, ip;
+	unsigned long fde_addr, func_addr;
+	struct sframe_fde _fde;
 
 	fde_addr = sec->fdes_start + (fde_num * sizeof(struct sframe_fde));
-	unsafe_copy_from_user(fde, (void __user *)fde_addr,
+	unsafe_copy_from_user(&_fde, (void __user *)fde_addr,
 			      sizeof(struct sframe_fde), Efault);
 
-	ip = fde_addr + fde->start_addr;
-	if (ip < sec->text_start || ip > sec->text_end)
+	func_addr = fde_addr + _fde.start_addr;
+	if (func_addr < sec->text_start || func_addr > sec->text_end)
 		return -EINVAL;
 
-	*fde_start_base = fde_addr;
+	fde->func_start_addr	= func_addr;
+	fde->func_size		= _fde.func_size;
+	fde->fres_off		= _fde.fres_off;
+	fde->fres_num		= _fde.fres_num;
+	fde->info		= _fde.info;
+	fde->rep_size		= _fde.rep_size;
+
 	return 0;
 
 Efault:
@@ -67,8 +82,7 @@ static __always_inline int __read_fde(struct sframe_section *sec,
 
 static __always_inline int __find_fde(struct sframe_section *sec,
 				      unsigned long ip,
-				      struct sframe_fde *fde,
-				      unsigned long *fde_start_base)
+				      struct sframe_fde_internal *fde)
 {
 	unsigned long func_addr_low = 0, func_addr_high = ULONG_MAX;
 	struct sframe_fde __user *first, *low, *high, *found = NULL;
@@ -109,13 +123,13 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 	if (!found)
 		return -EINVAL;
 
-	ret = __read_fde(sec, found - first, fde, fde_start_base);
+	ret = __read_fde(sec, found - first, fde);
 	if (ret)
 		return ret;
 
 	/* make sure it's not in a gap */
-	if (ip < *fde_start_base + fde->start_addr ||
-	    ip >= *fde_start_base + fde->start_addr + fde->func_size)
+	if (ip < fde->func_start_addr ||
+	    ip >= fde->func_start_addr + fde->func_size)
 		return -EINVAL;
 
 	return 0;
@@ -165,7 +179,7 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 		 s32:	UNSAFE_GET_USER_SIGNED_INC(to, from, size, label))
 
 static __always_inline int __read_fre(struct sframe_section *sec,
-				      struct sframe_fde *fde,
+				      struct sframe_fde_internal *fde,
 				      unsigned long fre_addr,
 				      struct sframe_fre *fre)
 {
@@ -244,8 +258,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 }
 
 static __always_inline int __find_fre(struct sframe_section *sec,
-				      struct sframe_fde *fde,
-				      unsigned long fde_start_base,
+				      struct sframe_fde_internal *fde,
 				      unsigned long ip,
 				      struct unwind_user_frame *frame)
 {
@@ -257,7 +270,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	unsigned int i;
 	u32 ip_off;
 
-	ip_off = ip - (fde_start_base + fde->start_addr);
+	ip_off = ip - fde->func_start_addr;
 
 	if (fde_type == SFRAME_FDE_TYPE_PCMASK)
 		ip_off %= fde->rep_size;
@@ -306,8 +319,7 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 {
 	struct mm_struct *mm = current->mm;
 	struct sframe_section *sec;
-	struct sframe_fde fde;
-	unsigned long fde_start_base;
+	struct sframe_fde_internal fde;
 	int ret;
 
 	if (!mm)
@@ -323,11 +335,11 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 				    sec->sframe_end - sec->sframe_start))
 		return -EFAULT;
 
-	ret = __find_fde(sec, ip, &fde, &fde_start_base);
+	ret = __find_fde(sec, ip, &fde);
 	if (ret)
 		goto end;
 
-	ret = __find_fre(sec, &fde, fde_start_base, ip, frame);
+	ret = __find_fre(sec, &fde, ip, frame);
 end:
 	user_read_access_end();
 
-- 
2.48.1


