Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48E9B8C85
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2019 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395192AbfITIWM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Sep 2019 04:22:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37056 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395191AbfITIWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Sep 2019 04:22:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so6241163lje.4
        for <bpf@vger.kernel.org>; Fri, 20 Sep 2019 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hOm0RSVxiN9cy/2zlDkuDpGL5XVU330++py7GJHjAx0=;
        b=gpxypbyVCKkOGbVW+Afzq0G0SijqxBGhC3HHNQu38FBsCf3mjnrrXApKO4u8mD5Ge3
         zA04+tnmTerkM4T1RJ7krUmnB+9hTEFLGJXEb12Rj7tOexqvl+NS34gitG6WfSllFUWh
         4jKwiMG6K5ttmC0iW8Q0blWchaToknxTaq+xx5nUNjEIhDlZ7S96cWZ1yNPU3qPe62aT
         INq3V5DtnKDJFTpcH19QS0y3kVdWHtz23xRU/H+KEZJ7m5AG/GrfFIJPrCDg5eZ8ICEB
         RG4tAhxqXtZROOpeRHPk9By6C7D7GJeujMxAGxPFpnXTUGQimTyzigJgMQ//nJSFb65u
         p+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hOm0RSVxiN9cy/2zlDkuDpGL5XVU330++py7GJHjAx0=;
        b=lPdPUNK5tnqfUdkV/oylj/zy3mdjV8qJ0nLcRgtzar1Ms404M0JPI+i/d08bryV3n+
         q4iK0vkS3pQiFP8rlVvt9tvJL456JNtA44FBDVH7dHk0gf/1ZYgYqs9lqDunAhSy2tJW
         nihcW2Wlw9s4b4iMB6YPgV1oRcPlOfbGk8v2eSEW9Ntvm7ifkSZqOTtwo/fqBnQuaAvr
         p6EvMBHWtXapn0CD1NUH2qPQ/loRba3bnojDZ+TG3fI2ZrrdXkukkIy2BsCL2cSySr83
         6G/0Y2ZyMXvUnWXhsqLRx8UB42k/7m95V40PLAXjGY7hDjleJ34Mst2hw5FGQwpfrHZb
         R0Og==
X-Gm-Message-State: APjAAAUIl0LJRUEozMSBMgCenHniKVYAs2vCWZFmyKlYu7SYHe3DOVUd
        YQ0xHsyBUFntggyTyVzbBY7qww==
X-Google-Smtp-Source: APXvYqwL1jMaxNVYlobOS7lqzCZWK0IyjHtQ8tNd29VLU4eery6g9+RMfYffbt3kONUMacbsmztDtw==
X-Received: by 2002:a05:651c:c4:: with SMTP id 4mr6073391ljr.111.1568967729239;
        Fri, 20 Sep 2019 01:22:09 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id k15sm270207ljg.65.2019.09.20.01.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 01:22:08 -0700 (PDT)
Date:   Fri, 20 Sep 2019 11:22:06 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] libbpf: fix version identification on busybox
Message-ID: <20190920082204.GC8870@khorivan>
Mail-Followup-To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190919160518.25901-1-ivan.khoronzhuk@linaro.org>
 <CAEf4BzbCjCYr5NMPctDkUggwpehnqZPVBSqZOsd9MvSq6WmnZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzbCjCYr5NMPctDkUggwpehnqZPVBSqZOsd9MvSq6WmnZQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 19, 2019 at 01:02:40PM -0700, Andrii Nakryiko wrote:
>On Thu, Sep 19, 2019 at 11:22 AM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> It's very often for embedded to have stripped version of sort in
>> busybox, when no -V option present. It breaks build natively on target
>> board causing recursive loop.
>>
>> BusyBox v1.24.1 (2019-04-06 04:09:16 UTC) multi-call binary. \
>> Usage: sort [-nrugMcszbdfimSTokt] [-o FILE] [-k \
>> start[.offset][opts][,end[.offset][opts]] [-t CHAR] [FILE]...
>>
>> Lets modify command a little to avoid -V option.
>>
>> Fixes: dadb81d0afe732 ("libbpf: make libbpf.map source of truth for libbpf version")
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>
>> Based on bpf/master
>>
>>  tools/lib/bpf/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>> index c6f94cffe06e..a12490ad6215 100644
>> --- a/tools/lib/bpf/Makefile
>> +++ b/tools/lib/bpf/Makefile
>> @@ -3,7 +3,7 @@
>>
>>  LIBBPF_VERSION := $(shell \
>>         grep -oE '^LIBBPF_([0-9.]+)' libbpf.map | \
>> -       sort -rV | head -n1 | cut -d'_' -f2)
>> +       cut -d'_' -f2 | sort -r | head -n1)
>
>You can't just sort alphabetically, because:
>
>1.2
>1.11
>
>should be in that order. See discussion on mailing thread for original commit.

if X1.X2.X3, where X = {0,1,....99999}
Then it can be:

-LIBBPF_VERSION := $(shell \
-       grep -oE '^LIBBPF_([0-9.]+)' libbpf.map | \
-       sort -rV | head -n1 | cut -d'_' -f2)
+_LBPFLIST := $(patsubst %;,%,$(patsubst LIBBPF_%,%,$(filter LIBBPF_%, \
+           $(shell cat libbpf.map))))
+_LBPFLIST2 := $(foreach v,$(_LBPFLIST), \
+               $(subst $() $(),,$(foreach n,$(subst .,$() $(),$(v)), \
+                       $(shell printf "%05d" $(n)))))
+_LBPF_VER := $(word $(words $(sort $(_LBPFLIST2))), $(sort $(_LBPFLIST2)))
+LIBBPF_VERSION := $(patsubst %_$(_LBPF_VER),%,$(filter %_$(_LBPF_VER), \
+        $(join $(addsuffix _, $(_LBPFLIST)),$(_LBPFLIST2))))

It's bigger but avoids invocations of grep/sort/cut/head, only cat/printf
, thus -V option also.

>
>>  LIBBPF_MAJOR_VERSION := $(firstword $(subst ., ,$(LIBBPF_VERSION)))
>>
>>  MAKEFLAGS += --no-print-directory
>> --
>> 2.17.1
>>

-- 
Regards,
Ivan Khoronzhuk
