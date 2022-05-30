Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE7D53750C
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 09:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiE3GBF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 May 2022 02:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiE3GBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 May 2022 02:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5B70918;
        Sun, 29 May 2022 23:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6ADB61024;
        Mon, 30 May 2022 06:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C7CC3411A;
        Mon, 30 May 2022 06:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653890460;
        bh=9+vUpzH4zsiyF0ITGPYTsdIpRtxFGEOt+NDBCWSgyyk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kKx1QfL1RswEhDE4PDvaBIeKJDbfN2dG81BAsTb5bH5xuXKJX/bOWu13SFjiWgmVi
         Q9/Zyvj+E7r995uILsme/TtOZ6ClerEPr2gs6lRCEVQ0kIF74iAgxDl3vvO6A+ev2y
         ABVcwurHMwILkKT72jBXEYzJ6e6U3Huuob3BscWktyLZRezFkO/V63lLEVvzKYtYjf
         peYudkP/MORSnoyN/3NuMB8DvQ88PdT9yjWezxrfexBvSZKdOYVL6oSWpY9oM8WcId
         RRAKa2ZQrRjh0FU+e6NIdrhCFXkJzAFgWigCYQ7nyOWd1rg9gnYhyILjSF0Ja6owJb
         EJjYlQxJKr53A==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ef5380669cso98522897b3.9;
        Sun, 29 May 2022 23:01:00 -0700 (PDT)
X-Gm-Message-State: AOAM531S5mxlZHUJoHJJyeun48TP9N1wHIH0qrzAUcDsJvHxGAwiDydh
        IYhBB2usPsrHAnNAVrN1FJPmUIGHqJQG/DKfdWY=
X-Google-Smtp-Source: ABdhPJyjtBLOhvEqAAeBCCeTEpbnyG04Vh+WYS5z348W9bswsw2cybWqNOk7hZyzPv5sTvUV/au1yjK/yVrhxIXr2A8=
X-Received: by 2002:a81:5a87:0:b0:2ec:239:d1e with SMTP id o129-20020a815a87000000b002ec02390d1emr55732305ywb.211.1653890459185;
 Sun, 29 May 2022 23:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1653861287.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1653861287.git.dxu@dxuuu.xyz>
From:   Song Liu <song@kernel.org>
Date:   Sun, 29 May 2022 23:00:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4nC_7L48aMJfNPcx69O6JtS7zk8p2=4Vro2S1608dztw@mail.gmail.com>
Message-ID: <CAPhsuW4nC_7L48aMJfNPcx69O6JtS7zk8p2=4Vro2S1608dztw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Add PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 29, 2022 at 3:06 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This patchset adds PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE progs.
> On top of being generally useful for unit testing kprobe progs, this
> feature more specifically helps solve a relability problem with bpftrace
> BEGIN and END probes.
>
> BEGIN and END probes are run exactly once at the beginning and end of a
> bpftrace tracing session, respectively. bpftrace currently implements
> the probes by creating two dummy functions and attaching the BEGIN and
> END progs, if defined, to those functions and calling the dummy
> functions as appropriate. This works pretty well most of the time except
> for when distros strip symbols from bpftrace. Every now and then this
> happens and users get confused. Having PROG_TEST_RUN support will help
> solve this issue by allowing us to directly trigger uprobes from
> userspace.
>
> Admittedly, this is a pretty specific problem and could probably be
> solved other ways. However, PROG_TEST_RUN also makes unit testing more
> convenient, especially as users start building more complex tracing
> applications. So I see this as killing two birds with one stone.

We have BPF_PROG_RUN which is an alias of BPF_PROG_TEST_RUN. I guess
that's a better name for the BEGIN/END use case.

Have you checked out bpf_prog_test_run_raw_tp()? AFAICT, it works as good as
kprobe for this use case.

Thanks,
Song
