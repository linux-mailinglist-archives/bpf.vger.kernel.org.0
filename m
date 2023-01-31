Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C13682C1A
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 13:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjAaMCL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 07:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaMCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 07:02:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB871CADD
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 04:02:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t18so14001113wro.1
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 04:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RH1frntibWrBNekuTq6WUaNPuNdfe6vU0X1bsy2+Qdg=;
        b=Ls/X+zcfx4546GpSppkGw6FdO2qidBU2qePgmnjMp0lpbYVufeMu5jg5vYJ1GkntIt
         RdpzvjSrUoaS0UBVA+HAXxlWbz8DLkGoCK+kKHrkBH1dbTo6JIdKKe2vVJdIosL6E2+8
         mtzcS96+2mtFauzcsdwhrebN6jl7kCdUlELGxCz5+OiLFKVqyLQkl8pFfn62kUCK5vzS
         e3nxHYgT6NsUoxsE8NDlWfFvjvGQuFHP/Rb6oNAl4SQQxGElP42Lv6y2jskyRuGemaQv
         IldWmM9FX8Iro7Zvk1ay1ZQKp+ypA2zawwPo1aS0FrkOLNBu9S7TbjBtqq0cnsyAVoEa
         rwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RH1frntibWrBNekuTq6WUaNPuNdfe6vU0X1bsy2+Qdg=;
        b=PyFoq7HpmiPB7/x7aUTGTDD3CatObTNNYfd2pd6AE5ry/gakupWMVekcRfAuwVAcBO
         iNwZmashbODwZOu+zfTXslUahCpezXOjQz6Xcy7DOEa+pysCM1Xq7IVuwYI/bPcmoDvX
         pJ6lgEZRubX/KALEpxKVFQUWhTUeCbyThZiJgg5TsIpxFBMDCd5HnUuBq9X/GkmYKLA5
         vmDkrP56Zy8ERJfs0wD6Y8P4SAT7dJBujDbiZ1luw6chNGgGvCRqnIJA2OrMWZyoGDdk
         USA+9TBrLaSezqmhnVPszAyqux9lp/yhYK9i5EDdziuaBcUfFatQNB4dEDQF/w5onuw+
         SbHg==
X-Gm-Message-State: AO0yUKXvbWzezBerkbgdyYhF0DEmPEWL4eYE6/4C/oBx+aN1WzjTjJXZ
        YUdk51Wqqu22L1ZbVjd+wghOLw==
X-Google-Smtp-Source: AK7set9d5f2zhPq8Wj0okARLa7n0kl5/dUBNMjlmii9a1rF4uu+myT6TIVWDwfrcQ50Pwr7tJBmvsQ==
X-Received: by 2002:adf:a40e:0:b0:2bf:da34:2b37 with SMTP id d14-20020adfa40e000000b002bfda342b37mr11785560wra.3.1675166527423;
        Tue, 31 Jan 2023 04:02:07 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:2c35:6e47:db1a:a1d2? ([2a02:8011:e80c:0:2c35:6e47:db1a:a1d2])
        by smtp.gmail.com with ESMTPSA id az19-20020adfe193000000b002bdc3f5945dsm1665920wrb.89.2023.01.31.04.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 04:02:07 -0800 (PST)
Message-ID: <195ea485-1449-7ed8-5184-d00cf7e0dd5b@isovalent.com>
Date:   Tue, 31 Jan 2023 12:02:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Typo in the man7 bpf-helpers page
Content-Language: en-GB
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Zexuan Luo <spacewanderlzx@gmail.com>,
        bpf <bpf@vger.kernel.org>
Cc:     linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
References: <CAADJU1032g+sNGN9AZKeVuMzZywXZ0BWpm3592XcGJdp4goCUQ@mail.gmail.com>
 <991b275a-4a44-a870-24e6-d6683bf69589@gmail.com>
 <877b57f5-77ba-805b-ed5f-57e47fa83b16@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <877b57f5-77ba-805b-ed5f-57e47fa83b16@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-01-31 12:40 UTC+0100 ~ Alejandro Colomar <alx.manpages@gmail.com>
> [Resend with Quentin's right address, I hope]
> 
> Hi Zexuan, Quentin,
> 
> On 1/31/23 11:03, Zexuan Luo wrote:
>> Hello Colomar,
>>
>> I just found a potential bug in the bpf-helpers page.
> 
> Thanks for reporting bugs :)
> 
>>
>> Under the https://www.man7.org/linux/man-pages/man7/bpf-helpers.7.html:
> 
> This page is generated from the Linux kernel sources.  I've CCed Quentin
> and the BPF list so they can check it there.
> 

Hi Alejandro, Zexuan,
Thanks for the report! Happy to take fixes, however, see below...

> BTW, I'm refreshing the page now.
> 

Great, thank you!

> Quentin, I realized in the diff that there is some inconsistency in the
> number of spaces after a sentence-ending period.  Could you please use
> two spaces for that?  It's especially important for groff(1), which will
> render it differently.   However, it's not a big issue, so don't feel
> urged to do that.

Yes, you mentioned that in the past and this is on my list. As you can
see, I haven't felt urged so far indeed :). But it's still on my mind
for the next time I take a look at this doc for typos etc.

> 
> Cheers,
> 
> Alex
> 
>>
>> ```
>>         u64 bpf_get_socket_cookie(struct sk_buff *skb)
>>
>>                Description
>>                       If the struct sk_buff pointed by skb has a known
>>                       socket, retrieve the cookie (generated by the
>>                       kernel) of this socket.  If no cookie has been set
>>                       yet, generate a new cookie. Once generated, the
>>                       socket cookie remains stable for the life of the
>>                       socket. This helper can be useful for monitoring
>>                       per socket networking traffic statistics as it
>>                       provides a global socket identifier that can be
>>                       assumed unique.
>>
>>                Return A 8-byte long non-decreasing number on success, or
>>                       0 if the socket field is missing inside skb.
>>
>>         u64 bpf_get_socket_cookie(struct bpf_sock_addr *ctx)
>>
>>                Description
>>                       Equivalent to bpf_get_socket_cookie() helper that
>>                       accepts skb, but gets socket from struct
>>                       bpf_sock_addr context.
>>
>>                Return A 8-byte long non-decreasing number.
>>
>>         u64 bpf_get_socket_cookie(struct bpf_sock_ops *ctx)
>>
>>                Description
>>                       Equivalent to bpf_get_socket_cookie() helper that
>>                       accepts skb, but gets socket from struct
>>                       bpf_sock_ops context.
>>
>>                Return A 8-byte long non-decreasing number.
>> ```
>>
>> The function bpf_get_socket_cookie repeats three times. The second one
>> should be bpf_get_socket_cookie_addr and the third one should be
>> bpf_get_socket_cookie_ops.
> 

No, I don't think there is anything wrong with that. I suppose you mean
bpf_get_socket_cookie_sock_(addr|ops) (the functions you mentioned don't
exist), but the four variants of the helper just have the same name, and
take different objects for their context. There is no risk of collision
because they are each associated to distinct eBPF program types.

Please see also commit d692f1138a4b ("bpf: Support bpf_get_socket_cookie
in more prog types"): "It doesn't introduce new helpers. Instead it
reuses same helper name bpf_get_socket_cookie() but adds support to this
helper to accept `struct bpf_sock_addr` and `struct bpf_sock_ops`.".

Thanks,
Quentin
