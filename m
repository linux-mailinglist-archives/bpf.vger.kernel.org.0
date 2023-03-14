Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEDB6B88F9
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 04:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCND2Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 23:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCND2P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 23:28:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D21A198;
        Mon, 13 Mar 2023 20:28:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id y2so14058324pjg.3;
        Mon, 13 Mar 2023 20:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678764493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93rd96BjgMlpU5IthE9kWjrvD+BqUiDl/rlOq7m9Vj8=;
        b=CwsNNQnBgAg+gdDYFYgEquNx2e4ImAskMB1eJVNnfQztFaMw0dw/qtSvSRowihQSWO
         aibAJucptsuU+O/9HNgs5Ogm6erolFNhpZHCfwIPYCZWJTYTGaJ2SWVfZcCi66J6KHQZ
         G60Dj8k/Qhnjb3cQ0ySze57uR1A6q9SYZ+ydNtTqAihhOfXkTDF9Ptal6Wctkk8hd/w4
         kmiFxHONQBWX26zrwDwTzoG922NO1Vwqt7pE3YHo4pRuPYNstPCznJ99WyR+GDWNO/jc
         ppWhQFLmehgpEWw7iKt3ZTL3xcPdK7lGdGvnL1EnvO6VmW5ff6i1xPiGEudnVHWfCpHl
         jLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678764493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93rd96BjgMlpU5IthE9kWjrvD+BqUiDl/rlOq7m9Vj8=;
        b=LNCQfYFgG/P8ZPYqphMtXRzg/x1XsDBEVmcWnrBYfLEwv/Q0UXD02M5usH5fwVkS3t
         Y29mMpry9NcCdd5XSkSOUwLpneTTRG7A4cU00Km55XJPbC+ycGshYIYdKZWG/+RYgrYL
         vCM7hyBhm01zhpDjMi94V0OHKgOmr38te+IaWqKvN61Q/COpD0ML3+yte32K1Nrf2qq2
         QdMy1xRjq9vKV3nfUhETkLXK/vsJjEUsKjvS3rpRMIgOAMCQUYZf/2R3cMAtus8iyydF
         mXWDjH4FODRAHnRD+m3Bqg1y/9Do/mMrW5esxkNHqIM17YyVtxBvgzVScqGQ8TF9Da91
         jtyQ==
X-Gm-Message-State: AO0yUKUnfhhnH8+0mqaZXDXNtAqP6g6P+S6XQnCw37KRlHE5IBTb5Spm
        d8kPPrTLm6wqARdJWjVigSFHgEmpdxA=
X-Google-Smtp-Source: AK7set+fJGk4L2o5GgyKH/KD40qmLus2fEVnoCOSAXzCWKp/De9UzqdqH0zM1vxQ0zrBf2e5kuWxcg==
X-Received: by 2002:a17:90b:1d12:b0:234:e3f:f53b with SMTP id on18-20020a17090b1d1200b002340e3ff53bmr36956879pjb.21.1678764492935;
        Mon, 13 Mar 2023 20:28:12 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-16.three.co.id. [180.214.233.16])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a0cc200b0023b3a9fa603sm528470pjt.55.2023.03.13.20.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 20:28:12 -0700 (PDT)
Message-ID: <cd2abd58-dc43-5213-5d47-f336becb22f9@gmail.com>
Date:   Tue, 14 Mar 2023 10:28:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next] bpf, doc: use internal linking for link to
 netdev FAQ
Content-Language: en-US
To:     David Vernet <void@manifault.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Tobin C. Harding" <me@tobin.cc>
References: <20230313025119.17430-1-bagasdotme@gmail.com>
 <20230313030938.GA152792@maniforge> <ZA6knaEQcddfTCyS@debian.me>
 <fefa25fe-8148-cbd7-a91e-e4713eb6b0ef@gmail.com>
 <4653cfd1-7209-6e49-4f01-fcc3f82f16ce@gmail.com>
 <20230313123602.GA2392@maniforge> <87wn3kvkkq.fsf@meer.lwn.net>
 <20230313135638.GD2392@maniforge> <87sfe8vi9s.fsf@meer.lwn.net>
 <20230313143240.GE2392@maniforge>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230313143240.GE2392@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/13/23 21:32, David Vernet wrote:
> On Mon, Mar 13, 2023 at 08:27:11AM -0600, Jonathan Corbet wrote:
>> David Vernet <void@manifault.com> writes:
>>
>>>> In this specific case, though, there is a better solution.  Text like:
>>>>
>>>>   see the netdev FAQ (Documentation/process/maintainer-netdev.rst)
>>>>
>>>> will add links in the built docs, and also tells readers of the
>>>> plain-text files where they should be looking.  Without adding warnings.
>>>
>>> Nice, seems like the best of both worlds. A syntax clarification
>>> question: are you saying that this would work?
>>>
>>>> see the `netdev-FAQ`_.
>>>>
>>>>   <snip>
>>>>
>>>> .. _netdev-FAQ: Documentation/process/maintainer-netdev.rst
>>>
>>> Or is it required to have the full path inline in the text, as in your
>>> example:
>>>
>>>>   see the netdev FAQ (Documentation/process/maintainer-netdev.rst)
>>>
>>> The benefit of the former is of course that you only have to specify the
>>> link in one place.
>>
>> Yeah, but the latter is what we actually have.
> 
> Ack, just wanted to make sure I understood the suggestion. I think this
> is just fine. There's really no need to add 5 - 6 links in the same file
> anyways.
> 
> Bagas would you be OK with submitting a v2 patch which changes the first
> instance of the `netdev-FAQ`_ to netdev FAQ
> (Documentation/process/maintainer-netdev.rst) per Jon's suggestion?
> 

The target is actually netdev subsytem documentation, however, so I need
to change the wording surrounding the link.

Thanks!

-- 
An old man doll... just what I always wanted! - Clara

