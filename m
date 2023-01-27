Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6972567E286
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 12:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjA0LBq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 06:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjA0LBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 06:01:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE822525E
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 03:01:40 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RA2QTp030227;
        Fri, 27 Jan 2023 11:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Rx0/G0jl8hcbW8of0PsFQ1pEXcqGNWEmvP+2Djcwl1o=;
 b=WDT+zJhoOuKY1NsxiJTX+z3v0Q60dOrr56NdKUIi4PWcXimvAhIHlw7hWLAm61F8GKps
 krSAoOZdnhmg6jBlWOpf8Nmg2TjYVj3K80G0Se6TzHVvuu3vMiaMW8byU1P6a6RqOJE0
 SvbGEzopAeFMGN0rdu9AwJFPexlXr5190iZuHxdvATDNE+4OcW1LT3Xvt3x02+/38mHH
 3a1wqLGzfP4Uk/STtAacxA9sY0KWV7VI0XyI6L9E1EFqgk9dJSsLSSL4X2xGv7tvsYL0
 q+KsuNXxd9luGiLCdtnBnyihW/WUtAPeD6gbaquQqwqu0z0wG0EvRJjCOVBOZQ+7UT4N iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nccgv183y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:01:24 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RAx2Pv024021;
        Fri, 27 Jan 2023 11:01:24 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nccgv183d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:01:24 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QM6X3Z008086;
        Fri, 27 Jan 2023 11:01:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dajm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:01:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RB1IYD48038336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 11:01:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0C5220040;
        Fri, 27 Jan 2023 11:01:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5417D20043;
        Fri, 27 Jan 2023 11:01:18 +0000 (GMT)
Received: from [9.179.11.57] (unknown [9.179.11.57])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 11:01:18 +0000 (GMT)
Message-ID: <37b2889c5284a02ecf3de84b07efa3219584252b.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 17/24] libbpf: Read usdt arg spec with
 bpf_probe_read_kernel()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Fri, 27 Jan 2023 12:01:17 +0100
In-Reply-To: <CAEf4BzYcGSnmXVr52KcqtJrid6moyFqSL0R86S6LTiuvnQK9_g@mail.gmail.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
         <20230125213817.1424447-18-iii@linux.ibm.com>
         <CAEf4BzamdUMpNeryWa2gGP6KB8uTs5sZTNnU3kMkvJFdchNRiw@mail.gmail.com>
         <cd145e29fc2cf9c4772fd61eb2921b2784d983fd.camel@linux.ibm.com>
         <CAEf4BzYcGSnmXVr52KcqtJrid6moyFqSL0R86S6LTiuvnQK9_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b_hmeEpxe7dTARsmJPItS34A1IvjBLcs
X-Proofpoint-ORIG-GUID: 0p_rjFbkIAdUke5JqL-biS053_e7ByEl
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-01-26 at 11:03 -0800, Andrii Nakryiko wrote:
> On Thu, Jan 26, 2023 at 3:41 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > On Wed, 2023-01-25 at 16:26 -0800, Andrii Nakryiko wrote:
> > > On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > >=20
> > > > Loading programs that use bpf_usdt_arg() on s390x fails with:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 ; switch (arg_spec->arg_type) {
> > > > =C2=A0=C2=A0=C2=A0 139: (61) r1 =3D *(u32 *)(r2 +8)
> > > > =C2=A0=C2=A0=C2=A0 R2 unbounded memory access, make sure to bounds =
check any
> > > > such
> > > > access
> > >=20
> > > can you show a bit longer log? we shouldn't just=C2=A0 use
> > > bpf_probe_read_kernel for this. I suspect strategically placed
> > > barrier_var() calls will solve this. This is usually an issue
> > > with
> > > compiler reordering operations and doing actual check after it
> > > already
> > > speculatively adjusted pointer (which is technically safe and ok
> > > if
> > > we
> > > never deref that pointer, but verifier doesn't recognize such
> > > pattern)
> >=20
> > The full log is here:
> >=20
> > https://gist.github.com/iii-i/b6149ee99b37078ec920ab1d3bb45134

[...]

> > --- a/tools/lib/bpf/usdt.bpf.h
> > +++ b/tools/lib/bpf/usdt.bpf.h
> > @@ -130,7 +130,10 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64
> > arg_num, long *res)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!spec)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ESRCH;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg_num >=3D BPF_USDT_MAX_ARG=
_CNT || arg_num >=3D spec-
> > > arg_cnt)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg_num >=3D BPF_USDT_MAX_ARG=
_CNT)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -ENOENT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 barrier_var(arg_num);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg_num >=3D spec->arg_cnt)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg_spec =3D &spec->args[arg=
_num];
> >=20
> > I can use this in v2 if it looks good.
>=20
> arg_num -> spec->arg_cnt is "real" check, arg_num >=3D
> BPF_USDT_MAX_ARG_CNT is more to satisfy verifier (we know that
> spec->arg_cnt won't be >=3D BPF_USDT_MAX_ARG_CNT). Let's swap two
> checks
> in order and keep BPF_USDT_MAX_ARG_CNT close to spec->args[arg_num]
> use? And if barrier_var() is necessary, then so be it.

Unfortunately just swapping did not help, so let's use the barrier.

> > Btw, I looked at the barrier_var() definition:
> >=20
> > #define barrier_var(var) asm volatile("" : "=3Dr"(var) : "0"(var))
> >=20
> > and I'm curious why it's not defined like this:
> >=20
> > #define barrier_var(var) asm volatile("" : "+r"(var))
> >=20
> > which is a bit simpler?
> > >=20
>=20
> no reason, just unfamiliarity with embedded asm back then, we can
> update it we they are equivalent

Thanks! I will add a simplification in v2 then.
