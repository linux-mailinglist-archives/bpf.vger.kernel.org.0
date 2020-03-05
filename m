Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B14179CD5
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 01:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbgCEA3U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 19:29:20 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35993 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbgCEA3U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 19:29:20 -0500
Received: by mail-il1-f193.google.com with SMTP id b17so3505124iln.3
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 16:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DMuXBI4n6VFH3vcmCnA8kWV3eDknxjUy9BFc+h/MzKY=;
        b=BzVBYccsXnBXQL8L4nriLT4wgNKsO/qjfzqlAJN1M5w8pTENcT4OLw0Esd5zBKM4Ws
         l08LyYnuwPv6FKWz7kZMosKXMI5dnF1gmkRPzi5UCbCLEbsb6s6ThdBHDyArCXk8HVZ7
         miNbYmMMN1oklJ9Lg93WhI0agt1FOPlhhvsq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DMuXBI4n6VFH3vcmCnA8kWV3eDknxjUy9BFc+h/MzKY=;
        b=Zq/kJc4hEd9WrOAxBYPLAydrlYTCwWvtKqZRfWzf6NLl2fpE456k1+z6QDnwDFm1ax
         jAUBN+T/rw5VfS/u+wVuGxGXN0zwEvoRehK/6fpJQYIXxMWV5Zp+Z8mrOT+aTS37OJWp
         gr6RX4OM1SiCRtLHRg0mdLjWYno4AFRffDBvPTwabKZEPJWlFmPgl1v5Fxf4g49hrk/V
         lx2EQHqjamrVr05wzbBEHcnWJ4XuorlrOO9q4L2gfRhqsOEHytHCtRhrp35WoLcnJJLL
         IEIyI/5CWLCLnsC7Bns5EpKpTTjJM1tqYczft0wcAbkeA8X8d+V0N5ADLJSD0tMfDis8
         +NaA==
X-Gm-Message-State: ANhLgQ15y756xWpwinDJmoVMA4YW5JXO1P3hmvW/ZMwBSuhwiARUN/mP
        biGJx09yL82LaXlMmpDAgUst6A==
X-Google-Smtp-Source: ADFU+vsj6BlimOUY1cjq4xUk/QovllsyeGkV1HNUuBRFKOYD/q6CBKOvI+ohh2SeR6TANE6+s96y1Q==
X-Received: by 2002:a92:914a:: with SMTP id t71mr4854237ild.108.1583368158380;
        Wed, 04 Mar 2020 16:29:18 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i16sm9674080ils.41.2020.03.04.16.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 16:29:17 -0800 (PST)
Subject: Re: [PATCH 2/4] selftests: Fix seccomp to support relocatable build
 (O=objdir)
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        daniel@iogearbox.net, kafai@fb.com, yhs@fb.com, andriin@fb.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        khilman@baylibre.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
 <11967e5f164f0cd717921bd382ff9c13ef740146.1583358715.git.skhan@linuxfoundation.org>
 <202003041442.A46000C@keescook>
 <11ffe43f-f777-7881-623d-c93196a44cb6@linuxfoundation.org>
 <87eeu7r6qf.fsf@mpe.ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <da1b2591-bb19-9dc7-ed5f-cc2481c24f87@linuxfoundation.org>
Date:   Wed, 4 Mar 2020 17:29:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87eeu7r6qf.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/4/20 5:22 PM, Michael Ellerman wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
>> On 3/4/20 3:42 PM, Kees Cook wrote:
>>> On Wed, Mar 04, 2020 at 03:13:33PM -0700, Shuah Khan wrote:
>>>> Fix seccomp relocatable builds. This is a simple fix to use the
>>>> right lib.mk variable TEST_GEN_PROGS for objects to leverage
>>>> lib.mk common framework for relocatable builds.
>>>>
>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>> ---
>>>>    tools/testing/selftests/seccomp/Makefile | 16 +++-------------
>>>>    1 file changed, 3 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
>>>> index 1760b3e39730..a8a9717fc1be 100644
>>>> --- a/tools/testing/selftests/seccomp/Makefile
>>>> +++ b/tools/testing/selftests/seccomp/Makefile
>>>> @@ -1,17 +1,7 @@
>>>>    # SPDX-License-Identifier: GPL-2.0
>>>> -all:
>>>> -
>>>> -include ../lib.mk
>>>> -
>>>> -.PHONY: all clean
>>>> -
>>>> -BINARIES := seccomp_bpf seccomp_benchmark
>>>>    CFLAGS += -Wl,-no-as-needed -Wall
>>>> +LDFLAGS += -lpthread
>>>>    
>>>> -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
>>>
>>> How is the ../kselftest_harness.h dependency detected in the resulting
>>> build rules?
>>>
>>> Otherwise, looks good.
>>
>> Didn't see any problems. I will look into adding the dependency.
> 
> Before:
> 
>    $ make --no-print-directory -C tools/testing/selftests/ TARGETS=seccomp
>    make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
>            ARCH=powerpc -C ../../.. headers_install
>      INSTALL /home/michael/build/adhoc/kselftest/usr/include
>    gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
>    gcc -Wl,-no-as-needed -Wall    seccomp_benchmark.c   -o seccomp_benchmark
>    
>    $ touch tools/testing/selftests/kselftest_harness.h
>    
>    $ make --no-print-directory -C tools/testing/selftests/ TARGETS=seccomp
>    make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
>            ARCH=powerpc -C ../../.. headers_install
>      INSTALL /home/michael/build/adhoc/kselftest/usr/include
>    gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
>    $
> 
> Note that touching the header causes it to rebuild seccomp_bpf.
> 
> With this patch applied:
> 
>    $ make --no-print-directory -C tools/testing/selftests/ TARGETS=seccomp
>    make -s --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
>            ARCH=powerpc -C ../../.. headers_install
>    gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c  -o /home/michael/build/adhoc/kselftest/seccomp/seccomp_bpf
>    gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_benchmark.c  -o /home/michael/build/adhoc/kselftest/seccomp/seccomp_benchmark
>    
>    $ touch tools/testing/selftests/kselftest_harness.h
>    
>    $ make --no-print-directory -C tools/testing/selftests/ TARGETS=seccomp
>    make -s --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
>            ARCH=powerpc -C ../../.. headers_install
>    make[1]: Nothing to be done for 'all'.
>    $
> 
> 

Thanks. I realized I overlooked header dependency case.

> So yeah it still needs:
> 
> seccomp_bpf: ../kselftest_harness.h
> 
> 
Yes v2 coming up. It also has to handle OUTPUT relocation.

thanks,
-- Shuah
