Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881EB6D1042
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 22:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjC3Usa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 16:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjC3Us2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 16:48:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD0349CF
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 13:48:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ek18so81632635edb.6
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680209304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUw2xCp4xjRZLwaaILT1xZlBowqcVPOVjh9Mftrm4h4=;
        b=YMgj4LlAQaJrQqJ6m6oVGhmGB6XyE+BoAFj/MWOUwhaDFlQE46M/LSFT5sRoUbE2f3
         uGFQ+vsm8KHl5iSQKRS4l2/lyh+14YUdcCyLeJIKuxowle5FlK9usUGLnB8krfkuX2l6
         rUI85FDcIi+try/Cc1wP0g1/OcJyw+PZmZyguUTItAoZ1na3zjlVBaW0EC2jUwebWUL9
         7AI7OySBSazOrRh9sNDE9Kyxm/SmX9+Cue7FJ3oRj3a9dM59+l6+9Xh/kADbCp3ZnrGw
         RNRkqABCBiSBqpmDvqpQKiw1I0ryTjZvbAEVz4cHM60c4t93JT6og/Nn1HqqZYwXFXcm
         OcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680209304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUw2xCp4xjRZLwaaILT1xZlBowqcVPOVjh9Mftrm4h4=;
        b=JKZXuLVRlix22Cl1kpL8L5REi5uESM5MjiB5EB1nM3UQT64/cfbdO7shtGVWxk5kRF
         DxxLn8m/XOkRfme6qjSe6tBmdXIhbsStl5NxbXIGgoKi1M6eCi8pKLY6dXt2+B4bn7go
         wOwCM8k55bZ9dphKNnWy/F/UGldD3ZpGzGd45VP1EXMycZs6kq3WVkrIFPAkBSJqCHsE
         VDEuyU1FxfPwItGVu5G1qWRHGgsXglef0rEIT3b3fcuY9nxC/xD7X3upo/8PuvOzfSgW
         6ntcAlk4Ukd8iZ+se2EfO4reHsFqLWfFURmESl3gCBFIQtalYoolYtq/rpRkVh0BZC5q
         97Ww==
X-Gm-Message-State: AAQBX9dtPf7XZny5cKCPANQLkmAYym1bCTaI6wyyvRUnCz0SxnvnrtB1
        iHP3VcqOeImjLvkCnAc9YBIYUL2sylbgQMkyGdc=
X-Google-Smtp-Source: AKy350aUspuId7yOCNh3q1rCkeyFeZKT9b+axjGkMqlePARtU0YE+70sWGSvhZdU2SkZBmz1YwqahJObNQC77OTe/fI=
X-Received: by 2002:a50:d694:0:b0:4fb:f19:883 with SMTP id r20-20020a50d694000000b004fb0f190883mr12689575edi.1.1680209304044;
 Thu, 30 Mar 2023 13:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-4-andrii@kernel.org>
 <CAN+4W8jj9AJ785pO3zPh7_n7USdDjvjLgW1EgQ39MBpx08M_1w@mail.gmail.com>
In-Reply-To: <CAN+4W8jj9AJ785pO3zPh7_n7USdDjvjLgW1EgQ39MBpx08M_1w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 30 Mar 2023 13:48:11 -0700
Message-ID: <CAEf4BzYOYVF1PZYnZUvTWkKTXVChvOjt6jCRBFBWhMDP4f295w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
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

On Thu, Mar 30, 2023 at 10:12=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> w=
rote:
>
> On Wed, Mar 29, 2023 at 12:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
>
> I like the approach! My main problem is always following the various
> offset calculations. I'm still not convinced I understand them fully.
>
> For example, there is a bunch of accounting for the implicit 0 that is
> written out to user space. Wouldn't it be easier to not terminate the
> buffer during normal operation, and instead only do that in
> vlog_finalize()?

So I'm preserving the original behavior, but I also think the original
behavior makes sense, as it tries to keep valid string contents at all
times. At least I don't really see much problem with it, do you?

