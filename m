Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791F62DC935
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 23:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgLPWru (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 17:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgLPWrt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 17:47:49 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93792C061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 14:47:09 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id u203so24011616ybb.2
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 14:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QAq1Cyz5FbkyrRqT65pmBimBepYkTyBr8tBoHKyN4/A=;
        b=nkaKPfwy1MezD1ak01Dt65aurlO12pFpRD/kUR/8OkyW0Y1WfAgrj1c2+nKQVrzK22
         DG4V7F277l6VJHt1TZyoyN1y0vAk3jB+fJJuNrXYCd+erMBTlY+7l7JwkRymdTj7Ki1Y
         ze37d7TAvULwnZ9TGeaT60OYtcVq+Itd+4D0tm0K+mL8BfGKqjQ4MJyjYa1dcXL8n2cz
         fRIy2HduFyfxDm4DzLwNOTker8rfeu4zwPr6FSs7g/cuuzYV78Ey8mgHKrEIejKvqR5r
         3EeIZA9xM8rvHUzyCVa7SoctZAdLgSXO5kOdy+U6vNQgyFITxE0+iQJzzBTvwiTSsLPg
         0yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QAq1Cyz5FbkyrRqT65pmBimBepYkTyBr8tBoHKyN4/A=;
        b=tmIy5jzh5Th8TSAgw9DZqCIwKtsSbfPeGJXHEBLQX42vSadkoxpv3lewDxNl1q00AA
         Gp34KyhzCIox/23k3RsqAW/HA78hy59s7MbwQUlNkUkp6fenQNeulKc5RqTdiapxSgVM
         xBoKXkoiR6oL7bWewUu6pVX2avAVEX92gJQ7tUUPq9xfeC6EGUuB40fhHlFYOtv0Vxdl
         wE5KqZ6Knh69PgIZqaQnDW74dGgwflELCMG5cs21Uy1hKD5/iBdOB0I0V4N2QW+n044t
         2CGULEZbQOT3+u2J71xK/j4p2e9r6iZvHmuXq4X279dn/jXLINimntvcZ4dr1EZlY5qe
         rhcw==
X-Gm-Message-State: AOAM533AP7EkITvX8CFrR8O3+vDzD+/5HA0Bu9gOXeECSgSpews8ktwO
        ggOAbBLtTtJdt1zNS6QPOJ23xblR382r9HP1awM=
X-Google-Smtp-Source: ABdhPJxDl1u7ISaIioRhgRcRW3gknMx1yL+aAutNpB8guTddJlWu2Av/L4/cm/DWTL2cYoTSld2KrR1CINcS45vA9AU=
X-Received: by 2002:a25:d44:: with SMTP id 65mr53428928ybn.260.1608158828900;
 Wed, 16 Dec 2020 14:47:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607973529.git.me@ubique.spb.ru> <0ff8927166f6e18e72adab8a94cb6d694c610cc0.1607973529.git.me@ubique.spb.ru>
In-Reply-To: <0ff8927166f6e18e72adab8a94cb6d694c610cc0.1607973529.git.me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Dec 2020 14:46:58 -0800
Message-ID: <CAEf4BzZZoD8C3u97KMoJ4iOzkx3TNVT9E36hpQri0sMWTZVqUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Factor out nullable reg type conversion
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

On Mon, Dec 14, 2020 at 11:53 AM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> Factor out helper function for conversion nullable register type to its
> corresponding type with value.
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---
>  kernel/bpf/verifier.c | 77 ++++++++++++++++++++++++-------------------
>  1 file changed, 44 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 93def76cf32b..dee296dbc7a1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1073,6 +1073,43 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
>         __mark_reg_known_zero(regs + regno);
>  }

[...]

> -               if (is_null) {
>                         /* We don't need id and ref_obj_id from this point
>                          * onwards anymore, thus we should better reset it,
>                          * so that state pruning has chances to take effect.
>                          */
>                         reg->id = 0;
>                         reg->ref_obj_id = 0;

nit: I'd just return here and reduce further nesting of the else branch.

> -               } else if (!reg_may_point_to_spin_lock(reg)) {
> -                       /* For not-NULL ptr, reg->ref_obj_id will be reset
> +               } else {
> +                       mark_ptr_not_null_reg(reg);

Now that this can return -EINVAL, I think some WARN or error message is due.

> +
> +                       if (!reg_may_point_to_spin_lock(reg)) {
> +                               /* For not-NULL ptr, reg->ref_obj_id will be reset
>                          * in release_reg_references().
>                          *
>                          * reg->id is still used by spin_lock ptr. Other
>                          * than spin_lock ptr type, reg->id can be reset.
>                          */
> -                       reg->id = 0;
> +                               reg->id = 0;
> +                       }
>                 }
>         }
>  }
> --
> 2.25.1
>
