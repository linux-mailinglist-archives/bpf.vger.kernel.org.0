Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2EF380B03
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhENOFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 May 2021 10:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234065AbhENOFy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 May 2021 10:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621001083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=is4w+TCn3msJ9Lv2hnDIZ3A/ae5d78m5BGbhOBjRDwM=;
        b=BS5Ujx69U2GrtCwJEcYwhJX7xD3G6yPIAUghVI0AFElZaTG6XBepLWE1Ro1nYNNa+6xnHP
        qaKidnK+ywDFT/+PIJkOjiblofaZftWXJ6SpXbgNblvAfeJNX0a/wJrAb9KL+rleoRr04V
        8LVZjrGSKor1CVe5UzOFPpPS/e0Uq/0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-6wIUT2qhOjCu7fXJ0uQyNw-1; Fri, 14 May 2021 10:04:41 -0400
X-MC-Unique: 6wIUT2qhOjCu7fXJ0uQyNw-1
Received: by mail-wm1-f72.google.com with SMTP id j128-20020a1c55860000b02901384b712094so1126223wmb.2
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 07:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=is4w+TCn3msJ9Lv2hnDIZ3A/ae5d78m5BGbhOBjRDwM=;
        b=Qth65LLXy6E9+ADQxIHbWzCF+CEA8tu3Tf7llqAswrw1F4Cw6tXDFDthiM8fgoDLzT
         9qjzbQkkGCHRuxamAirx2Zkch1JzEXsIP7GyUow8c54oKjXV96Ugj0YOZEwC8wBTEvbW
         UtpD3mEuJ/KUDvjNMoUWfMKeDp3YNH8Vsy669/x4zWWRxGPyEAQjpZzan0yul7bh2Yjj
         n0yZlrd6GtyVXYUSiaTNR6/JPLn3kNjRap3RGyKO4T36xQxMCh5s5l0js6x8jNxnG2Gr
         ts5Y4fO1P+lpo/K+SPyKa+TbO4FBgVV+RRawunNVNVAML81TxJ1MOn3WlZgtaBvXtFtv
         h5gw==
X-Gm-Message-State: AOAM533qWlF5b32cYfawjhV3xGgvbfG5llKP8Pc6aOlzm1mRFemvOitG
        tWyctmilz03CKvxKkIYpB6s/LuNxPbk7y3R3GZUgIKpwNuYNOa+VG7l/13mADWLJvZy0YU1Uh9N
        2h+bkzn2yzPYn
X-Received: by 2002:a5d:4c46:: with SMTP id n6mr23646429wrt.95.1621001079448;
        Fri, 14 May 2021 07:04:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4iA/HgadsB2lsRId4OOvBGpKAqwH3PMIW7YVjgLLNeMDpfssFX4UIjarUvAw16XstGk4aKg==
X-Received: by 2002:a5d:4c46:: with SMTP id n6mr23646401wrt.95.1621001079232;
        Fri, 14 May 2021 07:04:39 -0700 (PDT)
Received: from redhat.com (bzq-79-181-160-222.red.bezeqint.net. [79.181.160.222])
        by smtp.gmail.com with ESMTPSA id f13sm3003855wrt.86.2021.05.14.07.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:04:38 -0700 (PDT)
Date:   Fri, 14 May 2021 10:04:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] virtio-net: fix for build_skb()
Message-ID: <20210514100326-mutt-send-email-mst@kernel.org>
References: <20210513114808.120031-1-xuanzhuo@linux.alibaba.com>
 <162094681137.5074.5504584757048483865.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162094681137.5074.5504584757048483865.git-patchwork-notify@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 13, 2021 at 11:00:11PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (refs/heads/master):
> 
> On Thu, 13 May 2021 19:48:06 +0800 you wrote:
> > #1 Fixed a serious error.
> > #2 Fixed a logical error, but this error did not cause any serious consequences.
> > 
> > The logic of this piece is really messy. Fortunately, my refactored patch can be
> > completed with a small amount of testing.
> > 
> > Thanks.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net-next,1/2] virtio-net: fix for unable to handle page fault for address
>     https://git.kernel.org/netdev/net-next/c/6c66c147b9a4
>   - [net-next,2/2] virtio-net: get build_skb() buf by data ptr
>     https://git.kernel.org/netdev/net-next/c/7bf64460e3b2
> 
> You are awesome, thank you!

I actually think this is a bugfix patchset and belongs in net, not
net-next. And maybe stable? For there

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 

