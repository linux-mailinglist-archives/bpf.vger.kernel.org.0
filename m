Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3906F59E9D5
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiHWRhK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiHWRgi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 13:36:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6321B25FA
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 08:18:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so7917692wms.5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=sC6Qg7PC1pRCwsOWly4PH4FLeBlDo+VgWJqOA60O6es=;
        b=6l9DFwlClafFzfanFPkwNFKBIBkI2ARSRABIY+7hA5M7Tk/pYyy8TpZz+UdLG54lRa
         sX36BNxVx36ClPFpvqOBBLu1hk+8Glow3fdnmCzXWHetJ1IBu1tXhDozcjQaIYk23pee
         zZJmpT6pDwEsMCBGa4+EDP9vZsU6pXgjP+y+rXzaOiaG+yH+BARtx11mNUaVvjy5PTOT
         G/0HDrnwAgfhgxZv4GH5/+LRqs4fKdBeUq3qlFBpBQUq78/WHN6v0r3YDvME3UtGoy+F
         q1XKZNlM0BIhCCOSf09tt9xHsVBOqn3c+UirgykEou3WKIxrXI9aH26B9uVoS2iyd1xf
         /zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=sC6Qg7PC1pRCwsOWly4PH4FLeBlDo+VgWJqOA60O6es=;
        b=yKscgyr1XPqq1wQtfkv3HcEyiomh5Hn++120DKsGUPv8r60Ivkwqn93Zs11rMRy3AF
         FfzgB+9NH69JAPN801MTWV7hTP3SaeXzvqXJm+SbEeh0z2tceY23xgDLafyXrUZUKtfj
         gU7NZ7GI1uaUZEAlXxkSP8JwEa+7G2K0X4eKmdwdZQjprHdAi0lBzOGafIFSHIy93ib9
         XtcIQVBCeohsRM/fmFv3qJs27pDJkg0rEKubtZM8wTvxuzh5WpmhC31Bi/7uEInWRCoH
         HzB9KtEpWyo55JEwfPwIOjo+7WsC2XJQt95xfP4JG2q+t2izSvpOuCHkaYCwzvrrw21J
         WEpQ==
X-Gm-Message-State: ACgBeo1UmQZLhJGB3v7eOSaXn6ylWGTH/uaimtr5s9pRQ0KmMjuq5axw
        B2qATyouKnZW17OMBbDVp1fYzg==
X-Google-Smtp-Source: AA6agR4l9Eq/789JZxvndT5P25W8FqVXVhHjEX3UaX7AYyjLMPoaoulXmzMa1zv4/M23Nq0wSjjL+A==
X-Received: by 2002:a05:600c:6028:b0:3a6:3cf:265c with SMTP id az40-20020a05600c602800b003a603cf265cmr2547931wmb.83.1661267887920;
        Tue, 23 Aug 2022 08:18:07 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id c13-20020adfa30d000000b0021f131de6aesm14663204wrb.34.2022.08.23.08.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 08:18:07 -0700 (PDT)
Message-ID: <593cfd34-9394-5f7c-e3b9-c4492533d030@isovalent.com>
Date:   Tue, 23 Aug 2022 16:18:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next] scripts/bpf: Fix attributes for bpf-helpers(7)
 man page
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
        bpf@vger.kernel.org
References: <20220823084719.13613-1-quentin@isovalent.com>
 <a9533d19-8266-8eed-63ec-82aa07ce83d0@gmail.com>
 <1c07206a-25c5-9621-afd5-d64913fece13@isovalent.com>
 <8af3984e-49f4-e94f-df87-6609a5330b9f@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <8af3984e-49f4-e94f-df87-6609a5330b9f@gmail.com>
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

On 23/08/2022 16:04, Alejandro Colomar wrote:
> Hi Quentin,
> 
> On 8/23/22 16:23, Quentin Monnet wrote:
>> Wow, I'm two days late!
> 
> ;-)
> 
> [...]
>>>
>>> You could append the version here.  Or maybe put a placeholder that the
>>> script should fill with information from the makefile or
>>> git-describe(1)?
>>
>> So if I understand correctly, running bpf_doc.py should currently
>> produce the following string:
>>
>>      .TH BPF-HELPERS 7 "" "Linux (5.19.0)" ""
>>
>> Is this what you expect?
> 
> Almost.  I expect:
> 
> .TH BPF-HELPERS 7 "" "Linux 5.19.0"
> 
> Notice the differences:
> - No 5th empty field "".
> - No parentheses in the version string.
> 
> But since you're not in control of the last field, and it's just a bug
> in rst2man, an empty 5th arg as you suggested is the best you can
> provide.

Agreed

>  I'll file the bug.
> 
> As for the parentheses in the version, I wouldn't put them; I only put
> them in the man-pages unreleased string, to make it clear that it's a
> version, but in the final version I remove them.

OK, I wasn't sure. Thanks for the details.

> See:
> 
> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/lib/version.mk>
> and
> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/lib/dist.mk#n33>
> 
>>
>> I can make the script call "make kernelversion" to produce the above.
>> I'm not 100% convinced it should be the role of that script vs. when
>> copying it (we risk having some inaccuracies, for example I generated
>> the above from the bpf-next, so it doesn't really correspond to 5.19),
>> but maybe it's easier that way and avoids adding another script in the
>> middle of the generation so OK.
> 
> I like it that way.  Moreover, I'll always run this script from a
> release tag from Linus' repo, so the version should match exactly the code.
> 
> Anyway, and I think this affects many projects out there have the same
> issue:
> 
> The versioning should always be correct.  git-describe(1) should be
> preferred, or in absence of that, a generic (unreleased) string should
> be used.  Describing any commit after v5.18 and before v5.19-rc1 to be
> '5.18.0' is plain wrong/misleading.  The Makefile should probably
> autogenerate that info from git-describe(1).  See how the Linux
> man-pages do it (in the links above you can see it) for example.

It's not really about how to do it, more that I don't want to have a
hard dependency on git for the script. I want it to run just as well
when there's no Git repo around. But I can try to run "git describe" and
fall back on the Makefile (or on an empty version) if the command fails.

OK I'll prepare a new version, thanks for your help.
Quentin
