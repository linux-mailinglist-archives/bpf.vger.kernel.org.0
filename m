Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F606EFD0A
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 00:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbjDZWH0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 18:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbjDZWHZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 18:07:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4E22704
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 15:07:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24756a12ba0so5329677a91.1
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682546834; x=1685138834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6o3HhDAjNO89E3A0MRfU/b89KbqoEVo8Ba34QDXA+YA=;
        b=vOoliF7YSsdLjONkRkZIomxWjUfYe8LKdJb6rEHeLX6RhV38s/FBR4eoLfKYHW7zE3
         IavK6ET/Qqw5poSNg/YQZq3rl6vIwPoyAUWlMwIL/UgLwhldJ2/Nd9O47mnyXXXL9cvc
         sbFEtL3hc7qQh5FF+QVgJ+bj4+U9dfQxRkPyP9jul2D1FVAiTPMHklz+MO3UfFTHw1Xm
         oXIIx8QlKD6IFFHxrWK2XZK4XxjXuoHPzTZ/2hRqfXcOlir58wsKvMi0q4JRPoYFFWOv
         e4yhq3ur0yW91dT8QCcgI0Rp96j+86/T/j+x9r6LdVItESTZ1/6fDdvYKWk3gPn4jiib
         l8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682546834; x=1685138834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o3HhDAjNO89E3A0MRfU/b89KbqoEVo8Ba34QDXA+YA=;
        b=gNma0Z20RlrcsmPfofjgn0hg0jCJDZAJXuaZulcHqx5/wIVrf2Pb22lMSfTCE8hqJR
         MuZrMPLDJn8J4XoSQHGIX4m+GXZoAyAv1tKPAk7ULL4Vnl3D0YVtBbCJhu9o4JVmpOiC
         EIbWxXE8YdkWHalDOlZcfrtbxZYkOQuZuBgiUEjPVgft4BWreKHc5icW9glIxbNWGHi3
         nTXrxHX/bQ5Umrrs2YrJqVgdJfdlQ1IA8ES/CiDX9dB1mEgaJquCYyqH9jmxA5GIAt4q
         LXDJHXx5pRxK+5GyKBXB/LVKwRpoI0vpPmoYUKMKcOa5fo6oHgQlCPOp9oVa/o+gR1Xh
         jYjw==
X-Gm-Message-State: AAQBX9f9tL2cI5GjBzlIygvHxmBDkxq+6zwCZfaTkSqXTA40kVw60VvP
        sVooAJ9LP8iueI377xnh4vHNWltSVcSueoEpw+8k6g==
X-Google-Smtp-Source: AKy350bX4vKLe+c9/tywLjSWFK8JD/QrNCXcfXaXMeIppYVuasWMVt/WvZF7gUIFFE4mxooBAPv/W+J2eK4njGwo/b8=
X-Received: by 2002:a17:90a:8589:b0:249:7224:41cb with SMTP id
 m9-20020a17090a858900b00249722441cbmr22904088pjn.31.1682546834469; Wed, 26
 Apr 2023 15:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 26 Apr 2023 15:07:03 -0700
Message-ID: <CA+PiJmTHO3SPM_LvwFYWP+uf_KU4QytBshGzk78CZi8oGJ+rnw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Dynptr Verifier Adjustments
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>
> It is expected that you build the freshest vmlinux image before
> building selftests, because we generate vmlinux.h from it. In your
> case we generated vmlinux.h from your system-wide
> /sys/kernel/btf/vmlinux BTF information, which doesn't yet have latest
> UAPI enums.
>
I'm still unable to build the selftests. I've got it pointed to a
locally built kernel built using the config/config.x86_64, and have
tried running the vmtest.sh script, and building just the tests via
make. I'm using O= to direct it to the out directory for the kernel
build. I've been hitting various errors when trying this. Confusingly
the error message isn't always the same. Currently from a clean build,
it complains about "linux/atomic.h" not found via #include
"../../../include/linux/filter.h"'s in various files. Other times it's
complained about the various helper functions from bpf_helper_defs.h
being unused.

I'm not sure if I'm invoking the command wrong, or missing
dependencies or something. I got past some earlier issues by updating
clang. Any idea what I'm doing wrong?
