Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC56D861D
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 20:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDESft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjDESfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 14:35:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB9295
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 11:35:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eg48so143282826edb.13
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 11:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680719745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj1vkMw9ZTYtNBWV1ZDSs/vmrI3+L+GYF5nZK9fjFc4=;
        b=dT3dsIJ9Gwf4NpsB+A1UfDe4hGYKFH3XrklsdXFReH7u78LegiMuKCEbZWTzSpqT0V
         2TjskH3KoJl3Oa/a+2k2dBEkj8UEE4n8s8xhesSe0H44zfapDzAlJfUUlPxB+Ccb9Bup
         NANXpVXxtAVBRYs3aqeldr/1EDka2q3WE2z0BDhu1KeuRk6N63MXj/+NP3yKdbqvVu3t
         fzE+6BN8eK+dxaK4UaB0rlizNtNCRcAWfPsQSy8XKX0ucr56B6muvmu3Kep6Mq9W2H9l
         ZAJyRsViPGZn3YO8IQHYl71oyuNYAlsEIYceVPR5E5B6kn5zpm/CkkBFdV4WRrhMzPdB
         MLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680719745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj1vkMw9ZTYtNBWV1ZDSs/vmrI3+L+GYF5nZK9fjFc4=;
        b=N/eHfuffpbZdVlqtFXnIVkfKLrpzUPKQMJdVq89O7EnODCxDesDJbi7WUhmaZQvCt0
         BdIoC7zRbzX/lWsOC8oTPaysc8sM8g0RpPxcJ6DkFpu5TKQm5FJ8FNaL9b0RiKSS+3pD
         809hY/Kti+p9/LKN/n/7RXt6Lfx/kuaU1z7Gdt3u8/O+pAfI6ocN+qBJOMgDgRrtBuWl
         YYE9SPBXKlf4GrONR4V9GTmZLNXYDSfDvhrSPPt5dQXurLG7w4h8wmfZHTzXDQSC1NoO
         2YtP6r5x5O4tsdkJGvR+9ecnCJNDjInHChl3AaKswcbbUkqsnx59Hy7aGD6wJCQgtBUL
         HpOQ==
X-Gm-Message-State: AAQBX9dZsm1p42JF2vDB17bh69VAfqVxYq88O9VjhW4wYCE+XvGijHGC
        I4gFOn3Ag+XRfEZBkFFlgAzKxKLXxZOj1oym6PI=
X-Google-Smtp-Source: AKy350b3Fm07NNt1hgUxFR9++D3Way34//JXsfgy3JgqC+0qx8FdtGRP69IQHC34H6GLF+vx78Tya8JB8JxvWRqsGlE=
X-Received: by 2002:a17:906:7d9:b0:92f:b329:cb75 with SMTP id
 m25-20020a17090607d900b0092fb329cb75mr2089391ejc.5.1680719745173; Wed, 05 Apr
 2023 11:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <CAN+4W8hptrrVjQ+-=otz_FPb2uL4E4bgzNRzp3pOh4=hWgeA+A@mail.gmail.com>
In-Reply-To: <CAN+4W8hptrrVjQ+-=otz_FPb2uL4E4bgzNRzp3pOh4=hWgeA+A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Apr 2023 11:35:33 -0700
Message-ID: <CAEf4BzYRc+ppyvbYy39FLPLGL41kPSV8xVSbJ_4Mha_shRCNHw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/19] BPF verifier rotating log
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 10:28=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > This turned into a pretty sizable patch set with lots of arithmetics, b=
ut
> > hopefully the set of features added to verifier log in this patch set a=
re both
> > useful for BPF users and are self-contained and isolated enough to not =
cause
> > troubles going forward.
>
> Hi Andrii,
>
> Thanks for pushing this forward, this will make all of the log
> handling so much nicer. Sorry it took a while to review, but it's
> quite a chunky series as you point out yourself :) Maybe it makes
> sense to pull out some of the acked bits (moving code around, etc.)
> into a separate patch set?
>
> I'll send out individual reviews shortly, but wanted to put my my main
> proposal here. It's only compile tested, but it's hopefully clearer
> than my words. Note that I didn't fix up whitespace to make the diff
> smaller. It should apply on top of your branch.
>
> From 162afa86d109954a4951d052513580849bd5cc54 Mon Sep 17 00:00:00 2001
> From: Lorenz Bauer <lmb@isovalent.com>
> Date: Wed, 5 Apr 2023 18:24:42 +0100
> Subject: [PATCH] bpf: simplify log nul termination and FIXED mode
>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>  kernel/bpf/log.c | 105 ++++++++++++++++++++++-------------------------
>  1 file changed, 50 insertions(+), 55 deletions(-)

