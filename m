Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF569ED06
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 03:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjBVCqs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 21:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjBVCqr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 21:46:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0492FCC6
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 18:46:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cy6so19394859edb.5
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 18:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F8ZMRR/VKK1etFEaNA4kZ31IdkR8BQTcd8mKo/APEoo=;
        b=dKfDhIrBWZAURfU4m2VIJbn6ahKZ8/o22VdHh2amKZqRd5nBmWzfA8cGFrQgNHYhH8
         7/OPw5zpITj5qixxCb7SiXEf+xqjjbr4aAIKHOe4ZuQteBRqyD33loARcbsn6GXvcgVZ
         UKVx62mI6CyCmh495kHVrFG4dKbklcIQw1gMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8ZMRR/VKK1etFEaNA4kZ31IdkR8BQTcd8mKo/APEoo=;
        b=yXVIq9si9qtiqPF6VnQe8a5KL9Vu17nElPxredqwdpSx5MVtCs7sNoOXuESxEeNhY2
         4EoHVd+tpQGn8jQ96Gy2x0WH264niRUmOYu05GnSIsCC4xQtHlbV3mqG1pIneqHl8RTb
         AuOfHxbLFVj40ucRz+1s+p31s9wgSxvm9VtbgXl0VdAhi9RHRZOiRwJ4wk05r8F3fi2b
         pOkTZ+RNlvsF0ptAw6AGEuJ/KfQNIFYiTzx2E+qtiQSHP1eqRiWIeTV4jwUeZpi4cqcD
         MLvFJkDO2D8rwjKPvZ9wudtlG2UyvCUzXILUBBi6VaC9RcSQ2xTrarDFP55wlfTrC5x4
         bo7w==
X-Gm-Message-State: AO0yUKVDpxsMH7Mt0oHKukYkZTh0Fx1NsdHTjBqW5g+3ytPBGpDljPLP
        8wgneuc+3/8xEHB7pHc4Z3DCI4bQHiKop1ZbdWU=
X-Google-Smtp-Source: AK7set+1UmJ5oZD1szBw6uHFwRnYaeFSkulkZvIeadAVcG30K7fN9lEnpzAz9p8nuqqDJBvwpPw9NA==
X-Received: by 2002:aa7:da97:0:b0:4aa:a0ed:e373 with SMTP id q23-20020aa7da97000000b004aaa0ede373mr4945647eds.7.1677034004130;
        Tue, 21 Feb 2023 18:46:44 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id x23-20020a50d617000000b0049e1f167956sm3366110edi.9.2023.02.21.18.46.43
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 18:46:43 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id cq23so24613897edb.1
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 18:46:43 -0800 (PST)
X-Received: by 2002:a17:906:8508:b0:8d0:2c55:1aa with SMTP id
 i8-20020a170906850800b008d02c5501aamr4252043ejx.0.1677034003068; Tue, 21 Feb
 2023 18:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20230221233808.1565509-1-kuba@kernel.org>
In-Reply-To: <20230221233808.1565509-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Feb 2023 18:46:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_410KZqHwF-WL5U7QYxnpHHHNP-3xL=g_y89XnKc-uw@mail.gmail.com>
Message-ID: <CAHk-=wi_410KZqHwF-WL5U7QYxnpHHHNP-3xL=g_y89XnKc-uw@mail.gmail.com>
Subject: Re: [PULL] Networking for v6.3
To:     Jakub Kicinski <kuba@kernel.org>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 21, 2023 at 3:38 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.3

Ok, so this is a bit nitpicky, but commit c7ef8221ca7d ("ice: use GNSS
subsystem instead of TTY") ends up doing odd things to kernel configs.

My local configuration suddenly grew this:

    CONFIG_ICE_GNSS=y

which is pretty much nonsensical.

The reason? It's defined as

    config ICE_GNSS
            def_bool GNSS = y || GNSS = ICE

and so it gets set even when both GNSS and ICE are both disabled,
because 'n' = 'n'.

Does it end up *mattering*? No. It's only used in the ICE driver, but
it really looks all kinds of odd, and it makes the resulting .config
files illogical.

Maybe I'm the only one who looks at those things. I do it because I
think they are sometimes easier to just edit directly, but also
because for me it's a quick way to see if somebody has sneaked in new
config options that are on by default when they shouldn't be.

I'd really prefer to not have the resulting config files polluted with
nonsensical config options.

I suspect it would be as simple as adding a

        depends on ICE != n

to that thing, but I didn't get around to testing that. I thought it
would be better to notify the guilty parties.

Anyway, this has obviously not held up me pulling the networking
changes, and you should just see this as (yet another) sign of "yeah,
Linus cares about those config files to a somewhat unhealthy degree".

                      Linus
