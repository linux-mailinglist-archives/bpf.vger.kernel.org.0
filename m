Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6C4DD138
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 00:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiCQXgB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 19:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiCQXgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 19:36:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD00221B88
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 16:34:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r2so7691727iod.9
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/80TYwdmZPytCnABRzYkRDicIJ5Gpr362hQj9hMXBQI=;
        b=dleoHZ6QI2oMHPUJMjYoANKl3IfUoK5QZBR2oQKRP/oq1OeefYEXAjx25Xvw8kvrcE
         BQM2AaiKpCrVMy0IaDzahjlyoU6zTkn0z9AkAJAbgtknLhEOdkhZzaApJwxXCFRR5AHS
         k++iqjDhm5NlugLMGLZviuhyaRvPuY9G43J4RRSw6CGKdAE1pnJrq3PLyZNKrADMsNtq
         kRlPBhuQD9rcGQFVqPmLnUWcN9ISWXYErBEfn/VX5X7lw4ZfR8q33OY2c9FXrsE0671P
         6fvGr707EDVROnDYWS6hlhF0FQfTR7vMiAG4cntrdLCoAhBKQRhiCbsKBU5JWBFG+uFr
         bxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/80TYwdmZPytCnABRzYkRDicIJ5Gpr362hQj9hMXBQI=;
        b=Vs8Z7RQ10DFb3F+xpIYAqfxxxxv+IrFBUxHqYjf31XJ2Ks+v0dyodxgbG3TfA15fgp
         4ZyVjMyDCN5iniV9pMeTEMtKKJpS8j0ztYy2DfzRWmdYTFvQ0Wtx3UTNXF17uKIFFvBi
         gkWGTJUJ7HUiM9w+Wcx6CppTPl/mzEc5jwaEveH2ZJ7cYTUSHB9PaaF+AkAWiCaEAbKh
         sqtjTvjywbWSMStG/1F1SIyDz/0hmNsqwaWd8OvR5XogS2esgN3FeHb221HiM88lqVdY
         1ka7N3AQf/MXTIFKJPEwjcqx1qCWAEGbBGjlsy9dvkl49HVV/yPNbJLS28AmvaWo9gEJ
         IJug==
X-Gm-Message-State: AOAM533eFAJzHdZS5SDeej5gyy+vTg4Ey+fPOsji8EU0yp8ZcC4WAyCI
        d21w4gi1FB+wjGcvluo5nrrtqqY1nCViMfmA11ue3Vml
X-Google-Smtp-Source: ABdhPJzmH6ghlz9usS3BMVCggu4cSuW2DHKCmc/lPk5auAXGPxA5vlHFCwym6/ZGaUGgl4f/sQ1rxK52Uno0IWFnwwI=
X-Received: by 2002:a6b:6f0c:0:b0:648:ea2d:41fe with SMTP id
 k12-20020a6b6f0c000000b00648ea2d41femr3355568ioc.63.1647560081768; Thu, 17
 Mar 2022 16:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647473511.git.delyank@fb.com>
In-Reply-To: <cover.1647473511.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Mar 2022 16:34:30 -0700
Message-ID: <CAEf4BzYvQkXRABzbds9xZhofA6K_S7L=_m849dsZddgp2BHizg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/5] Subskeleton support for BPF libraries
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

On Wed, Mar 16, 2022 at 4:37 PM Delyan Kratunov <delyank@fb.com> wrote:
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
> runtime by parsing the final object's BTF.
>
> 3. Subskeletons allow access to all global variables, programs, and custom maps. They also expose
> the internal maps *of the final object*. This allows bpf_var_skeleton objects to contain a bpf_map**
> instead of a section name.
>
> Changes since v3:
>  - Re-add key/value type lookup for legacy user maps (fixing btf test)
>  - Minor cleanups (missed sanitize_identifier call, error messages, formatting)
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

Looks great, applied to bpf-next. Thanks!

> Delyan Kratunov (5):
>   libbpf: .text routines are subprograms in strict mode
>   libbpf: init btf_{key,value}_type_id on internal map open
>   libbpf: add subskeleton scaffolding
>   bpftool: add support for subskeletons
>   selftests/bpf: test subskeleton functionality
>
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  25 +
>  tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
>  tools/bpf/bpftool/gen.c                       | 588 +++++++++++++++---
>  tools/lib/bpf/libbpf.c                        | 161 ++++-
>  tools/lib/bpf/libbpf.h                        |  29 +
>  tools/lib/bpf/libbpf.map                      |   2 +
>  tools/lib/bpf/libbpf_legacy.h                 |   4 +
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |  12 +-
>  .../selftests/bpf/prog_tests/subskeleton.c    |  78 +++
>  .../selftests/bpf/progs/test_subskeleton.c    |  28 +
>  .../bpf/progs/test_subskeleton_lib.c          |  61 ++
>  .../bpf/progs/test_subskeleton_lib2.c         |  16 +
>  13 files changed, 910 insertions(+), 109 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c
>
> --
> 2.34.1
