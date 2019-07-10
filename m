Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABA5646EC
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2019 15:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfGJNZY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 10 Jul 2019 09:25:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbfGJNZY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Jul 2019 09:25:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6ADNm7v040452
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2019 09:25:22 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tnfq5uh3r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2019 09:25:22 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 10 Jul 2019 14:25:20 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Jul 2019 14:25:18 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6ADPHXR53215306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 13:25:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A1B042042;
        Wed, 10 Jul 2019 13:25:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1F374203F;
        Wed, 10 Jul 2019 13:25:16 +0000 (GMT)
Received: from dyn-9-152-97-237.boeblingen.de.ibm.com (unknown [9.152.97.237])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Jul 2019 13:25:16 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: do not ignore clang failures
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <CAEf4BzZEs24=Cp8CdQiXtGXCcMtW430ER7wDHND7YA7OVfz3XA@mail.gmail.com>
Date:   Wed, 10 Jul 2019 15:25:16 +0200
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Content-Transfer-Encoding: 8BIT
References: <CAEf4Bzb3BKoEcYiM3qQ6uqn+bZZ7kO2ogvZPba7679TWFT4fmw@mail.gmail.com>
 <20190701184025.25731-1-iii@linux.ibm.com>
 <cc418117-32a7-b7aa-3570-29b1b3421303@iogearbox.net>
 <59B1630A-537D-43A1-B75C-87BE80709F93@linux.ibm.com>
 <CAEf4BzZEs24=Cp8CdQiXtGXCcMtW430ER7wDHND7YA7OVfz3XA@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19071013-4275-0000-0000-0000034B5D23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071013-4276-0000-0000-0000385B6122
Message-Id: <AAD094D8-EB0A-4464-B180-0293816B8DF8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100156
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 09.07.2019 um 20:14 schrieb Andrii Nakryiko <andrii.nakryiko@gmail.com>:
> 
> On Mon, Jul 8, 2019 at 8:01 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>> 
>>> Am 05.07.2019 um 16:22 schrieb Daniel Borkmann <daniel@iogearbox.net>:
>>> 
>>> On 07/01/2019 08:40 PM, Ilya Leoshkevich wrote:
>>>> Am 01.07.2019 um 17:31 schrieb Andrii Nakryiko <andrii.nakryiko@gmail.com>:
>>>>> Do we still need clang | llc pipeline with new clang? Could the same
>>>>> be achieved with single clang invocation? That would solve the problem
>>>>> of not detecting pipeline failures.
>>>> 
>>>> I’ve experimented with this a little, and found that new clang:
>>>> 
>>>> - Does not understand -march, but -target is sufficient.
>>>> - Understands -mcpu.
>>>> - Understands -Xclang -target-feature -Xclang +foo as a replacement for
>>>> -mattr=foo.
>>>> 
>>>> However, there are two issues with that:
>>>> 
>>>> - Don’t older clangs need to be supported? For example, right now alu32
>>>> progs are built conditionally.
>>> 
>>> We usually require latest clang to be able to test most recent features like
>>> BTF such that it helps to catch potential bugs in either of the projects
>>> before release.
>>> 
>>>> - It does not seem to be possible to build test_xdp.o without -target
>>>> bpf.
>>> 
>>> For everything non-tracing, it does not make sense to invoke clang w/o
>>> the -target bpf flag, see also Documentation/bpf/bpf_devel_QA.rst +573
>>> for more explanation, so this needs to be present for building test_xdp.o.
>> 
>> I'm referring to the test introduced in [1]. test_xdp.o might not be an
>> ideal target, but even if it's replaced with a more suitable one, the
>> llc invocation would still be required. So I could redo the patch as
>> follows:
>> 
>> - Replace test_xdp.o with get_cgroup_id_kern.o, use an intermediate .bc
>>  file.
>> - Use clang without llc for all other eBPF programs.
>> - Split out Kbuild include and order-only prerequisites.
>> 
>> What do you think?
> 
> How about just forcing llc to fail as well like this:
> 
> (clang <whatever> || echo "clain failed") | llc <whatever>
> 
> While not pretty, it will get us what we need with very clear
> messaging as well. E.g.:
> 
> progs/test_btf_newkv.c:21:37: error: expected identifier
> PF_ANNOTATE_KV_PAIR(btf_map_legacy, int, struct ipv_counts);
>                                    ^
> progs/test_btf_newkv.c:21:1: warning: type specifier missing, defaults
> to 'int' [-Wimplicit-int]
> PF_ANNOTATE_KV_PAIR(btf_map_legacy, int, struct ipv_counts);
> ^
> 1 warning and 1 error generated.
> llc: error: llc: <stdin>:1:1: error: expected top-level entity
> clang failed
> ^

While this would definitely work at least in my scenario, what about the
following hypothetical cases?

- clang manages to output something before exiting with nonzero rc
- future llc version exits with zero rc when given "clang failed" or any
  other arbitrary string as an input (perhaps, with just a warning?)

Come to think of it, what are the downsides of having intermediate
bitcode files? While I did not run into this yet, I could imagine it
might be even useful from time to time to inspect them.

