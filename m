Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE4152433B
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 05:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbiELDVQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 23:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbiELDVP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 23:21:15 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A52CDC6
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 20:21:13 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i22so2731972ila.1
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 20:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSdl3EtMfdlKkqmqNDtfwLCVpXiKvX4o7rlzhwELDOM=;
        b=UsgSJo5/CLy9dQ363SXqJiRLZkMciAv2ccm/fHIiwMELQ00ehID9GvsYjZuvP4c3SR
         xlKTYeTOC+hsmQX6PXCHz9psEcCSIJT2eEG/KP1vFTeQBqGGZP/rn16BPMquOJ3B9uee
         m/taUwKGyDO5lG6COKtkLbGNltkSxqNW3SEL13s7Lx2eoBz7CpfTsG27Kz4GAdneVNMg
         jPTjmOYEI6C5PoMJaCdiri0FdIlpkznb81W2wWkexEAmkIcuV5/Vhkcl1qD4tS77poYn
         h8UHfXbGWty7CybJq9Bya9fT5SLl+atwxLLFRmS/bBSXKOHHxqCQIZ52rGkSKoBx4aYP
         lfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSdl3EtMfdlKkqmqNDtfwLCVpXiKvX4o7rlzhwELDOM=;
        b=WGx7WslKyikxHFLY1XEgUGQpf3hhqZNBMSmEvGzzxNs44flWeKLbyJmY6CaReeGpID
         gUl/J17K4PWXw8fh3Yauvrxo2eHXswyGXlMeMUY0w5j+ZK85e1iEmJrRJdJOhe/b7ZXU
         s+RixxSRE4d3QKcNqVKHCd6U8e9le2AeN5BveldOfV0qS0I1kxJEK1IZ9VHxiRdVnW0w
         ssis4CwK0P5liCbu3oToP7p7xZXsLNEV2LtUK6bz64vDjI+7NkNKVx834vwUo33ug8Y6
         B2Qo2fL8p7fCkQlaFOiPldNnf3c8NFx9xcUZx62p0CIUykgUTTj+NHR2VSWcpx+RsHnL
         /XGQ==
X-Gm-Message-State: AOAM531n72WE9RW7VYn7/TmtMupgGa3mlkUjy2YBMYMo7MGvI0bli+HP
        2gYQuEeQ1cXorl9cqEyyWsWw7yGJyL+FiDuzf78=
X-Google-Smtp-Source: ABdhPJzvCUUujqt9VGxPAK72fUNShAOGAVa4dVUZ9bD+vALiMNtsKr6sDwWBMF1LQ2A9YaRG0+DrpLenkVIa6p69J9s=
X-Received: by 2002:a05:6e02:1d8d:b0:2cf:2112:2267 with SMTP id
 h13-20020a056e021d8d00b002cf21122267mr13132493ila.239.1652325672791; Wed, 11
 May 2022 20:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAN9vWDLY24LEY-zhBSNVRTPBqbYQd+D62av0jKK_BqMvwt5-ig@mail.gmail.com>
 <CAEf4Bza6Ks-FGAGkLCGhK1KEDRdtqv==y7nN63KejF829XQtfA@mail.gmail.com> <CAN9vWD+6SBQtQqxZ__bvqJ8MsrOUr4cfQcU99at1XVPSUiOsmw@mail.gmail.com>
In-Reply-To: <CAN9vWD+6SBQtQqxZ__bvqJ8MsrOUr4cfQcU99at1XVPSUiOsmw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 May 2022 20:21:01 -0700
Message-ID: <CAEf4BzYtkLX8cYGC9rAnDyMBrQ8uHmgA8T8+nZ6dJe3c1X+73w@mail.gmail.com>
Subject: Re: BPF maps don't work without CONFIG_TRACING/CONFIG_FTRACE
To:     Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 9, 2022 at 10:12 PM Michael Zimmermann
<sigmaepsilon92@gmail.com> wrote:
>
> Thank you for your answer.
> What I'm ultimately trying to do is: Use aya-rs to watch egress on a
> network interface and notify userspace through a map (for certain IPs
> only).
>
> In my actual use case, the userspace is supposed to do more complex
> stuff but for testing I simply logged the receival of a message
> through the BPF map on the console. And that is what I expect to
> happen and which does happen as long as CONFIG_TRACING/CONFIG_FTRACE
> are active. If not, I simply never receive any messages on any map.
>
> I've also tried this using an XDP program which sends a message every
> time it sees a packet. And while the program seemed to be
> working(since it did block certain traffic), I never saw any data in
> the map when those configs were disabled.
>
> Also, I'm giving you two configs(tracing and ftrace) since the other
> one seems to get y-selected automatically if one of them is active.

Please don't top post, reply inline instead.

I don't think we have enough to investigate here, even "receive any
messages on any map" is so ambiguous that it's hard to even guess what
you are really trying to do. BPF maps are not sending/receiving
messages. So please provide some pieces of code and what you are doing
to check. CONFIG_TRACING and CONFIG_FTRACE shouldn't have any effect
on functioning of BPF maps, so it's most probably that you are doing
something besides BPF map update/lookup, but you don't provide enough
information to check anything.

>
> On Tue, May 10, 2022 at 2:00 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, May 3, 2022 at 2:40 AM Michael Zimmermann
> > <sigmaepsilon92@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I'm using a kernel which has TRACING and FTRACE disabled and it looks
> > > like BPF programs are unable to communicate with usespace.
> > > I've reproduced this on aarch64 and x86_64 with both aya-rs's XDP
> > > sample and bcc's "tc_perf_event.py" sample. bcc's sample uses
> > > BPF_PERF_OUTPUT instead of maps though.
> > >
> > > Everything seems to run and work correctly, but there's no data being
> > > send to userspace resulting in no log output.
> > > Is that expected or am I running into a weird bug here?
> > >
> >
> > You probably need to provide few more details on what you are trying
> > to do, what you expect to happen and what's actually happening. As it
> > is it's hard to provide any useful help.
> >
> > > Thanks
> > > Michael
