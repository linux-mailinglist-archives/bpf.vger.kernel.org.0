Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679F1584E8B
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 12:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiG2KMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 06:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiG2KMO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 06:12:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9AC6460
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 03:12:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p10so1205641wru.8
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dpdNjtTVSj9p6Bh1Nal+TgUB3MIlSHttFRmodawBE+4=;
        b=N/uCEVIZNtWfl9H4FhDx7hKDv9Ip7y8SLfxk00oKF2qrtL2h5bU3rUkMHljCliZAnT
         ZNnKb2GsV+jSx2bqVsnVk9tMW2/rTUdbg7xh9CB1JZ+G0krlwx7FopMVHsZ23lTt5XHD
         eex65+EV2varbDa9Tnuks8He/h5ZvVQZlZbM2svtVxVxCeV8prB3hdhkCkycy8tHCNUF
         SbytgX4f9FOUJL8obUrqgDBKJEbldvIbqcVTKhK+aIM3ymOkuoLMTtVfYbQDNkawjAE/
         dRbNw+/ZQULNfVJBCtxj6ZJWw/W0TjtljJ9Y3SXIV0f0TKLBI84WgoB4EW2qn+FpmYfN
         gBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dpdNjtTVSj9p6Bh1Nal+TgUB3MIlSHttFRmodawBE+4=;
        b=m9mxiMawsm1ctDlNGLvhxmHlEhi3D3hJQALMGs3s2b4m94VGl3AvOGMwZeeOzuHA9g
         sXYoVocgv00HT7scsbEyZ+XsVXudor/4y30+OzBCDqqY3SjAI12HS2nUXS0FbMBhcY+R
         8Bv746NksKTKOFd+xGuVD+mpqxU8ZEE7GyzwohBv0FZuSJ7caDgKOxnhRs0Uapy5WdKU
         yel6ws21NQL8S5c3D/KzgdRbDqM5IT5c1HOWTL3ybCMxfK+BY31vVokYdSJ99iufR/47
         fKKcpjnNHJgT67aPsXMwEsIfWjRM2NkbKPIKM8aTftfcDB634ZMcyV21LJaIC8m+odtX
         ZXQA==
X-Gm-Message-State: ACgBeo07TwePliHOaB9MvW2wPrdZc+yW+uY1ZafRBRff1YDSVjWpGheZ
        mhuGctelfDQ/jE/lpTOCbBlaKg==
X-Google-Smtp-Source: AA6agR5aUpFvxjSy3mpInypMpDENpDK0s6xec36MpZbLE7eF4uaZaV/H9UchgYx24ka6K0RBwNVPFw==
X-Received: by 2002:a5d:6c6f:0:b0:21d:c28a:2f99 with SMTP id r15-20020a5d6c6f000000b0021dc28a2f99mr1888700wrz.448.1659089532117;
        Fri, 29 Jul 2022 03:12:12 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003a2fdde48d1sm3727995wmk.25.2022.07.29.03.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:12:11 -0700 (PDT)
Message-ID: <31673eca-ec46-35b2-9172-4156d985b621@isovalent.com>
Date:   Fri, 29 Jul 2022 11:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [RFC PATCH bpf-next] bpftool: Mark generated skeleton headers as
 system headers
Content-Language: en-GB
To:     Yonghong Song <yhs@fb.com>,
        =?UTF-8?Q?J=c3=b6rn-Thorben_Hinz?= <jthinz@mailbox.tu-berlin.de>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220728165644.660530-1-jthinz@mailbox.tu-berlin.de>
 <7d4af6b4-f4da-f004-48a1-e408d8615ee8@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <7d4af6b4-f4da-f004-48a1-e408d8615ee8@fb.com>
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

On 28/07/2022 19:25, Yonghong Song wrote:
> 
> 
> On 7/28/22 9:56 AM, Jörn-Thorben Hinz wrote:
>> Hi,
>>
>> after compiling a skeleton-using program with -pedantic once and
>> stumbling across a tiniest incorrectness in skeletons with it[1], I was
>> debating whether it makes sense to suppress warnings from skeleton
>> headers.
>>
>> Happy about comments about this. This change might be too suppressive
>> towards warnings and maybe ignoring only -Woverlength-strings directly
>> in OBJ_NAME__elf_bytes() be a better idea. Or keep all warnings from
>> skeletons available as-is to have them more visible in and around
>> bpftool’s development.
> 
> This is my 2cents. As you mentioned, skeleton file are per program
> and not in system header file directory. I would like not to mark
> these header files as system files. Since different program will
> generate different skeleton headers, suppressing warnings
> will prevent from catching potential issues in certain cases.
> 
> Also, since the warning is triggered by extra user flags like -pedantic
> when building bpftool, user can also add -Wno-overlength-strings
> in the extra user flags.

I agree with Yonghong, I don't think it's a good idea to mark the whole
file as a system header. I would maybe consider the other solution where
we can disable the warning locally in the skeleton, just around
OBJ_NAME__elf_bytes() as you suggested. Although I suppose we'd need
several pragmas if we want to silence it for GCC and clang, for example?
It looks like your patch was only addressing GCC?

Thanks for the contribution,
Quentin
