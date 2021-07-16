Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B383CB1F6
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 07:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbhGPFiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Jul 2021 01:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbhGPFiQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Jul 2021 01:38:16 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4616C06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 22:35:21 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id b13so13000345ybk.4
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 22:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7xaa3FpOVkgtkSDgQcTacyNa2IVr4ihhiD9U/1cBAY=;
        b=Opk3nkolxtZ+zunORSTJQ2adXwBNtVqV8mdo4RqlovIbzWyd2ViJfpsq53jEqJ6D9r
         YVP3xfALhF0ZwKSWxRMOk0ym5EYLYe8s/LLVADe23NHa0Oe3NyEheXx+QzB6A07gwr+l
         FfTtUMYQWFYvuViclvEl6rbFu3UBrAJl2DQvUtig9JOnkW7wt4Y1Iyj5dLh4nO55QyCv
         AIrHAlUlJFN5mhXvSV8Fu4EvFegXvrZ0CaevA3lOJIjykQAbpPkGpxhUiNEXDYNCIysu
         N3xNc47NTk05SbgJA6b/+de2HSmDbb5amfUmKZ8+AabQ52AtcIjQuNlSD5prgVMI4dQw
         I+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7xaa3FpOVkgtkSDgQcTacyNa2IVr4ihhiD9U/1cBAY=;
        b=eesiTfE43AEUv8ZLMKxqSAJYAxynzlQkYJs+Z6OveFf0puaj6iq4NzuH+yY+ZSsL2g
         Wlz/94JPOklaQhIGAsQIHU1KQTotvBgD8y1gPbSWKNyIW4/ex0vPKnFtWrzVVsEF52lY
         sLg9AgSKUAFV737iMOSAtsPTrk0ijTpWrw/bxfuLEVmL/0uC/NQjICVo1ANLwNKSortD
         yDh7k3OyY4ziYOEkN9BZpMgpS9oEpl2GPEkbKHHJy9D9DuL/OeOGKDofPxmtN9IbduCf
         Sf542m6tAXITJtwN/XT1salKoeOKddwVKIKJyZtwfFfQPpDUR3SB8AZsiiSwu5QJ/Ee8
         N34w==
X-Gm-Message-State: AOAM530c8AGffeYwXZkwXBq/8awA+q+f+QrYWhOSD5HZ7uwscHogfhAA
        Cq6/ONZLH8caiW/cQmFfJKMggllZydtfiFd4GVE=
X-Google-Smtp-Source: ABdhPJxHzqk8nlghl/vBkMWrk+3d1PFrPzaJuz/VXTF9w8iLsK5XIOehgzowavgh7mUmNvE7FelAxKm4BgtP3Wn6rt4=
X-Received: by 2002:a25:9942:: with SMTP id n2mr10753213ybo.230.1626413721118;
 Thu, 15 Jul 2021 22:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210714165440.472566-1-m@lambda.lt> <20210714165440.472566-3-m@lambda.lt>
In-Reply-To: <20210714165440.472566-3-m@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 15 Jul 2021 22:35:10 -0700
Message-ID: <CAEf4BzbP6Dr0GWavhV-MUqdFe1rB_A_criwHB_=yS_yGuoc1oQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: check inner map deletion
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 14, 2021 at 9:52 AM Martynas Pumputis <m@lambda.lt> wrote:
>
> Add a test case to check whether an unsuccessful creation of an outer
> map of a BTF-defined map-in-map destroys the inner map.
>
> As bpf_object__create_map() is a static function, we cannot just call it
> from the test case and then check whether a map accessible via
> map->inner_map_fd has been removed. Instead, we iterate over all maps
> and check whether the map "$MAP_NAME.inner" does not exist.
>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  .../bpf/progs/test_map_in_map_invalid.c       | 27 +++++++++
>  tools/testing/selftests/bpf/test_maps.c       | 58 ++++++++++++++++++-
>  2 files changed, 84 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
>
> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
> new file mode 100644
> index 000000000000..03601779e4ed
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
> @@ -0,0 +1,27 @@
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
> +int xdp_noop0(struct xdp_md *ctx)
> +{
> +       return XDP_PASS;
> +}
> +
> +int _version SEC("version") = 1;

please don't add new uses of version, it's completely unnecessary on
modern kernels

> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 30cbf5d98f7d..48f6c6dfd188 100644
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
> @@ -1229,10 +1233,62 @@ static void test_map_in_map(void)
>
>         close(fd);
>         bpf_object__close(obj);
> +
> +
> +       /* Test that failing bpf_object__create_map() destroys the inner map */
> +
> +       obj = bpf_object__open(MAPINMAP_INVALID_PROG);

you didn't check bpf_object__open() succeeded here...

> +
> +       map = bpf_object__find_map_by_name(obj, "mim");

... and crash will happen here on error

> +       if (!map) {
> +               printf("Failed to load array of maps from test prog\n");
> +               goto out_map_in_map;
> +       }
> +

[...]
