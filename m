Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BF235D622
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 05:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhDMDrW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 23:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242844AbhDMDrV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 23:47:21 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351ACC061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 20:47:02 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id l14so10382556ybf.11
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 20:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UPrjAHu8LDiNzO63qcD5Bm9KV75qT2zquAfqqaWWa2I=;
        b=kYmHJ3+nTxiOugo2Mi3HXJKi6Y1F1aHqSxKhewHjGPgKbGmFxDQTnfH385creYayPG
         aaIyKFQW7vyr2AcnraTTRlfTGMx44InAIYtIO//KZmjnFvi3G4xZtuZul76ylMb9eNBx
         POCjVqZsGfTSnQmOyI6XlwRRiXUu8sQBkQ5ULAJ5V8YZvyf3bmmUrBdiWGn5eMo5oFnj
         xhePwnb8pfdBiTKtplY+jk5xbmojeD5vrmUwGcFyO9VZAQVKIpg5/MviOiI4AVYUCVq/
         K8Bx2DKZFHjds/BJP3lz9tVlaenccrthmWzelniBvJMv/7cWO5oNZQrUvz6s+0PyUjvl
         NryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UPrjAHu8LDiNzO63qcD5Bm9KV75qT2zquAfqqaWWa2I=;
        b=RBWx4JSSTXcAUlIE0Z6SVK0AGKS+iQNA/+56OR/WkYeLrvgdaS9RAaIJVRR8e4zBwh
         QTD1A9NE85k+iMcf5tPy5bL974PQ5lwcghWGpVJYpNfmb/T9GS+GsEnwCF7+o1DjSjER
         4CPjjpiZX4IedAn77CJtoIddWESkxQyUenDtZhzT/rRnUfil0LViFA/QGbkYoLwlau7w
         4f0VJR49iPCCj3jX5FhROI5EF+0rAhI1PdTCMtFeWObUQs8+3Q9US4jN6Ff+/xeqhnAB
         UEmQIRXEo8BwTdvVItmjLhLSy3dm5sTswiabUg2B/lcxefnKKb6VaH9FIo4E3OOugjlx
         yq9g==
X-Gm-Message-State: AOAM533HvbMMtgxXzmH4mgc5N6/ioHIzM6/kymxqdZ5EK1ro5x810JGf
        n5T+jBmLom39D2wb7zyCWzLFmw/yzU5fbKWHXN0=
X-Google-Smtp-Source: ABdhPJzuKPQA0Jtt2Dl/HJuI2npPIZpDG70eO6w557garTBaZa0ofSjwFSyVdnvlUe1+Ozo0CznxM/SYthLr63gJpDI=
X-Received: by 2002:a25:9942:: with SMTP id n2mr41212255ybo.230.1618285621484;
 Mon, 12 Apr 2021 20:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210408195740.153029-1-toke@redhat.com> <20210408195740.153029-2-toke@redhat.com>
In-Reply-To: <20210408195740.153029-2-toke@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Apr 2021 20:46:50 -0700
Message-ID: <CAEf4BzaZ8nAAqs8twnqCtSvmxsDvKBDUaYw+s+CcOnZyYo=0Vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add tests for target
 information in bpf_link info queries
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 8, 2021 at 12:57 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Extend the fexit_bpf2bpf test to check that the info for the bpf_link
> returned by the kernel matches the expected values.
>
> While we're updating the test, change existing uses of CHEC() to use the
> much easier to read ASSERT_*() macros.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

Just a minor nit below. Looks good, thanks.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 50 +++++++++++++++----
>  1 file changed, 39 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> index 5c0448910426..019a46d8e98e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> @@ -57,11 +57,13 @@ static void test_fexit_bpf2bpf_common(const char *obj=
_file,
>                                       bool run_prog,
>                                       test_cb cb)
>  {
> +       __u32 duration =3D 0, retval, tgt_prog_id, info_len;

if not CHECK() is used, duration shouldn't be needed anymore

>         struct bpf_object *obj =3D NULL, *tgt_obj;
> +       struct bpf_prog_info prog_info =3D {};
>         struct bpf_program **prog =3D NULL;
>         struct bpf_link **link =3D NULL;
> -       __u32 duration =3D 0, retval;
>         int err, tgt_fd, i;
> +       struct btf *btf;
>
>         err =3D bpf_prog_load(target_obj_file, BPF_PROG_TYPE_UNSPEC,
>                             &tgt_obj, &tgt_fd);
> @@ -72,28 +74,55 @@ static void test_fexit_bpf2bpf_common(const char *obj=
_file,
>                             .attach_prog_fd =3D tgt_fd,
>                            );
>
> +       info_len =3D sizeof(prog_info);
> +       err =3D bpf_obj_get_info_by_fd(tgt_fd, &prog_info, &info_len);
> +       if (!ASSERT_OK(err, "tgt_fd_get_info"))
> +               goto close_prog;
> +
> +       tgt_prog_id =3D prog_info.id;
> +       btf =3D bpf_object__btf(tgt_obj);
> +
>         link =3D calloc(sizeof(struct bpf_link *), prog_cnt);
>         prog =3D calloc(sizeof(struct bpf_program *), prog_cnt);
> -       if (CHECK(!link || !prog, "alloc_memory", "failed to alloc memory=
"))
> +       if (!ASSERT_OK_PTR(link, "link_ptr") || !ASSERT_OK_PTR(prog, "pro=
g_ptr"))

nit: can you split them into two independent ifs now? Just one extra
`goto close_prog` is no big deal, but reads nicer

>                 goto close_prog;
>
>         obj =3D bpf_object__open_file(obj_file, &opts);
> -       if (CHECK(IS_ERR_OR_NULL(obj), "obj_open",
> -                 "failed to open %s: %ld\n", obj_file,
> -                 PTR_ERR(obj)))
> +       if (!ASSERT_OK_PTR(obj, "obj_open"))
>                 goto close_prog;
>
>         err =3D bpf_object__load(obj);
> -       if (CHECK(err, "obj_load", "err %d\n", err))
> +       if (!ASSERT_OK(err, "obj_load"))
>                 goto close_prog;
>

[...]
