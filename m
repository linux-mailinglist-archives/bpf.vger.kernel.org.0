Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1603CF0A1
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 02:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356500AbhGSXcN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 19:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392000AbhGSW0Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 18:26:16 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E1C0610DF
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 15:59:14 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g5so30180687ybu.10
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Z+qeuTYQofR99lVoPOn0FXcRHswoHfrAVzXWRvWTaU=;
        b=qE+sBW+mHnV4QDC6vTXlz1bW3+7SJ1C8+Fwz8Rmr1mCHIg/nKZtEg7JwT3liEEf+bM
         ng7UemdpEOZzUW+f5PxzC4xHNEafHiztyvU3VeMhm8OgsCce0fJEVVUg0yU1eKMdYMOB
         jBngdLSdVvmVmw3+OMM4jKZbtXc5rR6D5BmPC8VGq8Ce8utGYPEm8wQjD6gtHKMGUZf8
         gu9ccgv4ZQO9KRiLOtZjE5pgNqGC/6O8Olc7iGxYI/97QOd6bfE5cpWDgn8a7fpCfG42
         Nv1IVb6B+l8vBR5xXlfXh4YTkXTZa+o1P0qzoo+TWJTdnxyRxS6pCwcYHbqVX57ohHQZ
         4dUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Z+qeuTYQofR99lVoPOn0FXcRHswoHfrAVzXWRvWTaU=;
        b=hMpOa36HadLNNBbpRgpcLY6bh1TwJaMqUoj/lyOH0JbHt0wMuFagAVsVhQMKhY+dz4
         2bP56rdw65vfjcdOtRIr+butT7aMC01jEK5EDyDjsB9belNMP8WhrsymK9xrF0d5phEu
         WfJOpTQ7vImlDynJxEUl/5b7WBBE234lR74T2qmceRkJg9AvcJQnVu6AZ2F6Zj1SAK9y
         ZuGnOoT8DZ/rz6Fros+dJhr6gbVE63WohuQb1Xdn7MDDNI7MnuELSxIfjJiBxb7w0ChI
         sL53EtJAqC/8BLbsg4ung0LY6s5qYWeAMuwz1/VekwTGNxIBVc9Ph8Dp0lAHETT83F09
         fa6A==
X-Gm-Message-State: AOAM532oY0HcdNU21Ix4mMBhX8yAn0Qc3D6FdRdIfG2XTRyb76w45BZp
        84ClfMzlxxxt7hWYlgqnSj2tuFYOFfMtHTd2FN8=
X-Google-Smtp-Source: ABdhPJwHmx2WxWPXwJMcpHZ8Jstw/6HSDh8UF4znu2c/LOnv3VEkdcreG3TNK18B7/wVPEN0hy89EKkUyiwVnCtlWDE=
X-Received: by 2002:a25:d349:: with SMTP id e70mr34689499ybf.510.1626735553464;
 Mon, 19 Jul 2021 15:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210719173838.423148-1-m@lambda.lt> <20210719173838.423148-3-m@lambda.lt>
In-Reply-To: <20210719173838.423148-3-m@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Jul 2021 15:59:02 -0700
Message-ID: <CAEf4Bzbx0SxK5mqKNydVQzM9f0-d9yaeKK6e2Q9Mhe1O0m_04g@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: check inner map deletion
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 19, 2021 at 10:36 AM Martynas Pumputis <m@lambda.lt> wrote:
>
> Add a test case to check whether an unsuccessful creation of an outer
> map of a BTF-defined map-in-map destroys the inner map.
>
> As bpf_object__create_map() is a static function, we cannot just call it
> from the test case and then check whether a map accessible via
> map->inner_map_fd has been closed. Instead, we iterate over all maps and
> check whether the map "$MAP_NAME.inner" does not exist.
>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  .../bpf/progs/test_map_in_map_invalid.c       | 26 ++++++++
>  tools/testing/selftests/bpf/test_maps.c       | 64 ++++++++++++++++++-
>  2 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
>
> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
> new file mode 100644
> index 000000000000..2918caea1e3d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Isovalent, Inc. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct inner {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __type(key, __u32);
> +       __type(value, int);
> +       __uint(max_entries, 4);
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +       __uint(max_entries, 0); /* This will make map creation to fail */
> +       __uint(key_size, sizeof(__u32));
> +       __array(values, struct inner);
> +} mim SEC(".maps");
> +
> +SEC("xdp_noop")

canonical section name for XDP programs is strictly "xdp", so I
updated it to avoid fixing that later when libbpf will start enforcing
this

> +int xdp_noop0(struct xdp_md *ctx)
> +{
> +       return XDP_PASS;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 30cbf5d98f7d..d4184dde04df 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -1153,12 +1153,16 @@ static void test_sockmap(unsigned int tasks, void *data)
>  }
>
>  #define MAPINMAP_PROG "./test_map_in_map.o"
> +#define MAPINMAP_INVALID_PROG "./test_map_in_map_invalid.o"
>  static void test_map_in_map(void)
>  {
>         struct bpf_object *obj;
>         struct bpf_map *map;
>         int mim_fd, fd, err;
>         int pos = 0;
> +       struct bpf_map_info info = {};
> +       __u32 len = sizeof(info);
> +       __u32 id = 0;
>
>         obj = bpf_object__open(MAPINMAP_PROG);
>
> @@ -1229,10 +1233,68 @@ static void test_map_in_map(void)
>
>         close(fd);

added fd = -1 here

>         bpf_object__close(obj);
> +
> +
> +       /* Test that failing bpf_object__create_map() destroys the inner map */
> +
> +       obj = bpf_object__open(MAPINMAP_INVALID_PROG);
> +       err = libbpf_get_error(obj);
> +       if (err) {
> +               printf("Failed to load %s program: %d %d",
> +                      MAPINMAP_INVALID_PROG, err, errno);
> +               goto out_map_in_map;
> +       }
> +

[...]
