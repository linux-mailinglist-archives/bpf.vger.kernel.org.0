Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223B76D0C6A
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 19:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjC3RNG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 13:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjC3RNG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 13:13:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C56FB
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:12:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so79453232eda.0
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680196375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8ckCG2MXCCllOuvEfRAbs4aAKepLUTTxuTYC3VTCyY=;
        b=SC9A9GLBUI0BSpiAK085wg0e6YCaFFntEYGCA5QkFod+p3mu8lROgwOfq01Tdxq7Xq
         6MMsBsG/piAd64xW2SI04HP+4YkQr4Kewb1yNX5TET9ldwfs7+ZoTCCnENqAWm35OXzO
         MsxS4drMHGdqRprJhedDlIXAydXVPmXZ/AxfpKOYANqiNIhi6BBWFBt1FdprZ9bIOa+V
         wfFeqXrZfEha12AWv/joIN9mY2k5VDtbEDf3lQxPt35kkeflU7UgbtLKc2YmlqXaNX57
         5TwcFmDM+qSOV2DbZ5946u9+l5QLVlEHsw4Vrq8LjeGCDi1z1VAeH4ugbiYkMBt5PpSA
         RohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8ckCG2MXCCllOuvEfRAbs4aAKepLUTTxuTYC3VTCyY=;
        b=GMu4kzQIw6kvdw4VTuDAIH+xsoqUlvRb+8vLgPJRRlP4hE0PlRL+m2FrYrbzEWZwXZ
         CkYRq+gFps9gZkAFAS1cUsNd5DWDQgGVvuVpFj/YfqSzVewTc9dAay8p6FBzBkiLFmio
         5Px/ePo8FXSOBvkYYww+yrfDM+lq1JYOMifVl9K70hDaXTWxDhMfMY9yJVYpPguLuAl2
         6Q8bp688KdONu9M5uvMZgRcB+9ExAUsiMXnU7eI+2xHyb8Ccb2pZdOj7fclMZVvZjLV6
         ygLcozCLr9UzMFxSLDbqjh2pNawGLM30BXoe5Vv6zC1v5UGS1xRLD9LVASjz3TJvSDvU
         WE2Q==
X-Gm-Message-State: AAQBX9f3vOjAVN79anraQZpWF/i3Qe5nG1EyzEpX4AdlNBU4S52AWrUm
        T14f05NG8X2uLqX7WU7/kepeo+mnMmv+pSTIiE6npA==
X-Google-Smtp-Source: AKy350Z2wkSloQAxDjGvYAfK5SDO957AzO1tJ6C9Nr55PQTV2aqFDnfJd5hfvdbzpIM1qoGGSffcbpf2XSt5+48bdhw=
X-Received: by 2002:a50:cd0b:0:b0:4fc:a484:c6ed with SMTP id
 z11-20020a50cd0b000000b004fca484c6edmr11781206edi.2.1680196375048; Thu, 30
 Mar 2023 10:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-4-andrii@kernel.org>
In-Reply-To: <20230328235610.3159943-4-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 30 Mar 2023 18:12:43 +0100
Message-ID: <CAN+4W8jj9AJ785pO3zPh7_n7USdDjvjLgW1EgQ39MBpx08M_1w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
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

On Wed, Mar 29, 2023 at 12:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:

I like the approach! My main problem is always following the various
offset calculations. I'm still not convinced I understand them fully.

For example, there is a bunch of accounting for the implicit 0 that is
written out to user space. Wouldn't it be easier to not terminate the
buffer during normal operation, and instead only do that in
vlog_finalize()?

