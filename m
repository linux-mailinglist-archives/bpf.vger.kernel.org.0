Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED77623030
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 17:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiKIQc1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 11:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKIQc0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 11:32:26 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE54C19C0A
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 08:32:25 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id gw22so17206465pjb.3
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 08:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmPZM+ck5t49vl2nen2+qwHlesdw+y9rtemVG3D5bFw=;
        b=bqF92Gv5R3C5AUt7rmOlXV8WHqBSS6t57BYlfCa2Groc9nu/mSlF/J2Bw8lLXZpsoY
         LQPgKGZHLDG8FUL3uWlbTQvlKLNht4O4rQ1rI3DoGQAc0E2JvVljP0hdgsp4mSLQDdQM
         bMdvwXg0+x6PeE1CspTjBr5xEfb1k9CK+8eNYWmbWUYUQd9wqZPocmvXgX2puau+w04q
         94zlhJ1M6jKkEz10QmZ1GVDwxSCg9qTWAxXdjKFAVI+6Umh9xu2sbfNpEJqPJSNEOEx9
         slsxfBbDbk3Mrl2jWphWH7usn8L4owIyfHzTGkcaR0Nb7uyJAGVX/NIeLpoQP4HLccEo
         DJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmPZM+ck5t49vl2nen2+qwHlesdw+y9rtemVG3D5bFw=;
        b=DCQ6SK7xqThOy3FCgmE+mJVCpXa+b0yVNLHMBVZHQLr4X5rlh4+NydVV3qSmqnpPVf
         X05wyE2xUWhHxEAikElRrM9Olu6WsDQbZNHMVNy9Cd7Qme+vwly1eB+8RAinDepiKT4S
         X8/pmXilK+kKf6fcF0tTSCTCCN3N+fYNVQASGAgbPYItGxnb2q074T/Q8e3rOeom0knw
         oER+EpH54jYfuyapQ7sJGdfTnas1WG0gsRCyid3vMWsmXJn/Ffzs2kJVqF0PXw/Bzq3I
         a0PuDx6QIuuMKjpGQtt0jtUkeFDOPh4+RCBoup1Oe3m+qwdnHaYNBqHL6dKUl6NfhM3z
         cQZQ==
X-Gm-Message-State: ACrzQf0b78wGUz5qFwPvaDrFzhUAY8iXdWt1PG2ZiWETyaMXAuL4iyFt
        PnP9wMJ1oNjbDsuz2nUBNaIAg/WKhFv3yQ==
X-Google-Smtp-Source: AMsMyM6CDw1mNwMIjwpSvLtCizwVIau0aK2rCOJSvNi/2s7fAtgH1xLB8cPi28wm9IYBCTZG3QFHNQ==
X-Received: by 2002:a17:902:e84a:b0:186:b8ff:c698 with SMTP id t10-20020a170902e84a00b00186b8ffc698mr61606768plg.143.1668011545097;
        Wed, 09 Nov 2022 08:32:25 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902ed0200b00183ba0fd54dsm9237578pld.262.2022.11.09.08.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:32:24 -0800 (PST)
Date:   Wed, 9 Nov 2022 22:02:19 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v5 22/25] selftests/bpf: Update spinlock selftest
Message-ID: <20221109163219.on5vdlzqisy2z7k5@apollo>
References: <20221107230950.7117-1-memxor@gmail.com>
 <20221107230950.7117-23-memxor@gmail.com>
 <CAEf4BzbpLYCxXe+k4Hq_Dy0GbqKL-70t_ad4-pdqBzdojLp2uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbpLYCxXe+k4Hq_Dy0GbqKL-70t_ad4-pdqBzdojLp2uA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 05:43:34AM IST, Andrii Nakryiko wrote:
> On Mon, Nov 7, 2022 at 3:11 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Make updates in preparation for adding more test cases to this selftest:
> > - Convert from CHECK_ to ASSERT macros.
> > - Use BPF skeleton
> > - Fix typo sping -> spin
> > - Rename spinlock.c -> spin_lock.c
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/spin_lock.c      | 46 +++++++++++++++++++
> >  .../selftests/bpf/prog_tests/spinlock.c       | 45 ------------------
> >  .../selftests/bpf/progs/test_spin_lock.c      |  4 +-
> >  3 files changed, 48 insertions(+), 47 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/spin_lock.c
> >  delete mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c
> >
>
> [...]
>
> > +void test_spinlock(void)
> > +{
> > +       struct test_spin_lock *skel;
> > +       pthread_t thread_id[4];
> > +       int prog_fd, i;
> > +       void *ret;
> > +
> > +       skel = test_spin_lock__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "test_spin_lock__open_and_load"))
> > +               return;
> > +       prog_fd = bpf_program__fd(skel->progs.bpf_spin_lock_test);
> > +       for (i = 0; i < 4; i++)
> > +               if (!ASSERT_OK(pthread_create(&thread_id[i], NULL,
> > +                                             &spin_lock_thread, &prog_fd), "pthread_create"))
>
> I mean... does that pthread_create() call have to happen inside ASSERT_OK?
>
> err = pthread_create(...)
> if (!ASSERT_OK(err, "pthread_create"))
>     goto end;
>

Ack, I'll rewrite it like this.
