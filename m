Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40572580E
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 21:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEUTN6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 15:13:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33942 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfEUTN6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 15:13:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LJDZXA118380;
        Tue, 21 May 2019 19:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Qes9g+HcLw4dkNDva1fec77F7FL6YdVXwoNGFuUHV1c=;
 b=Hx3Q4Vef+SZ2WFMAL/3doJSvtfIHAqLf3uE3ZxTtk8FOduRZOXrN/CnuUS14XsRI2abT
 tTiQBkuEzHkA0JcGzt50d/Ok3bag66cKs7bApmLVLOhfbBITxC4Ezpk7f0E6ZgnlEmjk
 IbnIiLWWYtm842bT12KdouTcGef4euSv8rd22o089P8sZQmd7N1IjNKoc6tEZQ7Dq4S2
 l7OMqQ3TLy2qteaJUu02ll0PpCG6itzxSN6mj3So/FTOOZOCUgX4PnGn0FATEleeMYNc
 KmPskfaSKWl3DUBwAOXkLSs7jwOTKQqtXZFdvQYhTRIuualcOGr6KEQRWJf+rxfBdeIo yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sj9ftfkm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 19:13:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LJDVKQ135269;
        Tue, 21 May 2019 19:13:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2sks1ycjx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 19:13:31 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4LJDQqN030952;
        Tue, 21 May 2019 19:13:26 GMT
Received: from termi.oracle.com (/10.175.26.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 19:13:25 +0000
From:   jose.marchesi@oracle.com (Jose E. Marchesi)
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     binutils@sourceware.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
References: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
        <87d0kbrb3m.fsf@oracle.com>
        <768B654F-A66B-4CCE-9320-D096538B23F2@netronome.com>
Date:   Tue, 21 May 2019 21:13:15 +0200
In-Reply-To: <768B654F-A66B-4CCE-9320-D096538B23F2@netronome.com> (Jiong
        Wang's message of "Tue, 21 May 2019 19:14:47 +0100")
Message-ID: <87blzvmxis.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210118
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210118
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


    >> Despite using a different syntax for the assembler (the llvm assembl=
er
    >> uses a C-ish expression-based syntax while the GNU assembler opts for
    >> a more classic assembly-language syntax) this implementation tries to
    >> provide inter-operability with clang/llvm generated objects.
    >=20
    >    I also noticed your implementation doesn=E2=80=99t seem to use the=
 same sub-register
    >    syntax as what LLVM assembler is doing.
    >=20
    >      x register for 64-bit, and w register for 32-bit sub-register.
    >=20
    >    So:
    >      add r0, r1, r2 means BPF_ALU64 | BPF_ADD | BFF_X
    >      add w0, w1, w1 means BPF_ALU | BPF_ADD | BPF_X
    >=20
    >    ASAICT, different register prefix for different register width is =
also adopted
    >    by quite a few other GNU assembler targets like AArch64, X86_64.
    >=20
    > Right.  I opted for using different mnemonics for alu and alu64
    > instructions, as it seemed to be simpler.
    >=20
    > What was your rationale for using sub-register notation?=20=20
=20=20=20=20
    It is the same instruction operating on different register classes,
    sub-register is a new register class, so define separate notation
    for them. This also simplifies compiler back-end when generating
    sub-register instructions, at least for LLVM, and is likely for GCC
    as well.

    LLVM eBPF backend has full support for generating sub-register ISA,

Well, the way I read the spec, these look like different instructions
operating on the same registers, only with different semantics :)

But yeah, it is basically two different ways to look at the same thing,
at the ISA level.

Given that both llvm and ebpf_asm use some kind of sub-registers (using
different register names, or suffixes) I guess I could do the same... In
principle I don't have a strong preference, but I have to think about
it, and determine what would be the impact in my on-going GCC backend.

Thanks for the info.  Much appreciated.
