Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6420731C7AB
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 09:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBPI5V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 03:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBPI5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 03:57:09 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196DDC061788
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 00:56:24 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f1so14647849lfu.3
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 00:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyN/1pWzJnIDjuGU29vP9Mf3I8eoOizxWJKMDDh0wtE=;
        b=IcvuvIYXcHFspNRbPxlLm4+57PblcVraelaeMIYyjNTjt1zx1IGKLrTCt0NZ8oW90W
         A3J10ynOrJLbqhOqyW+wT71wdAAER+ez2+dibFWP2sL3GatE3PJ6hhP31uoNXG3SXFcF
         JeH17jjvv0+MXG2vyYwMlLaneE4Le+YYXZz4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyN/1pWzJnIDjuGU29vP9Mf3I8eoOizxWJKMDDh0wtE=;
        b=b6YxAtmwj+zvo+l8Bm2S3E8wk6LOVKZgfyLEXLwQztFWj4jB9RbOPHezrEE2mp8a64
         SE4DgXBYcrmgNK1TJSj65MkN4A3S+g9ffnTbjB/+trFpZuXucmZL+RPqxUMhDAZQxnB/
         Nqq941+mU550BMu4JLrjGUbfo6Ur0wSyC3WN38RxSIgojFpAno+AIrfHZ9XpN0KdtD7+
         9HJqqAYQeRETvvdIvsF7w4tADeWcNmEiGFtExjTba6P3qQ7taUwjugZ0yQJoxybpkR+3
         vvteRO0jz7/JmQSc7hI9bCKiSziWwQSDvB5KEsEMVJQHvgBFLYIMfwaXDuhlxsAFYtBk
         H1Gw==
X-Gm-Message-State: AOAM530D1Xssol1VT9fs7D94NVWGAzeQX+/VSlwmPYC9pX0FDdhvyIe+
        7XxmgTUm50ItSBJUeyr6tMFdiO+S0g9DLyxy/f+TZQ==
X-Google-Smtp-Source: ABdhPJz/llzLGKvbUYahjbAxay9wgBRpvQ5InkpiWt7iKwvcfTR5/ZZDU010kfQ7VhPsb1+lMFTBUzpXNI4DrXznFv0=
X-Received: by 2002:a05:6512:22c9:: with SMTP id g9mr11781605lfu.325.1613465782607;
 Tue, 16 Feb 2021 00:56:22 -0800 (PST)
MIME-Version: 1.0
References: <20210213214421.226357-1-xiyou.wangcong@gmail.com>
 <20210213214421.226357-5-xiyou.wangcong@gmail.com> <602ac96f9e30f_3ed41208b6@john-XPS-13-9370.notmuch>
In-Reply-To: <602ac96f9e30f_3ed41208b6@john-XPS-13-9370.notmuch>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 16 Feb 2021 08:56:11 +0000
Message-ID: <CACAyw99k43REGCh8cP1PioV+k-_BRAjecVHcmtOdL6fi2shxkQ@mail.gmail.com>
Subject: Re: [Patch bpf-next v3 4/5] skmsg: use skb ext instead of TCP_SKB_CB
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Feb 2021 at 19:20, John Fastabend <john.fastabend@gmail.com> wrote:
>
> Cong Wang wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> >
> > Currently TCP_SKB_CB() is hard-coded in skmsg code, it certainly
> > does not work for any other non-TCP protocols. We can move them to
> > skb ext instead of playing with skb cb, which is harder to make
> > correct.
> >
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Jakub Sitnicki <jakub@cloudflare.com>
> > Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > ---
>
> I'm not seeing the advantage of doing this at the moment. We can
> continue to use cb[] here, which is simpler IMO and use the ext
> if needed for the other use cases. This is adding a per packet
> alloc cost that we don't have at the moment as I understand it.

John, do you have a benchmark we can look at? Right now we're arguing
in the abstract.
