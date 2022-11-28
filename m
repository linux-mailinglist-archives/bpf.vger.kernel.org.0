Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBD639F63
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 03:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiK1CQt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 21:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiK1CQp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 21:16:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C750B492
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 18:16:44 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b29so9086069pfp.13
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 18:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/2P343gho5HNHVjLxV7wS8hSXo2aBB6vvazbMNjCys=;
        b=XCBbmDv6rIwqgj9fGD+bRU1QV8jjeZ0z0GIH8IR9kFNwaaxqFLThf7+JthpcrwBnB+
         YcjbB5JQtSf8zPhAlLCh+6ahZ9V2Iur7G5JH+uwlhmyIJc0ESA4swq4WC6apq4waPw51
         AcboYdsGiF1qoz0msbgwhnt4gv1KID84tlwfvdk3uKuoF+11afb7oRkk257z0mCvGiKj
         3QXEF9XKJi5wuDpURkOfEPqn6XDx46Dpat03elsHwmkvJ9GM1h4/nffjH/oI2gkkRiqo
         rpcKlgKvGj8dlKarMyM9W213GvlCSaAxaZS2HBKCsqLBriOmgRKBPyambMpTfmHZJTd0
         ZNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/2P343gho5HNHVjLxV7wS8hSXo2aBB6vvazbMNjCys=;
        b=lz63TrLCJL4Ys5htqI+tTol4eTs+ZU/cygIrUAWpocy3qYIUYsLJz4fjuK3DpQwkGA
         0V5KkeIz3kuOYt5KH5U8qD+75SqOhf5/fRdv4mOKp6Lhd8pIdb/y5IsYlANhsv42s8XD
         9NeAYPDLKZAa3K0wrxHS1m3LvUdTBosgRcctWrzL5pi8QAJ5f889AObykJWbkukjXYn0
         /unobJbOYkDhg4+DL29nY8UKNZwBIqkxshrD9XOLa/0dy/JYVinRb/GqBvIpERf4K9fo
         7I1hrb9HroIUPbp15wFovIOvAu6mtdVHPl1t6PtA/saQEzqCy3sDXzIrjs5KS9Gt1aoV
         wNtQ==
X-Gm-Message-State: ANoB5pl92oOB7XjqXLjK276CWyu5I77AbdayW1NhBVPEIMQZUUUOkWTw
        2NyMfa5xTb4pmJAD0ocg8zhXQ0FHQ/WoGQ==
X-Google-Smtp-Source: AA0mqf7jCYKqUhKRtAE0sWAKoaZvG/1P7uZYRHny8JyPfIIOoGEN+wcoroNRaLab73rkx6nO3CtSww==
X-Received: by 2002:a63:c143:0:b0:45b:f8be:7400 with SMTP id p3-20020a63c143000000b0045bf8be7400mr26175909pgi.30.1669601803833;
        Sun, 27 Nov 2022 18:16:43 -0800 (PST)
Received: from [192.168.255.10] ([43.132.98.43])
        by smtp.gmail.com with ESMTPSA id a16-20020a17090a8c1000b002135a57029dsm6471054pjo.29.2022.11.27.18.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 18:16:43 -0800 (PST)
Message-ID: <4333b0e1-c11c-05ac-97d0-ffe6dc188cf8@gmail.com>
Date:   Mon, 28 Nov 2022 10:16:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH bpf 1/2] bpf: Check timer_off for map_in_map only when map
 value have timer
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com, toke@redhat.com
References: <20221126105351.2578782-1-hengqi.chen@gmail.com>
 <20221126105351.2578782-2-hengqi.chen@gmail.com>
 <ca360165-2473-abaf-40ba-cc54345f74ec@meta.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <ca360165-2473-abaf-40ba-cc54345f74ec@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Yonghong:

On 2022/11/27 11:21, Yonghong Song wrote:
> 
> 
> On 11/26/22 2:53 AM, Hengqi Chen wrote:
>> The timer_off value could be -EINVAL or -ENOENT when map value of
>> inner map is struct and contains no bpf_timer. The EINVAL case happens
>> when the map is created without BTF key/value info, map->timer_off
>> is set to -EINVAL in map_create(). The ENOENT case happens when
>> the map is created with BTF key/value info (e.g. from BPF skeleton),
>> map->timer_off is set to -ENOENT as what btf_find_timer() returns.
>> In bpf_map_meta_equal(), we expect timer_off to be equal even if
>> map value does not contains bpf_timer. This rejects map_in_map created
>> with BTF key/value info to be updated using inner map without BTF
>> key/value info in case inner map value is struct. This commit lifts
>> such restriction.
>>
>> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>   kernel/bpf/map_in_map.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
>> index 135205d0d560..0840872de486 100644
>> --- a/kernel/bpf/map_in_map.c
>> +++ b/kernel/bpf/map_in_map.c
>> @@ -80,11 +80,18 @@ void bpf_map_meta_free(struct bpf_map *map_meta)
>>   bool bpf_map_meta_equal(const struct bpf_map *meta0,
>>               const struct bpf_map *meta1)
>>   {
>> +    bool timer_off_equal;
>> +
>> +    if (!map_value_has_timer(meta0) && !map_value_has_timer(meta1))
>> +        timer_off_equal = true;
>> +    else
>> +        timer_off_equal = meta0->timer_off == meta1->timer_off;
>> +
> 
> Is it possible we assign -1 to meta->timer_off directly instead of
> -EINVAL or -ENOENT, to indicate it does not exist? This will make
> this and possible other future timer_off comparison much easier?
> 

These error codes are checked in verifier, so didn't touch it.

>>       /* No need to compare ops because it is covered by map_type */
>>       return meta0->map_type == meta1->map_type &&
>>           meta0->key_size == meta1->key_size &&
>>           meta0->value_size == meta1->value_size &&
>> -        meta0->timer_off == meta1->timer_off &&
>> +        timer_off_equal &&
>>           meta0->map_flags == meta1->map_flags &&
>>           bpf_map_equal_kptr_off_tab(meta0, meta1);
>>   }
>> -- 
>> 2.34.1
