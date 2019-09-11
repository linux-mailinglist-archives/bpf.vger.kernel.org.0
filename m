Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F69AFB08
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2019 13:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfIKLCU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Sep 2019 07:02:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32840 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKLCU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Sep 2019 07:02:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so19590120ljd.0
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2019 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UnTxdulsUUoW4MpbjOz0YKEvbNh2+pBrrEt0pc1iTEY=;
        b=Ob2WcKnDVzkZwjpLgbluTx3iqYajdJ2DODeTyESW1TZpIwQOdUyjdsE56rYtwFwt2o
         vBHbj91NUsX2nOIrtjuQFtM5PvLBFXFOuX1qow3GG0qSqk48qu90ef+ZdRUE0SEODX+j
         4A5l8K0SW7YGwUIBaZ2T3+eF8n20cTVGmnJvXrWCez7G8/aw/Q4JeC2DD1qck35C0wvV
         sG/9ovLmpbqikwoeV9Bp6YBNBeZLVWS1Ol7sSgShU808PXkCBpas1n+Rq25ehBoz58Gq
         TYBRJNVkl9PPBhK1CBlnXOFsyw+qu08HMpMM/J8a9R27bRvxwAQ9yttZQ6YgmKsM0HG+
         SxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UnTxdulsUUoW4MpbjOz0YKEvbNh2+pBrrEt0pc1iTEY=;
        b=P6Bkra3N7SH1cGJH8dj9uRTDiOof4MPU8k4WGntaqWx1+LD8xNPiF8gA+PLxLG1mRf
         fxpOxBQChxeLHA0eOjnhIuaK9DOv0svcFdTAqCAcLID/OBp5QNYSkm8r5ieGr/zBX2C6
         Uxlof95oU8IRWbVnIacrQ0gdPQTgEcKOjNRTRBnCJDMY7E48V6G2zGVcDRPjvpdZcJvi
         No1j0VET6toygA5BYA7IoaiiwtrBETwofA2k9nVC9KsjzUDLRGrsToY8PYQXdB3SVMiP
         LSs5EHo0875jcRvv2SwrFDXPDjWwNBxIRz9AcCIzce0gKjyij+wisyVvfXL+mu2Dxe5y
         MCyg==
X-Gm-Message-State: APjAAAWU227IdcIUty3rs/eX+4zliK54Cqfgpsd18uEGYDjLHi3EOCzT
        mWHd3tWtAssjJTq6BKrZXcGYuA==
X-Google-Smtp-Source: APXvYqzrabH5jqIXFRRKoZkb0A3Gq2y2775Mog1g0hbWCWbCyy1Z3PbubQS3H6F+3FkRG2x9faJgfQ==
X-Received: by 2002:a2e:a303:: with SMTP id l3mr22113052lje.124.1568199738009;
        Wed, 11 Sep 2019 04:02:18 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8e6:86de:79c0:860e:c175:7d39? ([2a00:1fa0:8e6:86de:79c0:860e:c175:7d39])
        by smtp.gmail.com with ESMTPSA id b9sm4570882ljd.52.2019.09.11.04.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 04:02:17 -0700 (PDT)
Subject: Re: [PATCH bpf-next 01/11] samples: bpf: makefile: fix HDR_PROBE
 "echo"
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
 <20190910103830.20794-2-ivan.khoronzhuk@linaro.org>
 <55803f7e-a971-d71a-fcc2-76ae1cf813bf@cogentembedded.com>
 <20190910145359.GD3053@khorivan>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <4251fe86-ccc7-f1ce-e954-2d488d2a95a9@cogentembedded.com>
Date:   Wed, 11 Sep 2019 14:02:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190910145359.GD3053@khorivan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10.09.2019 17:54, Ivan Khoronzhuk wrote:

>> Hello!
>>
>> On 10.09.2019 13:38, Ivan Khoronzhuk wrote:
>>
>>> echo should be replaced on echo -e to handle \n correctly, but instead,
>>
>>  s/on/with/?
> s/echo/printf/ instead of s/echo/echo -e/

    I only pointed that 'on' is incorrect there. You replace something /with/ 
something other...

> 
> printf looks better.
> 
>>
>>> replace it on printf as some systems can't handle echo -e.
>>
>>   Likewise?

    Same grammatical mistake.

> I can guess its Mac vs Linux, but it does mean nothing if it's defined as
> implementation dependent, can be any.
 >
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> [...]

MBR, Sergei
