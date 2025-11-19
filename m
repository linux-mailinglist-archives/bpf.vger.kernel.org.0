Return-Path: <bpf+bounces-75073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89569C6F055
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 14:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8DCB4F2727
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3D435A92F;
	Wed, 19 Nov 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fUOeqjf/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5335FF73;
	Wed, 19 Nov 2025 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558699; cv=none; b=d8CDaiGHaLvSUjZglUKEQkgEjCVu3D8milSeMo/mCiq997F1Mlrj0LoEw9bDO8lOEskvHVMkr3qiZpUpLWMt4YXIhury5HjGwD3bKECX0r0pkPYTf2Aqcx0X+B7avMqbX6uqpsoxxGvzUTaXzUNUeysPeMajrVgdVcnCt4W5D8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558699; c=relaxed/simple;
	bh=nBrq+RdgNfMc1ur3lIbsaNPcuu3pASuyi/IdKr8/EoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEb3f58eUoeazMK9ZkNJf6fDhipJZaRsivX9lIU9kzaDtoAtIIzGItDW5laSDnh11FZqmBzargfQLKN0PzdOU6z97GNcsfG621taOMBd5NHrFFS/DKoZ/zxJTA+kZxd3B4CBwE1k+LNnG6pYpiBCdrgp58Hj2Vx/lxxrdjWzrvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fUOeqjf/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ6Zdrm020334;
	Wed, 19 Nov 2025 13:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ICCfn5d8Ymkg1VuzL
	DcLXzjBqW3Luy6UcZfak1nf4ac=; b=fUOeqjf/5PIVsyQaf/WVJ2WrbNv/gq/qK
	h24dWMohX0E7qR+r91QrZ0fRmF4ye2PAF18aUs17DP/KZGiTVeJESLhfzX5eiaD6
	NhBzo1vKCLLHj24y5qsRTgvVIl0Gnw6Lncg/JT62zm1HDn/b+cETIfAuDA+kxxqY
	tjdys9cDqhbRO8uLkJslG2VHT/dGqeJvfbVBb+2G+V3PVx2rTZ7Y+VBo3GCxW7qG
	pn0U1sASaOdjMMaZm1suO9R9KBwKIHOx+xGX2nwlV6337YY+0aZ5agYS4l387qeq
	jwoFRMlOfGAMq/gX6F6+guBRK9sOgYwJqVCeyGk7QCncEJ48attRw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw8mxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:36 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJDHjrV014737;
	Wed, 19 Nov 2025 13:23:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw8mxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJCYSr3007031;
	Wed, 19 Nov 2025 13:23:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af62jgkcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 13:23:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJDNUeW44171684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 13:23:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8D9420040;
	Wed, 19 Nov 2025 13:23:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B6C820043;
	Wed, 19 Nov 2025 13:23:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 13:23:30 +0000 (GMT)
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
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v12 08/13] unwind_user/sframe: Add support for outermost frame indication
Date: Wed, 19 Nov 2025 14:23:18 +0100
Message-ID: <20251119132323.1281768-9-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251119132323.1281768-1-jremus@linux.ibm.com>
References: <20251119132323.1281768-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691dc4d8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7d_E57ReAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=mDV3o1hIAAAA:8 a=yMhMjlubAAAA:8
 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=7mOBRU54AAAA:8
 a=mFg4y33aAicYmUfzDuoA:9 a=jhqOcbufqs7Y1TYCrUUU:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=wa9RWnbW_A1YIeRBVszw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0sYAbp2epTJF
 KwK0o6nV/t/DascHTDAw7LjrSVRelVjU3PChgqNTnUIqNBrR65oSm2XirXhGaq6SmWYXiF9l1o1
 BsQhZw9XMFA3APgLGsAzpWdBL5le73BMdkqHwRiBZKgzAka4TyoQ/V6rFSBgo/dSBXgg9LHtznx
 NdSbabmEonNwBeP4+PV83lwjZMVwR3jfTZTot0Q0bfvhGMA/Z5R0bX++6shrDi2fEkjT1foBBry
 b+KgQFanPYjh8tQz0YZsoGAsl3XtdIOuJVvRNk5bDVDcwgny0eibC0knYxhDsdUTo5WHxOJwFNT
 /PwBeGNB/s/bKHBUxF9TtHWloEtkba+Ln2E9Lu+Peanpoy1GCtSZ3uKnat4AHyISNzxApfJNd6v
 w4n5s2CWsuTbBxxsa84qbBd6dq6cDQ==
X-Proofpoint-GUID: Lc5hNVLHNPbVtLhcgANqHWlJnau4aR0p
X-Proofpoint-ORIG-GUID: w_ZwY8KvewR66gHHIbtRNLPrA3VLgrnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

SFrame may represent an undefined return address (RA) as SFrame FRE
without any offsets as indication for an outermost frame.

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
    - New patch.

 kernel/unwind/sframe.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index d4ef825b1cbc..1e877c3e5417 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -33,6 +33,7 @@ struct sframe_fre_internal {
 	s32		ra_off;
 	s32		fp_off;
 	u8		info;
+	bool		ra_undefined;
 };
 
 DEFINE_STATIC_SRCU(sframe_srcu);
@@ -187,6 +188,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	unsigned char offset_count, offset_size;
 	s32 cfa_off, ra_off, fp_off;
 	unsigned long cur = fre_addr;
+	bool ra_undefined = false;
 	unsigned char addr_size;
 	u32 ip_off;
 	u8 info;
@@ -205,7 +207,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	UNSAFE_GET_USER_INC(info, cur, 1, Efault);
 	offset_count = SFRAME_FRE_OFFSET_COUNT(info);
 	offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(info));
-	if (!offset_count || !offset_size)
+	if (!offset_size)
 		return -EFAULT;
 
 	if (cur + (offset_count * offset_size) > sec->fres_end)
@@ -213,6 +215,14 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 
 	fre->size = addr_size + 1 + (offset_count * offset_size);
 
+	if (!offset_count) {
+		cfa_off		= 0;
+		ra_off		= 0;
+		fp_off		= 0;
+		ra_undefined	= true;
+		goto done;
+	}
+
 	UNSAFE_GET_USER_INC(cfa_off, cur, offset_size, Efault);
 	offset_count--;
 
@@ -233,11 +243,13 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	if (offset_count)
 		return -EFAULT;
 
+done:
 	fre->ip_off		= ip_off;
 	fre->cfa_off		= cfa_off;
 	fre->ra_off		= ra_off;
 	fre->fp_off		= fp_off;
 	fre->info		= info;
+	fre->ra_undefined	= ra_undefined;
 
 	return 0;
 
@@ -298,6 +310,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	frame->ra_off  = fre->ra_off;
 	frame->fp_off  = fre->fp_off;
 	frame->use_fp  = SFRAME_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
+	frame->outermost = fre->ra_undefined;
 
 	return 0;
 }
-- 
2.48.1


