Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AFA6A18A5
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 10:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBXJYY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 04:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXJYX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 04:24:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BB15DCD1
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 01:24:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i34so27001428eda.7
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 01:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTweRjc8yOnKd0wjXCLkcU3l1xjeg/lfkkZ4yVcU0+I=;
        b=lAW36uHb21iACHYo5y0767OorPNQyOVChBjbKQXEz7UbflVipMZmuNBkb5a++ifQMi
         miKaR7O4KdoFbaBwsa0THkJIVpyxM7m9/8rzqqnqzqo2guyTh2O/MJ3pJ1jj6MhmizOQ
         2UFVBs8BHG8p0thtikLhm1G3slZaxmq5Sw9QBbTZX+b2mELlokJyuWWH8OxwCvuvkmtb
         UVP+u2s0B2d3z5D4IoxMWEXcnOHVDySOY1qnleR7rA4M/PdG55/bnYANIL3qpklSy3Ev
         jinwMlrjvYXKXV+3WUADCFGBOCV3ZpbpF8RiW/pKiEEizExoTm2nfrNVQ+MvulCPaoLe
         R/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTweRjc8yOnKd0wjXCLkcU3l1xjeg/lfkkZ4yVcU0+I=;
        b=n4kbOQbwJlk89zWqAQA8Ety+5lnYUp11WBPa+ZSMai0Q2pbFMSpWjpHjN6v3hUh5Cn
         3aWfux801ItjL+TveUZTF5YwehqUl5To7znjbI9vRqzi3H0pn1KmRT6Oo1zbTeF7rSkk
         ANbs4N1SpZT87bcsDLjBBKlwXCE6FMhwhALCP0DJiD9TX9qsO3qHm0iGqs+aeEbuy//i
         hDI6lyfIKTOUp92ei8ruRM8UMUjc6R25WMg3i7dstIWm7vAfRkOqgRDQRfGOEUm0bJNr
         p7dDGYGEGwnl/bQvN3zWZ36+TzhjteZvZSI1vUjw14PeG7hqm3dEUlWq+F+TXvDS/QOj
         VEcQ==
X-Gm-Message-State: AO0yUKWyNqBI9r35LOA4q8C/Zx8yLp3H+aMgeORGJmAR0dflE7cISW0v
        K+HGMRFqpLiUiOuU5KuhH8iTKw==
X-Google-Smtp-Source: AK7set+LQUlpGYF4mH0Seww8ZBljv26E7b+3K+NxIP/8qiSepghYnSTxsefRs1ucyl9ESWWKX78+fA==
X-Received: by 2002:a05:6402:756:b0:4af:6c25:f028 with SMTP id p22-20020a056402075600b004af6c25f028mr4629896edy.5.1677230660144;
        Fri, 24 Feb 2023 01:24:20 -0800 (PST)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id t17-20020a50d711000000b004af596a6bfcsm4003815edi.26.2023.02.24.01.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 01:24:19 -0800 (PST)
Message-ID: <7dba2833-04ec-f59f-0b2f-64912f70bc7f@tessares.net>
Date:   Fri, 24 Feb 2023 10:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCHv3 bpf-next 2/2] selftests/bpf: run mptcp in a dedicated
 netns
Content-Language: en-GB
To:     Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Felix Maurer <fmaurer@redhat.com>, mptcp@lists.linux.dev
References: <20230224061343.506571-1-liuhangbin@gmail.com>
 <20230224061343.506571-3-liuhangbin@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230224061343.506571-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hangbin,

Thank you for this new version!

On 24/02/2023 07:13, Hangbin Liu wrote:
> The current mptcp test is run in init netns. If the user or default
> system config disabled mptcp, the test will fail. Let's run the mptcp
> test in a dedicated netns to avoid none kernel default mptcp setting.

(...)

> +	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");

"Funny", I saw the ">&" in a previous versions and I was going to react
before noticing this is in fact valid in Bash (and ZSH). But of course I
should have checked with 'sh' instead...

Anyway, Martin: thank you for having spotted that!

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
