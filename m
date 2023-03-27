Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5DD6CAD0E
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC0Scj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjC0Scj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:32:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF73AAB
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:32:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ew6so39957591edb.7
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679941953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVD8yUwOZlbr33agwo1MtLByZkicXh4/kmNJUuNmcKw=;
        b=ITGW1nPSWm133rjUPQMm3wCAv0cnms1DFFOvKMu56qZ730h4sIqtPlGaDjIIPgYXRF
         MaJHWEVIT4cAxzSCt3zB/jewT+KWg4tokkc1ZR/XmD4lYPefqjX7TTwF7Zxh+BX4YThr
         oki5rbJqLjFE63jf5dv1qBrSO37I0zP+2dh06NLqKXj03hU135IZAtJEPSDMEI8GULGT
         KMtkbLYkMoi1C9JC6ZigEYIgEg7cSE8ahQpXWxA3ihnx3TwRv3gHrm3e4Hr5AoRTRoiV
         Q+W5Jyv6P9ECz4QAQQHtmTR64AWgwD1hxcz260YYha4Fdof/JjA6oc3XLp8WkyHLwHRP
         p37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679941953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVD8yUwOZlbr33agwo1MtLByZkicXh4/kmNJUuNmcKw=;
        b=M7wy3DA+PIkxnG+M8W1jKl8D4GcbfgXCRgMZXCzLT7GEfdO4LFUH8jfKR4aNVL+y50
         PwJBILqplLLE0zIJSTH4pkdY8UKP0OeLRzGcFrUvzSBS7qySbMni7BMjp1B83pxRs6bL
         gTUXI8e5awluuM7/yRMusc7xEA+T7l9fkhLuxIJed8+LROgAO1x2iha3BPO2hnmiOjjY
         UhJvkVO4fsdgkWyZ/kj+cLvUaNkPI6BXnfyakMGbhnhgSlsTYwvK79y7AbtEuSrn9OK6
         qQu8mk3FHlEBFPfFjCYz/zNICprm3RotnWRFcizTXRxlI1cAE5OZjSD6fRqcF0Ndad7V
         m2/g==
X-Gm-Message-State: AAQBX9d3thBMXBwaMqapCKOOsflR4bVvCuLVxBYGT8KUiEgQ3oHGY5xA
        q/M7OEgmtlW/QWrRmw8k5vwRHqQS5SjWZ0ucqAYegAQaMR8=
X-Google-Smtp-Source: AKy350Z7eq2Ju2CbQsFTSl9rnAsSeok6vxOtFJxZcvNXfdyjCOptBCRlJzj/L/YxNwbwENEfxCW+b0RIk7ayQC3+LDI=
X-Received: by 2002:a17:906:6692:b0:944:70f7:6fae with SMTP id
 z18-20020a170906669200b0094470f76faemr2231000ejo.5.1679941953441; Mon, 27 Mar
 2023 11:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230325010845.46000-1-inwardvessel@gmail.com> <ZB5mAffV69GUEIZU@google.com>
In-Reply-To: <ZB5mAffV69GUEIZU@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 11:32:21 -0700
Message-ID: <CAEf4BzaFpC_3Wgf56Tw=O-Vb28Wf5vguaJkvQNaRMN=0v7puvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: synchronize access to print function pointer
To:     Stanislav Fomichev <sdf@google.com>
Cc:     JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, kernel-team@meta.com
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

On Fri, Mar 24, 2023 at 8:09=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 03/24, JP Kobryn wrote:
> > This patch prevents races on the print function pointer, allowing the
> > libbpf_set_print() function to become thread safe.
>
> Why does it have to be thread-safe? The rest of the APIs aren't, so

It doesn't have to, but if it can be made thread-safe trivially, it
probably should be. Rust users are especially sensitive to this (see
discussion in [0] for example).

Generally speaking, yep, libbpf APIs are not thread-safe by default
(we don't do explicit locking anywhere inside libbpf), but there are a
bunch of APIs that are inherently thread-safe as they are stateless
(like feature probing, string conversion APIs, I suspect upon
inspection we'll see that all bpf_program__attach_*() APIs are also
probably thread-safe already). So we should start marking them as such
to avoid confusion and uncertainty for users. I'd also like to
document somewhere that two independent bpf_objects can be used safely
on two separate threads, because whatever state they are sharing (like
feature detection cache) is designed in such a way to be thread-safe
and shareable with no locking.

  [0] https://github.com/libbpf/libbpf-rs/pull/374#issuecomment-1462565778

> why can't use solve it on your side by wrapping those calls with a
> mutex?

It would be very unfortunate to wrap libbpf_set_print and *all other
libbpf API* in mutex.

>
> (is there some context I'm missing?)
>
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 9 ++++++---
> >   tools/lib/bpf/libbpf.h | 3 +++
> >   2 files changed, 9 insertions(+), 3 deletions(-)
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index f6a071db5c6e..15737d7b5a28 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -216,9 +216,10 @@ static libbpf_print_fn_t __libbpf_pr =3D __base_pr=
;
>
> >   libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn)
> >   {
> > -     libbpf_print_fn_t old_print_fn =3D __libbpf_pr;
> > +     libbpf_print_fn_t old_print_fn;
> > +
> > +     old_print_fn =3D __atomic_exchange_n(&__libbpf_pr, fn, __ATOMIC_R=
ELAXED);
>
> > -     __libbpf_pr =3D fn;
> >       return old_print_fn;
> >   }
>
> > @@ -227,8 +228,10 @@ void libbpf_print(enum libbpf_print_level level,
> > const char *format, ...)
> >   {
> >       va_list args;
> >       int old_errno;
> > +     libbpf_print_fn_t print_fn;
>
> > -     if (!__libbpf_pr)
> > +     print_fn =3D __atomic_load_n(&__libbpf_pr, __ATOMIC_RELAXED);
> > +     if (!print_fn)
> >               return;
>
> >       old_errno =3D errno;
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 1615e55e2e79..4478809ff9ca 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -99,6 +99,9 @@ typedef int (*libbpf_print_fn_t)(enum
> > libbpf_print_level level,
> >   /**
> >    * @brief **libbpf_set_print()** sets user-provided log callback
> > function to
> >    * be used for libbpf warnings and informational messages.
> > + *
> > + * This function is thread safe.
> > + *
> >    * @param fn The log print function. If NULL, libbpf won't print
> > anything.
> >    * @return Pointer to old print function.
> >    */
> > --
> > 2.39.2
>
