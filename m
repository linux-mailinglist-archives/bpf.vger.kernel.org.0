Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A23D6B70C5
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 09:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCMICS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjCMIBh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 04:01:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9B3BDA5;
        Mon, 13 Mar 2023 00:58:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso604893pjb.0;
        Mon, 13 Mar 2023 00:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678694287;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hat8ABt+aIhJHmkgJ54scd67JOhwFtz9Gg2oapIINaM=;
        b=kFmY22yZpquTAvlpQDx2jQBWU5fSGyo6DISTzAE6GWo2HPcvUO/pVxjyeP/NsOYtNX
         g4rpW/OCvHnX9c2QqkCjafRzHKcFKbVycja/5ft3L3TcfhjKPgHoJdXCzTS7CCfNqh8Q
         Dxy/KCFbk1s3Fee2UfMIxsrk1KkojzEjrvid4xmlV+1+av21WLTr4fLWInCzJcT5hK5g
         qb+Ff7s6ek3GGsIYxJryfLNzIepo0u6dHgU8MlPeBmNXKdrW49C4QuawDf7XW9Y3bZhq
         OZUnTIi33H6hDA2IyiI3FbLBjJMvvFJmaexISKBzSvjcGKqXouf4rqwU4ltyjTdMW2MI
         uoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694287;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hat8ABt+aIhJHmkgJ54scd67JOhwFtz9Gg2oapIINaM=;
        b=So3kIzEncpfFp3Klf8ooW7pZh3qSif3JAPI1g3VDwy9jiJcHiiX8NbYMRiH05Ckr5T
         RrCHHz9hw953d3iSepHTZ9K61WpgdA5p2G+vqESTpeM8Io9aVpmp+AeM9wHA9FbR2Q8i
         3spSr/StL3ZyQmr9ARX0pXTQ4FnRBPB8j/cTM2tsTZoXm7bLH2Teknvkhvk4WKkxpFUF
         PwSeMRtxBy0FQQHlYI0hndIvQGogFxBRfeM/3ol6C+EEuAeOGmEipBH0oE7yve0AhvIZ
         TUZx+QGaXw7UYADEO9d1yx/PZSagNDws17YD7DfxJhiVmy1WuODzwaRy4dBcSvfAHXIv
         LgXw==
X-Gm-Message-State: AO0yUKXCN32FHGdKLsQ3U3dc3shwiRzDfeTOf2NyBrRaw9VKOjQmimQ/
        z2G2NJ7ybSwcjEQsqoDfWUo=
X-Google-Smtp-Source: AK7set+iRq23u8hMYMCXBM+T4tOxHpw2sNBM6ytHUEdT61AtXh8oAny7LUXb5iWPuPvsIocSFUGKIA==
X-Received: by 2002:a17:902:e54a:b0:19e:8bfe:7d79 with SMTP id n10-20020a170902e54a00b0019e8bfe7d79mr37424033plf.1.1678694286928;
        Mon, 13 Mar 2023 00:58:06 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-36.three.co.id. [116.206.12.36])
        by smtp.gmail.com with ESMTPSA id jz16-20020a170903431000b0019cbd37a335sm4103268plb.93.2023.03.13.00.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 00:58:06 -0700 (PDT)
Message-ID: <4653cfd1-7209-6e49-4f01-fcc3f82f16ce@gmail.com>
Date:   Mon, 13 Mar 2023 14:57:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next] bpf, doc: use internal linking for link to
 netdev FAQ
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     David Vernet <void@manifault.com>
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
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Tobin C. Harding" <me@tobin.cc>
References: <20230313025119.17430-1-bagasdotme@gmail.com>
 <20230313030938.GA152792@maniforge> <ZA6knaEQcddfTCyS@debian.me>
 <fefa25fe-8148-cbd7-a91e-e4713eb6b0ef@gmail.com>
Content-Language: en-US
In-Reply-To: <fefa25fe-8148-cbd7-a91e-e4713eb6b0ef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/13/23 11:42, Bagas Sanjaya wrote:
> On 3/13/23 11:20, Bagas Sanjaya wrote:
>> On Sun, Mar 12, 2023 at 10:09:38PM -0500, David Vernet wrote:
>>> This regresses all of the warnings I fixed in d56b0c461d19da ("bpf,
>>> docs: Fix link to netdev-FAQ target"):
>>>
>>> [void@maniforge bpf-next]$ make -j SPHINXDIRS="bpf" htmldocs
>>> make[2]: Nothing to be done for 'html'.
>>> Using alabaster theme
>>> source directory: bpf
>>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:125: WARNING: unknown document: '/process/maintainer-netdev'
>>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:150: WARNING: unknown document: '/process/maintainer-netdev'
>>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:207: WARNING: unknown document: '/process/maintainer-netdev'
>>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:232: WARNING: unknown document: '/process/maintainer-netdev'
>>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:398: WARNING: unknown document: '/process/maintainer-netdev'
>>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:414: WARNING: unknown document: '/process/maintainer-netdev'
>>>
>>> And it also causes the netdev-FAQ links to once again be broken and not
>>> actually point to anything.
>>
>> Hi,
>>
>> I don't see these warnings in my builds. I'm using Sphinx 2.4.4
>> (virtualenv, install with pip3 install -r
>> Documentation/sphinx/requirements.txt). I guess your Sphinx version
>> doesn't support :doc: directive.
>>
>> Also, did you enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS,
>> and CONFIG_WARN_ABI_ERRORS?
>>
>> Thanks.
>>
> 
> Oops, I didn't see the context.
> 
> When I rebuild the docs, I always omit SPHINXDIRS as you mentioned.
> For :doc: links to work, you need to just do ``make htmldocs`` and
> DO NOT specify that variable.
> 
> Anyway, these warnings make sense since the target is absolute
> (rather than relative).
> 

Hi again,

I think SPHINXDIRS specifies the subdir as root directory when
resolving references, so when there are references to docs
outside SPHINXDIRS, nonexistent doc warnings will occur. For normal
(full) htmldocs builds though, these will go away (see [1]).

Thanks.

[1]: https://lore.kernel.org/all/f4d40da6-756b-9e75-b867-cc9eedc4b232@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara

