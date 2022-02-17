Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E464BAC28
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 22:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiBQV7r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 16:59:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiBQV7q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 16:59:46 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B065D1A8
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 13:59:31 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h5so5408684ioj.3
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 13:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMDGxFR0xYbMvHRtoYJpxjZWPUVO0m5xLr1svW5im/E=;
        b=cNH6/95E7jx0i7x9Kt7NtL6ws1IQ7qjj4NCqyW/ITzXjjBADUNPvUAAhq8V160eBMy
         bY+xjhUfl55XcSiU1Ita9yarSZos9ELhnwK7m6+scs88ZzvA9Da8z+tZb5Mi7Z/9CZYB
         qf3LP32lar9LiDyfLCjoKOYFqkRFm7MKnTw8AVt8XYarn8I4/FOI4ie0aH4p9ctbPTmm
         hpihN+rPedGDNNpzvLqgZS5tHyyeRASTNzcozTzZmBmH3CmED9eV2mYEvoh4p8GWGE2v
         099jPXmayik3TfUs9HHEQyGe/vVjMlRagAMaSUmxpMkzHwfHICTxRuEKusz/Xp9mMQbs
         46Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMDGxFR0xYbMvHRtoYJpxjZWPUVO0m5xLr1svW5im/E=;
        b=DbmvD9ONDd0XMie21xDhFeQLx9hr4sLnzbQyfC2KX1uwWL8mx2/c+fkzcuW7ycSmFP
         Th3neQEBBZVClCftkKIXGfRr1DwOGGaY9pXyTr6XjGkcdvqdK/4nMX68tsSuQLLc66Ob
         jFjihjpJY98r/q7jd276lZHgYamzHUB2Tzu/Td+Lkto0GVAnHQE9p+j7erGVRRM9dtpM
         eF+8XKmj/D/gsKjJxkKv5zi65deCY2a2Tmgt2XW43JEtWeFsIrF8nQJYtxerMEeS6DLe
         czyQdON6TfGUaGlBzNWcVNUlKchlhcQedA+0kU+v7/DFmKQbK05Lkne4zzLM2j4TiHBs
         W06Q==
X-Gm-Message-State: AOAM531JFhgBnTRuRSpuCqPQKYEmdXl1uX/+kREhv127YU0pxWQfTauw
        w7guPDNbRQ0o4hbvhVRg3NojCD/TmJbUOU7XgTI=
X-Google-Smtp-Source: ABdhPJx1fNMoELX4bnEDg1Tbi2bYIf0FPAPYIKRVJw3hOWsL+VZCePJaqxZRyhfHy+ZQlGhAQKsug/MjR+QGHuJV42s=
X-Received: by 2002:a05:6638:22c3:b0:30a:2226:e601 with SMTP id
 j3-20020a05663822c300b0030a2226e601mr3320135jat.237.1645135171055; Thu, 17
 Feb 2022 13:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20220217194005.2765348-1-yhs@fb.com>
In-Reply-To: <20220217194005.2765348-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Feb 2022 13:59:20 -0800
Message-ID: <CAEf4BzaWczdp4JnK8t-Fd95zsVcadUuXmE9nB_icvnimztfDWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a clang deprecated-declarations
 compilation error
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Thu, Feb 17, 2022 at 11:40 AM Yonghong Song <yhs@fb.com> wrote:
>
> Build the kernel and selftest with clang compiler with LLVM=1,
>   make -j LLVM=1
>   make -C tools/testing/selftests/bpf -j LLVM=1
>
> I hit the following selftests/bpf compilation error:
>   In file included from test_cpp.cpp:3:
>   /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:73:8:
>     error: 'relaxed_core_relocs' is deprecated: libbpf v0.6+: field has no effect [-Werror,-Wdeprecated-declarations]
>   struct bpf_object_open_opts {
>          ^
>   test_cpp.cpp:56:2: note: in implicit move constructor for 'bpf_object_open_opts' first required here
>           LIBBPF_OPTS(bpf_object_open_opts, opts);
>           ^
>   /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:77:3: note: expanded from macro 'LIBBPF_OPTS'
>                   (struct TYPE) {                                             \
>                   ^
>   /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:90:2: note: 'relaxed_core_relocs' has been explicitly marked deprecated here
>           LIBBPF_DEPRECATED_SINCE(0, 6, "field has no effect")
>           ^
>   /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:24:4: note: expanded from macro 'LIBBPF_DEPRECATED_SINCE'
>                   (LIBBPF_DEPRECATED("libbpf v" # major "." # minor "+: " msg))
>                    ^
>   /.../tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:19:47: note: expanded from macro 'LIBBPF_DEPRECATED'
>   #define LIBBPF_DEPRECATED(msg) __attribute__((deprecated(msg)))
>
> There are two ways to fix the issue, one is to use GCC diagnostic ignore pragma, and the
> other is to open code bpf_object_open_opts instead of using LIBBPF_OPTS.
> Since in general LIBBPF_OPTS is preferred, the patch fixed the issue by
> adding proper GCC diagnostic ignore pragmas.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Do you know why we see this only with Clang? Why GCC doesn't generate this?


>  tools/testing/selftests/bpf/test_cpp.cpp | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
> index 773f165c4898..19ad172036da 100644
> --- a/tools/testing/selftests/bpf/test_cpp.cpp
> +++ b/tools/testing/selftests/bpf/test_cpp.cpp
> @@ -1,6 +1,9 @@
>  /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>  #include <iostream>
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>  #include <bpf/libbpf.h>
> +#pragma GCC diagnostic pop
>  #include <bpf/bpf.h>
>  #include <bpf/btf.h>
>  #include "test_core_extern.skel.h"
> --
> 2.30.2
>
