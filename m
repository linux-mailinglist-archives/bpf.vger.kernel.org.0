Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88F569D157
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 17:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjBTQaw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 11:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjBTQav (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 11:30:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA831E1DE
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 08:30:50 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KF3B78024157;
        Mon, 20 Feb 2023 16:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=yZvrffCTZEyAdh1vRBTM2L2iFTULQ3mXh4jhEEH5l1s=;
 b=Ewq2Wvbycu2tSalO5gGbmmPdwjfJTfEw59cOaVvdd7502PazNSriYkURjQ0JzaJx4L3U
 TQT9zY4phUt0X/bP3E6b+5Ljq8v4gQ0ohp6rKev5mshDWEH8ietykHvTt0fuKTJIuuV+
 5OEG9Fop5bWPoggGBtOYs1yfbOHvqgKUnTA/hfWJsKAiuIGqmzLM374c/BW3WIxFTPSC
 ZCjR5Q8LOoP3FUxdTUQ8QCR6G/JObWRXlnP5FxuUSzVu2j3CYMBj7xVqIp+8VqMRDCIS
 IhKG6+/h1UsplnQPrXBz/SYBPiVKBVPJE3e2xlH+o1mQ9iD47Qh0W+cZyTfDGsEl/Nre cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv2at851y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 16:30:35 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KFSawi006992;
        Mon, 20 Feb 2023 16:30:35 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv2at8515-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 16:30:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KFJN2A007346;
        Mon, 20 Feb 2023 16:30:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6ax1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 16:30:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KGUU0G14876932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 16:30:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE5AC2004B;
        Mon, 20 Feb 2023 16:30:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 613B42004E;
        Mon, 20 Feb 2023 16:30:30 +0000 (GMT)
Received: from heavy (unknown [9.155.209.149])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Feb 2023 16:30:30 +0000 (GMT)
Date:   Mon, 20 Feb 2023 17:30:29 +0100
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Puranjay Mohan <puranjay12@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        memxor@gmail.com
Subject: Re: [RFC] libbbpf/bpftool: Support 32-bit Architectures.
Message-ID: <20230220163029.3c5hv4rzaybt7jlr@heavy>
References: <CANk7y0joRFw2F4iAuN9r-dWWMvOmbFZz_J4rhGhgVFjdnxPTYw@mail.gmail.com>
 <Y+2J+jIFIxGOW32X@google.com>
 <CAEf4BzaQJfB0Qh2Wn5wd9H0ZSURbzWBfKkav8xbkhozqTWXndw@mail.gmail.com>
 <CANk7y0iKQX7BdGabDgHmTa=BXc_WCh3rkh5xjqJqc56FJs-QUA@mail.gmail.com>
 <CAEf4BzbHZ3mJT7sMhAGjfEjENjgMT+vForcKr1d+75yUkme+Tw@mail.gmail.com>
 <CANk7y0hJc=--b8eV4d6nmjAThuv1njvTtbzpvpp_UmPB6R=6ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0hJc=--b8eV4d6nmjAThuv1njvTtbzpvpp_UmPB6R=6ag@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aBTtTVrRPHKt5n15rRVTUU19JpxPBYTA
X-Proofpoint-ORIG-GUID: GVtDZivY22T3lQ-8RLK_n6EQ3vrgJei9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_13,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 18, 2023 at 02:23:56PM +0100, Puranjay Mohan wrote:
> On Fri, Feb 17, 2023 at 10:46 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Feb 17, 2023 at 2:25 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> > >
> > > Hi,
> > > Thanks for the response.
> > >
> > > On Thu, Feb 16, 2023 at 11:13 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 15, 2023 at 5:48 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > > >
> > > > > On 02/15, Puranjay Mohan wrote:
> > > > > > The BPF selftests fail to compile on 32-bit architectures as the skeleton
> > > > > > generated by bpftool doesn’t take into consideration the size difference
> > > > > > of
> > > > > > variables on 32-bit/64-bit architectures.
> > > > >
> > > > > > As an example,
> > > > > > If a bpf program has a global variable of type: long, its skeleton will
> > > > > > include
> > > > > > a bss map that will have a field for this variable. The long variable in
> > > > > > BPF is
> > > > > > 64-bit. if we are working on a 32-bit machine, the generated skeleton has
> > > > > > to
> > > > > > compile for that machine where long is 32-bit.
> > > > >
> > > > > > A reproducer for this issue:
> > > > > >          root@56ec59aa632f:~# cat test.bpf.c
> > > > > >          long var;
> > > > >
> > > > > >          root@56ec59aa632f:~# clang -target bpf -g -c test.bpf.c
> > > > >
> > > > > >          root@56ec59aa632f:~# bpftool btf dump file test.bpf.o format raw
> > > > > >          [1] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > > > > >          [2] VAR 'var' type_id=1, linkage=global
> > > > > >          [3] DATASEC '.bss' size=0 vlen=1
> > > > > >                 type_id=2 offset=0 size=8 (VAR 'var')
> > > > >
> > > > > >         root@56ec59aa632f:~# bpftool gen skeleton test.bpf.o > skeleton.h
> > > > >
> > > > > >         root@56ec59aa632f:~# echo "#include \"skeleton.h\"" > test.c
> > > > >
> > > > > >         root@56ec59aa632f:~# gcc test.c
> > > > > >         In file included from test.c:1:
> > > > > >         skeleton.h: In function 'test_bpf__assert':
> > > > > >         skeleton.h:231:2: error: static assertion failed: "unexpected
> > > > > > size of \'var\'"
> > > > > >           231 |  _Static_assert(sizeof(s->bss->var) == 8, "unexpected
> > > > > > size of 'var'");
> > > > > >                  |  ^~~~~~~~~~~~~~
> > > > >
> > > > > > One naive solution for this would be to map ‘long’ to ‘long long’ and
> > > > > > ‘unsigned long’ to ‘unsigned long long’. But this doesn’t solve everything
> > > > > > because this problem is also seen with pointers that are 64-bit in BPF and
> > > > > > 32-bit in 32-bit machines.
> > > > >
> > > > > > I want to work on solving this and am looking for ideas to solve it
> > > > > > efficiently.
> > > > > > The main goal is to make libbbpf/bpftool host architecture agnostic.
> > > > >
> > > > > Looks like bpftool needs to be aware of the target architecture. The
> > > > > same way gcc is doing with build-host-target triplet. I don't
> > > > > think this can be solved with a bunch of typedefs? But I've long
> > > > > forgotten how a pure 32-bit machine looks, so I can't give any
> > > > > useful input :-(
> > > >
> > > > Yeah, I'd rather avoid making bpftool aware of target architecture.
> > > > Three is 32 vs 64 bitness, there is also little/big endianness, etc.
> > > >
> > > > So I'd recommend never using "long" (and similar types that depend on
> > > > bitness of the platform, like size_t, etc) for global variables. Also
> > > > don't use pointer types as types of the variable. Stick to __u64,
> > > > __u32, etc.
> > >
> > > I feel if we follow. this convention then it will work out but
> > > currently a lot of selftests use these
> > > architecture dependent variable types and therefore don't even compile
> > > for 32-bit architectures
> > > because of the _Static_asserts in the skeleton.
> > >
> > > Do you suggest replacing all these with __u64, __u32, etc. in the
> > > selftests so that they compile on every architecture?
> >
> > how many changes are we talking about? my initial reaction is that
> > yeah, if this matters for correctness, we should be strict with __u64
> > and __u32 use over long
> 
> I can try to compile the selftests on arm32 and count the number of failures.
> It is important for correctness but also for testing the support of
> BPF on non-64 bit
> architectures. If the selftests don't even compile we can't test BPF properly.

Hi,

Does anyone plan looking into fixing selftests on 32-bit arches in the
near future (i.e. getting rid of longs and pointers)? I have an x86 JIT
change that I would like to test, and I'm also running into this issue.
I can try doing this, but I'd like to avoid doing duplicate work.

Best regards,
Ilya

[...]
