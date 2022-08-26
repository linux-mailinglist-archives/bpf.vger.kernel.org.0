Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270045A24C2
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiHZJo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 05:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZJow (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 05:44:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069DB10DA
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 02:44:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bu22so806536wrb.3
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qd5AnmilPeZpQVWOQ65abWICFK7H+8SyCqEMxoxsAg8=;
        b=EnXqy5udCV+nplY4NQGSj4RUXGRxWKtSFSFvHMseMgpfzKz0bbwRyEsNnTNHJMJI7L
         dCubOK3qsaewnYtsmlZz9GvnEWIT7rPC3njQmj1UdyCjbZ+3AD9u1tWdNHIC4ZvdUWhJ
         +ae29cG36fB3LFhVAF8LQuatUlCzfzA3QqEC2yNQlF8P02SJzQ3Yg5A1rr/kXGDbEfgU
         DrsKiswkb493IN5Ij7cHf6RhuqfcoNVsRU49kWKrTmdJJukcPxQE7ElyebiJ5Zbxg9C/
         ZoBNfClE7pWLHAULRYRbdn/XlFDZ4YLj7WMkmUzvLR2NfXMsGFZNzeANawExA+PvQrL+
         Ol9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qd5AnmilPeZpQVWOQ65abWICFK7H+8SyCqEMxoxsAg8=;
        b=ALORozAo4DqvtlP6/fDwHkpeVv/gb6exuCZ3/Qn6BGzgd20yZkkQzq8fe+84rcLBWi
         a6U0Qp4IxYJvFalokU8E4WuIhl1lC44sMYavsgXEMsMx/7lsFmt+rxyQQq3nkqxv7g+y
         lVi/ozrQs2VL/ed0kcD0h30AHK6wr1Qyk6Dgqatjl0mDs6l0ll1h4kgCXDv/vayszbgj
         q7KpSyrIs4muON3dFudwpdnXhP8pS2NI5mHfZFriQ3Oi4sl5EZgze4RYhC0bQ3F3dkqh
         jBX8OrD/FPwIwzk5k8LJJrCRHnE7HL4NSzNSMWhNYKk7SEKZghT4GY0xqZdtQTRifI4a
         bTIA==
X-Gm-Message-State: ACgBeo2MIQ6p+B48cbatIFCdmV4AcxzremsPcgP3b1J5oB7r3conJTzu
        3dOhEYHri94W/uIH1KnvQkLprg==
X-Google-Smtp-Source: AA6agR77l6rDkXBMPtdxHS+CsZ6ClvTYWi8ckWmUFtvl9WQkBAmIHk+NAkOG+5bHMjopXfkILl0Iww==
X-Received: by 2002:adf:ee4c:0:b0:222:c3bb:560c with SMTP id w12-20020adfee4c000000b00222c3bb560cmr4423573wro.584.1661507088512;
        Fri, 26 Aug 2022 02:44:48 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id v64-20020a1cac43000000b003a5fcae64d4sm1917408wme.29.2022.08.26.02.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:44:48 -0700 (PDT)
Message-ID: <c94959da-67f6-da66-1d46-ae9dfdc0e674@isovalent.com>
Date:   Fri, 26 Aug 2022 10:44:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH bpf-next v3] bpf: Fix a few typos in BPF helpers
 documentation
Content-Language: en-GB
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Jakub Wilk <jwilk@jwilk.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linux-man@vger.kernel.org
References: <20220825220806.107143-1-quentin@isovalent.com>
 <ebbae976-b452-c359-fd67-5b0511c3ef10@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ebbae976-b452-c359-fd67-5b0511c3ef10@gmail.com>
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

On 25/08/2022 23:12, Alejandro Colomar wrote:
> Hi Quentin,
> 

>> - *        ctx. Providing an *len_diff* adjustment that is larger than
>> the
> 
> I just noticed:  groff(1) uses double spaces after an end-of-sentence
> period.  Otherwise, it is understood as something like initials, or an
> abbreviature, and it causes some issues.  Please check the whole
> document, as I've seen a mix of styles.
> 
> Search for something like '.\. [^ ]'

This is a strange restriction in my opinion, but I can look into this as
a follow-up. I've not noticed issues with the rendered page so far, out
of curiosity what issues are we talking about?

Also before that, it would be good to sync and see what other formatting
elements need be addressed on the page, so we can fix them in a batch
rather than submitting them one after the other like we're doing.

Quentin
