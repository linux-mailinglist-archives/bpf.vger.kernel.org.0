Return-Path: <bpf+bounces-76415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC90BCB3471
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 16:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAAB030C44F2
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2AB30100E;
	Wed, 10 Dec 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e9Q1MsqS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAEF6F2F2;
	Wed, 10 Dec 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765379997; cv=none; b=ZBM0xIo9wP1b51mFd9YxH+PnT+uShRfglo5+YATXI61Hbppo1mvx+llm2tAfdo4N4IKOdpNDuu2xJ6sS3SIvR7+RGQs3lauyg/fNaFsnxeXsk2+sqnbr+4LXfDD4JeQLruHCCZcBCZbKYpb0Z7g9dZhn+ips9Kt5TY8uVocN6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765379997; c=relaxed/simple;
	bh=tiWJ2j4DHKo/8dwgDMqgR6aWAbCgUawqrknhxhNm1ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkA+4TcHGaslirUaBtVKt1iL7Wad6/KvF+Gwa0gzx8S4VcC1Fgmx1eYYSkhGDX8QHv3B0Rq2qleBKejScV8fLdCnFUY74sEZNM26BkPEZCBhOBO3O4P/vBjQgYMQnOUJrKKKsTxIDf9gQYe0JXIWP5SNPLrNP5vrZrOQlMqH048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e9Q1MsqS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAEO9L6012921;
	Wed, 10 Dec 2025 15:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1MWGwR
	wcf54+C5AQhWR3Gqw4fc7GnAdkPMBjYFMNoUw=; b=e9Q1MsqScS4taebbfDazhv
	A8dzCkcLrk6Q/RBNFMhBNd0ScyfdX1IOu3NiIqzfOMF0dX1KKbfwJuthRdOJC9BZ
	t4ZwVw8xObBSty3zva9Djr+HF9UH/z5Xe8wV7wPltBTeb9f9Y0HVdCr2xZkm+Sw0
	eN01KNbncBAZt8o3nB0C6dwvwIAjz/rgsT2lhROMViqkosdnLThu8pKFnzMRs1sD
	OK3X4gfIEAptvq+fmKsbCg1GyDX6HhqQs1tTaefQSraVONccVjagT2kfgCGO2yRp
	vP495L3BVgegnTotmCoTMhXyfT2KTlYcxAUmJgdDGmuzFJAzx+tsQzdRqGl1PM3g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avawvahgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 15:19:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BAEtX8S032066;
	Wed, 10 Dec 2025 15:19:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avawvahgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 15:19:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAE4743008472;
	Wed, 10 Dec 2025 15:19:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytn1937-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 15:19:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BAFJ5VS52298120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 15:19:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE84920043;
	Wed, 10 Dec 2025 15:19:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58CAA20040;
	Wed, 10 Dec 2025 15:19:04 +0000 (GMT)
Received: from osiris (unknown [9.111.15.174])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Dec 2025 15:19:04 +0000 (GMT)
Date: Wed, 10 Dec 2025 16:19:02 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
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
Subject: Re: [RFC PATCH v3 13/17] s390/ptrace: Provide frame_pointer()
Message-ID: <20251210151902.40732D1a-hca@linux.ibm.com>
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
 <20251208171559.2029709-14-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251208171559.2029709-14-jremus@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a_BuvdF9hZClqgXyowAYhzzpkuXFdamT
X-Proofpoint-ORIG-GUID: 8FikjVBgtVE8byOpez3eQKOpzihoHr3U
X-Authority-Analysis: v=2.4 cv=aY9sXBot c=1 sm=1 tr=0 ts=69398f6f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=0Va_bqAEYgpgdbXSXcAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwNyBTYWx0ZWRfX81GjcufygHRk
 w5Fj2uQ0wOdB8YITtX3NTtr7vcOADSfxBAChZ31n2RheVvMPfHoBa8unHgQUIrmc1w41p3IdAuC
 lmiYE6pTJwiXLk1LD5e/AA8dza8yQMtWH18ViY7ImPEfztwXksFqVmvZY97puW1JU0rW4XaGUj9
 hskij6li5fKnkZldbPKLxfLn5qbHiCd4chTpmDhCxvoyOCjQ8WkeJK2Mh+87BLM2Rgk+aBEwuSN
 LNC/iedTyHDF6XvvqZzavqHZDr8UpTK6HuRX2q24Ujq7HduOhpKiQuGsQl+PbLshQpKa2IOPCdV
 RqQuKIJfAVR3I7quWQDbwETGW18lGGU0VbUOBd1d5zgZrnvEbgIFPGzGtAXPGGoyzSFN02I/RfM
 i0gMHULkRKc3mynhvFu7hRqMrQUiVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060007

On Mon, Dec 08, 2025 at 06:15:55PM +0100, Jens Remus wrote:
> On s390 64-bit the s390x ELF ABI [1] designates register 11 as the
> "preferred" frame pointer (FP) register in user space.
> 
> While at it convert instruction_pointer() and user_stack_pointer()
> from macros to inline functions, to align their definition with
> x86 and arm64.
> 
> Use const qualifier on struct pt_regs pointers to prevent compiler
> warnings:
> 
> arch/s390/kernel/stacktrace.c: In function ‘arch_stack_walk_user_common’:
> arch/s390/kernel/stacktrace.c:114:34: warning: passing argument 1 of
> ‘instruction_pointer’ discards ‘const’ qualifier from pointer target
> type [-Wdiscarded-qualifiers]
> ...
> arch/s390/kernel/stacktrace.c:117:48: warning: passing argument 1 of
> ‘user_stack_pointer’ discards ‘const’ qualifier from pointer target
> type [-Wdiscarded-qualifiers]
> ...
> 
> [1]: s390x ELF ABI, https://github.com/IBM/s390x-abi/releases
> 
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
> 
> Notes (jremus):
>     Changes in RFC v2:
>     - Separate provide frame_pointer() into this new commit.
> 
>  arch/s390/include/asm/ptrace.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
> index dfa770b15fad..455c119167fc 100644
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -212,8 +212,6 @@ void update_cr_regs(struct task_struct *task);
>  #define arch_has_block_step()	(1)
>  
>  #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
> -#define instruction_pointer(regs) ((regs)->psw.addr)
> -#define user_stack_pointer(regs)((regs)->gprs[15])
>  #define profile_pc(regs) instruction_pointer(regs)

"while at it", and then you don't convert user_mode() to a function? :)

Please provide a stand-alone patch for the "while at it" stuff, so it
can go independently.

