Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCE3234418
	for <lists+bpf@lfdr.de>; Fri, 31 Jul 2020 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbgGaKbg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 06:31:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:36754 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbgGaKbf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 06:31:35 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k1SK5-0003hb-9N; Fri, 31 Jul 2020 12:31:33 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k1SK5-000UW4-58; Fri, 31 Jul 2020 12:31:33 +0200
Subject: Re: [PATCH bpf] libbpf: Fix register in PT_REGS MIPS macros
To:     Jerry Crunchtime <jerry.c.t@web.de>
References: <05fb9d72-d1a7-5346-b55b-4495cdf54124@web.de>
 <76288d74-3110-952a-f068-e040d63dbd7d@iogearbox.net>
 <a6cdc832-1142-f1e0-4393-b982c51eac89@web.de>
Cc:     bpf@vger.kernel.org, andriin@fb.com
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c185d3eb-9253-5854-70ac-32a0d47ec4cd@iogearbox.net>
Date:   Fri, 31 Jul 2020 12:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a6cdc832-1142-f1e0-4393-b982c51eac89@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25889/Thu Jul 30 17:03:53 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/31/20 11:56 AM, Jerry Crunchtime wrote:
> Hi,
> 
>  > Jerry, your patch is missing a Signed-off-by from you.
> 
> Signed-off-by: Jerry Crunchtime <jerry.c.t@web.de>

Thanks! One more comment below:

> On 7/31/20 1:00 AM, Daniel Borkmann wrote:
>> On 7/30/20 1:44 PM, Jerry Crunchtime wrote:
>>> The o32, n32 and n64 calling conventions require the return
>>> value to be stored in $v0 which maps to $2 register, i.e.,
>>> the second register.
>>>
>>> Fixes: c1932cd ("bpf: Add MIPS support to samples/bpf.")
>>
>> Jerry, your patch is missing a Signed-off-by from you. It should be
>> enough if
>> you just reply with one in here that I'll add to the commit message and
>> I'll
>> take it via bpf tree then, thanks.
>>
>>> ---
>>>   tools/lib/bpf/bpf_tracing.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>>> index 58eceb884..ae205dcf8 100644
>>> --- a/tools/lib/bpf/bpf_tracing.h
>>> +++ b/tools/lib/bpf/bpf_tracing.h
>>> @@ -215,7 +215,7 @@ struct pt_regs;
>>>   #define PT_REGS_PARM5(x) ((x)->regs[8])
>>>   #define PT_REGS_RET(x) ((x)->regs[31])
>>>   #define PT_REGS_FP(x) ((x)->regs[30]) /* Works only with
>>> CONFIG_FRAME_POINTER */
>>> -#define PT_REGS_RC(x) ((x)->regs[1])
>>> +#define PT_REGS_RC(x) ((x)->regs[2])
>>>   #define PT_REGS_SP(x) ((x)->regs[29])
>>>   #define PT_REGS_IP(x) ((x)->cp0_epc)

While in process of applying, I noticed that there is one more thing broken; you
fixed the PT_REGS_RC() but by that logic at the same time we would also need to
fix PT_REGS_RC_CORE() given it still points to regs[1] as well:

   #define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), regs[1])

Please fix up and resubmit.

Thanks,
Daniel
