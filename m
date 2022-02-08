Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC964AE56F
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 00:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiBHXbY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 18:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiBHXbX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 18:31:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C65C061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 15:31:21 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218NCbwm007954;
        Tue, 8 Feb 2022 23:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8ffuxfBXjC2lw76mD562wwix+xKzojHoub1J/Txx5ho=;
 b=aa3eFXmG0c3MkkdnuuRtmUELXtwDC8grgaaFgHCsJSfNcCKd2g0SI4dRoDazHOIGYzXL
 lYG0VernU2Sc3TWXWqoa8//0yr7CYxU+Swe7GtDN3E8w4w/lO0e+DGRyHDhiLRkknjzS
 TPkLXk+XItMi23I3RCZpEpDr9TVr1FYsx4pbfAv1msFvCFMzQZ64uh9xBFIhNoEeAo6X
 a/XvsZ32ng/9NuK4Jh2JnkStibYcic4G7K6oTY+tVa3kI6mIZeEwNGYWG9HnIDi2CM2c
 4UNQtSaGUOzEFNyGE7ryKRbf6pl0/SFn3wvRRxP8s3ADwA1GBxTjm0ZmhUB6tspew+CV Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3tst4mdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:31:03 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 218NUuIM012143;
        Tue, 8 Feb 2022 23:30:56 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3tst4md9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:30:56 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218N8nMe031702;
        Tue, 8 Feb 2022 23:30:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3e1gv9gkq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 23:30:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218NUo9d24641980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 23:30:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE5C9A405B;
        Tue,  8 Feb 2022 23:30:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FD56A4054;
        Tue,  8 Feb 2022 23:30:50 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 23:30:50 +0000 (GMT)
