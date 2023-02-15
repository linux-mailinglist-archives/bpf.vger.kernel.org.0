Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4670697628
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 07:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjBOGL4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 01:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjBOGLz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 01:11:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3D533461
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 22:11:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id bt8so14657573edb.12
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 22:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ht8FGw9JUv4WWXRXnq5VS71Prp5bIgMzWnh988Lpztw=;
        b=ZgSY92aIrxaB1q95sDtS9sDuIAN8cb7h5jkZWi6zypElN4fjEU39Ne4w0xTRbKusFM
         NJQRpOvwJJZUi76d6rCjnnmLSUefIO/cW1bFgyFGnLgvzuAPaeA+RUcltD8dHXrtZVgR
         YaXn7g9IKH7gULoSSDj9ggcYHrRGPXAEc38RFbKPyiMoVUFGpc6s2zY5k/DnHGBwfoAA
         krPOoBMprsY5enFmFZigk6Rou5vtzBt1w6b00kSB6twzWODsMp3FLktto6HPXZs3PKIf
         jDOEDViovsim2fuatRCUc8f8jF/PdpIbnQxT7FmauhBfv0dVRvY8LPFliHNUhSXhzlsF
         LWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ht8FGw9JUv4WWXRXnq5VS71Prp5bIgMzWnh988Lpztw=;
        b=1TYm7Ilhh0kn/wDKudjJz+8SkasXeJDjnVUCymi19QHky6zbZX/eMaxDiiTcSAxKXR
         JGUxlqJqF6EQsr8QjK7FD1s7sS5JTuZ8QU556+sYXYOgT6IZc+3FHFsx5MX1rtv27FI4
         Onv1grOruyDgpQUkZPIEVWT8/hug7EFEAT/xjmMqTfFmXO60jdjQASVJoJQYXGvhHEvj
         24VmJNpN463312LrtDue5REbKZBlBmZQBaLMIIPPvY1Q7MYATh3UfWXdzJfvFeZc63lO
         3wlmHFjND1AvshOn8WBcnnEkmpIQwxhLm4dnv3CbDWj/ovPldE7/4m63f/AbwwYevXDx
         r7qg==
X-Gm-Message-State: AO0yUKWis46TN+q8NQ+UOQ8cVT/HSCljhpO63ikgvRhsh/J9uY316Ycc
        I+EeLz/2VBGlqaHmCubUSMZno6VOiwiesqL7Kafl6TPmtj0=
X-Google-Smtp-Source: AK7set9vFr1ZH4Ispd3UqB4v+6seB7xuc/OitYEaR12Oquh2n3JloAlC0icIqBIz4fjZIL7XncAoRNuWPjF7Yyy5vTQ=
X-Received: by 2002:a50:c05c:0:b0:4ab:3a49:68b9 with SMTP id
 u28-20020a50c05c000000b004ab3a4968b9mr418514edd.5.1676441508085; Tue, 14 Feb
 2023 22:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20230215001439.748696-1-andrii@kernel.org> <Y+xN4kdLsSB7kJVJ@google.com>
In-Reply-To: <Y+xN4kdLsSB7kJVJ@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Feb 2023 22:11:36 -0800
Message-ID: <CAEf4BzaWbdYdQONOyq0CVPdBitQkx1mYa9BO=BQWVz858QB3RQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Fix BPF verifier global subprog context
 argument logic
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
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

On Tue, Feb 14, 2023 at 7:13 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On 02/14, Andrii Nakryiko wrote:
> > Fix kernel bug in determining whether global subprog's argument is
> > PTR_TO_CTX,
> > which is done based on type names. Currently KPROBE programs are broken.
>
> > Add few tests validating that KPROBE context can be passed to global
> > subprog.
> > For that also refactor test_global_funcs test to use test_loader
> > framework.
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> That endless loop+again in the first patch raised my brows a bit.
> But I'm assuming they are fine since we are working on a verified
> btf_vmlinux at this point...

it can't be a loop, because we are either on non-modifier type on the
first try, or will be on non-modifier after first retry. And then:

if (!btf_type_is_modifier(ctx_struct))
    return NULL;

It could be endless only if we have CONST/VOLATILE/RESTRICT/TYPEDEF
pointing to itself (as folks are investigating on another thread), but
that's a total corruption of BTF and lots of other places will break
even earlier.


>
>
> > Andrii Nakryiko (3):
> >    bpf: fix global subprog context argument resolution logic
> >    selftests/bpf: convert test_global_funcs test to test_loader framework
> >    selftests/bpf: add global subprog context passing tests
>
> >   kernel/bpf/btf.c                              |  13 +-
> >   .../bpf/prog_tests/test_global_funcs.c        | 133 +++++-------------
> >   .../selftests/bpf/progs/test_global_func1.c   |   6 +-
> >   .../selftests/bpf/progs/test_global_func10.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func11.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func12.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func13.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func14.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func15.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func16.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func17.c  |   4 +-
> >   .../selftests/bpf/progs/test_global_func2.c   |  43 +++++-
> >   .../selftests/bpf/progs/test_global_func3.c   |  10 +-
> >   .../selftests/bpf/progs/test_global_func4.c   |  55 +++++++-
> >   .../selftests/bpf/progs/test_global_func5.c   |   4 +-
> >   .../selftests/bpf/progs/test_global_func6.c   |   4 +-
> >   .../selftests/bpf/progs/test_global_func7.c   |   4 +-
> >   .../selftests/bpf/progs/test_global_func8.c   |   4 +-
> >   .../selftests/bpf/progs/test_global_func9.c   |   4 +-
> >   .../bpf/progs/test_global_func_ctx_args.c     | 105 ++++++++++++++
> >   20 files changed, 292 insertions(+), 125 deletions(-)
> >   create mode 100644
> > tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
>
> > --
> > 2.30.2
>
