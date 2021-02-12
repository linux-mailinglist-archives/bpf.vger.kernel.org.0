Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2A7319CF2
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBLK7n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 05:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhBLK7k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 05:59:40 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADCCC061756
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 02:58:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v24so12473683lfr.7
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 02:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCdl6xS/yVJp5Nl7mhEYBP6S5Y+b/9q9qCwgCmlGQQE=;
        b=Nd7D08C6QZXWVMkUKkcBrBPmPLJ8Y9A5p66s4YYeO/KTmwpLyUnfNViVHreZxOYt8f
         16Mwfe20mTpDdjMeNttWSo95sPFFGTsu9b9YKUUnTuClYDXEGativjGB7D82W7oyfQ8u
         wRt7xbuzJWyziuaaUSSvE1BQNaHaLzMCGGNVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCdl6xS/yVJp5Nl7mhEYBP6S5Y+b/9q9qCwgCmlGQQE=;
        b=Gtz0/TCc+c3P9ZC45bIjVlLdFbyubuZOru3k71+T3XnMz/JVajCpMYppQTowgIu/os
         3LYYcFq4weCjiwvfCg/v7Q60ISHCMUWcM9s+2rUg91UYUvg+1aBODzXN9x+FC1RQoA7P
         I5Nfyk3D/fDewq1aYaj5NcaCyRREUrIMWqSrLVHErdrR33xcRfmBBFFTOzfW9ImivS9W
         dPHBirhFyOiopQ5vKwuwBzgQxxvEEWMmovLO+VFcGF/KdE5K6NwWDEK6wIKtNOpDVssB
         ZLAUSCgftGRrjmcRpPLWbJ4veLc7lK4ebvUp4Xefg4ZZgBCaxd7I16d1e3Ntbec5bM4o
         keRQ==
X-Gm-Message-State: AOAM530Rrgqigf7Zi3XAKlTqt43flcm65M4BcHud0yYN4fOVhHomDgm7
        l5VomA7iAdsMg1KnEfpf68FrxpB5hqPIvzw+bfjx8g==
X-Google-Smtp-Source: ABdhPJyjtQBACFtEed271bZN/M1Ef3JGWDwWO+HQflqG73mqOtcxmBfewpTme7AHwhpdOwDFK/MzF8btczQdpqj2TUA=
X-Received: by 2002:ac2:58f8:: with SMTP id v24mr1318891lfo.56.1613127533108;
 Fri, 12 Feb 2021 02:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20210210022136.146528-1-xiyou.wangcong@gmail.com> <20210210022136.146528-5-xiyou.wangcong@gmail.com>
In-Reply-To: <20210210022136.146528-5-xiyou.wangcong@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 12 Feb 2021 10:58:42 +0000
Message-ID: <CACAyw99ErxrTShKNeP+6kr9oj3Bw9BBZ8pe34pSGEueJmWOb5Q@mail.gmail.com>
Subject: Re: [Patch bpf-next v2 4/5] skmsg: use skb ext instead of TCP_SKB_CB
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Feb 2021 at 02:22, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> From: Cong Wang <cong.wang@bytedance.com>
>
> Currently TCP_SKB_CB() is hard-coded in skmsg code, it certainly
> does not work for any other non-TCP protocols. We can move them to
> skb ext instead of playing with skb cb, which is harder to make
> correct.

Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
