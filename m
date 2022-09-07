Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1FF5B0938
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIGPwV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 11:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIGPwT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 11:52:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676CB40561
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 08:52:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bj14so7826327wrb.12
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=NYzhmzD+Hlo+7fMnBjpgbj1puf06rcJdgGC2mEQ/ztA=;
        b=LDxfrhEFnmzhrhYxmVz2myek1v8Bg4MQZrIBkKNIxjNF4GsBJfYRcaNQsrLU454+Zu
         m2M2HNxKxBP3PTGgdMVhVMxjLitd7P9ehj2zQpmTRyfI1uxnISmUzWktA5MqkektQfDT
         E467PnvS767e8UOwq0biUv1X5OjAnkPx4lXNpqD0FMYx4GuCqnVOQHjZE1iX7HlR285h
         QSkmX64GTXSzBaHFD+cQzyaOEyse2CjJ1YP5YheOh0tfzQ19wjd1uihOhetibhAQCi4s
         lgF42EhjbGXR5MpUDEgTRkxmIGThCEyB/us+RykzHCPcdcVx67w+gIZxiOCfDrulW2wH
         F8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=NYzhmzD+Hlo+7fMnBjpgbj1puf06rcJdgGC2mEQ/ztA=;
        b=VFufiZ69ftxxDAt5GfOI8RK4Fr1mMfh10AxlCgd1jlOSdynKIZrQLZFNfTOLYcxD6m
         gGvuhKyDS0C/Ukv2M1ldU9grep6Q/yt5P/ykvzT3Ckpbq/UGYLeFOLphqzPzK4w8HaHb
         A15VF3bkFlSkBjH1QE5F6gYqfURw64Tr+7KtVpEA65sgulE37/Xv5ZevFwWrzm9MBjPS
         bFCbXmbgf23FjMojoup/lfPF098sAeF3ClF1/D5XkKIlJbMe0AQPi/O18RVV/QNXt36D
         awMkWM1WkJrEyryL12iu/hqvMICgb9jheHwG8zGA7dFRl6rcEocZF2l9XhZaXeXUjau1
         ZAJg==
X-Gm-Message-State: ACgBeo3/sOUOj6WWr/sJwtSIBltvy3XdBbnwVHUDaI51aI6DPhnb8V27
        fe77FfSImlPhu29Bbm54ku3i2g==
X-Google-Smtp-Source: AA6agR6Ck/iuOSME6EjZf8jow12+0iA5PATS6wY7tjSqX+x7dYs/TYvadEnR8TtfnZ08Q6C4u32vow==
X-Received: by 2002:a05:6000:18a1:b0:222:c54a:3081 with SMTP id b1-20020a05600018a100b00222c54a3081mr2463664wri.666.1662565935974;
        Wed, 07 Sep 2022 08:52:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:d023:bfe9:4cda:fa70? ([2a01:e0a:b41:c160:d023:bfe9:4cda:fa70])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b00228cd9f6349sm9500020wrw.106.2022.09.07.08.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:52:14 -0700 (PDT)
Message-ID: <953e16f5-80bd-2098-bd7f-5f4fd74ceaaa@6wind.com>
Date:   Wed, 7 Sep 2022 17:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH nf-next] netfilter: nf_tables: add ebpf expression
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20220831101617.22329-1-fw@strlen.de> <87v8q84nlq.fsf@toke.dk>
 <20220831125608.GA8153@breakpoint.cc> <87o7w04jjb.fsf@toke.dk>
 <20220831135757.GC8153@breakpoint.cc> <87ilm84goh.fsf@toke.dk>
 <20220831152624.GA15107@breakpoint.cc>
 <CAADnVQJp5RJ0kZundd5ag-b3SDYir8cF4R_nVbN8Zj9Rcn0rww@mail.gmail.com>
 <20220831155341.GC15107@breakpoint.cc>
 <CAADnVQJGQmu02f5B=mc1xJvVWSmk_GNZj9WAUskekykmyo8FzA@mail.gmail.com>
 <20220831215737.GE15107@breakpoint.cc>
 <bf148d57-dab9-0e25-d406-332d1b28f045@6wind.com>
 <CAADnVQLYcjhpVaFJ3vriDcv=bczXddRd=q83exNNPrgnvsCEAg@mail.gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <CAADnVQLYcjhpVaFJ3vriDcv=bczXddRd=q83exNNPrgnvsCEAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Le 07/09/2022 à 05:04, Alexei Starovoitov a écrit :
> On Mon, Sep 5, 2022 at 11:57 PM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
>>
>>
>> Le 31/08/2022 à 23:57, Florian Westphal a écrit :
>>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>>>> This helps gradually moving towards move epbf for those that
>>>>> still heavily rely on the classic forwarding path.
>>>>
>>>> No one is using it.
>>>> If it was, we would have seen at least one bug report over
>>>> all these years. We've seen none.
>>>
>>> Err, it IS used, else I would not have sent this patch.
>>>
>>>> very reasonable early on and turned out to be useless with
>>>> zero users.
>>>> BPF_PROG_TYPE_SCHED_ACT and BPF_PROG_TYPE_LWT*
>>>> are in this category.
>>>
>>> I doubt it had 0 users.  Those users probably moved to something
>>> better?
>> We are using BPF_PROG_TYPE_SCHED_ACT to perform custom encapsulations.
>> What could we used to replace that?
> 
> SCHED_CLS. It has all of the features of cls and act combined.

Indeed, thanks.
