Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDA56B6E85
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 05:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCMEnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 00:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCMEm7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 00:42:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D8641B49;
        Sun, 12 Mar 2023 21:42:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a2so11601873plm.4;
        Sun, 12 Mar 2023 21:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678682570;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=voPVnSW+Ym1Pc3x0EfCp5jAF5bIPXKeacSRqsGL8uBA=;
        b=oUtCU55eu/1xwhWvLOUv+LxqpLEgB5fZHs65u1ihdyCO7vTvB2QqW4D7qM5DfWTtIi
         TBps84x2I2bbNScTEuLOsIzDyoFMShYKlOvGQeft43p3YCPjAdtz2zNAK2AUDzep4V3R
         kkjcdLm3lMvDJqmhCzzwEVRq+9jISKmbts7vUSkTolxH3bHTQ9MDVZtpmNDStjWue9mG
         kmXs7nu+QxEkQJ5t/YZ1eCVD/XXhl1HyuphzIibnerUT8l9FMEonLzrvkU75BoQCCxAP
         iwXOqFgwmVZ0uQoQd2Kj84Me5RkyslmA1kGwNMYtYXZ/cIW/JFeiu+aj6Sekort2MrcH
         XB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678682570;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voPVnSW+Ym1Pc3x0EfCp5jAF5bIPXKeacSRqsGL8uBA=;
        b=AFCOocnD2eoeI+HzNj40Edi1HJRV4uphb20JmmHwJiPpzcfcAN+i4vM99nBoOcKnFM
         GkRT9xPx4q15RCgxryNFXvRCT0IrPB5z8ssrucN3YoeEJnqMNTKNZ70+zkz57NwGv3se
         VX7OlR66Qr4MkEAuvUOE5HxdaTuBtEpmV4pjyz5Fvtet5CDoNCtg50DCDc1Zn2JT6ldm
         owkyG8A9RyH8dOAQDQESZnp7C0+vJZ4pPSrYeN8lN3hZ2KrCE4cZCIujRudaWopriqCF
         UqhHYqGS440gXNtUsGLTLJy1P9x1lpIca54Sz6XxYWF2t5wqjDvsipXxUNRyi0+fLa+K
         TbWg==
X-Gm-Message-State: AO0yUKXC5EInmqcfCtEmYlLq8k1vAZAOnbl0AF6MumYwO/Gr/AUrIvgp
        fILwU+H012UKCllSmFd//bg=
X-Google-Smtp-Source: AK7set8ZZy+wjFT+uTOytBqMN1+IP+zg1kQXrnu23Ub0Dj0U3qaEhb9dPK9Qj+8mv9TZE7et2OA2qQ==
X-Received: by 2002:a17:90b:1d03:b0:234:bff5:97e0 with SMTP id on3-20020a17090b1d0300b00234bff597e0mr9124585pjb.20.1678682570481;
        Sun, 12 Mar 2023 21:42:50 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id x10-20020a17090a2b0a00b0023b3d80c76csm2838616pjc.4.2023.03.12.21.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 21:42:49 -0700 (PDT)
Message-ID: <fefa25fe-8148-cbd7-a91e-e4713eb6b0ef@gmail.com>
Date:   Mon, 13 Mar 2023 11:42:42 +0700
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
Content-Language: en-US
In-Reply-To: <ZA6knaEQcddfTCyS@debian.me>
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

On 3/13/23 11:20, Bagas Sanjaya wrote:
> On Sun, Mar 12, 2023 at 10:09:38PM -0500, David Vernet wrote:
>> This regresses all of the warnings I fixed in d56b0c461d19da ("bpf,
>> docs: Fix link to netdev-FAQ target"):
>>
>> [void@maniforge bpf-next]$ make -j SPHINXDIRS="bpf" htmldocs
>> make[2]: Nothing to be done for 'html'.
>> Using alabaster theme
>> source directory: bpf
>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:125: WARNING: unknown document: '/process/maintainer-netdev'
>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:150: WARNING: unknown document: '/process/maintainer-netdev'
>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:207: WARNING: unknown document: '/process/maintainer-netdev'
>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:232: WARNING: unknown document: '/process/maintainer-netdev'
>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:398: WARNING: unknown document: '/process/maintainer-netdev'
>> /home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:414: WARNING: unknown document: '/process/maintainer-netdev'
>>
>> And it also causes the netdev-FAQ links to once again be broken and not
>> actually point to anything.
> 
> Hi,
> 
> I don't see these warnings in my builds. I'm using Sphinx 2.4.4
> (virtualenv, install with pip3 install -r
> Documentation/sphinx/requirements.txt). I guess your Sphinx version
> doesn't support :doc: directive.
> 
> Also, did you enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS,
> and CONFIG_WARN_ABI_ERRORS?
> 
> Thanks.
> 

Oops, I didn't see the context.

When I rebuild the docs, I always omit SPHINXDIRS as you mentioned.
For :doc: links to work, you need to just do ``make htmldocs`` and
DO NOT specify that variable.

Anyway, these warnings make sense since the target is absolute
(rather than relative).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

