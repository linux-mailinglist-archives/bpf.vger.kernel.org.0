Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7314734BB29
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 06:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhC1E7S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 00:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhC1E7A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Mar 2021 00:59:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2C9C061762
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 21:59:00 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z1so10216681ybf.6
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 21:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJnm8eFRltGTypDSqa/8ciwzBV7B2PV/atOPtN6a4/I=;
        b=FuJrjy0nt/mVUoi1ka6FiKBlMxztZj/gMAfRjjiQMPlsYqNEoplMSA8cnFAew0joeX
         VQ4Dxwc3CF3nvYexkoRjh66FYbawa1ixwsnI5MfR+sspWjrbZuFjoeTDuZ8To9je0FJb
         3DTTNDr5C4ivb7tewaYkep3IZhRudrwrrFqtnR9AMexD5RWzE6TaiKidkS//tAA97G4D
         AakEB5rzZ2yFptpTIUQAuxgjq/vYRP1hjfiCpC7Ws63YjN8b8K6oEkzb17BGnHd1Oq9k
         tirq//mAatWj2cgA2eBQJTOptIVq5uS1kbP+pY6M8VF9pQloFQXg1iBu/3DWyuLJ8BUd
         Vjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJnm8eFRltGTypDSqa/8ciwzBV7B2PV/atOPtN6a4/I=;
        b=W06EqN/NQxJvcc8yxzWtcfBkUUEtmKmwzWRCAVawnnk1w5eNOlGyKhMznYWVJg3J0l
         bGqStEyK/qZIoUbBvOS5W/d5SU+WIIdzrEqTdsgH/YfYmlxJejj8ugtHwioo0h1S2Sgo
         u8gXYBAOBplwLmVaejD5P0Utk2TXHlDD+Zq7IwXfAzhJfNs0uSAtMDOoyUIlQ8lgX5qd
         W8LgXgjYuWK9Ecw7IJJeaXgc8hox9BrMeNXw+OKUonn6ie0tPlebmc8E6O9L/Vf7kLFn
         3XuqaPvWjABjp2aLWikvfJuCtLoseSZpqgC0k4m1j53SMW1+TuQ9OKrTlga/T9yTzPVs
         zZYg==
X-Gm-Message-State: AOAM53079Lbhfgvk6ewXdq81c7K9iQdvm0f28rRNoIFa93xh8el1UX9e
        JSxPJTNmwRO02Lui5M4rdA2IN2XFuj8kjySVvnpsWGtekUTPhg==
X-Google-Smtp-Source: ABdhPJyW/soIAnGrxo2FRAXpe6F0j9tiGRMhkH+FJYB6103owa7yBKaA9UIg4cIndpQDez5A1KHXempFVIl54y1FunI=
X-Received: by 2002:a25:5b55:: with SMTP id p82mr27807027ybb.510.1616907539254;
 Sat, 27 Mar 2021 21:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com> <20210326122438.211242-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326122438.211242-1-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 27 Mar 2021 21:58:48 -0700
Message-ID: <CAEf4BzZcTROE0fNoAtwpZGUOiMNBN458K5b_3O+q-9mFhnvvAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] selftests/bpf: test_progs/sockopt_sk: Convert to
 use BPF skeleton
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 26, 2021 at 5:24 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Switch the test to use BPF skeleton to save some boilerplate and
> make it easy to access bpf program bss segment.
>
> The latter will be used to pass PAGE_SIZE from userspace since there
> is no convenient way for bpf program to get it from inside of the
> kernel.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

It's a nice cleanup. See some suggestion to further clean it up. But
even with this:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/sockopt_sk.c     | 72 ++++++-------------
>  1 file changed, 23 insertions(+), 49 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> index d5b44b135c00..114c1a622ffa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -3,6 +3,7 @@
>  #include "cgroup_helpers.h"
>
>  #include <linux/tcp.h>
> +#include "sockopt_sk.skel.h"
>
>  #ifndef SOL_TCP
>  #define SOL_TCP IPPROTO_TCP
> @@ -191,60 +192,33 @@ static int getsetsockopt(void)
>         return -1;
>  }
>
> -static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title)
> -{
> -       enum bpf_attach_type attach_type;
> -       enum bpf_prog_type prog_type;
> -       struct bpf_program *prog;
> -       int err;
> -
> -       err = libbpf_prog_type_by_name(title, &prog_type, &attach_type);
> -       if (err) {
> -               log_err("Failed to deduct types for %s BPF program", title);
> -               return -1;
> -       }
> -
> -       prog = bpf_object__find_program_by_title(obj, title);
> -       if (!prog) {
> -               log_err("Failed to find %s BPF program", title);
> -               return -1;
> -       }
> -
> -       err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd,
> -                             attach_type, 0);
> -       if (err) {
> -               log_err("Failed to attach %s BPF program", title);
> -               return -1;
> -       }
> -
> -       return 0;
> -}
> -
>  static void run_test(int cgroup_fd)
>  {
> -       struct bpf_prog_load_attr attr = {
> -               .file = "./sockopt_sk.o",
> -       };
> -       struct bpf_object *obj;
> -       int ignored;
> -       int err;
> -
> -       err = bpf_prog_load_xattr(&attr, &obj, &ignored);
> -       if (CHECK_FAIL(err))
> -               return;
> -
> -       err = prog_attach(obj, cgroup_fd, "cgroup/getsockopt");
> -       if (CHECK_FAIL(err))
> -               goto close_bpf_object;
> -
> -       err = prog_attach(obj, cgroup_fd, "cgroup/setsockopt");
> -       if (CHECK_FAIL(err))
> -               goto close_bpf_object;
> +       struct sockopt_sk *skel;
> +       int duration = 0;
> +
> +       skel = sockopt_sk__open_and_load();
> +       if (CHECK(!skel, "skel_load", "sockopt_sk skeleton failed\n"))
> +               goto cleanup;

if (!ASSERT_OK_PTR(skel, "skel_load))

is still less boilerplate :)

> +
> +       skel->links._setsockopt =
> +               bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
> +       if (CHECK(IS_ERR(skel->links._setsockopt),
> +                        "setsockopt_attach", "err: %ld\n",
> +                        PTR_ERR(skel->links._setsockopt)))

you could save some more boilerplate if you did:

if (!ASSERT_OK_PTR(skel->links._getsockopt), "getsockopt_link")
    goto cleanup;

> +               goto cleanup;
> +
> +       skel->links._getsockopt =
> +               bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
> +       if (CHECK(IS_ERR(skel->links._getsockopt),
> +                        "getsockopt_attach", "err: %ld\n",
> +                        PTR_ERR(skel->links._getsockopt)))
> +               goto cleanup;
>
>         CHECK_FAIL(getsetsockopt());

please switch this to ASSERT_OK() as well.

Once you don't use CHECK/CHECK_FAIL, you also won't need `int duration`, btw.

>
> -close_bpf_object:
> -       bpf_object__close(obj);
> +cleanup:
> +       sockopt_sk__destroy(skel);
>  }
>
>  void test_sockopt_sk(void)
> --
> 2.29.2
>
