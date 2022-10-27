Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87C1610643
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJ0XO0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 19:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiJ0XOZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 19:14:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B0B7F4C
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 16:14:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l11so4262224edb.4
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l5p6o9GBw4SLMOA7oeHqLz5IYlnA3AQEElExsPZII5M=;
        b=BWMvnE3L1C+/sx0iglVZKZYHaegao8/fVuzCJ2zAh+/8p5CwAmwA90OusFIQPieFur
         4BFgMwwq0Pw1w+CVti+ixGwZxZIUs5Ddx7GdL4Bmma/asMQzk7VFld5+jywtAaFiD6Wh
         cXy6/aHZzq0bY6hmmfJED9bGFV4gL5kF8T9kCPFub2FTmdP53WntrCUERkBqB33MYidq
         PYTiqIuOU4URdhBGpNzkZb1LBT7ZEj0Rl8E7umUiqt4eiXi37Hawa4h6q+Qn16Vq4m71
         r/NX60sNHDVhNeocka6nkBGYex2r7zq2/6bA/HFs7b740031ZB6fkclQIbeQmOARzzoA
         rgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5p6o9GBw4SLMOA7oeHqLz5IYlnA3AQEElExsPZII5M=;
        b=b4CFIJ9vo09jdal62pGMgRky8ptmLUhSr7eYZ9B2OSxNoy17bwYg/akIKk+wS19atJ
         VS5FHXfVCWQUbdcyAKoOlMZpT3mLTA8qcz5pjGQ56X1ZIK7iMSW8/5WP6AbOEH7N/maA
         jUqzFglUZNaJZsazaLn5zKiTUkaeGLV++2dHvfXyU4QYmXbvZ7qLFc2bwvU2U7aFR4Wk
         g50FdamZ5Ej+iJvuraXgJ+ui+f8SvEWqWoJPgaezuiYwHnnZyV/44ghQwXEf1xKCuNDZ
         FWu8pP0bkL53jPoaEMvg5rpzyHVK1fwwSuY9EBzzymKLLQagZZKnI8rPcKvRl4Zqynx/
         qowA==
X-Gm-Message-State: ACrzQf3aVsGBQ3tUlTutR+LR3HFKRNFteSxaj855eVNROh6qzkB6bF5S
        yw+oGwNtFIattgTvD4+Lp5aicRa2AGekxBSQeVY=
X-Google-Smtp-Source: AMsMyM44Uy39LGuqSKEytLZRwZMknD6vwlElRbljHwb+AhvIVSuS3+L6fzsskd5RFN+ebN9rzXdgV0to1F2fMV3NzKQ=
X-Received: by 2002:a05:6402:5248:b0:461:f0fa:864e with SMTP id
 t8-20020a056402524800b00461f0fa864emr17974085edd.81.1666912462296; Thu, 27
 Oct 2022 16:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221025222802.2295103-1-eddyz87@gmail.com>
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Oct 2022 16:14:10 -0700
Message-ID: <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
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

On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Hi BPF community,
>
> AFAIK there is a long standing feature request to use kernel headers
> alongside `vmlinux.h` generated by `bpftool`. For example significant
> effort was put to add an attribute `bpf_dominating_decl` (see [1]) to
> clang, unfortunately this effort was stuck due to concerns regarding C
> language semantics.
>

Maybe we should make another attempt to implement bpf_dominating_decl?
That seems like a more elegant solution than any other implemented or
discussed alternative. Yonghong, WDYT?

BTW, I suggest splitting libbpf btf_dedup and btf_dump changes into a
separate series and sending them as non-RFC sooner. Those improvements
are independent of all the header guards stuff, let's get them landed
sooner.

> After some discussion with Alexei and Yonghong I'd like to request
> your comments regarding a somewhat brittle and partial solution to
> this issue that relies on adding `#ifndef FOO_H ... #endif` guards in
> the generated `vmlinux.h`.
>

[...]

> Eduard Zingerman (12):
>   libbpf: Deduplicate unambigous standalone forward declarations
>   selftests/bpf: Tests for standalone forward BTF declarations
>     deduplication
>   libbpf: Support for BTF_DECL_TAG dump in C format
>   selftests/bpf: Tests for BTF_DECL_TAG dump in C format
>   libbpf: Header guards for selected data structures in vmlinux.h
>   selftests/bpf: Tests for header guards printing in BTF dump
>   bpftool: Enable header guards generation
>   kbuild: Script to infer header guard values for uapi headers
>   kbuild: Header guards for types from include/uapi/*.h in kernel BTF
>   selftests/bpf: Script to verify uapi headers usage with vmlinux.h
>   selftests/bpf: Known good uapi headers for test_uapi_headers.py
>   selftests/bpf: script for infer_header_guards.pl testing
>
>  scripts/infer_header_guards.pl                | 191 +++++
>  scripts/link-vmlinux.sh                       |  13 +-
>  tools/bpf/bpftool/btf.c                       |   4 +-
>  tools/lib/bpf/btf.c                           | 178 ++++-
>  tools/lib/bpf/btf.h                           |   7 +-
>  tools/lib/bpf/btf_dump.c                      | 232 +++++-
>  .../selftests/bpf/good_uapi_headers.txt       | 677 ++++++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++
>  .../selftests/bpf/prog_tests/btf_dump.c       |  11 +-
>  .../bpf/progs/btf_dump_test_case_decl_tag.c   |  39 +
>  .../progs/btf_dump_test_case_header_guards.c  |  94 +++
>  .../bpf/test_uapi_header_guards_infer.sh      |  33 +
>  .../selftests/bpf/test_uapi_headers.py        | 197 +++++
>  13 files changed, 1816 insertions(+), 12 deletions(-)
>  create mode 100755 scripts/infer_header_guards.pl
>  create mode 100644 tools/testing/selftests/bpf/good_uapi_headers.txt
>  create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
>  create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c
>  create mode 100755 tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh
>  create mode 100755 tools/testing/selftests/bpf/test_uapi_headers.py
>
> --
> 2.34.1
>
