Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744EA44EBBF
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 18:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhKLRFf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 12:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbhKLRFe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 12:05:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C81C061766
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 09:02:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so10436310wme.0
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VZGehk3+HjfLCRM6NGvoDoHhkCICOZhcoeDuxektNp4=;
        b=i4r1TRjg5InRAmEoxfv3subbanekSTukrotGUQs6tEPZnyWwKL3C9wb+crae+VQFZ/
         qZGR7XhjAeL4yhn9wM5iV4RxEaJNVgeqUYKbWYC54ecmwf3kxLtH33pXIbEK/ETTO0od
         hr6I7svFxj2YBnHIgp4UDY8gI8oq0p1fI01q8XQGcgG3yj13qahLD8HecKfhSkbZSc6v
         TUvt2oDXen92VsDd1TO4a2lM9tzODodBxYl56Yowa9Y+8RQc65Z3fdfJ1Y/6htAaVGmA
         WqbHvDrENhi4upX0BQxdB83MxCtmu7FWfmkJcPmay1Nn7WSep4jl4+40keBvzi87iiE1
         Y1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VZGehk3+HjfLCRM6NGvoDoHhkCICOZhcoeDuxektNp4=;
        b=YWKaPRa9Az50F8GGpJnUw9KUTljLy0Hjp7ZIDTd0cxcSv9O4Mu0/Wa9z1CGKIJ22oX
         9TcE6kSJ+JIIpJmgCLXrzn9wEy/bBskz+9fn2nIMHACFvzH7VXL2rHVBMg0TS84x/1ns
         D2EJgauhbMhqM82uoXYhXvWU8UZvwMELV2pRpaviVDY7cTiuub57xGrZ5SrgNAPaRmyX
         ++izFNEUvaPy8Ziqt41Z0/5zZJo1Rlix+ChUWD9s6OdCdm6obxTZfP7l2q4MQ5n8+nIX
         5PaKpofO+9CXMRFMDTUf6vvhUQguByMwVENiBS9TjArTcpYhQ5Rdk2s8ZgmbtG01h7IR
         B11A==
X-Gm-Message-State: AOAM532jmwTgRvkxV7fbkgwYVSYzxfOKP1J4jtLLGe4Lv8AIEWdEWRFF
        yskC11JoKw8oABEDvDb+y5C+AkWSuF0Oqw==
X-Google-Smtp-Source: ABdhPJw/3xnMi8Ie76412HjjQrPyQn2wdn5YkAl58VsGkXALq8TmEKdsCVBKKYWdXfsa4pYbudbycA==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr18195693wmq.148.1636736561937;
        Fri, 12 Nov 2021 09:02:41 -0800 (PST)
Received: from [192.168.1.8] ([149.86.71.160])
        by smtp.gmail.com with ESMTPSA id j8sm5973254wrh.16.2021.11.12.09.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 09:02:41 -0800 (PST)
Message-ID: <2a34cc7d-1d84-99af-715e-5865dfdcc72b@isovalent.com>
Date:   Fri, 12 Nov 2021 17:02:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next] bpftool: add current libbpf_strict mode to
 version output
Content-Language: en-GB
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20211112164432.3138956-1-sdf@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20211112164432.3138956-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-11-12 08:44 UTC-0800 ~ Stanislav Fomichev <sdf@google.com>
> + bpftool --legacy version
> bpftool v5.15.0
> features: libbfd, skeletons
> + bpftool version
> bpftool v5.15.0
> features: libbfd, libbpf_strict, skeletons
> + bpftool --json --legacy version
> {"version":"5.15.0","features":{"libbfd":true,"libbpf_strict":false,"skeletons":true}}
> + bpftool --json version
> {"version":"5.15.0","features":{"libbfd":true,"libbpf_strict":true,"skeletons":true}}

Nice, thanks!
The following doesn't work as expected, though:

    $ ./bpftool --version --legacy
    ./bpftool v5.15.0
    features: libbfd, libbpf_strict, skeletons

This is because we run do_version() immediately when parsing --version,
and we don't parse --legacy in that case. Could we postpone do_version()
until after we have parsed all options, so that the output from the
above is consistent with e.g. "bpftool --legacy --version"?

Thanks,
Quentin
