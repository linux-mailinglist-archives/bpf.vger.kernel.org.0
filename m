Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1F6D84F2
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjDER3f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDER3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:29:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF459FF
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:29:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-4fa3cc29988so655689a12.3
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680715759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8vlfYD4oZl9ouCECbV2vHAjc79Gj1ci3+5Jwg1DSsk=;
        b=PMOUqNHyBIHbEBHSQZPHgFOx1ACmgr4FmfHm6nM19lYHz4+ld4ZnXvqXmTp6Dr8V7S
         n/qBajS+6Ahrtv5OBPu51MX+R55TJwjyOi2G4alXPtrLyaxUygvxytGsvyU65Ffta63i
         9d8NoJYLfvgX5kGrsI836tF30SspqC6DlOMGCkr22fVUml6hTIR/Xb4BeHFAFL+GNC+r
         Jd1/KmTK81dKDqp3YQuYTGLrQzHVmXUOME0s5DM6TayL2QiTWKLNY62pYgHOIGV2Vh4j
         jK2PRFSpwJ+dEh/1h44GXmeuht4PKGQJZmK7TmYcV6Te2bFrQ5IaMabywdanbZyMwaEu
         MNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8vlfYD4oZl9ouCECbV2vHAjc79Gj1ci3+5Jwg1DSsk=;
        b=s/r54hTU0NQDkp3LNZQ0UuHWQQHPqkRE1a+H2sWvxmx+0Ni9IyygWAvsIq6Ogz0V3D
         L21LE9sgwXK5a/ElCt3qQT2o53W9aYLNkiJqtcJKNPtDl+Wwp8kQdiPg9yKSJne229Ah
         aGt7ASvkH8NZ3hBDbnnG+7HzyCnSY+YpqcNTU0SQFCen8uilWosP84GMseNyNg4Hn+Qh
         eMMRBHnAV49/W0t+y2dW4bSjju/thz+I+MUW4tkiOGwfb6874VYkndyKRIBlGpYHf+W6
         CXTk8w82LrTIRXMqf6rN6V4reDzWHHZgZJtXlNyECasPF1fUqno4tDl+kMxk6fBx5lSH
         TqQQ==
X-Gm-Message-State: AAQBX9dXS+NKVJGauG4AGLNVoSGSnPSHQJa1hY0KorJChQ+IYbmxCu3P
        1jUWWWAk2VuHVx8ud6vCsEuSZbbRPVjUKvT25rC7Yg==
X-Google-Smtp-Source: AKy350bBEd6FfOHaDDvI6DISBgesA6br7Bif5fu50WmsV314gHNzhjJudMKWYG45aYsGcIIvRgURriAGOFUs0je2p1A=
X-Received: by 2002:a50:8a91:0:b0:4fc:a484:c6ed with SMTP id
 j17-20020a508a91000000b004fca484c6edmr1607848edj.2.1680715759314; Wed, 05 Apr
 2023 10:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-12-andrii@kernel.org>
In-Reply-To: <20230404043659.2282536-12-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 5 Apr 2023 18:29:08 +0100
Message-ID: <CAN+4W8hoD9FWRz2kAkyX5HEkRcddQh0HuFBYotDWwgvDnVKA9A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 11/19] bpf: keep track of total log content
 size in both fixed and rolling modes
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> With these changes, it's now possible to do this sort of determination of
> log contents size in both BPF_LOG_FIXED and default rolling log mode.
> We need to keep in mind bpf_vlog_reset(), though, which shrinks log
> contents after successful verification of a particular code path. This
> log reset means that log->end_pos isn't always increasing, so to return
> back to users what should be the log buffer size to fit all log content
> without causing -ENOSPC even in the presenec of log resetting, we need

Just for you :) Nit: presence

> to keep maximum over "lifetime" of logging. We do this accounting in
> bpf_vlog_update_len_max() helper.

Ah, this is interesting! The way I conceived of this working is that
the kernel gives me the buffer size required to avoid truncation at
the final copy out _given the same flags_. From a user space POV I
don't care about the intermediate log that was truncated away, since I
in a way asked the kernel to not give me this information. Can we drop
the len_max logic and simply use end_pos?

