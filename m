Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C101B43BD
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2019 00:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfIPWET (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 18:04:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40884 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfIPWET (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 18:04:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so1414997ljw.7
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=an8Tg0keAdSMZgI1pA83USwohPIWdfUkBfCw/Vxa0hM=;
        b=hv59pXfy2WeDYAVOITvOqi5pmbivkfyJEmrsWkFDXA2OijgH8E4ceqm8i61GPbaYML
         yt9Rep1apYmMxAzvW1DoX+b7veawQc/j2oFXjXkwmVjtq07PKyGqvuH2mWXFLHqRti9e
         3eVbV5UIW5nxPj0SkRdCrVl2+wMPJBwBCFaat2EQkV5GKKP1LErG3HPgMzKFhCufxgMo
         2ZMu/4tuqbmWyu4sz+HCEKd15qrvE87rZ2rb6G+DdjFRte8KPenKCtqx4OF4GLUb0HR9
         f7YPCEv9ct/lZBQmB0Cotn4PpnNpMpvzZP8gqAoVU0npRdfwXqHau30dIoce7ygjSc0r
         G6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=an8Tg0keAdSMZgI1pA83USwohPIWdfUkBfCw/Vxa0hM=;
        b=RMCkyVfdgRTvL9wLAMekU6AODdCHq0FFzKNKe+BCEwpOS3PPWIS7BpSYnTv+MK8Q0z
         QD7CJ27hIwcQyR9Lfa9m5yGHRCqOlUwzIfFJOc7Rvu+A8FL33tCEXFWA3AUdyM+3Qao8
         D7YYOC0QwXdleM9jK9nSIuE0GozR09Jli/COc9d9jMiXY/KhuwtLL32yMI6fVmMsC530
         M36Goe7TWajWZU8XPU2EowkT8ohV7+vkeyvfC1Js8inJrMoSR/joPLtRTxISODKcms72
         jRAFjks8YMGlsXyZsOMfwqMAoSDgXR0u/wxs9P1jf3zUo9opDhqIPXU8RQDsZYyNQKbO
         eL0g==
X-Gm-Message-State: APjAAAWegHlYvZTBzipXlgtnHsu6eKA8+hPIsVhSHXlxhsekowUz6r/l
        oBtjnxwChZEYDwHu/KmDWY5nGw==
X-Google-Smtp-Source: APXvYqxKcpaUkIgEEiF9cNrbe9aM6QbWJZh2LRNWuc6kfhQ6aLuq3JgpMsPLd/oxBkW+nYaCZTr3hw==
X-Received: by 2002:a2e:958c:: with SMTP id w12mr67916ljh.98.1568671455527;
        Mon, 16 Sep 2019 15:04:15 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id e8sm40562ljk.54.2019.09.16.15.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 15:04:14 -0700 (PDT)
Date:   Tue, 17 Sep 2019 01:04:12 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v3 bpf-next 05/14] samples: bpf: makefile: use
 __LINUX_ARM_ARCH__ selector for arm
Message-ID: <20190916220411.GC4420@khorivan>
Mail-Followup-To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
 <20190916105433.11404-6-ivan.khoronzhuk@linaro.org>
 <CAEf4BzYpCGHxNG-jOjwx5a2NXbvLW4gZH8GD2p7E27v9K3ookg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzYpCGHxNG-jOjwx5a2NXbvLW4gZH8GD2p7E27v9K3ookg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 16, 2019 at 01:44:23PM -0700, Andrii Nakryiko wrote:
>On Mon, Sep 16, 2019 at 3:59 AM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> For arm, -D__LINUX_ARM_ARCH__=X is min version used as instruction
>> set selector and is absolutely required while parsing some parts of
>> headers. It's present in KBUILD_CFLAGS but not in autoconf.h, so let's
>> retrieve it from and add to programs cflags. In another case errors
>> like "SMP is not supported" for armv7 and bunch of other errors are
>> issued resulting to incorrect final object.
>> ---
>>  samples/bpf/Makefile | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 8ecc5d0c2d5b..d3c8db3df560 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -185,6 +185,16 @@ HOSTLDLIBS_map_perf_test   += -lrt
>>  HOSTLDLIBS_test_overhead       += -lrt
>>  HOSTLDLIBS_xdpsock             += -pthread
>>
>> +ifeq ($(ARCH), arm)
>> +# Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
>> +# headers when arm instruction set identification is requested.
>> +ARM_ARCH_SELECTOR = $(shell echo "$(KBUILD_CFLAGS) " | \
>> +                   sed 's/[[:blank:]]/\n/g' | sed '/^-D__LINUX_ARM_ARCH__/!d')
>
>Does the following work exactly like that without shelling out (and
>being arguably simpler)?
>
>ARM_ARCH_SELECTOR = $(filter -D__LINUX_ARM_ARCH__%, $(KBUILD_CFLAGS))
>
>> +
>> +CLANG_EXTRA_CFLAGS := $(ARM_ARCH_SELECTOR)
>> +KBUILD_HOSTCFLAGS := $(ARM_ARCH_SELECTOR)
>
>Isn't this clearing out previous value of KBUILD_HOSTCFLAGS? Is that
>intentional, or it was supposed to be += here?
>
>> +endif
>> +
>>  # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
>>  #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
>>  LLC ?= llc
>> --
>> 2.17.1
>>

Just left from previous version filtering all -D options.
Will update in next v., SELECTOR also.

-- 
Regards,
Ivan Khoronzhuk
