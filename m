Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8801D2339DA
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgG3UjB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 16:39:01 -0400
Received: from mout.web.de ([217.72.192.78]:52039 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728751AbgG3Ui7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 16:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596141537;
        bh=sM9gEWrOWiazgMEQ2OdMP+OboaeGEZPMJlp25uBJd+Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CvIsFb+mngRwzo12md4EY/bOeVVSfAitAUjOKU291E9KLXsXbl7uSzDwyDHtTN7br
         tu66D5Zn2LSG9j/hQqWUmd5AcYnuJcuve16zsTwU5ODFu4YhskvT+P2nab3exzlGng
         c1SR58+r0c/FbupzZOYwyS2j4RphIp0nnWn90S0E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([77.2.34.38]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lzb94-1knHN50vnm-014iye; Thu, 30
 Jul 2020 22:38:57 +0200
Subject: Re: [PATCH bpf] libbpf: Fix register in PT_REGS MIPS macros
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jerry Cruntime <jerry.c.t@web.de>
Cc:     bpf <bpf@vger.kernel.org>
References: <05fb9d72-d1a7-5346-b55b-4495cdf54124@web.de>
 <CAEf4BzZfa0m2O4rBEMdN2N2dLeXCfMbwAohCZLevZ3F+mKenvA@mail.gmail.com>
From:   Jerry Cruntime <jerry.c.t@web.de>
Message-ID: <6ac86da0-16f0-eb9e-010e-277cfdd555be@web.de>
Date:   Thu, 30 Jul 2020 22:38:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZfa0m2O4rBEMdN2N2dLeXCfMbwAohCZLevZ3F+mKenvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZZGDQOaJjU49AjJayMA4Lp/ohcl1aIL54FP2J35oWBs9AJrHRl5
 RVK7FaOtVEbHCSNcTHh/fDWqLx7+UhfXCRtANX+MR9otPh6tjkZ8OvoBPysH2Nt0MuxU/sA
 IOjfsrZTo72+SLCM00lVrSFqSoyZ3eVjdOy8QRVlPB/n5S0H5FPjTELPyt5QE3N83VtuDvL
 Xq91bFjZyJRNcn6y4+0pQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ByVaE9pRNSk=:i1Ej3Y/yMiPXrl+dPy+Flo
 5Zcxh+y3Y2POxJAs1iOQYqi3zFTxJEC9MYqHdRarzGbycmWcjnd448F1OvKOShfc6Koi21kk8
 /wXSYsN5e1Ubo7LVrsaDy6WKpMZf8fVxApgjulwjR5tCibQ3v9ZJ7ijlGVY6YITEWEhGFnVOG
 bCWQ9uwVIGZvJTMyXamun729H4Ojiac48pM3BWu2AG5PrgJHk2v4VIXgs91Hn+1cEkTjAJYFq
 /oWfbhMG3dTeOmVadzsUl6W2Bxvqb7SPQPbVOkjxA7Qpijxk+zpssQ4hP4to8kyEpRI8dAE82
 dCQ4WyIiMdhSH0PCr8m9nxSqMCJ53UuCpWCIn7rDmJ4uu12YSghamNhwwGT6byiPwr8pPSbqD
 2UXBmSpz8QtJchQijviykbp8+4Qwzsvqq+EYL1sd+syEabxbFn2RZvCAaKg9Tvs/DM+ueuYt9
 abUxoXQP5C1OJ9/v7d3O9K+KfhVGmb5IbNIJTGkjM8YZW13cmeOPhFdWaWolsr3btqz6+gDmd
 qMb3wSr1hT7nf1OJuskQsqOB0MEAve/CqNYu3L17avq6Z2KjwZ4q3INtJzRBd3wbcTp15r9ug
 ZEOkkqOJL23qnbO+UnCvW0E3ki7XbU8WrOi5vdCFupCYehHQiSaTfa0+t7cBksgm2PIlN/fFy
 HCNjXMZplhEGcMe5/er2MT/Dc2uGBc4Kl8XJyizQM6/UdFZeCxrmMuf5YQ1vU5nw6tLianuu5
 1hbajdug4Q4O7OtBhgjomErE4C7wkL+Bv+FCDXv6Inc9/hQFV/1ZD0+c2Uv7m5LVITF/w+gLZ
 yISR1BXLW0PYNW3B7vQUGdsOWkPI0ZtLirdX9+xN3Quk8QHehUyfPd2DwgqpPFIZk59JNLJeL
 r1vOYYzotCZeAzvNIHNFyTlLxTAIPSGcMqnpMo+wbBhtAZCbQgThGYzyJFJUVoJgW7FI+q0s8
 PKoUBG6/N1GmhlF1NRys8yBLA5e9HABk50axZNDma0WUIahh12Lqmjnms2YLvHEmxnWU+xRyD
 03sy84AoO5XYslJ175fdau0zOmoh06UZM6Qlbx1ygJOBDl0qd4kFfL5tmhbsUVJRUULmqQ05u
 QD4YgODKWUD4f4ukAhUQxI2gRCZMmz3tZxFVjQzmBZXHoABjm4gclTCskRSMJ9FFKWOFG1ZDx
 DoD1vaZmZExhVWDGPjVa31j2DJIsWxlaKlOPwhucN6QChhVjB/sJuauLvyKusIJd2F5XCkKEq
 JgKakDrEtwAjL0wP4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

 > I've quickly looked up some doc on MIPS calling convention, doesn't
 > seem like regs[8] is actually used for 5th input argument (the doc I
 > found documented only the use of $4 through $7 for first 4 args).
 > Should we drop PT_REGS_PARM5() for MIPS, while at it?

My understanding is that with o32 only 4 arguments can be passed in
registers ($4-$7). But n32 and n64 extended it to pass 8 arguments in
registers ($4-$11).

My source is "MIPS Run, Second Edition" from Dominic Sweetman table 11.2
on page 327. It is also described here:

https://en.wikipedia.org/wiki/Calling_convention#MIPS


On 7/30/20 9:55 PM, Andrii Nakryiko wrote:
> On Thu, Jul 30, 2020 at 4:45 AM Jerry Cruntime <jerry.c.t@web.de> wrote:
>>
>> The o32, n32 and n64 calling conventions require the return
>> value to be stored in $v0 which maps to $2 register, i.e.,
>> the second register.
>>
>> Fixes: c1932cd ("bpf: Add MIPS support to samples/bpf.")
>> ---
>>    tools/lib/bpf/bpf_tracing.h | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>> index 58eceb884..ae205dcf8 100644
>> --- a/tools/lib/bpf/bpf_tracing.h
>> +++ b/tools/lib/bpf/bpf_tracing.h
>> @@ -215,7 +215,7 @@ struct pt_regs;
>>    #define PT_REGS_PARM5(x) ((x)->regs[8])
>
> I've quickly looked up some doc on MIPS calling convention, doesn't
> seem like regs[8] is actually used for 5th input argument (the doc I
> found documented only the use of $4 through $7 for first 4 args).
> Should we drop PT_REGS_PARM5() for MIPS, while at it?
>
>>    #define PT_REGS_RET(x) ((x)->regs[31])
>>    #define PT_REGS_FP(x) ((x)->regs[30]) /* Works only with
>> CONFIG_FRAME_POINTER */
>> -#define PT_REGS_RC(x) ((x)->regs[1])
>> +#define PT_REGS_RC(x) ((x)->regs[2])
>
> This looks good, though.
>
>>    #define PT_REGS_SP(x) ((x)->regs[29])
>>    #define PT_REGS_IP(x) ((x)->cp0_epc)
>>
>> --
>> 2.17.1
