Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD394AE38A
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386347AbiBHWXA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386337AbiBHUKb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 15:10:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD241C0613CB
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 12:10:30 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k25so961867ejp.5
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 12:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xhuOnoHjMqmnwg4AI//Ql5Lv0seonbuD/Fbn72VEBa4=;
        b=NHQNoyAa2GtK9dOezJmPjk9HjqN/b7KSf04Fz4HKOU0Ntpw+9s9uUrrAdgLkQl0PeD
         +GPhZxYGpeivloFlsT1//01ZZyY7FHM5yx9Zm+BwANau48paOb5XGOzcyludCVj5kKaH
         0GJLdciKC1Sf3WXvdW3JDJqbplsy2zbzC/2vdUbE+aRylst7aFygC8BIBGckTEQLzBHR
         1JEjYIaCNjsijri8c6643DYdPq7W8L29Z2gW/lDvDbcY9pSCGwEijzdZiwJaB6+88Bqo
         CXGf018rdrNheIVtrSE5iISwGhc3pO0rOFPldI2wGuXF/6ME2xjj9i79A9/8r7bBb8NW
         53NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xhuOnoHjMqmnwg4AI//Ql5Lv0seonbuD/Fbn72VEBa4=;
        b=B9qOzz2wA8g8CKzoiiAv9Ljfs0Z7pSVUTZVSvHGZt+nL2NO8bpyPwyBWywK4dU+Ehy
         vLBC0kXxGf4ReRa+bevFOpiVkvbzU+rT24e5K9/Cq9alnp0vLfPV6Bk+aYIctpWUIcPU
         si9Uhb4lVmOG63tLtBPdn2YsOqPM7jE/QBi1BaKRJckPOVBqeH0x1wYDWFu86wGbwBDR
         FG9AeXHGNWpbDfr8M5LHlWMeTxSgckICz8LjgtznMTrXVDX6ywObX5JSh+V5rHubKmtb
         6ZDQY0aPnpnWtyjXzzQS/IV5rGd45lHzzzdf5Ofy6EmPZ9wpdSYyA9lWak+wC183sT/v
         IVLA==
X-Gm-Message-State: AOAM5323kgouTp5QTK0dRFOsc5AyN7Wv1bskdgre1HJpbdonRT4ffN36
        MWap19NQ9flaxcQu0ou5QLIDYOQwKGo0BA==
X-Google-Smtp-Source: ABdhPJySLlk4crAU+IMHCu9q24AB5xzpd3UVDpxpN4g4FFc1wmTToCNfTeUoLUp6vb0ItLzJePyzQQ==
X-Received: by 2002:a17:907:1b05:: with SMTP id mp5mr4994504ejc.527.1644351029158;
        Tue, 08 Feb 2022 12:10:29 -0800 (PST)
Received: from erthalion.local (dslb-178-012-046-224.178.012.pools.vodafone-ip.de. [178.12.46.224])
        by smtp.gmail.com with ESMTPSA id a17sm5342539edt.92.2022.02.08.12.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:10:28 -0800 (PST)
Date:   Tue, 8 Feb 2022 21:10:07 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [RFC PATCH v2] bpftool: Add bpf_cookie to link output
Message-ID: <20220208201007.6iv7mimcjoxcqzqa@erthalion.local>
References: <20220204181146.8429-1-9erthalion6@gmail.com>
 <CAEf4BzYiT-HRn9bLy=qoyOhOQ1ESCB3mB97xt98JWapgB_nbBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYiT-HRn9bLy=qoyOhOQ1ESCB3mB97xt98JWapgB_nbBw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Mon, Feb 07, 2022 at 02:11:11PM -0800, Andrii Nakryiko wrote:
> On Fri, Feb 4, 2022 at 10:12 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> > BPF perf links") introduced the concept of user specified bpf_cookie,
> > which could be accessed by BPF programs using bpf_get_attach_cookie().
> > For troubleshooting purposes it is convenient to expose bpf_cookie via
> > bpftool as well, so there is no need to meddle with the target BPF
> > program itself.
> >
> >     $ bpftool link
> >     1: type 7  prog 5  bpf_cookie 123
> >         pids bootstrap(87)
> >
> > Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> > ---
> > Changes in v2:
> >     - Display bpf_cookie in bpftool link command instead perf
> >
> >     Previous discussion: https://lore.kernel.org/bpf/20220127082649.12134-1-9erthalion6@gmail.com
>
>
> So I think this change is pretty straightforward and I don't mind it,
> but I'm not clear how this approach will scale to multi-attach kprobe
> and fentry programs. For those, users will be specifying many bpf
> cookies, one per each target attach function. At that point we'll have
> a bunch of cookies sorted by the attach function IP (not necessarily
> in the original order). I don't think it will be all that useful and
> interesting to the end user. We won't be storing original function
> names (too much memory for storing something that most probably won't
> be ever queried), so restoring original order and original function
> names will be hard. If we don't think this through, we'll end up with
> kernel API that works for just one simple use case.
>
> Can you please describe your use case which motivated this feature in
> the first place to better understand the importance of this?

The use case is pretty theoretical at the moment, I'm trying to
understand how to get more visibility about bpf_cookie usage. Let me try
to do the same only in bpftool, while pondering if multi-attach programs
case could be somehow meaningfully addressed as well.
