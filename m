Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE73D46E2E5
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 08:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhLIHKc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 02:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhLIHKc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Dec 2021 02:10:32 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F38C061746
        for <bpf@vger.kernel.org>; Wed,  8 Dec 2021 23:06:59 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id f9so11466341ybq.10
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 23:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bh7KiQx9BaUsPvjfimgMkq68BMARjRsaI0nKpdgB4T8=;
        b=RqIyjTCl+R2tHrOPrR7w01v00TLY92K4SrCU9aaDRXXvD+ls5tK4w8kIgWazNbJK2q
         1+Dux25VqTr1naB0f1hoMeMN6cREukaUJvJyGvRFsxz2csMe8hqL8bqxMjIGQ7FVPQr9
         JystjwcX8tug20B2PI2lvirK9Q2xsTwPGdiW6xEzmmqWAFElHLvtN4WukNAVWI1nJQcP
         hk1eaN4lALa9t8VEiGQEqiDod5mtSgOqPvcFwdDGVxVoOD8vqiv1oo3RHExWLnvhoOd2
         i9AsPvLxqqFIXeZXNHwjSBM6hB9HPI1qKDlOVnvw+d/fzZu4bX+Q3WRsrdA8oAp3F2Ov
         8YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bh7KiQx9BaUsPvjfimgMkq68BMARjRsaI0nKpdgB4T8=;
        b=Tp4JDtyIck5hfH+mtilXMnhdZPKOeTWmW5exqan350/dVgUT9zIy87rvKxDsdtQ0H1
         hoPLEDcEqvh+GUwpnQ0pu5Cax+bhfbH5AT+FjqAw/PBN+bSuLtXn6NM4tTMd+s3gNc2b
         TVZwWhPYN3PXBE+yU3IuInHy7P878+BNXypydjaCsQpbZQiFkGnizU1Y0O8D1ttZSsUv
         a0xw7B19lm2W2XgsVwQEWTl28eDypCFn2IaQfAesQzqc2RHdxKY5wJFttK8vEcVMh+S2
         QABGVoyAG0Uo9EJjMyjtm9KknO8uuIFk0Jj5p84kggglJYcDFHyjw0J73aCB2X3TIvVf
         Eciw==
X-Gm-Message-State: AOAM533nfqpd9V1Bbj6+5jOEnOo5Yuvu2G4iTwwpHWdi2pY7iaR5ZapT
        QPAakdCotkvPSUqLP1OHAVLiqBQb5Bgnr9q6TJw=
X-Google-Smtp-Source: ABdhPJwcA8B2C/iSuGMQA/ihYpDon5Y3AXBJWEreIkibtkJ5VL2KBdeM0yQ4Tn8TtK5uvIvr8StN8kWVxscU560pmSg=
X-Received: by 2002:a25:cf46:: with SMTP id f67mr4189669ybg.362.1639033618497;
 Wed, 08 Dec 2021 23:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20211209050403.1770836-1-yhs@fb.com>
In-Reply-To: <20211209050403.1770836-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Dec 2021 23:06:47 -0800
Message-ID: <CAEf4BzZ7RmpE1k1+f-3AE=QN3p3Wqa78KPh8xC2Euzu-iua8PQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a compilation warning
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 8, 2021 at 9:04 PM Yonghong Song <yhs@fb.com> wrote:
>
> The following warning is triggered when I used clang compiler
> to build the selftest.
>
>   /.../prog_tests/btf_dedup_split.c:368:6: warning: variable 'btf2' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>         if (!ASSERT_OK(err, "btf_dedup"))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /.../prog_tests/btf_dedup_split.c:424:12: note: uninitialized use occurs here
>         btf__free(btf2);
>                   ^~~~
>   /.../prog_tests/btf_dedup_split.c:368:2: note: remove the 'if' if its condition is always false
>         if (!ASSERT_OK(err, "btf_dedup"))
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /.../prog_tests/btf_dedup_split.c:343:25: note: initialize the variable 'btf2' to silence this warning
>         struct btf *btf1, *btf2;
>                                ^
>                                 = NULL
>
> Initialize local variable btf2 = NULL and the warning is gone.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Added:

Fixes: 9a49afe6f5a5 ("selftests/bpf: Add btf_dedup case with
duplicated structs within CU")

and pushed to bpf-next. Thanks.

>  tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> index 878a864dae3b..90aac437576d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> @@ -340,7 +340,7 @@ static void btf_add_dup_struct_in_cu(struct btf *btf, int start_id)
>
>  static void test_split_dup_struct_in_cu()
>  {
> -       struct btf *btf1, *btf2;
> +       struct btf *btf1, *btf2 = NULL;
>         int err;
>
>         /* generate the base data.. */
> --
> 2.30.2
>
