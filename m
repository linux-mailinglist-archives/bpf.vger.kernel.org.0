Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC4A3E9A78
	for <lists+bpf@lfdr.de>; Wed, 11 Aug 2021 23:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhHKVlW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhHKVlW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 17:41:22 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B72CC061765
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 14:40:58 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z128so7454277ybc.10
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2M2XOs7vA5W4k9AMzdi+i5NpF+wBykourd59alPq8I=;
        b=Js0KHQPLr2dSc2mcvOy3Ujlhf/efuqvQtSojaFAF2rzCQJ+ARsenSUjlEaSyqiEJH+
         5wopMmdYGzczLUL0ix/0WVeyepfbc6FO1pMOOoauCcz9DYl/UkEqQB6Y1DPTuEIKyEXY
         ZJj4zkKQPMfEgfaRS0Aj4oz00Yowfs1fKdMJaR9kUDkpXi/LnAZe+V+4B+YpZlNXrCyK
         1cb8BuWEp1gNFdWwV5wYR3PJIiUbPIhDoD9897EHFXOV7WUQuheoXoMzjGF1Mr5Xz/eM
         ZHyqhka4Tro8hYopM5MGA8HUF4Kfr32cOrqhKQHjFvMmJTiCb8yaKCh6kkREFCQPW4g6
         vGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2M2XOs7vA5W4k9AMzdi+i5NpF+wBykourd59alPq8I=;
        b=FA8vaOo+OnQk+dXSRGcFMcA4EgFrb8KLGn9gKbfx0RnulvPg5pEz0/FcyBtEncIubZ
         5f3mtkAj/3LxNDJEoD1BnZI38hyoT90Mw1Os5z20EfGt/QgfQDly5bWI/kALUV4FPSsx
         6JESfGqzXQDjxJuqij5jFakb9qelHCifkdZb5qMB4QoqMpg7gOIIWbTENseWkxXwEB5O
         oqEP/jBHN/B0NXuQ3drhRYv7Sl2gi8Q74GXfNHAtAn7yCdwVu8X6WzOTNWxKVZ2FZMPq
         yiMbIPotYhkgIGYq8R9GF49CmPUELxKsBu8a4T1cJr8Fjrprpl0sSImp1eNwONLYtQSE
         yGPQ==
X-Gm-Message-State: AOAM532J9T5wtZ5J6JfC53egPYbn70PdHOJ2+c+t87ThULuTj9dkFWUy
        3sX1G+gTNA59jMuPVwfMh9qutJWRalD6paUrq74=
X-Google-Smtp-Source: ABdhPJychQ8Tt7zLiONh693Q6ztsBnohg+6IzaoIggmlQ5l+1doCNVh5Y31+vi4QwhnbLcgSy/ls6ffFFGMMTHK0NVY=
X-Received: by 2002:a25:24cd:: with SMTP id k196mr79831ybk.459.1628718057720;
 Wed, 11 Aug 2021 14:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210810212107.2237868-1-fallentree@fb.com> <20210810212107.2237868-4-fallentree@fb.com>
In-Reply-To: <20210810212107.2237868-4-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Aug 2021 14:40:46 -0700
Message-ID: <CAEf4BzZA+w-sF2w6EfK00ZotoMOBaC5sbSund+zQ_=1ahw2BoA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/4] selftests/bpf: Support glob matching for
 test selector.
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 10, 2021 at 2:21 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch adds '-a' and '-b' arguments, supporting exact string match, as well

typo: you probably meant '-d'

> as using '*' wildchar in test/subtests selection.

typo: wildcard

>
> Caveat: As same as the current substring matching mechanism, test and subtest
> selector applies independently, 'a*/b*' will execute all tests matches "a*",
> and with subtest name matches "b*", but tests matches "a*" but has no subtests
> will also be executed.
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---

This looks good, see proposal at the end to simplify internals by
always using glob form.

But there is another problem with test/subtest selection. While you
are looking at this topic, maybe you can deal with that as well?

Basically:

[vmuser@archvm bpf]$ sudo ./test_progs -t core_reloc/arrays -t
core_reloc/enumval
#32/68 enumval:OK
#32/69 enumval___diff:OK
#32/70 enumval___val3_missing:OK
#32/71 enumval___err_missing:OK
#32 core_reloc:OK
Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
[vmuser@archvm bpf]$ sudo ./test_progs -t core_reloc/arrays,core_reloc/enumval
#32/19 arrays:OK
#32/20 arrays___diff_arr_dim:OK
#32/21 arrays___diff_arr_val_sz:OK
#32/22 arrays___equiv_zero_sz_arr:OK
#32/23 arrays___fixed_arr:OK
#32/24 arrays___err_too_small:OK
#32/25 arrays___err_too_shallow:OK
#32/26 arrays___err_non_array:OK
#32/27 arrays___err_wrong_val_type:OK
#32/28 arrays___err_bad_zero_sz_arr:OK
#32 core_reloc:OK
Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED

The intent was to run two sets of subtests, but we get either one or another...

For test selection it's a bit better. sudo ./test_progs -t
core_reloc,core_extern will run both tests, but ./test_progs -t
core_reloc and -t core_extern will run just core_extern.

This is not a theoretical problem, I ran into these limitations when
trying to disable only some of the subtests on older kernels (see
[0]).

It would be great to support both -t abc -t def to be interpreted as
-t abc,def (concatenation of specifications), and fix multiple
specifiers with subtests.

It's actually ambiguous, because -t foo/bar,baz can be interpreted as
either "test foo, subtests bar and baz" (i.e., -t foo/bar,foo/baz) or
"test foo and subtest bar within it, and separately test baz" (so, -t
foo/bar -t baz). I think the second one is less surprising and it
still allows to specify multiple subtests with more verbose form, if
necessary.

See if you can tackle that, but it doesn't have to be in the same patch set.

  [0] https://github.com/libbpf/libbpf/blob/master/travis-ci/vmtest/configs/blacklist/BLACKLIST-5.5.0#L106-L108

>  tools/testing/selftests/bpf/test_progs.c | 71 +++++++++++++++++++++---
>  tools/testing/selftests/bpf/test_progs.h |  1 +
>  2 files changed, 63 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index f0fbead40883..af43e206a806 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -13,6 +13,28 @@
>  #include <execinfo.h> /* backtrace */
>  #include <linux/membarrier.h>
>
> +// Adapted from perf/util/string.c

no C++ comments, please

> +static bool __match_glob(const char *str, const char *pat)

we (almost) never use __funcname in selftest, is there anything wrong
with just "match_glob"? Better still "matches_glob" reads more
meaningfully.

> +{
> +       while (*str && *pat && *pat != '*') {
> +               if (*str != *pat)
> +                       return false;
> +               str++;
> +               pat++;
> +       }

[...]

> @@ -553,29 +592,43 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>                 }
>                 break;
>         }
> +       case ARG_TEST_NAME_GLOB_ALLOWLIST:
>         case ARG_TEST_NAME: {
> +               if (env->test_selector.whitelist.cnt || env->subtest_selector.whitelist.cnt) {
> +                       fprintf(stderr, "-a and -t are mutually exclusive, you can only specific one.\n");

typo: specify

but also, it just occurred to me. Isn't `-t whatever` same as `-a
'*whatever*'`? We can do that transparently and make -a and -t
co-exist nicely. Basically, let's do globs only internally.

> +                       return -EINVAL;
> +               }
>                 char *subtest_str = strchr(arg, '/');
>

[...]
