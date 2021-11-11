Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB944DBDD
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhKKS63 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhKKS63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 13:58:29 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64C3C0613F5
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:55:39 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id y68so12222143ybe.1
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inO6BvEs5cIIUViacdtgZS7eKa2eoaKBpoYeKalYyHA=;
        b=VH2Ev01vvieYmSq0zgDXBpSuSPeYwXj2KWwgeoX07aa309pUjVxYOv9hJllRtHF/dI
         mzYl8IHT4tAjnOf4b/k5QhtbmiMx4A4eJ9T7UX+3V2L8Lr3olN6Fr1p4+caLRPYFbhWb
         d80hmw9ptWOsv0Se/AAPhZDL2pbdd/RX2/OdplEL0UQ7Tbo/Et99ZxgL9oZnwnYio23P
         iYY9xOoLT74cDKQS46dhcrcOrfKwr7cGGIbZs9xC56GbNj0qQ9K7de6i0Bh+M8KtB0Ww
         f9SPEMUzddxwzbBGSl1UEXbtFIFIDKV/xWOZ6tJ0FisU38SvKn7p5KPby95T+D+QqSKQ
         hAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inO6BvEs5cIIUViacdtgZS7eKa2eoaKBpoYeKalYyHA=;
        b=K+aQWbI4M8LX7eCuGiD33GLTz6DQcjTNu7u7Fe6Mn0earooUZt37OLDeFsnmCHcHqn
         2OhNMMd2FHR9EvE3nJg+lUq78vpYY2GSmwLRkWBPIp5B584++zcABURoRuxZ3xtf94SZ
         4zsITQwUMh9vgGjGSTS7QmXxJ09QBHiYlvrYAtYCXPFav7kTkA8JQbJoYjp9NLWdhGUe
         /g4PN4rPTpBn9qdPzcn+noOofzRKNh2+d9T1oBWyZEWD8iYrMUJmDwnhFmoEKGXdZggz
         8DLUH2V1PCyE6OPPC5Ibz3MYvJMFLequSMs0sR+h3QF1c26oJI2VX7dJNXaa7P2oZsSt
         C9qg==
X-Gm-Message-State: AOAM531h4rhf+TEh2yT1iuuJHxIBf1F41HOoTY3iKaPu2u+Fb7Pztipi
        liq4tCdYlWKih85fm0SwiZT+Td9eC9t0x6555Xz0Uoaz
X-Google-Smtp-Source: ABdhPJwqrbjE/5jU4KALumFGtJqPzRHmM2eZz+uqzflqEOEQp0Qhin59+H4y7wAACqICGtkcsIpExApHIcR14RgV2tU=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr9380544ybj.433.1636656938919;
 Thu, 11 Nov 2021 10:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110052022.372373-1-yhs@fb.com>
In-Reply-To: <20211110052022.372373-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Nov 2021 10:55:27 -0800
Message-ID: <CAEf4BzbaATS=A1R-rEOuwp6ZTwMLd2jXRUOykfxGHZ8qS9LJPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/10] selftests/bpf: Add a C test for btf_type_tag
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:21 PM Yonghong Song <yhs@fb.com> wrote:
>
> For the C test, compiler the kernel and selftest with clang compiler
> by adding LLVM=1 to the make command line since btf_type_tag is
> only supported by clang compiler now.

I'm confused. Why does kernel compilation matter at all? And then for
progs/*.c we always compile with Clang anyway (except for unused
gcc_bpf flavor, but that's separate). So what am I missing?

>
> The following is the key btf_type_tag usage:
>   #define __tag1 __attribute__((btf_type_tag("tag1")))
>   #define __tag2 __attribute__((btf_type_tag("tag2")))
>   struct btf_type_tag_test {
>        int __tag1 * __tag1 __tag2 *p;
>   } g;
>
> The bpftool raw dump with related types:
>   [4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>   [11] STRUCT 'btf_type_tag_test' size=8 vlen=1
>           'p' type_id=14 bits_offset=0
>   [12] TYPE_TAG 'tag1' type_id=16
>   [13] TYPE_TAG 'tag2' type_id=12
>   [14] PTR '(anon)' type_id=13
>   [15] TYPE_TAG 'tag1' type_id=4
>   [16] PTR '(anon)' type_id=15
>   [17] VAR 'g' type_id=11, linkage=global
>
> With format C dump, we have
>   struct btf_type_tag_test {
>         int __attribute__((btf_type_tag("tag1"))) * __attribute__((btf_type_tag("tag1"))) __attribute__((btf_type_tag("tag2"))) *p;
>   };
> The result C code is identical to the original definition except macro's are gone.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/btf_tag.c        | 24 +++++++++++++++
>  .../selftests/bpf/progs/btf_type_tag.c        | 29 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
> index d15cc7a88182..88d63e23e35f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_tag.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
> @@ -3,6 +3,12 @@
>  #include <test_progs.h>
>  #include "btf_decl_tag.skel.h"
>
> +/* struct btf_type_tag_test is referenced in btf_type_tag.skel.h */
> +struct btf_type_tag_test {
> +        int **p;
> +};
> +#include "btf_type_tag.skel.h"
> +
>  static void test_btf_decl_tag(void)
>  {
>         struct btf_decl_tag *skel;
> @@ -19,8 +25,26 @@ static void test_btf_decl_tag(void)
>         btf_decl_tag__destroy(skel);
>  }
>
> +static void test_btf_type_tag(void)
> +{
> +       struct btf_type_tag *skel;
> +
> +       skel = btf_type_tag__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "btf_type_tag"))
> +               return;
> +
> +       if (skel->rodata->skip_tests) {
> +               printf("%s:SKIP: btf_type_tag attribute not supported", __func__);
> +               test__skip();
> +       }
> +
> +       btf_type_tag__destroy(skel);
> +}
> +
>  void test_btf_tag(void)
>  {
>         if (test__start_subtest("btf_decl_tag"))
>                 test_btf_decl_tag();
> +       if (test__start_subtest("btf_type_tag"))
> +               test_btf_type_tag();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag.c b/tools/testing/selftests/bpf/progs/btf_type_tag.c
> new file mode 100644
> index 000000000000..0e18c777862c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/btf_type_tag.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#ifndef __has_attribute
> +#define __has_attribute(x) 0
> +#endif

is this necessary, doesn't the minimum Clang/GCC version that we
support have __has_attribute already?

> +
> +#if __has_attribute(btf_type_tag)
> +#define __tag1 __attribute__((btf_type_tag("tag1")))
> +#define __tag2 __attribute__((btf_type_tag("tag2")))
> +volatile const bool skip_tests = false;
> +#else
> +#define __tag1
> +#define __tag2
> +volatile const bool skip_tests = true;
> +#endif
> +
> +struct btf_type_tag_test {
> +       int __tag1 * __tag1 __tag2 *p;
> +} g;
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(sub, int x)
> +{
> +  return 0;
> +}
> --
> 2.30.2
>
