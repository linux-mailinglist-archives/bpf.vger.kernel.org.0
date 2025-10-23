Return-Path: <bpf+bounces-71949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E09C02510
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 232A44E4F32
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3A5274B28;
	Thu, 23 Oct 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hYEAcFaB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF526ED49;
	Thu, 23 Oct 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235617; cv=none; b=gSeoDpwnfVmrXt47dChI6D6iXC5J3mAkuXbMvjMQ/uJyr1cNd6x30P7IvMs2IHSrQCKH8heJ2GM2kfFsfqYz8x87R9tzPtzSCFhTrcj+7mqI9Hb/Yu8vqaj4iM3pyHm1mQ9/apkonsOFPGQFJWsfWfLaGGsZqflpz87SSDHgU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235617; c=relaxed/simple;
	bh=Rkr2/K5WyituUirf0rxUaWGpUEtb9xPCsKzFDn4yonI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onn6UaY+YnRW0PO104F++Y9/RAoaBdLW3KZLqUM21w7O5ImmCZwbQJqe6rEfB/TUam0LzhZs4O77ZTeOWABnB7a6zJUa0BBbm1HhGnVSNt66XBKaXHwH72r5Ln4VNRMOKlS4UsY/HWbt/XRfTINAhdXz4wULHYMMvhoP2LDtQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hYEAcFaB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7psvY027549;
	Thu, 23 Oct 2025 16:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HRKplFgc/N23qIp2s
	TDF45qMxKOLUtK3bExzmctco20=; b=hYEAcFaBVwAUiN0NTaIMptAk+WPdTS67+
	Qtte2gen6qAzvGM0a858JeyD+fvkgLI2aCOG4QOA11LzwVxBFGuVvN/Yi5JxSdVD
	96/URo/fMi/E+xclZbJVSTg5Ui4UGSmWrI8eZYbYxVQ2ao1eXBAUlxFyBK4J16UJ
	z28sklUPgNoyVv/0BwFXUWHmDSMLRTVgpprQXGgRBVLEnnNUn19nsRC3czKDD98/
	pcQtvtsZjlbuvm2fJJg/YUyEqlfcEypU3K4s/Jnj6g+NrvTVmm/RWkB8+CyEB0Q2
	uwjGMC5HqRWo1+E4qJmE0WgXR76//hoJJmsRvbq6BScwHKSH3A+uw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fk7xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 16:05:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NG5Rtp014464;
	Thu, 23 Oct 2025 16:05:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fk7xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 16:05:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NE0lhC024987;
	Thu, 23 Oct 2025 16:05:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk6jqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 16:05:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NG5n9q43188482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 16:05:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CE3120043;
	Thu, 23 Oct 2025 16:05:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0A742004E;
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
Subject: [RFC PATCH 2/2] fixup! unwind_user/sframe: Add .sframe validation option
Date: Thu, 23 Oct 2025 18:05:45 +0200
Message-ID: <20251023160545.549532-2-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023160545.549532-1-jremus@linux.ibm.com>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
 <20251023160545.549532-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa5263 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=RXKZOtKmAAAA:8
 a=QM4A5weLxKa4Be6FPkMA:9 a=UFF3uGjEBZWolfm0k6KQ:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=DXsff8QfwkrTrK3sU8N1:22 a=p-dnK0njbqwfn1k4-x12:22 a=7aar8cbMflRChVwg8ngv:22
X-Proofpoint-GUID: JQOQOsgBFhMmP2VrUNQfgcLdi1PTmTK7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7i7elW/X49hm
 rd4PYzXvuZOcz+YChHWDjPYMaoks8NQ6lv4D+jK8NDgGKbOyFW0Q5nnVNsOVZS+msSRFtuelnBl
 kboV7c7ljE9Xxvu1QpTNQiaSZyLr1bPAdCizLxsEKGWC+P2q9aV/m5WaN4DcK58sRrOGBpsfrbu
 ewfRBloJPYeB7Dm0bFRBky0A6qVcoiD5L/pFsICGXhbzonBeszCYrFV2VXdjl4xvsNs4sCiT6qI
 sQY/Y4NFTz7z3Rvdra3u9ICOZb0TqAtLC8fzGzDtbHHp7SeZqwi+xc85mMRwisesQNHDx/yK0zO
 WoyPX9h4aN3kQFgDUl1/RidYa6GME/RoFerXW33s3Rnmqn93SRMMsD6lJ84umhPQ078TQQKDTbm
 AovBvFswYrncVfmtPncAJsdz2t+bMw==
