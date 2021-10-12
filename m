Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46F0429C22
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 05:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhJLD6d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 23:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhJLD6U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 23:58:20 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D22C061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:56:18 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q189so43710868ybq.1
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxOYfubF7MJSGfHaRpWlkWAsoJlrbw2i0Vb2Cjv3OQY=;
        b=OfLW/vbeRLK9WWH6xz/yfJRASl8i/vfNX3ho1CnsndoWPVr/V4KE8JPjHuWmrJKOGP
         xf1N25RlwuzImm5tQrZAKtRHQmZVSj5PpSRen2+mx06nHX5El40eSUyQs7pYSMKonEev
         OcBUo6TmlWVGETS3yhydPGGjusfA6epzU0NJamYcJL93kZxgrWN375LJfty9tz49AuvD
         026ugd4z12jKDIHLsZbwsXts3rRpz3gKYx8GhurAuPawZKhRaUpdfu3RiDj9KBEjXr11
         s7FpcpR8HV6V2rDrk4A/mEoGUT85YnE4dDTZNTpouz+xyjNBgb39t3e2WSWnZTh3u5P+
         sdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxOYfubF7MJSGfHaRpWlkWAsoJlrbw2i0Vb2Cjv3OQY=;
        b=eDH1DHf8YLAK5NlBWXCZuWDiyOLRpqPc1/Hw7YyDieykznZyDs02YBgy177Gtezbw/
         w4hfclwTR7A0pN7XD3QsH2PXpxjgJvLjDWlSBcRYEc5IP6lMfBQV3Px/QPmWdwAKjs3u
         TWU8sMaKOgps53NMyJMjc8AhL92lK++2NjH2JFi1zjKFdiny0MXrnQI7e0S91O4PGGPd
         mFVcbIheSHePm/hy7RWto1WzFkM7SMvpw9BaFIH3EEmPFq74XTrYtbVqqk8BsOcEd5ie
         MUc1anu6HxTGsuXvQyuIp+P68GhGj9FH8BcYD+vYc3IGI2d1sEoEdOYPcA4CdvC54bv+
         SjJw==
X-Gm-Message-State: AOAM530MNpu61rJhuY6D6fi21DQS3xyjSMm7h1F/6ucT6h3r5F/Lg3/N
        qZx72BrFF6fQ7A984VPqp8Rl4mLk1oVa/vKOkj4=
X-Google-Smtp-Source: ABdhPJz+5zvIjHpZ8+1DGBZuTqA+pKVIvO08Ldn3c6HGuMf2/X+zTZZyOzbJ2v5kaKEWXgeWCJE3dmu/2A/Cd8JfulA=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr25720299ybf.455.1634010978090;
 Mon, 11 Oct 2021 20:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211012023218.399568-1-iii@linux.ibm.com> <20211012023218.399568-2-iii@linux.ibm.com>
In-Reply-To: <20211012023218.399568-2-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Oct 2021 05:56:07 +0200
Message-ID: <CAEf4BzY=npfWOSgPPEKZ9g44a5XQ_606agX840dLLCqJiDC++g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Use cpu_number only on arches
 that have it
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 12, 2021 at 4:51 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> cpu_number exists only on Intel and aarch64, so skip the test involing
> it on other arches. An alternative would be to replace it with an
> exported non-ifdefed primitive-typed percpu variable from the common
> code, but there appears to be none.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/btf_dump.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index 87f9df653e4e..12f457b6786d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -778,8 +778,10 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
>  static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
>                                    char *str)
>  {
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
>         TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
>                           "int cpu_number = (int)100", 100);
> +#endif

We are in the talks about supporting cross-compilation of selftests,
and this will be just another breakage that we'll have to undo.

Can we find some other variable that will be available on all
architectures? Maybe "runqueues"?

>         TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_profile_flip", int, BTF_F_COMPACT,
>                           "static int cpu_profile_flip = (int)2", 2);
>  }
> --
> 2.31.1
>
