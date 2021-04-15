Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246DE360435
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 10:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhDOIZk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 04:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhDOIZj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 04:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618475115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bQmWZhJFBGurEcgsfC0EuOHiXGG/UZMr42BKHCg0CM=;
        b=FrLbKiWI78+iV+MeIABfx+K9zAaRG/DDZJY6QU8LGlMryR2JBVkthmbJWj0GSj+fyfxu1w
        kCoD4Jofj26FBTwiLgkIoqTirJOGbYiH9fKKAYiCJPDTeOJ2CR423ZNrzaFetgEubFODyr
        RsvI7E0cksB0klAXaN6FDIZrz35Z4eA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-5mzOXTbQO-i-OXy1guL6_w-1; Thu, 15 Apr 2021 04:25:14 -0400
X-MC-Unique: 5mzOXTbQO-i-OXy1guL6_w-1
Received: by mail-ed1-f71.google.com with SMTP id f9-20020a50fe090000b02903839889635cso2811470edt.14
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 01:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/bQmWZhJFBGurEcgsfC0EuOHiXGG/UZMr42BKHCg0CM=;
        b=OW3/LBZdYGrDRsYDPuG05F21JZ2D99xHbRL+oghJaBoDDAi51rtO15mR2MPdt2NZNm
         lFpv56Y3zqkS7L80uZkUwo45KI1NlP6nQtTImZtFAkT+lPUNZ+VxZRzDUljpAW2fWzcG
         2/IEw8ymcxHWym1IPh8hVG5HvZ4dLOZoaDu9YBRrV1UVxSFmw9vZRKJJq41qHgaSEHnM
         fe1X+RHTYKwGZIsCovj2m9uMCTtj+D3H6N91Hd2rssxSVO0Urxb37m2e5Jyab6wATZYx
         XGAf1DNnuiobIfoiaHYmBsZjAJClIyggittsMGjU1851rMKWLj/g4kjIHEdc/HKx65L4
         NWyQ==
X-Gm-Message-State: AOAM5310vONnmA8zpKRw9amDPmq+8U8bv04jMKz6id5yyOc+5xvEYRzN
        Nyh3bqSAj+rqc8jwpJVG+Oc1FpmuKEGu7Ams32ml3WLqx8waL0yUlIBicAwUZqD+d1PRLMcoZ1x
        aRA2X6pzoO0YT
X-Received: by 2002:a17:906:fb90:: with SMTP id lr16mr2188975ejb.173.1618475113128;
        Thu, 15 Apr 2021 01:25:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV9d4Hf8P/msHacfoZkJ3KBX3z8yqEirLBflCXrob29FKDQvETDro/hTdN8fxJUXyuYv/GnQ==
X-Received: by 2002:a17:906:fb90:: with SMTP id lr16mr2188956ejb.173.1618475112977;
        Thu, 15 Apr 2021 01:25:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id bm13sm1380535ejb.75.2021.04.15.01.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 01:25:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] tools: do not include scripts/Kbuild.include
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Harish <harish@linux.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Networking <netdev@vger.kernel.org>
References: <20210415072700.147125-1-masahiroy@kernel.org>
 <20210415072700.147125-2-masahiroy@kernel.org>
 <9d33ee98-9de3-2215-0c0b-cc856cec1b69@redhat.com>
 <CAK7LNAQupbmeEVR0njSciv0X9FD+MofeB2Xm=wprEdNaO4TQKQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e46231f-1d30-6a6f-c768-f34295376d0a@redhat.com>
Date:   Thu, 15 Apr 2021 10:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQupbmeEVR0njSciv0X9FD+MofeB2Xm=wprEdNaO4TQKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15/04/21 10:04, Masahiro Yamada wrote:
> On Thu, Apr 15, 2021 at 4:40 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> I think it would make sense to add try-run, cc-option and
>> .DELETE_ON_ERROR to tools/build/Build.include?
> 
> To be safe, I just copy-pasted what the makefiles need.
> If someone wants to refactor the tool build system, that is fine,
> but, to me, I do not see consistent rules or policy under tools/.

"Please put this in a common file instead of introducing duplication" is 
not asking for wholesale refactoring.

Paolo

