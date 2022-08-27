Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5695A3A84
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 01:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiH0Xyy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 19:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH0Xyx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 19:54:53 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66CCE3C
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 16:54:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id n11so1081088qvr.6
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 16:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ys/YVJRyYvvPyfyr5GxVD9otRX9BvLh2Zeib8iuYg8Q=;
        b=UbdXjxMCIRfczgwnUajgI5YNM4Sseio+BaCgDvMyHg/wpvbhqo8jtFiUJJV7LVFNSz
         Tf3KtsKcXhsgzkcUTMsc/c3BeFlOE9eHVeyPzi4trdaMCuuhNCpX1ecxDUbvf7J0Y4MY
         4fQKSG1hSRDR5XbrApwSbympJxVXFYRA0pjnPJEOdXMF4JNgvY4uhHwy/5R7OzWCBE+A
         e5INwWkD6sqUHCU8zWRPwiLvZ1COoeFDk9x4z9b+ZAiQVXNMI3cjk3S7dAp+n+tk5jmF
         Ql4KyjCx97gmlZjux+Z+CsmnR/Jt//3qb/TrWLozfGlaYY5iRULtExgePgt2orzwmWOW
         qKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ys/YVJRyYvvPyfyr5GxVD9otRX9BvLh2Zeib8iuYg8Q=;
        b=ducZwss0Mp+CGYdXb9QYahyJdMEcwwUP9uKRvflTgaZjSBZFtJ5McxR+aOJ+7oYo5N
         nxvr2fKKdzL0dyFA0kAhDvFrUHf3dyIvbTy5UUH0E8dvOmm/FT0/T8S26kPeE40YCYtO
         jv7f7ffREu4XCqrBcinLiRutSo2tTx4dAYz/po4RYJu9uKE9RYFsKA2VkIQtvkKJXzz7
         V2TJT4aWKRUFmTublAjWxHMfZiHIog2TKdYmO/+rdlyIzvVngNRe+SKuSXOWtRXIOKSm
         yudBthvmKppXbWZIR/poHHUzo1ma42NSh9CUbf/Zvhq5iZJ1r737wb9O5RXe53NpqFGX
         rAVQ==
X-Gm-Message-State: ACgBeo0m4GdP4TVqTa7OCQnwWClx9riAkh46e0c0vgbF7fULWRuhMClH
        bJs9ZCs6KfkJIeFJCTtec0SbRAa2NWk8xf4yyWd/+A==
X-Google-Smtp-Source: AA6agR6paO8TSXPWJbCb0RSjAjcT4eqbedQTCP9nJqP1kKtigKw0xr3dg2/J+7227v5cuP1n2e07rbWngIEtLjr7DJ0=
X-Received: by 2002:ad4:5de7:0:b0:496:d0f8:7000 with SMTP id
 jn7-20020ad45de7000000b00496d0f87000mr5299218qvb.12.1661644489878; Sat, 27
 Aug 2022 16:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220824033837.458197-1-weiyongjun1@huawei.com>
 <b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com> <CAEf4BzafSAZfhkun5PBGODw6v1s10Nh4JeH8azdqZY-62kBCKg@mail.gmail.com>
 <ee620e99-dc04-aa2c-f53b-b875dba79feb@isovalent.com> <CAEf4BzbmaUygfMK_JZ7Q8UWNFLH-pGHJ_6LMy=M-CQOC7o2LRw@mail.gmail.com>
In-Reply-To: <CAEf4BzbmaUygfMK_JZ7Q8UWNFLH-pGHJ_6LMy=M-CQOC7o2LRw@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Sun, 28 Aug 2022 00:54:38 +0100
Message-ID: <CACdoK4LYKA7xw17bVF40jvRdqwMK77Cjn_7CHtZvu5FEwUz75A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: implement perf attach command
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 27 Aug 2022 at 06:12, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 26, 2022 at 3:45 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > Hi Andrii,
> >
> > On 25/08/2022 19:37, Andrii Nakryiko wrote:
> > > On Thu, Aug 25, 2022 at 8:28 AM Quentin Monnet <quentin@isovalent.com> wrote:
> > >>
> > >> Hi Wei,
> > >>
> > >> Apologies for failing to answer to your previous email and for the delay
> > >> on this one, I just found out GMail had classified them as spam :(.
> > >>
> > >> So as for your last message, yes: your understanding of my previous
> > >> answer was correct. Thanks for the patch below! Some comments inline.
> > >>
> > >
> > > Do we really want to add such a specific command to bpftool that would
> > > attach BPF object files with programs of only RAW_TRACEPOINT and
> > > RAW_TRACEPOINT_WRITABLE type?
> > >
> > > I could understand if we added something that would be equivalent of
> > > BPF skeleton's auto-attach method. That would make sense in some
> > > contexts, especially for some quick testing and validation, to avoid
> > > writing (a rather simple) user-space loading code.
> >
> > Do you mean loading and attaching in a single step, or keeping the
> > possibility to load first as in the current proposal?
> >
> > >
> > > But "perf attach" for raw_tp programs only? Seem way too limited and
> > > specific, just adding bloat to bpftool, IMO.
> >
> > We already support attaching some kinds of program types through
> > "prog|cgroup|net attach". Here I thought we could add support for other
> > types as a follow-up, but thinking again, you're probably right, it
> > would be best if all the types were supported from the start. Wei, have
> > you looked into how much work it would be to add support for
> > tracepoints, k(ret)probes, u(ret)probes as well? The code should be
> > mostly identical?
>
> Are you thinking to allow to attach individual BPF programs within BPF
> object, i.e., effectively bpftool as an interface to libbpf's
> bpf_program__attach()?
>
> Or you had more of BPF skeleton's auto-attach that attaches all
> auto-attachable BPF programs?

Here I was thinking the former, to have the support for tracing
programs catch up with networking/cgroup programs that can be attached
with bpftool already.

Although for the future I'm also considering the second option, where
we could pass an option to "bpftool prog load" to tell it to attach
everything it can. Not sure yet, there are some similarities between
the two (and my guess is you would find it too much?), but they're not
exactly the same use case either.
