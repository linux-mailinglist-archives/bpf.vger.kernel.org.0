Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC7B46F435
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 20:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhLITsk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 14:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhLITsk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Dec 2021 14:48:40 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B58AC061746
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 11:45:06 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 131so16210527ybc.7
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 11:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6A1pBLAI/+q+d47N0dS4qLy1KdbSGVNOCWIh561NQ0=;
        b=PAIvnypVtRPUhZdLSK1Emy1yyZBlYss9xkCpz4kPgNybJkPGBEYzwd2ygyP1dthUG4
         AKToNh3g3xKsmFlJ5Ks8LOvqmS34gdSASFAb+3i7rpYotATIkgS0CzWjaBYaimJPTZMw
         BwBaWmJ1YtZYOrc9j9Nj9gxXdN5RLtx5rrn8djomPi4ooB5ScGo16YPh2bQE6qQBrXZV
         WFayuNv9L94y+oHcbBToCzxGl38ZHIHWdjzgkfsH4cPhAFvm8lu9UuCPR52JLjWj+XKN
         HYr2aK4+BseSGr1DmEC7wNOWYyreEMWMMO67uootIwZXrt0Wlbxhf9ec6CU395oyVuEM
         CvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6A1pBLAI/+q+d47N0dS4qLy1KdbSGVNOCWIh561NQ0=;
        b=Dn2aQ/Vow/2qov7UjkT2Nobpi7OedsIzV3nVjD+iPGITeAA9UBvhN5z110WH3M6L6K
         x/71e32EXVt30oPn3T+p/1n3p+2H9jlILkCHL80iKU/hUWyXDwtWVL77rN9ZHhSxCCCW
         SS8Nad7bfNGxqWg9bGLMgGCRgRnVbjjnDrX4ujfUlQ1moJTq19856ggRbBZ0Y0/s+uax
         PvqnOacg4wr1aS24DBjYxR1hn/BEP6rWpqfkU0X7JIOYOCqYX/JkkniZ8jLI2jjkdqY8
         DnPBDwRTXiGrNaMKFtDSrkpqjgJKZV3VRlnJq/c/ELQpfQkl97MOTiqBKSwZEGufZ2pb
         5Qlg==
X-Gm-Message-State: AOAM531GMA8d9PGr+SlFS0vwPYByf8aLg/YVIXv/bjucVXschV3P9VkK
        BvDaOcV5Zt6AdnYHTTFQTQ/Myd/AYasFPmI8W8s=
X-Google-Smtp-Source: ABdhPJxDcyCX/vyjpD/GU8kOba1PEBQ6s0HoZJaHmoGE3jEDnc9jxbT5WsriJ8v4PSY0bx6zfF97AL5rjZeVMZerAgI=
X-Received: by 2002:a25:e406:: with SMTP id b6mr8845543ybh.529.1639079105498;
 Thu, 09 Dec 2021 11:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20211209004920.4085377-1-andrii@kernel.org> <20211209004920.4085377-2-andrii@kernel.org>
 <61b1a1844d712_ae146208b@john.notmuch> <CAEf4Bzb0Miw3uOfSDv3NRWHmMaQFFyZhOw1N8FoYYWjJ+kL1AQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb0Miw3uOfSDv3NRWHmMaQFFyZhOw1N8FoYYWjJ+kL1AQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Dec 2021 11:44:54 -0800
Message-ID: <CAEf4BzaScCJK6kC1hh5gPxxTzvMDpN3VBJzp3RW0KyAMbx3dXw@mail.gmail.com>
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

On Wed, Dec 8, 2021 at 11:01 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 8, 2021 at 10:26 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > To unify libbpf APIs behavior w.r.t. log_buf and log_level, fix
> > > bpf_prog_load() to follow the same logic as bpf_btf_load() and
> > > high-level bpf_object__load() API will follow in the subsequent patches:
> > >   - if log_level is 0 and non-NULL log_buf is provided by a user, attempt
> > >     load operation initially with no log_buf and log_level set;
> > >   - if successful, we are done, return new FD;
> > >   - on error, retry the load operation with log_level bumped to 1 and
> > >     log_buf set; this way verbose logging will be requested only when we
> > >     are sure that there is a failure, but will be fast in the
> > >     common/expected success case.
> > >
> > > Of course, user can still specify log_level > 0 from the very beginning
> > > to force log collection.
> > >
> > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> >
> > [...]
> >
> > > @@ -366,16 +368,17 @@ int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
> > >                       goto done;
> > >       }
> > >
> > > -     if (log_level || !log_buf)
> > > -             goto done;
> > > +     if (log_level == 0 && !log_buf) {
> >                               ^^^^^^^^
> >
> > with non-Null log buf? Seems comment and above are out of sync?
> >
> > Should it be, if (log_level == 0 && log_buf) { ... }
>
> Doh... yeah, it should. Apparently inverting a boolean expression is
> non-trivial :) I'll add low-level bpf_prog_load() (and maybe
> bpf_btf_load() while at it) log_buf tests to log_buf.c in selftests to
> catch something like this better, thanks for catching!

I did write selftest and of course there was another bug in
bpf_btf_load() (log_level wasn't set to 1 on retry). So yay tests.

BTW, if anyone runs into problems like "why the error is returned from
bpf() syscall if it shouldn't?", I highly recommend trying retsnoop
([0]) to save lots of time trying to pinpoint what exactly is
happening. In this case, just running

sudo ./retsnoop -e '*sys_bpf' -a ':kernel/bpf/btf.c' -a
':kernel/bpf/verifier.c' -v -n test_progs --lbr

helped to pinpoint exact log_level + log_buf check in btf_parse() that
was failing, saving tons of time and making libbpf bug obvious.

If you don't know even roughly where the problem is, use `sudo
./retsnoop -c bpf -v` (probably with --lbr to see through function
inlining, if your kernel is recent enough), this will attach to tons
of functions (1500+) and will take a bit longer to start up, but will
give you wider coverage.

  [0] https://github.com/anakryiko/retsnoop

>
> >
> > > +             /* log_level == 0 with non-NULL log_buf requires retrying on error
> > > +              * with log_level == 1 and log_buf/log_buf_size set, to get details of
> > > +              * failure
> > > +              */
> > > +             attr.log_buf = ptr_to_u64(log_buf);
> > > +             attr.log_size = log_size;
> > > +             attr.log_level = 1;
> > >
> > > -     /* Try again with log */
> > > -     log_buf[0] = 0;
> > > -     attr.log_buf = ptr_to_u64(log_buf);
> > > -     attr.log_size = log_size;
> > > -     attr.log_level = 1;
> > > -
> > > -     fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
> > > +             fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
> > > +     }
> > >  done:
> > >       /* free() doesn't affect errno, so we don't need to restore it */
> > >       free(finfo);
> > > --
> > > 2.30.2
> > >
> >
> >
