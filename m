Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E04DA9D6
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 06:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbiCPFaI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 01:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbiCPFaH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 01:30:07 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8964129826
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:28:50 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id c23so1197471ioi.4
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFUbP6JOltAkWw+SsUOxB8OdytIrvaX8G07wXFADUz0=;
        b=OTHFUtFD0i9AEtBbgnaKW7xvxPRa4CukTSyxotSqM8kQqe7qewtSV4yptDt7/cKz7d
         Tbu0JVIFUHhFIXSR72Ax1UxsIlRjr0U9WKMEtWE1dZzio0a2Yteo37viyvoh+eoWR97e
         kHXig6+DMMjAATvI7F4x9ZobQFko7FbBdYxsk5h0kDOKIoB2N03gvRi2W+TCavPVJF87
         F9BCAs1W9bCe5ypNNTLDACc4LnUSjyg0BImVXxeEwotHqEFc2pWU2ezN6lJ9XRia8e5Q
         CZrANaPsAoW6TCHqrQlwpSx/Sbn0WtVCyeSTNvQL45la6kzd2SV7wKgE6l0K+3CUHXG9
         Gd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFUbP6JOltAkWw+SsUOxB8OdytIrvaX8G07wXFADUz0=;
        b=7+nksFDOAXPUaOb3tyWGBPNQGZmK9GT20felB8NRK5xHOqr0Ii2JHG8XyAs/iqIATZ
         xd4rqQYpbvJCzog+aNIjhKCAh/TdHbwQroY1semBHJ0CpCSH7tmaxZ4JvJRRQyuZLyLG
         pXlkjvB8mZDg29lCN06EWkmVn3Be77VbJQq9u+yPlTuQi1Dl5jAhbSYe6Lj3d2LRxigR
         nKVGsJzRF0OnorkYUEl3uZueIY6kkmXSqOaGMDZy/+zRGQFopZd8QuKMPLg9gGCqJOmD
         EMbAjZGFSLnbhmRvxtJ0nppwAEQ3bagzY6RNxmbCVdG56CpJm8duFu12V+ToBSAAUhSd
         E+dw==
X-Gm-Message-State: AOAM5321qYMAoHgfrozDdzVp09mU55Y8wEUwcXLPn//hFYRYd8PQFzPX
        z+8O+SsNmnCMNdoyKn2V74heTEVnTgLEVAcGIfS7NWMdn2E=
X-Google-Smtp-Source: ABdhPJxmULGFsau3VyXWdrs9EBBLJJIXloo7JbvALzvICrCHOx2jdlLiHbEOcib6QrXEYDeblhPTfSjxGjgkfUFyZsg=
X-Received: by 2002:a6b:8bd7:0:b0:646:2804:5c73 with SMTP id
 n206-20020a6b8bd7000000b0064628045c73mr23550142iod.112.1647408529855; Tue, 15
 Mar 2022 22:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647382072.git.delyank@fb.com>