> Another issue to keep in mind is that we limit log buffer size to 32-bit
> value and keep such log length as u32, but theoretically verifier could
> produce huge log stretching beyond 4GB. Instead of keeping (and later
> returning) 64-bit log length, we cap it at UINT_MAX. Current UAPI makes
> it impossible to specify log buffer size bigger than 4GB anyways, so we
> don't really loose anything here and keep everything consistently 32-bit
> in UAPI. This property will be utilized in next patch.
> These changes do incidentally fix one small issue with previous logging
> logic. Previously, if use provided log buffer of size N, and actual log
> output was exactly N-1 bytes + terminating \0, kernel logic coun't
> distinguish this condition from log truncation scenario which would end
> up with truncated log contents of N-1 bytes + terminating \0 as well.
>
> But now with log->end_pos being logical position that could go beyond
> actual log buffer size, we can distinguish these two conditions, which
> we do in this patch. This plays nicely with returning log_size_actual
> (implemented in UAPI in the next patch), as we can now guarantee that if
> user takes such log_size_actual and provides log buffer of that exact
> size, they will not get -ENOSPC in return.
>
> All in all, all these changes do conceptually unify fixed and rolling
> log modes much better, and allow a nice feature requested by users:
> knowing what should be the size of the buffer to avoid -ENOSPC.
>
> We'll plumb this through the UAPI and the code in the next patch.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_verifier.h | 12 ++-----
>  kernel/bpf/log.c             | 68 +++++++++++++++++++++++++-----------
>  2 files changed, 50 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4c926227f612..98d2eb382dbb 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -504,6 +504,7 @@ struct bpf_verifier_log {
>         char __user *ubuf;
>         u32 level;
>         u32 len_total;
> +       u32 len_max;
>         char kbuf[BPF_VERIFIER_TMP_LOG_SIZE];
>  };
>
> @@ -517,23 +518,16 @@ struct bpf_verifier_log {
>  #define BPF_LOG_MIN_ALIGNMENT 8U
>  #define BPF_LOG_ALIGNMENT 40U
>
> -static inline u32 bpf_log_used(const struct bpf_verifier_log *log)
> -{
> -       return log->end_pos - log->start_pos;
> -}
> -
>  static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *=
log)
>  {
>         if (log->level & BPF_LOG_FIXED)
> -               return bpf_log_used(log) >=3D log->len_total - 1;
> +               return log->end_pos >=3D log->len_total;
>         return false;
>  }
>
>  static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log=
 *log)
>  {
> -       return log &&
> -               ((log->level && log->ubuf && !bpf_verifier_log_full(log))=
 ||
> -                log->level =3D=3D BPF_LOG_KERNEL);
> +       return log && log->level;
>  }
>
>  #define BPF_MAX_SUBPROGS 256
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 14dc4d90adbe..acfe8f5d340a 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -16,10 +16,26 @@ bool bpf_verifier_log_attr_valid(const struct bpf_ver=
ifier_log *log)
>                log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK);
>  }
>
> +static void bpf_vlog_update_len_max(struct bpf_verifier_log *log, u32 ad=
d_len)
> +{
> +       /* add_len includes terminal \0, so no need for +1. */
> +       u64 len =3D log->end_pos + add_len;
> +
> +       /* log->len_max could be larger than our current len due to
> +        * bpf_vlog_reset() calls, so we maintain the max of any length a=
t any
> +        * previous point
> +        */
> +       if (len > UINT_MAX)
> +               log->len_max =3D UINT_MAX;
> +       else if (len > log->len_max)
> +               log->len_max =3D len;
> +}
> +
>  void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
>                        va_list args)
>  {
> -       unsigned int n;
> +       u64 cur_pos;
> +       u32 new_n, n;
>
>         n =3D vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args)=
;
>
> @@ -33,21 +49,28 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, =
const char *fmt,
>                 return;
>         }
>
> +       n +=3D 1; /* include terminating zero */

