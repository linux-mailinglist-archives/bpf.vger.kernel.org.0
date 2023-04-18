Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E736E69C7
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 18:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjDRQnM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjDRQnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 12:43:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6FD901F
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 09:43:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f173af6712so16807395e9.1
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681836183; x=1684428183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yChDZ6lPEiZFSMHS9eZZu5Rm2GjLj4bAjIDP+NDqrok=;
        b=CbOa4jScJ2Dpm2/H1CXGGsXencDu9B2kIVkipDfkTLd/XLlNTDhzUSbbW/pkAS+Dif
         /YDMTMR7geQAeVIW/x/EYx+5573zfEXGRRQ1STYee7aLwktt4YbZhXf4td/Jp3maCShw
         sn8XzoANU9HGjhXUAQbjNzQrkcQcUfAMyEbhKRwkmY8RSZXpGTMuTWF1U8HkL1E25bfU
         Ivg1qh8b2MZ3no1bzxrdpxoIVFkcTlD19Ao8fdOqMZPWbgcYw4T9edSig+ZUYuuvuqEy
         liL2PEC10A95o4aVgw/s6mqAEyPPF7p7lWBPn/tY7dUeDiz/KzeFMFyBwIlVLRQS3+GY
         bEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681836183; x=1684428183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yChDZ6lPEiZFSMHS9eZZu5Rm2GjLj4bAjIDP+NDqrok=;
        b=cIGJhsNqQWbXAWNrQT5G+syBT0+Sashy4q5ZvA1saJnZe4XfqifADykNLCg1QaomnE
         ebWwDZy0JhansH53aHWyB/n0s2gfmTF27SL+2dOBFoMIJqguXkc2gIeFRwtqsFVyLDg2
         tpS4EMOtKss/YhV/0nkiJNmkt4NyUgSIIX05fPIspIGIX+Nrwnf7I6Tm7EZygMy2r5P6
         pQR++R0kTqDVD/m5wTud31bpTDgeI8PEs9dshS+fHTatjGp7GggZpsXjxDQSWB5ky3Y9
         hgjFyTaH43YV9wUGILYmBREJlLpJvcznKp1AajdK4rQS4rHgXJHtwpYiof7Kglzil6K8
         fGmA==
X-Gm-Message-State: AAQBX9e+nte/1fo14uFDzbjQW6GTZ2LMfAo3dd9BDI044sQsR+w9P6o9
        +5w2a9F42u+sfeJRdhnzWLPG9A==
X-Google-Smtp-Source: AKy350YrXRtEQKRX0KiVbMNZGdfeus3NG5IKjGaNEi+qAfcTFVsBugEZT/BmblP55SKeMMT1mQlNHw==
X-Received: by 2002:a5d:42d2:0:b0:2f4:e580:a72f with SMTP id t18-20020a5d42d2000000b002f4e580a72fmr2350432wrr.45.1681836182812;
        Tue, 18 Apr 2023 09:43:02 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:192d:7ca1:96c2:5c9b? ([2a02:8011:e80c:0:192d:7ca1:96c2:5c9b])
        by smtp.gmail.com with ESMTPSA id z8-20020a7bc7c8000000b003f1745c7df3sm5789492wmk.23.2023.04.18.09.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:43:02 -0700 (PDT)
Message-ID: <d940f802-8aab-140d-7a87-9cf0b3a8ac9f@isovalent.com>
Date:   Tue, 18 Apr 2023 17:43:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [backport PATCH 1/2] tools perf: Fix compilation error with new
 binutils
Content-Language: en-GB
To:     Ian Rogers <irogers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     stable@vger.kernel.org, acme@redhat.com, andres@anarazel.de,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Ben Hutchings <benh@debian.org>, Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org
References: <20230417122943.2155502-1-anders.roxell@linaro.org>
 <20230417122943.2155502-2-anders.roxell@linaro.org>
 <CAP-5=fWUevSnyn5MtVO1p6cEVE8MvBTq4Qgth7RcPYueRERQKA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAP-5=fWUevSnyn5MtVO1p6cEVE8MvBTq4Qgth7RcPYueRERQKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-04-17 10:14 UTC-0700 ~ Ian Rogers <irogers@google.com>
> On Mon, Apr 17, 2023 at 5:30 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> From: Andres Freund <andres@anarazel.de>
>>
>> binutils changed the signature of init_disassemble_info(), which now causes
>> compilation failures for tools/perf/util/annotate.c, e.g. on debian
>> unstable.
> 
> Thanks, I believe the compilation issue may well be resolved by:
> https://lore.kernel.org/lkml/20230311065753.3012826-8-irogers@google.com/
> where binutils is made opt-in rather than opt-out.

Hi,
These commits are to make it possible to build against recent binutils,
without having to leave it out at compile time, so as I understand they
address a different issue?

> 
>> Relevant binutils commit:
>>
>>   https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
>>
>> Wire up the feature test and switch to init_disassemble_info_compat(),
>> which were introduced in prior commits, fixing the compilation failure.
> 
> I was kind of surprised to see no version check ifdef. Is
> init_disassemble_info_compat is supported in older binutils?

It is not part of binutils, it was introduced in commit a45b3d692623
("tools include: add dis-asm-compat.h to handle version differences"),
which should likely be backported alongside these ones if it hasn't been
already. Possibly the others from the same series [0], as well?

I think all 5 patches from Andres' series were backported to 5.15 [1].

[0]
https://lore.kernel.org/all/20220703212551.1114923-1-andres@anarazel.de/t/#m999a44663894e235b523ffc41ce87e956019ea72
[1]
https://lore.kernel.org/all/e6e2df31-6327-f2ad-3049-0cbfa214ae5c@hauke-m.de/t/#u

Best regards,
Quentin
