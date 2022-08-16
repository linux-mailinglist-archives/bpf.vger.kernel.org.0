Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D52596509
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 23:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiHPV6r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 17:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbiHPV6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 17:58:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A528983B
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:58:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id tl27so21417695ejc.1
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZePXSsb+bZ2CUm4HD2KZp6gtGsoBd5wLdsRrfQSCzNI=;
        b=nRvazCYgNyznAjbNVqFFzzOKMwgcRrJiFtdANXFOH+IdnbXYkAm7ErcmBWDWQ9WZ/N
         ov0XPVyq6Zy1Y7nPlKH9/4G/k2Rw1P/ME1Wpuw01zipiqt+7jx8hp4lKHy8ry43Zz4Fl
         NMai7h0DT1NNe2UA9xGXTUi0KIhOQ4Vo7Z38nGMkbkHWg6qP+BZ10aYc9tdVzjhPOdQ6
         BtILlryg4E1WRv/XBGnzC8yxP34XqmPZui417cVCLmLWk2XBQsizIqTrHR9MpTZD4c3z
         W7jD/yLU4gdjbR7rE+Ig5SoAcgmdyquZkVOvYelDrCNrVFX58OkVr0RSqjp098CQRhAk
         43Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZePXSsb+bZ2CUm4HD2KZp6gtGsoBd5wLdsRrfQSCzNI=;
        b=Igpxr9NsfXBESfDiodGbd9k/fVmGptfJNIuAuxZBcPPS7NPavSbv4clRpLp1/j6cmz
         d3H8cbul+e3e+Di1JQhM1CMZlgJ+anf5B49dYXmI4o4dgyR7Qe8u+F6hf8WKhVQSAUfD
         XdRhqvY6uoNOkCV3Aig+vhVfWjanXw+2o/fiMjs6Qkw2aIgjiFeXyuh0lJnwKg1Q5lFO
         zGjEWzWn1jArHzpdvS7pfDPi8zGUke5gVQzSFQmv0ZZiWU/XQhXqsw3atefUYQZpelhZ
         00QwNWvxqiy5sQsCdxbN+qEqib+ozqLynoqgLy2OvxQSgHSlS/tcvnBoQUIQ6aYrxB9b
         /7UQ==
X-Gm-Message-State: ACgBeo3xguNn3QAHF0+WtsB5zEissDGAKY1c/8dHb4CZMffXbesNEq9X
        2G//d7FQPx9lAbDPTpL+3cPjqNdm2rlUEMhfB2s=
X-Google-Smtp-Source: AA6agR7Vbjy21RmhY8fa8VY4vJWxO1HOQRc/XGM+a2MaOYGpSKxvgPh4L9uGxJLjbxnx35sofOft+RH4N1WozqpBG94=
X-Received: by 2002:a17:907:1361:b0:730:8f59:6434 with SMTP id
 yo1-20020a170907136100b007308f596434mr14989455ejb.745.1660687119679; Tue, 16
 Aug 2022 14:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220816001929.369487-1-andrii@kernel.org> <20220816001929.369487-5-andrii@kernel.org>
 <CA+khW7jdztV3XgdVJy7t8jwr8iheTMjQMYnioLBVX3xxBRRKjw@mail.gmail.com>
In-Reply-To: <CA+khW7jdztV3XgdVJy7t8jwr8iheTMjQMYnioLBVX3xxBRRKjw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Aug 2022 14:58:28 -0700
Message-ID: <CAEf4Bzbze6cDTaEPUY07zwj1_e2sYbNWpFb+9v=JuhuzbM2=9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: few fixes for selftests/bpf
 built in release mode
To:     Hao Luo <haoluo@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 2:34 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Aug 15, 2022 at 8:52 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Fix few issues found when building and running test_progs in release
> > mode.
> >
> > First, potentially uninitialized idx variable in xskxceiver,
> > force-initialize to zero to satisfy compiler.
> >
> > Few instances of defining uprobe trigger functions break in release mode
> > unless marked as noinline, due to being static. Add noinline to make
> > sure everything works.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> I can't say for the noinline change, I trust it works. The fix for
> uninitialized use looks good to me.

yeah, I tested noinline with both default debug (-O0) build and
release build (-O2).

noinline itself was interesting, apparently GCC doesn't support
__attribute__((noinline)) for static functions, but noinline is fine.
I was scratching my head for a while, didn't find any good explanation
and just went with `noinline`.

>
> Acked-by: Hao Luo <haoluo@google.com>
>
>
> >  tools/testing/selftests/bpf/prog_tests/attach_probe.c | 6 +++---
> >  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c   | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/task_pt_regs.c | 2 +-
> >  tools/testing/selftests/bpf/xskxceiver.c              | 2 +-
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> >

[...]
