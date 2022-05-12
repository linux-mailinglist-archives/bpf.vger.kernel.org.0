Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B657752430B
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 05:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244689AbiELDIg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 23:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiELDIe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 23:08:34 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0EA37A9F
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 20:08:28 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s23so3990257iog.13
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 20:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gH9nt5Z+twTdMet/u1CbVcZ/HwvokShMe4DYq6ey1ws=;
        b=mjMITYrwuNjiAOOqoIxqXih5BdpaOxAsbI7ApWL3j76DWOqf7508gYyxJIIbRZHM3/
         hWRyJ0onJGseJj944QZUHurAu/1hWuRj3kFWHifwYs52FzhciCjL/O6QkAuxYcatIwpC
         6fGf0au6lyF9GXClcJ6HK3dfvnLLpcOtrMMzgZmscZeYCtBEAvZ47RCHEdOPLl7FwGkG
         lG8iTSHWH4i7PPtPocTkfmzdPuBbY0BHUOHm/dDx1z1tNfZllNrsf5XJJddz52FD5pHa
         krV1mi4Q4ni1HZrKzm7C9gQk6fcEOeRGwoVsz50dOHQeStrljBG5FY1KWW5kRjJg0I4E
         Kssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gH9nt5Z+twTdMet/u1CbVcZ/HwvokShMe4DYq6ey1ws=;
        b=y1IV3LusFnK+H5i8toeSr6xLmccmZlXCJNuGW6mUGrHZvET2V6Ne3loyNj9cbz1oqc
         2d41OQH6ummnvatcpCuCXKVy9qFbNMG5YXYyvBhP4apWPADV6+JG3ia0PW94beIvrCe6
         j0bLsFYRU3x/EJeNiBNTQb+zrtzs8FGIgf4Eokk4QWE7+Myem5X7D8gYGFL1I67l8+gT
         4sysSbeFprrvfNwuaXoL6SnHxMENMMnH3K05iw7q08miuyPgC1/j3N8HIl6ENDAZuWw3
         B5zP26yBvUY/yGvwEef92HWYEMLDx6eWWmk8ge5FWqXhFfWojGl90tv9rOStLuFoZ9Jz
         UG6w==
X-Gm-Message-State: AOAM531frb4SsJBDEd4ipiD+kXUf8FqUuFx1MbRDF1Ex9/85DJDhdtuZ
        /CrIvyx6rUvS7eWbKJeydFvQHibhCr9FQ+c0g1DLGGYe
X-Google-Smtp-Source: ABdhPJz29dthggp3OqY26f+HrxsBqjupDoVbWtj1xSB0tAau8/xFN2KfBeO0xTA8mgNoJx5oX2XcYobL9iInpwlGWvQ=
X-Received: by 2002:a05:6638:533:b0:32a:d418:b77b with SMTP id
 j19-20020a056638053300b0032ad418b77bmr13919738jar.237.1652324907569; Wed, 11
 May 2022 20:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220511194654.765705-1-memxor@gmail.com> <20220511194654.765705-4-memxor@gmail.com>
In-Reply-To: <20220511194654.765705-4-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 May 2022 20:08:16 -0700
Message-ID: <CAEf4BzZm2rVt3Xxahah4cDur3o1LtUU399KYe5+ZzOaDck+cGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add negative C tests for kptrs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Wed, May 11, 2022 at 12:46 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> This uses the newly added SEC("?foo") naming to disable autoload of
> programs, and then loads them one by one for the object and verifies
> that loading fails and matches the returned error string from verifier.
> This is similar to already existing verifier tests but provides coverage
> for BPF C.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/map_kptr.c       |  87 +++-
>  .../selftests/bpf/progs/map_kptr_fail.c       | 418 ++++++++++++++++++
>  2 files changed, 504 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_fail.c
>

[...]

> +
> +static void test_map_kptr_success(void)
>  {
>         struct map_kptr *skel;
>         int key = 0, ret;
> @@ -35,3 +113,10 @@ void test_map_kptr(void)
>
>         map_kptr__destroy(skel);
>  }
> +
> +void test_map_kptr(void)
> +{
> +       if (test__start_subtest("success"))
> +               test_map_kptr_success();
> +       test_map_kptr_fail();

I think the intent for this was to be another subtest, right? Worth
fixing in a follow up?

> +}
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> new file mode 100644
> index 000000000000..05e209b1b12a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> @@ -0,0 +1,418 @@

[...]