>
> Another example is start_pos in bpf_verifier_log. In a way, the
> verifier log is a bit peculiar as ring buffers go, since there is no
> reader we need to account for. It seems to me like we don't need to
> track start_pos at all? We can deduce that truncation has occurred if
> end_pos >=3D total_len. Similarly, the number of useful bytes is
> min(end_pos, total_len). We might need to track the total required
> size later (haven't had time to look at your other patch set, sorry),
> but then we could do that independent of the ring buffer
> implementation.

Hm... start_pos definitely is necessary due to bpf_vlog_reset() at
least. Similarly, end_pos can go back on log reset. But second patch
set simplifies this further, as we keep track of maximum log content
size we ever reach, and that could be straightforwardly compared to
log->len_total.

>
> In my mind we could end up with something like this:
>
> void bpf_verifier_vlog(...) {
>   ...
>   if (log->level & BPF_LOG_FIXED)
>     n =3D min(n, bpf_vlog_available()); // TODO: Need to signal ENOSPC
> somehow, maybe just a bool?
>
>   bpf_vlog_append(..., n)
> }
>
> bpf_vlog_append() would only deal with writing into the buffer, no
> BPF_LOG_FIXED specific code. Null termination would happen in
> bpf_vlog_finalize.

I'm not following. bpf_vlog_append() would have to distinguish between
BPF_LOG_FIXED and rotating mode, because in rotating mode you have to
wrap around the physical end of the buffer.

>
> Some more thoughts below:
>
> >  #define BPF_LOG_LEVEL1 1
> >  #define BPF_LOG_LEVEL2 2
> >  #define BPF_LOG_STATS  4
> > +#define BPF_LOG_FIXED  8
>
> Nit: how about calling this BPF_LOG_TRUNCATE_TAIL instead? FIXED only
> makes sense with the context that we implement this using a (rotating)
> ring buffer.

It's more verbose, so BPF_LOG_FIXED seems more in line with existing
constants names. But note that this is not part of UAPI, user-space
won't see/have "BPF_LOG_FIXED" constant.

>
> > --- a/kernel/bpf/log.c
> > +++ b/kernel/bpf/log.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/types.h>
> >  #include <linux/bpf.h>
> >  #include <linux/bpf_verifier.h>
> > +#include <linux/math64.h>
> >
> >  bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
> >  {
> > @@ -32,23 +33,199 @@ void bpf_verifier_vlog(struct bpf_verifier_log *lo=
g, const char *fmt,
> >                 return;
> >         }
> >
> > -       n =3D min(log->len_total - log->len_used - 1, n);
> > -       log->kbuf[n] =3D '\0';
> > -       if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
> > -               log->len_used +=3D n;
> > -       else
> > -               log->ubuf =3D NULL;
> > +       if (log->level & BPF_LOG_FIXED) {
> > +               n =3D min(log->len_total - bpf_log_used(log) - 1, n);
>
> Noob question, doesn't log->len_total - bpf_log_used(log) - 1
> underflow if the log is full? Maybe worth turning this into
> bpf_vlog_available() as well.

It's a valid question. The answer is that currently
bpf_verifier_vlog() assumes log is not completely full, because all
the callers first check bpf_verifier_log_needed(), which returns false
if the log buffer is full.

I'm removing this assumption (and the whole "is log full" check) in
the follow up patch set.


>
> > +               log->kbuf[n] =3D '\0';
> > +               n +=3D 1;
>
> I personally find the original style of doing copy_to_user(..., n+1)
> instead of adding and subtracting from n easier to read. Still prefer
> to terminate in finalize().
>

This makes the rest of the math (especially for rotating mode) simpler
with no extra +1/-1.  See how many uses of n are below, and imagine
that we'll have to do +1 there. Conceptually, n is "how much stuff we
write to user-space", so it makes sense if we write a zero-terminating
byte.

> > +
> > +               if (copy_to_user(log->ubuf + log->end_pos, log->kbuf, n=
))
> > +                       goto fail;
> > +
> > +               log->end_pos +=3D n - 1; /* don't count terminating '\0=
' */
> > +       } else {
> > +               u64 new_end, new_start, cur_pos;
> > +               u32 buf_start, buf_end, new_n;
> > +
> > +               log->kbuf[n] =3D '\0';
> > +               n +=3D 1;
> > +
> > +               new_end =3D log->end_pos + n;
> > +               if (new_end - log->start_pos >=3D log->len_total)
> > +                       new_start =3D new_end - log->len_total;
> > +               else
> > +                       new_start =3D log->start_pos;
> > +               new_n =3D min(n, log->len_total);
> > +               cur_pos =3D new_end - new_n;
> > +
> > +               div_u64_rem(cur_pos, log->len_total, &buf_start);
> > +               div_u64_rem(new_end, log->len_total, &buf_end);
> > +               /* new_end and buf_end are exclusive indices, so if buf=
_end is
> > +                * exactly zero, then it actually points right to the e=
nd of
> > +                * ubuf and there is no wrap around
> > +                */
> > +               if (buf_end =3D=3D 0)
> > +                       buf_end =3D log->len_total;
> > +
> > +               /* if buf_start > buf_end, we wrapped around;
> > +                * if buf_start =3D=3D buf_end, then we fill ubuf compl=
etely; we
> > +                * can't have buf_start =3D=3D buf_end to mean that the=
re is
> > +                * nothing to write, because we always write at least
> > +                * something, even if terminal '\0'
> > +                */
> > +               if (buf_start < buf_end) {
> > +                       /* message fits within contiguous chunk of ubuf=
 */
> > +                       if (copy_to_user(log->ubuf + buf_start,
> > +                                        log->kbuf + n - new_n,
> > +                                        buf_end - buf_start))
> > +                               goto fail;
> > +               } else {
> > +                       /* message wraps around the end of ubuf, copy i=
n two chunks */
> > +                       if (copy_to_user(log->ubuf + buf_start,
> > +                                        log->kbuf + n - new_n,
> > +                                        log->len_total - buf_start))
> > +                               goto fail;
> > +                       if (copy_to_user(log->ubuf,
> > +                                        log->kbuf + n - buf_end,
> > +                                        buf_end))
> > +                               goto fail;
> > +               }
> > +
> > +               log->start_pos =3D new_start;
> > +               log->end_pos =3D new_end - 1; /* don't count terminatin=
g '\0' */
> > +       }
> > +
> > +       return;
> > +fail:
> > +       log->ubuf =3D NULL;
> >  }
> >
> > -void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
> > +void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
> >  {
> >         char zero =3D 0;
> > +       u32 pos;
> >
> >         if (!bpf_verifier_log_needed(log))
> >                 return;
> >
> > -       log->len_used =3D new_pos;
> > -       if (put_user(zero, log->ubuf + new_pos))
> > +       /* if position to which we reset is beyond current log window,
> > +        * then we didn't preserve any useful content and should adjust
> > +        * start_pos to end up with an empty log (start_pos =3D=3D end_=
pos)
> > +        */
> > +       log->end_pos =3D new_pos;
>
> Is it valid for new_pos to be > log->end_pos? If not it would be nice
> to bail out here (maybe with a WARN_ON_ONCE?). Then this function
> could become bpf_vlog_truncate.

new_pos should always be <=3D end_pos, unless there is some bug
somewhere else. It's unlikely we'll have a bug with this, because
verifier code just remembers previous end_pos temporarily and resets
to it, it doesn't do any match on that, I think.

I can add this extra check, but this feels like it falls into the
"unnecessary defensive code" bucket, so I expect a push back for that.

>
> > +       if (log->end_pos < log->start_pos)
> > +               log->start_pos =3D log->end_pos;
> > +       div_u64_rem(new_pos, log->len_total, &pos);
> > +       if (put_user(zero, log->ubuf + pos))
> > +               log->ubuf =3D NULL;
> > +}
> > +
> > +static void bpf_vlog_reverse_kbuf(char *buf, int len)
>
> This isn't really kbuf specific, how about just reverse_buf?

kbuf as opposed to ubuf. Kernel-space manipulations, which don't
require copy_from_user. I wanted to emphasize this distinction and
keep symmetry with bpf_vlog_reverse_ubuf().

>
> > +{
> > +       int i, j;
> > +
> > +       for (i =3D 0, j =3D len - 1; i < j; i++, j--)
> > +               swap(buf[i], buf[j]);
> > +}
> > +
> > +static int bpf_vlog_reverse_ubuf(struct bpf_verifier_log *log, int sta=
rt, int end)
>
> Oh boy, I spent a while trying to understand this, then trying to come
> up with something simpler. Neither of which I was very successful with
> :o)

