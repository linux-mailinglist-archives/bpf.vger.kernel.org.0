Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9F469116F
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 20:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBIThQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 14:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBIThP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 14:37:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF887457E6
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 11:37:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q19so3075119edd.2
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 11:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P7r35QariJt8FIr4ScLxkbJGD85TFr5FAmlYiYMamss=;
        b=YHYqeUT3PrKOEUdIeG3y7x3oS1PQQ7T9scaXc9USxv+pev7LLweGIihh58Xe4wNigs
         QYW2ooScjkTYHi+Ju52tl+bRUQJ15Zih29FU3VBEWC+ZSjL4o4VLk4JfbHgQ4QYnv4Qz
         M2H1NffzNmJIhl21sUKfBpJV7FJzMFy2/xdiJwXagPD3AWo7hxuk9HS65kMWJma73+bY
         A7A53f2kqOC++bl8KagHQjHlWRxdteedjb2UTGEAyzhLdkttzNRVq3olNp22V2KOcmc2
         MZMdwwBp2fQx+8XoW8jxjrOi7L/fjltyv0CHr/evFzg3G8cICKSoZvGmBNNzI3ttlZpD
         wbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7r35QariJt8FIr4ScLxkbJGD85TFr5FAmlYiYMamss=;
        b=OhmhIWggI/Ux0+TPmvWOXdCOW4VFJ9MD7Ysq2Hl+8lQN3H3ejtluv7rR7dePlLPyN7
         GWcC1B4w3CfITH7FHT4TFSxx2rHmQInARRBF0cvEDhIJ/ZIAuu8wYIfnNRyj7mSgEJRL
         XgGzbb6RNQtBFbr7WGERiSoJM8kCTsUlKO3EieDxuYkBmJtxSIqLyhAqfqnsQH1ZxoOl
         spXoY8aFs+iUX8flXnMc9nH/LPbmvinUh49EJn8CCH5eJOQrCo92w9DgjEquTakZBlRg
         LXILEg0x/PCAYnJiIlDK6fUN5DfSaMkwI1vi/GLJcD66KlREzW5R9nY3N+BTtsZ/wPlm
         FTsA==
X-Gm-Message-State: AO0yUKV1jhzq/NSCyfsAVi7f42k0LmilHBPS4bkBVNPlWvshn4cZZkzj
        Ae4txgIRru9mT4kdavOfxFhpJU+PcSR/3vMFc2pCTLx1i9o=
X-Google-Smtp-Source: AK7set/jNw24CiPXthayvx8RKlCV0I/HXqw/5q13dyoCKMzApNgqJcgOEczl4xwGDIw8mBROzO5lsUPHl+/NeSCPgFQ=
X-Received: by 2002:a05:6402:2420:b0:4ab:1f1b:95a1 with SMTP id
 t32-20020a056402242000b004ab1f1b95a1mr709318eda.0.1675971432401; Thu, 09 Feb
 2023 11:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20230208205642.270567-1-iii@linux.ibm.com> <20230208205642.270567-9-iii@linux.ibm.com>
 <CAEf4BzYCNNROXcEx5w3St6TLWS3YP4C6_uCWfgfS3t_p5uaxyQ@mail.gmail.com> <f1731f2b3008964d3c7c8c25c5a4d8799ac10c57.camel@linux.ibm.com>
