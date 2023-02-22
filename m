Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE169F752
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 16:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjBVPEK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 10:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjBVPEJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 10:04:09 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD420124;
        Wed, 22 Feb 2023 07:04:07 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id m7so10324590lfj.8;
        Wed, 22 Feb 2023 07:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8DfyNQ+PftHNc7/fqct+NKBfZNeE2WyaD8j2Dk2j1Y=;
        b=Dq/dRb6wf7wQug1zT3PY3AF63b3HkQ5EJbw+DotGkFmDFEPl8JDbOLf7zpTiiLI58J
         byixMFQLw9fCtpXBIyct5B6feHE3ouP+//fREZCsbFgpnzkNUq8c6ad4/zUnaepen7+0
         fsGzhevwHyTSMr7geml0ZbmMRH6Zp3e1Ki8gFlj+qmiGgPav2szzHEUwk9ChIxwHcWYY
         GSuNwwXnkxEpXATH59vHJWbcBYCBys0cpQjH7bMGZE2ysQgZ7Zy4i5GYk1t+BNs5Utye
         gkhXqZwj5tRJna8Ra38wEcpa8N+3cRXhljsnyM5CtJc6tAcvhrM8XmzfgADygnwvR0+W
         Qfbg==
X-Gm-Message-State: AO0yUKXIQ3XsztuUQ1Dz4tbvVngFEz0o3KLMFEydEBT1QmIcNSsUll3s
        2kzi2GcjE+f76NKh+R3F2liwYwCTtUvAbMZp
X-Google-Smtp-Source: AK7set+R/B6YQmKjjALfUc4Y7qyf3g0gTXv2XIcDpiMpCwH0vxmziwEhVVQ0wutemZmriHRriv4/8w==
X-Received: by 2002:ac2:51d1:0:b0:4da:fb89:fcc6 with SMTP id u17-20020ac251d1000000b004dafb89fcc6mr2862473lfm.57.1677078245278;
        Wed, 22 Feb 2023 07:04:05 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w7-20020ac25987000000b004b4cbc942a3sm384381lfn.127.2023.02.22.07.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 07:04:04 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id h9so8000347ljq.2;
        Wed, 22 Feb 2023 07:04:03 -0800 (PST)
X-Received: by 2002:a2e:a4c3:0:b0:295:93eb:e790 with SMTP id
 p3-20020a2ea4c3000000b0029593ebe790mr1355976ljm.5.1677078243825; Wed, 22 Feb
 2023 07:04:03 -0800 (PST)
MIME-Version: 1.0
References: <9c476aa64c9588205817833dbaa622f87c0e0081.1677051600.git.viresh.kumar@linaro.org>
In-Reply-To: <9c476aa64c9588205817833dbaa622f87c0e0081.1677051600.git.viresh.kumar@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Feb 2023 16:03:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXd3876o+petD51xfnJRBOOg=oqkO_pdsmcr8=Uec2KDg@mail.gmail.com>
Message-ID: <CAMuHMdXd3876o+petD51xfnJRBOOg=oqkO_pdsmcr8=Uec2KDg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix undeclared function 'barrier_nospec' warning
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 9:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Add the missing header for architectures that don't define
> the barrier_nospec() macro. The nospec.h header is added after the
> inclusion of barrier.h to avoid redefining the macro for architectures
> that already define barrier_nospec() in their respective barrier.h
> headers.
>
> Fixes: 74e19ef0ff80 ("uaccess: Add speculation barrier to copy_from_user()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Linus's master branch fails currently to build for arm64 without this commit.

Not just arm64 :-(
http://kisskb.ellerman.id.au/kisskb/head/5b7c4cabbb65f5c469464da6c5f614cbd7f730f2

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
