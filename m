Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F4265017
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 22:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIJUDH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 16:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgIJUAY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 16:00:24 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22802C061573
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 13:00:24 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y13so8573889iow.4
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvpQx2GdBhHH5L5R0qxiajJnES+U476q1eHbIsuJrlk=;
        b=te+GOS40uLNb2jCq6qo6xlAh77siynxLvraP6nRBPNqalAPE1CQ5Ccwj5cwHyko0iz
         uufsotPuLWSsmFVGoRHJbchTSWVi0qjJCP0Ytl1lbb75zhWVZUflTxzOw2pCGR65NEzV
         97XILyZGbJtVn9heLoLC7VcIJxiPkU3KmAXDB4dCOAJFQn8Eu3XhPG0+kFSzUBmaUgVi
         8GXETX8ABQcjdKjtUUahHGG5xdQtt9o39LWGOrfbu9hbpOpsCjtxIhfjmCO8lcJUuRe8
         Vk6clbpdKmyiP6UhjSkD2a8dCrS8nACO4ZMqGDCkRokAlens4Xb7XPDVuKhbUC2Gdu5n
         EbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvpQx2GdBhHH5L5R0qxiajJnES+U476q1eHbIsuJrlk=;
        b=HOFjrs+5heItv5qTjlWkuWcYoPA2xqFnPHG0TOKBkIq+ZQMv2mDI5sx39FsfF+7C5g
         yCiy2141950CvCsMQlKU+BVwM00COmR9A9fDbsHI/kx7xhs6k1hjPoSMjhzbeZJpS6o2
         fYAcWpn6WJIBEDJd6OsE/xm7PTa8ZG6RO5gi6gg8JbxCBiK8u+jPwm1od/8iQIiBp2ac
         fTZZxT3UOctw62WL+p5ZEYzYG9LCWv31BQ5IlkARXlroQN7lD2PgLMUgYLCxHJgunUM/
         11tZ2ZSuXmC4Hqz1rl2j6bMy/RbDYsWc6nO8sLvw2MIyuGzHoeEyBJxbNqVT6QBj9h1/
         taIQ==
X-Gm-Message-State: AOAM530a5MDbsaRsn6M3zXrfP9xV/TtD7KX3USWGdsrmQjGPWzZ1A8yF
        IiVq7UQDqkukWobbC8mEJt2NUEEl2KdoNIndqUFiM+KT3Q5Clg==
X-Google-Smtp-Source: ABdhPJyz34BmM2FfHO10F94pw/JbhEsMx18hNTrLKkjkxyb5BzPTHiYd/cgF5stQZo5ysEbMhX2j/X3wY4Gk1hhDBlk=
X-Received: by 2002:a02:b70c:: with SMTP id g12mr9966809jam.62.1599768023200;
 Thu, 10 Sep 2020 13:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <159921182827.1260200.9699352760916903781.stgit@firesoul>
 <20200904163947.20839d7e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <20200907160757.1f249256@carbon>
In-Reply-To: <20200907160757.1f249256@carbon>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Thu, 10 Sep 2020 13:00:12 -0700
Message-ID: <CANP3RGfjUOoVH152VHLXL3y7mBsF+sUCqEZgGAMdeb9_r_Z-Bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: don't check against device MTU in __bpf_skb_max_len
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux NetDev <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All recent Android R common kernels are currently carrying the
following divergence from upstream:

https://android.googlesource.com/kernel/common/+/194a1bf09a7958551a9e2dc947bdfe3f8be8eca8%5E%21/

static u32 __bpf_skb_max_len(const struct sk_buff *skb)
 {
- return skb->dev ? skb->dev->mtu + skb->dev->hard_header_len :
-  SKB_MAX_ALLOC;
+ if (skb_at_tc_ingress(skb) || !skb->dev)
+ return SKB_MAX_ALLOC;
+ return skb->dev->mtu + skb->dev->hard_header_len;
 }

There wasn't agreement on how to handle this upstream because some
folks thought this check was useful...
Myself - I'm not entirely certain...
I'd like to be able to test for (something like) this, yes, but the
way it's done now is kind of pointless...
It breaks for gso packets anyway - it's not true that a gso packet can
just ignore the mtu check, you do actually need to check individual
gso segments are sufficiently small...
You need to check against the right interface, which again in the
presence of bpf redirect it currently utterly fails.
Checking on receive just doesn't seem useful, so what if I want to
increase packet size that arrives at the stack?
I also don't understand where SKB_MAX_ALLOC even comes from... skb's
on lo/veth can be 64KB not SKB_MAX_ALLOC (which ifirc is 16KB).

I think maybe there's now sufficient access to skb->len &
gso_segs/size to implement this in bpf instead of relying on the
kernel checking it???
But that might be slow...

It sounded like it was trending towards some sort of larger scale refactoring.

I haven't had the opportunity to take another look at this since then.
I'm not at all sure what would break if we just utterly deleted these
pkt too big > mtu checks.

In general in my experience bpf poorly handles gso and mtu and this is
an area in need of improvement.
I've been planning to get around to this, but am currently busy with a
bazillion other higher priority things :-(
Like trying to figure out whether XDP is even usable with real world
hardware limitations (currently the answer is still leaning towards
no, though there was some slightly positive news in the past few
days).  And whether we can even reach our performance goals with
jit'ed bpf... or do we need to just write it in kernel C... :-(

On Mon, Sep 7, 2020 at 7:08 AM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
> On Fri, 4 Sep 2020 16:39:47 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
>
> > On Fri, 04 Sep 2020 11:30:28 +0200 Jesper Dangaard Brouer wrote:
> > > @@ -3211,8 +3211,7 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
> > >
> > >  static u32 __bpf_skb_max_len(const struct sk_buff *skb)
> > >  {
> > > -   return skb->dev ? skb->dev->mtu + skb->dev->hard_header_len :
> > > -                     SKB_MAX_ALLOC;
> > > +   return SKB_MAX_ALLOC;
> > >  }
> > >
> > >  BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
> > >
> >
> > Looks familiar:
> > https://lore.kernel.org/netdev/20200420231427.63894-1-zenczykowski@gmail.com/
> >
>
> Great to see that others have proposed same fix before.  Unfortunately
> it seems that the thread have died, and no patch got applied to
> address this.  (Cc. Maze since he was "mull this over a bit more"...)
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