X-Proofpoint-ORIG-GUID: 2pQ0g_imgIn4r0izGJe5pHdkYBlMN7vJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

This RFC fixup is POC to demonstrate how the SFrame validation code
would adjust if introducing an internal FDE representation (struct
sframe_fde_internal) similar to the used internal FRE representation
(struct sframe_fre) in the SFrame reading code.  The goal is to
eliminate the passing through of fde_start_base in many places as well
as the various computations of the effective function start address
(= *fde_start_base + fde->start_addr) throughout this module.  The
internal FDE representation simply conveys the effective function start
address via the "unsigned long func_start_addr" field.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 kernel/unwind/sframe.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index f88fc2c92c58..f2977c010117 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -354,21 +354,21 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 #ifdef CONFIG_SFRAME_VALIDATION
 
 static int safe_read_fde(struct sframe_section *sec,
-			 unsigned int fde_num, struct sframe_fde *fde,
-			 unsigned long *fde_start_base)
+			 unsigned int fde_num, struct sframe_fde_internal *fde)
 {
 	int ret;
 
 	if (!user_read_access_begin((void __user *)sec->sframe_start,
 				    sec->sframe_end - sec->sframe_start))
 		return -EFAULT;
-	ret = __read_fde(sec, fde_num, fde, fde_start_base);
+	ret = __read_fde(sec, fde_num, fde);
 	user_read_access_end();
 	return ret;
 }
 
 static int safe_read_fre(struct sframe_section *sec,
-			 struct sframe_fde *fde, unsigned long fre_addr,
+			 struct sframe_fde_internal *fde,
+			 unsigned long fre_addr,
 			 struct sframe_fre *fre)
 {
 	int ret;
@@ -388,18 +388,18 @@ static int sframe_validate_section(struct sframe_section *sec)
 
 	for (i = 0; i < sec->num_fdes; i++) {
 		struct sframe_fre *fre, *prev_fre = NULL;
-		unsigned long ip, fde_start_base, fre_addr;
-		struct sframe_fde fde;
+		unsigned long ip, fre_addr;
+		struct sframe_fde_internal fde;
 		struct sframe_fre fres[2];
 		bool which = false;
 		unsigned int j;
 		int ret;
 
-		ret = safe_read_fde(sec, i, &fde, &fde_start_base);
+		ret = safe_read_fde(sec, i, &fde);
 		if (ret)
 			return ret;
 
-		ip = fde_start_base + fde.start_addr;
+		ip = fde.func_start_addr;
 		if (ip <= prev_ip) {
 			dbg_sec("fde %u not sorted\n", i);
 			return -EFAULT;
@@ -416,8 +416,8 @@ static int sframe_validate_section(struct sframe_section *sec)
 			ret = safe_read_fre(sec, &fde, fre_addr, fre);
 			if (ret) {
 				dbg_sec("fde %u: __read_fre(%u) failed\n", i, j);
-				dbg_sec("FDE: start_addr:0x%x func_size:0x%x fres_off:0x%x fres_num:%d info:%u rep_size:%u\n",
-					fde.start_addr, fde.func_size,
+				dbg_sec("FDE: func_start_addr:0x%lx func_size:0x%x fres_off:0x%x fres_num:%d info:%u rep_size:%u\n",
+					fde.func_start_addr, fde.func_size,
 					fde.fres_off, fde.fres_num,
 					fde.info, fde.rep_size);
 				return ret;
-- 
2.48.1


