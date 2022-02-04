Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F884A9A4E
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 14:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359015AbiBDNuZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 08:50:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235063AbiBDNuY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 08:50:24 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214D1UW9017419;
        Fri, 4 Feb 2022 13:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZX/Icao0H9j1c9MCBbqCARcaWhtzyaSl8/cxqAyOJhk=;
 b=byjrAbigWdVKPryIeBo4zzTDEwMXwbv268laRoisxjbA8WDRx9MKmE0EbpL6U5VhFeqk
 XYCxo8Q2D46zNX4nFboi2rTkuPeiU4/C37U4ugEdORpe2Sy2iv7G3WBisfQokwDJmmQK
 dQXmwdMsz3mbhjE5cSlWy4Yi+3JoSSzjNVNFBpw9fFfeoGuVoZmykoVGdCYBXvXOx8EU
 vo8I8V4VnhYYjmX6PLov6tBsUu0keEPTERyW9hXRzkD7plyJkYwWmfpjjAhu1Z8FvfQS
 BvBaedE0TLBmfQSgQ4ocjdOK3ilsBc1JCPn1fgZA5/RGxBbeROSRS1EDzqnAMBI1lp5f og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx36p8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 13:50:04 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214Cm8n2004717;
        Fri, 4 Feb 2022 13:50:03 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx36p7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 13:50:03 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214DhTXG029005;
        Fri, 4 Feb 2022 13:50:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3e0r0yd1yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 13:50:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214Dntjr46924216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 13:49:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B4BB42049;
        Fri,  4 Feb 2022 13:49:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBC9F42041;
        Fri,  4 Feb 2022 13:49:54 +0000 (GMT)
Received: from localhost (unknown [9.43.69.119])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 13:49:54 +0000 (GMT)
Date:   Fri, 04 Feb 2022 13:49:52 +0000
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH bpf-next 1/3] s390/bpf: Add orig_gpr2 to user_pt_regs
To:     Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        =?iso-8859-1?b?Qmr2cm4gVPZwZWw=?= <bjorn@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        bpf@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
References: <20220201234200.1836443-1-iii@linux.ibm.com>
        <20220201234200.1836443-2-iii@linux.ibm.com> <YfrmO+pcSqrrbC3E@osiris>
        <1643952491.peuih6eln6.naveen@linux.ibm.com>
        <1643962017.hhlhw119x7.naveen@linux.ibm.com>
        <80a92fcc73e537b56491f8313574bea6dfa1c1c8.camel@linux.ibm.com>
In-Reply-To: <80a92fcc73e537b56491f8313574bea6dfa1c1c8.camel@linux.ibm.com>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1643982436.03nza6qz50.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oGSB1_DMBhbsXR8vW7IIdm0IwgW40ytd
X-Proofpoint-GUID: CXsegPChd5iOMHgJH6h1KzBR2OeZfk2n
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040076
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich wrote:
> On Fri, 2022-02-04 at 08:21 +0000, Naveen N. Rao wrote:
>> Naveen N. Rao wrote:
>> > Hi Heiko,
>> >=20
>> > Heiko Carstens wrote:
>> > > On Wed, Feb 02, 2022 at 12:41:58AM +0100, Ilya Leoshkevich wrote:
>> > > > user_pt_regs is used by eBPF in order to access userspace
>> > > > registers -
>> > > > see commit 466698e654e8 ("s390/bpf: correct broken uapi for
>> > > > BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the
>> > > > first
>> > > > syscall argument from eBPF programs, we need to export
>> > > > orig_gpr2.
>> > > >=20
>> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> > > > ---
>> > > > =C2=A0arch/s390/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 2 +-
>> > > > =C2=A0arch/s390/include/uapi/asm/ptrace.h | 1 +
>> > > > =C2=A02 files changed, 2 insertions(+), 1 deletion(-)
>> > > >=20
>> > > > diff --git a/arch/s390/include/asm/ptrace.h
>> > > > b/arch/s390/include/asm/ptrace.h
>> > > > index 4ffa8e7f0ed3..c8698e643904 100644
>> > > > --- a/arch/s390/include/asm/ptrace.h
>> > > > +++ b/arch/s390/include/asm/ptrace.h
>> > > > @@ -83,9 +83,9 @@ struct pt_regs {
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0unsigned long args[1];
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0psw_t psw;
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0unsigned long gprs[NUM_GPRS];
>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
unsigned long orig_gpr2;
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
>> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long orig_gpr2;
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0union {
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0unsigned int int_code;
>> > > > diff --git a/arch/s390/include/uapi/asm/ptrace.h
>> > > > b/arch/s390/include/uapi/asm/ptrace.h
>> > > > index ad64d673b5e6..b3dec603f507 100644
>> > > > --- a/arch/s390/include/uapi/asm/ptrace.h
>> > > > +++ b/arch/s390/include/uapi/asm/ptrace.h
>> > > > @@ -295,6 +295,7 @@ typedef struct {
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long args=
[1];
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psw_t psw;
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long gprs=
[NUM_GPRS];
>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long orig_gpr2;
>> > > > =C2=A0} user_pt_regs;
>> > >=20
>> > > Isn't this broken on nearly all architectures? I just checked
>> > > powerpc,
>> > > arm64, and riscv. While powerpc seems to mirror pt_regs as
>> > > user_pt_regs,
>> > > and therefore exports orig_gpr3, the bpf macros still seem to
>> > > access the
>> > > wrong location to access the first syscall parameter(?).
>> >=20
>> > On powerpc, gpr[3] continues to be valid on syscall entry (so this
>> > test=20
>> > passes on powerpc), though orig_gpr3 will remain valid throughout.
>>=20
>> Hmm.. we can't use orig_gpr3 since we don't use a syscall wrapper.
>> All=20
>> system calls just receive the parameters directly.
>>=20
>> - Naveen
>=20
> Right, I ran into this yesterday as well.
> I solved it in v2
> (https://lore.kernel.org/bpf/20220204041955.1958263-1-iii@linux.ibm.com/)
> by introducing a macro that hides whether or not an arch uses a syscall
> wrapper.

Thanks. I missed your patches. I will take a look.

- Naveen
>=20