Another example is start_pos in bpf_verifier_log. In a way, the
verifier log is a bit peculiar as ring buffers go, since there is no
reader we need to account for. It seems to me like we don't need to
track start_pos at all? We can deduce that truncation has occurred if
end_pos >=3D total_len. Similarly, the number of useful bytes is
min(end_pos, total_len). We might need to track the total required
size later (haven't had time to look at your other patch set, sorry),
but then we could do that independent of the ring buffer
implementation.

In my mind we could end up with something like this:

void bpf_verifier_vlog(...) {
  ...
  if (log->level & BPF_LOG_FIXED)
    n =3D min(n, bpf_vlog_available()); // TODO: Need to signal ENOSPC
somehow, maybe just a bool?

  bpf_vlog_append(..., n)
}

bpf_vlog_append() would only deal with writing into the buffer, no
BPF_LOG_FIXED specific code. Null termination would happen in
bpf_vlog_finalize.

Some more thoughts below:

>  #define BPF_LOG_LEVEL1 1
>  #define BPF_LOG_LEVEL2 2
>  #define BPF_LOG_STATS  4
> +#define BPF_LOG_FIXED  8

Nit: how about calling this BPF_LOG_TRUNCATE_TAIL instead? FIXED only
makes sense with the context that we implement this using a (rotating)
ring buffer.

> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -8,6 +8,7 @@
>  #include <linux/types.h>
>  #include <linux/bpf.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/math64.h>
>
>  bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
>  {
> @@ -32,23 +33,199 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log,=
 const char *fmt,
>                 return;
>         }
>
> -       n =3D min(log->len_total - log->len_used - 1, n);
> -       log->kbuf[n] =3D '\0';
> -       if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
> -               log->len_used +=3D n;
> -       else
> -               log->ubuf =3D NULL;
> +       if (log->level & BPF_LOG_FIXED) {
> +               n =3D min(log->len_total - bpf_log_used(log) - 1, n);

Noob question, doesn't log->len_total - bpf_log_used(log) - 1
underflow if the log is full? Maybe worth turning this into
bpf_vlog_available() as well.

> +               log->kbuf[n] =3D '\0';
> +               n +=3D 1;

I personally find the original style of doing copy_to_user(..., n+1)
instead of adding and subtracting from n easier to read. Still prefer
to terminate in finalize().

> +
> +               if (copy_to_user(log->ubuf + log->end_pos, log->kbuf, n))
> +                       goto fail;
> +
> +               log->end_pos +=3D n - 1; /* don't count terminating '\0' =
*/
> +       } else {
> +               u64 new_end, new_start, cur_pos;
> +               u32 buf_start, buf_end, new_n;
> +
> +               log->kbuf[n] =3D '\0';
> +               n +=3D 1;
> +
> +               new_end =3D log->end_pos + n;
> +               if (new_end - log->start_pos >=3D log->len_total)
> +                       new_start =3D new_end - log->len_total;
> +               else
> +                       new_start =3D log->start_pos;
> +               new_n =3D min(n, log->len_total);
> +               cur_pos =3D new_end - new_n;
> +
> +               div_u64_rem(cur_pos, log->len_total, &buf_start);
> +               div_u64_rem(new_end, log->len_total, &buf_end);
> +               /* new_end and buf_end are exclusive indices, so if buf_e=
nd is
> +                * exactly zero, then it actually points right to the end=
 of
> +                * ubuf and there is no wrap around
> +                */
> +               if (buf_end =3D=3D 0)
> +                       buf_end =3D log->len_total;
> +
> +               /* if buf_start > buf_end, we wrapped around;
> +                * if buf_start =3D=3D buf_end, then we fill ubuf complet=
ely; we
> +                * can't have buf_start =3D=3D buf_end to mean that there=
 is
> +                * nothing to write, because we always write at least
> +                * something, even if terminal '\0'
> +                */
> +               if (buf_start < buf_end) {
> +                       /* message fits within contiguous chunk of ubuf *=
/
> +                       if (copy_to_user(log->ubuf + buf_start,
> +                                        log->kbuf + n - new_n,
> +                                        buf_end - buf_start))
> +                               goto fail;
> +               } else {
> +                       /* message wraps around the end of ubuf, copy in =
two chunks */
> +                       if (copy_to_user(log->ubuf + buf_start,
> +                                        log->kbuf + n - new_n,
> +                                        log->len_total - buf_start))
> +                               goto fail;
> +                       if (copy_to_user(log->ubuf,
> +                                        log->kbuf + n - buf_end,
> +                                        buf_end))
> +                               goto fail;
> +               }
> +
> +               log->start_pos =3D new_start;
> +               log->end_pos =3D new_end - 1; /* don't count terminating =
'\0' */
> +       }
> +
> +       return;
> +fail:
> +       log->ubuf =3D NULL;
>  }
>
> -void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
> +void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
>  {
>         char zero =3D 0;
> +       u32 pos;
>
>         if (!bpf_verifier_log_needed(log))
>                 return;
>
> -       log->len_used =3D new_pos;
> -       if (put_user(zero, log->ubuf + new_pos))
> +       /* if position to which we reset is beyond current log window,
> +        * then we didn't preserve any useful content and should adjust
> +        * start_pos to end up with an empty log (start_pos =3D=3D end_po=
s)
> +        */
> +       log->end_pos =3D new_pos;

Is it valid for new_pos to be > log->end_pos? If not it would be nice
to bail out here (maybe with a WARN_ON_ONCE?). Then this function
could become bpf_vlog_truncate.

> +       if (log->end_pos < log->start_pos)
> +               log->start_pos =3D log->end_pos;
> +       div_u64_rem(new_pos, log->len_total, &pos);
> +       if (put_user(zero, log->ubuf + pos))
> +               log->ubuf =3D NULL;
> +}
> +
> +static void bpf_vlog_reverse_kbuf(char *buf, int len)

