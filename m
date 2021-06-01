Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D658939720E
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhFALIc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 07:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231219AbhFALIb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Jun 2021 07:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622545610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aaASPp3wsnjRSRxwYNnrbRgJnT5vvPPdfGvm6PNwdHA=;
        b=KPfK2bGq+PG6tXPU+SV56oltBQLhYSgFpoNvNYfNsxLofYjmOK9DD0TlYNw7B4WTYJ/B9S
        WfqRWRZ8Z8tq73q4jg3k9E6RzVx+uotC1pzl26epzpmjE4HOl9ktO8ITJvZDHQU5cZ3FJE
        MowZgpeOLTnsNTrzmZvGn0vmIIl7+CQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-eCrkLOZDMYCHVjCOPWA1Hw-1; Tue, 01 Jun 2021 07:06:49 -0400
X-MC-Unique: eCrkLOZDMYCHVjCOPWA1Hw-1
Received: by mail-wm1-f70.google.com with SMTP id l18-20020a05600c4f12b02901921c0f2098so317967wmq.0
        for <bpf@vger.kernel.org>; Tue, 01 Jun 2021 04:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aaASPp3wsnjRSRxwYNnrbRgJnT5vvPPdfGvm6PNwdHA=;
        b=iq8zzeotea0SnkiNrQA2Nh7ra7fkcZGN6luTnz9GRhYpm1UZlDXU/S7DCHcS5bj7d+
         1L9xcwkBsYlSZzBbDsheIt6wxyZCcUMJqntWPiATXTf5urILbZ4E8rlFVOySrLD1DMUu
         SATSxLySvOgoqGQFkIdBsaeIURGnsl2RjktHg/ZGdv16I6vSgrJXJfdFPbMwAzhXk/XK
         PzY4N7maKi9blFaqg5+U8CXoRzsyOVWY6I2ERNkLj478DI7ic0pVwd2/icO2g8lBWZHM
         TgRuyMs+WskW0yN9YpYx64S8QGPNEap6vJjXubg9wOOOgp4DwTsdOvlKU/UZNdOzcu9t
         UWiQ==
X-Gm-Message-State: AOAM5312SIJPMVrJXNDYR4RptCChp32hWM/pU5rhtp89J28PcdTdWHJd
        I/QC8UrAOJ4vMez8IosAqxALbVl8D4lLrPXUc1RgFBGZ6s4rli0m+ZwpSx8S1ymOdKSrFQzoH9u
        czQ08Zt0jSKS8
X-Received: by 2002:adf:c38a:: with SMTP id p10mr13213651wrf.138.1622545608107;
        Tue, 01 Jun 2021 04:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxse7H7NC7uKSyVhO6tqCkb28FmQf5X8G+WwPdEHDAGaDn6G2Zi6zozpeSFKQlrGMyxGwqDxw==
X-Received: by 2002:adf:c38a:: with SMTP id p10mr13213630wrf.138.1622545607887;
        Tue, 01 Jun 2021 04:06:47 -0700 (PDT)
Received: from redhat.com (line103-35.adsl.actcom.co.il. [192.117.103.35])
        by smtp.gmail.com with ESMTPSA id o17sm2656386wrp.47.2021.06.01.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 04:06:47 -0700 (PDT)
Date:   Tue, 1 Jun 2021 07:06:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] virtio-net: fix for build_skb()
Message-ID: <20210601070610-mutt-send-email-mst@kernel.org>
References: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 01, 2021 at 02:39:58PM +0800, Xuan Zhuo wrote:
> #1 Fixed a serious error.
> #2 Fixed a logical error, but this error did not cause any serious consequences.
> 
> The logic of this piece is really messy. Fortunately, my refactored patch can be
> completed with a small amount of testing.

Looks good, thanks!
Also needed for stable I think.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Thanks.
> 
> Xuan Zhuo (2):
>   virtio-net: fix for unable to handle page fault for address
>   virtio_net: get build_skb() buf by data ptr
> 
>  drivers/net/virtio_net.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> --
> 2.31.0