Thanks for the code, I do understand your idea much better now.
Basically, you are saying to tread FIXED as a partial case of rotating
by adjusting N to never go beyond the end of the buffer. While I do
find explicit FIXED code path in bpf_verifier_log() a bit easier to
reason about, I can see this as a conceptual simplification, yep. The
finalization/zero termination is still special-cased for fixed vs
rotating.

I still fail to see how zero termination every single time is
complicating everything, and even with your implementation we can
support this easily with no more code (just kbuf[n - 1] =3D 0; before we
delegate to bpf_vlog_emit()).

So all in all, looking at stats, I don't really see a big
simplification. On the other hand, I spent a considerable time
thinking, debugging, and testing my existing implementation
thoroughly. Then there is also interaction with log_buf=3D=3DNULL &&
log_size=3D=3D0 case, I'd need to re-analyze everything again.

How strong do you feel the need for me to redo this tricky part to
save a few lines of C code (and lose easy debuggability at least of
kbuf contents)? I'm a bit on the fence. I noted a few things I would
add (or remove) even to existing code and I'll apply that. But unless
someone comes out and says "let's do it this way", I'd rather not
waste half a day on debugging some random off-by-one error again.

>
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index ab8149448724..b6b59047a594 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -54,45 +54,13 @@ static void bpf_vlog_update_len_max(struct
> bpf_verifier_log *log, u32 add_len)
>          log->len_max =3D len;
>  }
>
> -void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
> -               va_list args)
> +static void bpf_vlog_emit(struct bpf_verifier_log *log, const char
> *kbuf, u32 n)
>  {
>      u64 cur_pos;
> -    u32 new_n, n;
> -
> -    n =3D vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
> -
> -    WARN_ONCE(n >=3D BPF_VERIFIER_TMP_LOG_SIZE - 1,
> -          "verifier log line truncated - local buffer too short\n");
> -
> -    if (log->level =3D=3D BPF_LOG_KERNEL) {
> -        bool newline =3D n > 0 && log->kbuf[n - 1] =3D=3D '\n';
> -
> -        pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
> -        return;
> -    }
> -
> -    n +=3D 1; /* include terminating zero */
> -    bpf_vlog_update_len_max(log, n);
> -
> -    if (log->level & BPF_LOG_FIXED) {
> -        /* check if we have at least something to put into user buf */
> -        new_n =3D 0;
> -        if (log->end_pos + 1 < log->len_total) {
> -            new_n =3D min_t(u32, log->len_total - log->end_pos, n);
> -            log->kbuf[new_n - 1] =3D '\0';

without this part I can't debug what kernel is actually emitting into
user-space with a simple printk()...

> -        }
> -        cur_pos =3D log->end_pos;
> -        log->end_pos +=3D n - 1; /* don't count terminating '\0' */
> -
> -        if (log->ubuf && new_n &&
> -            copy_to_user(log->ubuf + cur_pos, log->kbuf, new_n))
> -            goto fail;
> -    } else {
>          u64 new_end, new_start;
>          u32 buf_start, buf_end, new_n;
>
> -        log->kbuf[n - 1] =3D '\0';

realized we don't really need this zero-termination for rotating case,
will drop it

> +    bpf_vlog_update_len_max(log, n);
>
>          new_end =3D log->end_pos + n;
>          if (new_end - log->start_pos >=3D log->len_total)
> @@ -101,7 +69,7 @@ void bpf_verifier_vlog(struct bpf_verifier_log
> *log, const char *fmt,
>              new_start =3D log->start_pos;
>
>          log->start_pos =3D new_start;
> -        log->end_pos =3D new_end - 1; /* don't count terminating '\0' */
> +        log->end_pos =3D new_end;
>
>          if (!log->ubuf)
>              return;
> @@ -126,35 +94,60 @@ void bpf_verifier_vlog(struct bpf_verifier_log
> *log, const char *fmt,
>          if (buf_start < buf_end) {
>              /* message fits within contiguous chunk of ubuf */
>              if (copy_to_user(log->ubuf + buf_start,
> -                     log->kbuf + n - new_n,
> +                     kbuf + n - new_n,
>                       buf_end - buf_start))
>                  goto fail;
>          } else {
>              /* message wraps around the end of ubuf, copy in two chunks =
*/
>              if (copy_to_user(log->ubuf + buf_start,
> -                     log->kbuf + n - new_n,
> +                     kbuf + n - new_n,
>                       log->len_total - buf_start))
>                  goto fail;
>              if (copy_to_user(log->ubuf,
> -                     log->kbuf + n - buf_end,
> +                     kbuf + n - buf_end,
>                       buf_end))
>                  goto fail;
>          }
> -    }
> -
>      return;
>  fail:
>      log->ubuf =3D NULL;
>  }
>
> -void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
> +static u32 bpf_vlog_available(const struct bpf_verifier_log *log)
>  {
> -    char zero =3D 0;
> -    u32 pos;
> +    return log->len_total - (log->end_pos - log->start_pos);
> +}
> +
> +void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
> +               va_list args)
> +{
> +    /* NB: contrary to vsnprintf n can't be larger than sizeof(log->kbuf=
) */

it can't be even equal to sizeof(log->kbuf)

> +    u32 n =3D vscnprintf(log->kbuf, sizeof(log->kbuf), fmt, args);
> +
> +    if (log->level =3D=3D BPF_LOG_KERNEL) {
> +        bool newline =3D n > 0 && log->kbuf[n - 1] =3D=3D '\n';
> +
> +        pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
> +        return;
> +    }
>
> +    if (log->level & BPF_LOG_FIXED) {
> +        bpf_vlog_update_len_max(log, n);

this made me pause for a second to prove we are not double-accounting
something. We don't, but I find the argument of a simplification a bit
weaker due to this :)

> +        /* avoid rotation by never emitting more than what's unused */
> +        n =3D min_t(u32, n, bpf_vlog_available(log));
> +    }
> +
> +    bpf_vlog_emit(log, log->kbuf, n);
> +}
> +
> +void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
> +{
>      if (!bpf_verifier_log_needed(log) || log->level =3D=3D BPF_LOG_KERNE=
L)
>          return;
>
> +    if (WARN_ON_ONCE(new_pos > log->end_pos))
> +        return;

will add this warn, good point

> +
>      /* if position to which we reset is beyond current log window,
>       * then we didn't preserve any useful content and should adjust
>       * start_pos to end up with an empty log (start_pos =3D=3D end_pos)
> @@ -162,17 +155,6 @@ void bpf_vlog_reset(struct bpf_verifier_log *log,
> u64 new_pos)
>      log->end_pos =3D new_pos;
>      if (log->end_pos < log->start_pos)
>          log->start_pos =3D log->end_pos;
> -
> -    if (!log->ubuf)
> -        return;
> -
> -    if (log->level & BPF_LOG_FIXED)
> -        pos =3D log->end_pos + 1;
> -    else
> -        div_u64_rem(new_pos, log->len_total, &pos);
> -
> -    if (pos < log->len_total && put_user(zero, log->ubuf + pos))
> -        log->ubuf =3D NULL;

equivalent to what you do in vlog_finalize, right?

>  }
>
>  static void bpf_vlog_reverse_kbuf(char *buf, int len)
> @@ -228,6 +210,7 @@ static bool bpf_vlog_truncated(const struct
> bpf_verifier_log *log)
>
>  int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual=
)
>  {
> +    char zero =3D 0;
>      u32 sublen;
>      int err;
>
> @@ -237,8 +220,20 @@ int bpf_vlog_finalize(struct bpf_verifier_log
> *log, u32 *log_size_actual)
>
>      if (!log->ubuf)
>          goto skip_log_rotate;
> +
> +    if (log->level & BPF_LOG_FIXED) {
> +        bpf_vlog_update_len_max(log, 1);
> +
> +        /* terminate by (potentially) overwriting the last byte */
> +        if (put_user(zero, log->ubuf + min_t(u32, log->end_pos,
> log->len_total-1))
> +            return -EFAULT;
> +    } else {
> +        /* terminate by (potentially) rotating out the first byte */
> +        bpf_vlog_emit(log, &zero, 1);
> +    }

not a big fan of this part where we still do two separate handlings
for two modes

> +
>      /* If we never truncated log, there is nothing to move around. */
> -    if ((log->level & BPF_LOG_FIXED) || log->start_pos =3D=3D 0)
> +    if (log->start_pos =3D=3D 0)

yep, BPF_LOG_FIXED implied start_pos =3D=3D 0, unnecessary check

>          goto skip_log_rotate;
>
>      /* Otherwise we need to rotate log contents to make it start from th=
e
> --
> 2.39.2