In-Reply-To: <cover.1647382072.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 22:28:38 -0700
Message-ID: <CAEf4BzaeyfiH3_8+56Lctehmef8WvQqEkit0uh26z6iG-HYZBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/5] Subskeleton support for BPF libraries
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 3:15 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> In the quest for ever more modularity, a new need has arisen - the ability to
> access data associated with a BPF library from a corresponding userspace library.
> The catch is that we don't want the userspace library to know about the structure of the
> final BPF object that the BPF library is linked into.
>
> In pursuit of this modularity, this patch series introduces *subskeletons.*
> Subskeletons are similar in use and design to skeletons with a couple of differences:
>
> 1. The generated storage types do not rely on contiguous storage for the library's
> variables because they may be interspersed randomly throughout the final BPF object's sections.
>
> 2. Subskeletons do not own objects and instead require a loaded bpf_object* to
> be passed at runtime in order to be initialized. By extension, symbols are resolved at
> runtime by parsing the final object's BTF. This has the interesting effect that the same
> userspace code can interoperate with the library BPF code *linked into different final objects.*
>
> 3. Subskeletons allow access to all global variables, programs, and custom maps. They also expose
> the internal maps *of the final object*. This allows bpf_var_skeleton objects to contain a bpf_map**
> instead of a section name.
>
> Changes since v2:
>  - Reuse SEC_NAME strict mode flag
>  - Init bpf_map->btf_value_type_id on open for internal maps *and* user BTF maps
>  - Test custom section names (.data.foo) and overlapping kconfig externs between the final object and the library
>  - Minor review comments in gen.c & libbpf.c
>
> Changes since v1:
>  - Introduced new strict mode knob for single-routine-in-.text compatibility behavior, which
>    disproportionately affects library objects. bpftool works in 1.0 mode so subskeleton generation
>    doesn't have to worry about this now.
>  - Made bpf_map_btf_value_type_id available earlier and used it wherever applicable.
>  - Refactoring in bpftool gen.c per review comments.
>  - Subskels now use typeof() for array and func proto globals to avoid the need for runtime split btf.
>  - Expanded the subskeleton test to include arrays, custom maps, extern maps, weak symbols, and kconfigs.
>  - selftests/bpf/Makefile now generates a subskel.h for every skel.h it would make.
>
> For reference, here is a shortened subskeleton header:
>
> #ifndef __TEST_SUBSKELETON_LIB_SUBSKEL_H__
> #define __TEST_SUBSKELETON_LIB_SUBSKEL_H__
>
> struct test_subskeleton_lib {
>         struct bpf_object *obj;
>         struct bpf_object_subskeleton *subskel;
>         struct {
>                 struct bpf_map *map2;
>                 struct bpf_map *map1;
>                 struct bpf_map *data;
>                 struct bpf_map *rodata;
>                 struct bpf_map *bss;
>                 struct bpf_map *kconfig;
>         } maps;
>         struct {
>                 struct bpf_program *lib_perf_handler;
>         } progs;
>         struct test_subskeleton_lib__data {
>                 int *var6;
>                 int *var2;
>                 int *var5;
>         } data;
>         struct test_subskeleton_lib__rodata {
>                 int *var1;
>         } rodata;
>         struct test_subskeleton_lib__bss {
>                 struct {
>                         int var3_1;
>                         __s64 var3_2;
>                 } *var3;
>                 int *libout1;
>                 typeof(int[4]) *var4;
>                 typeof(int (*)()) *fn_ptr;
>         } bss;
>         struct test_subskeleton_lib__kconfig {
>                 _Bool *CONFIG_BPF_SYSCALL;
>         } kconfig;
>
> static inline struct test_subskeleton_lib *
> test_subskeleton_lib__open(const struct bpf_object *src)
> {
>         struct test_subskeleton_lib *obj;
>         struct bpf_object_subskeleton *s;
>         int err;
>
>         ...
>         s = (struct bpf_object_subskeleton *)calloc(1, sizeof(*s));
>         ...
>
>         s->var_cnt = 9;
>         ...
>
>         s->vars[0].name = "var6";
>         s->vars[0].map = &obj->maps.data;
>         s->vars[0].addr = (void**) &obj->data.var6;
>   ...
>
>         /* maps */
>         ...
>
>         /* programs */
>         s->prog_cnt = 1;
>         ...
>
>         err = bpf_object__open_subskeleton(s);
>   ...
>         return obj;
> }
> #endif /* __TEST_SUBSKELETON_LIB_SUBSKEL_H__ */
>
> Delyan Kratunov (5):
>   libbpf: .text routines are subprograms in strict mode
>   libbpf: init btf_{key,value}_type_id on internal map open
>   libbpf: add subskeleton scaffolding
>   bpftool: add support for subskeletons
>   selftests/bpf: test subskeleton functionality
>

CI fails at test #18 (btf) ([0]), please take a look. I was able to
repro it locally as well.

  [0] https://github.com/kernel-patches/bpf/runs/5562170931?check_suite_focus=true

Given you are going to resubmit, I left a few more nits that I'd
otherwise fix while applying.



>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  25 +
>  tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
>  tools/bpf/bpftool/gen.c                       | 595 +++++++++++++++---
>  tools/lib/bpf/libbpf.c                        | 155 ++++-
>  tools/lib/bpf/libbpf.h                        |  29 +
>  tools/lib/bpf/libbpf.map                      |   2 +
>  tools/lib/bpf/libbpf_legacy.h                 |   4 +-
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |  12 +-
>  .../selftests/bpf/prog_tests/subskeleton.c    |  78 +++
>  .../selftests/bpf/progs/test_subskeleton.c    |  28 +
>  .../bpf/progs/test_subskeleton_lib.c          |  61 ++
>  .../bpf/progs/test_subskeleton_lib2.c         |  16 +
>  13 files changed, 910 insertions(+), 110 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c
>
> --
> 2.34.1
