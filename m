Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBEB4AA252
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 22:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbiBDVcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 16:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbiBDVcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 16:32:05 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27B5C061714
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 13:32:03 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z7so5954811ilb.6
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 13:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLAQ/qfECVQ3m5fZagBtede3QZNKbP2YtA6i8sy4ENc=;
        b=b8+EyVh68rUr8diHZPaan486c7aiAO/EWzXPSSpRoWhuSNJddCqXq2iWhN1oWVqIwj
         ewoBExm3w0zNQjZjCmnVZoFFrbm7T1I+wV/bMl4EwHykHaJVh0xPb9OsrvPQUZDXCuQn
         6YcBrA66U+zJ3MaA4Yb4UXeUHU4yU32QCx+w/qFbd8hFTHmuc+Bg6xSIXGTD0Kyq+wPC
         x1Rrrx6Q1QeXs/RzDD6cuacZETbvTh8IAYH/7361w8f3j0cDCccgF4TP5SoKq8ZTesqV
         gV+gC7zW2h7qhIdvHNwaBg0XJVCdRHqyUQQH1BJs8WI2P5aAzdGKIkC21eKu+Yzv1gZL
         jTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLAQ/qfECVQ3m5fZagBtede3QZNKbP2YtA6i8sy4ENc=;
        b=tAsoBtCaD9PvhpXYepFSp3VzbojvvwOokcltJe3X/WImDR4raB+xYUytjwrrW6kXcw
         XVffbYs7AfzS4GUqnTdtI1oHM7baaZOK8l5bGJJu2nuvHYKj3PvNks3Z1kuQW0IH8k/o
         Y+ieGWmY7Yuj3mQwWXzSEbdnWVsBHrSlHIeMnzbKtsVrsiCcPYZa3XrF1u6CZ8bHUYVi
         Duxch/C1cy9H9y/xGMzdpBZF4m39j+mzOOCnf7ZII2CPYOGG9uyXGXJUBA43IUi73sHF
         3SjUSzLBb8O1EKNEx+AaNE6qokwHumMY3S+j/29X0Gq0N+aW+XO1H22eyj/T4e0ks0Zt
         3QUA==
X-Gm-Message-State: AOAM533bjyFouuNblJr/6uBRUobniKFFbKwKAKfjLYuP/Goa/z1kYvlA
        H8HhCoyBdpQ/Z52uGT39COwuqddIf+nvypV0uwA=
X-Google-Smtp-Source: ABdhPJzEBQ/HSdVoR6jUXtfHy9qrb0MxUIT1MOs+xnn5vz4nhJUvFA3QGYtNHjXtVldy00MypFrFDm2ueatElQ+G9sI=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr526623ilu.71.1644010323089;
 Fri, 04 Feb 2022 13:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20220204211302.302066-1-yhs@fb.com>
In-Reply-To: <20220204211302.302066-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Feb 2022 13:31:51 -0800
Message-ID: <CAEf4BzZOYAoHtH9HT52j22FHj2rT=RJpZHK7ZUoY2cvrmbuxWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix build issue with llvm-readelf
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 4, 2022 at 1:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> There are cases where clang compiler is packaged in a way
> readelf is a symbolic link to llvm-readelf. In such cases,
> llvm-readelf will be used instead of default binutils readelf,
> and the following error will appear during libbpf build:
>
>   Warning: Num of global symbols in
>    /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/sharedobjs/libbpf-in.o (367)
>    does NOT match with num of versioned symbols in
>    /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.so libbpf.map (383).
>    Please make sure all LIBBPF_API symbols are versioned in libbpf.map.
>   --- /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf_global_syms.tmp ...
>   +++ /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf_versioned_syms.tmp ...
>   @@ -324,6 +324,22 @@
>    btf__str_by_offset
>    btf__type_by_id
>    btf__type_cnt
>   +LIBBPF_0.0.1
>   +LIBBPF_0.0.2
>   +LIBBPF_0.0.3
>   +LIBBPF_0.0.4
>   +LIBBPF_0.0.5
>   +LIBBPF_0.0.6
>   +LIBBPF_0.0.7
>   +LIBBPF_0.0.8
>   +LIBBPF_0.0.9
>   +LIBBPF_0.1.0
>   +LIBBPF_0.2.0
>   +LIBBPF_0.3.0
>   +LIBBPF_0.4.0
>   +LIBBPF_0.5.0
>   +LIBBPF_0.6.0
>   +LIBBPF_0.7.0
>    libbpf_attach_type_by_name
>    libbpf_find_kernel_btf
>    libbpf_find_vmlinux_btf_id
>   make[2]: *** [Makefile:184: check_abi] Error 1
>   make[1]: *** [Makefile:140: all] Error 2
>
> The above failure is due to different printouts for some ABS
> versioned symbols. For example, with the same libbpf.so,
>   $ /bin/readelf --dyn-syms --wide tools/lib/bpf/libbpf.so | grep "LIBBPF" | grep ABS
>      134: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LIBBPF_0.5.0
>      202: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LIBBPF_0.6.0
>      ...
>   $ /opt/llvm/bin/readelf --dyn-syms --wide tools/lib/bpf/libbpf.so | grep "LIBBPF" | grep ABS
>      134: 0000000000000000     0 OBJECT  GLOBAL DEFAULT   ABS LIBBPF_0.5.0@@LIBBPF_0.5.0
>      202: 0000000000000000     0 OBJECT  GLOBAL DEFAULT   ABS LIBBPF_0.6.0@@LIBBPF_0.6.0
>      ...
> The binutils readelf doesn't print out the symbol LIBBPF_* version and llvm-readelf does.
> Such a difference caused libbpf build failure with llvm-readelf.
>
> To fix the issue, let us do proper filtering for LIBBPF_*@@LIBBPF_* symbols.
> The proposed fix works for both binutils readelf and llvm-readelf.
>
> Reported-by: Delyan Kratunov <delyank@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index f947b61b2107..d1577c26c16b 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -132,7 +132,8 @@ GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
>  VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
>                               sed 's/\[.*\]//' | \
>                               awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}' | \

have you tried just doing !/UND|ABS/ here?

> -                             grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
> +                             grep -Eo '[^ ]+@LIBBPF_' | grep -Ev '^LIBBPF_' | \
> +                             cut -d@ -f1 | sort -u | wc -l)
>
>  CMD_TARGETS = $(LIB_TARGET) $(PC_FILE)
>
> @@ -195,7 +196,8 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
>                 readelf --dyn-syms --wide $(OUTPUT)libbpf.so |           \
>                     sed 's/\[.*\]//' |                                   \
>                     awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
> -                   grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |             \
> +                   grep -Eo '[^ ]+@LIBBPF_' | grep -Ev '^LIBBPF_' |     \
> +                   cut -d@ -f1 |                                        \
>                     sort -u > $(OUTPUT)libbpf_versioned_syms.tmp;        \
>                 diff -u $(OUTPUT)libbpf_global_syms.tmp                  \
>                      $(OUTPUT)libbpf_versioned_syms.tmp;                 \
> --
> 2.30.2
>
