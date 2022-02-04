Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC54A9CBA
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 17:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355483AbiBDQQ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 11:16:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234695AbiBDQQ1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 11:16:27 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214FiCXi016615;
        Fri, 4 Feb 2022 16:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=jxN8wZhtrM8/+tSWW1NhChdAckIHPszHALMUGv3e/xI=;
 b=cUSAEBNhUVoRdkhzZ48RRayXws0KjaBw4Upbif4V3nZB6N16vRs+jZhLs9btUOw2Dkw5
 muc6nm1aGwkorNKrelKTe/YhsmLwRjV4aoAnGoanVfdEd/509wHSQjHsXO5xlMFp0hUH
 KnGYrkaF9oQpRk3jt3oqLwk1gQ+2ERuUmOdIk2N4UMNn5FgI+Y0Wl1yy7AfsaabBXiSs
 yBt1s9W2/rda9wKCAfOdZAg/3Iz8g1zqFFsH2wCP8C/3ceRJ+ykWjsRZXGUaenIxel7g
 K728nHuLIrOikH6crBvPhiR09RMonp/Jstvf1Olf0h3dH4x+dFxMSuRfLahEx/6KYSYN xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx3a0n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 16:16:07 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214FlcQY031505;
        Fri, 4 Feb 2022 16:16:06 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx3a0m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 16:16:06 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214GDGnS025980;
        Fri, 4 Feb 2022 16:16:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3e0r0v656r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 16:16:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214GFweI44040588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 16:15:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9B534C052;
        Fri,  4 Feb 2022 16:15:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 697BA4C044;
        Fri,  4 Feb 2022 16:15:58 +0000 (GMT)
Received: from localhost (unknown [9.43.69.119])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 16:15:58 +0000 (GMT)
Date:   Fri, 04 Feb 2022 16:15:56 +0000
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH bpf-next v3 04/11] libbpf: Add __PT_PARM1_REG_SYSCALL
 macro
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
        <20220204145018.1983773-5-iii@linux.ibm.com>
In-Reply-To: <20220204145018.1983773-5-iii@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1643990954.fs9q9mrdxt.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U0CXSGKxQIntdVu6gAmB-nkHSaoAGQ1m
X-Proofpoint-GUID: 96LH4deMfbUNDYKwvMZOcXX-r6vgi_2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040092
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich wrote:
> Some architectures have a special way to access the first syscall
> argument. There already exists __PT_PARM4_REG_SYSCALL for the
> fourth argument, so define a similar macro for the first one.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 032ba809f3e5..30f0964f8c9e 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -265,7 +265,11 @@ struct pt_regs;
>=20
>  #endif
>=20
> +#ifdef __PT_PARM1_REG_SYSCALL
> +#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM1_REG_SYSC=
ALL)
> +#else /* __PT_PARM1_REG_SYSCALL */
>  #define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> +#endif
>  #define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
>  #define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
>  #ifdef __PT_PARM4_REG_SYSCALL
> @@ -275,7 +279,11 @@ struct pt_regs;
>  #endif
>  #define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
>=20
> +#ifdef __PT_PARM1_REG_SYSCALL
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), _=
_PT_PARM1_REG_SYSCALL)
> +#else /* __PT_PARM1_REG_SYSCALL */
>  #define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> +#endif
>  #define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
>  #define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
>  #ifdef __PT_PARM4_REG_SYSCALL

When I was contemplating implementing this for powerpc, I came up with=20
the below patch which looked cleaner to me, and also makes it easy for=20
architectures to over-ride any other syscall parameter in future. Feel=20
free to include this in your series if it makes sense.

- Naveen

--
libbpf: Generalize overriding syscall parameter access macros

Instead of conditionally overriding PT_REGS_PARM4_SYSCALL, provide
default fallback for all _REG_SYSCALL macros so that architectures can
simply override a specific syscall parameter macro.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 40 ++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 032ba809f3e57a..2e2f057c7ec7c5 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -265,25 +265,33 @@ struct pt_regs;
=20
 #endif
=20
-#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
-#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
-#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
-#ifdef __PT_PARM4_REG_SYSCALL
-#define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCAL=
L)
-#else /* __PT_PARM4_REG_SYSCALL */
-#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
+#ifndef __PT_PARM1_REG_SYSCALL
+#define __PT_PARM1_REG_SYSCALL __PT_PARM1_REG
+#endif
+#ifndef __PT_PARM2_REG_SYSCALL
+#define __PT_PARM2_REG_SYSCALL __PT_PARM2_REG
+#endif
+#ifndef __PT_PARM3_REG_SYSCALL
+#define __PT_PARM3_REG_SYSCALL __PT_PARM3_REG
+#endif
+#ifndef __PT_PARM4_REG_SYSCALL
+#define __PT_PARM4_REG_SYSCALL __PT_PARM4_REG
 #endif
-#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
+#ifndef __PT_PARM5_REG_SYSCALL
+#define __PT_PARM5_REG_SYSCALL __PT_PARM5_REG
+#endif
+
+#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM1_REG_SYSCAL=
L)
+#define PT_REGS_PARM2_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM2_REG_SYSCAL=
L)
+#define PT_REGS_PARM3_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM3_REG_SYSCAL=
L)
+#define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCAL=
L)
+#define PT_REGS_PARM5_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM5_REG_SYSCAL=
L)
=20
-#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
-#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
-#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
-#ifdef __PT_PARM4_REG_SYSCALL
+#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __P=
T_PARM1_REG_SYSCALL)
+#define PT_REGS_PARM2_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __P=
T_PARM2_REG_SYSCALL)
+#define PT_REGS_PARM3_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __P=
T_PARM3_REG_SYSCALL)
 #define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __P=
T_PARM4_REG_SYSCALL)
-#else /* __PT_PARM4_REG_SYSCALL */
-#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
-#endif
-#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
+#define PT_REGS_PARM5_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __P=
T_PARM5_REG_SYSCALL)
=20
 #else /* defined(bpf_target_defined) */
=20
--=20
2.34.1


