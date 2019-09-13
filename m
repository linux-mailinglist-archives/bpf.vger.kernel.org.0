Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29CDB272D
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 23:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389617AbfIMVYM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 17:24:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37833 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbfIMVYJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 17:24:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so23165362lff.4
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2019 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M7RhwXkvx5UdXmM9G4lNP2WF3fIHiZECXKfzifEwcp4=;
        b=vXIy2wUt6CHXoGo9KPMbdEWFr+4Ws+dQLZDXXickxOjGdu3VW2EHmmG5X71zL4Ew/2
         mc1yYqRPVxOTrS1mjS9mO3DqGj2lneRbZuDyTEKfYxOizw/XJgcgxgUrYGTvqJYeBuJV
         ZEGU4RVBYG8GkE0kL2ee7rXMfkpO4MMQlBSd/pwcSBCULXbdkyy97eS5ZepJxd/E5FKY
         xBy5f3WSxa+qiw84F+Ue1OFUO/JAcKtlWa577IzduLR/cvVivD6r9GEyvtHJQHO1qInK
         82j/HEJowx+BF5Q2Xgqq99Mb2/W/MN+huQjMXUjsOqV0V0csQV8NQWxF4+N0wE2BB4s4
         2q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=M7RhwXkvx5UdXmM9G4lNP2WF3fIHiZECXKfzifEwcp4=;
        b=rZ05ZgFU3/JwoBlTFi0IORbrC7nAWASRry2dqnTmBrJzCIkf0eTU63zgQiXa+owjDn
         nVlcpAldamI+EjtIGCw8L6NVMMsFaPyS+B7m8WSgJDzEoeYwnJ3sRvNUbkeNlQ5rWKWV
         i2VyhlYrz2M7uljMp2XUL2L3U83TgjDbQuMupl18eSJSYjaFL+XAmmAH6FwdMObqZ6uV
         DWM8C/0a6AL3IpqEfvGUiE7Eo97a+NvMX0ser39nMX/w62Z+MB3l9rZyvl1i3XfJpn4W
         r1qgVU8XKOH1nCULjAmN1RzGGnj1+WJ1n5T/5wZh53uSsBheq/EYMW4YSqh3v0M/Mh8K
         ZisA==
X-Gm-Message-State: APjAAAUFK4nISzK6w31tHSulkjoBTi4ga/6S/8ARQ20d7pDk+TRjtKCi
        asU1dLcFsUrw8FEr7s8LjdpT8A==
X-Google-Smtp-Source: APXvYqz4+ycJ/IxKPzka58i4Xx9/yTLRhRavI/eAkAU02kKZDMblx3U4TzjFff6RCcX5HmTFSELOjw==
X-Received: by 2002:a19:4a10:: with SMTP id x16mr34910188lfa.126.1568409846959;
        Fri, 13 Sep 2019 14:24:06 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id p8sm6619563ljn.93.2019.09.13.14.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 14:24:06 -0700 (PDT)
Date:   Sat, 14 Sep 2019 00:24:04 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH bpf-next 05/11] samples: bpf: makefile: use D vars from
 KBUILD_CFLAGS to handle headers
Message-ID: <20190913212402.GB26724@khorivan>
Mail-Followup-To: Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
 <20190910103830.20794-6-ivan.khoronzhuk@linaro.org>
 <97ca4228-145a-2449-b4ba-8e79380a54f4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <97ca4228-145a-2449-b4ba-8e79380a54f4@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 13, 2019 at 09:12:01PM +0000, Yonghong Song wrote:
>
>
>On 9/10/19 11:38 AM, Ivan Khoronzhuk wrote:
>> The kernel headers are reused from samples bpf, and autoconf.h is not
>> enough to reflect complete arch configuration for clang. But CLANG-bpf
>> cmds are sensitive for assembler part taken from linux headers and -D
>> vars, usually used in CFLAGS, should be carefully added for each arch.
>> For that, for CLANG-bpf, lets filter them only for arm arch as it
>> definitely requires __LINUX_ARM_ARCH__ to be set, but ignore for
>> others till it's really needed. For arm, -D__LINUX_ARM_ARCH__ is min
>> version used as instruction set selector. In another case errors
>> like "SMP is not supported" for arm and bunch of other errors are
>> issued resulting to incorrect final object.
>>
>> Later D_OPTIONS can be used for gcc part.
>> ---
>>   samples/bpf/Makefile | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 8ecc5d0c2d5b..6492b7e65c08 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -185,6 +185,15 @@ HOSTLDLIBS_map_perf_test	+= -lrt
>>   HOSTLDLIBS_test_overhead	+= -lrt
>>   HOSTLDLIBS_xdpsock		+= -pthread
>>
>> +# Strip all expet -D options needed to handle linux headers
>> +# for arm it's __LINUX_ARM_ARCH__ and potentially others fork vars
>> +D_OPTIONS = $(shell echo "$(KBUILD_CFLAGS) " | sed 's/[[:blank:]]/\n/g' | \
>> +	sed '/^-D/!d' | tr '\n' ' ')
>> +
>> +ifeq ($(ARCH), arm)
>> +CLANG_EXTRA_CFLAGS := $(D_OPTIONS)
>> +endif
>
>Do you need this for native compilation?
Yes, native "arm" also requires it.

>
>so arm64 compilation does not need this?
yes, now only arm

>If only -D__LINUX_ARM_ARCH__ is needed, maybe just
>with
>    CLANG_EXTRA_CFLAGS := -D__LINUX_ARM_ARCH__
Value also needed: -D__LINUX_ARM_ARCH_=7 or -D__LINUX_ARM_ARCH_=6
So, need retrieve it.

>Otherwise, people will wonder whether this is needed for
>other architectures. Or just do
>    CLANG_EXTRA_CFLAGS := $(D_OPTIONS)
>for all cross compilation?
arm, cross and native requires it.

Will do this:

# Strip all expet -D options needed to handle linux headers
# for arm it's __LINUX_ARM_ARCH__ and potentially others fork vars
ifeq ($(ARCH), arm)
D_OPTIONS = $(shell echo "$(KBUILD_CFLAGS) " | sed 's/[[:blank:]]/\n/g' | \
	sed '/^-D/!d' | tr '\n' ' ')
endif

CLANG_EXTRA_CFLAGS := $(D_OPTIONS)



>
>> +
>>   # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
>>   #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
>>   LLC ?= llc
>>

-- 
Regards,
Ivan Khoronzhuk