yeah, it's conceptually very simple, but because of kernel-user
boundary and buffering, we need to do it two symmetrical chunks at a
time

>
> > +{
> > +       /* we split log->kbuf into two equal parts for both ends of arr=
ay */
> > +       int n =3D sizeof(log->kbuf) / 2, nn;
> > +       char *lbuf =3D log->kbuf, *rbuf =3D log->kbuf + n;
> > +
> > +       /* Read ubuf's section [start, end) two chunks at a time, from =
left
> > +        * and right side; within each chunk, swap all the bytes; after=
 that
> > +        * reverse the order of lbuf and rbuf and write result back to =
ubuf.
> > +        * This way we'll end up with swapped contents of specified
> > +        * [start, end) ubuf segment.
> > +        */
> > +       while (end - start > 1) {
> > +               nn =3D min(n, (end - start ) / 2);
> > +
> > +               if (copy_from_user(lbuf, log->ubuf + start, nn))
> > +                       return -EFAULT;
> > +               if (copy_from_user(rbuf, log->ubuf + end - nn, nn))
> > +                       return -EFAULT;
> > +
> > +               bpf_vlog_reverse_kbuf(lbuf, nn);
> > +               bpf_vlog_reverse_kbuf(rbuf, nn);
> > +
> > +               /* we write lbuf to the right end of ubuf, while rbuf t=
o the
> > +                * left one to end up with properly reversed overall ub=
uf
> > +                */
> > +               if (copy_to_user(log->ubuf + start, rbuf, nn))
> > +                       return -EFAULT;
> > +               if (copy_to_user(log->ubuf + end - nn, lbuf, nn))
> > +                       return -EFAULT;
> > +
> > +               start +=3D nn;
> > +               end -=3D nn;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +bool bpf_vlog_truncated(const struct bpf_verifier_log *log)
> > +{
> > +       if (log->level & BPF_LOG_FIXED)
> > +               return bpf_log_used(log) >=3D log->len_total - 1;
>
> Can this ever return true? In verifier_vlog we avoid writing more than
> total - bpf_log_used. Seems like your new test case covers this, so
> I'm a bit lost...

I think so. bpf_log_used() returns buffer contents excluding
terminating zero, so it can only go up to log->len_total - 1, but if
it is as log->len_total - 1, then we treat it as overflow. I mention
this in the second patch set, but this approach doesn't distinguish
log buffer filled up to exactly N bytes, vs log_buffer that was > N
bytes long, but got truncated. I actually change and simplify this
logic in second patch set and make it distinguish these two
situations. This was important to make sure that log_size_actual can
be used as is exactly, otherwise users would have to supply at least
log_size_actual + 1.

So, basically, here, I'm preserving existing behavior, and patch set 2
changes this bit as part of overall fixed mode overhaul.

>
> > +       else
> > +               return log->start_pos > 0;
> > +}
> > +
> > +void bpf_vlog_finalize(struct bpf_verifier_log *log)
> > +{
> > +       u32 sublen;
>
> Nit: "pivot" might be more appropriate?

div_u64_rem(log->start_pos, log->len_total, &sublen);
sublen =3D log->len_total - sublen;

pivot implies it's an index of an element, and then causes questions
about inclusive/exclusive, right? While length is length, so seems
less ambiguous?


>
> > +       int err;
> > +
> > +       if (!log || !log->level || !log->ubuf)
> > +               return;
> > +       if ((log->level & BPF_LOG_FIXED) || log->level =3D=3D BPF_LOG_K=
ERNEL)
> > +               return;
> > +
> > +       /* If we never truncated log, there is nothing to move around. =
*/
> > +       if (log->start_pos =3D=3D 0)
> > +               return;
> > +
> > +       /* Otherwise we need to rotate log contents to make it start fr=
om the
> > +        * buffer beginning and be a continuous zero-terminated string.=
 Note
> > +        * that if log->start_pos !=3D 0 then we definitely filled up e=
ntire log
> > +        * buffer with no gaps, and we just need to shift buffer conten=
ts to
> > +        * the left by (log->start_pos % log->len_total) bytes.
> > +        *
> > +        * Unfortunately, user buffer could be huge and we don't want t=
o
> > +        * allocate temporary kernel memory of the same size just to sh=
ift
> > +        * contents in a straightforward fashion. Instead, we'll be cle=
ver and
> > +        * do in-place array rotation. This is a leetcode-style problem=
, which
> > +        * could be solved by three rotations.
>
> It took me a while to understand this, but the problem isn't in place
> rotation, right? It's that we can't directly access ubuf so we have to
> use kbuf as a window.

Hm.. no, it is the rotation in place. Even if it was in the kernel
buffer and we wanted to rotate this without creating a second large
copy of the buffer, we'd have to do this double rotation. Kernel vs
user space adds complications for sure, but it is hidden inside
bpf_vlog_reverse_ubuf(), and as far as this overall algorithm goes,
doesn't matter.

>
> > +        *
> > +        * Let's say we have log buffer that has to be shifted left by =
7 bytes
> > +        * (spaces and vertical bar is just for demonstrative purposes)=
:
> > +        *   E F G H I J K | A B C D
> > +        *
> > +        * First, we reverse entire array:
> > +        *   D C B A | K J I H G F E
> > +        *
> > +        * Then we rotate first 4 bytes (DCBA) and separately last 7 by=
tes
> > +        * (KJIHGFE), resulting in a properly rotated array:
> > +        *   A B C D | E F G H I J K
> > +        *
> > +        * We'll utilize log->kbuf to read user memory chunk by chunk, =
swap
> > +        * bytes, and write them back. Doing it byte-by-byte would be
> > +        * unnecessarily inefficient. Altogether we are going to read a=
nd
> > +        * write each byte twice.
>
> But four copies in total?

So each rotation reads each byte once and writes each byte once. So
two copies. And then the entire buffer is rotated twice (three
rotating steps, but overall contents is rotated twice), so two reads
and two writes for each byte, 4 memory copies altogether. Would you
like me to clarify this some more?
