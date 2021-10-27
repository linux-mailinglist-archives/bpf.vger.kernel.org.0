Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC22E43C543
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 10:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhJ0IhJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 04:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhJ0IhI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 04:37:08 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90534C061570
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:34:43 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h11so3430936ljk.1
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIDFtAiKeA+WxeyP7TSnB2e6k+2/VG+8HR9nAV/81kI=;
        b=k3lsPonJ3nEEe9s6t52vikl+DKG36TXthaT+bsFpnRoBg0qP3GSE5peymnGk1dpcpf
         WuUW6UDylysQEEPYcNvkEyHKGiXricPjOaaYonKnpj/0DEws9bWHtJhwO3or0XAIfK0s
         c3Je9JvEiamrGDrRbPa50yEUUbtepgxBLz6p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIDFtAiKeA+WxeyP7TSnB2e6k+2/VG+8HR9nAV/81kI=;
        b=W6HnOJ5iEbeLfzQfOLfTrqWjiry3BP3ijkJT753EMMseOHyaH6ECtr7XuRMOttUnWV
         FQAkN1QT6X15x534czBnsaBVxwQGPIDnM2gVSQ+N0/Cyw/kc61PdNGdXPnPnnNbWn2hO
         qfM6XUlvS1SbEhQEir3dwt7Lw41QaIc+JEbB1sIjCRfc7RTvjyqNQGH2H2g1q/hwnFt4
         uFI1YVWGbWAjnG64cCEihtnVtqfKIaLaGBRFeLE6rXt4W5rh29V+ULm+pz8jMa0D1lbw
         u15Tr6QE8tIcigRxeUnPVRJbivjYk6Dff1LuIvj5auqibDuywrEGNAK5IXjrYUHFgAw7
         4J3A==
X-Gm-Message-State: AOAM530tW1Mwr2RCYzkp9ya4p83jD/cgDBgMz6oq8/Y72fb7pRKF6zSh
        GhgB280FxPO46/PwCisQe6IhyJs5kTnJuAULhPncYQ==
X-Google-Smtp-Source: ABdhPJxI9s3Gnb8U1l5ecHTKXwGJNbsw6QtitFikqgde5xFWdwI818s8KeQVN/LZpnNqM2coqoQMKip3NaMpkNWUFr8=
X-Received: by 2002:a05:651c:2328:: with SMTP id bi40mr31550620ljb.121.1635323681920;
 Wed, 27 Oct 2021 01:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211019144655.3483197-1-maximmi@nvidia.com> <20211019144655.3483197-10-maximmi@nvidia.com>
 <CACAyw9_MT-+n_b1pLYrU+m6OicgRcndEBiOwb5Kc1w0CANd_9A@mail.gmail.com>
 <87y26nekoc.fsf@toke.dk> <533129a4-7f4e-e7a6-407c-f15b6acbb0e2@nvidia.com>
In-Reply-To: <533129a4-7f4e-e7a6-407c-f15b6acbb0e2@nvidia.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 27 Oct 2021 09:34:31 +0100
Message-ID: <CACAyw9-rKNX=EtQ2JtLkLTyDfj2-HBtZfFB05TLgcJSw3ja7AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] bpf: Add a helper to issue timestamp
 cookies in XDP
To:     Maxim Mikityanskiy <maximmi@nvidia.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@chromium.org>,
        Joe Stringer <joe@cilium.io>, Tariq Toukan <tariqt@nvidia.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 22 Oct 2021 at 17:56, Maxim Mikityanskiy <maximmi@nvidia.com> wrote:
>
> tcp_time_stamp_raw() uses ktime_get_ns(), while bpf_ktime_get_ns() uses
> ktime_get_mono_fast_ns(). Is it fine to use ktime_get_mono_fast_ns()
> instead of ktime_get_ns()? I'm a bit worried about this note in
> Documentation/core-api/timekeeping.rst:
>
>  > most drivers should never call them,
>  > since the time is allowed to jump under certain conditions.

That depends on what happens when the timestamp is "off". Since you're
sending this value over the network I doubt that the two methods will
show a difference.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
