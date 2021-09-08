Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9B403C76
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 17:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352008AbhIHP1u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbhIHP1u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 11:27:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A04C061757
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 08:26:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b6so3870147wrh.10
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z6aIlkSjV86MFHPZTFrxiT+oD432fUchaiXzwO3BfqI=;
        b=S0PfmmT0a8dvuobUBJXJT3gxzOP8RuobMIz98161p2bpEsB+XXfOubPbsXnFIx3rXL
         of+Zdu6RQxLqZQWZd6G4zbVqBEJG3cM1Zj4u7njfPoa7HVCjEiCAOMJCg4hP5OK3UfcG
         K2a3Py5Ohy5R87uj6uj8cQoBODXo8AC+26+LAkHMVCOONUrDiz+EzPTfsxXs4JyacTes
         GWd4YsWxCMYFutfku/4L7O9616YWNTzPqoJ8qL87JqgoK7yKGQr66aZxzAwXH/sCqzQt
         oOUSRXFX6eKHjOOL4WbksrmMCLfyIRn6x1wQFd7/jI+9IvKVbLqi1ijjalXoXwppGCJh
         XdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z6aIlkSjV86MFHPZTFrxiT+oD432fUchaiXzwO3BfqI=;
        b=sPkFX3luPur+amKubLbo+Is+0nw9F5+UbKfQr94Q8I+4cybVgHe6YKLPfo3Jm4QIht
         fK54+MJWl09o58nagM2DVrNZBLk+MAwc2T4L48iG9AQyJJ9deFe1qkbWFN9OdZzP51f/
         Apt12Z+sOyBQYQT9T7xtSyvPRORjWehaa+a60hKw61cHkC3QsOTWQHStJ6ZG/40t1MoA
         wFqdAzIMub16+9kAK4dr5ox0fC1tNyvY0bw/7/kLYMzcWFFrBrRR8H7n4u2PS02VnGf6
         mrFs6v4wVHsm8LjmI3Cbp3w3iq5n7rRdK+QybfIVYCAN72FNVbcgtXwW2Rgf4K4zFMpD
         aekw==
X-Gm-Message-State: AOAM5313n04u2NfqbeUGQHRAm0XsMcPjTEcCQZMmDW8khLk9Bjlz9uqw
        G/9RGsuF4katiaCxVjO6rF+zZg==
X-Google-Smtp-Source: ABdhPJxnfl9kjmj373dx7q08lHZzeLCY4941jItBk3GfmS1Pdp7uFWMXEnYrOHa08RKQjQngLdq6+Q==
X-Received: by 2002:a05:6000:362:: with SMTP id f2mr4782151wrf.197.1631114800396;
        Wed, 08 Sep 2021 08:26:40 -0700 (PDT)
Received: from apalos.home (ppp-94-66-220-137.home.otenet.gr. [94.66.220.137])
        by smtp.gmail.com with ESMTPSA id k16sm2403105wrh.24.2021.09.08.08.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:26:40 -0700 (PDT)
Date:   Wed, 8 Sep 2021 18:26:35 +0300
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
Message-ID: <YTjWK1rNsYIcTt4O@apalos.home>
References: <1628217982-53533-1-git-send-email-linyunsheng@huawei.com>
 <1628217982-53533-5-git-send-email-linyunsheng@huawei.com>
 <2b75d66b-a3bf-2490-2f46-fef5731ed7ad@huawei.com>
 <20210908080843.2051c58d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210908080843.2051c58d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jakub,

On Wed, Sep 08, 2021 at 08:08:43AM -0700, Jakub Kicinski wrote:
> On Wed, 8 Sep 2021 16:31:40 +0800 moyufeng wrote:
> >     After adding page pool to hns3 receiving package process,
> > we want to add some debug info. Such as below:
> > 
> > 1. count of page pool allocate and free page, which is defined
> > for pages_state_hold_cnt and pages_state_release_cnt in page
> > pool framework.
> > 
> > 2. pool size、order、nid、dev、max_len, which is setted for
> > each rx ring in hns3 driver.
> > 
> > In this regard, we consider two ways to show these info：
> > 
> > 1. Add it to queue statistics and query it by ethtool -S.
> > 
> > 2. Add a file node "page_pool_info" for debugfs, then cat this
> > file node, print as below:
> > 
> > queue_id  allocate_cnt  free_cnt  pool_size  order  nid  dev  max_len
> > 000		   xxx       xxx        xxx    xxx  xxx  xxx      xxx
> > 001
> > 002
> > .
> > .
> > 	
> > Which one is more acceptable, or would you have some other suggestion?
> 
> Normally I'd say put the stats in ethtool -S and the rest in debugfs
> but I'm not sure if exposing pages_state_hold_cnt and
> pages_state_release_cnt directly. Those are short counters, and will
> very likely wrap. They are primarily meaningful for calculating
> page_pool_inflight(). Given this I think their semantics may be too
> confusing for an average ethtool -S user.
> 
> Putting all the information in debugfs seems like a better idea.

I can't really disagree on the aforementioned stats being confusing.
However at some point we'll want to add more useful page_pool stats (e.g the
percentage of the page/page fragments that are hitting the recycling path).
Would it still be 'ok' to have info split across ethtool and debugfs?

Regards
/Ilias
