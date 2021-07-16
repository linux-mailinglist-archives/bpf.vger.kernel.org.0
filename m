Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A273CBBCF
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhGPS1v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Jul 2021 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPS1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Jul 2021 14:27:51 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EEFC06175F
        for <bpf@vger.kernel.org>; Fri, 16 Jul 2021 11:24:56 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a16so16269470ybt.8
        for <bpf@vger.kernel.org>; Fri, 16 Jul 2021 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0Kd7hm9TYQ2L4OJyDrX8T3mERAgZ5bgljiprrgb7sw=;
        b=TNUj7harowZgtxn/ggwR//tF0P8UkEe4qUV2MxmXG4uRtE6HL20Wm49s/uq34Lxz2s
         KMMuat/3mWdq3IHxkCkr60+kXCiwSc4ORHofhbr8OTrVMGFvM9szGGdpJCbcENrb4UV1
         V1Zjw8K5HZdGB7otoeqxPijCgAOHTz33yM3bJkDlomvJ31Jwx1/Mkmj7ziXSwfOF95nT
         GCRQFAnv1iYdg27Oy9N/fjYizkj0myskiqNip8x2PpHLkFTxj3sfesyzRdLjUj5LPhSS
         jNUoZ/B7Wa7pMC2NmLBpZO7xIIihP2fSs9WQLNbSzI2iMVLSArreZKat9zKIR6JZ1HLL
         NpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0Kd7hm9TYQ2L4OJyDrX8T3mERAgZ5bgljiprrgb7sw=;
        b=eqFHwVWUHB3EhQtKbzk/FvdATFYL1OAekV8F0DLx74poQlK42AvHm8Kjc0OiigiVas
         pGBQwiRv+HTMbMd5aBM5aYRDjNByMsl9ku1ZrB+Hif/RqXl6JDKyZ3tSm3rjR8YPMzWQ
         H00tAycOxQwdt1INRkLvmgAxO8JMgTq0PFMjp0bZLnpzf5PDTu031k1uz55iufGhMfCu
         FxQgoXBMltNbrD2to/DRzuv62xMZgS1e88jHQHqBWsFME3xC3ZAw0mDz/MAbYoEQ4h+2
         zUGecr8iApIIXmeV61ElbNgx4n4iWPd8Pe6ZI/nxruSfbMp2NNODCDQn5nMcptaiDDK1
         sGOQ==
X-Gm-Message-State: AOAM531FL7xUjkd2zFNnzYhJac5hNPpwHUbE87tH95dJZxiHep9hOyjk
        3QVqWE/8n+ZdgDD7wtRqwLKyHdITRE779tcfpVsMIKrP5dc=
X-Google-Smtp-Source: ABdhPJyAfNTRZV9PWPG8GPm2arqvD5Vr8t1dc8vKf8RyKiQ8mXojMbGXAvi1gjQ3c45bXkQthCJ8l9leySsbp3CRI7E=
X-Received: by 2002:a25:1455:: with SMTP id 82mr14397786ybu.403.1626459895482;
 Fri, 16 Jul 2021 11:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210714165440.472566-1-m@lambda.lt> <20210714165440.472566-3-m@lambda.lt>
 <CAEf4BzbP6Dr0GWavhV-MUqdFe1rB_A_criwHB_=yS_yGuoc1oQ@mail.gmail.com> <4b29412c-b8f2-39a2-4d96-4c1fa0360927@lambda.lt>
