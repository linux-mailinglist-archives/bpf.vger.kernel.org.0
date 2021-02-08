Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B7314312
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 23:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBHWg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 17:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBHWg5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 17:36:57 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639A1C061788
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 14:36:16 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u25so25202905lfc.2
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 14:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=beLWpohwOnzhrDTDlSFGbzPhhIZ9O7q0MeQl5aLJKRg=;
        b=i5VZDnGycdNCzF2pmcBiKZNdplWTlQQbLL9Rz2g7L5XN+8yUegXaSkPqjStwysIP0h
         GEF3KPoQOxmxk7kznD47KJ1Ch/YMyoq67gGiKEVQ5v1FF+YQhL7FVTBw2OgoHszmsE6d
         GE4j0OHwdjI17nk5p8XIs8xh9tEpOqKNYzyjgyulBBVDMV6uABqftjqGH3HQB5mK3yDM
         SETe+yic2GsoEIamZrt655ChhQV01LEk4Idu18cT3b4aOoI8BgeFvND7cnnaWDnWVoJi
         kcHFrha5LGdRwp3MGOTWYAOgy19NTnwzmg87Q3BXV7GawoZJnVUa4iCV/8xD4Lw8TAGg
         EyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=beLWpohwOnzhrDTDlSFGbzPhhIZ9O7q0MeQl5aLJKRg=;
        b=G9/aMbZ4mOV9wO0oQhXuCQoChSQFxX4tMordvCFlG3F1jW46nOJHjwLccCRg94EZLL
         uKblpGSOS18f1FbxmygfKGRD8TNsZt/YlEYs820S8hBemqHSLGW7I6mvOnCiHIg1/Jvx
         CH5dkl8OCe1XqitnMcvx3h3EqA75geYeUp/GQYmJdXrMR10Jo/SHWa8upm7wSzTytyyh
         N+EqIQlPYX8ZcCT4wqtWidRvs7wtlpdAfDsAHxdOTjuI1WWKLHF2H76LfehBxQrHcSZt
         QvQqbpE0NS3oZr8xciIL3sMnaxUkFwPxPHEE6f9xZ6EqZwUL1ewTRWtosY8C7REBo0VT
         O/Mg==
X-Gm-Message-State: AOAM533fUGrVvmwbsEFhu0Sd5NWjGdsJo2/yRHOsV4l1Pm99tP3bQUzk
        ixoArqTrsZkzCr4S7upXIK4yOq9eNwTGYLWpIEY=
X-Google-Smtp-Source: ABdhPJwFcZRkOgEwd8l59Q1zicfbB843shDQEVmtH6HHpkR6XtNP9gdlkkkjvHZEjEuuCD8aCFtDY5XaPb1pkXZqn8Q=
X-Received: by 2002:a19:341:: with SMTP id 62mr11962497lfd.196.1612823774785;
 Mon, 08 Feb 2021 14:36:14 -0800 (PST)
MIME-Version: 1.0
References: <1612387304-68681-1-git-send-email-u9012063@gmail.com>
 <d8f4d928-2ee1-234b-c4fe-1d8896b0f338@gmail.com> <CALDO+Sa=ohgXUzpY1E2E9CPoYEDZK9AVOTSznZ0WvUD54zEQXA@mail.gmail.com>
 <e3914ec6-ccb5-8d8f-2915-343030e5c7db@gmail.com> <CALDO+SabDwkLb85dxAV8R=iRgUyOAy9Q1JKDGXPTVJ+4bCTR9A@mail.gmail.com>
 <ec98f84e-6120-00fc-1a9b-d86e9d371fcc@gmail.com> <602f7207-23b4-a237-7651-ad8bdb02ed0e@ovn.org>
In-Reply-To: <602f7207-23b4-a237-7651-ad8bdb02ed0e@ovn.org>
From:   William Tu <u9012063@gmail.com>
Date:   Mon, 8 Feb 2021 14:35:38 -0800
Message-ID: <CALDO+SaKcEzCcG8o2Rm_VKjGi0KiaYxuGu8T6=x+ggimRjR9Xw@mail.gmail.com>
Subject: Re: [ovs-dev] [PATCH] netdev-afxdp: Add start qid support.
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Gregory Rose <gvrose8192@gmail.com>,
        ovs-dev <ovs-dev@openvswitch.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 4:58 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>
