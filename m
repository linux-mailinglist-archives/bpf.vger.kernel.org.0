Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6E7380F62
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 20:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhENSEM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 May 2021 14:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhENSEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 May 2021 14:04:12 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B694C061574
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 11:03:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id v188so180587ybe.1
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hLyw2uR+bfkbeaBMZ+iWGrPj1WFcMPPzB+aALMIchE=;
        b=lnzqsBz+04yvfbwIiF+owjLvSS6Z1nhpCnR5hLOgAGaFWJNz+1NIdi9Gma5vKJTaB6
         7twMyL3ruBIlZKGlF/wFgENNVp+E0Vc0A+BhlCR2UTw/0BzQsj9SUGjkaY0pwTe8vxaY
         gmAHLzn1m4epgac0lcCoA8herNsYMusW54vKCJbuTmV0mb8HZOhh/wEuM/DsOw7qO/TD
         9AaIOWSBaQZTSQJDd+Z6qnfRIBVd6gLagPp2CzCLxzCRAUaHYADS1RxYt2jZQGmiAg5A
         HTL8jZhTehFt8Dfw9i5Wf7HsCMFJTXUUf6VXjPS6FRZQdyZuApIA06HJWX9RMRoHXECC
         Af4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hLyw2uR+bfkbeaBMZ+iWGrPj1WFcMPPzB+aALMIchE=;
        b=OhvBCbuZW1hwt8ki47V0kh9LfJ8be1IW1VMS5x02b/i2NDYtVqBg4Ag27ZFt54GZhB
         HNVHUcGWWbrNmz3fahld3RXnNzrHjKx97enmHOyMvY2aRwfRBXCDmSmS1lO+1yPIV3FE
         rNZCSasJGyngjL3iIcnySG6nFiGBJyFse8G+77y+G8uNWSIx5qPwKBbMGDWSMsN1Kxhb
         JeWwE5Oau35zAGZj+k5BOIPcbZqgInjG6l0abx2iCu86bobvYamAbS2EhY6+RYfDcB2Q
         N8Tm9o5yQciKUbHoLUnR4tzjfGkETDQBc6+UW98PP2Vrl1sUBJ2FZbs5xW4EMHvcRzUs
         DjMQ==
X-Gm-Message-State: AOAM532tjYwqt4Yt4GsO6Ug6vOl1cI/quW+lF1jstAnjmZbXnTXuZ6dS
        zkHtGBHVnnMIogAHqyBQGvu2CcIS2oMk4MAlD9o=
X-Google-Smtp-Source: ABdhPJzBZJm1IBD7GHmp6MCeCCpvKIU7pKZmgR/loEvy83PJuWOjGtmGHTCfXu8g3tkE/DnzgIV0idxmdmXYKV5aW20=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr20875527ybr.425.1621015379776;
 Fri, 14 May 2021 11:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com> <20210514003623.28033-17-alexei.starovoitov@gmail.com>
In-Reply-To: <20210514003623.28033-17-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 May 2021 11:02:48 -0700
Message-ID: <CAEf4BzZuO+JpTEk13i-LRD+9C0JscUvChdqh0JKDzef0tvNXBw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 16/21] libbpf: Introduce bpf_map__initial_value().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 13, 2021 at 5:36 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_map__initial_value() to read initial contents
> of mmaped data/rodata/bss maps.
> Note that bpf_map__set_initial_value() doesn't allow modifying
> kconfig map while bpf_map__initial_value() allows reading
> its values.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  tools/lib/bpf/libbpf.c   | 8 ++++++++
>  tools/lib/bpf/libbpf.h   | 1 +
>  tools/lib/bpf/libbpf.map | 1 +
>  3 files changed, 10 insertions(+)
>

[...]
