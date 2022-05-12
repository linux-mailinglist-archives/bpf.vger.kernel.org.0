Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8225052418E
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 02:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347161AbiELAcf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 20:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346263AbiELAcd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 20:32:33 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C971D48C7;
        Wed, 11 May 2022 17:32:32 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id o5so2527514ils.11;
        Wed, 11 May 2022 17:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CI9GsZiqFfqQ+oQacRrtNOjUXyd6c9DyeOGcY6h67+8=;
        b=bzS1tTS3zJ6uuYucJOBMw61ufuRJT7unh43vNBP/bl8l3gOKRrwxpukFPuGPfD1R+O
         G6kjCDA36tVPA4QXCtLN8kDKAjggueHVeW9RpqvlDOXh/LlDrRMb413LvT9YLVH9YXVO
         w2IdebuZnVz6vZPdVXIMWrZoKCtSw50uMV0w9V5sCnx2FG2zFKznO5qDnQCYlH3rkNcA
         sI2UDMXZDkuk9xdAbYdocmWUWCA7tSRmQ3sUtIhMAXEE0oDygEv+fTGM4Ka8NUVnPhei
         S89NXkBwSlJQEUXRk7l8uL8cscEJH6S1V8jS+oqExRcNzQ0G6FCa8KXTs8vKRPQC8Zz6
         kfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CI9GsZiqFfqQ+oQacRrtNOjUXyd6c9DyeOGcY6h67+8=;
        b=EmFHO84kmju62RzTG1fOYe+1tRHBU8AJB8NXGPkerMgfBud+Rp8jQ3mR9KCIVNgNDX
         8IUDejaMqkBC11JyxcbG0lYcCE3TM9j57qlvCLLgHiXk1vNcKFt3nkelIuEz6koWs5Ud
         VhCgaCCcisoKES0quVxQ6f5lqnS09oOqIlaxzf6/ScjA7fY4+r1oxxw984y9yoqUTY5j
         zYXBUo77HNIUlQ2Zvz8YG8TGahEngox0Nt0GV4gV9ciBdDVMRtDZeNEM38vWnCX1gU83
         5s5/m27uVWiCJLSm46e0irDPwD2JeLvbff1p0dgqtLj8ihi6Kl4qWZdqCv4iI4RfPwUQ
         fBoQ==
X-Gm-Message-State: AOAM531ku+KYaCiTNDpEVt9VIpulPkg2OgS8yvLeezs2XHtyHGIyqN4l
        +sjt3K5EiTKu2l6YSFVUsmPcO+tTBDYQBGJbX6FcNWfPaaU=
X-Google-Smtp-Source: ABdhPJy0KDrat8/ojLKFa07gLcOjKsy+KnUSfyEbrGOscnsAAWvzTx+Xqlh7WfRYLpTqprrZgX65POqFhQAEv3XZF8o=
X-Received: by 2002:a05:6e02:1b82:b0:2cf:199f:3b4b with SMTP id
 h2-20020a056e021b8200b002cf199f3b4bmr13038771ili.71.1652315551545; Wed, 11
 May 2022 17:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220511220243.525215-1-yhs@fb.com> <20220511220249.525908-1-yhs@fb.com>
In-Reply-To: <20220511220249.525908-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 May 2022 17:32:20 -0700
Message-ID: <CAEf4BzZgby0RDcXXwHtB+zxof3Gmgn+EUnbeEyYOshb7dfbzyA@mail.gmail.com>
Subject: Re: [PATCH dwarves 2/2] btf_encoder: Normalize array index type for
 parallel dwarf loading case
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
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

On Wed, May 11, 2022 at 3:02 PM Yonghong Song <yhs@fb.com> wrote:
>
> With latest llvm15 built kernel (make -j LLVM=1), I hit the following
> error when build selftests (make -C tools/testing/selftests/bpf -j LLVM=1):
>   In file included from skeleton/pid_iter.bpf.c:3:
>   .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown type name
>        '__builtin_va_list___2'; did you mean '__builtin_va_list'?
>   typedef __builtin_va_list___2 va_list___2;
>           ^~~~~~~~~~~~~~~~~~~~~
>           __builtin_va_list
>   note: '__builtin_va_list' declared here
>   In file included from skeleton/profiler.bpf.c:3:
>   .../selftests/bpf/tools/build/bpftool/vmlinux.h:84050:9: error: unknown type name
>        '__builtin_va_list__ _2'; did you mean '__builtin_va_list'?
>   typedef __builtin_va_list___2 va_list___2;
>           ^~~~~~~~~~~~~~~~~~~~~
>           __builtin_va_list
>   note: '__builtin_va_list' declared here
>
> The error can be easily explained with after-dedup vmlinux btf:
>   [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>   [2300] STRUCT '__va_list_tag' size=24 vlen=4
>         'gp_offset' type_id=2 bits_offset=0
>         'fp_offset' type_id=2 bits_offset=32
>         'overflow_arg_area' type_id=32 bits_offset=64
>         'reg_save_area' type_id=32 bits_offset=128
>   [2308] TYPEDEF 'va_list' type_id=2309
>   [2309] TYPEDEF '__builtin_va_list' type_id=2310
>   [2310] ARRAY '(anon)' type_id=2300 index_type_id=21 nr_elems=1
>
>   [5289] PTR '(anon)' type_id=2308
>   [158520] STRUCT 'warn_args' size=32 vlen=2
>         'fmt' type_id=14 bits_offset=0
>         'args' type_id=2308 bits_offset=64
>   [27299] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>   [34590] TYPEDEF '__builtin_va_list' type_id=34591
>   [34591] ARRAY '(anon)' type_id=2300 index_type_id=27299 nr_elems=1
>
> The typedef __builtin_va_list is a builtin type for the compiler.
> In the above case, two typedef __builtin_va_list are generated.
> The reason is due to different array index_type_id. This happened
> when pahole is running with more than one jobs when parsing dwarf
> and generating btfs.
>
> Function btf_encoder__encode_cu() is used to do btf encoding for
> each cu. The function will try to find an "int" type for the cu
> if it is available, otherwise, it will create a special type
> with name __ARRAY_SIZE_TYPE__. For example,
>   file1: yes 'int' type
>   file2: no 'int' type
>
> In serial mode, file1 is processed first, followed by file2.
> both will have 'int' type as the array index type since file2
> will inherit the index type from file1.
>
> In parallel mode though, arrays in file1 will have index type 'int',
> and arrays in file2 wil have index type '__ARRAY_SIZE_TYPE__'.
> This will prevent some legitimate dedup and may have generated
> vmlinux.h having compilation error.
>

I think it is two separate problems.

1. Maybe instead of this generating __ARRAY_SIZE_TYPE__ we should
generate proper 'int' type?

2. __builtin_va_list___2 shouldn't have happened, it's libbpf bug.
Libbpf handles __builtin_va_list specially (see
btf_dump_is_blacklisted()), so we need to fix libbpf to not get
confused if there are two __builtin_va_list copies in BTF.

> This patch fixed the issue by normalizing all array_index types
> to be the first array_index type in the whole btf.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  btf_encoder.c | 24 +++++++++++++++++++++---
>  btf_encoder.h |  2 +-
>  pahole.c      |  2 +-
>  3 files changed, 23 insertions(+), 5 deletions(-)
>

[...]
