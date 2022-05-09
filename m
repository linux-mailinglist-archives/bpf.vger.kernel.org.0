Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F93520970
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiEIXnm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 19:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiEIXll (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 19:41:41 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3A4266E11
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:35:00 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r17so10331633iln.9
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hP5zQedd+rYC1S4HRPBg88V0KJRyjXXiHVufb/6WnaY=;
        b=gj5j5J5gQRdPKiMmQtJOwX1i+40eDtpywNG6QRGqeVfXUikEofYz7XQMoJD/G9sHRK
         oG52XI0jFFIvf5+7cFnZSR8z8lYxMzYDGcf4rov3ULif1UhOUnb2EajmwmsDlWUbC3cM
         glkc5dABuPxmg7ykxjADJ/BQ0l5OapA6GNA7IWCY/dgQWXEsoKEjrob7TF0QE0PUiFOJ
         UgpATFLSVJ65Q1pDxjRBJ6Bk9kStLorzhgzhF0y7E3eD4xwwtuqL1OMB8csIea0VSs31
         r4agNaT3UBf3OvbjuSeVjhKyD7zyJDZ3k2gRvDjNsdtD69JikgRAszgeJuM9xwpFk++4
         X1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hP5zQedd+rYC1S4HRPBg88V0KJRyjXXiHVufb/6WnaY=;
        b=gVcng/hYoZWgr9N+TTw3FscGBKGjC3shne0Hkj3okD43T4Ltidm4KLJMdcQuJJlmz2
         f5eeiLZqChPnvbLSIapFA34Ym3yr/hlC6qhg3y2fFG4abGs5B49RUM8iS3GLlmFAn29b
         4hFxhWsb1VcLtNQPeyksAZUcg+R3AZJvwMAYaqh3aRMVHPR2WKWdYM0KqC/RELumXo7v
         besoHNT0ehdK6cktK2k7vuoyJL47WLaZaR3LxG0u2QN6ImdSCdx0GDHIXwYYjAI+kkwK
         2Xjw2a1X9VG6m8HzqX+phpDfpMp0XhUUKDLqV65LOK9p3q6EWRYdXt006GJLd0EVFpPS
         Svzw==
X-Gm-Message-State: AOAM532RtQbKnExJaox1Y3y78xkt8JfUJoYonC/gXJidV5k7M0DDbVwV
        fKlUE7fnMIbpeiHGNH5Epn04okYOpIa/Qy+nZCI=
X-Google-Smtp-Source: ABdhPJzA7G5qKT2hsauOwLDDDP6ADj+XqBO+JSACW5K7vCI2uD7xuQMkGz+/FGvRYX0I56l7UhY35UW/b8pu6Jh1QXw=
X-Received: by 2002:a05:6e02:1d8d:b0:2cf:2112:2267 with SMTP id
 h13-20020a056e021d8d00b002cf21122267mr7782939ila.239.1652139299461; Mon, 09
 May 2022 16:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190033.2579182-1-yhs@fb.com>
In-Reply-To: <20220501190033.2579182-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 16:34:48 -0700
Message-ID: <CAEf4BzYdMdx6jsr_2Rsq_AMif1aV+YvmoU21V8KRbRuWQB8v6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/12] selftests/bpf: Fix selftests failure
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>
> The kflag is supported now for BTF_KIND_ENUM.
> So remove the test which tests verifier failure
> due to existence of kflag.
>
> With enum64 support in kernel and libbpf,
> selftest btf_dump/btf_dump failed with
> no-enum64 support llvm for the following
> enum definition:
>  enum e2 {
>         C = 100,
>         D = 4294967295,
>         E = 0,
>  };
>
> With the no-enum64 support llvm, the signedness is
> 'signed' by default, and D (4294967295 = 0xffffffff)
> will print as -1. With enum64 support llvm, the signedness
> is 'unsigned' and the value of D will print as 4294967295.
> To support both old and new compilers, this patch
> changed the value to 268435455 = 0xfffffff which works
> with both enum64 or non-enum64 support llvm.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c  | 20 -------------------
>  .../bpf/progs/btf_dump_test_case_syntax.c     |  2 +-
>  2 files changed, 1 insertion(+), 21 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index ba5bde53d418..8e068e06b3e8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -2896,26 +2896,6 @@ static struct btf_raw_test raw_tests[] = {
>         .err_str = "Invalid btf_info kind_flag",
>  },
>
> -{
> -       .descr = "invalid enum kind_flag",
> -       .raw_types = {
> -               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),          /* [1] */
> -               BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_ENUM, 1, 1), 4),  /* [2] */
> -               BTF_ENUM_ENC(NAME_TBD, 0),
> -               BTF_END_RAW,
> -       },
> -       BTF_STR_SEC("\0A"),
> -       .map_type = BPF_MAP_TYPE_ARRAY,
> -       .map_name = "enum_type_check_btf",
> -       .key_size = sizeof(int),
> -       .value_size = sizeof(int),
> -       .key_type_id = 1,
> -       .value_type_id = 1,
> -       .max_entries = 4,
> -       .btf_load_err = true,
> -       .err_str = "Invalid btf_info kind_flag",
> -},
> -
>  {
>         .descr = "valid fwd kind_flag",
>         .raw_types = {
> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> index 1c7105fcae3c..4068cea4be53 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> @@ -13,7 +13,7 @@ enum e1 {
>
>  enum e2 {
>         C = 100,
> -       D = 4294967295,
> +       D = 268435455,
>         E = 0,
>  };

can you please also add btf_dump tests for >32-bit enums at the same
time? Both signed and unsigned?


>
> --
> 2.30.2
>
