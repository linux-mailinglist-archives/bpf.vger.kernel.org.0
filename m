Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DA46E2DA
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 08:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhLIHFJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 02:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhLIHFI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Dec 2021 02:05:08 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1140FC061746
        for <bpf@vger.kernel.org>; Wed,  8 Dec 2021 23:01:36 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v64so11477959ybi.5
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 23:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gl46sy3Tp3/9p2Fz4Kl8JCRCuuyxdsKVd00JAcm+nq8=;
        b=FlP2N1tH9bmmUrPPN3oJX+CZVmaTxgZVlEDXLKcv0T54OkGJHpYd5FwBcWiYtuILW5
         J+PI/l/TFbYvBVh59ICUR1KZBiVtWEkHEmPclNxe0FFPMXMOxqP+Xggg+op6QMV/51vX
         g7HXzOFJaJVaTMMKKionssNF8nvtgH8U1rALD0N6vc7NrqFdluC6nZiYZlB7Q5LqqcHe
         GM8YLuW0ji0nLTFiYt0syPMeJr14WowqZqyIRJi7Vl6g5CYm86HFFyCdIRQl+AlzIGEB
         VVajkcL7FCWnMAomKWaK10JkjWtIGdS2cDyUkQm2mGY7DQaCdIlaMUfRBqScAaNWCne/
         EN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gl46sy3Tp3/9p2Fz4Kl8JCRCuuyxdsKVd00JAcm+nq8=;
        b=YjuTlUS06VnWEKEah0nhHeIqLPYMbXqap7FfSybqsunZhYoJGA1n4AHYPh1u0qYVPy
         AayjG5AP2Cosdbm63gG+R8iElp6NowdG5uqxeKDc4fDxJKGVe4MlbzsmGf4x/u2IztiG
         r/JUbsPuEpmQKv5n/xifDwKn1+zd+99p162eSNjl9dKxU6t6En30CGO6BFio/UJdXpgy
         ZI6qbUbeH8KDhQS/mpOSj5mqj/dZitTxAwmlkhCZVAQHrPQkC68v+BokVhBG1O2Bdkwt
         RZUQRUYhNs4U0Xt+ilxNEWMzAiG5HdJJXF8JIMCP7XIIni17q64Rv7i+hWQtZCCg0d9P
         YGeA==
X-Gm-Message-State: AOAM530LbdkE7c2Zhix3zy98/9o5vkBxSgxDEFPPDm+ofrFiCFyVGci8
        RFRdVSTe07iAqyYUalG8ksh+t7YuJ4lOzYAvyZA=
X-Google-Smtp-Source: ABdhPJxsB+jNHQ/BahEhtqDDljBRWGQPvhopAV+swqe6Noe6sYenzRCjKcCJf5sOkDme4ErgN7fkZeKLJwY2hAcfxyc=
X-Received: by 2002:a5b:1c2:: with SMTP id f2mr4563066ybp.150.1639033295192;
 Wed, 08 Dec 2021 23:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20211209004920.4085377-1-andrii@kernel.org> <20211209004920.4085377-2-andrii@kernel.org>
 <61b1a1844d712_ae146208b@john.notmuch>
In-Reply-To: <61b1a1844d712_ae146208b@john.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Dec 2021 23:01:23 -0800
Message-ID: <CAEf4Bzb0Miw3uOfSDv3NRWHmMaQFFyZhOw1N8FoYYWjJ+kL1AQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/12] libbpf: fix bpf_prog_load() log_buf
 logic for log_level 0
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 8, 2021 at 10:26 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Andrii Nakryiko wrote:
> > To unify libbpf APIs behavior w.r.t. log_buf and log_level, fix
> > bpf_prog_load() to follow the same logic as bpf_btf_load() and
> > high-level bpf_object__load() API will follow in the subsequent patches:
> >   - if log_level is 0 and non-NULL log_buf is provided by a user, attempt
> >     load operation initially with no log_buf and log_level set;
> >   - if successful, we are done, return new FD;
> >   - on error, retry the load operation with log_level bumped to 1 and
> >     log_buf set; this way verbose logging will be requested only when we
> >     are sure that there is a failure, but will be fast in the
> >     common/expected success case.
> >
> > Of course, user can still specify log_level > 0 from the very beginning
> > to force log collection.
> >
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> [...]
>
> > @@ -366,16 +368,17 @@ int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
> >                       goto done;
> >       }
> >
> > -     if (log_level || !log_buf)
> > -             goto done;
> > +     if (log_level == 0 && !log_buf) {
>                               ^^^^^^^^
>
> with non-Null log buf? Seems comment and above are out of sync?
>
> Should it be, if (log_level == 0 && log_buf) { ... }

Doh... yeah, it should. Apparently inverting a boolean expression is
non-trivial :) I'll add low-level bpf_prog_load() (and maybe
bpf_btf_load() while at it) log_buf tests to log_buf.c in selftests to
catch something like this better, thanks for catching!

>
> > +             /* log_level == 0 with non-NULL log_buf requires retrying on error
> > +              * with log_level == 1 and log_buf/log_buf_size set, to get details of
> > +              * failure
> > +              */
> > +             attr.log_buf = ptr_to_u64(log_buf);
> > +             attr.log_size = log_size;
> > +             attr.log_level = 1;
> >
> > -     /* Try again with log */
> > -     log_buf[0] = 0;
> > -     attr.log_buf = ptr_to_u64(log_buf);
> > -     attr.log_size = log_size;
> > -     attr.log_level = 1;
> > -
> > -     fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
> > +             fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
> > +     }
> >  done:
> >       /* free() doesn't affect errno, so we don't need to restore it */
> >       free(finfo);
> > --
> > 2.30.2
> >
>
>
