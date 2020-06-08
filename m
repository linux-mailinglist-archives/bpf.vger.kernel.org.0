Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D0C1F1D8E
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgFHQkc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 12:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbgFHQkb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 12:40:31 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A888C08C5C2;
        Mon,  8 Jun 2020 09:40:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i27so10391241ljb.12;
        Mon, 08 Jun 2020 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXzlhx30X7rf3m2Vi+T5KVUT4esolO+EOHVouc1TbaY=;
        b=YPKkBvSOmmqBhlgVH5HqQJW7p9iFA6BTKYMB42brXkJ1VgkQPa+ve/DHD+TwqrXvFs
         p1W4clgqNvfTYzq1/O49zXX88wY5kGDAtkMGp/P7uhNbcxlmgQlDpuyuLmQ3SUJMvIcu
         O0QXtdRVC/4W9ig3ijwD0QFOpW0azbQBidSWayuoUeyLnM9UZqwQ/TJtAmBqG+j4E+mf
         /43QlQtmM+YZNo8Rc4MzgKGwhGt1AU1DRoVkobQKVN67V894cJM1phpluQPmC1Cl+10j
         cc7oXMWP/QLQ/gsD1p0ALFig+b+SYDHdwj6NzTM4/S0+pnjxqiNXET5ebYfQiue5Sir7
         +CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXzlhx30X7rf3m2Vi+T5KVUT4esolO+EOHVouc1TbaY=;
        b=V5gFK3Ad8jjiB2LR5RXUYd9gr589wMV1kClRfeybSENLs1dMzW/yWqqMgr9q5I4AZw
         +oXCtYmHG5tyRPfd8sOj8hkjVKu3rJ8lbCpryPVY3CM3Cj6K+Az9l4yQ/73lCjRhmoBK
         lFoVDnOoQ3w2POKCYlxbuZ3BiJz+/9S3PWrJThL7X6XOsjyziEQwasllyyXALB4CITDI
         OvjnNR+DnyRUylTy+piAsZ41oZp4lP2Zvq26dKnydyNPOV9RnGw/XFjRe1ZP5xhlV4SE
         wgjDTXH+kKqPh/PExcxAlymf53USsz+58eatXrupF/NUuPaA2WV1e6CXn0E+523of2oH
         2m2w==
X-Gm-Message-State: AOAM532VpnR8h5v4gTnkLBlGeHqFIgJoAip2892vSbhvJyiF/akehhWA
        AJrS5upwtX+yMxOc8hhgdpOMSYbZCal61Cl7X9A=
X-Google-Smtp-Source: ABdhPJw+zEe9CsFz1DbQ5hAnOW7xhrxaXR1hr42EbFqIpL0ESfNR2SVZ/Bfaxz68Ck36JY2+OrQD6Kbw6w6xG0jgeN8=
X-Received: by 2002:a2e:2f07:: with SMTP id v7mr6660513ljv.51.1591634428763;
 Mon, 08 Jun 2020 09:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200424064338.538313-1-hch@lst.de> <20200424064338.538313-6-hch@lst.de>
 <1fc7ce08-26a7-59ff-e580-4e6c22554752@oracle.com> <20200608065120.GA17859@lst.de>
 <c0f216d1-edc1-68e6-7f3e-c00e33452707@oracle.com> <20200608130503.GA22898@lst.de>
In-Reply-To: <20200608130503.GA22898@lst.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 8 Jun 2020 09:40:17 -0700
Message-ID: <CAADnVQL3iBoem4T6CxYeZRCJwS7qRwjjbW+8ip5r3-LCt_eRXQ@mail.gmail.com>
Subject: Re: WARNING: CPU: 1 PID: 52 at mm/page_alloc.c:4826
 __alloc_pages_nodemask (Re: [PATCH 5/5] sysctl: pass kernel pointers to ->proc_handler)
To:     Christoph Hellwig <hch@lst.de>, Stanislav Fomichev <sdf@google.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 8, 2020 at 6:05 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 08, 2020 at 09:45:49AM +0200, Vegard Nossum wrote:
> > Just a test case.
> >
> > Allowing the kernel to allocate an unbounded amount of memory on behalf
> > of userspace is an easy DOS.
> >
> > All the length checks were already in there, e.g.
> >
> >  static int cmm_timeout_handler(struct ctl_table *ctl, int write,
> >                               void __user *buffer, size_t *lenp, loff_t
> > *ppos)
> >  {
> >         char buf[64], *p;
> > [...]
> >                 len = min(*lenp, sizeof(buf));
> >                 if (copy_from_user(buf, buffer, len))
> >                         return -EFAULT;
>
> Doesn't help if we don't know the exact limit yet.  But we can put
> some arbitrary but reasonable limit like KMALLOC_MAX_SIZE on the
> sysctls and see if this sticks.

adding Stanislav. I think he's looking into this already.
