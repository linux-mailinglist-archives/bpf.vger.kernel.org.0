Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9E458BAE
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 10:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhKVJlD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 04:41:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239083AbhKVJlC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 04:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637573876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIlk+ihBReA4luef3l9FK2apG4r8ckQxVs4q15V5P4E=;
        b=NLR+E018s2S7ZzYKWUob+eoSFm0wBoB+b328BV0Rzrf6RDlKY/H0JQW4KuuWV96Rv879KR
        ZNAB9aQc/LpsQHbBrCxqwnXsn/ugmIRkdMnQWWlTBkW6VBt9iZ72aI6m/sXitm4kw5f2CK
        IuS6zHKLtLeOwL97Ox6NAxQ4xFgwyT0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-MzvayvqGNuKGclgGLyVKMQ-1; Mon, 22 Nov 2021 04:37:54 -0500
X-MC-Unique: MzvayvqGNuKGclgGLyVKMQ-1
Received: by mail-wm1-f72.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so9074012wms.8
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 01:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIlk+ihBReA4luef3l9FK2apG4r8ckQxVs4q15V5P4E=;
        b=EM3oizA3cNN12Aj896D+QGMtYeXCwsJrSpz4+WzPIkt+emgBZFjyr+av8ugGC6agJD
         mzC90YeycH9+dPBSK5Hhc1evvwe3ywDMrXoY9QSDho2S607O3oRBf07rUogdu9ktmPPE
         Y0TXZk5+qA1Cdf3XXNhgjDBjzraWsAIUMwDa90+hfCUUO0gyLPC2z2yWYPj1/KmvApbU
         9c6JG0qzpD/k627NdZGNHqAyg5Ix2BUaPV48JFGPI/9sGb/DO0FIxBWOff1heWO/nblq
         s95OwaiXVL39gHR5oO1/15wlC2gI6OoyxUGkEK+95KZidhoH0W2xm5IYAvHXidCpuno7
         gCeg==
X-Gm-Message-State: AOAM530ob7ZdZQMPzQgv5F9hMBuLL4/zBQyXEb6kIO3gEU4ULr7kmc7s
        Rai3plQWItB5uvgXpLtbtOfqM5TCqsFzSMxVXVfPLy1KN9tE5VYJ7EFDuEwmCHRBUiFO9uIbfJ4
        lEqfOJEUZo+mM
X-Received: by 2002:a5d:6dc3:: with SMTP id d3mr36126809wrz.159.1637573873434;
        Mon, 22 Nov 2021 01:37:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxBO0fMZmz4vU5DDAWrAXgOEEtOabqFm5qkQuvtfLHepd8zMa6raRS+mZ6nm92m3RkPKn+JQ==
X-Received: by 2002:a5d:6dc3:: with SMTP id d3mr36126776wrz.159.1637573873232;
        Mon, 22 Nov 2021 01:37:53 -0800 (PST)
Received: from redhat.com ([2.55.128.84])
        by smtp.gmail.com with ESMTPSA id j11sm8373660wrt.3.2021.11.22.01.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 01:37:52 -0800 (PST)
Date:   Mon, 22 Nov 2021 04:37:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andrey Ryabinin <arbn@yandex-team.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 6/6] vhost_net: use RCU callbacks instead of
 synchronize_rcu()
Message-ID: <20211122043620-mutt-send-email-mst@kernel.org>
References: <20211115153003.9140-1-arbn@yandex-team.com>
 <20211115153003.9140-6-arbn@yandex-team.com>
 <CACGkMEumax9RFVNgWLv5GyoeQAmwo-UgAq=DrUd4yLxPAUUqBw@mail.gmail.com>
 <b163233f-090f-baaf-4460-37978cab4d55@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b163233f-090f-baaf-4460-37978cab4d55@yandex-team.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 19, 2021 at 02:32:05PM +0300, Andrey Ryabinin wrote:
> 
> 
> On 11/16/21 8:00 AM, Jason Wang wrote:
> > On Mon, Nov 15, 2021 at 11:32 PM Andrey Ryabinin <arbn@yandex-team.com> wrote:
> >>
> >> Currently vhost_net_release() uses synchronize_rcu() to synchronize
> >> freeing with vhost_zerocopy_callback(). However synchronize_rcu()
> >> is quite costly operation. It take more than 10 seconds
> >> to shutdown qemu launched with couple net devices like this:
> >>         -netdev tap,id=tap0,..,vhost=on,queues=80
> >> because we end up calling synchronize_rcu() netdev_count*queues times.
> >>
> >> Free vhost net structures in rcu callback instead of using
> >> synchronize_rcu() to fix the problem.
> > 
> > I admit the release code is somehow hard to understand. But I wonder
> > if the following case can still happen with this:
> > 
> > CPU 0 (vhost_dev_cleanup)   CPU1
> > (vhost_net_zerocopy_callback()->vhost_work_queue())
> >                                                 if (!dev->worker)
> > dev->worker = NULL
> > 
> > wake_up_process(dev->worker)
> > 
> > If this is true. It seems the fix is to move RCU synchronization stuff
> > in vhost_net_ubuf_put_and_wait()?
> > 
> 
> It all depends whether vhost_zerocopy_callback() can be called outside of vhost
> thread context or not. If it can run after vhost thread stopped, than the race you
> describe seems possible and the fix in commit b0c057ca7e83 ("vhost: fix a theoretical race in device cleanup")
> wasn't complete. I would fix it by calling synchronize_rcu() after vhost_net_flush()
> and before vhost_dev_cleanup().
> 
> As for the performance problem, it can be solved by replacing synchronize_rcu() with synchronize_rcu_expedited().

expedited causes a stop of IPIs though, so it's problematic to
do it upon a userspace syscall.

> But now I'm not sure that this race is actually exists and that synchronize_rcu() needed at all.
> I did a bit of testing and I only see callback being called from vhost thread:
> 
> vhost-3724  3733 [002]  2701.768731: probe:vhost_zerocopy_callback: (ffffffff81af8c10)
>         ffffffff81af8c11 vhost_zerocopy_callback+0x1 ([kernel.kallsyms])
>         ffffffff81bb34f6 skb_copy_ubufs+0x256 ([kernel.kallsyms])
>         ffffffff81bce621 __netif_receive_skb_core.constprop.0+0xac1 ([kernel.kallsyms])
>         ffffffff81bd062d __netif_receive_skb_one_core+0x3d ([kernel.kallsyms])
>         ffffffff81bd0748 netif_receive_skb+0x38 ([kernel.kallsyms])
>         ffffffff819a2a1e tun_get_user+0xdce ([kernel.kallsyms])
>         ffffffff819a2cf4 tun_sendmsg+0xa4 ([kernel.kallsyms])
>         ffffffff81af9229 handle_tx_zerocopy+0x149 ([kernel.kallsyms])
>         ffffffff81afaf05 handle_tx+0xc5 ([kernel.kallsyms])
>         ffffffff81afce86 vhost_worker+0x76 ([kernel.kallsyms])
>         ffffffff811581e9 kthread+0x169 ([kernel.kallsyms])
>         ffffffff810018cf ret_from_fork+0x1f ([kernel.kallsyms])
>                        0 [unknown] ([unknown])
> 
> This means that the callback can't run after kthread_stop() in vhost_dev_cleanup() and no synchronize_rcu() needed.
> 
> I'm not confident that my quite limited testing cover all possible vhost_zerocopy_callback() callstacks.

