Return-Path: <bpf+bounces-62113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD0EAF1641
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F46A7AF23F
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD662750F2;
	Wed,  2 Jul 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n+US6jnL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685A275112;
	Wed,  2 Jul 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461072; cv=none; b=ViOWbUkf4bXcVncBrLf7KtMCeGHoYIWakftUSNTcBWnKujmuI0ql4pMbyAI9sD01Ng8i602TE0qWi0GGmuLlerlVURDejWtd3ZOGMMMJh8JWi9LNhhnqcjWJw83axNTC1EquvICNSRIP55c43qpMwg5fbqOjZhrFfcUwFGhiXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461072; c=relaxed/simple;
	bh=0fV3N+hhZTmP3CQyJcJtFrhr7wGpoiGzXrO2T7RbqXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jh5aNqj+Wyy9KouJzZgJOBqfgFATjQfORIx/8GIz1rwXxut4FgVBfbMoHM+JKwPI2FXgpcSFybQomuRWK99mQd5snEE2v4u9TnLk2VGpICAmkIeRi9PNXyx0WLUdkp+OIWIYBrs/+xzECNaC6gDBDJmsfhOZPpc9M7mdywOATqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n+US6jnL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562CeI0O013209;
	Wed, 2 Jul 2025 12:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SLo8ad
	wDyZ2a+aEcqiFtRAlQqRjdUifFA/wDj5U+6E8=; b=n+US6jnLLdYL7kglYNbjuT
	mu+7W7oKznhnLHXcTZ+yxYXJhXecORrkuKs0qK4PQKG2kznZxiy5O6rbM6ly4yPy
	WUI+nGbpnTED/nxw+fIr2Le7LJ7Ycvku6SoYeLDiy/hnPkUkueJcI4UBcaujseX5
	whjyWjwmSMkBW/9BV4ziW4Ws8mf6Jt+BnbZojZPxniB2vHbWffzeS5O0AD6jsHL4
	1lH7E+KY1kYqFw9vh5K5ZQg73srEDMgnuvT8z68OYLyaicfXMs7op0ikbSQCYwki
	xqbO44kiA5h7/uH51Fa8Vmf+hYPyQlY08VgPLxpoGa0424clmAws8xWHv80ZTL/A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u1w93x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 12:57:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5629VnOB032148;
	Wed, 2 Jul 2025 12:57:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47ju40qq2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 12:57:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562CvNfS39846152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 12:57:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CF4120043;
	Wed,  2 Jul 2025 12:57:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08BEC20040;
	Wed,  2 Jul 2025 12:57:23 +0000 (GMT)
Received: from [9.152.222.224] (unknown [9.152.222.224])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 12:57:22 +0000 (GMT)
Message-ID: <7eea50a5-e1b0-4319-9a25-cb8b327a836d@linux.ibm.com>
Date: Wed, 2 Jul 2025 14:57:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] unwind_deferred: Implement sframe handling
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, Indu Bhagat <indu.bhagat@oracle.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20250701184939.026626626@goodmis.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250701184939.026626626@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j3dTyobZwAYIbBORySSJbo7qt5Esgp4q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwMCBTYWx0ZWRfX6AqeVuxaFy6R L7a8jktW83LvqDP1UBtNsl/c9tmm4ywmoxtAlag09SVF5pmKLG+qU2mwlWZfkuxUDA4phdzqWv1 rJv2JBhXSryQOSPVKpQwheusTbYWUFDH1UOGdS0jEP4Gb8zzSU2wmog5bUYnOyd9YKM/4uByhim
 oN9cQRKfsE85f9fo3quLNyTBupVI8C6fgNkCoXOWRh/4G6u2GULg/XiXxnYGEkS/y/hjX4IVxFE Pm72SvUfXi5M+BlmcN6Sy9/3bcl26hdQkLDu0WW/HdNDU08MSZIKLCSS8VKN+95P9fGjs2UvKWp PQXQKJKjqSyLUWt6kG6rSCe3NiwtfVpGU8n6j6rWpm6Dghn4A85S9mH01PdznUhdY8mO/2T6eQp
 DmpgOI44g4xcFd25TVk1CiT+zZg0FkHQsRzlUGDK2xUlxD1fA5bO1wNAgx940zL3Ep0wz7KP
X-Proofpoint-GUID: j3dTyobZwAYIbBORySSJbo7qt5Esgp4q
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=68652cb8 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8 a=GcyzOjIWAAAA:8
 a=gqIrRWIkWWbV9rJkhgAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-476f2AVtAYA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=hQL3dl6oAZ8NdCsdz28n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020100

Hello Steve!

On 01.07.2025 20:49, Steven Rostedt wrote:
> This code is based on top of:
> 
>  https://lore.kernel.org/linux-trace-kernel/20250701005321.942306427@goodmis.org/
>  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git unwind/core
> 
> This is the implementation of parsing the SFrame section in an ELF file.

...

> The code for this patch series can be found here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git unwind/sframe

Wouldn't it make sense to include your related perf (tools) series [1]
in that branch to ease testing?  Provided you also include the minor
fix [2] to make perf tools work. :-)

Additionally it would make sense to include the patches from Josh that
add SFrame information to the vDSO on x86 [3].

[1]: [PATCH v12 00/11] perf: Support the deferred unwinding infrastructure,
https://lore.kernel.org/linux-trace-kernel/20250701180410.755491417@goodmis.org/

[2]: https://lore.kernel.org/linux-trace-kernel/51903e66-56bc-42a4-b80c-9c3223e2a48a@linux.ibm.com/

[3]: [PATCH v6 0/6] x86/vdso: VDSO updates and fixes for sframes,
https://lore.kernel.org/all/20250425023750.669174660@goodmis.org/

> Changes since v6: https://lore.kernel.org/linux-trace-kernel/20250617225009.233007152@goodmis.org/

> - Moved the addition of the prctl(), that allows libraries to add the elf
>   sections to the kernel, to the last patch and labeled it as "DO NOT APPLY".
>   This should instead be a proper system call and work to make it robust and
>   flexible still needs to be done. The prctl() patch is added for debugging
>   purposes only.

Does PR_SET_VMA [4] create a precedent case for the SFrame prctls?

[4]: https://man7.org/linux/man-pages/man2/pr_set_vma.2const.html

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


