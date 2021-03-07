Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CC632FE8D
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 04:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhCGDVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Mar 2021 22:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhCGDVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Mar 2021 22:21:32 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27526C06174A
        for <bpf@vger.kernel.org>; Sat,  6 Mar 2021 19:21:32 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id c131so6435557ybf.7
        for <bpf@vger.kernel.org>; Sat, 06 Mar 2021 19:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Mo6EA6KmNnajY0pYkcBcIsjRiUPRnigfnPlRYPc5ZQ=;
        b=CB2CyrUt+vbnZpYSYNJfR4xOn2V/dyMCSmvezuZAE+gy3IYm0QmVc0NUALtWRfJ++x
         L7j2iMIn8CgsRJWLqvgcLjOAfiQN2dL/MMNHXEZpM3O9mgU2WBGn0WDiQOVyv6ENLgtj
         pe3nw5cCyxYTQGDw8sYy+Y6OSwsiKSOFOSRTVDWTZmMqyIJUGaKaAZg5zyfnpnQ3UXgQ
         7N7kgtbqi9xSDRoVw8evwshtD51/HbqCrCjutcIle5ciqn7l1Ks5hn79erbLGmQ+VDF8
         ihuWrnJFoTkCF0GzMpgZO637Vf6hu3X1aZ4T5Wh3YT513sohgp6Ycrg28Cj/8bJHfKik
         0uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Mo6EA6KmNnajY0pYkcBcIsjRiUPRnigfnPlRYPc5ZQ=;
        b=igRCR8CmXflyORHg36+z/eXFzwY68SC+8WonpAtXWd+ParJMGzLzYv0TZYHuW89eIR
         KESAni8+YCMV0ZkLQUycMjYQE/BejX+jbElzlFjplo0/XoJkm9c0mmr4wIhqFAwW6kuH
         4i6phIZLBe6Ymz2acAsuOhBWmdCEKl2hL//SzMhdYBaffYuICIQ+/Extm88+G7lCyd9I
         n0CNNqDLi5MjJoNAUy9tsvAOQwHg76s4jVUH7/r1pUm7qvrEAauS34Y92dxx6bmSuEfZ
         E92u5riPosNJoXaI4+xc4kcak20KC4rI3Pfhr+p720dhbg7DYSpEinXHgWKmjxjvLO0n
         sieg==
X-Gm-Message-State: AOAM531NvdZrEtmjScbsTRZl8+CudmebdYfmTXgR0S4/7WlG5fACA7sv
        3oJwF79DhU2nUc2Ihe6V5dbHNb9z16rmo92OIPM=
X-Google-Smtp-Source: ABdhPJyG+jWhl65w7ApMvOUl8OW5OmSdOBm7KSJ2Mh9jUfKI8YuWc/pzXey/vh1hRhNGSTY4RST2Zxnz0CfRIflaag4=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr23372030yba.510.1615087291282;
 Sat, 06 Mar 2021 19:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20210305170844.151594-1-iii@linux.ibm.com> <20210305170844.151594-2-iii@linux.ibm.com>
In-Reply-To: <20210305170844.151594-2-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 6 Mar 2021 19:21:20 -0800
Message-ID: <CAEf4Bzb8LdOq1oX0jCKM9RyejUSJtciwdku+c0bEtyvW0jCzwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Add BTF_KIND_FLOAT to test_core_reloc_size
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 5, 2021 at 9:12 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Verify that bpf_core_field_size() is working correctly with floats.
> Also document the required clang version.
>
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/README.rst                   | 9 +++++++++
>  tools/testing/selftests/bpf/prog_tests/core_reloc.c      | 1 +
>  tools/testing/selftests/bpf/progs/core_reloc_types.h     | 5 +++++
>  tools/testing/selftests/bpf/progs/test_core_reloc_size.c | 3 +++
>  4 files changed, 18 insertions(+)
>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
> index 9a2850850121..3a2149c5863c 100644
> --- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
> +++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
> @@ -807,6 +807,7 @@ struct core_reloc_size_output {
>         int arr_elem_sz;
>         int ptr_sz;
>         int enum_sz;
> +       int float_sz;
>  };
>
>  struct core_reloc_size {
> @@ -816,6 +817,7 @@ struct core_reloc_size {
>         int arr_field[4];
>         void *ptr_field;
>         enum { VALUE = 123 } enum_field;
> +       float float_field;
>  };
>
>  struct core_reloc_size___diff_sz {
> @@ -825,6 +827,7 @@ struct core_reloc_size___diff_sz {
>         char arr_field[10];
>         void *ptr_field;
>         enum { OTHER_VALUE = 0xFFFFFFFFFFFFFFFF } enum_field;
> +       float float_field;

here the point is to test differently sized field, so it would be good
to have `double float_field;` instead

>  };
>
>  /* Error case of two candidates with the fields (int_field) at the same
> @@ -839,6 +842,7 @@ struct core_reloc_size___err_ambiguous1 {
>         int arr_field[4];
>         void *ptr_field;
>         enum { VALUE___1 = 123 } enum_field;
> +       float float_field;
>  };
>
>  struct core_reloc_size___err_ambiguous2 {
> @@ -850,6 +854,7 @@ struct core_reloc_size___err_ambiguous2 {
>         int arr_field[4];
>         void *ptr_field;
>         enum { VALUE___2 = 123 } enum_field;
> +       float float_field;
>  };
>
>  /*

[...]
