Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65F35A0BF4
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiHYI4N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 04:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHYI4M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 04:56:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BE1A7AAA
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 01:56:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k9so23720435wri.0
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=n/sV1XGkeUrQ//2+1uRG3XzR/P0GxC0cxmv211880No=;
        b=YvXqJonVZ40GkjYopq7LgFe+ERU7hpyacYUfyhEA0t3WyzRyNCNOYeheg75dVK3MCX
         CqjUs/x1IUvTFYUKrSvnNrKJvD612opvYbN9CBBt2d0rvzwjk/3MRDYIkVlda9jglNOh
         b6Pn7m67ePRtewjZlV+VBwlE68mRmdf0XDx4SOzF2UOv4LsiOGHm387bwRBKMB5YD5T3
         GlXjBUaRfCKT5yQVZGj1kfZKv0Gfgmxqf4H6/GNllFoctAU4EnyZNy+l9p8KOSMriBK1
         sxziAjsEWX7f0p2Gy6XVX1nBPBMA5o/dtusRDJ4F3Hk62qLaDY7PjWJsrynaoTqGo/YU
         uKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=n/sV1XGkeUrQ//2+1uRG3XzR/P0GxC0cxmv211880No=;
        b=fInFMQOW66VF7RByd7HqQ3Rc4wTo/rGGuJ92IdKZc13howzMsOMz4AuTyWeBbLPm+N
         lpd72vW2kE1ZrpxSvg77etM2KaIG3nY0JPiyWf69VUtAakMpaJ8xc9L5z9WKklgWond8
         qZQUs04D1ivX4tvya1GahwjIqPfEPaPpwp35aiZ4zakVSI6KM3CvFkMTeLBOVeljCpVU
         UppUJ5L7AIhajDplBO8JlMoX6H2NWp8WIo4UANg0WP3Yki6v0euWtko6giQhjPhDnlt5
         qIbYSnvceilOFVA9QyaHhsUtdcIsBT6AdDjpbj/aCM5F5iUJvPkC7GmhnfAotxieSkoi
         X8AA==
X-Gm-Message-State: ACgBeo2C5N96qT4WCvZUL27euoKSgF3tUKDfD9imsyq9AwRFeVPky1pn
        46u1+Sqle4hw5o8ngkk80iPk7Q==
X-Google-Smtp-Source: AA6agR62hihJTrIMkeZGa/dfjJlhT3Xr6nn8kZzppRyO5zz+x7SOgzPsvIfhwEiWcYFCwWbp99Gahw==
X-Received: by 2002:a5d:6290:0:b0:225:739f:9a7c with SMTP id k16-20020a5d6290000000b00225739f9a7cmr1508771wru.630.1661417769746;
        Thu, 25 Aug 2022 01:56:09 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c1d8700b003a5bd5ea215sm4736809wms.37.2022.08.25.01.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:56:09 -0700 (PDT)
Message-ID: <e510b3f8-ed6c-55c7-3585-2e065324ae85@isovalent.com>
Date:   Thu, 25 Aug 2022 09:56:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] bpftool: fix a wrong type cast in btf_dumper_int
Content-Language: en-GB
To:     John Fastabend <john.fastabend@gmail.com>,
        Lam Thai <lamthai@arista.com>, bpf@vger.kernel.org
References: <20220824225859.9038-1-lamthai@arista.com>
 <630716d02ebbe_e1c39208c3@john.notmuch>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <630716d02ebbe_e1c39208c3@john.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/08/2022 07:29, John Fastabend wrote:
> Lam Thai wrote:
>> When `data` points to a boolean value, casting it to `int *` is problematic
>> and could lead to a wrong value being passed to `jsonw_bool`. Change the
>> cast to `bool *` instead.
> 
> How is it problematic? Its from BTF_KIND_INT by my quick reading.

Hi John, it's an INT but it also has a size of 1:

    struct map_value {
       int a;
       int b;
       short c;
       bool d;
    };

    # bpftool btf dump id 1107
    [...]
    [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
    [...]
    [12] STRUCT 'map_value' size=12 vlen=4
            'a' type_id=2 bits_offset=0
            'b' type_id=2 bits_offset=32
            'c' type_id=13 bits_offset=64
            'd' type_id=14 bits_offset=80
    [13] INT 'short' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
    [14] INT '_Bool' size=1 bits_offset=0 nr_bits=8 encoding=BOOL
    [...]

And Lam reported [0] that the pretty-print for the map does not display
the correct boolean value, because it reads too many bytes from this
*(int *)data.

    # bpftool map dump name my_map --pretty
    [{
            "key": ["0x00","0x00","0x00","0x00"
            ],
            "value":
["0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
            ],
            "formatted": {
                "key": 0,
                "value": {
                    "a": 0,
                    "b": 0,
                    "c": 0,
                    "d": true
                }
            }
        }
    ]

The above is before the map gets any update. The bytes in "value" look
correct, but "d" says "true" when it should be "false". So bpf tree
would make sense to me.

[0] https://github.com/libbpf/bpftool/issues/38

> 
>>
>> Fixes: b12d6ec09730 ("bpf: btf: add btf print functionality")
>> Signed-off-by: Lam Thai <lamthai@arista.com>
>> ---
> 
> for bpf-next looks like a nice cleanup, I don't think its needed for bpf
> tree?
> 
>>  tools/bpf/bpftool/btf_dumper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
>> index 125798b0bc5d..19924b6ce796 100644
>> --- a/tools/bpf/bpftool/btf_dumper.c
>> +++ b/tools/bpf/bpftool/btf_dumper.c
>> @@ -452,7 +452,7 @@ static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
>>  					     *(char *)data);
>>  		break;
>>  	case BTF_INT_BOOL:
>> -		jsonw_bool(jw, *(int *)data);
>> +		jsonw_bool(jw, *(bool *)data);

Looks good, thanks
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
