Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E821426501D
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 22:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIJUEa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgIJUBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 16:01:55 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3EC061786
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 13:01:06 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id c17so4882197ybe.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwYQJNbGKe1uc+ehMFEmYhgcYpURmPzs3fUngECFASw=;
        b=AMyj2OWKYShQOyHjOabXROd0ncvtC34PBKwF+rVx87f2jcW6KrrW0HZM59tExyQ28A
         2e3GEc6q8nLQeEstQX0R6Fuhanzz7YDKDOAhCIVDAzq4j2RWCzbxh9X2WJmQ838Sucnv
         mk7Z37CZuOXEko4XWLGqlJ2g2iHUqkJkURZA+3jYfLs5WoGluh1wI1iWS6S9CD++f6zf
         dXHdW+6Sp+Md7uyx0C+e9arnSYUGtMDSonmCGaisL/Fmv6dTPhb69gLCgqDQ0N6Ww8PE
         JsZaumXs/Ee/j+L/MA/NEeDHZzGRTJAPtbvKn42L1kV847Tri0dsCz9xyEbOQ1rIJM9C
         Z9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwYQJNbGKe1uc+ehMFEmYhgcYpURmPzs3fUngECFASw=;
        b=drbAmKR68iGhB4mNIokjKFg/IpT8HNloHBJBdbUVxlM6sTM94p7WNmqpqMD+flSmdC
         rSmWqFI1In1zGBwZfTK3LaIQkGOjx2nuv7M5jKUmfLb6w0aE001ewBWqHJdvaAmJwyyO
         aKDcJtQYks/MmHTFbC30pH4TCJK3wDnMXCY6XxCxLOJ4EbwEw933cloSpFVY0+WEmiPT
         B+BNAVySKdD+YyTCZxYTH/cofOvYx2mzUz+CYEP/7U8A7Jv8GAjqYDvrwwrVYaPwi5Me
         KoS8QXdTsVMZPueixOgIUmGHkvfEmcriGihQS1a1agXzLsK+ZUmpmkM+Kyvn0yibXEJB
         iYVQ==
X-Gm-Message-State: AOAM5323Wp1Ng7CHr7lW9yD+qv6s9s6WkDbexI3fCClaDqSJAUpESSi9
        fRx8AH+qhFl+TnrPgrT7/0U+kWwDofJBIec+Zxc=
X-Google-Smtp-Source: ABdhPJxIYP6yFfPLPMbsB4OSpt4f5K7V4+wLcRXM6ImtdMv+2d8jrzzTDA6YJWC14kAReUmekmejtXSfVTFmUqzsnoY=
X-Received: by 2002:a25:6885:: with SMTP id d127mr14589944ybc.27.1599768065408;
 Thu, 10 Sep 2020 13:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200910171336.3161995-1-iii@linux.ibm.com>
In-Reply-To: <20200910171336.3161995-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Sep 2020 13:00:54 -0700
Message-ID: <CAEf4BzbNfKhGfMM2N=016NGA0X4jpK2Nu_=tXs1bLhxBZXgo=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix test_ksyms on non-SMP kernels
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 10:13 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On non-SMP kernels __per_cpu_start is not 0, so look it up in kallsyms.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/prog_tests/ksyms.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> index e3d6777226a8..b771804b2342 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> @@ -32,6 +32,7 @@ static __u64 kallsyms_find(const char *sym)
>
>  void test_ksyms(void)
>  {
> +       __u64 per_cpu_start_addr = kallsyms_find("__per_cpu_start");
>         __u64 link_fops_addr = kallsyms_find("bpf_link_fops");
>         const char *btf_path = "/sys/kernel/btf/vmlinux";
>         struct test_ksyms *skel;
> @@ -63,8 +64,9 @@ void test_ksyms(void)
>               "got %llu, exp %llu\n", data->out__bpf_link_fops1, (__u64)0);
>         CHECK(data->out__btf_size != btf_size, "btf_size",
>               "got %llu, exp %llu\n", data->out__btf_size, btf_size);
> -       CHECK(data->out__per_cpu_start != 0, "__per_cpu_start",
> -             "got %llu, exp %llu\n", data->out__per_cpu_start, (__u64)0);
> +       CHECK(data->out__per_cpu_start != per_cpu_start_addr, "__per_cpu_start",
> +             "got %llu, exp %llu\n", data->out__per_cpu_start,
> +             per_cpu_start_addr);
>
>  cleanup:
>         test_ksyms__destroy(skel);
> --
> 2.25.4
>
