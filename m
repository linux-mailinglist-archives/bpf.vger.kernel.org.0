Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA601B6210
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2019 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfIRLJP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Sep 2019 07:09:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45187 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbfIRLJO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Sep 2019 07:09:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so6745206ljb.12
        for <bpf@vger.kernel.org>; Wed, 18 Sep 2019 04:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v6VDBivAx2Q88SjA44gfOPe9NoEO8jXXz9c7wXdVcf8=;
        b=tCVX5aZD3vnvAHSrP6KOImKf10EnxZ5PUxXqH8CtrK+nKWLM/4ASeJiwnRor2JUp9M
         ordOe7ZTyDQo7RCvgs+2/YXL+8J8UxBvCuIFEzKmaMu45QayOHaqjSBF937/7ctpskSL
         SMgexpzILYXSH6sJwZ0wsBRDIDClNqbEZVpQFrWC05tHycojsHMNgegYYvPoUp4/2/ET
         4kVne/wulUTxfVG8J+qaeGy0YYGDlnnDZiPhq0yWJfydeD4EamDvP6SGTvPM6JxyS0qo
         PeqxnWX2STWki4P7QYkPFYFd7wL2TtxhQVB621Ux3JL+vYqrOBlWnxkJztBZBXZPwgvq
         R4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=v6VDBivAx2Q88SjA44gfOPe9NoEO8jXXz9c7wXdVcf8=;
        b=hgxYAxgZCU4e1CkBhJOsjaFCZlt5KQSRkbdMd4YIXTVkaPieMZmnIG9CEcHaukqrYU
         t/9bvIYiKew2W9fvVvYeYapewLczYbl3QaaHf3EPZgLNznBd5OYH8BpIYd7/V1NjieMH
         Us8lZBLEXKk2alkKL4VYjZfw2zodFpxsqlxzSCnS79rS2cMI1esjiQ9LvnNLFCbFbwEA
         e4alqje4EC4ypI/hc5Vp8tWGz2W36PLFRM3kzyrnpsATNArrp1r7tUP9Y8browCU9Q6q
         HC9Qt7p8J3d4psWaYM950/JiOxQiAw2ccKVDECjvCPywHsYtGBynPp+f4kGk7Nx6u6li
         kcZw==
X-Gm-Message-State: APjAAAWQOW9+IyboSjHjT+zZRf3ghYqi773rgTmRKzB4TMFW30kBzmao
        mnOmiWUgiw74eIk1XHqXZsOLpA==
X-Google-Smtp-Source: APXvYqz8KtQm/GaMsAS/WjsyC6R0FVH1xHo/PGvVugL2x09OJNwgmyUbA4yOBZA5j8PWCfL+yF6QCQ==
X-Received: by 2002:a2e:9241:: with SMTP id v1mr1903624ljg.148.1568804951532;
        Wed, 18 Sep 2019 04:09:11 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id y13sm970049ljd.51.2019.09.18.04.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 04:09:10 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:09:08 +0300
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
Subject: Re: [PATCH v3 bpf-next 13/14] samples: bpf: makefile: add sysroot
 support
Message-ID: <20190918110907.GE2908@khorivan>
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
 <20190916105433.11404-14-ivan.khoronzhuk@linaro.org>
 <CAEf4BzYa7mwFLZWdS0EMf4m=s88a94z6p30mxN8Q9=erpE5=Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzYa7mwFLZWdS0EMf4m=s88a94z6p30mxN8Q9=erpE5=Xg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 17, 2019 at 10:23:57PM -0700, Andrii Nakryiko wrote:
>On Mon, Sep 16, 2019 at 4:00 AM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> Basically it only enables that was added by previous couple fixes.
>> Sysroot contains correct libs installed and its headers ofc. Useful
>
>Please, let's not use unnecessary abbreviations/slang. "Of course" is
>not too long and is a proper English, let's stick to it.
>
>> when working with NFC or virtual machine.
>>
>> Usage:
>>
>> clean (on demand)
>>     make ARCH=arm -C samples/bpf clean
>>     make ARCH=arm -C tools clean
>>     make ARCH=arm clean
>>
>> configure and install headers:
>>
>>     make ARCH=arm defconfig
>>     make ARCH=arm headers_install
>>
>> build samples/bpf:
>>     make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- samples/bpf/ \
>>     SYSROOT="path/to/sysroot"
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>  samples/bpf/Makefile | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 133123d4c7d7..57ddf055d6c3 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -194,6 +194,11 @@ TPROGS_CFLAGS += -I$(srctree)/tools/lib/
>>  TPROGS_CFLAGS += -I$(srctree)/tools/include
>>  TPROGS_CFLAGS += -I$(srctree)/tools/perf
>>
>> +ifdef SYSROOT
>> +TPROGS_CFLAGS += --sysroot=${SYSROOT}
>> +TPROGS_LDFLAGS := -L${SYSROOT}/usr/lib
>
>Please stay consistent: $() instead of ${}?
Yes, thanks.

>
>> +endif
>> +
>>  EXTRA_CXXFLAGS := $(TPROGS_CFLAGS)
>>
>>  # options not valid for C++
>> --
>> 2.17.1
>>

-- 
Regards,
Ivan Khoronzhuk
