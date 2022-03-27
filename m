Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937FF4E8A5F
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 00:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiC0WFb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Mar 2022 18:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiC0WFb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Mar 2022 18:05:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93422B17
        for <bpf@vger.kernel.org>; Sun, 27 Mar 2022 15:03:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so17844851wru.4
        for <bpf@vger.kernel.org>; Sun, 27 Mar 2022 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kepb6Q4dMaY4st+OER5akUGXYCQVluZrL0BsXU/5dSY=;
        b=RAllcjWLuYQalVkKdJ1IfOIE4Qh2kt2CpIthana8CsX7n6ywE0f0MhfqcMCcvQkD1W
         6nESiDGHr2wDfwXUuNo5k0KQ4qkq+kNsMQ6Nu7wj8/Hd7hpQZg5OxgFyFYy9GkELuBv0
         /U0J6xo9HpHVJsbeWYrU8L5c3CqP+RTEutAvfJi8VGQxnCDhG0p3Hh/1hYr/WmL6NyLZ
         WETH9PiQ8rLIkr7c01Nh1G6h9xompWmsB57m0nO72CzBMod5Gb74fU4NIIq2rrkX2NCj
         bXLhohCaDlUGSg8gbV5lzRocmnRGjkPl9w7o3rrJ654K8Jcukq3hvNjq1h7u8eKc1+iV
         Fhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kepb6Q4dMaY4st+OER5akUGXYCQVluZrL0BsXU/5dSY=;
        b=fAmqPYMsmPCKduZdGCUX1/ecdtYu1H073FtpLoSktip5ko+rWm0TjgLRynMwQxxfEE
         y7tuPSWFdoNgvbeMABaZX58aTd3z6aU/iaFvQ7dJTNNvk7QMSOfyK6Xn4TiJdmRzaPSt
         r2mRXvyd43AQslolTS0kH9eq4Hwu/RysBMRY2T3jNIN55a3NhfHO+h1BQpu9tUFghsvz
         DVkfxgl+yfQ7IIZgXV39BdK7NeT1xkUADgejB8O/f5avzfqhNEF9nvKnpAyhiK2KtYJg
         O54MfbLX9msLKt61rAnFkGuXLZTSKDt+tl+jnSiATj7WCnx/v/1Lqy9aIqevOh08+5xL
         F6Pg==
X-Gm-Message-State: AOAM531fOc+XHYPHqMRy940C4EaTW6ns2wvOon/Fl9r90+EMa5V9Kwi5
        cgXs84YKv6XcSo7Wgv6+NfVR+g==
X-Google-Smtp-Source: ABdhPJze78ciHB5L0PCDrlmqysqWQsQV/dAJ9GOnwo8Zr4iz6hRjbHEU1fC/wn/2KtfZ3IVWQeSZcw==
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id n4-20020a056000170400b00203d857aa7amr18556351wrc.513.1648418630223;
        Sun, 27 Mar 2022 15:03:50 -0700 (PDT)
Received: from [192.168.178.8] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id az26-20020adfe19a000000b00204154a1d1fsm10527866wrb.88.2022.03.27.15.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 15:03:49 -0700 (PDT)
Message-ID: <6b558a11-7f5e-8a4e-b70b-e4c7d3c3e052@isovalent.com>
Date:   Sun, 27 Mar 2022 23:03:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
Content-Language: en-GB
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com
References: <20220309163112.24141-1-9erthalion6@gmail.com>
 <a9a2c8ba-ff17-eafe-5cf4-32e5ef19b656@isovalent.com>
 <20220326090834.f7ukfgjyfhk6sbws@erthalion.local>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220326090834.f7ukfgjyfhk6sbws@erthalion.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-03-26 10:08 UTC+0100 ~ Dmitry Dolgov <9erthalion6@gmail.com>
>> On Sat, Mar 26, 2022 at 01:38:36AM +0000, Quentin Monnet wrote:
>> 2022-03-09 17:31 UTC+0100 ~ Dmitrii Dolgov <9erthalion6@gmail.com>
>>> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
>>> BPF perf links") introduced the concept of user specified bpf_cookie,
>>> which could be accessed by BPF programs using bpf_get_attach_cookie().
>>> For troubleshooting purposes it is convenient to expose bpf_cookie via
>>> bpftool as well, so there is no need to meddle with the target BPF
>>> program itself.
>>>
>>> [...]
>>>
>>> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
>>> index 7c384d10e95f..bb6c969a114a 100644
>>> --- a/tools/bpf/bpftool/pids.c
>>> +++ b/tools/bpf/bpftool/pids.c
>>> @@ -78,6 +78,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>>>  	ref->pid = e->pid;
>>>  	memcpy(ref->comm, e->comm, sizeof(ref->comm));
>>>  	refs->ref_cnt = 1;
>>> +	refs->has_bpf_cookie = e->has_bpf_cookie;
>>> +	refs->bpf_cookie = e->bpf_cookie;
>>>
>>>  	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
>>>  	if (err)
>>> @@ -205,6 +207,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
>>>  		if (refs->ref_cnt == 0)
>>>  			break;
>>>
>>> +		if (refs->has_bpf_cookie)
>>> +			jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
>>> +
>>
>> Thinking again about this patch, shouldn't the JSON output for the
>> cookie(s) be an array if we expect to have several cookies for
>> multi-attach links in the future?
> 
> Interesting point. My impression is that this could be done together
> with the other changes about making multi-attach links possible (I
> didn't miss anything, it's not yet implemented, right?). On the other
> hand I'm planning to prepare few more patches in similar direction -- so
> if everyone agrees it has to be extended to an array now, I can tackle
> this as well.

Correct, it's not implemented yet for multi-attach links. My concern
here is to avoid changing the JSON structure in the future (to avoid
breaking changes for tools that would process the JSON). If we know
we're likely to have several cookies in the future, it may be worth
using an array “from start” (since no version has been tagged yet after
you added support for the cookie).

Quentin
