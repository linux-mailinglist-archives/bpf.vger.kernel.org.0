Return-Path: <bpf+bounces-70642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 421A5BC775C
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 07:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D84AB350F59
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 05:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F223D7EB;
	Thu,  9 Oct 2025 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l70Aktyx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF44AD4B;
	Thu,  9 Oct 2025 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989030; cv=none; b=gEjFLTBS/DhBtdbue2DbK1IyR/lRC8I1+FHBvPQY/kE0lmA10WS09nT6TYwiQJfMY8l9bawlrQ7bwIGOLn0AudpeM8z+ve4jcDYdudnQG+KqLwl2XfanRw3jR852GuYPMsRJT+4dn4DMAaHVwycPrEJuWx+DyCr9vDo4c1zAluI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989030; c=relaxed/simple;
	bh=98qv5gCVu0arT0WU/zbKp6K58lsyDxcHiEjm2yynPKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXHY/5TqZx7M0FS2Z5Au2OT+b5KpjxObF1+9kY8h89oyM/nP8i2L5Jx08Gt9r7thALaByMd0EiOQKHJo9SIoQG85Vz2JTDcqZspODcH1CPrPVoT2IFK0IvWm8TyRhi2EJImplxfcYwdVhC/R9nZ3PgzqshAlP/wrqnLIpRp8foY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l70Aktyx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5994KH1i002137;
	Thu, 9 Oct 2025 05:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/5cSbI
	lTHivCoCjUL+gWdAZHt8AL5oHSUiVwv6sMvf0=; b=l70AktyxnXQwFM9irjndoO
	CwzJCqr8QN9geIZivEu0D1z3ldjMn9twN0V3D7PbuIXoXvLwcLv4j4qsVSwTf37w
	U49xkAIq/eVbWGEU0sB2ViYCEFBUv4/t8frQ8X1FjBm5J6HXcdBWkbZ7yyiuU/F8
	lQFWpC1EcqMGGDTyCQ9rFQcerGlItTZCfU8nPe1EHFpWChl8/Xq5ZpieoW4BCm8T
	/Ywz5lbHM+V1iz4HsuMjHqDyr4k5Dk08wGRaLOhQhxAasip9lR6UIELVC0hyktpx
	cmfD0UF+lhTlBDTH31igSIIy2k6yCS/yhjNn9bONw2nXcwqtx1teGkeNph2hmC5w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv86tk9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 05:49:54 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5995lwZb006383;
	Thu, 9 Oct 2025 05:49:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv86tk9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 05:49:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5991XAbr021040;
	Thu, 9 Oct 2025 05:49:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nv8sjjyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 05:49:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5995npEc17563960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 05:49:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 082BD20049;
	Thu,  9 Oct 2025 05:49:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C47F20040;
	Thu,  9 Oct 2025 05:49:47 +0000 (GMT)
Received: from [9.78.106.240] (unknown [9.78.106.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 05:49:47 +0000 (GMT)
Message-ID: <42d72061-3d23-43db-bb02-d5f75333c924@linux.ibm.com>
Date: Thu, 9 Oct 2025 11:19:45 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc64/bpf: support direct_call on livepatch function
To: Naveen N Rao <naveen@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, Viktor Malik <vmalik@redhat.com>,
        live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Joe Lawrence
 <joe.lawrence@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20251002192755.86441-1-hbathini@linux.ibm.com>
 <amwerofvasp7ssmq3zlrjakqj5aygyrgplcqzweno4ef42tiav@uex2ildqjvx2>
 <17f49a63-eccb-4075-91dd-b1f37aa762c7@linux.ibm.com>
 <unegysw3bihg32od7aham3npsdpm5govboo3uglorwsrjqfqfk@pbyzwwztmqtc>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <unegysw3bihg32od7aham3npsdpm5govboo3uglorwsrjqfqfk@pbyzwwztmqtc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vmzUx7Jj6cCsN4wLndwN3vVcZMSsNY-1
X-Proofpoint-ORIG-GUID: _txk5zoJyP1dG6BShDodMjflf50oEsuh
X-Authority-Analysis: v=2.4 cv=MKNtWcZl c=1 sm=1 tr=0 ts=68e74d02 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=RPo1N_Dm-bXGz9hhwcIA:9
 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX63z3IqBezQN+
 C81paXFCtrGEL+Iwuc77cQ41YfOapgJ2QPAn4UVzWbXghqF3hEpqCVAHiIJhKF0M/f05w7Lw+gG
 ff8ffvldnzoh8rvq2fNMiHmAQzkHiesAZ5+BI2QSsZy0J5GMm03gdq4cpOgySpl/HU9BOyj8hAV
 4JEkAr2QgA6Qu3vmiHJ6GLTGmwjM5AAob2Xj4mIxgZ5RnA4X0ION/4HE9wA20fzm7fSv53sZgAS
 w3HOGKVydVjs4dzud0UNF6gToHe54UuFLftWTx3ODzY7OUebRuteTlI2zBUEyOd9ssevzr6eiy3
 PtT9OPxLNo8REsbkPPDOeWA1p56Xzk6eb7sKmb2QgAzbuSyrsER3GgGc6Dx9h7TiZnW4ghFca5I
 YeanlSHdIhip6nb4qt6LtAbUY2YzIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510080121



On 08/10/25 1:43 pm, Naveen N Rao wrote:
> On Mon, Oct 06, 2025 at 06:50:20PM +0530, Hari Bathini wrote:
>>
>>
>> On 06/10/25 1:22 pm, Naveen N Rao wrote:
>>> On Fri, Oct 03, 2025 at 12:57:54AM +0530, Hari Bathini wrote:
>>>> Today, livepatch takes precedence over direct_call. Instead, save the
>>>> state and make direct_call before handling livepatch.
>>>
>>> If we call into the BPF trampoline first and if we have
>>> BPF_TRAMP_F_CALL_ORIG set, does this result in the BPF trampoline
>>> calling the new copy of the live-patched function or the old one?
>>
>> Naveen, calls the new copy of the live-patched function..
> 
> Hmm... I'm probably missing something.
> 
> With ftrace OOL stubs, what I recall is that BPF trampoline derives the
> original function address from the OOL stub (which would be associated
> with the original function, not the livepatch one).

Trampoline derives the address from LR. The below snippet
in livepatch_handler ensures the trampoline jumps to '1f'
label instead of the original function with LR updated:

+	/* Jump to the direct_call */
+	bnectrl	cr1
+
+	/*
+	 * The address to jump after direct call is deduced based on ftrace 
OOL stub sequence.
+	 * The seemingly insignificant couple of instructions below is to 
mimic that here to
+	 * jump back to the livepatch handler code below.
+	 */
+	nop
+	b	1f
+
+	/*
+	 * Restore the state for livepatching from the livepatch stack.
+	 * Before that, check if livepatch stack is intact. Use r0 for it.
+	 */
+1:	mtctr	r0


- Hari

