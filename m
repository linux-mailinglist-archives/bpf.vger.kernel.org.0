Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01874A9D21
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 17:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376653AbiBDQrJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 11:47:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242805AbiBDQrI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 11:47:08 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214ETq0c016005;
        Fri, 4 Feb 2022 16:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=cQpRXPbqcV6Amd+PW0WDOnGwkTtZSc4vZZYlaVZ5u10=;
 b=XDAiZW2sASsoMOpnL0wd5PoxeDbH0wxwuJ5Dsji3dDzSKdMI5+h+pcwHikG0OPoDK7+c
 Wv3FDayFcrslL9hSx1DvIegV3Vsk0BOjdVXRKjPBp6QJg9Zq8ukLuQtxWl5GkaZB70LZ
 J3v2HgjeHTbjrA5YKUhMCLqs26EgQajW7vFoN3qWm7Vlm2UbUTzSOj6Fkzm/omjYR+iO
 +z7mqB/UJRAIomkrt3uxm8kYFSyFRAvpusK+JwVUfONcrR3iTJae+N+b94MwgFAeZgK1
 WebE2tMYg6/sSJAjevbCNbmR6i10lJuR/Pd7/DUbDI1Bd4+MrgY3YyIciybA6OkJgRok Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0rt5gktn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 16:46:49 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214Gbol5026093;
        Fri, 4 Feb 2022 16:46:49 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0rt5gkt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 16:46:49 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214GXOJB018700;
        Fri, 4 Feb 2022 16:46:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3e0r0u6njr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 16:46:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214GkhPP46531020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 16:46:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17A10A4060;
        Fri,  4 Feb 2022 16:46:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0343A405F;
        Fri,  4 Feb 2022 16:46:42 +0000 (GMT)
Received: from localhost (unknown [9.43.69.119])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 16:46:42 +0000 (GMT)
Date:   Fri, 04 Feb 2022 16:46:40 +0000
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH bpf-next v3 05/11] libbpf: Add PT_REGS_SYSCALL_REGS macro
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     bpf@vger.kernel.org
References: <20220204145018.1983773-1-iii@linux.ibm.com>
        <20220204145018.1983773-6-iii@linux.ibm.com>
In-Reply-To: <20220204145018.1983773-6-iii@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1643991537.bfyv1b2oym.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _a1d6PFGsLwwtERUN-HeOV3TLlOhnZsf
X-Proofpoint-ORIG-GUID: QKL-wsS83GZwe0zYML6MHZ5LP2G4O8R6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040094
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich wrote:
> Some architectures pass a pointer to struct pt_regs to syscall
> handlers, others unpack it into individual function parameters.

I think that is just dependent on ARCH_HAS_SYSCALL_WRAPPER, so only x86,=20
arm64 and s390 pass pointers to pt_regs to syscall entry points.

> Introduce a macro to describe what a particular arch does, using
> `passing pt_regs *` as a default.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 30f0964f8c9e..08d2990c006f 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -334,6 +334,15 @@ struct pt_regs;
>=20
>  #endif /* defined(bpf_target_defined) */
>=20
> +/*
> + * When invoked from a syscall handler kprobe, returns a pointer to a
> + * struct pt_regs containing syscall arguments and suitable for passing =
to
> + * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().
> + */
> +#ifndef PT_REGS_SYSCALL_REGS
> +#define PT_REGS_SYSCALL_REGS(ctx) ((struct pt_regs *)PT_REGS_PARM1(ctx))
> +#endif
> +

I think that name is misleading if an architecture doesn't implement syscal=
l=20
wrappers, since you are simply getting access to the kprobe pt_regs, rather=
=20
than the syscall pt_regs. This can perhaps be named PT_REGS_SYSCALL_UNWRAP(=
) or=20
such to make that clear.

Also, should this just be keyed off a simpler HAS_SYSCALL_WRAPPER or such,=20
rather than the other way around?

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 032ba809f3e57a..c72f285578d3fc 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -110,6 +110,8 @@
=20
 #endif /* __i386__ */
=20
+#define HAS_SYSCALL_WRAPPER
+
 #endif /* __KERNEL__ || __VMLINUX_H__ */
=20
 #elif defined(bpf_target_s390)
@@ -126,6 +128,7 @@
 #define __PT_RC_REG gprs[2]
 #define __PT_SP_REG gprs[15]
 #define __PT_IP_REG psw.addr
+#define HAS_SYSCALL_WRAPPER
=20
 #elif defined(bpf_target_arm)
=20
@@ -154,6 +157,7 @@
 #define __PT_RC_REG regs[0]
 #define __PT_SP_REG sp
 #define __PT_IP_REG pc
+#define HAS_SYSCALL_WRAPPER
=20
 #elif defined(bpf_target_mips)
=20

We can then simply do:

#ifdef HAS_SYSCALL_WRAPPER
#define PT_REGS_SYSCALL_UNWRAP(ctx) ((struct pt_regs *)PT_REGS_PARM1(ctx))
#else
#define PT_REGS_SYSCALL_unwRAP(ctx) ((struct pt_regs *)(ctx))
#endif


Taking this a bit further, it would be nice if we can fold in progs/bpf_mis=
c.h=20
into bpf_traching.h by also including SYS_PREFIX.


- Naveen