Message-ID: <e7610d2a-4ce7-1099-1f0a-d361712678fc@linux.ibm.com>
Date:   Wed, 9 Feb 2022 00:30:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next v4 05/14] libbpf: Generalize overriding syscall
 parameter access macros
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
 <20220208051635.2160304-6-iii@linux.ibm.com>
 <CAEf4BzZCYa-wz5B7pwvo6R84vs70YFxJddSvA_FwCGDnUrHXFg@mail.gmail.com>
 <566fdad05cb0176b7dfcffb6d99c59567db91c8e.camel@linux.ibm.com>
 <CAEf4BzYjWdp7JA2DY--GQ_miQTnyuAA1XspovvuE+Ui5fAFNxQ@mail.gmail.com>
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <CAEf4BzYjWdp7JA2DY--GQ_miQTnyuAA1XspovvuE+Ui5fAFNxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hbmYw18RVdZUfAuSeQHPosoXbYhQv4d6
X-Proofpoint-GUID: AdM-jTt9-2OvTkp_tD2uaxzuB100Tbcy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_07,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/9/22 00:21, Andrii Nakryiko wrote:
> On Tue, Feb 8, 2022 at 3:09 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>
>> On Tue, 2022-02-08 at 14:05 -0800, Andrii Nakryiko wrote:
>>> On Mon, Feb 7, 2022 at 9:16 PM Ilya Leoshkevich <iii@linux.ibm.com>
>>> wrote:
>>>>
>>>> Instead of conditionally overriding PT_REGS_PARM4_SYSCALL, provide
>>>> default fallbacks for all __PT_PARMn_REG_SYSCALL macros, so that
>>>> architectures can simply override a specific syscall parameter
>>>> macro.
>>>> Also allow completely overriding PT_REGS_PARM1_SYSCALL for
>>>> non-trivial access sequences.
>>>>
>>>> Co-developed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>> ---
>>>>   tools/lib/bpf/bpf_tracing.h | 48 +++++++++++++++++++++++++--------
>>>> ----
>>>>   1 file changed, 33 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/tools/lib/bpf/bpf_tracing.h
>>>> b/tools/lib/bpf/bpf_tracing.h
>>>> index da7e8d5c939c..82f1e935d549 100644
>>>> --- a/tools/lib/bpf/bpf_tracing.h
>>>> +++ b/tools/lib/bpf/bpf_tracing.h
>>>> @@ -265,25 +265,43 @@ struct pt_regs;
>>>>
>>>>   #endif
>>>>
>>>> -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
>>>> -#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
>>>> -#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
>>>> -#ifdef __PT_PARM4_REG_SYSCALL
>>>> +#ifndef __PT_PARM1_REG_SYSCALL
>>>> +#define __PT_PARM1_REG_SYSCALL __PT_PARM1_REG
>>>> +#endif
>>>> +#ifndef __PT_PARM2_REG_SYSCALL
>>>> +#define __PT_PARM2_REG_SYSCALL __PT_PARM2_REG
>>>> +#endif
>>>> +#ifndef __PT_PARM3_REG_SYSCALL
>>>> +#define __PT_PARM3_REG_SYSCALL __PT_PARM3_REG
>>>> +#endif
>>>> +#ifndef __PT_PARM4_REG_SYSCALL
>>>> +#define __PT_PARM4_REG_SYSCALL __PT_PARM4_REG
>>>> +#endif
>>>> +#ifndef __PT_PARM5_REG_SYSCALL
>>>> +#define __PT_PARM5_REG_SYSCALL __PT_PARM5_REG
>>>> +#endif
>>>> +
>>>> +#ifndef PT_REGS_PARM1_SYSCALL
>>>> +#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)-
>>>>> __PT_PARM1_REG_SYSCALL)
>>>> +#endif
>>>> +#ifndef PT_REGS_PARM2_SYSCALL
>>>> +#define PT_REGS_PARM2_SYSCALL(x) (__PT_REGS_CAST(x)-
>>>>> __PT_PARM2_REG_SYSCALL)
>>>> +#endif
>>>> +#ifndef PT_REGS_PARM3_SYSCALL
>>>> +#define PT_REGS_PARM3_SYSCALL(x) (__PT_REGS_CAST(x)-
>>>>> __PT_PARM3_REG_SYSCALL)
>>>> +#endif
>>>> +#ifndef PT_REGS_PARM4_SYSCALL
>>>>   #define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)-
>>>>> __PT_PARM4_REG_SYSCALL)
>>>> -#else /* __PT_PARM4_REG_SYSCALL */
>>>> -#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
>>>>   #endif
>>>> -#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
>>>> +#ifndef PT_REGS_PARM5_SYSCALL
>>>> +#define PT_REGS_PARM5_SYSCALL(x) (__PT_REGS_CAST(x)-
>>>>> __PT_PARM5_REG_SYSCALL)
>>>> +#endif
>>>>
>>>> -#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
>>>> -#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
>>>> -#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
>>>> -#ifdef __PT_PARM4_REG_SYSCALL
>>>> +#define PT_REGS_PARM1_CORE_SYSCALL(x)
>>>> BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM1_REG_SYSCALL)
>>>> +#define PT_REGS_PARM2_CORE_SYSCALL(x)
>>>> BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM2_REG_SYSCALL)
>>>> +#define PT_REGS_PARM3_CORE_SYSCALL(x)
>>>> BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_REG_SYSCALL)
>>>>   #define PT_REGS_PARM4_CORE_SYSCALL(x)
>>>> BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG_SYSCALL)
>>>> -#else /* __PT_PARM4_REG_SYSCALL */
>>>> -#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
>>>> -#endif
>>>> -#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
>>>> +#define PT_REGS_PARM5_CORE_SYSCALL(x)
>>>> BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_REG_SYSCALL)
>>>>
>>>
>>> No, please don't do it. It makes CORE variants too rigid. We agreed
>>> w/
>>> Naveen that the way you did it in v2 is better and more flexible and
>>> in v3 you did it the other way. Why?
>>
>> As far as I remember we didn't discuss this proposal from Naveen [1] -
>> there was another one about moving SYS_PREFIX to libbpf, where
>> we agreed that it would have bad consequences.
> 
> Alright, I guess I never submitted my opposition to what Naveen
> proposed. But I did land the v3 version of that patch, didn't I? Why
> change something that's already accepted?

Right. Sorry, I just wanted to use this opportunity to clean up things a
little.

> 
>>
>> Isn't this patch essentially equivalent to the one from my v3 [2],
>> but with the added ability to override more things and better-looking?
> 
> No, it's not. We want to override entire PT_REGS_PARM1_CORE_SYSCALL
> definition to be something like BPF_CORE_READ((struct pt_regs___s390x
> *)x, orig_gpr2), while you are making  PT_REGS_PARM1_CORE_SYSCALL
> definition very rigid.

Right, now that we've decided to use flavors, this is no longer useful.
I'll drop it for v5.

> 
> 
>> I.e.: if we define __PT_PARMn_REG_SYSCALL, then PT_REGS_PARMn_SYSCALL
>> and PT_REGS_PARMn_CORE_SYSCALL use that, and __PT_PARMn_REG otherwise.
>>
>> [1]
>> https://lore.kernel.org/bpf/1643990954.fs9q9mrdxt.naveen@linux.ibm.com/
>> [2]
>> https://lore.kernel.org/bpf/20220204145018.1983773-5-iii@linux.ibm.com/
>>
>>>
>>>>   #else /* defined(bpf_target_defined) */
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>
