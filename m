Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6E3A6ADA
	for <lists+bpf@lfdr.de>; Mon, 14 Jun 2021 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhFNPtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Jun 2021 11:49:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234465AbhFNPtK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 14 Jun 2021 11:49:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EFY9ZQ018819;
        Mon, 14 Jun 2021 11:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=iufwgfEldV70ORNGlohIey8QqufRHIAQPypVoFkjH/c=;
 b=g5x7zp+PG7xMDBOuvoeGo9SJ/yZacwobEq+73EjXMaihu3jab/BcA97o3+s1Dd1UcrAF
 oZ1tY2Q5WHIdtGt1BK6YiesgPewW04WfNcxfPFrLFg7S1tTm5+AIOsezdtqn1cmz+0UH
 hpw9cBsUS71JbcTQnqIQXRz8c/HeAVVzJ8aMiQX3IuxjVZ2WtFkf7opH5EFmYfk8jao7
 3JWl8F82SvdVEjnGzzlGYdDfPhOJQIvaVQhAnv67y7COBbb/+ib23AZ2y6FcZnUYim8o
 tJ/b6qlbqohVEmUbdiHkM/PbKRfY+F35/cVDKVEtmoD4qN9SDUm99wmpsABZloGOHf5S 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39671apvn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 11:46:34 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15EFYEt1019125;
        Mon, 14 Jun 2021 11:46:33 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39671apvm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 11:46:33 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15EFguoA031047;
        Mon, 14 Jun 2021 15:46:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 394m6hs1nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 15:46:31 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15EFkThE35258682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 15:46:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54824AE055;
        Mon, 14 Jun 2021 15:46:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2DB6AE045;
        Mon, 14 Jun 2021 15:46:28 +0000 (GMT)
Received: from localhost (unknown [9.85.73.215])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 15:46:28 +0000 (GMT)
Date:   Mon, 14 Jun 2021 21:16:26 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip v7 03/13] kprobes: treewide: Remove
 trampoline_address from kretprobe_trampoline_handler()
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org,
        bpf@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, kernel-team@fb.com,
        kuba@kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Abhishek Sagar <sagar.abhishek@gmail.com>, tglx@linutronix.de,
        X86 ML <x86@kernel.org>, yhs@fb.com
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
        <162209757191.436794.12654958417415894884.stgit@devnote2>
In-Reply-To: <162209757191.436794.12654958417415894884.stgit@devnote2>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1623685371.y5qy4nxer2.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9fhSx89odVf5INJWR2yl-7U9AFcZNx8R
X-Proofpoint-ORIG-GUID: UohyzDTtlp9FN-x5xY_KM1UScthLuuh-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_10:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140099
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Masami,

Masami Hiramatsu wrote:
> Remove trampoline_address from kretprobe_trampoline_handler().
> Instead of passing the address, kretprobe_trampoline_handler()
> can use new kretprobe_trampoline_addr().
>=20
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Andrii Nakryik <andrii@kernel.org>
> ---
>  Changes in v3:
>    - Remove wrong kretprobe_trampoline declaration from
>      arch/x86/include/asm/kprobes.h.
>  Changes in v2:
>    - Remove arch_deref_entry_point() from comment.
> ---
>  arch/arc/kernel/kprobes.c          |    2 +-
>  arch/arm/probes/kprobes/core.c     |    3 +--
>  arch/arm64/kernel/probes/kprobes.c |    3 +--
>  arch/csky/kernel/probes/kprobes.c  |    2 +-
>  arch/ia64/kernel/kprobes.c         |    5 ++---
>  arch/mips/kernel/kprobes.c         |    3 +--
>  arch/parisc/kernel/kprobes.c       |    4 ++--
>  arch/powerpc/kernel/kprobes.c      |    2 +-
>  arch/riscv/kernel/probes/kprobes.c |    2 +-
>  arch/s390/kernel/kprobes.c         |    2 +-
>  arch/sh/kernel/kprobes.c           |    2 +-
>  arch/sparc/kernel/kprobes.c        |    2 +-
>  arch/x86/include/asm/kprobes.h     |    1 -
>  arch/x86/kernel/kprobes/core.c     |    2 +-
>  include/linux/kprobes.h            |   18 +++++++++++++-----
>  kernel/kprobes.c                   |    3 +--
>  16 files changed, 29 insertions(+), 27 deletions(-)
>=20

<snip>

> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index d65c041b5c22..65dadd4238a2 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -205,15 +205,23 @@ extern void arch_prepare_kretprobe(struct kretprobe=
_instance *ri,
>  				   struct pt_regs *regs);
>  extern int arch_trampoline_kprobe(struct kprobe *p);
> =20
> +void kretprobe_trampoline(void);
> +/*
> + * Since some architecture uses structured function pointer,
> + * use dereference_function_descriptor() to get real function address.
> + */
> +static nokprobe_inline void *kretprobe_trampoline_addr(void)
> +{
> +	return dereference_function_descriptor(kretprobe_trampoline);

I'm afraid this won't work correctly. For kernel functions, please use=20
dereference_kernel_function_descriptor() which checks if the function=20
has a descriptor before dereferencing it.


Thanks,
Naveen

