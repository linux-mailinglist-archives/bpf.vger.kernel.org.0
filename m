Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881146B88F6
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 04:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCND0S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 23:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCND0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 23:26:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BD51A4A1;
        Mon, 13 Mar 2023 20:26:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u5so15192143plq.7;
        Mon, 13 Mar 2023 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678764366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tgJkRUBDlmWuiZTgIUK/X8KhxS1/RDX+q/WNCauH64Q=;
        b=C2BJwGT5uzHhxgR1KMedWfvIlH8eOOercV/21+AbS5y8IZJV9SOVAIJsO6Rx6oPHqw
         E+N45Yo+RLLG0LlGx4j0pyZCI/9lurOmkNH3MrUUS3Sony7QQk5l0B7evV5+4oJHYZzb
         PlliHezofmY+at5jDcp8NF5y1ic8tMSjY/iOEwG09yzJv6hQPMH/mUNX5L3dc7jh3Sga
         f8JczdbHDV0lKfxma+8odcvrAAqij2ylDx93Qt6bwAy2yroJSUO3XDcrU20w0ekz6keK
         x11uv3KuHsNIIyS6oUxGuyqiPBjJajQaLyiEpfW/0HqOSj0cYLvVgpab0w/+grJAA7P6
         uJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678764366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tgJkRUBDlmWuiZTgIUK/X8KhxS1/RDX+q/WNCauH64Q=;
        b=ByRfP80ssFoVPMCIIXF66ARnJJKn1eVoolWfEWJIyti2gXBV9zbbZrcxE9s+020Of6
         J81G/QbEaGmjogDAp8oYEYafOtjDsFiTEC1WvIoThxkgsIgagzMVIBFQVBXn/mVN9ejd
         GgsKhsCW1IT9IeoVala/MFSZAaX20kBBoYCE7Xe0q2Lo+bsVEAxYWLz+TGvYYWck2rgX
         ijfeAUdmIluBvFLYhObTUekzYEpqbFTwXoxtceq0lsj9ekILnRjc43aJW12k03Cv1/9A
         KSrhyMTAd0DuzG+ghSXBX7GAhBbHF1sg0obi8ZJJT62ZKYknHoXWfAoKmbOA/P7uxygM
         mvxA==
X-Gm-Message-State: AO0yUKXK7eqG7/LVVZzSIfLTueaGt0j6MWadZnc9S61xugVmedRF9chA
        itGN2WPjP8G7e96+Kyyx4l4=
X-Google-Smtp-Source: AK7set+444IJpG2pWigOl/yCg6qZlOG2auN2XYwmFhJPKw9WW+zLAcJTIPPUsQD6D4IWIVdI4Gtx0A==
X-Received: by 2002:a17:902:cec1:b0:19e:ab29:1ec2 with SMTP id d1-20020a170902cec100b0019eab291ec2mr36815090plg.65.1678764366301;
        Mon, 13 Mar 2023 20:26:06 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-16.three.co.id. [180.214.233.16])
        by smtp.gmail.com with ESMTPSA id jy7-20020a17090342c700b0019aa5e0aadesm550819plb.110.2023.03.13.20.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 20:26:05 -0700 (PDT)
Message-ID: <b29611da-6f66-f112-892f-ef17b6a3fd38@gmail.com>
Date:   Tue, 14 Mar 2023 10:25:58 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next] bpf, doc: use internal linking for link to
 netdev FAQ
To:     Jonathan Corbet <corbet@lwn.net>, David Vernet <void@manifault.com>
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
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87wn3kvkkq.fsf@meer.lwn.net>
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

On 3/13/23 20:37, Jonathan Corbet wrote:
> David Vernet <void@manifault.com> writes:
> 
>> Sure, but there are practicalities to consider here. It takes O(minutes)
>> to do a full docs build, as opposed to O(seconds). I've done reviews of
>> docs patches where the engineer tried to build the docs tree, but
>> thought it was hung and ended up cancelling it. Full docs builds also
>> unfortunately spew quite a few warnings in other subtrees. You have to
>> carefully wade through the warnings in those other subtrees to ensure
>> you haven't added any new ones.
>>

I have tried to add CONFIG_COMPILE_TEST + CONFIG_WARN_MISSING_DOCUMENTS
+ CONFIG_WARN_ABI_ERRORS when performing htmldocs build, but hangs on
checking missing documents (even I noticed this behavior when cleandocs).

> I get your point, but that is essentially saying that there should be no
> linkages between our documentation subtrees, which defeats much of the
> purpose of using a system like Sphinx.
> 

I mean external referencing to docs.kernel.org when simple internal linking
below should suffice, right?

> In this specific case, though, there is a better solution.  Text like:
> 
>   see the netdev FAQ (Documentation/process/maintainer-netdev.rst)
> 
> will add links in the built docs, and also tells readers of the
> plain-text files where they should be looking.  Without adding warnings.
> 

OK.

In 287f4fa99a5281, Sphinx generates netdev-FAQ crossref as link to
`/process/maintainer-netdev.html#netdev-faq`, due to use of external
link syntax.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

