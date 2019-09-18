Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B525B617E
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2019 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfIRKfP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Sep 2019 06:35:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41615 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfIRKfP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Sep 2019 06:35:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so5288001lfn.8
        for <bpf@vger.kernel.org>; Wed, 18 Sep 2019 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5IKevHxYE8kJAT6rh5UWN+J7usw4VjwCKVPryNseZJE=;
        b=WO9H67nVw2fT4Z2j/RPZzKh1muXV7mcGA8J1lk2RWGs2FHPWhOPkyl1I1sCSpysElI
         Ktq8U63s20pJSpRtGo7OAL2AeKJZJoOPcq5cj8K3VgFbFnZTUXN9N0V0x3Bk2LcTA7ux
         UFDOVVCgrhdUR0gYw1X80XO+Vf2YOSoRce39mhb0indSnYQ7dd5T/RfIutn5iXyqqsuA
         AU1pwvN86k0TXLLx1hTjvdx9HKGYUw+/ToZFyPCDd2/dk9vGOYYROCSxkK1RNWczW9pm
         eR5+0UrUO/AmkDcbiPYVDy0Il64EmQXeE+g5poMQtgiVyMyzJ1pU78Y0vs9R/ywO3cYh
         1Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5IKevHxYE8kJAT6rh5UWN+J7usw4VjwCKVPryNseZJE=;
        b=YYLljN8F3Ruab0a2YL4tqUcJymISSruqmKpAbGkWauNISH6A8o+0LCTINC1IXioe+z
         OSbPR2K/hj37rPJ1W5PA3KYgiJkdH0XWK+QJ0jtoI/I8v2ayo1621PDImo+OGdgjTwE1
         A1bqfR48VwlbJ98tLvx4o80D6OQ6IEG6Wu/LekdT27iXncMdrWipv2tENHSY3xiqyjAS
         RC2rZwdgFkfIPYCpVX8vQTQQe/m00YJPkBwwklxEANX4B7X9KrjS7K/cPtrUF4IcMcwc
         pO9tdlLJleeYIbCnjk22w0XYWKKTOqoDgb3e8n4EIkmltX6r04YjaCSyI9tZNAuMqcXc
         +9FQ==
X-Gm-Message-State: APjAAAVy8hKi9IyqNX6eO85ABLo6T91gbi8caPstpYdLaBEohNrHxrtj
        CD+aSapDV+/OZEGKNGIkqG4W9Q==
X-Google-Smtp-Source: APXvYqyL7ppVAzsU/nQPvrrwKm85aNB1UxdDF5l/HMW6KLOQWEly82ds/7WozGXkgR1luXbXHPwaMw==
X-Received: by 2002:a19:6a09:: with SMTP id u9mr1673963lfu.91.1568802912601;
        Wed, 18 Sep 2019 03:35:12 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id p9sm955453lji.107.2019.09.18.03.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 03:35:11 -0700 (PDT)
Date:   Wed, 18 Sep 2019 13:35:09 +0300
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
Subject: Re: [PATCH v3 bpf-next 09/14] samples: bpf: makefile: use own flags
 but not host when cross compile
Message-ID: <20190918103508.GC2908@khorivan>
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
 <20190916105433.11404-10-ivan.khoronzhuk@linaro.org>
 <CAEf4BzbuPnxAs0A=w60q0jTCy5pb2R-h0uEuT2tmvjsaj4DH4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzbuPnxAs0A=w60q0jTCy5pb2R-h0uEuT2tmvjsaj4DH4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 17, 2019 at 04:42:07PM -0700, Andrii Nakryiko wrote:
>On Mon, Sep 16, 2019 at 3:59 AM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> While compile natively, the hosts cflags and ldflags are equal to ones
>> used from HOSTCFLAGS and HOSTLDFLAGS. When cross compiling it should
>> have own, used for target arch. While verification, for arm, arm64 and
>> x86_64 the following flags were used alsways:
>>
>> -Wall
>> -O2
>> -fomit-frame-pointer
>> -Wmissing-prototypes
>> -Wstrict-prototypes
>>
>> So, add them as they were verified and used before adding
>> Makefile.target, but anyway limit it only for cross compile options as
>> for host can be some configurations when another options can be used,
>> So, for host arch samples left all as is, it allows to avoid potential
>> option mistmatches for existent environments.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>  samples/bpf/Makefile | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 1579cc16a1c2..b5c87a8b8b51 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -178,8 +178,17 @@ CLANG_EXTRA_CFLAGS := $(ARM_ARCH_SELECTOR)
>>  TPROGS_CFLAGS += $(ARM_ARCH_SELECTOR)
>>  endif
>>
>> +ifdef CROSS_COMPILE
>> +TPROGS_CFLAGS += -Wall
>> +TPROGS_CFLAGS += -O2
>
>Specifying one arg per line seems like overkill, put them in one line?
Will combine.

>
>> +TPROGS_CFLAGS += -fomit-frame-pointer
>
>Why this one?
I've explained in commit msg. The logic is to have as much as close options
to have smiliar binaries. As those options are used before for hosts and kinda
cross builds - better follow same way.

>
>> +TPROGS_CFLAGS += -Wmissing-prototypes
>> +TPROGS_CFLAGS += -Wstrict-prototypes
>
>Are these in some way special that we want them in cross-compile mode only?
>
>All of those flags seem useful regardless of cross-compilation or not,
>shouldn't they be common? I'm a bit lost about the intent here...
They are common but split is needed to expose it at least. Also host for
different arches can have some own opts already used that shouldn't be present
for cross, better not mix it for safety.

>
>> +else
>>  TPROGS_LDLIBS := $(KBUILD_HOSTLDLIBS)
>>  TPROGS_CFLAGS += $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS)
>> +endif
>> +
>>  TPROGS_CFLAGS += -I$(objtree)/usr/include
>>  TPROGS_CFLAGS += -I$(srctree)/tools/lib/bpf/
>>  TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
>> --
>> 2.17.1
>>

-- 
Regards,
Ivan Khoronzhuk
