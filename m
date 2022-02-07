Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6704F4ACB81
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 22:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbiBGVnm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 16:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiBGVni (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 16:43:38 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4CDC061355
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 13:43:38 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id p11so6171062ils.1
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 13:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+Uo/c3yfwy+ORo718JEWq4Vrj0UTt/vYS/jXPeFs54=;
        b=GgLvpbH6ZyUkYIOaOE/WMlODSWZnS4k0mKPWmknq3hfd07TX3BHgV9vMgW89XU0kdz
         duJWdb/2Y8oFh/CS8s8n3X/Iq1xH4qAfVAhr9M69KhPRRarT51IkaXhFFEkAYkARgi0S
         2k34h6ys5JVQuCvn51st8TIHksRj57adE4twQvnEOtvJAXsXrfe0BCwveLefZcEoT+xt
         zythxPm1ykPLi8feqQbVxUx62w8h4sbN4+aeQu3vx5ftb5P0GKYjREzzHHm3Z8ihxeR0
         ksNltRp8ZlHySWJj3ddjd11nS6iBTfJ6aRV74T9qcInqcDkq92VU3gXZ37WOlYCziuip
         bKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+Uo/c3yfwy+ORo718JEWq4Vrj0UTt/vYS/jXPeFs54=;
        b=tWJ7ZSQHSdnqDJtpsSzz3cTGq2sI5HZ16XkNS7FQLhkYoSM3pNuHQsnShflqNnqrn/
         963FRgWSSoWfFduldCz+9pe0CkjWYCLz+cQeLRf0X4pnJ1eVNKi9yOgNs51o2eQZ4Vzg
         wCQEw7cIR4M5xztfeKJSSF4GMY+PQXHoTWzEQ+Wg09LqyILCpbXCt26apNZXLI/k/Z66
         AoTU88x/4FEYuMSqUt62mePYZkSLF+A4xGZF+bfjgJ/KUwP3H2TUB8YJ/2MsCOgMkB+c
         ++OWCCSOcYHjKMBThoUD4iG9GU2LPrYDjv0OeN1lvoMed5j0w9dQAw+qKC4LZC8cYbj7
         XonQ==
X-Gm-Message-State: AOAM531mjihlikZyzvUFkJcYtZYNQ4IpMHwlGVNIHhIqSuzaw8xT4eBy
        yHIRKLK0QC25ZIrMrA+D+1P4T4RNHepD6lAn8r0=
X-Google-Smtp-Source: ABdhPJwKIPyoe3ucQAGTt/GGkakKpVaxYdE/hc3q/J1yKOFZJE91id+ZDj2DAw7pOVfpBytjNimOlx/4tzQF3R9J+tw=
X-Received: by 2002:a05:6e02:2163:: with SMTP id s3mr673152ilv.252.1644270217475;
 Mon, 07 Feb 2022 13:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20220205012705.1077708-1-andrii@kernel.org> <20220205012705.1077708-5-andrii@kernel.org>
 <alpine.LRH.2.23.451.2202071400210.9037@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2202071400210.9037@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 13:43:26 -0800
Message-ID: <CAEf4BzbX2=iRmPSV-et+KBY7rd5Q+n1ptcbvJ32k6s97x+vW6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add custom SEC() handling selftest
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Feb 7, 2022 at 6:21 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Sat, 5 Feb 2022, Andrii Nakryiko wrote:
>
> > Add a selftest validating various aspects of libbpf's handling of custom
> > SEC() handlers. It also demonstrates how libraries can ensure very early
> > callbacks registration and unregistration using
> > __attribute__((constructor))/__attribute__((destructor)) functions.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> A few suggestions here for additional tests, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> Should we override a default attach method to demonstrate that
> custom handlers can do that? Or would that break parallel
> testing mode?

Yep, I should. I was a bit lazy and wanted some feedback before adding
more tests. I'll add some kprobe overload to auto-attach to sys_enter
or something like that. If I do that during the test (not in
constructor/destructor), it won't interfere with parallel tests (they
each run in a different process).

>
> Also might be good to have a test that captured the difference
> in auto-attach behaviour between a skeleton attach and an
> explicit bpf_prog__attach(); running the bpf_prog__attach on the
> SEC("xyz") should result in -EOPNOTSUPP.

Sure, can add that as well.

>
>
> > ---
> >  .../bpf/prog_tests/custom_sec_handlers.c      | 136 ++++++++++++++++++
> >  .../bpf/progs/test_custom_sec_handlers.c      |  51 +++++++
> >  2 files changed, 187 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> >

[...]
