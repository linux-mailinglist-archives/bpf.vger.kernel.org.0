Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C53D3E11
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 13:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfJKLQK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 07:16:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37701 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfJKLQK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 07:16:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so9442015lje.4
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ooy01geSvoqL+GgWiguG5Arr/pkbSR9LEwm6vQ6trlA=;
        b=FJGDUtGWD6dezMdpfiI3yfqw/RLXa3Cf5Y5p0xGMYaiScNsHdq6GDzLNWh5p1En1q0
         eRQtdLRr1/D6U7+Q85XT3rS2ISqQiuliJAmkF/J0fC9tO1mut3EkSl4ckQrODTRDbJdU
         SE36sc3svSCPDdHSMN0uQY3JTiTL9xr8ZTzeE4IQ0z4WYKvesc1H+lJWGNS1B3UvJgJx
         arlORLWtfcvJ3hdtQRMkK1TK2MtcjnIxaexR8VaF/1B+qtq7HkJxYQivLhERG8DBNbBl
         hQfb0LW2/xY1uof3a5oa/f9swp/JrzNMd0ITcgQudf+WS9jFD7yBHeENt5IvXwF77pU0
         to2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ooy01geSvoqL+GgWiguG5Arr/pkbSR9LEwm6vQ6trlA=;
        b=Pmyn66bEcJHK37SxvVDwvRq73dXbQk/QesqGNFYELemrfYmtetYrKa/nHOy6Gjim/j
         qqQd2SyLI1xWJfFyjZCltQL/d8Fny7kcQXEFXTRng1GZmnOGhiweeDQC0nGq9GPaluH1
         Fk+BJB96anlKxqegGxQsFoUPea+1+FVX696kLOLTDkQvmTLkPVg0Iith9NpPjismgGf1
         ZISxIvDT4/Ifr9jKXubR4s1RPP2042vx8Suk8L8aGMXUs7dmMAvQ/Gm7+qhasBHwPeFg
         jar3yKPRpipsQ/2TtpOSYhRGqUdp4PPKPkP0BVanr47qA7SyyUgsFENvv+/G6XmPmkTZ
         tgLQ==
X-Gm-Message-State: APjAAAVaLcN/nxA38uXaZoLotp6m6KpEhC/q23XX0iLX3b4OfbaIvA8C
        g2oTsOLz60xMrm78OgSkAHRXSQ==
X-Google-Smtp-Source: APXvYqz+u6eneONfnjvqqaE8Uh0If4lrYaqqjy+4UFFpkLHI7cc3rLwOyRGvWtm0ePCkEkvTKscC4w==
X-Received: by 2002:a2e:569a:: with SMTP id k26mr9075699lje.256.1570792567730;
        Fri, 11 Oct 2019 04:16:07 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4430:5cc6:e6ed:2da1:4d7:1d29])
        by smtp.gmail.com with ESMTPSA id q26sm1857253lfd.53.2019.10.11.04.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 04:16:06 -0700 (PDT)
Subject: Re: [PATCH v5 bpf-next 09/15] samples/bpf: use own flags but not
 HOSTCFLAGS
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
 <20191011002808.28206-10-ivan.khoronzhuk@linaro.org>
 <99f76e2f-ed76-77e0-a470-36ae07567111@cogentembedded.com>
 <20191011095715.GB3689@khorivan>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <3fb88a06-5253-1e48-9bea-2d31a443250b@cogentembedded.com>
Date:   Fri, 11 Oct 2019 14:16:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20191011095715.GB3689@khorivan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/11/2019 12:57 PM, Ivan Khoronzhuk wrote:

>>> While compiling natively, the host's cflags and ldflags are equal to
>>> ones used from HOSTCFLAGS and HOSTLDFLAGS. When cross compiling it
>>> should have own, used for target arch. While verification, for arm,
>>
>>   While verifying.
> While verification stage.

   While *in* verification stage, "while" doesn't combine with nouns w/o
a preposition.

>>> arm64 and x86_64 the following flags were used always:
>>>
>>> -Wall -O2
>>> -fomit-frame-pointer
>>> -Wmissing-prototypes
>>> -Wstrict-prototypes
>>>
>>> So, add them as they were verified and used before adding
>>> Makefile.target and lets omit "-fomit-frame-pointer" as were proposed
>>> while review, as no sense in such optimization for samples.
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> [...]

MBR, Sergei