> On 2/7/21 5:05 PM, Toshiaki Makita wrote:
> > On 2021/02/07 2:00, William Tu wrote:
> >> On Fri, Feb 5, 2021 at 1:08 PM Gregory Rose <gvrose8192@gmail.com> wrote:
> >>> On 2/4/2021 7:08 PM, William Tu wrote:
> >>>> On Thu, Feb 4, 2021 at 3:17 PM Gregory Rose <gvrose8192@gmail.com> wrote:
> >>>>> On 2/3/2021 1:21 PM, William Tu wrote:
> >>>>>> Mellanox card has different XSK design. It requires users to create
> >>>>>> dedicated queues for XSK. Unlike Intel's NIC which loads XDP program
> >>>>>> to all queues, Mellanox only loads XDP program to a subset of its queue.
> >>>>>>
> >>>>>> When OVS uses AF_XDP with mlx5, it doesn't replace the existing RX and TX
> >>>>>> queues in the channel with XSK RX and XSK TX queues, but it creates an
> >>>>>> additional pair of queues for XSK in that channel. To distinguish
> >>>>>> regular and XSK queues, mlx5 uses a different range of qids.
> >>>>>> That means, if the card has 24 queues, queues 0..11 correspond to
> >>>>>> regular queues, and queues 12..23 are XSK queues.
> >>>>>> In this case, we should attach the netdev-afxdp with 'start-qid=12'.
> >>>>>>
> >>>>>> I tested using Mellanox Connect-X 6Dx, by setting 'start-qid=1', and:
> >>>>>>      $ ethtool -L enp2s0f0np0 combined 1
> >>>>>>      # queue 0 is for non-XDP traffic, queue 1 is for XSK
> >>>>>>      $ ethtool -N enp2s0f0np0 flow-type udp4 action 1
> >>>>>> note: we need additionally add flow-redirect rule to queue 1
> >>>>>
> >>>>> Seems awfully hardware dependent.  Is this just for Mellanox or does
> >>>>> it have general usefulness?
> >>>>>
> >>>> It is just Mellanox's design which requires pre-configure the flow-director.
> >>>> I only have cards from Intel and Mellanox so I don't know about other vendors.
> >>>>
> >>>> Thanks,
> >>>> William
> >>>>
> >>>
> >>> I think we need to abstract the HW layer a little bit.  This start-qid
> >>> option is specific to a single piece of HW, at least at this point.
> >>> We should expect that further HW  specific requirements for
> >>> different NIC vendors will come up in the future.  I suggest
> >>> adding a hw_options:mellanox:start-qid type hierarchy  so that
> >>> as new HW requirements come up we can easily scale.  It will
> >>> also make adding new vendors easier in the future.
> >>>
> >>> Even with NIC vendors you can't always count on each new generation
> >>> design to always keep old requirements and methods for feature
> >>> enablement.
> >>>
> >>> What do you think?
> >>>
> >> Thanks for the feedback.
> >> So far I don't know whether other vendors will need this option or not.
> >
> > FWIU, this api "The lower half of the available amount of RX queues are regular queues, and the upper half are XSK RX queues." is the result of long discussion to support dedicated/isolated XSK rings, which is not meant for a mellanox-specific feature.
> >
> > https://patchwork.ozlabs.org/project/netdev/cover/20190524093431.20887-1-maximmi@mellanox.com/
> > https://patchwork.ozlabs.org/project/netdev/cover/20190612155605.22450-1-maximmi@mellanox.com/
> >
> > Toshiaki Makita
>
> Thanks for the links.  Very helpful.
>
> From what I understand lower half of queues should still work, i.e.
> it should still be possible to attach AF_XDP socket to them.  But
> they will not work in zero-copy mode ("generic" only?).
> William, could you check that?  Does it work and with which mode
> "best-effort" ends up with?  And what kind of errors libbpf returns
> if we're trying to enable zero-copy?

Thanks for your feedback.
Yes, only zero-copy mode needs to be aware of this, meaning zero-copy
mode has to use the upper half of the queues (the start-qid option here).
Native mode and SKB mode works OK on upper and lower queues.
When attaching zc XSK to lower half queue, libbpf returns EINVAL at
xsk_socket__create().

William
