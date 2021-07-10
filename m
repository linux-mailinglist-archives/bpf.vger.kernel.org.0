Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476DC3C2C6A
	for <lists+bpf@lfdr.de>; Sat, 10 Jul 2021 03:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhGJB0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Jul 2021 21:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGJB0N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Jul 2021 21:26:13 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69FDC0613DD;
        Fri,  9 Jul 2021 18:23:29 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id o139so17260033ybg.9;
        Fri, 09 Jul 2021 18:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8jQjT1qSMZptlSQt3s5if8w9DNoMov/pXhlEE2aHRk=;
        b=NgeniTHpaPDg52aVHipfXOe0wxU1vmvij7CvyHKE4QZC7rWLoY9OeIWA0lqgcdpMPj
         e4GxZlCf1OcXwJVeoXtc3StR9+Cr048FaP0ce3QWp9XqJ4DUTyoVEc/U4rHfGWF7lBfu
         w5TSAnWoM2725HMk3vTfqwdscc//zs0pyXehHQQJrZbVE0XkglBw0zaNWnInHI7yjxNd
         obUK5yq+gR7ekU3Q8Sb+uDVJnWd5HinHJEqjeaZdzfRUAewDImV66zUHmHeB/N8JK8oE
         +8QBp9VxVdLYmbE1PyNb5Pj1cD6+MieH0wPCc/817Dr3mS2QOg/A/plK0IvITkL9xvTA
         4boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8jQjT1qSMZptlSQt3s5if8w9DNoMov/pXhlEE2aHRk=;
        b=V/jZlDpqZYyh9l7X9NZKDAWpVsqdyzSu8njvPeUvZI/+7LKG7IIxNjLA6aXyQeV4qW
         ZyiurRqEgyi7JY2jrcc8z8tiFyo6edBYgihQlVb3neDxk8UTYovsI8L3tC13HXjDvv4n
         SVYjjnlc7Lnc2xALOm99UP8/zdfhoR8VyX23EnP7yFiSyz/0j85+/38VyW4UaGzIe7Gq
         Q3IxMtcGRG0zQtOY/5yc2LB9Vzl/cdwQJO/BVDNbPDtdl073T8mJDHi/jPNOfKHej26j
         vJVgWqM16CgooVLZtb0b5P8vppZ/z1a89ViXXieeAuacd5L9/yiAFXKkXn2NMrv4zo8/
         KKxg==
X-Gm-Message-State: AOAM530bbRwcR21FlIcW3PP/SDJ8GgyeU+LZXt+mQUidGuXFa/rg4yq1
        1DuT2Uj2sGgCt+2DP66gchxfw9v84igJH3HmJGI=
X-Google-Smtp-Source: ABdhPJxZSQJHoieF7sMt6YTPZ5hjlDIqjYAEsWKyvr7GGlzeMntVqfhQ+viWSUHsJC9RC0ueuJH628ahSqnudaThO2E=
X-Received: by 2002:a25:9942:: with SMTP id n2mr51147364ybo.230.1625880209009;
 Fri, 09 Jul 2021 18:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210709025525.107314-1-xuanzhuo@linux.alibaba.com>
 <20210709124340.44bafef1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAEf4BzYuBYE1np+YwpwZT5_K5Zzed1NTPz57zbgn+0V5W1=nZg@mail.gmail.com> <20210709172030.29cf233e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210709172030.29cf233e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Jul 2021 18:23:18 -0700
Message-ID: <CAEf4BzZLa75jN-+GOpCM7Ma75iHkn_cfer8Vtirpx+nGKeFtXA@mail.gmail.com>
Subject: Re: [PATCH net v2] xdp, net: fix use-after-free in bpf_xdp_link_release
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Antoine Tenart <atenart@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Wei Wang <weiwan@google.com>, Taehee Yoo <ap420073@gmail.com>,
        bpf <bpf@vger.kernel.org>, Abaci <abaci@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 9, 2021 at 5:20 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 9 Jul 2021 14:56:26 -0700 Andrii Nakryiko wrote:
> > On Fri, Jul 9, 2021 at 12:43 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > On Fri,  9 Jul 2021 10:55:25 +0800 Xuan Zhuo wrote:
> > > > The problem occurs between dev_get_by_index() and dev_xdp_attach_link().
> > > > At this point, dev_xdp_uninstall() is called. Then xdp link will not be
> > > > detached automatically when dev is released. But link->dev already
> > > > points to dev, when xdp link is released, dev will still be accessed,
> > > > but dev has been released.
> > > >
> > > > dev_get_by_index()        |
> > > > link->dev = dev           |
> > > >                           |      rtnl_lock()
> > > >                           |      unregister_netdevice_many()
> > > >                           |          dev_xdp_uninstall()
> > > >                           |      rtnl_unlock()
> > > > rtnl_lock();              |
> > > > dev_xdp_attach_link()     |
> > > > rtnl_unlock();            |
> > > >                           |      netdev_run_todo() // dev released
> > > > bpf_xdp_link_release()    |
> > > >     /* access dev.        |
> > > >        use-after-free */  |
> > > >
> > > > This patch adds a check of dev->reg_state in dev_xdp_attach_link(). If
> > > > dev has been called release, it will return -EINVAL.
> > >
> > > Please make sure to include a Fixes tag.
> > >
> > > I must say I prefer something closet to v1. Maybe put the if
> > > in the callee? Making ndo calls to unregistered netdevs is
> > > not legit, it will be confusing for a person reading this
> > > code to have to search callees to find where unregistered
> > > netdevs are rejected.
> >
> > So I'm a bit confused about the intended use of dev_get_by_index(). It
> > doesn't seem to be checking that device is unregistered and happily
> > returns dev with refcnt bumped even though device is going away. Is it
> > the intention that every caller of dev_get_by_index() needs to check
> > the state of the device *and* do any subsequent actions under the same
> > rtnl_lock/rtnl_unlock region? Seems a bit fragile.
>
> It depends on the caller, right? Not all callers even take the rtnl
> lock. AFAIU dev_get_by_index() gives the caller a ref'ed netdev object.
> If all the caller cares about is the netdev state itself that's
> perfectly fine.
>
> If caller has ordering requirements or needs to talk to the driver
> chances are the lookup and all checks should be done under rtnl.
> Or there must be some lock dependency on rtnl (take a lock which
> unregister netdev of the device of interest would also take).
>
> In case of XDP we impose extra requirements on ourselves because we
> want the driver code to be as simple as possible.
>
> > I suspect doing this state check inside dev_get_by_index() would have
> > unintended consequences, though, right?
>
> It'd be moot, dev_get_by_index() is under RCU and unregister path syncs
> RCU, but that doesn't guarantee anything if caller holds no locks.

Yep. As Xuan also mentioned, if dev_get_by_index and attach happens
under the same lock then we can't really get dev that's unregistered.

Ok, all makes sense, thanks for explaining.

>
> > BTW, seems like netlink code doesn't check the state of the device and
> > will report successful attachment to the dev that's unregistered? Is
> > this something we should fix as well?
>
> Entire rtnetlink is under rtnl_lock, and so is unregistering a netdev
> so those paths can't race.
>
> > Xuan, if we do go with this approach, that dev->reg_state check should
> > probably be done in dev_xdp_attach() instead, which is called for both
> > bpf_link-based and bpf_prog-based XDP attachment.
> >
> > If not, then the cleanest solution would be to make this check right
> > before dev_xdp_attach_link (though it's not clear what are we gaining
> > with that, if we ever have another user of dev_xdp_attach_link beside
> > bpf_xdp_link_attach, we'll probably miss similar situation), instead
> > of spreading out rtnl_unlock.
> >
> > BTW, regardless of the approach, we still need to do link->dev = NULL
> > if dev_xdp_attach_link() errors out.
