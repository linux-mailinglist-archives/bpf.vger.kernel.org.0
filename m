Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D5242F504
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbhJOOTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 10:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbhJOOTh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Oct 2021 10:19:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84DC061570
        for <bpf@vger.kernel.org>; Fri, 15 Oct 2021 07:17:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r19so41288073lfe.10
        for <bpf@vger.kernel.org>; Fri, 15 Oct 2021 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNBNetlXiKA/5wOmeUNGAiY3ozuqgab3m7QPlttlB08=;
        b=CkPGlgl27sU2jSGBCoEIwfYUgGG9z5FzoqDhlFLSg61p58QeVXqcCoiZJf5G4SpakK
         VYuZz7j8aL5DftQ1TUAa4QaMcjxBD25M7+7dFFZCvvYwgqW7fJDMd1iw83z6xXqLlfi4
         DkpPZfPzLe1KM9+pNjKBOILQN8UQA/WIq4wL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNBNetlXiKA/5wOmeUNGAiY3ozuqgab3m7QPlttlB08=;
        b=L/ft+ulOKwMo2fjcsnFVi/MMaZZNqyvpLLA+4Yz3Zg1k+ppCf2c55YoaAjl914Zi+G
         8ru8FN+S6XApCX4LRmTodeX2OyEVL6yCqsappPCF8z+5qTS3VkrQR21s0RKlxUfR188h
         I4lFbT5lfcXD6SeOuwwG7DnTjhO0fZ91afV3H+PCh2OmpO/A41+mrj17frrXhCxoy0Hy
         L/Hgdx80saoz7o3gVdQwWJ4yGRX1bmwd8IYUNTIml3+jioiMsUnzQlcDoUABYPeHnCCy
         ZtuB/EGErY+VW7kGPKhzdL+2QiRX5r+fnR6hLlUgh+gZAwxrYz6Y1ZAJ1+XZKbu5+wG7
         aemg==
X-Gm-Message-State: AOAM530KN5GMcPiRx2D5y6rD3L7hy92zrLF7saYASLRYLp2ZdheusUSE
        QdYI8PXhbOjKjbSD0TclgHRyRE/YHmYrkl+zyW1deg==
X-Google-Smtp-Source: ABdhPJxC2+JyudW+dRKjr4gncthcJMBkAZznViO+/7S3dZxYXWMvX/Wnq0PXw79vvK7l5bPCnyJAPWJjRdC//U6T9ko=
X-Received: by 2002:a05:6512:38a8:: with SMTP id o8mr11424441lft.102.1634307447034;
 Fri, 15 Oct 2021 07:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211015112336.1973229-1-markpash@cloudflare.com>
In-Reply-To: <20211015112336.1973229-1-markpash@cloudflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 15 Oct 2021 15:17:16 +0100
Message-ID: <CACAyw99T4bUoXp7kAftuOMBW4YVLfAosJvVSKwpoBXVgH4sAVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Get ifindex in BPF_SK_LOOKUP prog type
To:     Mark Pashmfouroush <markpash@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@chromium.org>,
        Joe Stringer <joe@cilium.io>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 15 Oct 2021 at 12:24, Mark Pashmfouroush
<markpash@cloudflare.com> wrote:
>
> BPF_SK_LOOKUP users may want to have access to the ifindex of the skb
> which triggered the socket lookup. This may be useful for selectively
> applying programmable socket lookup logic to packets that arrive on a
> specific interface, or excluding packets from an interface.

For the series:

Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
