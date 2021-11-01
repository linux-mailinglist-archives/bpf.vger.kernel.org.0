Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067604422B7
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 22:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhKAVft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 17:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhKAVfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 17:35:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93FC061714
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 14:33:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id r5so12774742pls.1
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxAibTQCntzN2SdzEHDJkcvsHbHDOdonvslLWKFcPug=;
        b=Z2jatWqYkBsqJL4ieE78ObcXwrdfuaNmDcjZ4TcPCySCmkDGkcK8OnILpsZ9zpwTDc
         oWvfnxOcaUr62PotGRFAwCixoG7YiJTHt2HS41d2qwqRi8gga7ykgUkvY4UAIV0U42vs
         UMwvJKuHL8ym2IcEua2fT0Hsj7XOEgfe6Xd8U9VGqRCt41U+KivTOgiRVoqoKftxVtqJ
         zEOTb8VKumbjeOMocAz/yDkiRGpgAvp9h3+RlLb6fHWZiWOMQQN7kROpi/+c/CKEj1mx
         1SgFCDIdD9ndcsE+ymtOne3yKWfBLr7mYXzJSCcAESz3L7Wv5T9aNs6xm67VVagqIxmc
         zZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxAibTQCntzN2SdzEHDJkcvsHbHDOdonvslLWKFcPug=;
        b=dUg8L3EgJITHuWkIhurgHjbrDI0u6DWF9BreTYtJX62YFSF+D1Ru0n5WOAC5JDr1CO
         0Q5kWsTiAK+kpLPx6a98uVZp9NTpmFDB9oPtrTFPgjUaa+nEl4dI0ozdRki8h9al097s
         OHmC3GcxUqGFdOeGqLQWvqMrfgPnZEc46q1AETwV8D87F+wJfqFbGv5xAL7EDBG9/bn8
         j+N0FAqi3LK0odhYjBUaQLLhygNhxCEAMUoCx6nsciZBRAg5bewXJzcfAUUS0r6fp6wi
         pV4m2cXWQgLd4pBwFfT6zWpC445Er/x/Avn6+rllErHxjY/NwRSXBgVq3SvIR7hxxtLy
         LCpw==
X-Gm-Message-State: AOAM532rt3VKehmlFLjAojucVWGKLyyHjwBaJQvgvdd7qfgwR5sDFpCJ
        PEcFLv+Bsd4jBBWfPGiivBg+YUKgDEIdnw1SFbY=
X-Google-Smtp-Source: ABdhPJwz48tIfnjFAds8BuR1dS9j8lsvs6AKzkuEVJhg9VMHxB7kNspMowAxsUoByOiKUP9+Lag1UrdoZRg7krIoNUk=
X-Received: by 2002:a17:90b:3148:: with SMTP id ip8mr1687119pjb.62.1635802393054;
 Mon, 01 Nov 2021 14:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <269c70c6c529a09eb6d6b489eb9bf5e5513c943a.1635196496.git.lorenzo@kernel.org>
In-Reply-To: <269c70c6c529a09eb6d6b489eb9bf5e5513c943a.1635196496.git.lorenzo@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Nov 2021 14:33:01 -0700
Message-ID: <CAADnVQLG-T-7mLgVY9naMKGog-Qcf3yoZRvZLJqm55iAPhFEhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: introduce bpf_map_get_xdp_prog utility routine
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 2:18 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Introduce bpf_map_get_xdp_prog to load an eBPF program on
> CPUMAP/DEVMAP entries since both of them share the same code.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/linux/bpf.h |  2 ++
>  kernel/bpf/core.c   | 17 +++++++++++++++++
>  kernel/bpf/cpumap.c | 12 ++++--------
>  kernel/bpf/devmap.c | 16 ++++++----------
>  4 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 26bf8c865103..891936b54b55 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1910,6 +1910,8 @@ static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
>         return bpf_prog_get_type_dev(ufd, type, false);
>  }
>
> +struct bpf_prog *bpf_map_get_xdp_prog(struct bpf_map *map, int fd,
> +                                     enum bpf_attach_type attach_type);
>  void __bpf_free_used_maps(struct bpf_prog_aux *aux,
>                           struct bpf_map **used_maps, u32 len);
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index dee91a2eea7b..7e72c21b6589 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2228,6 +2228,23 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
>         }
>  }
>
> +struct bpf_prog *bpf_map_get_xdp_prog(struct bpf_map *map, int fd,
> +                                     enum bpf_attach_type attach_type)
> +{
> +       struct bpf_prog *prog;
> +
> +       prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_XDP);
> +       if (IS_ERR(prog))
> +               return prog;
> +
> +       if (prog->expected_attach_type != attach_type) {
> +               bpf_prog_put(prog);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return prog;
> +}

It is supposed to be a cleanup... but...

1. it's tweaking __cpu_map_load_bpf_program()
to pass extra 'map' argument further into this helper,
but the 'map' is unused.

2. bpf_map_get_xdp_prog is a confusing name. what 'map' doing in there?

3. it's placed in core.c while it's really cpumap/devmap only.

I suggest leaving the code as-is.
