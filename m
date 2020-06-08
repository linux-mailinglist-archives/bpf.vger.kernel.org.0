Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ADE1F1EC4
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 20:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgFHSMe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 14:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFHSMb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 14:12:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B15CC08C5C3;
        Mon,  8 Jun 2020 11:12:30 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w1so18209109qkw.5;
        Mon, 08 Jun 2020 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=z154RMOSTrXqb2CRDUiw56xx556gz0WSpn0WRRUM9uc=;
        b=hGbti0/L5HXU/Ps4jKVXu3Zx4uuYL3OuZ0gXWUlGL+hAIZPW3f0SdkkNzi2pu7S35M
         8W8aeo0w4u7CoN9mfBLv4vjKgYxY/VkVy0SqzzsAIG/fg4L7hewJyE7nCY9kXdBXuIX/
         N6lGCtklb00LTSHYYuMwIqKSD6oa2DvOZ/I2EtNgvWD1X4R8NSGmAtaPRwmlwgf5zF8N
         fuQPZ9Azv0h/KFe9pTsJO/na0kUaMDf55+Iopc0v6u7d/hUUA8aKR9+z0ne0CSYmuyyB
         mHBV1qujGVEINjeqWBV1YiDj0sWpXk7gHNO2LZXeH8nwTPCwf5DIxylH9p2W1J6LoCij
         go1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=z154RMOSTrXqb2CRDUiw56xx556gz0WSpn0WRRUM9uc=;
        b=kk1YNLXgCVPhsJ448uuCxhC8+YDEAX1riVyIBty39GClKcy2w5MRX8pck1Zw3DyDzM
         OkPE9jz/6d5nehLaI+MJxM9gzZnjubhPD+Y+9K5w4wd4wQQHH3ftkBjXsDMUchCfjlDy
         pLDQPZQsyGihQkiSXSe9Z47ZrvXIe4aI15smaqjUz52Dy5fMfvKzkyKEKiTAUKPrHfxt
         t4t23Ga5MtH7MwTwBlQzWGy78MBQGI+l+I05pb33qX1RyNdFkfQtL7V/D9ea6tCb97Mt
         42fVYMryZo+5uaFeRpr/9VNPL+zshJ3EpokmogFphMFz04pTKnr398Uj+bmh+kZqpKMU
         LmhA==
X-Gm-Message-State: AOAM532rz/Qrk3kUv7Zd4IS6ez1gxSYzEDoeZzdv13ZeKjkvkIZnJpYN
        8kSv6ZZKR5KBKBq8xP7wd94=
X-Google-Smtp-Source: ABdhPJy1OkcL9UjkEis9IyIjboP1KXpSxXx+e8nNZ7FzbXjUwl2rKoEdJnUXhq68pqRXmUbX0+lJyw==
X-Received: by 2002:a37:a8c4:: with SMTP id r187mr23415214qke.69.1591639949626;
        Mon, 08 Jun 2020 11:12:29 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m126sm6791923qke.99.2020.06.08.11.12.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 11:12:29 -0700 (PDT)
Date:   Mon, 08 Jun 2020 15:12:03 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzbEcV6YaezP4yY8J=kYSBhh0cRHCvgCUe9xvB12mF08qg@mail.gmail.com>
References: <20200608161150.GA3073@kernel.org> <CAEf4BzbEcV6YaezP4yY8J=kYSBhh0cRHCvgCUe9xvB12mF08qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: libbpf's hashmap use of __WORDSIZE
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Irina Tirdea <irina.tirdea@intel.com>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <1BB90A3B-1372-487E-9E96-193AAAEBC095@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mi

On June 8, 2020 2:32:16 PM GMT-03:00, Andrii Nakryiko <andrii=2Enakryiko@g=
mail=2Ecom> wrote:
>On Mon, Jun 8, 2020 at 9:11 AM Arnaldo Carvalho de Melo
><arnaldo=2Emelo@gmail=2Ecom> wrote:
>>
>> Hi Andrii,
>>
>>         We've got that hashmap=2E[ch] copy from libbpf so that we can
>> build perf in systems where libbpf isn't available, and to make it
>build
>> in all the containers I regularly test build perf I had to add the
>patch
>> below, I test build with many versions of both gcc and clang and
>> multiple libcs=2E
>>
>>   https://gcc=2Egnu=2Eorg/onlinedocs/cpp/Common-Predefined-Macros=2Ehtm=
l
>>
>> The way that tools/include/linux/bitops=2Eh has been doing since 2012
>is
>> explained in:
>>
>>   http://git=2Ekernel=2Eorg/torvalds/c/3f34f6c0233ae055b5
>>
>> Please take a look and see if you find it acceptable,
>>
>> Thanks,
>>
>> - Arnaldo
>>
>>   Warning: Kernel ABI header at 'tools/perf/util/hashmap=2Eh' differs
>from latest version at 'tools/lib/bpf/hashmap=2Eh'
>>   diff -u tools/perf/util/hashmap=2Eh tools/lib/bpf/hashmap=2Eh
>>
>> $ diff -u tools/lib/bpf/hashmap=2Eh tools/perf/util/hashmap=2Eh
>> --- tools/lib/bpf/hashmap=2Eh     2020-06-05 13:25:27=2E822079838 -0300
>> +++ tools/perf/util/hashmap=2Eh   2020-06-05 13:25:27=2E838079794 -0300
>> @@ -10,10 +10,9 @@
>>
>>  #include <stdbool=2Eh>
>>  #include <stddef=2Eh>
>> -#ifdef __GLIBC__
>> -#include <bits/wordsize=2Eh>
>> -#else
>> -#include <bits/reg=2Eh>
>> +#include <limits=2Eh>
>> +#ifndef __WORDSIZE
>> +#define __WORDSIZE (__SIZEOF_LONG__ * 8)
>>  #endif
>
>This looks fine, I also build-tested it in Travis CI, so all good=2E
>There is actually __SIZEOF_SIZE_T__, which is more directly what
>hash_bits work with, but I don't think it matters for any reasonable
>system in use :)
>
>So yeah,
>
>Acked-by: Andrii Nakryiko <andriin@fb=2Ecom>
>
>Are you going to do this change for libbpf's variant, or should I
>submit a separate patch?

I'll send the patch later,

Thanks for checking,

- Arnaldo
>
>>
>>  static inline size_t hash_bits(size_t h, int bits)

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
