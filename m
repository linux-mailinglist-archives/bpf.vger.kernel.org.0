Return-Path: <bpf+bounces-43373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8279B4287
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 07:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437831C21A03
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 06:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4100720125C;
	Tue, 29 Oct 2024 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iJAGDJX0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178A145B2C;
	Tue, 29 Oct 2024 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730184340; cv=none; b=JqLA0zh/do9Clnp8VJ51hqgdIoZdqxNluARnxtIVNbkQFT8BI7yHTyR1DJ1Vayuvxc6SjwENkZ2agc+Q9KtwnYllKU5yd6DV7Sa0saZ/4CMwEo/O2iJtgwj5H/wQsvkSFzZodkU7Z3NuG6Aja0FnTh9z67D5LHik1tFNHyVpJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730184340; c=relaxed/simple;
	bh=1DrL+8jrbRz5TXvELVZ3R7u/AfvuuYFORhxgcZBZzpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lejOKsxJN8IxTusLLsB9HRBf42Ys3hQveS/vQtsfU9uwupGAGXY8fxVa83V++8j/t92Jd5H6zHoDH0Lu88LO4oObwa4Eg2gCCEDX1t5rxHH04Z4qxB5M1CKS16zv99K+s+tDlJkpcPl1To/tq6TREOOq4SskzQpId8xpz1uFSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iJAGDJX0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T25Ta3007263;
	Tue, 29 Oct 2024 06:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wpMMtU
	T/7iLSb1CPes2U6yH2Knc2kYorBmqmySojMfw=; b=iJAGDJX0zp7I8wnDmOxnwR
	nsM832ucdpVHkqQlx2nmn3aDhYFrvERJXw+QFNKGd0H1UhMEw6AIZDhCEjEexTAI
	guKsHOoqJguJX/7T0/zQZAK+VWxiqz9f3CchJR+AXAmbWu3MJQC581JSC2+woml5
	wu4gC23D4KkJH74McGOquG3CMMc2mmS+7vem9H1FJ2TbLKQmXSvskdWJa/iu90p4
	0kpLJ8LHaYEpm2681wNPdpOFRtuVAAYCFr/xX16m5/yk5yQhxw+p8EF+TdfG3nR3
	9ObEqtjhVEPKZWfz9X5implw3U26UFo9ZQNNGrlLtysJVwIYYNIg8BUynlDR1Gng
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb65bm7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 06:44:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49T6idbf015515;
	Tue, 29 Oct 2024 06:44:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb65bm7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 06:44:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49T55BI6017313;
	Tue, 29 Oct 2024 06:44:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42harsa1gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 06:44:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49T6iZ7M40370472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 06:44:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4555820043;
	Tue, 29 Oct 2024 06:44:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBCF820040;
	Tue, 29 Oct 2024 06:44:31 +0000 (GMT)
Received: from [9.203.115.143] (unknown [9.203.115.143])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Oct 2024 06:44:31 +0000 (GMT)
Message-ID: <841804f7-d634-4d8c-8585-04a2e4ea40f0@linux.ibm.com>
Date: Tue, 29 Oct 2024 12:14:30 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/17] powerpc64/bpf: Add support for bpf trampolines
To: Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: "Naveen N. Rao" <naveen@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
References: <20241018173632.277333-1-hbathini@linux.ibm.com>
 <20241018173632.277333-18-hbathini@linux.ibm.com>
 <87wmhtrmni.fsf@mpe.ellerman.id.au>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <87wmhtrmni.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -iB9zBHmU6GGaR0CrGda44FqrDjFKDqK
X-Proofpoint-GUID: 57WHYjnIt4dw8lVBHWWBue558w_N7zEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290052



