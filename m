Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC567CA2E
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbjAZLmE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 06:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjAZLmD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 06:42:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86AD3401E
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 03:42:02 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QBMIr8000317;
        Thu, 26 Jan 2023 11:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vKnQEbUmxXllFL576a0h5gfuJB/XWExl8ktynr58BW4=;
 b=HLuXzFde6EJqh1MHKB+K3V3AHHQukugMKTruyDMD0Tna/lphWuDj897A9QeAmzr7WWLC
 nkw1PM5yXN+D9qs2ZNJF78vHgF3RoOXkcVd4w2s9pJLo1aEKBpN46u7pcrvPu1egOqcF
 IgTP3OKXnanCbtZ0p6yzO7hM8ht1tFA0QSUjCMJZ0S+xLauTH7hTMW0I+qh+UVJ7fAhD
 HQjtNQknOyX0TyIuXYpKbsGN7QvOfuh18PvWp4goUkou18zkhUhZxMvTxE8qU11Vqwkf
 sfCtUGlzFNspoSvpIdpMkppc6cK2vqootKRN71CuI/w4TXjkizvaJHiwAPS+QvPpWCHY Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbrka0dp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 11:41:47 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QBZPWk019377;
        Thu, 26 Jan 2023 11:41:46 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbrka0dnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 11:41:46 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEpd9Z016036;
        Thu, 26 Jan 2023 11:41:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n87p6chd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 11:41:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QBffSI47120818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 11:41:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C4472004F;
        Thu, 26 Jan 2023 11:41:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4A2520040;
        Thu, 26 Jan 2023 11:41:40 +0000 (GMT)
Received: from [9.155.209.149] (unknown [9.155.209.149])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 11:41:40 +0000 (GMT)
Message-ID: <cd145e29fc2cf9c4772fd61eb2921b2784d983fd.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 17/24] libbpf: Read usdt arg spec with
 bpf_probe_read_kernel()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 26 Jan 2023 12:41:40 +0100
In-Reply-To: <CAEf4BzamdUMpNeryWa2gGP6KB8uTs5sZTNnU3kMkvJFdchNRiw@mail.gmail.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
         <20230125213817.1424447-18-iii@linux.ibm.com>
         <CAEf4BzamdUMpNeryWa2gGP6KB8uTs5sZTNnU3kMkvJFdchNRiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 77HnJf3HEfobI4AwWvha5L77JDOZsnBd
X-Proofpoint-GUID: P70uZUG6PmsS_G9PY47JE3WURPQmkwnF
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_04,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-01-25 at 16:26 -0800, Andrii Nakryiko wrote:
> On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > Loading programs that use bpf_usdt_arg() on s390x fails with:
> >=20
> > =C2=A0=C2=A0=C2=A0 ; switch (arg_spec->arg_type) {
> > =C2=A0=C2=A0=C2=A0 139: (61) r1 =3D *(u32 *)(r2 +8)
> > =C2=A0=C2=A0=C2=A0 R2 unbounded memory access, make sure to bounds chec=
k any such
> > access
>=20
> can you show a bit longer log? we shouldn't just=C2=A0 use
> bpf_probe_read_kernel for this. I suspect strategically placed
> barrier_var() calls will solve this. This is usually an issue with
> compiler reordering operations and doing actual check after it
> already
> speculatively adjusted pointer (which is technically safe and ok if
> we
> never deref that pointer, but verifier doesn't recognize such
> pattern)

The full log is here:

https://gist.github.com/iii-i/b6149ee99b37078ec920ab1d3bb45134

The relevant part seems to be:

; if (arg_num >=3D BPF_USDT_MAX_ARG_CNT || arg_num >=3D spec->arg_cnt)
128: (79) r1 =3D *(u64 *)(r10 -24)      ; frame1:
R1_w=3Dscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
129: (25) if r1 > 0xb goto pc+83      ; frame1:
R1_w=3Dscalar(umax=3D11,var_off=3D(0x0; 0xf))
; if (arg_num >=3D BPF_USDT_MAX_ARG_CNT || arg_num >=3D spec->arg_cnt)
130: (69) r1 =3D *(u16 *)(r8 +200)      ; frame1:
R1_w=3Dscalar(umax=3D65535,var_off=3D(0x0; 0xffff))
R8_w=3Dmap_value(off=3D0,ks=3D4,vs=3D208,imm=3D0)
131: (67) r1 <<=3D 48                   ; frame1:
R1_w=3Dscalar(smax=3D9223090561878065152,umax=3D18446462598732840960,var_of=
f=3D
(0x0; 0xffff000000000000),s32_min=3D0,s32_max=3D0,u32_max=3D0)
132: (c7) r1 s>>=3D 48                  ; frame1: R1_w=3Dscalar(smin=3D-
32768,smax=3D32767)
; if (arg_num >=3D BPF_USDT_MAX_ARG_CNT || arg_num >=3D spec->arg_cnt)
133: (79) r2 =3D *(u64 *)(r10 -24)      ; frame1:
R2=3Dscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
134: (bd) if r1 <=3D r2 goto pc+78      ; frame1: R1=3Dscalar(smin=3D-
32768,smax=3D32767) R2=3Dscalar(umax=3D4294967295,var_off=3D(0x0; 0xfffffff=
f))
; arg_spec =3D &spec->args[arg_num];
135: (79) r1 =3D *(u64 *)(r10 -24)      ; frame1:
R1_w=3Dscalar(umax=3D4294967295,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
136: (67) r1 <<=3D 4                    ; frame1:
R1_w=3Dscalar(umax=3D68719476720,var_off=3D(0x0;
0xffffffff0),s32_max=3D2147483632,u32_max=3D-16)
137: (bf) r2 =3D r8                     ; frame1:
R2_w=3Dmap_value(off=3D0,ks=3D4,vs=3D208,imm=3D0)
R8=3Dmap_value(off=3D0,ks=3D4,vs=3D208,imm=3D0)
138: (0f) r2 +=3D r1                    ; frame1:
R1_w=3Dscalar(umax=3D68719476720,var_off=3D(0x0;
0xffffffff0),s32_max=3D2147483632,u32_max=3D-16)
R2_w=3Dmap_value(off=3D0,ks=3D4,vs=3D208,umax=3D68719476720,var_off=3D(0x0;
0xffffffff0),s32_max=3D2147483632,u32_max=3D-16)
; switch (arg_spec->arg_type) {
139: (61) r1 =3D *(u32 *)(r2 +8)

#128-#129 make sure that *(u64 *)(r10 -24) <=3D 11, but when #133
loads it again, this constraint is not there. I guess we need to
force flushing r1 to stack? The following helps:

--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -130,7 +130,10 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64
arg_num, long *res)
        if (!spec)
                return -ESRCH;
=20
-       if (arg_num >=3D BPF_USDT_MAX_ARG_CNT || arg_num >=3D spec-
>arg_cnt)
+       if (arg_num >=3D BPF_USDT_MAX_ARG_CNT)
+               return -ENOENT;
+       barrier_var(arg_num);
+       if (arg_num >=3D spec->arg_cnt)
                return -ENOENT;
=20
        arg_spec =3D &spec->args[arg_num];

I can use this in v2 if it looks good.



Btw, I looked at the barrier_var() definition:

#define barrier_var(var) asm volatile("" : "=3Dr"(var) : "0"(var))

and I'm curious why it's not defined like this:

#define barrier_var(var) asm volatile("" : "+r"(var))

which is a bit simpler?
>=20
