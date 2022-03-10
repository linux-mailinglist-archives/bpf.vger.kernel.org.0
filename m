Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69034D4E26
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 17:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiCJQHe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 11:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbiCJQH3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 11:07:29 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC2B187E2F
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 08:06:17 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o26so5085032pgb.8
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 08:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=vPDslFAB2WX3+89jiOl8aHGYg43S9qtM0t31/Go73nE=;
        b=k3V0lcgRuAv9K/+lHB10VICnm56R5wMnlGzfUklzmF9p0UV9qKSYyidKibFeSTzT2x
         tKj7rN1wFW/EZWJDGRenXI2nj/uDIFh5liIn5Tt60CaxkXp5nWeKjH+681f51xaDlLlm
         L3i3C5dBYYFr9ZxaIMzIo9+KN6qI5r4mnFaXl8Mp7Y4AbKH1kauCgvgrq0xCn4hM/ztH
         W7jAJHgPGjGt5O52Ri3GSWGdAahrqISrz3v9RwQgTpHNK7WuEAhOr+h6YSh8REfJoDk4
         rXDPWXOuzYMFYl5jJF7TAF0zPhMxlFhUYH8S53eHIvzfw1XoGEo8wWbQNgB0uCDVv+Me
         dCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=vPDslFAB2WX3+89jiOl8aHGYg43S9qtM0t31/Go73nE=;
        b=AfQAL0P57ibYFZmIVLykMWHquMJSR885O5q33M/czO8UWKPDuJ5h9hW43XZ/gPEvK0
         I/KiFGqbWethphqja1XufRfJPMdLTP3s8bb301oS7a8sbUYBq7BAl7x20iVjYO9cGqGL
         3SviEtljSi/XS5f9gNhYvRFCO6Me77lD8sN0GiirJDz4EQdEm4jYtr/UyY6L4HfVreaf
         /2LouCqmKqzkG6miyb0gq9R578/W1HJASN6ST7HXNIdQsvvQgk5zyl6Rwrhmf7bgrFjJ
         qhKjZx/lGkvMNuf7Q1+teuhXUuz0XqmaoLzuwkCWmRgY9t+t3BhWZZt1avDoYD5ivcU3
         bv6Q==
X-Gm-Message-State: AOAM530etrRZ8UbhhMUwmaYxaDaJfNojDqkKgHptOVQxvt7fsbXsBhaz
        lprmeL+aCtrxoRul83utomQNAA==
X-Google-Smtp-Source: ABdhPJyaDcNJcH+wL4U0Rhh+k9fHnNTSq6Fc2Z873WTTA4inyitRWePsEBand1h8+e22kSXNjq+VHA==
X-Received: by 2002:a63:6a49:0:b0:37c:7a6e:e7a6 with SMTP id f70-20020a636a49000000b0037c7a6ee7a6mr4615349pgc.545.1646928377027;
        Thu, 10 Mar 2022 08:06:17 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id w204-20020a627bd5000000b004f6f70163e8sm7148989pfc.31.2022.03.10.08.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 08:06:16 -0800 (PST)
Message-ID: <c7608cf0-fda2-1aa6-b0c1-3d4e0b5cad0e@linaro.org>
Date:   Thu, 10 Mar 2022 08:06:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     David Ahern <dsahern@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "syzbot+e223cf47ec8ae183f2a0@syzkaller.appspotmail.com" 
        <syzbot+e223cf47ec8ae183f2a0@syzkaller.appspotmail.com>
References: <20220308000146.534935-1-tadeusz.struk@linaro.org>
 <14626165dad64bbaabed58ba7d59e523@AcuMS.aculab.com>
 <6155b68c-161b-0745-b303-f7e037b56e28@linaro.org>
 <66463e26-8564-9f58-ce41-9a2843891d1a@kernel.org>
 <45522c89-a3b4-4b98-232b-9c69470124a3@linaro.org>
 <ff2e1007-5883-5178-6415-326d6ae69c34@kernel.org>
 <8fdab42f-171f-53d7-8e0e-b29161c0e3e2@linaro.org>
 <CA+FuTSeAL7TsdW4t7=G91n3JLuYehUCnDGH4_rHS=vjm1-Nv9Q@mail.gmail.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH] net: ipv6: fix invalid alloclen in __ip6_append_data
In-Reply-To: <CA+FuTSeAL7TsdW4t7=G91n3JLuYehUCnDGH4_rHS=vjm1-Nv9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/10/22 06:39, Willem de Bruijn wrote:
> On Wed, Mar 9, 2022 at 4:37 PM Tadeusz Struk <tadeusz.struk@linaro.org> wrote:
>>
>> On 3/8/22 21:01, David Ahern wrote:
>>> On 3/8/22 12:46 PM, Tadeusz Struk wrote:
>>>> That fails in the same way:
>>>>
>>>> skbuff: skb_over_panic: text:ffffffff83e7b48b len:65575 put:65575
>>>> head:ffff888101f8a000 data:ffff888101f8a088 tail:0x100af end:0x6c0
>>>> dev:<NULL>
>>>> ------------[ cut here ]------------
>>>> kernel BUG at net/core/skbuff.c:113!
>>>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>>>> CPU: 0 PID: 1852 Comm: repro Not tainted
>>>> 5.17.0-rc7-00020-gea4424be1688-dirty #19
>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35
>>>> RIP: 0010:skb_panic+0x173/0x175
>>>>
>>>> I'm not sure how it supposed to help since it doesn't change the
>>>> alloclen at all.
>>>
>>> alloclen is a function of fraglen and fraglen is a function of datalen.
>>
>> Ok, but in this case it doesn't affect the alloclen and it still fails.
> 
> This is some kind of non-standard packet that is being constructed. Do
> we understand how it is different?
> 
> The .syz reproducer is generally a bit more readable than the .c
> equivalent. Though not as much as an strace of the binary, if you
> can share that.
> 
> r0 = socket$inet6_icmp_raw(0xa, 0x3, 0x3a)
> connect$inet6(r0, &(0x7f0000000040)={0xa, 0x0, 0x0, @dev, 0x6}, 0x1c)
> setsockopt$inet6_IPV6_HOPOPTS(r0, 0x29, 0x36,
> &(0x7f0000000100)=ANY=[@ANYBLOB="52b3"], 0x5a0)
> sendmmsg$inet(r0, &(0x7f00000002c0)=[{{0x0, 0x0,
> &(0x7f0000000000)=[{&(0x7f00000000c0)="1d2d", 0xfa5f}], 0x1}}], 0x1,
> 0xfe80)

Here it is:
https://termbin.com/krtr
It won't be of much help, I'm afraid, as the offending sendmmsg()
call isn't fully printed.

-- 
Thanks,
Tadeusz
