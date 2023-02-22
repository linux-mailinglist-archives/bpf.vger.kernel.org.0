Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C1369FDD5
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 22:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjBVVoF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 16:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjBVVoF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 16:44:05 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F4132CC6
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 13:44:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ec43so35595284edb.8
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8oYWKIc1S3uxITVpxd8tWdXuh6CEoVI7L8XjQ7W6G1A=;
        b=HhUHBtTjub8KdQHhqu1fxHUgmYd9w+ceHrZK9zRemdaggPWtv2iGPX6Cql9YcsRCzv
         ew7JVcXnoVO+4cDmGI33ch5+YbLrwqZNZFUyY25F96N4PowEGSsYLjkRYiFYdoihT7td
         zjBWY+nzFImFuPwTQP0fDvzUFTGKWAxaIS278=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oYWKIc1S3uxITVpxd8tWdXuh6CEoVI7L8XjQ7W6G1A=;
        b=UMq2/Uxurb9w6tydjVm7yGkWR+drdlKupiQBxPKu3tXebT5p/ob0UuPxSWuAldvHv3
         Dd4NQaqXCnf2RY/uINVndfwhVytbHN8Q1wpAZYvnYJjN6vAuqoEHN4q9I9SbivJdyqFO
         6J1+gUimhsCfknnm5PRrxvluuuxCkmhuSZhpjySoxgUqJneF9mNzqWcpDkbjSFp21qU3
         exKi08VMFhK/DK4WHfF+UGIwAB73OevgYFpz0AzBDKdfTGndi7ekitL4cHiv03KxqVmy
         qqE+7El7BRveCOo/oI6hm/bqeUAMIVgkd8YokT1jc5FLmrrMjJMpBqDjTQ2ovmM5ycZO
         2zGw==
X-Gm-Message-State: AO0yUKU6JhAb4weWRibXtTtwgTOleH9Rrw6W3BC6TvP34yp9wiPxd62M
        a44X2GluaRB8Ah3HlnGW7sw6zH7Dda8kw8wsoiQ=
X-Google-Smtp-Source: AK7set9glaw7o4S5Af7cr87gLw05Y0e7nfxV9zY1VxXT/zUfel6k19v/i++E5DE2GVct7ig1CTvHfg==
X-Received: by 2002:a17:906:f88a:b0:8b1:32dd:3af with SMTP id lg10-20020a170906f88a00b008b132dd03afmr17299609ejb.28.1677102241836;
        Wed, 22 Feb 2023 13:44:01 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709064a0500b008bbc4f3bceesm6446250eju.118.2023.02.22.13.44.01
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 13:44:01 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id i34so10808986eda.7
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 13:44:01 -0800 (PST)
X-Received: by 2002:a50:f694:0:b0:4ad:6d57:4e16 with SMTP id
 d20-20020a50f694000000b004ad6d574e16mr4649056edn.5.1677102240934; Wed, 22 Feb
 2023 13:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20230223083932.0272906f@canb.auug.org.au>
In-Reply-To: <20230223083932.0272906f@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Feb 2023 13:43:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXpth1kQRCeAXhxoAmsr8dnLLW9KJ0haMiXmdF6-hFfw@mail.gmail.com>
Message-ID: <CAHk-=wjXpth1kQRCeAXhxoAmsr8dnLLW9KJ0haMiXmdF6-hFfw@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the bpf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Wed, Feb 22, 2023 at 1:39 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):

Yup, that was very intentional to keep the fallout of the problem on
random architectures minimal.

         Linus