In-Reply-To: <4b29412c-b8f2-39a2-4d96-4c1fa0360927@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 16 Jul 2021 11:24:44 -0700
Message-ID: <CAEf4Bzbq90mZ9sMKPF3LoKyTiGatwXb4W0T57mAv1WyYLJZJcw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: check inner map deletion
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 16, 2021 at 8:07 AM Martynas Pumputis <m@lambda.lt> wrote:
>
>
>
> On 7/16/21 7:35 AM, Andrii Nakryiko wrote:
> > On Wed, Jul 14, 2021 at 9:52 AM Martynas Pumputis <m@lambda.lt> wrote:
> >>
> >> Add a test case to check whether an unsuccessful creation of an outer
> >> map of a BTF-defined map-in-map destroys the inner map.
> >>
> >> As bpf_object__create_map() is a static function, we cannot just call it
> >> from the test case and then check whether a map accessible via
> >> map->inner_map_fd has been removed. Instead, we iterate over all maps
> >> and check whether the map "$MAP_NAME.inner" does not exist.
> >>
> >> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> >> ---
> >>   .../bpf/progs/test_map_in_map_invalid.c       | 27 +++++++++
> >>   tools/testing/selftests/bpf/test_maps.c       | 58 ++++++++++++++++++-
> >>   2 files changed, 84 insertions(+), 1 deletion(-)
> >>   create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
> >> new file mode 100644
> >> index 000000000000..03601779e4ed
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
> >> @@ -0,0 +1,27 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright (c) 2021 Isovalent, Inc. */
> >> +#include <linux/bpf.h>
> >> +#include <bpf/bpf_helpers.h>
> >> +
> >> +struct inner {
> >> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> >> +       __type(key, __u32);
> >> +       __type(value, int);
> >> +       __uint(max_entries, 4);
> >> +};
> >> +
> >> +struct {
> >> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> >> +       __uint(max_entries, 0); /* This will make map creation to fail */
> >> +       __uint(key_size, sizeof(__u32));
> >> +       __array(values, struct inner);
> >> +} mim SEC(".maps");
> >> +
> >> +SEC("xdp_noop")
> >> +int xdp_noop0(struct xdp_md *ctx)
> >> +{
> >> +       return XDP_PASS;
> >> +}
> >> +
> >> +int _version SEC("version") = 1;
> >
> > please don't add new uses of version, it's completely unnecessary on
> > modern kernels
>
> Sure.
>
> >
> >> +char _license[] SEC("license") = "GPL";
> >> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> >> index 30cbf5d98f7d..48f6c6dfd188 100644
> >> --- a/tools/testing/selftests/bpf/test_maps.c
> >> +++ b/tools/testing/selftests/bpf/test_maps.c
> >> @@ -1153,12 +1153,16 @@ static void test_sockmap(unsigned int tasks, void *data)
> >>   }
> >>
> >>   #define MAPINMAP_PROG "./test_map_in_map.o"
> >> +#define MAPINMAP_INVALID_PROG "./test_map_in_map_invalid.o"
> >>   static void test_map_in_map(void)
> >>   {
> >>          struct bpf_object *obj;
> >>          struct bpf_map *map;
> >>          int mim_fd, fd, err;
> >>          int pos = 0;
> >> +       struct bpf_map_info info = {};
> >> +       __u32 len = sizeof(info);
> >> +       __u32 id = 0;
> >>
> >>          obj = bpf_object__open(MAPINMAP_PROG);
> >>
> >> @@ -1229,10 +1233,62 @@ static void test_map_in_map(void)
> >>
> >>          close(fd);
> >>          bpf_object__close(obj);
> >> +
> >> +
> >> +       /* Test that failing bpf_object__create_map() destroys the inner map */
> >> +
> >> +       obj = bpf_object__open(MAPINMAP_INVALID_PROG);
> >
> > you didn't check bpf_object__open() succeeded here...
>
> For the sake of brevity, I didn't add the check. If the opening fails,
> then we will catch it anyway with the bpf_object__find_map_by_name()
> invocation below: it will log "libbpf: elf: failed to open $PROG_NAME:
> No such file or directory" and then segfault.

Yeah, and then, due to the brevity you mentioned, someone like me will
go and waste time understanding what and where is crashing in our CIs.
Please add a proper check. Crashing test runners due to some
semi-expected failure is not an option. It happens in existing tests
very rarely, unfortunately, but it's a bug, not a feature.

>
> >
> >> +
> >> +       map = bpf_object__find_map_by_name(obj, "mim");
> >
> > ... and crash will happen here on error
> >
> >> +       if (!map) {
> >> +               printf("Failed to load array of maps from test prog\n");
> >> +               goto out_map_in_map;
> >> +       }
> >> +
> >
> > [...]
> >
