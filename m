Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E626E1976
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 03:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDNBM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 21:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDNBM5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 21:12:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A33AAE
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 18:12:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q23so32359667ejz.3
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 18:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681434772; x=1684026772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wcplw41LBfJXP8hUr9XGdVk7vhV6LbpO0EMg2XPC8VE=;
        b=az68cK04jwzuYx32bsPk2B8rX61mccW5wj++etdo/AIBD82882ezECAt0gKGj20mcq
         jA5F0BiwKrbF06FMPQ76lIv6pFtjCULMgSvG8nNyWgJnXl4U9Z32FtCv+YW/VniXz8yC
         gbmJgZXGj1B1ESPTNLC1Xrdsg2SrQiXnrPQrLIp3zMHVQH2zwo4CxI8y3LoQBgavWYzQ
         ZSVvj/jeW1YURgax1y9db5POdqzmccxd33+L/0jeRxF6xHkcrmUsVGXRap46UH42Q4vl
         TWzI1KZakJi7VTT3ntKeBJ3ou31+jUWYGUPfh4Ck5b05C6y8l4iOUHMzh9zHWF335O3M
         r4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681434772; x=1684026772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcplw41LBfJXP8hUr9XGdVk7vhV6LbpO0EMg2XPC8VE=;
        b=jX5JItAp09FSr57Wn9SyTknT9Tc9qjeIrrrh9RprAUzNXl5ZWbbJAZm45XICQdpKEe
         Z1wgNGHjVqLp6vWkOhXsf17CcsHnQC+TjccWE9TvdZ44F7RQYw8bceOX5vzSQp0ajGEe
         42hgCcfR5bNS6HEqmJ8DihudkgOm6gwbdZ/9p/NsMkm2Xwx8rlqA1AH7JNYtx1Pl3+OS
         4qDQu4fB08V0+6gua9sm+yRrb17FOufafbSa/S1IGs8Y0mSeuW3f2J7/JpwWlRE+VwX8
         FGFNx6AOeRv8+dzD9FWSnBN1WDarUtbrgc9gT62R3851phMlsiHi4iWcg1r3YI/lZrtU
         t1pQ==
X-Gm-Message-State: AAQBX9ePbpz7quMdG5eguRRi9hEUOFeBmtTwymtmwtWGdeO1Bj4ddvFv
        m2d1G57gM3Hqwni1ZOUX821UA+p10NjOofA/MlHMGA==
X-Google-Smtp-Source: AKy350ZINmTS4NdHqVS9IwLjAWEA7ghxO8OVwCxQuuWqxFLfNWLI+HCGcYbi8GjYU0ooMgrq4Elj1HHUPc3GTNrMgVQ=
X-Received: by 2002:a17:906:80c:b0:92e:a234:110a with SMTP id
 e12-20020a170906080c00b0092ea234110amr2190683ejd.3.1681434771687; Thu, 13 Apr
 2023 18:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <ZDfKBPXDQxH8HeX9@syu-laptop> <ZDfQYHJyJOrR5pcB@syu-laptop>
In-Reply-To: <ZDfQYHJyJOrR5pcB@syu-laptop>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Fri, 14 Apr 2023 02:12:40 +0100
Message-ID: <CACdoK4JemtGV9m=kuddE4eZQgfTNj1OqhwfhLpDcsspTvfZx7A@mail.gmail.com>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 13 Apr 2023 at 10:50, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> On Thu, Apr 13, 2023 at 05:23:16PM +0800, Shung-Hsi Yu wrote:
> > Hi,
> >
> > I'm considering switch to bpftool's mirror on GitHub for packaging (instead
> > of using the source found in kernel), but realize that it should goes
> > hand-in-hand with how libbpf is packaged, which eventually leads these
> > questions:
> >
> >   What is the suggested approach for packaging bpftool and libbpf?
> >   Which source is preferred, GitHub or kernel?
>
> An off-topic, yet somewhat related question that I also tried to figure out
> is "why the GitHub mirror for libbpf and bpftool exist at the first place?".
> It is a non-trivial amount of work for the maintainers after all.
>
> For libbpf, the main uses case for GitHub seem to be for it to be used as
> submodule for other projects (e.g. pahole[1]), and that alone seem to suffice.

Then it should be enough for bpftool, too :) The bcc repository uses
it as a submodule, for example.

The work is non-trivial, but when compared to libbpf, I managed to
preserve most of the Makefile from the kernel tree and all of the C
code, and bpftool also gets patches less often.

>
> For bpftool the reason seems to be less clear[2]. From what I can tell right
> now its mainly use for CI (this applies to libbpf as well), which is
> definitely useful.

Yes. At the moment, the CI present on bpftool's mirror is more limited
than libbpf's. But it allows me to test some compilation variants:
regular builds, static builds, cross-compiling (to some extent). Some
additional checks that would make little sense to have in the kernel
repo, too. It's mostly for checking that none of these build
configurations break when I sync from the kernel, and helped me find
and fix several issues in the build system on the mirror.

This CI on the mirror doesn't cover bpftool's features, but these
should be tested in the BPF CI itself, so we can catch regressions
before patches are merged. There are some tests already, not many, I'd
like to improve that someday. Anyway.

>
> But I wonder whether packaging one of the motives to create the mirrors
> initially? Can't seem to find anything in this regard.
>
>
> 1: https://github.com/acmel/dwarves/tree/master/lib
> 2: https://lore.kernel.org/bpf/CAEf4BzZ+0XpH_zJ0P78vjzmFAH3kGZ21w3-LcSEG=B=+ZQWJ=w@mail.gmail.com/

It seems like you haven't come across this one?:
https://lore.kernel.org/bpf/267a35a6-a045-c025-c2d9-78afbf6fc325@isovalent.com/t/

Yes, easing packaging was one of the motivations for the mirror. As
mentioned in my other answer, I've not taken the time to reach out to
package maintainers yet, so this hasn't really materialised at this
point.

CI, indeed, was another motivation.

Submodules, or simply making it easier to hack with bpftool's code,
was yet another thing. Microsoft folks intend to make bpftool
compatible with eBPF for Windows. It's quite simpler to work on that
from a repo which is mostly uncoupled from the Linux tree.

Perhaps the most important was to make it easier to just download,
build and use bpftool, for all users who need to get the latest
version, or to patch it, or to create static builds, or to
cross-compile, or whatever reason might cause you to compile it from
the sources. For all those cases, getting the mirror is faster and
requires less space than getting the kernel repo. This makes a nice
difference when periodically rebuilding images in automated workflows,
for example.

Does this answer your questions?
Quentin
