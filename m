Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631723D81EB
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 23:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhG0Vja (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 17:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhG0Vja (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 17:39:30 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153F1C061757
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 14:39:29 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w17so375612ybl.11
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1a7jrJjKAP6bNq/BoxlhtO+06fKv6AWeQXyECAY09V0=;
        b=Hu71cA0PmWo28I6OY8/fQ0xdY+ViL8a6gOwkp6XjXBW/FcU7GHkvPN6NQklXqgGObN
         liowl35iP3EAn/lU5C286wb2tA3YGRMeyyffWpCBQiwHYJXJvKG9Um7jQ1kc6mknTK5L
         +BmpZNTjQHEHqdjCWQhzGtZGnuYFTP0c0KnTuozpIfLqPU1VV+zLkIambPxngAzuVUc1
         GXSDIY+kqtb64ubP9JAm78BO/KtY/72sjApSJT5+W5OE5DmqGnT3uBAu+9zmic9arcza
         yyvyeipu+ddVMhpdoOhxigsA9JrZEJ5fvrXaIG/0uoAX+CNf7GQ1uE48GSetfdRJqCa6
         J+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1a7jrJjKAP6bNq/BoxlhtO+06fKv6AWeQXyECAY09V0=;
        b=t3XfutYCi64KLq2bkSDaY2outBWxs1/rkBWIN6hm8FWQY03eF5uZKQ28YcHUu88CyM
         Xl4G5VkVPgEXwnRKkBxlEOyUDvUvdV0/JS2VSpt1FESN0n2cF+dQKa9DMenWt4kr4FMI
         J+w1BYL1ADg5ZI9U1kbryE30+mSlyAB5bXfmhs5kJhTVLUc+WZRi7zCXQsor7Kbdd6FD
         wV0qTKnVktXr9XZuoP2+cDg60zERFTD6CxEcqAoKcOaVIIPgB57G/uE88jAzimfxrcaS
         rGP+rml4I4xUri5nNl01SGQU7iUDU7u8rh1wJMfwzMHmrkaIzlJp2UHTZ5tceaFKIXS7
         0tEg==
X-Gm-Message-State: AOAM5338fksNkpq9chySEyl/aC763jg93TNLXEIVySRiwNfcCVfH9UoM
        IchvmiR8ky0wCqZWpwrcB1/0BnkhSa51dmDB7Oy4SsBb2WI=
X-Google-Smtp-Source: ABdhPJz5ujRnG6cAuW/nqaj1pFm0Z7c1ntq453J5YLHBqSROCoktroP3/QW6vy21/0yMO095EV9h7L6M1QL9HSGhHGs=
X-Received: by 2002:a25:b741:: with SMTP id e1mr34486928ybm.347.1627421968379;
 Tue, 27 Jul 2021 14:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210726152001.34845-1-m@lambda.lt>
In-Reply-To: <20210726152001.34845-1-m@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Jul 2021 14:39:17 -0700
Message-ID: <CAEf4BzYTDEHL-+fAZcTODh57LSSFeeYQCb3ARq04ZbrPYzLr6Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] libbpf: fix race when pinning maps in parallel
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 26, 2021 at 8:19 AM Martynas Pumputis <m@lambda.lt> wrote:
>
> When loading in parallel multiple programs which use the same to-be
> pinned map, it is possible that two instances of the loader will call
> bpf_object__create_maps() at the same time. If the map doesn't exist
> when both instances call bpf_object__reuse_map(), then one of the
> instances will fail with EEXIST when calling bpf_map__pin().
>
> Fix the race by retrying reusing a map if bpf_map__pin() returns
> EEXIST. The fix is similar to the one in iproute2: e4c4685fd6e4 ("bpf:
> Fix race condition with map pinning").
>
> Before retrying the pinning, we don't do any special cleaning of an
> internal map state. The closer code inspection revealed that it's not
> required:
>
>     - bpf_object__create_map(): map->inner_map is destroyed after a
>       successful call, map->fd is closed if pinning fails.
>     - bpf_object__populate_internal_map(): created map elements is
>       destroyed upon close(map->fd).
>     - init_map_slots(): slots are freed after their initialization.
>
> Cc: Joe Stringer <joe@wand.net.nz>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---

Applied to bpf-next, thanks.

>  tools/lib/bpf/libbpf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>

[...]
