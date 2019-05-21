Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF204257EC
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfEUTBa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 15:01:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60860 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfEUTB3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 15:01:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LIwgpi118045;
        Tue, 21 May 2019 19:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nbssqjzdx8F8t5grL3rZrf1D2IuTtTMosqH7OnXoYcE=;
 b=EsJXHEhVeECbPxFgKG5LIwyC+R0N666gjmFT8AzcD0jOIlmhoKXfRId3cTdxyXlMWRLZ
 eG5+D9DzFLKDp1qIXupcaYrBCU6+Hj5bYMoSoBx9ELjlOWo+DkFoYUClh+FpIVPWQcal
 IVMkBCBhqGo17HDG+iTYVtwxHhlLZ73fySJmJR/ksCcMAy5+qY9Tz45N9Z5jWITM9GPJ
 Jxj815iHlH0OagwbisdzLX5LfCmHCkCt4XFScJJaZZqUpKb/HuxgO0Vz4zDp/TpIl2Hf
 gSNCukm4r0XEZMgdHY1Ud422zFsK4vVhW+NX1OVVFgMgUm2J5WnuyArSa0V0Q5njGIZ9 WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2sjapqfcgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 19:00:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LIw56Y115820;
        Tue, 21 May 2019 18:58:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sm04755vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 18:58:56 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4LIwsBX024715;
        Tue, 21 May 2019 18:58:54 GMT
Received: from termi.oracle.com (/77.182.16.85)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 18:58:53 +0000
From:   jose.marchesi@oracle.com (Jose E. Marchesi)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Edward Cree <ecree@solarflare.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, binutils@sourceware.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
References: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
        <CAADnVQJcfnEh4_ok1o9oWNiaBAdd-2XHiguu1FvPZdnAuXuWBg@mail.gmail.com>
Date:   Tue, 21 May 2019 20:58:43 +0200
In-Reply-To: <CAADnVQJcfnEh4_ok1o9oWNiaBAdd-2XHiguu1FvPZdnAuXuWBg@mail.gmail.com>
        (Alexei Starovoitov's message of "Tue, 21 May 2019 11:18:23 -0700")
Message-ID: <87ftp7my70.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210116
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210117
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Alexey.

    > > Despite using a different syntax for the assembler (the llvm assemb=
ler
    > > uses a C-ish expression-based syntax while the GNU assembler opts f=
or
    > > a more classic assembly-language syntax) this implementation tries =
to
    > > provide inter-operability with clang/llvm generated objects.
    >
    > I also noticed your implementation doesn=E2=80=99t seem to use the sa=
me sub-register
    > syntax as what LLVM assembler is doing.
    >
    >   x register for 64-bit, and w register for 32-bit sub-register.
    >
    > So:
    >   add r0, r1, r2 means BPF_ALU64 | BPF_ADD | BFF_X
    >   add w0, w1, w1 means BPF_ALU | BPF_ADD | BPF_X
    >
    > ASAICT, different register prefix for different register width is als=
o adopted
    > by quite a few other GNU assembler targets like AArch64, X86_64.
=20=20=20=20
    there is also Ed's assembler:
    https://github.com/solarflarecom/ebpf_asm

Oh interesting, didn't know about it.

    It uses 2 ops style.
    I think 3 ops style "add r0,r1,r2" is not a good fit for bpf isa.

I agree.  My port uses two-operand formats for most instructions,
including arithmetic instructions.  Examples:

sub %r2, 666
sub %r3, -666
sub %r4, 0x7eadbeef
sub %r5, %r6
=20=20=20=20
    I think we need to converge on one asm syntax for gas/bfd.
    At this point we cannot change llvm's asm output,
    so my preference would be to make gas accept it.
    But I understand the implementation difficulties to fit it into bfd inf=
ra.
    So I'm ok with more traditional asm the way Dave implemented it few
    years back.
    One asm syntax for gas and another asm syntax for clang is, imo, accept=
able.
=20=20=20=20
    Jose, can you combine Dave's patches with yours?

As far as I can see my port uses basically the same syntax than Dave's.

The only significant difference is that mine uses a % prefix for
register names.  I prefer it this way in order to avoid collisions with
symbols.
=20=20=20=20
    I think Ed had an idea on how to specify BTF in asm syntax.
    BTF has to be supported by the assembler as well
    along with .btf.ext, lineinfo, etc
    Currently llvm emits btf as '.byte 0x...', but that's far from ideal.

I haven't looked into BTF yet, but it would be certainly good, for
everyone to use the same directives to support it :)
