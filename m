Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3130940447A
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 06:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbhIIEbD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 00:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhIIEbC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 00:31:02 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6689BC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 21:29:53 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r4so1307727ybp.4
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 21:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRLKt2bZxP/hDB7E9s75aAmLbytnwSkW2Nwnrh7u55s=;
        b=bAfeqiq2AjO+C1UhP4ai6hQnv3HDocWcrxcc1ZpBkg7IfF0O1PWg05tga6G//g0HB7
         qkPfpnrWnadCflGXC+hxW7w454ZgNAOXEg3bP3JFyLHkmoqb7BoJoSTHUcfLglbselvu
         A71NbBGsm5F7PA9coOfTU1eYeBxKbDT4z9E9LR1tlFiRdtU5yeau4o4RRouMilSkxXIB
         ClDUSTvQhVtpyxLnZDtQW7ZzDXKReodNB5JDH6zFQpNlBUTXetGF2doCLNsr0ucs/8Rk
         llWT3MinvIVL6oNyAbhsWjd/MuRoEf2WKmsI/vDqjGIfuPSrANJTfd6JBptMVbM/6iaB
         lRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRLKt2bZxP/hDB7E9s75aAmLbytnwSkW2Nwnrh7u55s=;
        b=PagK/J4ZOVp9kXrBMB/EkJMo6TeJD/PuhVcdHuGZAHVmtr3K+bjK3UOAyXpbQ7wpeF
         BpzaVHKtN4KtTVaUKHxOfiJMDh8s3qatE2SfR6M5DSg9K/fXNQItvo71uqiwxZmdEU+L
         /SRY8qjgW/TvylkrrSIvpusPrwp8bymfvrlILxexxktI/UBX9SQjWvSG5s1LNgASocs6
         bjIm0sVehmwcY9lTaCY42tBQDoK9NImnIjkC7rGToEf4tmCT7s4HSV7InnuWhXjetsZJ
         V889RBhMS3JYBgoL2N0g+gkOV/K8OJ6IdtuzDCor/+t1FsBXWre2Mtx25DxqxmFxXw0g
         ZZ1w==
X-Gm-Message-State: AOAM530wsn3VOk24TZzUGRYsJjr7ldhz5Yq+sZXxSXdeRzVEPX9dROvH
        Z9Cf1vv57vqXUp4JBrbn6msbm1G+DTRkD10/laA=
X-Google-Smtp-Source: ABdhPJwDRo3yx0oGZ98vW+Em+n/6k+hWhnEPPSzHID+YqEU7jU8ln/NYYURi5m+4bOqnP7FBSROBN/tAde/isnupPes=
X-Received: by 2002:a25:65c4:: with SMTP id z187mr1377724ybb.113.1631161792659;
 Wed, 08 Sep 2021 21:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210905100914.33007-1-hengqi.chen@gmail.com> <20210905100914.33007-2-hengqi.chen@gmail.com>
In-Reply-To: <20210905100914.33007-2-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 21:29:41 -0700
Message-ID: <CAEf4BzZnKxVRtkaGUbzCmi0SDsR4_KM=uqdgP+Q6seAygkst7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test BPF map creation using
 BTF-defined key/value
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 5, 2021 at 3:09 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Test BPF map creation using BTF-defined key/value. The test defines
> some specialized maps by specifying BTF types for key/value and
> checks those maps are correctly initialized and loaded.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/map_create.c     |  87 ++++++++++++++
>  .../selftests/bpf/progs/test_map_create.c     | 110 ++++++++++++++++++
>  2 files changed, 197 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/map_create.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_map_create.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_create.c b/tools/testing/selftests/bpf/prog_tests/map_create.c
> new file mode 100644
> index 000000000000..6ca32d0dffd2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/map_create.c
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2021 Hengqi Chen */
> +
> +#include <test_progs.h>
> +#include "test_map_create.skel.h"
> +
> +void test_map_create(void)
> +{
> +       struct test_map_create *skel;
> +       int err, fd;
> +
> +       skel = test_map_create__open();
> +       if (!ASSERT_OK_PTR(skel, "test_map_create__open failed"))
> +               return;
> +
> +       err = test_map_create__load(skel);

If load() succeeds, all the maps will definitely be created, so all
the below tests are meaningless.

I think it's better to just change all the existing map definitions
used throughout selftests to use key/value types, instead of
key_size/value_size. That will automatically test this feature without
adding an extra test. Unfortunately to really test that the logic is
working, we'd need to check that libbpf doesn't emit the warning about
retrying map creation w/o BTF, but I think one-time manual check
(please use ./test_progs -v to see libbpf warnings during tests)
should be sufficient for this.

> +       if (!ASSERT_OK(err, "test_map_create__load failed"))
> +               goto cleanup;
> +
> +       fd = bpf_map__fd(skel->maps.map1);
> +       if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
> +               goto cleanup;
> +       close(fd);
> +
> +       fd = bpf_map__fd(skel->maps.map2);
> +       if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
> +               goto cleanup;
> +       close(fd);

[...]
