Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A9539BF0
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 06:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiFAELR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 00:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFAELO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 00:11:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7950E90CE1
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 21:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35887B815FB
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 04:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4795C36AE3
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 04:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654056670;
        bh=OyBxYFh4f/71XBJUEuQEiIIvQazODRG3fkYzsjVuQ2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K8mGaQXNqnMVShFGchDDCi/hiv5zsXPviwbPvQZD7O6+elAaLkWRARqGQIzYR1KDP
         teLVoQpEnDkvaZ2av29y+SZFAUm6q5kVCL446l0YLl1UGlbZ2pRjxRr8IMwL9FXq3v
         jb5kKDvxT+5GjfrpKJuGYrPShAvmUoN/9sAwZXusdGDYwNPMOyyxAoikeo5HcJUX+P
         4rhvAe3o8fo9SVYPN5oQPUN+51wJzf/bQBhlQh/L3+GH3bXaKmwDRUeza/9rh4lCWa
         ERpPhMCoLaGChbJzHKg/Weunmw1fy+OodPI7WZ7uZq8ltrC9KGW6TMRi91T0FPUiQg
         M9xGncPMDjMoQ==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-306b5b452b1so5690547b3.1
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 21:11:10 -0700 (PDT)
X-Gm-Message-State: AOAM531lm2X3uG6l68nCUn/LjfVle/7226KnNoLUBLI/zW2Z1VqmAwiu
        6rMdKU4OVHy3/4IZFxEpernUwlZTA/qbc7PAh2U=
X-Google-Smtp-Source: ABdhPJxVD0KN8f7qQWalEeuDUpvQuBoSFJma4sKlcnDu28cj/aO8fncUrHvRX9Y4oleKzwW8Zqrh9oZqWX/72ri1lzE=
X-Received: by 2002:a0d:eb4d:0:b0:30c:9849:27a1 with SMTP id
 u74-20020a0deb4d000000b0030c984927a1mr9505602ywe.472.1654056669852; Tue, 31
 May 2022 21:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220529223646.862464-1-eddyz87@gmail.com> <20220529223646.862464-3-eddyz87@gmail.com>
 <CAPhsuW7wwt+J=oHXeB_8s8Tu63dzgODh56aCFPv-Vp43bofutA@mail.gmail.com> <b517e19ffbd19b24b630cdeafdb4adb444a8dd56.camel@gmail.com>
In-Reply-To: <b517e19ffbd19b24b630cdeafdb4adb444a8dd56.camel@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 31 May 2022 21:10:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7drtkMj_Yh6FaoGzfAg7K2q4Bpb4a3oG+w0qqACZMo=w@mail.gmail.com>
Message-ID: <CAPhsuW7drtkMj_Yh6FaoGzfAg7K2q4Bpb4a3oG+w0qqACZMo=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: allow BTF specs and func
 infos in test_verifier tests
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 31, 2022 at 4:20 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> > On Tue, 2022-05-31 at 13:52 -0700, Song Liu wrote:
>
> Hi Song,
>
> Thanks a lot for the review, I'll apply the suggested changes and
> provide the v3 in one or two days. My only objection is below.
>
> > >  {
> > > -       int fd_prog, expected_ret, alignment_prevented_execution;
> > > +       int fd_prog, btf_fd, expected_ret, alignment_prevented_execution;
> > >         int prog_len, prog_type = test->prog_type;
> > >         struct bpf_insn *prog = test->insns;
> > >         LIBBPF_OPTS(bpf_prog_load_opts, opts);        __u32 pflags;
> > >         int i, err;
> > >
> > > +       fd_prog = -1;
> >
> > This is not really necessary.
>
> Actually this one is necessary to avoid compiler warning, note the
> following fragment of the do_test_single function below:
>
> static void do_test_single(...)
> {
>         ...
>         if (...) {
>                 btf_fd = load_btf_for_test(...);
>                 if (btf_fd < 0)
>                         goto fail_log;
>                 opts.prog_btf_fd = btf_fd;
>         }
>         ...
>         fd_prog = bpf_prog_load(..., &opts);
>         ...
> close_fds:
>         ...
>         close(fd_prog);
>         close(btf_fd);
>         ...
>         return;
> fail_log:
>         ...
>         goto close_fds;
> }
>
> If load_btf_for_test fails the goto fail_log would eventually jump to
> close_fds, where fd_prog would be in an uninitialised state.

Got it. Thanks for the explanation!

Song
