Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313E576314
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiGONu4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 09:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGONuz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 09:50:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D4F7FE5B
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 06:50:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i204-20020a1c3bd5000000b003a2fa488efdso4591139wma.4
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vP/l3glhlYhBppdKngJI0J7ugdtAGGvaC+UoPFCMETc=;
        b=tR3fBT7JpGE5DfgO2Zcwlp3u0nPCluwTDW1z16bdHLWLQbKR1NkC6ewPRFiRoL8rKA
         T/iiWbQvNxGU5W+kN9rZIQqI1CzQOUjqgiVaqYHIr2mXn5f84Xrf/Y8Ia8AytrOuycyO
         fW4RpigqbLWAml3+mGuRs04yz3KfkBB/SB3DL9ru6akW4wbeXxLGGprT2AV8MNICXATn
         nUyopU5U880X1AVMkZ8BJdccFK1i0tnexvgOoDA7VnOKaO35yhDXSjrMOiLaVxiY9yvL
         +3p0rMwQDmdabDKg+8mBgDUdWDz98hPde5mFY8RwoYjSv1LEIGZzdttTnnGO9qb5c7Kk
         3gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vP/l3glhlYhBppdKngJI0J7ugdtAGGvaC+UoPFCMETc=;
        b=Svw02d+oGK1oFMK0jCeR86qf8xrB5RcJ5zqn9koNNHL9SeW4RkVQlWP/VyzCM1y6Ig
         GLQny5hYzbeazzOA29hHvVKHqqnOKC3T5+ZpY7/R3T/Hx6mlemtM4FNZeb4brGPCjRIX
         v/6j+PGjd98LqMM6dx+bIVlArMvHUxQrwrzQLQZR58oihbV/NX/wHOS1pQ+7C33dMOZd
         SV3xbjo29Q0nit7y/zPa/Kkh6Jn1u4xtdigH/IY15xz6AjMvu/AEmEeDmAo12RfO+e9p
         cexImvPMsOfCRk65tojKBvGN0Tbbc1W1jm3tMD/uvCzcyJB25Jfe9unP2cYs7kM06kOi
         wMkA==
X-Gm-Message-State: AJIora/Cp+x89rHQtRwJrC8+qmNWvZvicgjO5GliVRbcCrZPA0kp6PqD
        bIK9b9eu0grE6fIbUn4/0Tz5pQ==
X-Google-Smtp-Source: AGRyM1v4Tc1bgx1DR6mEf/aCSbjBGbNZli3lQTizrsAZjNMPie7jqk2CeAkATbQQnjykrG1tpdyzmA==
X-Received: by 2002:a05:600c:190a:b0:3a2:e8cc:57ca with SMTP id j10-20020a05600c190a00b003a2e8cc57camr14613105wmq.118.1657893052171;
        Fri, 15 Jul 2022 06:50:52 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003a310631750sm782983wmq.35.2022.07.15.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 06:50:51 -0700 (PDT)
Message-ID: <e167c21e-c448-634c-992f-141bbcdf637d@isovalent.com>
Date:   Fri, 15 Jul 2022 14:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH bpf-next v1] bpf: fix bpf_skb_pull_data documentation
Content-Language: en-GB
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org
References: <20220714224721.2615592-1-joannelkoong@gmail.com>
 <43bbdc5a-000d-0aed-f325-2b942aa1fc02@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <43bbdc5a-000d-0aed-f325-2b942aa1fc02@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15/07/2022 14:43, Daniel Borkmann wrote:
> On 7/15/22 12:47 AM, Joanne Koong wrote:
>> Fix documentation for bpf_skb_pull_data() helper for
>> when flags == 0.
>>
>> Fixes: fa15601ab31e ("bpf: add documentation for eBPF helpers (33-41)")
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> ---
>>   include/uapi/linux/bpf.h       | 3 ++-
>>   tools/include/uapi/linux/bpf.h | 3 ++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 379e68fb866f..a80c1f6bbe25 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -2361,7 +2361,8 @@ union bpf_attr {
>>    *         Pull in non-linear data in case the *skb* is non-linear
>> and not
>>    *         all of *len* are part of the linear section. Make *len*
>> bytes
>>    *         from *skb* readable and writable. If a zero value is
>> passed for
>> - *         *len*, then the whole length of the *skb* is pulled.
>> + *        *len*, then all bytes in the head of the skb will be made
>> readable
> 
> Quentin, should the formatting be '*skb*' instead of 'skb'?

Correct

> Maybe it's more clear if we speak of 'all bytes in the linear part'
> instead of 'all
> bytes in the head' of the skb to make it clearer? Either is ok with me
> though.

Good suggestion, “linear part” is maybe easier to understand given that
the paragraph has no other mention the “head”.

Would it be worth, even, linking to e.g. Dave's doc
(http://vger.kernel.org/~davem/skb.html) here, to provide more details?
People reading the header file may not need that, but folks reading the
generated man page may not be aware of what a skb contains.

Quentin

