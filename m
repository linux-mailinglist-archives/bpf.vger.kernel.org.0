Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0107636BF56
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhD0Ggb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 02:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhD0Gga (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 02:36:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09BBC061574
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 23:35:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n21so11743465eji.1
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 23:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fc9oahwv+kLE/BNux0lRp3ukf2IdPJmNiIdJ8AYjk0w=;
        b=IwkY5axdUkRj/Hfj4waMTaqIHKeQliqi10Rk+lXOIgql/yOq3My9uGvoU3xQkxkwyf
         byfqFo6uZH/XDoDVSoosbZJ82dofX+RdqZvave5+YtuOLb3g7Ug1HV/VXyrdTs8wpSZU
         SGiGPPdqdLsdfY8hkkBL6RO++GlQF693u+2CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fc9oahwv+kLE/BNux0lRp3ukf2IdPJmNiIdJ8AYjk0w=;
        b=hQQkjCeX3MnID3SEaPk7N12kdaRd+6diOudJ1Aau7xMIn59F4app2fCD1alVJyHZhN
         Hnd0T6XpMF/xJRwCAKK6XaZoKTVLzq1W4BDmSTRLWSfZqK4zMZYUubYHZRSRveJHZWC8
         iNbncH9//R5nTTSOCwBZHvRSZunwH4BvmQq7e4YQ8+MbT/4+ZBDTR/CEwFnWE3e94vuT
         DTkBTCxWJQ0/po15Ow2wMvjKDCbgLSepFKc7cmlZ8qNct9SaV7YzOYkZzYdGY45BsLXs
         F+OV7nbtv4MUh0ASzCIu/uJnkZnIugyGxjePng699y+CDr8iZOYtEEBHOMOygLGEBl60
         aUPA==
X-Gm-Message-State: AOAM530g6Y09jy40DUQMBPV1CDPkKMzabBAOP5Rlqi9HK7Kttkeme1Lt
        2W+7UinQ4AoyuE5sR3wU+Pi2Lg==
X-Google-Smtp-Source: ABdhPJyoOTT61SY1Gaajl2yIhf3M6EpwKAML+uIKbn5axq6jt6vd9cJQmg1DMnrEKfkCbXOhCjkxKQ==
X-Received: by 2002:a17:906:28cd:: with SMTP id p13mr8362041ejd.336.1619505346530;
        Mon, 26 Apr 2021 23:35:46 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id gt35sm12645927ejc.57.2021.04.26.23.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 23:35:45 -0700 (PDT)
Subject: Re: [PATCH bpf-next v5 6/6] selftests/bpf: Add a series of tests for
 bpf_snprintf
To:     Florent Revest <revest@chromium.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210419155243.1632274-1-revest@chromium.org>
 <20210419155243.1632274-7-revest@chromium.org>
 <CAEf4BzZUM4hb9owhompwARabRvRbCYxBrpgXSdXM8RRm42tU1A@mail.gmail.com>
 <CABRcYm+=XSt_U-19eYXU8+XwDUXoBGQMROMbm6xk9P9OHnUW_A@mail.gmail.com>
 <CAEf4BzZnkYDAm2R+5R9u4YEdZLj=C8XQmpT=iS6Qv0Ne7cRBGw@mail.gmail.com>
 <CABRcYmLn2S2g-QTezy8qECsU2QNSQ6wyjhuaHpuM9dzq97mZ7g@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2db39f1c-cedd-b9e7-2a15-aef203f068eb@rasmusvillemoes.dk>
Date:   Tue, 27 Apr 2021 08:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABRcYmLn2S2g-QTezy8qECsU2QNSQ6wyjhuaHpuM9dzq97mZ7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26/04/2021 23.08, Florent Revest wrote:
> On Mon, Apr 26, 2021 at 6:19 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Apr 26, 2021 at 3:10 AM Florent Revest <revest@chromium.org> wrote:
>>>
>>> On Sat, Apr 24, 2021 at 12:38 AM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>>
>>>> On Mon, Apr 19, 2021 at 8:52 AM Florent Revest <revest@chromium.org> wrote:
>>>>>
>>>>> The "positive" part tests all format specifiers when things go well.
>>>>>
>>>>> The "negative" part makes sure that incorrect format strings fail at
>>>>> load time.
>>>>>
>>>>> Signed-off-by: Florent Revest <revest@chromium.org>
>>>>> ---
>>>>>  .../selftests/bpf/prog_tests/snprintf.c       | 125 ++++++++++++++++++
>>>>>  .../selftests/bpf/progs/test_snprintf.c       |  73 ++++++++++
>>>>>  .../bpf/progs/test_snprintf_single.c          |  20 +++
>>>>>  3 files changed, 218 insertions(+)
>>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
>>>>>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
>>>>>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
>>>>> new file mode 100644
>>>>> index 000000000000..a958c22aec75
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
>>>>> @@ -0,0 +1,125 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/* Copyright (c) 2021 Google LLC. */
>>>>> +
>>>>> +#include <test_progs.h>
>>>>> +#include "test_snprintf.skel.h"
>>>>> +#include "test_snprintf_single.skel.h"
>>>>> +
>>>>> +#define EXP_NUM_OUT  "-8 9 96 -424242 1337 DABBAD00"
>>>>> +#define EXP_NUM_RET  sizeof(EXP_NUM_OUT)
>>>>> +
>>>>> +#define EXP_IP_OUT   "127.000.000.001 0000:0000:0000:0000:0000:0000:0000:0001"
>>>>> +#define EXP_IP_RET   sizeof(EXP_IP_OUT)
>>>>> +
>>>>> +/* The third specifier, %pB, depends on compiler inlining so don't check it */
>>>>> +#define EXP_SYM_OUT  "schedule schedule+0x0/"
>>>>> +#define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
>>>>> +
>>>>> +/* The third specifier, %p, is a hashed pointer which changes on every reboot */
>>>>> +#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
>>>>> +#define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
>>>>> +
>>>>> +#define EXP_STR_OUT  "str1 longstr"
>>>>> +#define EXP_STR_RET  sizeof(EXP_STR_OUT)
>>>>> +
>>>>> +#define EXP_OVER_OUT "%over"
>>>>> +#define EXP_OVER_RET 10
>>>>> +
>>>>> +#define EXP_PAD_OUT "    4 000"
>>>>
>>>> Roughly 50% of the time I get failure for this test case:
>>>>
>>>> test_snprintf_positive:FAIL:pad_out unexpected pad_out: actual '    4
>>>> 0000' != expected '    4 000'
>>>>
>>>> Re-running this test case immediately passes. Running again most
>>>> probably fails. Please take a look.
>>>
>>> Do you have more information on how to reproduce this ?
>>> I spinned up a VM at 87bd9e602 with ./vmtest -s and then run this script:
>>>
>>> #!/bin/sh
>>> for i in `seq 1000`
>>> do
>>>   ./test_progs -t snprintf
>>>   if [ $? -ne 0 ];
>>>   then
>>>     echo FAILURE
>>>     exit 1
>>>   fi
>>> done
>>>
>>> The thousand executions passed.
>>>
>>> This is a bit concerning because your unexpected_pad_out seems to have
>>> an extra '0' so it ends up with strlen(pad_out)=11 but
>>> sizeof(pad_out)=10. The actual string writing is not really done by
>>> our helper code but by the snprintf implementation (str and str_size
>>> are only given to snprintf()) so I'd expect the truncation to work
>>> well there. I'm a bit puzzled
>>
>> I'm puzzled too, have no idea. I also can't repro this with vmtest.sh.
>> But I can quite reliably reproduce with my local ArchLinux-based qemu
>> image with different config (see [0] for config itself). So please try
>> with my config and see if that helps to repro. If not, I'll have to
>> debug it on my own later.
>>
>>   [0] https://gist.github.com/anakryiko/4b6ae21680842bdeacca8fa99d378048
> 
> I tried that config on the same commit 87bd9e602 (bpf-next/master)
> with my debian-based qemu image and I still can't reproduce the issue
> :| If I can be of any help let me know, I'd be happy to help
> 

It's not really clear to me if this is before or after the rewrite to
use bprintf, but regardless, in those two patches this caught my attention:

 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
-	enum bpf_printf_mod_type mod[MAX_TRACE_PRINTK_VARARGS];
+	u32 *bin_args;
 	static char buf[BPF_TRACE_PRINTK_SIZE];
 	unsigned long flags;
 	int ret;

-	ret = bpf_printf_prepare(fmt, fmt_size, args, args, mod,
-				 MAX_TRACE_PRINTK_VARARGS);
+	ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
+				  MAX_TRACE_PRINTK_VARARGS);
 	if (ret < 0)
 		return ret;

-	ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
-		BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
-	/* snprintf() will not append null for zero-length strings */
-	if (ret == 0)
-		buf[0] = '\0';
+	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);

 	raw_spin_lock_irqsave(&trace_printk_lock, flags);
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);

Why isn't the write to buf[] protected by that spinlock? Or put another
way, what protects buf[] from concurrent writes?

Probably the test cases are not run in parallel, but this is the kind of
thing that would give those symptoms.

Rasmus
