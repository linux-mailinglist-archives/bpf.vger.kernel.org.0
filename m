Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A766EB37D
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 23:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjDUVP7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjDUVP6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 17:15:58 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF83131
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 14:15:57 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-5ed99ebe076so23127646d6.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1682111756; x=1684703756;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q3+H/qensK44hOTIPI3S5vnMSCnftxuei3KDvIQCSYI=;
        b=aGy+OgAlhu9DwPfrqd6FOL0rlWj3aDqfhT+D84yu7tLbe+9BBfJZCWqyajPUmzO3ND
         8DOfeGkGt77XFiBZLUYxgl/w5sgdlTGdUBqlHtalopbntgaj2dyi35PubKusob4FSdf6
         Zsxru2IRNLPLxkuQvqKAc08h/rm+ZgVHlKSzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682111756; x=1684703756;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3+H/qensK44hOTIPI3S5vnMSCnftxuei3KDvIQCSYI=;
        b=D2PPxNeDp+ZhmgF1Q8ClBr689Oa2llTh0LvN8iWtzDC9/kSKFdHe5A8VUSArZiiu8r
         S5PEf15KThWTJFvEbqi4BzWTbiAxOqELPuVZskOlWlyZtwsbn9ARImPLWEAC2ZN6Ycct
         TJL4F2SMmXRfj03o7lka5wh/b9jlco3954OeJxOVaZ1vOhvK+LvXTS8IUB0Nio1CPPew
         NacvNqRSLwGFYKHbEr2YrfMCnlmGvxIfNjVRZChXS2ytTxnJaD4i+74jbXzNDbr63thh
         Ji07of9tYNt6CwjKtO5eE8Ay9TgWM0HN15uDiAhGeuxarpToUgECO7U+PXtMkKA74fwH
         JP7w==
X-Gm-Message-State: AAQBX9cpzM7l/TeE8eqfCY++MCo3J+fpl+EY7TZL7ruyeWfnR9WObH5D
        XXWjrynzwYAJ97iN+AWtAM5vgA==
X-Google-Smtp-Source: AKy350a48jgg8eLMs+HkO+YfU7DCSp0Beo94CosWVRQgGEDxrJUau9+rDp3x+Ce5iT6fdSRp+FUWZw==
X-Received: by 2002:a05:6214:761:b0:5a2:63a1:ecb2 with SMTP id f1-20020a056214076100b005a263a1ecb2mr9155219qvz.43.1682111756685;
        Fri, 21 Apr 2023 14:15:56 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id v3-20020a0c8e03000000b005eab96abc9esm1412762qvb.140.2023.04.21.14.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:15:56 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 21 Apr 2023 17:15:54 -0400 (EDT)
To:     tonyj@suse.de
cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?ISO-8859-15?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin@isovalent.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        David Miller <davem@davemloft.net>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
In-Reply-To: <ZEBp6C9zqDnM1PfT@suse.de>
Message-ID: <c341b9af-748a-23f9-afaf-301dc8d4ab8f@maine.edu>
References: <ZDfKBPXDQxH8HeX9@syu-laptop> <87leiw11yz.fsf@toke.dk> <ZD/IcBvVxtFtOhUC@syu-laptop.lan> <CAEf4BzbxfvR4Ji1q4wJCFHOxQgFzHr8t7TMK1VJj9sJ+a0srVQ@mail.gmail.com> <ZEBp6C9zqDnM1PfT@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Apr 2023, tonyj@suse.de wrote:
> 
> For a while Vince was maintaining a page documenting breakage in the 
> perf_event ABI but last I checked it ended at V4.0.  Not sure if he 
> just stopped updating, or that's where breakage ended :)

I actually still try to keep an eye on things.  I originally tracked 
things because we had to work around a lot of those breakages in PAPI.  

There have been a few breakages since then, mostly in rdpmc support and 
also some weird things on ARM64.  I stopped documenting things as 
thoroughly in part because despite the common wisdom I don't think the 
kernel devs care much about ABI breaks at least with the perf interface.

Vince