On 28/10/24 7:53 am, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.ibm.com> writes:
>> From: Naveen N Rao <naveen@kernel.org>
>>
>> Add support for bpf_arch_text_poke() and arch_prepare_bpf_trampoline()
>> for 64-bit powerpc. While the code is generic, BPF trampolines are only
>> enabled on 64-bit powerpc. 32-bit powerpc will need testing and some
>> updates.
> 
> Hi Hari,
> 
> This is breaking the PCREL build for me:
> 
>    ERROR: 11:49:18: Failed building ppc64le_defconfig+pcrel@fedora
>    INFO: 11:49:18: (skipped 41 lines) ...
>    INFO: 11:49:18: /linux/arch/powerpc/net/bpf_jit.h:90:9: note: in expansion of macro 'EMIT'
>       90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
>          |         ^~~~
>    /linux/arch/powerpc/include/asm/ppc-opcode.h:473:88: note: in expansion of macro 'IMM_DS'
>      473 | #define PPC_RAW_LD(r, base, i)          (0xe8000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_DS(i))
>          |                                                                                        ^~~~~~
>    /linux/arch/powerpc/net/bpf_jit.h:90:14: note: in expansion of macro 'PPC_RAW_LD'
>       90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
>          |              ^~~~~~~~~~
>    /linux/arch/powerpc/net/bpf_jit.h:90:36: note: in expansion of macro 'offsetof'
>       90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
>          |                                    ^~~~~~~~
>    /linux/arch/powerpc/net/bpf_jit_comp.c:791:17: note: in expansion of macro 'PPC64_LOAD_PACA'
>      791 |                 PPC64_LOAD_PACA();
>          |                 ^~~~~~~~~~~~~~~
>    /linux/arch/powerpc/net/bpf_jit.h:90:65: error: 'struct paca_struct' has no member named 'kernel_toc'; did you mean 'kernel_msr'?
>       90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
>          |                                                                 ^~~~~~~~~~
>    /linux/arch/powerpc/net/bpf_jit.h:29:34: note: in definition of macro 'PLANT_INSTR'
>       29 |         do { if (d) { (d)[idx] = instr; } idx++; } while (0)
>          |                                  ^~~~~
>    /linux/arch/powerpc/net/bpf_jit.h:90:9: note: in expansion of macro 'EMIT'
>       90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
>          |         ^~~~
>    /linux/arch/powerpc/include/asm/ppc-opcode.h:473:88: note: in expansion of macro 'IMM_DS'
>      473 | #define PPC_RAW_LD(r, base, i)          (0xe8000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_DS(i))
>          |                                                                                        ^~~~~~
>    /linux/arch/powerpc/net/bpf_jit.h:90:14: note: in expansion of macro 'PPC_RAW_LD'
>       90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
>          |              ^~~~~~~~~~
>    /linux/arch/powerpc/net/bpf_jit.h:90:36: note: in expansion of macro 'offsetof'
>       90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
>          |                                    ^~~~~~~~
>    /linux/arch/powerpc/net/bpf_jit_comp.c:882:25: note: in expansion of macro 'PPC64_LOAD_PACA'
>      882 |                         PPC64_LOAD_PACA();
>          |                         ^~~~~~~~~~~~~~~
>    make[5]: *** [/linux/scripts/Makefile.build:229: arch/powerpc/net/bpf_jit_comp.o] Error 1
> 
> 
> To test it you need to enable CONFIG_POWER10_CPU, eg:
> 
>    CONFIG_POWERPC64_CPU=n
>    CONFIG_POWER10_CPU=y
>    CONFIG_PPC_KERNEL_PCREL=y
> 
> This diff gets it building, but I haven't tested it actually works:

Thanks, Michael. Yeah, the below snippet will be sufficient as
PPC64_LOAD_PACA() is used with !IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)

- Hari

> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 2d04ce5a23da..af6ff3eb621a 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -86,9 +86,14 @@
>                                                          0xffff));             \
>                  } } while (0)
>   #define PPC_LI_ADDR    PPC_LI64
> +
> +#ifndef CONFIG_PPC_KERNEL_PCREL
>   #define PPC64_LOAD_PACA()                                                    \
>          EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
>   #else
> +#define PPC64_LOAD_PACA() do {} while (0)
> +#endif
> +#else
>   #define PPC_LI64(d, i) BUILD_BUG()
>   #define PPC_LI_ADDR    PPC_LI32
>   #define PPC64_LOAD_PACA() BUILD_BUG()
> 
> cheers
> 


