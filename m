Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B833BF245
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 00:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhGGXBX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 19:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGGXBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 19:01:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C2C061574
        for <bpf@vger.kernel.org>; Wed,  7 Jul 2021 15:58:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id k184so5750566ybf.12
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIFIlaUFD9pMdhZ2d2SOgEd6wmzZV+dSkW7NSK/9dko=;
        b=aPwwqZ8dhnoOEosAT7nRZdVnJZMGi3N2lZ47uJZ6wpOPKUC1hl1wOZzkUqXPiNtOtU
         Y2Pj8RFPzuEswxYks9DPp86vFxAwURXHZLvjK16dN+VkmuKqOHfuFl9zt4aaUBfbec68
         CqHRlCce0e2wMNjsvHG+DMj79tfXJLXuTDKLnF9G0lpzY0cVt8Y3W51uGFyKOFSheoHr
         XFjutIhkAW2abFMwzTtZdWZVIZ+UlKgAwxcI3W52I+bVgNpoUu33XNNzkqt4uI/gFSXB
         iukkUfT4t+G8Xpg/AvhQvr+eNd5mI2Ugu+tZcf+GMubPnD+teWR1af3NVGTq9rMsST3q
         42RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIFIlaUFD9pMdhZ2d2SOgEd6wmzZV+dSkW7NSK/9dko=;
        b=hhYL1ouIQ6m5YFc4QEMYZ5Sp/RIPqCKiccXeE55FJ/mkX3Ni+peDgVFADnI9Z5VG1G
         y/ymhtSdQRvZnQAfc70fMcYacRN2d55sqj+PwwAnv4MMSYElFMpZ0JeJeTba1B2rv3N5
         yQ5VCBNW8e+yOJnpXDjAF1X1Tbn7RXio8kvLQFcwtzMltN8SjTyH2ngbPKrKmQVtOk+n
         rD0PRbi2JoGEJSzqQXZt9w72ajgZt3GhaC1ucwBoGeMjApfR2w6BqQdkh+jgwJiQn7aD
         /6RqtXyZUCozE01VaHEDFix+sqKPFZ8pWUAoNgOf3uKexZmPQHEddSaaU0hIcuekNOAT
         IBIw==
X-Gm-Message-State: AOAM532Qq9sT6CMWIJVp6Hd5TuMNWYaBEYx4SAuQHlzRAGzWxd9F4yzr
        pcb16/Ic72uMBkFmogGVglktf1sGmXLqqi7NSHQ=
X-Google-Smtp-Source: ABdhPJxJWpEI8lQfUlK7vfg2iBpRZ6GkDAgLgV/Om7OG7EdLeaOr85v1g8CvYCMgQEYn56ohN7eB/9NqU8GbOgdlIGo=
X-Received: by 2002:a25:b741:: with SMTP id e1mr36422818ybm.347.1625698720218;
 Wed, 07 Jul 2021 15:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210706172619.579001-1-m@lambda.lt>
In-Reply-To: <20210706172619.579001-1-m@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Jul 2021 15:58:29 -0700
Message-ID: <CAEf4BzbCAO=hjA=hSh9QXN3C79xOmM0=Cc0H1gZnhm6LdDz9Sw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix reuse of pinned map on older kernel
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 6, 2021 at 10:24 AM Martynas Pumputis <m@lambda.lt> wrote:
>
> When loading a BPF program with a pinned map, the loader checks whether
> the pinned map can be reused, i.e. their properties match. To derive
> such of the pinned map, the loader invokes BPF_OBJ_GET_INFO_BY_FD and
> then does the comparison.
>
> Unfortunately, on < 4.12 kernels the BPF_OBJ_GET_INFO_BY_FD is not
> available, so loading the program fails with the following error:
>
>         libbpf: failed to get map info for map FD 5: Invalid argument
>         libbpf: couldn't reuse pinned map at
>                 '/sys/fs/bpf/tc/globals/cilium_call_policy': parameter
>                 mismatch"
>         libbpf: map 'cilium_call_policy': error reusing pinned map
>         libbpf: map 'cilium_call_policy': failed to create:
>                 Invalid argument(-22)
>         libbpf: failed to load object 'bpf_overlay.o'
>
> To fix this, probe the kernel for BPF_OBJ_GET_INFO_BY_FD support. If it
> doesn't support, then fallback to derivation of the map properties via
> /proc/$PID/fdinfo/$MAP_FD.
>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  tools/lib/bpf/libbpf.c | 103 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 92 insertions(+), 11 deletions(-)
>

[...]

> @@ -4406,10 +4478,19 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>
>         map_info_len = sizeof(map_info);
>
> -       if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
> -               pr_warn("failed to get map info for map FD %d: %s\n",
> -                       map_fd, libbpf_strerror_r(errno, msg, sizeof(msg)));
> -               return false;
> +       if (kernel_supports(obj, FEAT_OBJ_GET_INFO_BY_FD)) {

why not just try bpf_obj_get_info_by_fd() first, and if it fails
always fallback to bpf_get_map_info_from_fdinfo(). No need to do
feature detection. This will cut down on the amount of code without
any regression in behavior. More so, it will actually now be
consistent and good behavior in case of bpf_map__reuse_fd() where we
don't have obj. WDYT?


> +               if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
> +                       pr_warn("failed to get map info for map FD %d: %s\n",
> +                               map_fd,
> +                               libbpf_strerror_r(errno, msg, sizeof(msg)));
> +                       return false;
> +               }

[...]