This isn't really kbuf specific, how about just reverse_buf?

> +{
> +       int i, j;
> +
> +       for (i =3D 0, j =3D len - 1; i < j; i++, j--)
> +               swap(buf[i], buf[j]);
> +}
> +
> +static int bpf_vlog_reverse_ubuf(struct bpf_verifier_log *log, int start=
, int end)

Oh boy, I spent a while trying to understand this, then trying to come
up with something simpler. Neither of which I was very successful with
:o)

> +{
> +       /* we split log->kbuf into two equal parts for both ends of array=
 */
> +       int n =3D sizeof(log->kbuf) / 2, nn;
> +       char *lbuf =3D log->kbuf, *rbuf =3D log->kbuf + n;
> +
> +       /* Read ubuf's section [start, end) two chunks at a time, from le=
ft
> +        * and right side; within each chunk, swap all the bytes; after t=
hat
> +        * reverse the order of lbuf and rbuf and write result back to ub=
uf.
> +        * This way we'll end up with swapped contents of specified
> +        * [start, end) ubuf segment.
> +        */
> +       while (end - start > 1) {
> +               nn =3D min(n, (end - start ) / 2);
> +
> +               if (copy_from_user(lbuf, log->ubuf + start, nn))
> +                       return -EFAULT;
> +               if (copy_from_user(rbuf, log->ubuf + end - nn, nn))
> +                       return -EFAULT;
> +
> +               bpf_vlog_reverse_kbuf(lbuf, nn);
> +               bpf_vlog_reverse_kbuf(rbuf, nn);
> +
> +               /* we write lbuf to the right end of ubuf, while rbuf to =
the
> +                * left one to end up with properly reversed overall ubuf
> +                */
> +               if (copy_to_user(log->ubuf + start, rbuf, nn))
> +                       return -EFAULT;
> +               if (copy_to_user(log->ubuf + end - nn, lbuf, nn))
> +                       return -EFAULT;
> +
> +               start +=3D nn;
> +               end -=3D nn;
> +       }
> +
> +       return 0;
> +}
> +
> +bool bpf_vlog_truncated(const struct bpf_verifier_log *log)
> +{
> +       if (log->level & BPF_LOG_FIXED)
> +               return bpf_log_used(log) >=3D log->len_total - 1;

Can this ever return true? In verifier_vlog we avoid writing more than
total - bpf_log_used. Seems like your new test case covers this, so
I'm a bit lost...

> +       else
> +               return log->start_pos > 0;
> +}
> +
> +void bpf_vlog_finalize(struct bpf_verifier_log *log)
> +{
> +       u32 sublen;

Nit: "pivot" might be more appropriate?

> +       int err;
> +
> +       if (!log || !log->level || !log->ubuf)
> +               return;
> +       if ((log->level & BPF_LOG_FIXED) || log->level =3D=3D BPF_LOG_KER=
NEL)
> +               return;
> +
> +       /* If we never truncated log, there is nothing to move around. */
> +       if (log->start_pos =3D=3D 0)
> +               return;
> +
> +       /* Otherwise we need to rotate log contents to make it start from=
 the
> +        * buffer beginning and be a continuous zero-terminated string. N=
ote
> +        * that if log->start_pos !=3D 0 then we definitely filled up ent=
ire log
> +        * buffer with no gaps, and we just need to shift buffer contents=
 to
> +        * the left by (log->start_pos % log->len_total) bytes.
> +        *
> +        * Unfortunately, user buffer could be huge and we don't want to
> +        * allocate temporary kernel memory of the same size just to shif=
t
> +        * contents in a straightforward fashion. Instead, we'll be cleve=
r and
> +        * do in-place array rotation. This is a leetcode-style problem, =
which
> +        * could be solved by three rotations.

It took me a while to understand this, but the problem isn't in place
rotation, right? It's that we can't directly access ubuf so we have to
use kbuf as a window.

> +        *
> +        * Let's say we have log buffer that has to be shifted left by 7 =
bytes
> +        * (spaces and vertical bar is just for demonstrative purposes):
> +        *   E F G H I J K | A B C D
> +        *
> +        * First, we reverse entire array:
> +        *   D C B A | K J I H G F E
> +        *
> +        * Then we rotate first 4 bytes (DCBA) and separately last 7 byte=
s
> +        * (KJIHGFE), resulting in a properly rotated array:
> +        *   A B C D | E F G H I J K
> +        *
> +        * We'll utilize log->kbuf to read user memory chunk by chunk, sw=
ap
> +        * bytes, and write them back. Doing it byte-by-byte would be
> +        * unnecessarily inefficient. Altogether we are going to read and
> +        * write each byte twice.

But four copies in total?
