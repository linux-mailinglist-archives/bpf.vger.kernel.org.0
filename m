Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EC403DEB
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 18:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349999AbhIHQw7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 12:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhIHQw7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 12:52:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE408C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 09:51:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so2165317wmi.0
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u0sEIssVhhMZXP/9tK3Wy1fvOEBz/DBHnG38YBmZtuU=;
        b=JNh4XvHXFB+ZZmOGIGOzaSfeJ3JwGO7/ddserLozPdp/XmPjRDTKbU5CLsPS0DSD7O
         PB64MXie4CDEQSLl2sB0ccud87Uq+r8lvZzZ/ZjGFWpIkVcVSwqbPDyw+EWIdDsodjAJ
         GdPKMfxVllrouhxsUX0oiPaINyFXjWVmpZmmh4u/FJxPOQqxIkropGoW7RBpZmhJigGd
         bIyEpWwvN8n10zsuHNrFEodSfb2nGXx+jyJ0b5v5nuIUvpSSG81iPAtvBwAKmTEhDiEx
         GYuebSgPMnV1sjDRqcTOyz3igWwOu+HT/vBBnopnjrJTWljyrg5sbck2VY1iIpmqkrlO
         D7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u0sEIssVhhMZXP/9tK3Wy1fvOEBz/DBHnG38YBmZtuU=;
        b=UmhKwQ6K9IT/9Qp/HSCURvMOeaIt1N/vQbIqTVVjYnBd1TxvmTRMt96AHvt17VIUVq
         7l8DcmWfJC7SDGVB43IVtv6x6areat9Izd8Y7Ge/qewQnk1Fu0UU5RybbEZB9uzUy9uc
         dWsB1XkN6OnkmQmhXTW0aeDm/2bG+lY2LwwVjvmXcVmiXuGWSxArc0adNOyWO5Kz9Q6/
         Sp+w56bZPXHcv9bZL5UtJOFKS8hpvyYTpt6gsyhgab8Ca7k1YspH8Qh5ANbLcICdu2N7
         SZcCehc95EgL2fivapgzQ4SXhXBmg0Qpz/+nMqefRqbchnyRvL6SDitZ6Y1qMkSWgvAX
         KG7w==
X-Gm-Message-State: AOAM531SCaIzRc4RZBh6Q02CqsAm6t6DjOr+3F1ZmspqhzZbvM3+BwO6
        ddGTatx2/Q8drUtI4FdvuZzeoQ==
X-Google-Smtp-Source: ABdhPJzveQXqk7vxlS0je8HU7aSts3V9itUTDgGo7hbGJh4/dvZ49lDyAxd1/y8umswsHVFKjezE7g==
X-Received: by 2002:a1c:210a:: with SMTP id h10mr4713239wmh.117.1631119909316;
        Wed, 08 Sep 2021 09:51:49 -0700 (PDT)
Received: from apalos.home (ppp-94-66-220-137.home.otenet.gr. [94.66.220.137])
        by smtp.gmail.com with ESMTPSA id d8sm2828142wrv.20.2021.09.08.09.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:51:48 -0700 (PDT)
Date:   Wed, 8 Sep 2021 19:51:44 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     moyufeng <moyufeng@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        alexander.duyck@gmail.com, linux@armlinux.org.uk, mw@semihalf.com,
        linuxarm@openeuler.org, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, thomas.petazzoni@bootlin.com,
        hawk@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, will@kernel.org, willy@infradead.org,
        vbabka@suse.cz, fenghua.yu@intel.com, guro@fb.com,
        peterx@redhat.com, feng.tang@intel.com, jgg@ziepe.ca,
        mcroce@microsoft.com, hughd@google.com, jonathan.lemon@gmail.com,
        alobakin@pm.me, willemb@google.com, wenxu@ucloud.cn,
        cong.wang@bytedance.com, haokexin@gmail.com, nogikh@google.com,
        elver@google.com, yhs@fb.com, kpsingh@kernel.org,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, chenhao288@hisilicon.com
Subject: Re: [PATCH net-next v2 4/4] net: hns3: support skb's frag page
 recycling based on page pool
Message-ID: <YTjqIOt5+0J0r2bg@apalos.home>
References: <1628217982-53533-1-git-send-email-linyunsheng@huawei.com>
 <1628217982-53533-5-git-send-email-linyunsheng@huawei.com>
 <2b75d66b-a3bf-2490-2f46-fef5731ed7ad@huawei.com>
 <20210908080843.2051c58d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YTjWK1rNsYIcTt4O@apalos.home>
 <20210908085723.3c9c2de2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908085723.3c9c2de2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 08:57:23AM -0700, Jakub Kicinski wrote:
> On Wed, 8 Sep 2021 18:26:35 +0300 Ilias Apalodimas wrote:
> > > Normally I'd say put the stats in ethtool -S and the rest in debugfs
> > > but I'm not sure if exposing pages_state_hold_cnt and
> > > pages_state_release_cnt directly. Those are short counters, and will
> > > very likely wrap. They are primarily meaningful for calculating
> > > page_pool_inflight(). Given this I think their semantics may be too
> > > confusing for an average ethtool -S user.
> > > 
> > > Putting all the information in debugfs seems like a better idea.  
> > 
> > I can't really disagree on the aforementioned stats being confusing.
> > However at some point we'll want to add more useful page_pool stats (e.g the
> > percentage of the page/page fragments that are hitting the recycling path).
> > Would it still be 'ok' to have info split across ethtool and debugfs?
> 
> Possibly. We'll also see what Alex L comes up with for XDP stats. Maybe
> we can arrive at a netlink API for standard things (broken record).
> 
> You said percentage - even tho I personally don't like it - there is a
> small precedent of ethtool -S containing non-counter information (IOW
> not monotonically increasing event counters), e.g. some vendors rammed
> PCI link quality in there. So if all else fails ethtool -S should be
> fine.

Yea percentage may have been the wrong example. I agree that having
absolute numbers (all allocated pages and recycled pages) is a better
option.  To be honest keeping the 'weird' stats in debugfs seems sane, the 
pages_state_hold_cnt/pages_state_release_cnt are only going to be needed
during debug.


Thanks
/Ilias
