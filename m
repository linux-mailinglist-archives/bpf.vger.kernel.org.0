Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC7512233
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiD0TNc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 15:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiD0TNT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 15:13:19 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5317E84EFD
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 12:03:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id c125so4239365iof.9
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSaqVjmVYqV6de9fd3OrWrMZBe/mT7LRLe+2rYXlueI=;
        b=UcDxYuxhhii8lgf85htmvTq1+a1uoveTcv574BYDjnN7T5a7kyc5n+UruRyXR+Eml1
         wuaolH85lKsOtAIs87e8sCJoA64fLZOJLhnmyMpJTh65FQAra28zs4q8b6uzbGM9hZdr
         YZnqnwyJQ834KBW3mVMPh+UHr+K0m86s1qiLuxt22ROipJ0iRWz5LMLCFTYUIknqxCpL
         jRSoA4wnl83kcaNj+QeAoIIo1JsiBE3W5tEdVwnALfVeFov62hBph5umMFdgZupvCTtL
         GtzMXykYpJ5l2vK7LSBMu4oC6kzD0Dfx24OIwY7LkeQVDoaiNqKOSKMBl8Y0YlvIcRnq
         Er2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSaqVjmVYqV6de9fd3OrWrMZBe/mT7LRLe+2rYXlueI=;
        b=N3pGdPvwt5vMKWbp/fVn1vzdp7ncNvgKLzi7kMmQ2+gkCQ6/a3HwrR/fNnbJn+GItD
         F5gTY+5mu2R64Bvl8B1C3/PRqTv3nBTGRoBUymn/N9egx00ZHE8B2WZzxt3JlFV9TY3u
         1mMeOh6F27eoAfvM5sDjKC+OYL39XXpOoaFIZCZSvhqxnwmjjk4L4xKpRbAnN3qJ/TZh
         6tApKkxAbq+1sKatY2kxJqYVUGH7ZIGzkCK31diyXXDJv7ADNUcZMh7BvkHZqRVz3EA1
         32lmJEva5wHO4jeP1pdTtegwPiA2ua91Zwqvwuc4FFHk65aD2mMkBLOZ9CIFt1v51OEv
         7Dvw==
X-Gm-Message-State: AOAM532biwpFA7bhjx/iKD8i+49lDkMJG74/p7wQhv5ZSlzYHpD78Idf
        uTYb2NgGqfYAQUo0maBd9njkzmUyUU+qCMrgo2Y255epZto=
X-Google-Smtp-Source: ABdhPJyjuh7mfqKnJZ0d4AClwjCZxMC9g5IF982me0a7ZHXAqvc9LBAs0SbwlhiTSNSiSnqGp9FopRvW8NkubRMiNi4=
X-Received: by 2002:a05:6638:19c8:b0:328:6a22:8258 with SMTP id
 bi8-20020a05663819c800b003286a228258mr12999227jab.103.1651086231678; Wed, 27
 Apr 2022 12:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220422182254.13693-1-9erthalion6@gmail.com> <20220422182254.13693-3-9erthalion6@gmail.com>
In-Reply-To: <20220422182254.13693-3-9erthalion6@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Apr 2022 12:03:40 -0700
Message-ID: <CAEf4BzYSTOPiiEsksftkp1xkSw9JuCwtmiuZw4+nqREM_G=yMw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/2] selftests/bpf: Add bpf link iter test
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>
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

On Fri, Apr 22, 2022 at 11:23 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> Add a simple test for bpf link iterator
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c        | 15 +++++++++++++++
>  .../selftests/bpf/progs/bpf_iter_bpf_link.c    | 18 ++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 2c403ddc8076..e14a7a6d925c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -26,6 +26,7 @@
>  #include "bpf_iter_bpf_sk_storage_map.skel.h"
>  #include "bpf_iter_test_kern5.skel.h"
>  #include "bpf_iter_test_kern6.skel.h"
> +#include "bpf_iter_bpf_link.skel.h"
>
>  static int duration;
>
> @@ -1172,6 +1173,20 @@ static void test_buf_neg_offset(void)
>                 bpf_iter_test_kern6__destroy(skel);
>  }
>
> +static void test_link_iter(void)
> +{
> +       struct bpf_iter_bpf_link *skel;
> +
> +       skel = bpf_iter_bpf_link__open_and_load();
> +       if (CHECK(skel, "bpf_iter_bpf_link__open_and_load",
> +                 "skeleton open_and_load unexpected success\n"))
> +               return;
> +

please don't use CHECK() for new tests, you need ASSERT_OK_PTR() here

> +       do_dummy_read(skel->progs.dump_bpf_link);
> +
> +       bpf_iter_bpf_link__destroy(skel);
> +}
> +
>  #define CMP_BUFFER_SIZE 1024
>  static char task_vma_output[CMP_BUFFER_SIZE];
>  static char proc_maps_output[CMP_BUFFER_SIZE];
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
> new file mode 100644
> index 000000000000..a5041fa1cda9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020 Facebook */
> +#include "bpf_iter.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("iter/bpf_link")
> +int dump_bpf_link(struct bpf_iter__bpf_link *ctx)

see progs/bpf_iter.h, let's add bpf_iter__bpf_link there as well

> +{
> +       struct seq_file *seq = ctx->meta->seq;
> +       struct bpf_link *link = ctx->link;
> +       int link_id;
> +
> +       link_id = link->id;
> +       bpf_seq_write(seq, &link_id, sizeof(link_id));
> +       return 0;
> +}
> --
> 2.32.0
>