So above we WARN_ONCE if n >=3D BPF_VERIFIER_TMP_LOG_SIZE - 1, but here
we add 1 anyways. Doesn't that mean we may read 1 byte past the end of
kbuf?


>         if (log->level & BPF_LOG_FIXED) {
> -               n =3D min(log->len_total - bpf_log_used(log) - 1, n);
> -               log->kbuf[n] =3D '\0';
> -               n +=3D 1;
> -
> -               if (copy_to_user(log->ubuf + log->end_pos, log->kbuf, n))
> -                       goto fail;
> +               /* check if we have at least something to put into user b=
uf */
> +               new_n =3D 0;
> +               if (log->end_pos < log->len_total - 1) {
> +                       new_n =3D min_t(u32, log->len_total - log->end_po=
s, n);
> +                       log->kbuf[new_n - 1] =3D '\0';
> +               }
>
> +               bpf_vlog_update_len_max(log, n);
> +               cur_pos =3D log->end_pos;
>                 log->end_pos +=3D n - 1; /* don't count terminating '\0' =
*/
> +
> +               if (log->ubuf && new_n &&
> +                   copy_to_user(log->ubuf + cur_pos, log->kbuf, new_n))
> +                       goto fail;
>         } else {
> -               u64 new_end, new_start, cur_pos;
> +               u64 new_end, new_start;
>                 u32 buf_start, buf_end, new_n;
>
> -               log->kbuf[n] =3D '\0';
> -               n +=3D 1;
> +               log->kbuf[n - 1] =3D '\0';
> +               bpf_vlog_update_len_max(log, n);
>
>                 new_end =3D log->end_pos + n;
>                 if (new_end - log->start_pos >=3D log->len_total)
> @@ -66,6 +89,12 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, c=
onst char *fmt,
>                 if (buf_end =3D=3D 0)
>                         buf_end =3D log->len_total;
>
> +               log->start_pos =3D new_start;
> +               log->end_pos =3D new_end - 1; /* don't count terminating =
'\0' */
> +
> +               if (!log->ubuf)
> +                       return;
> +
>                 /* if buf_start > buf_end, we wrapped around;
>                  * if buf_start =3D=3D buf_end, then we fill ubuf complet=
ely; we
>                  * can't have buf_start =3D=3D buf_end to mean that there=
 is
> @@ -89,9 +118,6 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, c=
onst char *fmt,
>                                          buf_end))
>                                 goto fail;
>                 }
> -
> -               log->start_pos =3D new_start;
> -               log->end_pos =3D new_end - 1; /* don't count terminating =
'\0' */
>         }
>
>         return;
> @@ -114,8 +140,13 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u6=
4 new_pos)
>         log->end_pos =3D new_pos;
>         if (log->end_pos < log->start_pos)
>                 log->start_pos =3D log->end_pos;
> -       div_u64_rem(new_pos, log->len_total, &pos);
> -       if (put_user(zero, log->ubuf + pos))
> +
> +       if (log->level & BPF_LOG_FIXED)
> +               pos =3D log->end_pos + 1;
> +       else
> +               div_u64_rem(new_pos, log->len_total, &pos);
> +
> +       if (log->ubuf && pos < log->len_total && put_user(zero, log->ubuf=
 + pos))
>                 log->ubuf =3D NULL;
>  }
>
> @@ -167,12 +198,7 @@ static int bpf_vlog_reverse_ubuf(struct bpf_verifier=
_log *log, int start, int en
>
>  bool bpf_vlog_truncated(const struct bpf_verifier_log *log)
>  {
> -       if (!log->level)
> -               return false;
> -       else if (log->level & BPF_LOG_FIXED)
> -               return bpf_log_used(log) >=3D log->len_total - 1;
> -       else
> -               return log->start_pos > 0;
> +       return log->len_max > log->len_total;
>  }
>
>  void bpf_vlog_finalize(struct bpf_verifier_log *log)
> --
> 2.34.1
>