In-Reply-To: <f1731f2b3008964d3c7c8c25c5a4d8799ac10c57.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Feb 2023 11:37:00 -0800
Message-ID: <CAEf4BzbToAz40eCBoGTeN67pStmkj7zLSWvetKO1xHRj1b4C9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/9] libbpf: Add MSan annotations
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 9, 2023 at 2:02 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2023-02-08 at 17:29 -0800, Andrii Nakryiko wrote:
> > On Wed, Feb 8, 2023 at 12:57 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > MSan runs into a few false positives in libbpf. They all come from
> > > the
> > > fact that MSan does not know anything about the bpf syscall,
> > > particularly, what it writes to.
> > >
> > > Add libbpf_mark_defined() function to mark memory modified by the
> > > bpf
> > > syscall. Use the abstract name (it could be e.g.
> > > libbpf_msan_unpoison()), because it can be used for valgrind in the
> > > future as well.
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> >
> > This is a lot to satisfy MSan, especially mark_map_value_defined
> > which
> > has to do bpf_obj_get_info_by_fd()... Is there any other way? What
> > happens if we don't do it?
>
> It would generate false positives when accessing the resulting map
> values, which is not nice. The main complexity in this case comes not
> from mark_map_value_defined() per se, but from the fact that we don't
> know the value size, especially for percpu maps.
>
> I toyed with the idea to extend the BPF_MAP_LOOKUP_ELEM interface to
> return the number of bytes written, but decided against it - the only
> user of this would be MSan, and at least for the beginning it's better
> to have extra complexity in userspace, rather than in kernel.

yep, I know, it's a source of very confusing problems in some cases.
Which is why bpf_map__lookup_elem() and such expect user to provide
total key/value size (and checks it against struct bpf_map's knowledge
of key/value size, taking into account if map is per-CPU)

Ok, I don't see any other way around this as well. Just please extract
this check of whether the map is per-cpu or not into a separate
helper, so we can maintain this list in only one place. Currently we
have this check in validate_map_op() and I don't want to duplicate
this.

>
> > As for libbpf_mark_defined, wouldn't it be cleaner to teach it to
> > handle NULL pointer and/or zero size transparently? Also, we can have
> > libbpf_mark_defined_if(void *ptr, size_t sz, bool cond), so in code
> > we
> > don't have to have those explicit if conditions. Instead of:
> >
> > > +       if (!ret && prog_ids)
> > > +               libbpf_mark_defined(prog_ids,
> > > +                                   attr.query.prog_cnt *
> > > sizeof(*prog_ids));
> >
> > we can write just
> >
> > libbpf_mark_defined_if(prog_ids, attr.query.prog_cnt *
> > sizeof(*prog_ids), ret == 0);
> >
> > ?
> >
> > Should we also call a helper something like
> > 'libbpf_mark_mem_written',
> > because that's what we are saying here, right?
>
> Sure, all this sounds reasonable. Will do.
>
> >
> > >  tools/lib/bpf/bpf.c             | 70
> > > +++++++++++++++++++++++++++++++--
> > >  tools/lib/bpf/btf.c             |  1 +
> > >  tools/lib/bpf/libbpf.c          |  1 +
> > >  tools/lib/bpf/libbpf_internal.h | 14 +++++++
> > >  4 files changed, 82 insertions(+), 4 deletions(-)
> > >
> >
> > [...]
> >
> > > diff --git a/tools/lib/bpf/libbpf_internal.h
> > > b/tools/lib/bpf/libbpf_internal.h
> > > index fbaf68335394..4e4622f66fdf 100644
> > > --- a/tools/lib/bpf/libbpf_internal.h
> > > +++ b/tools/lib/bpf/libbpf_internal.h
> > > @@ -577,4 +577,18 @@ static inline bool is_pow_of_2(size_t x)
> > >  #define PROG_LOAD_ATTEMPTS 5
> > >  int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int
> > > attempts);
> > >
> > > +#if defined(__has_feature)
> > > +#if __has_feature(memory_sanitizer)
> > > +#define LIBBPF_MSAN
> > > +#endif
> > > +#endif
> > > +
> > > +#ifdef LIBBPF_MSAN
> >
> > would below work:
> >
> > #if defined(__has_feature) && __has_feature(memory_sanitizer)
> >
> > ?
> >
> > > +#define HAVE_LIBBPF_MARK_DEFINED
> > > +#include <sanitizer/msan_interface.h>
> > > +#define libbpf_mark_defined __msan_unpoison
> > > +#else
> > > +static inline void libbpf_mark_defined(void *s, size_t n) {}
> > > +#endif
> > > +
> > >  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> > > --
> > > 2.39.1
> > >
>
