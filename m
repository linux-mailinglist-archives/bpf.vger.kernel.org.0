Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8456B799E
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 14:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCMN44 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCMN4s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 09:56:48 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550BD664EB;
        Mon, 13 Mar 2023 06:56:42 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id c3so13139678qtc.8;
        Mon, 13 Mar 2023 06:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715801;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AmBuWVzCeWcPysh/zrfiCJW1ORbVCzeJReTTpgJTcI=;
        b=5koYIbNX02RCgAj53qg2QetZvWqhaY0qBTrfvc5sPRwYmd5VjlmXRo2dAI2MlPbZA/
         9mXQo/+hGqrTnjWWCrXyGAGjhMqscldplhd6f/KYm46YkUnSbYIIxpeTfbLJ7wHZk2Y5
         pDfFihd/WxN997wrWA8g8gdBQahqNITovmg2Gxff7F+sKFYpxFcQWqihwbnInVQFHqHS
         eVEhc60BYqRh1LgLvFfORGmQvgH5m5rKVn43dz6loAuxyWXMFyrbkT0zyxPaS24swjom
         WzYy+ZpERi24PWStS72wSgWbyjl+ZDHYAdMCVZ5tULp04JuOGVwspXdJ33O79zLRkyoS
         uelA==
X-Gm-Message-State: AO0yUKUQ8J7M1FcgZH4ZhCFA6omD8qIhtg20OvXMjJi7XLwvCXUnQHsJ
        dOr4wc9YeYYD7mPjRlBZTZXaFLennn71GHQU
X-Google-Smtp-Source: AK7set8M7GFhu/FRzb/OXZlhngwMXusy+bFgyE0ELxozalvLkpJGdj3NJQRakdbvwSJsoQWJxWp+ZA==
X-Received: by 2002:a05:622a:45:b0:3b9:ca95:da6e with SMTP id y5-20020a05622a004500b003b9ca95da6emr25579888qtw.44.1678715800955;
        Mon, 13 Mar 2023 06:56:40 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:b967])
        by smtp.gmail.com with ESMTPSA id t6-20020a37ea06000000b007186c9e167esm294473qkj.52.2023.03.13.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:56:40 -0700 (PDT)
Date:   Mon, 13 Mar 2023 08:56:38 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux BPF <bpf@vger.kernel.org>,
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
Subject: Re: [PATCH bpf-next] bpf, doc: use internal linking for link to
 netdev FAQ
Message-ID: <20230313135638.GD2392@maniforge>
References: <20230313025119.17430-1-bagasdotme@gmail.com>
 <20230313030938.GA152792@maniforge>
 <ZA6knaEQcddfTCyS@debian.me>
 <fefa25fe-8148-cbd7-a91e-e4713eb6b0ef@gmail.com>
 <4653cfd1-7209-6e49-4f01-fcc3f82f16ce@gmail.com>
 <20230313123602.GA2392@maniforge>
 <87wn3kvkkq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn3kvkkq.fsf@meer.lwn.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 13, 2023 at 07:37:25AM -0600, Jonathan Corbet wrote:
> David Vernet <void@manifault.com> writes:
> 
> > Sure, but there are practicalities to consider here. It takes O(minutes)
> > to do a full docs build, as opposed to O(seconds). I've done reviews of
> > docs patches where the engineer tried to build the docs tree, but
> > thought it was hung and ended up cancelling it. Full docs builds also
> > unfortunately spew quite a few warnings in other subtrees. You have to
> > carefully wade through the warnings in those other subtrees to ensure
> > you haven't added any new ones.
> >
> > It's hard enough to get people to write documentation. It's also hard
> > enough to get them to test building their documentation before
> > submitting it. I think there is a lot of value in being able to build
> > the documentation for the subtree you're contributing to, and be able to
> > have some expectation that it builds cleanly. Let's not make it more
> > difficult for the people who are actually adding substantive
> > documentation.
> 
> I get your point, but that is essentially saying that there should be no
> linkages between our documentation subtrees, which defeats much of the
> purpose of using a system like Sphinx.

I certainly agree that inter-subtree links are great to have, though in
my opinion, other features such as linking kernel-doc comments, auto
section labeling, etc make Sphinx very useful in their own right. But
yes, having inter-subtree links is of course a useful feature as well.

> In this specific case, though, there is a better solution.  Text like:
> 
>   see the netdev FAQ (Documentation/process/maintainer-netdev.rst)
> 
> will add links in the built docs, and also tells readers of the
> plain-text files where they should be looking.  Without adding warnings.

Nice, seems like the best of both worlds. A syntax clarification
question: are you saying that this would work?

> see the `netdev-FAQ`_.
>
>   <snip>
>
> .. _netdev-FAQ: Documentation/process/maintainer-netdev.rst

Or is it required to have the full path inline in the text, as in your
example:

>   see the netdev FAQ (Documentation/process/maintainer-netdev.rst)

The benefit of the former is of course that you only have to specify the
link in one place.

> For the bigger problem, the right answer is to start using intersphinx.
> I guess I need to get serious about playing with that.

Based on a quick online search, that indeed sounds like the ideal
solution.

Thanks,
David
