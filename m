Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEDD650678
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 03:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLSChK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Dec 2022 21:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiLSChI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Dec 2022 21:37:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E47AB1F5
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 18:37:07 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h12so7309535wrv.10
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 18:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a/j43+sQ5NlHh5GUPOhTpYGO+HVX9EP+QEs6b6RY9KQ=;
        b=heMreDTWrUVEzDqISOlPQrOAqLAVfatTCcBwJ4pJQY4Qzh8crhXK53qSYPgNPDFayu
         unj/eeJ9oOWXcf6NdmcWQjVEx6jF2Gai0VuJsMw+TW221AmnCc6DhiuA2Syp1oN0TMvl
         xOXQtBw/wwDLXmybNkWYdkD7GdK1AKScL0HofxVi4RYxK0CVXej6G5oGWkA2lMyES+Oe
         Axp9dkP+WTTivmv4Q2cOhND++5oWc38aga2S5IejKfXcBNJWn1D93rINoy671pILQ6cn
         wFXvvpoNS4Yo0leD+LV7PYk2xGyDdQx97SJaSQ99W3oE/NyhaWIQB3e5Xdr9+uP8bV1t
         bTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/j43+sQ5NlHh5GUPOhTpYGO+HVX9EP+QEs6b6RY9KQ=;
        b=2qlRY1ZwAV9mGGhKACbXOMb/JAF/0m3dxaOYIzVMZ6dghYmU0Mpd5qnZPuew5jjZWu
         /O93IaUfnN5a+LD7SD1j79M6zMtnpIu0oQc1v2+lQybcxWGB3WMd8PxfEmnXBQWmwt1B
         Hc8OCVY1uQk7xKYxKKpYn9EaeDIsG+1NK316g3HvGrGSgIt/qj8TgETs3wiRVThrIuLn
         Qlv7ociaxZdDB0FcL70YZCNFw7tHzf5Ar/fD4am4oVU3rk8AUxnIyR0hI5RN45uhvlcw
         Q/l7JLSp1MlXxbCPpjAPZIuiTTNPRoKX0rD0Qi5ffnbxVjDE3AbPEi0r/UX8mcY2YLpS
         rJOg==
X-Gm-Message-State: ANoB5pmNsf6WmfLG68pdmwdQbyAQTZrmpZqvUdp9svVf2dxeH4uzcAGa
        j4HAssVXrRWpMJsPazJIWLG9vmy6TCvTp0b9c4c=
X-Google-Smtp-Source: AA0mqf43NChoL+OmqhMrzoZHaPhnL620uJ5VTGUw4tXfO8ETbX+Pco9jCei0Fok+iDnbFquP6Jh245B3y/rNTiYCHCs=
X-Received: by 2002:a5d:4532:0:b0:242:72d6:7708 with SMTP id
 j18-20020a5d4532000000b0024272d67708mr9271710wra.157.1671417425797; Sun, 18
 Dec 2022 18:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20221217150207.58577-1-xiangxia.m.yue@gmail.com>
 <20221217150207.58577-2-xiangxia.m.yue@gmail.com> <ad206ab9-27f6-d08e-b215-2ceda94fd2bd@meta.com>
In-Reply-To: <ad206ab9-27f6-d08e-b215-2ceda94fd2bd@meta.com>
From:   Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date:   Mon, 19 Dec 2022 10:36:29 +0800
Message-ID: <CAMDZJNWaDhrWTzFi_yc=eE8qvEOr-OCvjHOozA6Uq1FuAZmF=w@mail.gmail.com>
Subject: Re: [bpf-next v2 2/2] selftests/bpf: add test case for htab map
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
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

On Sun, Dec 18, 2022 at 1:38 AM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 12/17/22 7:02 AM, xiangxia.m.yue@gmail.com wrote:
> > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >
> > This testing show how to reproduce deadlock in special case.
> > We update htab map in Task and NMI context. Task can be interrupted by
> > NMI, if the same map bucket was locked, there will be a deadlock.
> >
> > * map max_entries is 2.
> > * NMI using key 4 and Task context using key 20.
> > * so same bucket index but map_locked index is different.
> >
> > The selftest use perf to produce the NMI and fentry nmi_handle.
> > Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
> > map syscall increase this counter in bpf_disable_instrumentation.
> > Then fentry nmi_handle and update hash map will reproduce the issue.
> >
> > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Hou Tao <houtao1@huawei.com>
>
> Ack with a small nit below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
> >   tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
> >   .../selftests/bpf/prog_tests/htab_deadlock.c  | 75 +++++++++++++++++++
> >   .../selftests/bpf/progs/htab_deadlock.c       | 30 ++++++++
> >   4 files changed, 107 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
> >
> [...]
> > diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> > new file mode 100644
> > index 000000000000..72178f073667
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 DiDi Global Inc. */
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(max_entries, 2);
> > +     __uint(map_flags, BPF_F_ZERO_SEED);
> > +     __type(key, unsigned int);
> > +     __type(value, unsigned int);
> > +} htab SEC(".maps");
> > +
> > +SEC("fentry/nmi_handle")
>
> nmi_handle() is a static function. In my setup, it is not inlined.
> But if it is inlined, the test will succeed regardless of the
> previous fix. But currently we don't have mechanisms to
> discover such situations, so I am okay with the test.
> But it would be good if you can add a small comment
> to explain this caveat.
Ok, Thanks
> > +int bpf_nmi_handle(struct pt_regs *regs)
> > +{
> > +     unsigned int val = 0, key = 4;
> > +
> > +     bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
> > +     return 0;
> > +}
> > +
> > +SEC("perf_event")
> > +int bpf_empty(struct pt_regs *regs)
> > +{
> > +     return 0;
> > +}



-- 
Best regards, Tonghao
