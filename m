Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CCE4ACBDC
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 23:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbiBGWLY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 17:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbiBGWLX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 17:11:23 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CFCC061355
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 14:11:22 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id m17so12330897ilj.12
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 14:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SsOQ9LUap2p4+car5kLzEWJjUPh80TmKSTQhE7aPkoQ=;
        b=WySfExzJN78EO03XiJzMwmtN0jyYHLpiGdrnkd1fmFLZ7CCqSQ4h9Vqp99r/qrCOP1
         l29Tq7IJuxRIGkC+C+cag9yFGZxbrOMgOHT7aKL6yzH0a5yoPVubyW7C/dpIc87+kiFU
         qnbATF/g1f3iY6f/VBgPxYDGlt+7XAOQQPicshYzRa6WqGmRGLPN4XnlXGUpgNr6lHI5
         QTmEJfWyP90fjcTXc5Af4Ksf/N5PaY7uDaZkQLJaqi2yAGi2MQf5t3CVyEU87fb9afdr
         hUo0cfx3CZOsE4pLbXbj8soPb7Vx+RiTIF0dZnWzZlJyKppbe0Iz3o7wR9FR38xNkGY0
         Jdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsOQ9LUap2p4+car5kLzEWJjUPh80TmKSTQhE7aPkoQ=;
        b=J9d4TIOeHnXjO8wy2jXt0cnY/ko7OHH3jholeqdoTnihdQ5fxUWYUzH7gbXn+/1Hro
         dmA8bhvMO6ZgFPSDWO/p3EiDioWJLgyApNfTGrHvrq+9iGJd+eiRuqVjQr8zRBZc0IoX
         IsBi6gpZErXPk5QfEGuMH7lZAw5EXd2arLKFNSEWawnpeto85BEH5S8Dyc0YFKwaSUpv
         0DdE/oHHwYKysWVChc3N1qfTt1nckwj+GG87HWdc8zEjBTdXdn2ZDrUo7CyCc9GKRhwu
         sNuireVIzS6Yi2A66qc/XP8NKZm6Nts73ouyDH1JizAkPsVqchNG+mprJwVOaxwNFaGU
         XfgQ==
X-Gm-Message-State: AOAM5302Af4fhhxYsTBgg1V9LVffrFReWJVz8Qwzn9/MYccS8y+md/VL
        zfbWqOsek+7I4d1GH3a9LGKdidQC9JLHhX8HhWu1MTg1QA8=
X-Google-Smtp-Source: ABdhPJxPei5C6iZF2IcOH8/SwwIc2ZOGmdCdSzWU8oEznSYTATysXbcUXA2bBCil4TtAczo9mqJYNPRCyak+rtUpHEU=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr724459ilu.71.1644271882330;
 Mon, 07 Feb 2022 14:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20220204181146.8429-1-9erthalion6@gmail.com>
In-Reply-To: <20220204181146.8429-1-9erthalion6@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 14:11:11 -0800
Message-ID: <CAEf4BzYiT-HRn9bLy=qoyOhOQ1ESCB3mB97xt98JWapgB_nbBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] bpftool: Add bpf_cookie to link output
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
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

On Fri, Feb 4, 2022 at 10:12 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.
>
>     $ bpftool link
>     1: type 7  prog 5  bpf_cookie 123
>         pids bootstrap(87)
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Changes in v2:
>     - Display bpf_cookie in bpftool link command instead perf
>
>     Previous discussion: https://lore.kernel.org/bpf/20220127082649.12134-1-9erthalion6@gmail.com


So I think this change is pretty straightforward and I don't mind it,
but I'm not clear how this approach will scale to multi-attach kprobe
and fentry programs. For those, users will be specifying many bpf
cookies, one per each target attach function. At that point we'll have
a bunch of cookies sorted by the attach function IP (not necessarily
in the original order). I don't think it will be all that useful and
interesting to the end user. We won't be storing original function
names (too much memory for storing something that most probably won't
be ever queried), so restoring original order and original function
names will be hard. If we don't think this through, we'll end up with
kernel API that works for just one simple use case.

Can you please describe your use case which motivated this feature in
the first place to better understand the importance of this?

BTW, bpftool can technically implement this today without kernel
changes by fetching such bpf_cookies from the kernel using its pid
iterator BPF program. See skeleton/pid_iter.bpf.c for pointers. I
wonder if it would make more sense to start with doing this purely on
the bpftool side first.

As an aside (and probably something more generally useful), it seems
like we have a bpf_iter__bpf_map iterator, but we don't have prog and
link iterators implemented. Would it be a good idea to add that to the
kernel? Yonghong, Alexei, any thoughts?

>
>  include/uapi/linux/bpf.h       |  3 +++
>  kernel/bpf/syscall.c           | 13 +++++++++++++
>  tools/bpf/bpftool/link.c       |  2 ++
>  tools/include/uapi/linux/bpf.h |  3 +++
>  4 files changed, 21 insertions(+)
>

[...]
