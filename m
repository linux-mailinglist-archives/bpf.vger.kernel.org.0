Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62661525809
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 00:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359332AbiELWz3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 18:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356737AbiELWz1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 18:55:27 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082AB285AC5;
        Thu, 12 May 2022 15:55:26 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e194so6960361iof.11;
        Thu, 12 May 2022 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DnPdveEL3mkXzws6W5Z1XkwFEnMGc2N+Jff4vCU64+A=;
        b=kjxp60UKv6LJ4y0RoJDRdeYJkukQsOI0sauds2PBkAp9ZrUsBSc15UDtZa9s2gaXJW
         JC5KxGvielqxaJvSgomWSACr3Af+OPFUaxoSeG9snrrj7RP2hEVXEUY2lt3SMZTN8kcl
         42dOd2lZa8cOn7ensFPNVWiaDcTD0ILLCL69ZOxJWU+AxcSyDKGP3J4emR7hBKJqaRmk
         16qqyhPNYK8BRoJ1UcWiM6TLCw/iO+4AwXcKPnvQtym4eROE745BYxH6Kb+RBw7pE6D0
         qi4+/Kw5TUrIcvf7w3+pU5M+EjAcHsUp4mdLzyKsyliwXvDQQS272Hq1+xHj1wnfXrtd
         BRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnPdveEL3mkXzws6W5Z1XkwFEnMGc2N+Jff4vCU64+A=;
        b=7Pl9/BK3r7cS3YN/m8YtKw+hQgrg26D9UjrXmDS2zuYAlmZTo3lXggJEEd2iIlM4oj
         yLFhnZvu67VxDUNNKsTTEXlRX/8S/bCLfsw8Yli+WmUHYyMOLF2YLnBw08ZRPGI0tli8
         DDL5d7Hqh1TmFb8c1GSG4Xle3/RDSMm4sVerKx7wzSnNJYAVsH52jq5yeUfzbM9yX/FM
         gjbPhUo7qgKjaoAp/VLBexcm0tG6Ge/fY85/LC4gnjMh8puqvRdBPlb5LLFqlf4rhUpi
         Gq4r3m3008DC6tw4/CFmcaTGzauVmxAQqRP0IFJ5HaQiqbhaHwFvDh/NwqYoP5565oH1
         SKGA==
X-Gm-Message-State: AOAM533UoaoAXlMOUTejOqQu5Rx757Ry4u4x5CayWoVjIesRJAoAFkQq
        adFz2soZRKPMBAoZ3nHZizvFRH9Hs9W52uR8ULhMmrGrVdY=
X-Google-Smtp-Source: ABdhPJxoosVwHOcgZixwjQfq4cmnEttrjNbGpsnpT2FlQZzQkXUKKgXiZ8u3aYCw3YH8NeK7A3ST8c3s7thPhOr/Fqo=
X-Received: by 2002:a05:6602:1695:b0:65d:cbd3:eed0 with SMTP id
 s21-20020a056602169500b0065dcbd3eed0mr1053767iow.144.1652396125375; Thu, 12
 May 2022 15:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220512051759.2652236-1-yhs@fb.com> <20220512051804.2653507-1-yhs@fb.com>
In-Reply-To: <20220512051804.2653507-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 May 2022 15:55:14 -0700
Message-ID: <CAEf4Bzbr1M-WZLk1CRbSy5Ai8CCAH6JJH_=hGJ0rgQtriV8Ndg@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 2/2] btf_encoder: Normalize array index type
 for parallel dwarf loading case
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

On Wed, May 11, 2022 at 10:18 PM Yonghong Song <yhs@fb.com> wrote:
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
> Note that two array index_type_id's are different so the va_list and __builtin_va_list
> will have two versions in the BTF. With this, vmlinux.h contains the following code,
>   typedef __builtin_va_list va_list;
>   typedef __builtin_va_list___2 va_list___2;
> Since __builtin_va_list is a builtin type for the compiler,
> libbpf does not generate
>   typedef <...> __builtin_va_list
> and this caused __builtin_va_list___2 is not defined and hence compilation error.
> This happened when pahole is running with more than one jobs when parsing dwarf
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
> This patch fixed the issue by creating an 'int' type as the
> array index type, so all array index type should be the same
> for all cu's even in parallel mode.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  btf_encoder.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

LGTM, it should work reliably.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Changelog:
>   v1 -> v2:
>    - change creation of array index type to be 'int' type,
>      the same as the type encoder tries to search in the current
>      types.
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 1a42094..9e708e4 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1460,7 +1460,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>
>                 bt.name = 0;
>                 bt.bit_size = 32;
> -               btf_encoder__add_base_type(encoder, &bt, "__ARRAY_SIZE_TYPE__");
> +               bt.is_signed = true;
> +               btf_encoder__add_base_type(encoder, &bt, "int");
>                 encoder->has_index_type = true;
>         }
>
> --
> 2.30.2
>
