Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2D2FC4FE
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 00:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbhASXpE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 18:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbhASXoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jan 2021 18:44:54 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0AFC061573
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 15:43:56 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o10so31567196lfl.13
        for <bpf@vger.kernel.org>; Tue, 19 Jan 2021 15:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/G1m8PE0YTql3WtklqLcJoolwHbP1jsFDu8kUqAsjk=;
        b=ElJArjScwx6VrNY8cu9sHOG+hiNtxsnqba7p4lx6dFH6orCd9GDBiEhH96Aq6cEBM3
         o6gAA8i9eDCDdI1OYb9wrfKSIU6eP28xBrlScg4CYzkYpIzqGMV6kIsOT/VPoZZa9D04
         Plw2hA6RvBQbDqA+6AlNWDro5DYmxEdSHG97Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/G1m8PE0YTql3WtklqLcJoolwHbP1jsFDu8kUqAsjk=;
        b=Nqh5gmbfaIPbv0jrBp5zXUl2BFL/yErFZ4qphP2bq431OtBwI2orvB856zfWjxtyoa
         7lvls5xt0UKsMjdmKNVWQTC3pkK3cIBH9HUmdsHQZ3Zp53EkCtieYV0ECRbpzh3EYOzq
         b9j3bvXrjFrOkN3FGJwCyDTV7JFv4Hx5kGShQ0bA+TR5R+s1oesRSd1zlEFeUfWmpD6A
         q3OkGfnRwglkv3ET6tiPHH3JeBhu/fnvgPmxOba/ZfwSWImEUdztBcRPErQ4oEomLXos
         Xka/bQ+zl7EdfwK/evxMTpbO3xSNZu6U7GmkfPyanhDXcs4T4yKjxY3Vxnfxv23Xi6As
         qvfg==
X-Gm-Message-State: AOAM532GZK76fy5MlhCdwNyLnk9reyV+l6pPkVqVVkwUfaQe1MJL9cyh
        xu6bwxg05TdYakBg94FP4l8aSp3I5b6WsCLDtlrHXA==
X-Google-Smtp-Source: ABdhPJxBqqb+KLSnajsT/DbeOl0sTZlet887nfewnnGWNGEGILFOn3Maz+HeHkgfvTYPc3HetkFys+AElxbiEqKvY5k=
X-Received: by 2002:a19:670f:: with SMTP id b15mr2808464lfc.340.1611099834522;
 Tue, 19 Jan 2021 15:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20201215012907.3062-1-ivan@cloudflare.com> <20201217101441.3d5085f3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201217101441.3d5085f3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 19 Jan 2021 15:43:43 -0800
Message-ID: <CABWYdi21ntZzrfchif1XEjDZK-RiQKttxu8oT_yRTakNhYYciw@mail.gmail.com>
Subject: Re: [PATCH net-next] sfc: reduce the number of requested xdp ev queues
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 17, 2020 at 10:14 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 14 Dec 2020 17:29:06 -0800 Ivan Babrou wrote:
> > Without this change the driver tries to allocate too many queues,
> > breaching the number of available msi-x interrupts on machines
> > with many logical cpus and default adapter settings:
> >
> > Insufficient resources for 12 XDP event queues (24 other channels, max 32)
> >
> > Which in turn triggers EINVAL on XDP processing:
> >
> > sfc 0000:86:00.0 ext0: XDP TX failed (-22)
> >
> > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
>
> Looks like the discussion may have concluded, but we don't take -next
> patches during the merge window, so please repost when net-next reopens.
>
> Thanks!
> --
> # Form letter - net-next is closed
>
> We have already sent the networking pull request for 5.11 and therefore
> net-next is closed for new drivers, features, code refactoring and
> optimizations. We are currently accepting bug fixes only.
>
> Please repost when net-next reopens after 5.11-rc1 is cut.

Should I resend my patch now that the window is open or is bumping
this thread enough?

> Look out for the announcement on the mailing list or check:
> http://vger.kernel.org/~davem/net-next.html
>
> RFC patches sent for review only are obviously welcome at any time.
