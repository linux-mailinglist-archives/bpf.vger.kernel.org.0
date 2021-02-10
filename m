Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91995317175
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 21:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhBJUe5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 15:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhBJUez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 15:34:55 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A913CC061756
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 12:34:15 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id p193so3375781yba.4
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqVZp6cLAMM2FLiGeWT/H8e2DxhJVhZhC64BCf0/jCs=;
        b=BMeWxDVFx5Mb1LizSP4grVir5kHr/O2ouawxYSMM0sJL3FntMH9IIGn4yKDsvlguwu
         2q9Kj71CmBshLz814TnO5O+N+73M96i8IP9It3n8OEAL32nZ8GIW0wGeInP6GZJuf9VS
         gl9jgGXP5necTwD1eRZkMzj8oK/GwNlaSiY0mVn9agidjKGWItnPSCB3KKGiDDrGH1B/
         k2bt48qi27xIaSl36/y9/Eh3krfTCDEGw1j6gpOLWZqH0x7cSCpKYLZT10L2PQhFu1IL
         XxHfijaDXxhKyji5qMjRUSm3tS1vLgKMML4dH05Snmbk6uVFIjmUvw+y+VlPp42fsuOX
         kKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqVZp6cLAMM2FLiGeWT/H8e2DxhJVhZhC64BCf0/jCs=;
        b=bnfVdBU2FTvTB8nwRPxRCeFheFdgZ6UQG8AQNAD1k3dUT0Qf2yxPGbln5DQ2fWhoBB
         JbmGuggvYKkg3DEZJq7q2y+Ze3HO+8PGX/a6hzyhmH529g3f560oHDMiHINRHjxRT0D0
         QH0Hx+Yf0yUwkR0tR5z73kPA+qKjRHkfw930YZvNeF8DxYtn+mFTRpQDHk9g9/qP9j33
         Do1aIy020GhfG0Qfg0o9Fz5p72AZhhxfQA2gw0qx1852qj9BsYAp3UwsL6obQI50X7YU
         YuxE59uuQ55GxoxY/L+oGwQL8nCT2829tiLdS6l/S+agTOMHdbnbEaXstseEn4ZsvtaV
         z4sQ==
X-Gm-Message-State: AOAM531o4uJpKPdy8E9K5B+pAKbJn29pHwP3diVtvUzrKtkx91momdpW
        ZQ0AgJk+ieadh7YitoJ4LDwBcnj77P3lpN1HmYU=
X-Google-Smtp-Source: ABdhPJz8xGeHw3RXdSSXwK+r6w0gRFbqgymQtXVELw7FDSGj1ysp8hhHbGlKHjUGPEI1K3r3Du4itF2EPKwHzXOw1qE=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr6488988yba.403.1612989255037;
 Wed, 10 Feb 2021 12:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20210209064421.15222-1-me@ubique.spb.ru> <20210209064421.15222-2-me@ubique.spb.ru>
In-Reply-To: <20210209064421.15222-2-me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 12:34:04 -0800
Message-ID: <CAEf4BzaGM6+ketAOVAeRV9o7z6vUGsNH-5D9cQK71sJ4PqmHYA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Rename bpf_reg_state variables
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 10:44 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> Using "reg" for an array of bpf_reg_state and "reg[i + 1]" for an
> individual bpf_reg_state is error-prone and verbose. Use "regs" for the
> former and "reg" for the latter as other code nearby does.
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/btf.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>

[...]
