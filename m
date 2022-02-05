Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8254AA740
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 08:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbiBEHFD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Feb 2022 02:05:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229835AbiBEHFB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 5 Feb 2022 02:05:01 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2154R19b026042;
        Sat, 5 Feb 2022 07:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=m55UgW1yPVm/xJNrJGH8Nu18bCVaVMk5Ff08yWLXK/I=;
 b=au78TQRDJ2oBI1p7mkrSx1rjeZ2P7CHyNQt8f2WTDmNUDe9+I8wE6OLP94eAwgYlVjCo
 Cz5qMxAtRmhF53twYbgbyx7fy6jZiLvmBx13917oA2fgcEmE9OAck3cW+TigLrssg1v/
 jJqezSxF0k8FB9DheT6oNNcnvC2gQ4ZJcIyH79s1Et6VyjZpDxcVPjrQGRRqwJIdCdp9
 /SX+fUHE4w/dV9+v6jjiJR3ux4L4aaSKSvHCWjleQT41BwXchPLYEV91kiU+BkGIEMgG
 Z0ki2FgFh2Dzf2h9lRmVExNo+ItpDBrOzr0sQFivgZIavr69Nhqay522osLyZgGd6sQ7 mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1j7m9sqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 07:04:33 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2156v1gR014609;
        Sat, 5 Feb 2022 07:04:33 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1j7m9sq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 07:04:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21573Xr1020343;
        Sat, 5 Feb 2022 07:04:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggj8vgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 07:04:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21574Rtg30802392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 07:04:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A12A52054;
        Sat,  5 Feb 2022 07:04:27 +0000 (GMT)
Received: from localhost (unknown [9.43.52.121])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 206DE52051;
        Sat,  5 Feb 2022 07:04:27 +0000 (GMT)
Date:   Sat, 05 Feb 2022 07:04:25 +0000
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH bpf-next v3 05/11] libbpf: Add PT_REGS_SYSCALL_REGS macro
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20220204145018.1983773-1-iii@linux.ibm.com>
        <20220204145018.1983773-6-iii@linux.ibm.com>
        <1643991537.bfyv1b2oym.naveen@linux.ibm.com>
        <CAEf4BzY5tVGsGNy_Z0apLbbJ3L22Ov6q6+XwZo0_jn2oJCpmFw@mail.gmail.com>
In-Reply-To: <CAEf4BzY5tVGsGNy_Z0apLbbJ3L22Ov6q6+XwZo0_jn2oJCpmFw@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1644044042.jx0r0wed12.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 07QX90WIwBhe2GkyX6mtI2ZYaSu5sEH0
X-Proofpoint-GUID: BzS-zI8NFR8qmn8QgSPFVdNz9Lo1fXY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_02,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202050046
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Fri, Feb 4, 2022 at 8:46 AM Naveen N. Rao
> <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>
>> Ilya Leoshkevich wrote:
>> > Some architectures pass a pointer to struct pt_regs to syscall
>> > handlers, others unpack it into individual function parameters.
>>
>> I think that is just dependent on ARCH_HAS_SYSCALL_WRAPPER, so only x86,
>> arm64 and s390 pass pointers to pt_regs to syscall entry points.
>>
>> > Introduce a macro to describe what a particular arch does, using
>> > `passing pt_regs *` as a default.
>> >
>> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> > ---
>> >  tools/lib/bpf/bpf_tracing.h | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>> > index 30f0964f8c9e..08d2990c006f 100644
>> > --- a/tools/lib/bpf/bpf_tracing.h
>> > +++ b/tools/lib/bpf/bpf_tracing.h
>> > @@ -334,6 +334,15 @@ struct pt_regs;
>> >
>> >  #endif /* defined(bpf_target_defined) */
>> >
>> > +/*
>> > + * When invoked from a syscall handler kprobe, returns a pointer to a
>> > + * struct pt_regs containing syscall arguments and suitable for passi=
ng to
>> > + * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().
>> > + */
>> > +#ifndef PT_REGS_SYSCALL_REGS
>> > +#define PT_REGS_SYSCALL_REGS(ctx) ((struct pt_regs *)PT_REGS_PARM1(ct=
x))
>> > +#endif
>> > +
>>
>> I think that name is misleading if an architecture doesn't implement sys=
call
>> wrappers, since you are simply getting access to the kprobe pt_regs, rat=
her
>> than the syscall pt_regs. This can perhaps be named PT_REGS_SYSCALL_UNWR=
AP() or
>> such to make that clear.
>=20
> UNWRAP implies that there is something to unwrap, always. In case of
> s390x, for example, there is nothing to unwrap. So I think
> PT_REGS_SYSCALL_REGS() makes more sense, it just fetches correct
> pt_regs to work with to get syscall input arguments (and it might be
> exactly the same pt_regs that are passed in).
>=20
> I think in practice most users won't ever have to use this, as we'll
> add BPF_KPROBE_SYSCALL() macro, similar to BPF_KPROBE that we have
> now, but specific to syscall kprobe.

That will be very nice.

>=20
>>
>> Also, should this just be keyed off a simpler HAS_SYSCALL_WRAPPER or suc=
h,
>> rather than the other way around?
>=20
> I think the way Ilya did it is totally fine.
>=20
>>
>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>> index 032ba809f3e57a..c72f285578d3fc 100644
>> --- a/tools/lib/bpf/bpf_tracing.h
>> +++ b/tools/lib/bpf/bpf_tracing.h
>> @@ -110,6 +110,8 @@
>>
>>  #endif /* __i386__ */
>>
>> +#define HAS_SYSCALL_WRAPPER
>> +
>>  #endif /* __KERNEL__ || __VMLINUX_H__ */
>>
>>  #elif defined(bpf_target_s390)
>> @@ -126,6 +128,7 @@
>>  #define __PT_RC_REG gprs[2]
>>  #define __PT_SP_REG gprs[15]
>>  #define __PT_IP_REG psw.addr
>> +#define HAS_SYSCALL_WRAPPER
>>
>>  #elif defined(bpf_target_arm)
>>
>> @@ -154,6 +157,7 @@
>>  #define __PT_RC_REG regs[0]
>>  #define __PT_SP_REG sp
>>  #define __PT_IP_REG pc
>> +#define HAS_SYSCALL_WRAPPER
>>
>>  #elif defined(bpf_target_mips)
>>
>>
>> We can then simply do:
>>
>> #ifdef HAS_SYSCALL_WRAPPER
>> #define PT_REGS_SYSCALL_UNWRAP(ctx) ((struct pt_regs *)PT_REGS_PARM1(ctx=
))
>> #else
>> #define PT_REGS_SYSCALL_unwRAP(ctx) ((struct pt_regs *)(ctx))
>> #endif
>>
>>
>> Taking this a bit further, it would be nice if we can fold in progs/bpf_=
misc.h
>> into bpf_traching.h by also including SYS_PREFIX.
>=20
> As far as I know, SYS_PREFIX depends not just on architecture but also
> on kernel version (older versions of x86-64 kernels didn't need that
> prefix). For selftests, given they follow the latest version of kernel
> it's ok to always append SYS_PREFIX, but generally speaking for user
> BPF apps, they would need to be more careful and check whether they
> need SYS_PREFIX or not. So I don't want to add SYS_PREFIX to
> bpf_tracing.h because it's misleading.

That makes sense, thanks.


- Naveen

