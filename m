Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4128F478048
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 00:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhLPXFM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 18:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbhLPXFM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 18:05:12 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B274C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 15:05:12 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p18so240601pld.13
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 15:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yTlxurZuGuZnf7GvVt7mF6OF5+tMvBwPSLk27CUd00=;
        b=K+MZ9KT6R5AKnIWwpN544TqwDCeHWbAT3F4RLwhYc9S0BS89taxbno8VEuwN6ales0
         HY5dgNQjncAjYbnomBBDPOT8bouU4H/3FgIZ6pHdNDKxO7m3fF83PB3zjR8zH+QHBa67
         gF+AOrjW5OzJ3auZADMYYlA/hQVUVDGeiHAk7yx3zZU1MFhlQWIDCJ3XB627sE9diDAw
         KY8h+WHmVvxUHrKSP46B0a7g5OJlPlwCisVpEuT/LQFQjI/+j3gRundWjJwv+i9TF6pQ
         4xeKejcsgnxkLLGciZSaVJ/evpdv2S6cY9kmw8ITihkhi73W9uiuBPu4+JN18d4x3nu/
         BNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yTlxurZuGuZnf7GvVt7mF6OF5+tMvBwPSLk27CUd00=;
        b=6X14KhH1zax9tu9IKamDOO15zui+1HaA+tILRXwsZ0nWH5x9xze3vpLm1Y+1M92Q2q
         Usk4YYZISQURXl6HKc+btF+NRskW7krzo7/mbnzUY5v6AsU/+9oU4/zxKrsYs25CkklH
         QVIlzti7HwXVe7R/EF2b/B9+tkg0J9K/6r4593yrAn+hQNRaUfbroW3NYcBDNWeZd6m6
         GTrA/7kUkf1oWU5DUSGBl7HXXh7+DR0k165oKmxQ0DggQa+WfuGRMGOON7WTZ8jl2Sc+
         ZVnIQZwlPMMbp2xzsicMpKmuKYw5c+OkXLB6voTU72q49htlTzt40cNePYR4NqucwLJW
         FOkg==
X-Gm-Message-State: AOAM530TxdYH+GbpxmefCChE8uw7LpM2npJlaAGNQ55iE7wuDPUyzKab
        wcinkUxGiOGIc1xC9k9xi4n7gaiPu+ur0V2DIeE=
X-Google-Smtp-Source: ABdhPJzKqa532oKEPOl3S4gz2DNUADZNtdHGlBwHX3LTKRbZpQqPyqInikg75SiPz0SaVewznmetam+tABj/Q+e/P0c=
X-Received: by 2002:a17:902:e353:b0:142:d33:9acd with SMTP id
 p19-20020a170902e35300b001420d339acdmr137432plc.78.1639695911586; Thu, 16 Dec
 2021 15:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20211216025538.1649516-1-kuba@kernel.org>
In-Reply-To: <20211216025538.1649516-1-kuba@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Dec 2021 15:05:00 -0800
Message-ID: <CAADnVQ+hkTd0F05EmYPqWvfReMad5Sp6ahOBaYbv9QYkSzFH1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/3] bpf: remove the cgroup -> bpf header dependecy
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 15, 2021 at 6:55 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Changes to bpf.h tend to clog up our build systems. The netdev/bpf
> build bot does incremental builds to save time (reusing the build
> directory to only rebuild changed objects).
>
> This is the rough breakdown of how many objects needs to be rebuilt
> based on file touched:
>
> kernel.h      40633
> bpf.h         17881
> bpf-cgroup.h  17875
> skbuff.h      10696
> bpf-netns.h    7604
> netdevice.h    7452
> filter.h       5003
> sock.h         4959
> tcp.h          4048
>
> As the stats show touching bpf.h is _very_ expensive.
>
> Bulk of the objects get rebuilt because MM includes cgroup headers.
> Luckily bpf-cgroup.h does not fundamentally depend on bpf.h so we
> can break that dependency and reduce the number of objects.
>
> With the patches applied touching bpf.h causes 5019 objects to be rebuilt
> (17881 / 5019 = 3.56x). That's pretty much down to filter.h plus noise.
>
> v2:
> Try to make the new headers wider in scope. Collapse bpf-link and
> bpf-cgroup-types into one header, which may serve as "BPF kernel
> API" header in the future if needed. Rename bpf-cgroup-storage.h
> to bpf-inlines.h.
>
> Add a fix for the s390 build issue.
>
> v3: https://lore.kernel.org/all/20211215061916.715513-1-kuba@kernel.org/
> Merge bpf-includes.h into bpf.h.
>
> v4: https://lore.kernel.org/all/20211215181231.1053479-1-kuba@kernel.org/
> Change course - break off cgroup instead of breaking off bpf.
>
> v5:
> Add forward declaration of struct bpf_prog to perf_event.h
> when !CONFIG_BPF_SYSCALL (kbuild bot).

Applied. Thanks
