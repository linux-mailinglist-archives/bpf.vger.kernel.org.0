Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F0C4E4804
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 22:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiCVVCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 17:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbiCVVCh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 17:02:37 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D997150E1B
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:01:09 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h63so21667733iof.12
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgxS98SUpWvQi5slvITim56gp+1y1esXXxpCXWwYVDo=;
        b=iDnKPF8rMnhWBHdMs3H8O+SWrOzmCH/jfDxS+9yP0WTxkzJWCFuYKp0E3D5J3W2snK
         b9xsnJ00bOAjtWo3hLIweSYAc+L5yqtDCohSDNQbhARLYeTgTy/IxYYBFaRvAkL/k+Q+
         bUYGjodFp+q6ELdCzfsGPbh+Ulpti7VQMbypZ/9Q6qibBUM27H0LdxOYHZM0+40ut1ut
         5JBle57cyUJPKSbyCpxz2meax6/plvRFy/saykwHSwOHUS0g0a1rNSjlSEd17PMpLcqT
         X+sbFrah+BUTO6VMFv1iPZSs9IzJMBZtjN50iqAhSh1WD8OzPgVdVFR9TzqOe0hRRk42
         SgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgxS98SUpWvQi5slvITim56gp+1y1esXXxpCXWwYVDo=;
        b=2QzU8TZgAY/zbg9HfcW2gGi1WOqBpdIw7YW5gpUuO7vM7eQjRjE7CCrMQgfVVJqYsD
         oaLY38tdCNZTzCKSB97SO70OF3v/rrsE1LEiZdwsjY0dbE/gr/pDkxApsqGH2J1f32lZ
         MSzNmH7JahCq5dmJ+kNmOrGF+le28922xPy301xePI2XZsSpAyXuSYvEekOfaNcY+4iY
         nrlOdUDpIRS8mPeHnJJTq6LBiyZ7ZJFPnizi5pxrXJZyaNs3PU0iMRzWwVEA0icTZm8R
         tg7aEcPfIsIFbO5S4moNOGOl/G9VatEcFnKjfL7gQKlQceiWMw/a+o8EeJ8Sh10jHwyi
         ULNQ==
X-Gm-Message-State: AOAM531CeGIh7mYAIKO25uu6u9draC0CdK8G1aLdWzcfTmJb4ElneC6/
        FtMxrZeWKwIDNzua/6D5FoafHXrrOxbagHvtx70qsPea
X-Google-Smtp-Source: ABdhPJxyY0aLTWB3EwnSzWmh9M+NMROMjNtUdWcnjGiOU8cyO5BMpEJQ6C+3q3KSTNrN2tZ/9rnp3DJSl22lEe5FYeM=
X-Received: by 2002:a05:6602:185a:b0:645:d914:35e9 with SMTP id
 d26-20020a056602185a00b00645d91435e9mr13025904ioi.154.1647982869195; Tue, 22
 Mar 2022 14:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220320155510.671497-1-memxor@gmail.com> <20220320155510.671497-13-memxor@gmail.com>
In-Reply-To: <20220320155510.671497-13-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Mar 2022 14:00:57 -0700
Message-ID: <CAEf4BzauqNj1xfipPUFx3nBMQKEQ_WD_RWOKsxCLcV5zecsCtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/13] selftests/bpf: Add C tests for kptr
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Sun, Mar 20, 2022 at 8:56 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> This uses the __kptr and __kptr_ref macros as well, and tries to test
> the stuff that is supposed to work, since we have negative tests in
> test_verifier suite. Also include some code to test map-in-map support,
> such that the inner_map_meta matches the kptr_off_tab of map added as
> element.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/map_kptr.c       |  20 ++
>  tools/testing/selftests/bpf/progs/map_kptr.c  | 194 ++++++++++++++++++
>  2 files changed, 214 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/map_kptr.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> new file mode 100644
> index 000000000000..688732295ce9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +
> +#include "map_kptr.skel.h"
> +
> +void test_map_kptr(void)
> +{
> +       struct map_kptr *skel;
> +       char buf[24];
> +       int key = 0;
> +
> +       skel = map_kptr__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
> +               return;
> +       ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.hash_map), &key, buf, 0),
> +                 "bpf_map_update_elem hash_map");
> +       ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.hash_malloc_map), &key, buf, 0),
> +                 "bpf_map_update_elem hash_malloc_map");


nit: it's quite messy and verbose, please do the operation outside of
ASSERT_OK() and just validate error:

err = bpf_map_update_elem(...);
ASSERT_OK(err, "hash_map_update");

And keep those ASSERT_XXX() string descriptors relatively short (see
how they are used internally in ASSERT_XXX() macros).

> +       map_kptr__destroy(skel);
> +}

[...]

> +
> +extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
> +extern struct prog_test_ref_kfunc *
> +bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
> +extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> +
> +static __always_inline

nit: no need for __always_inline everywhere, just `static void` will
do the right thing.

> +void test_kptr_unref(struct map_value *v)
> +{
> +       struct prog_test_ref_kfunc *p;
> +
> +       p = v->unref_ptr;
> +       /* store untrusted_ptr_or_null_ */
> +       v->unref_ptr = p;
> +       if (!p)
> +               return;
> +       if (p->a + p->b > 100)
> +               return;
> +       /* store untrusted_ptr_ */
> +       v->unref_ptr = p;
> +       /* store NULL */
> +       v->unref_ptr = NULL;
> +}
> +

[...]
