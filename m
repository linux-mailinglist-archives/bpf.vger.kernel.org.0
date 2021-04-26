Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA7E36AF9C
	for <lists+bpf@lfdr.de>; Mon, 26 Apr 2021 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhDZIRp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Apr 2021 04:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhDZIRp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Apr 2021 04:17:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89FC061574
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 01:17:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a5so26055839ljk.0
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 01:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dci0jTaPQ1LF1SOSCmVyqguDpETXX8VuY92wwVPe54s=;
        b=u4BTT3cU0McS0gmu59hAKHH3pVQZU9S0WFQLxKND0zPErSxUTRjusDpfhyzG+9TyO+
         hs7Cb0K6hNb6xeaQO72fbppnnz4n0ui7BECnUl/eqrE+rZiFDsFm4FXO7P01bM/lJ7Ym
         6waFflFgSH4FdUJMJHnwdOTwRy1/X1Hoek7C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dci0jTaPQ1LF1SOSCmVyqguDpETXX8VuY92wwVPe54s=;
        b=YW+GG3rFKVPu9hSDRCRItNOnh/ZwECMuLDx2lHfgy1gokV25gVaSh9kijLH51hnKEo
         UV3Vg5a6exikjI9fTGc0rjpzGSIDB5qxD0KC6GQs+zxwZqLQqhLcqImFHd6v7zKcOeLV
         z1G4esZYW9Y9XqSmQ5xXY4NrjjP87N7hdbDLbEYkn79dxEsfyNdd/0oaQZ2Il4KRbomY
         rB9+9Q9pqIuNRNw4xN+crfQbeWnD1VxCOVKrNFUqZYhj2rP4C77tCUX4k+g0LGTzdMof
         zgZPdokv1D77ZVjkA+93liHtU2pMQF1C3XZIM1sl2WgRdsSHEBLz4913r29hfw0FCLUv
         kcFw==
X-Gm-Message-State: AOAM533SxHSW3zeHSj1UNeG8Ix6RMOnaehOTQMiZZUlmdMI9WfCNZ1BR
        U3ZMuYbxePF5SVKnhlDap78yhrCvwIu891QwYXBLDA==
X-Google-Smtp-Source: ABdhPJyNQSLJH4nRXzN26rXQvYHYhTUIBUff3vIk1Dxj6TdISJUCOZ2OlWvcJbCK/fb4jvjb6T5WIa+1MwI7gT3423E=
X-Received: by 2002:a2e:9913:: with SMTP id v19mr12344993lji.426.1619425022503;
 Mon, 26 Apr 2021 01:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210423233058.3386115-1-andrii@kernel.org> <20210423233058.3386115-6-andrii@kernel.org>
In-Reply-To: <20210423233058.3386115-6-andrii@kernel.org>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 26 Apr 2021 09:16:51 +0100
Message-ID: <CACAyw98cvRe6rE8XOBZfd7v=_5X45U=Qb0AtWJi5Kw2hWccpFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: fix core_reloc test runner
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 24 Apr 2021 at 00:36, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix failed tests checks in core_reloc test runner, which allowed failing tests
> to pass quietly. Also add extra check to make sure that expected to fail test cases with
> invalid names are caught as test failure anyway, as this is not an expected
> failure mode. Also fix mislabeled probed vs direct bitfield test cases.
>
> Fixes: 124a892d1c41 ("selftests/bpf: Test TYPE_EXISTS and TYPE_SIZE CO-RE relocations")
> Reported-by: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/core_reloc.c     | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> index 385fd7696a2e..607710826dca 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> @@ -217,7 +217,7 @@ static int duration = 0;
>
>  #define BITFIELDS_CASE(name, ...) {                                    \
>         BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_probed.o",     \
> -                             "direct:", name),                         \
> +                             "probed:", name),                         \
>         .input = STRUCT_TO_CHAR_PTR(core_reloc_##name) __VA_ARGS__,     \
>         .input_len = sizeof(struct core_reloc_##name),                  \
>         .output = STRUCT_TO_CHAR_PTR(core_reloc_bitfields_output)       \
> @@ -225,7 +225,7 @@ static int duration = 0;
>         .output_len = sizeof(struct core_reloc_bitfields_output),       \
>  }, {                                                                   \
>         BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_direct.o",     \
> -                             "probed:", name),                         \
> +                             "direct:", name),                         \
>         .input = STRUCT_TO_CHAR_PTR(core_reloc_##name) __VA_ARGS__,     \
>         .input_len = sizeof(struct core_reloc_##name),                  \
>         .output = STRUCT_TO_CHAR_PTR(core_reloc_bitfields_output)       \
> @@ -546,8 +546,7 @@ static struct core_reloc_test_case test_cases[] = {
>         ARRAYS_ERR_CASE(arrays___err_too_small),
>         ARRAYS_ERR_CASE(arrays___err_too_shallow),
>         ARRAYS_ERR_CASE(arrays___err_non_array),
> -       ARRAYS_ERR_CASE(arrays___err_wrong_val_type1),
> -       ARRAYS_ERR_CASE(arrays___err_wrong_val_type2),
> +       ARRAYS_ERR_CASE(arrays___err_wrong_val_type),
>         ARRAYS_ERR_CASE(arrays___err_bad_zero_sz_arr),
>
>         /* enum/ptr/int handling scenarios */
> @@ -865,13 +864,20 @@ void test_core_reloc(void)
>                           "prog '%s' not found\n", probe_name))
>                         goto cleanup;
>
> +
> +               if (test_case->btf_src_file) {
> +                       err = access(test_case->btf_src_file, R_OK);
> +                       if (!ASSERT_OK(err, "btf_src_file"))
> +                               goto cleanup;
> +               }
> +
>                 load_attr.obj = obj;
>                 load_attr.log_level = 0;
>                 load_attr.target_btf_path = test_case->btf_src_file;
>                 err = bpf_object__load_xattr(&load_attr);
>                 if (err) {
>                         if (!test_case->fails)
> -                               CHECK(false, "obj_load", "failed to load prog '%s': %d\n", probe_name, err);
> +                               ASSERT_OK(err, "obj_load");
>                         goto cleanup;
>                 }
>
> @@ -910,10 +916,8 @@ void test_core_reloc(void)
>                         goto cleanup;
>                 }
>
> -               if (test_case->fails) {
> -                       CHECK(false, "obj_load_fail", "should fail to load prog '%s'\n", probe_name);
> +               if (!ASSERT_FALSE(test_case->fails, "obj_load_should_fail"))

Similar to my other comment, I find it difficult to tell when this
triggers. Maybe it makes sense to return the status of the
assertion (not the original value)? So if (assertion()) will be
executed when the assertion fails? Not sure.

Acked-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
