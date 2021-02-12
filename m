Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851DF319CFE
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 12:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhBLLC0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 06:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhBLLAm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 06:00:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20DFC061756
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 02:59:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j19so12446420lfr.12
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iJ7UrLQLN4No3RYgCtbCpWKKsSe1h3yHMmFC+swKUY=;
        b=d1eZenfKTiRbgQJJ6zdV5C0OSq6GTfsNg01uQagm4lF4SB1Be6ClhSNUvePhX/+9FK
         vBc54GcHwiWzTGhHo+lCLs+BP5M3+LWAV1NClScLT9xrvJgRMzWRn77CL0M1+haPLkCq
         N4GHs2fZ1pyFWb3ftgNOyJ4VsDmzT7WXgerH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iJ7UrLQLN4No3RYgCtbCpWKKsSe1h3yHMmFC+swKUY=;
        b=X7DYpBEDUHmp/P6MBWwQLYfn9XD3Ofs2V3rQ38tO7l6q470TmA13M+07RdzVRVk54S
         gg2//3f6iucWAyFeMD6dxiJ6gjsdHKR3TC4iOcY/uNSwTRtGHW/VXHQLZV225ycmtvwF
         EP3P6fg53eazyi2051xLmmEwecHlCjpuG3gmXHCocmeGalyFo9upcrJ6rAG9TEbbtlJX
         gKDsnNOKlaqwRIafnd4UQNVWd1VfO9LngUElDndhtBN/WF/FEK8rOzs+Uq7mO4XWSYgS
         HGaDXf5S6voty/kFtH7Cq0geWzJpSGWgMNX0c0y5AO6B02FFjhk1UxCqoFWIvxsraSyF
         KD1g==
X-Gm-Message-State: AOAM532EAZrzZWT+FTfWSYPfxk+JstZ8dexDKP5DsCrZGo1odQmID8GA
        FItkwYAvh/ycvfIKkuN8Un3Dqcr4g7mPZ8LFDLUh5A==
X-Google-Smtp-Source: ABdhPJw+Vc1F+sEGJXji5FNptM/paaFzp2SCzk7duc02x9ddP8qenZ6D2heqx+V8E1nXKWtjb9X2DDvWcI80rzHFmrg=
X-Received: by 2002:ac2:52bc:: with SMTP id r28mr573853lfm.451.1613127590398;
 Fri, 12 Feb 2021 02:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20210210022136.146528-1-xiyou.wangcong@gmail.com> <20210210022136.146528-6-xiyou.wangcong@gmail.com>
In-Reply-To: <20210210022136.146528-6-xiyou.wangcong@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 12 Feb 2021 10:59:39 +0000
Message-ID: <CACAyw9_1ETC_-JUb6Z6hjRQGMBDedGDbKRR0jo_Qa+JuJM0uNQ@mail.gmail.com>
Subject: Re: [Patch bpf-next v2 5/5] sock_map: rename skb_parser and skb_verdict
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
> These two eBPF programs are tied to BPF_SK_SKB_STREAM_PARSER
> and BPF_SK_SKB_STREAM_VERDICT, rename them to reflect the fact
> they are only used for TCP. And save the name 'skb_verdict' for
> general use later.

Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
