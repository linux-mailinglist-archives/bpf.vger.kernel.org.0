Return-Path: <bpf+bounces-64885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6334B18203
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 14:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1CBB7A409D
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 12:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93F524728A;
	Fri,  1 Aug 2025 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mVAzJraa"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BAC1A3178;
	Fri,  1 Aug 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754052882; cv=none; b=pLmepx6NqTQJUgRcdKuBdCy1Tjm5Bblha3QW7FcMdGNWTLY0IZ2RiJY9uMbBLkqNeHFG6hYei2ibUriLVw/HS+fv4wCIU3V8h1AIwaCpd6BscpKvgPe7g1RMcgIkY/UmgTRqpEGBi7BQO4SndZNN2H9ccerUqydDd4+evPQ7xXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754052882; c=relaxed/simple;
	bh=W17CgRpCcA1BSn73lMqnsBAYjeIbaRzoHzy/VqgdLBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcHVqBZ5jLUwGzrmcXBu31XMsR7g+Pje2stcc5BpmQifGq1ERqZtSTyGy16F9kJEA3FPdBJQNCVQtBp3lWrKkLEZJ+5AcX+zp72yDYb+zIOwfGOU3TgQnxA+HFTTW2Z9bq7BaT+6FomSSVbsXmk46NtpZPc8J5eUK0uNuR1OOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mVAzJraa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5717lj6i017116;
	Fri, 1 Aug 2025 12:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RM+wXDg91nZxzEfKUC/aUjfAHLwDla
	aWmzTLZ9E6EDI=; b=mVAzJraayJpip02bsi84Pzk5Iw3//MbbeEOVIWW75AIHpp
	nRzo1ya7t+g7Vlz0xkW7e2qmpgvyUxWXo9zSr8QHZ4bxeH+fLiuBnS3Q58Ll/wZJ
	lSPoOhb5k7LqaPPiL0zCSE0ewK7eq6++jvAdK2F37JdjKoQKaXnKazIhHFLB/Y6j
	vIWStK6itk3nYo5QUBgqjiRWLP8OGntWu/9DGT9gajsGemE/aom9MXjDDjrn6HDe
	25PnXxewQ8hRXLy7WMWhzBJ88ysO4S8eU44O01edlnf3e5Z7nx+XHrNvS1IyNEMC
	ooC5oWCkq0PVf9MJ6+OoYFaCRck5olXILbJsLtKA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4864k896xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 12:53:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5718jBmD017275;
	Fri, 1 Aug 2025 12:53:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859r0hj3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 12:53:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571CrqLa43385276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 12:53:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2EA82004B;
	Fri,  1 Aug 2025 12:53:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D242720043;
	Fri,  1 Aug 2025 12:53:51 +0000 (GMT)
Received: from osiris (unknown [9.111.82.186])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  1 Aug 2025 12:53:51 +0000 (GMT)
Date: Fri, 1 Aug 2025 14:53:50 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
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
Subject: Re: [RFC PATCH v1 11/16] s390/unwind_user/sframe: Enable
 HAVE_UNWIND_USER_SFRAME
Message-ID: <20250801125350.9905B20-hca@linux.ibm.com>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
 <20250710163522.3195293-12-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710163522.3195293-12-jremus@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BAGEYFyOjhcKCT6uRHhsnl48vgulLEex
X-Proofpoint-GUID: BAGEYFyOjhcKCT6uRHhsnl48vgulLEex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA5MiBTYWx0ZWRfX2prHMf8SZzOt
 dFahisWf+YI1ynsFhUwkRqOkgc0PbQ+8TgjAVcymyypToUVqaA9NFlLYJRgjH0aKjM8eDwtEFoi
 rz+nuCkolnJQs3yg5skvKJbUt8GU3ZN9D41rED2Hl1fWaPLmnGPHw1eNB/eU5mlZ1uy8GlEQl+/
 VgaHrFjdDE2C3SHAO8H2/ziyY88HC9wooRuRaWDInrGlyrykymJnvijtW0c5oMKlAChOLwibhGF
 WjPGoSlK4/xdgrWUkajj26ugTxVrMVCrJ+3Z2twKyj2K6MtmkurlbohSIy8RF6VDL+FShqtK/QC
 GlmbUXugnIDn3Z+CAXZePneKlX8UZiNlwyA9vhXjt07ac4VwJWgTqYOY2astV6vOH0sMk8lFfyM
 FsP/xh2QUe1D7Jot0IxSds6ZFJk2qv6bcNZSlbeDpXqjj+RXmYjmiTwWPfg2Y4CXmObTzyx+
X-Authority-Analysis: v=2.4 cv=ZoDtK87G c=1 sm=1 tr=0 ts=688cb8e5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=vXNe0y40mXAc93P3-MgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxlogscore=439 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010092

On Thu, Jul 10, 2025 at 06:35:17PM +0200, Jens Remus wrote:
> Add s390 support for unwinding of user space using SFrame.  This
> leverages the previous commits to address the following s390
> particularities:
> 
> - The CFA is defined as the value of the stack pointer (SP) at call
>   site in the previous frame + 160.  Therefore the SP unwinds as
>   SP = CFA - 160.  Therefore use a SP value offset from CFA of -160.
> 
> - The return address (RA) is not saved on the stack at function entry.
>   It is also not saved in the function prologue, when in leaf functions.
>   Therefore the RA does not necessarily need to be unwound in the first
>   unwinding step for the topmost frame.
> 
> - The frame pointer (FP) and/or return address (RA) may be saved in
>   other registers when in leaf functions.  GCC effectively uses
>   floating-point registers (FPR) for this purpose.  Therefore DWARF
>   register numbers may be encoded in the SFrame FP/RA offsets.

...

> +static inline void __s390_get_dwarf_fpr(unsigned long *val, int regnum)
> +{
> +	switch (regnum) {
> +	case 16:
> +		fpu_std(0, (freg_t *)val);
> +		break;

...

> +static inline int s390_unwind_user_get_reg(unsigned long *val, int regnum)
> +{
> +	if (0 <= regnum && regnum <= 15) {
> +		struct pt_regs *regs = task_pt_regs(current);
> +		*val = regs->gprs[regnum];
> +	} else if (16 <= regnum && regnum <= 31) {
> +		__s390_get_dwarf_fpr(val, regnum);

This won't work with other potential in-kernel fpu users. User space fpr
contents may have been written to the current task's fpu save area and fprs
may have been clobbered by in-kernel users; so you need to get register
contents from the correct location. See arch/s390/include/asm/fpu.h.

