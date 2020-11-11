Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4722AF800
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 19:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKKSey (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 13:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgKKSex (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 13:34:53 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31666C0613D1;
        Wed, 11 Nov 2020 10:34:52 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d9so2646498qke.8;
        Wed, 11 Nov 2020 10:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=7kYU93NEW4QhXnW7PD/Rf1Zr+vcFFRboH8zR2j76/s8=;
        b=VCNzN7gq91Ag43OxgxF8x2L0G50ST9HzPAYhnPD3EYXqWHsvkFX9W20pTbjhun6W2/
         gM0s1V88He6peUppVPAwn6Qlo3Ai5BiRh0jZhpRZl2BRM7XsyNrbhGI0XER8bSrQxUiq
         CLWAv2++pEei4bdUjoqmDBpTcyvZTOf5+04jq/tryXAue3MyqXF0FmltJRqKt2vfXMi2
         yfY+vCSSQgn3JNo3OCr1zpnNeVvN2Ise4J/FvYbfEj7MppUmREuJSLgwsrKHISXQRkX2
         /kH08mQ5+j52k+GNRRSM+m78yovBPH+mZ7XYMuwesjFRVcpf3m7IqwX/VjFdUxvjrn9h
         rJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=7kYU93NEW4QhXnW7PD/Rf1Zr+vcFFRboH8zR2j76/s8=;
        b=aid5syRKZj5RKlrNZkm2e4c6RIjuR70f2GzyW98CT0F3Zi+nQM42QVbs3DbtjyktAe
         U0vWpO0GzzDYzzmGJ1MID8KqiZImR3qpSZGJg5yEAs3eJbVZyzBVwT6GSd7p+q2yGQP3
         5dnId99ZpGEZy/Wgyhp9Uc3Zs7S02elnv83DQCXuGlKlwYptPtnIp1Krowo543nJlMzt
         LBDD0byOmh3rb+8c35mrVlrHQzWRg1mSJht6EFGyjAMpVYXBqOhKmZvAXGTJ9f2g5qyw
         6tBdpLFOsxWmbK+W6/MR+xHrpYrcizu225A9xt4O4lOj8rpGkawQUhbSHhLAw3bfsjAM
         SdHA==
X-Gm-Message-State: AOAM531wWj0BsHWzS7FVPVVCKzerROYx6Od3MN/cldpPSlBAmDATGp8J
        BOrmzIcZa+bOFCnury5KwDk=
X-Google-Smtp-Source: ABdhPJyqyCe0jUW0OpBM0JFV5XLECeA1TuVcy+tuaBO+yIHyqY9doiKz0ZZNdZCywRzEbpjWQSSWHQ==
X-Received: by 2002:a37:4b44:: with SMTP id y65mr26790660qka.401.1605119691387;
        Wed, 11 Nov 2020 10:34:51 -0800 (PST)
Received: from [172.29.31.236] ([187.68.204.65])
        by smtp.gmail.com with ESMTPSA id i21sm2763925qtm.1.2020.11.11.10.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 10:34:50 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:34:26 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzZZ9HcfhVg=YF_0-7tO8Gpp8Jitm1Utg2h_jasXT0n4sw@mail.gmail.com>
References: <20201106052549.3782099-1-andrii@kernel.org> <20201106052549.3782099-5-andrii@kernel.org> <20201111115627.GB355344@kernel.org> <CAEf4BzZZ9HcfhVg=YF_0-7tO8Gpp8Jitm1Utg2h_jasXT0n4sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH dwarves 4/4] btf: add support for split BTF loading and encoding
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <1A8E09AB-8FE7-4B19-9287-663F8B139362@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On November 11, 2020 3:27:58 PM GMT-03:00, Andrii Nakryiko <andrii=2Enakry=
iko@gmail=2Ecom> wrote:
>On Wed, Nov 11, 2020 at 3:56 AM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> Em Thu, Nov 05, 2020 at 09:25:49PM -0800, Andrii Nakryiko escreveu:
>> > Add support for generating split BTF, in which there is a
>designated base
>> > BTF, containing a base set of types, and a split BTF, which extends
>main BTF
>> > with extra types, that can reference types and strings from the
>main BTF=2E
>>
>> > This is going to be used to generate compact BTFs for kernel
>modules, with
>> > vmlinux BTF being a main BTF, which all kernel modules are based
>off of=2E
>>
>> > These changes rely on patch set [0] to be present in libbpf
>submodule=2E
>>
>> >   [0]
>https://patchwork=2Ekernel=2Eorg/project/netdevbpf/list/?series=3D377859&=
state=3D*
>>
>> So, applied and added this:
>
>Awesome, thanks! Do you plan to release v1=2E19 soon?

Yes

>
>>
>> diff --git a/man-pages/pahole=2E1 b/man-pages/pahole=2E1
>> index 4b5e0a1bf5462b28=2E=2E20ee91fc911d4b39 100644
>> --- a/man-pages/pahole=2E1
>> +++ b/man-pages/pahole=2E1
>> @@ -185,6 +185,10 @@ Do not encode VARs in BTF=2E
>>  =2EB \-\-btf_encode_force
>>  Ignore those symbols found invalid when encoding BTF=2E
>>
>> +=2ETP
>> +=2EB \-\-btf_base
>> +Path to the base BTF file, for instance: vmlinux when encoding
>kernel module BTF information=2E
>> +
>>  =2ETP
>>  =2EB \-l, \-\-show_first_biggest_size_base_type_member
>>  Show first biggest size base_type member=2E
>>
>> ---------------
>>
>> The entry for btf_encode/-J is missing, I'll add in a followup patch=2E
>>
>> Also I had to fixup ARGP_btf_base to 321 as I added this, to simplify
>> the kernel scripts and Makefiles:
>>
>>   $ pahole --numeric_version
>>   118
>>   $
>
>Oh, this is nice! Can't really use it with Kbuild now due to backwards
>compatibility, but maybe someday=2E

Well, if it fails with --numeric_version, then it is old and the warning a=
bout the minimal version being v1=2E19 should be emitted :)

- Arnaldo
>
>>
>> Now to test this all by applying the kernel patches and the encoding
>> module BTF, looking at it, etc=2E
>>
>> - Arnaldo
>>
>
>[=2E=2E=2E]

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
