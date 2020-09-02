Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25E725B650
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 00:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBWK2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 18:10:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBWK1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 18:10:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082M9lAs120720;
        Wed, 2 Sep 2020 22:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=uvO52K3sIUUlnay/t4Jn4g39CIBUuBgb8+11GXEL2Cw=;
 b=vucxgcr+m5MCgOKIM+iWO4CWaGmYCeoV4boIRHRBfKEaKoKRU2GAsPwSiGHMPqUf7UXx
 j2ItQDz2HxQi9oFwPVeIIMCETdSnfs+V8A03BWNd9pwUhh+iChFGdezyafz/KYwb4NPf
 pnfNf8j3sc4Wzb0SxhP4SXM09bDBp97IEC/oDz/W5VhaYsaEFgzsVIDghgqpZGFx4+e1
 vFp41Q2rGe2O4XNR9IzdYgeRh9ItpWrB9WVbqKqIzSm631KSif5LUKWT6juQo5L+BgN6
 JhNINENJCX1hhQKtePWMtUwkRYslMjDfJhKGmv9JiyBm+t3AM0wHpdR6f3FccVD6GdwG SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 339dmn3wyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 22:10:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082M4f37196543;
        Wed, 2 Sep 2020 22:10:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3380x7y5cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 22:10:13 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082MACgj013839;
        Wed, 2 Sep 2020 22:10:12 GMT
Received: from termi.oracle.com (/10.175.48.72)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 15:10:11 -0700
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: EF_BPF_GNU_XBPF
References: <87mu282gay.fsf@oracle.com>
        <CAADnVQ+AZvXTSitF+Fj5ohYiKWERN2yrPtOLR9udKcBTHSZzxA@mail.gmail.com>
        <87y2ls0w41.fsf@oracle.com>
        <20200902203206.nx6ws4ixuo2bcic6@ast-mbp.dhcp.thefacebook.com>
        <87o8mn281a.fsf@oracle.com>
        <d0a6eb38-76a4-b335-878b-647fe68f937a@iogearbox.net>
Date:   Thu, 03 Sep 2020 00:10:07 +0200
In-Reply-To: <d0a6eb38-76a4-b335-878b-647fe68f937a@iogearbox.net> (Daniel
        Borkmann's message of "Wed, 2 Sep 2020 23:33:17 +0200")
Message-ID: <87k0xb25kw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020204
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020205
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Daniel.

>>>> As such, the property of being verifiable is irrelevant.
>>>
>>> No. It's a fundamental property of BPF.
>>> If it's not verifiable it's not BPF.
>> Sure.
>> 
>>> It's not xBPF either.
>> Heh, beg to differ :)
>> 
>>> Please call it something else and don't confuse people that your ISA
>>> has any overlap with BPF. It doesn't. It's not verifiable.
>> Nonsense.  xBPF has as much overlap with BPF as it can have: around
>> 99%.
>> The purpose of having the e_flag is to avoid confusion, not to
>> increase
>> it.  xBPF objects are mainly used to test the GCC BPF backend (and other
>> purposes we have in mind, like ease the debugging of BPF programs) but
>> we want to eliminate the chance of these objects to be confused with
>> legit BPF files, and used as such.
>
> I fully agree with Alexei. Looking at [0], if some of these extensions are
> useful and help/optimize code generation, why not add them to the BPF runtime
> in the kernel so they can be properly used in general for code generation
> from gcc/llvm in BPF backend?

The reasons why xBPF came to existence are:

1) Due to BPF being so restrictive, many hundreds of GCC tests won't
   even build, because they use functions having more than 5 arguments,
   or functions with too big stack frames, or indirect calls, etc.  We
   want to be able to test our backend properly, so we added the -mxbpf
   option in order to relax some of these restrictions.

2) We are working on a BPF simulator that works with GDB.  For that to
   work, we needed to add a "breakpoint" instruction that GDB can patch
   in the program.  Having a simulator also allows us to run more GCC
   tests.

3) With some extensions, it becomes possible to support DWARF call frame
   information, and therefore to debug BPF programs in GDB with
   unwinding support.  You can build with -mxbpf, debug, then build
   again without -mxbpf.

[We have received messages from people saying that a more relaxed
 variant of BPF would be useful in some userland contexts, and xbpf
 could certainly be used for that, but that's secondary.]

So, xBPF is mainly about compiler validation and debugging of BPF
programs.  It is not about helping with code optimization, and the
extensions it implements are clearly unsuitable for the kernel.

That's why it is important to clearly flag the ELF files that make use
of these extensions, and therefore our intention of using a bit in
e_flags for that purpose, and this thread.

The LLVM backend could also benefit from xBPF, for exactly the same
reasons than GCC.  In fact, right now the LLVM backend generates
non-conforming BPF instructions under certain circumstances, and the
resulting (invalid) objects are not annotated at all.

> xBPF would indeed be highly confusing if it cannot be used from the
> runtime (unless these are properly integrated into the kernel,
> verified and thus become a fixed part of eBPF ISA).
>
>   [0] https://linuxplumbersconf.org/event/7/contributions/724/attachments/636/1166/bpf.pdf

My intention was to discuss about these matters during LPC in the
Toolchain MC:

https://linuxplumbersconf.org/event/7/contributions/752/attachments/689/1288/toolchain-MC-bpf-discussion.pdf

Unfortunately no BPF people were present during the session, probably
because of scheduling, but we can do so via email.

We just want to provide good tools to you people :)
