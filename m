Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC540EA23
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbhIPSof (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 14:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350712AbhIPSo0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Sep 2021 14:44:26 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A27C0F39B9
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 10:14:57 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id ay33so8586083qkb.10
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+sVyL0z9gdCaMewuIk8MF5Tuvz1yFXgLVe0KMokq4s=;
        b=X49JRGTFv8nPqchbL1MDklVQ7qFF6NBIL4DAoLlNf87pcfJJwzfzYhrrDLcA+1/Bl4
         kD/KTIWLwNwmm5MqT3gIdvqE8ZFC/XNIkWyA+vgLua1PgF87jjfMA6Sh2NHi07LCA96m
         nyMn4rIhf8x6StqLKh0ufppH+vn+mfedcPHTs0txkkgk84qYJCiSVSsz4YTC6lEDC0tu
         xWFAA138kMP8Nltt9kcYImEN2N4rBFodYIOy6iBk3rP2eARta1wqcqOsTtqfbxgFkRo3
         KqjewAPnrfAsa6thgHDNNV5Ig1E8VkHk/k7DdQ31npxi8gPZ++ivpwZmhoq/IGiY86D/
         MO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+sVyL0z9gdCaMewuIk8MF5Tuvz1yFXgLVe0KMokq4s=;
        b=i4MvQAQIswvjrT+JIs5tE+xPEKLmBOwu629qx9zFmGDt7iHT9Q5SmlqoOZOJ3zI6Uj
         NdHi7QCIKg6Y1JKNVpbz3aeGh8/nmUT7JftSPSJOiGAvS/GNyy3w0AieBChty/YDK8z7
         jE+1ZA+dAcfhl1vBzYj42FubqLdth93rlU62GsZk99JEygUb+ReQ3HxUq6Gvyk0yN4OR
         QtfQqi38quq3HXZOUHXumq9j7clRXAqZAhYkzwKwihNeqhEvM231e7x3dpnukF1S3oGT
         VSmM68vr2hycJkOTMwWwUZJF49rR2cw0nN7qEip349L+HX6y7yeQVuLYg3K1Deyk7+Da
         FP6A==
X-Gm-Message-State: AOAM530oLppyjE2Y7N5cMLIVdWMSRywvRlcglUJ5pD8zpR0JUU56AHyp
        +ml4KdwvKxcwPpltJHFBsQM+eOSy5i08zf/vALadESf9
X-Google-Smtp-Source: ABdhPJxdGRAUIpRgsA/V4g58MzdkE/m+l8rKQ2PaVpyMVSzIaZXzNuRPu+xBWpxx0g2XmMjcAzBwdJj641D/abj5kkc=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr8292635ybb.267.1631812496026;
 Thu, 16 Sep 2021 10:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210916015836.1248906-1-andrii@kernel.org> <20210916015836.1248906-6-andrii@kernel.org>
 <b8dac642-bed3-cf84-4b21-99c7ffec07e1@fb.com>
In-Reply-To: <b8dac642-bed3-cf84-4b21-99c7ffec07e1@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Sep 2021 10:14:45 -0700
Message-ID: <CAEf4BzaYdbEoJ9rAiUMn_Pcr3=iiRPpb82ogj1iXc29rpYothQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: switch fexit_bpf2bpf selftest
 to set_attach_target() API
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 15, 2021 at 9:24 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/15/21 6:58 PM, Andrii Nakryiko wrote:
> > Switch fexit_bpf2bpf selftest to bpf_program__set_attach_target()
> > instead of using bpf_object_open_opts.attach_prog_fd, which is going to
> > be deprecated. These changes also demonstrate the new mode of
> > set_attach_target() in which it allows NULL when the target is BPF
> > program (attach_prog_fd != 0).
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Ack with a minor nit below.
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 43 +++++++++++--------
> >   1 file changed, 26 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > index 73b4c76e6b86..c7c1816899bf 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> > @@ -60,7 +60,7 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
> >       struct bpf_object *obj = NULL, *tgt_obj;
> >       __u32 retval, tgt_prog_id, info_len;
> >       struct bpf_prog_info prog_info = {};
> > -     struct bpf_program **prog = NULL;
> > +     struct bpf_program **prog = NULL, *p;
> >       struct bpf_link **link = NULL;
> >       int err, tgt_fd, i;
> >       struct btf *btf;
> > @@ -69,9 +69,6 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
> >                           &tgt_obj, &tgt_fd);
> >       if (!ASSERT_OK(err, "tgt_prog_load"))
> >               return;
> > -     DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
> > -                         .attach_prog_fd = tgt_fd,
> > -                        );
> >
> >       info_len = sizeof(prog_info);
> >       err = bpf_obj_get_info_by_fd(tgt_fd, &prog_info, &info_len);
> > @@ -89,10 +86,15 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
> >       if (!ASSERT_OK_PTR(prog, "prog_ptr"))
> >               goto close_prog;
> >
> > -     obj = bpf_object__open_file(obj_file, &opts);
> > +     obj = bpf_object__open_file(obj_file, NULL);
> >       if (!ASSERT_OK_PTR(obj, "obj_open"))
> >               goto close_prog;
> >
> > +     bpf_object__for_each_program(p, obj) {
> > +             err = bpf_program__set_attach_target(p, tgt_fd, NULL);
> > +             ASSERT_OK(err, "set_attach_target");
> > +     }
> > +
> >       err = bpf_object__load(obj);
> >       if (!ASSERT_OK(err, "obj_load"))
> >               goto close_prog;
> > @@ -270,7 +272,7 @@ static void test_fmod_ret_freplace(void)
> >       struct bpf_link *freplace_link = NULL;
> >       struct bpf_program *prog;
> >       __u32 duration = 0;
> > -     int err, pkt_fd;
> > +     int err, pkt_fd, attach_prog_fd;
> >
> >       err = bpf_prog_load(tgt_name, BPF_PROG_TYPE_UNSPEC,
> >                           &pkt_obj, &pkt_fd);
> > @@ -278,26 +280,32 @@ static void test_fmod_ret_freplace(void)
> >       if (CHECK(err, "tgt_prog_load", "file %s err %d errno %d\n",
> >                 tgt_name, err, errno))
> >               return;
> > -     opts.attach_prog_fd = pkt_fd;
> >
> > -     freplace_obj = bpf_object__open_file(freplace_name, &opts);
> > +     freplace_obj = bpf_object__open_file(freplace_name, NULL);
> >       if (!ASSERT_OK_PTR(freplace_obj, "freplace_obj_open"))
> >               goto out;
> >
> > +     prog = bpf_program__next(NULL, freplace_obj);
> > +     err = bpf_program__set_attach_target(prog, pkt_fd, NULL);
> > +     ASSERT_OK(err, "freplace__set_attach_target");
>
> The above pattern appears 3 times. Maybe it is worthwhile to
> have a small helper. But the current code is also fine,
> so I won't insist.

I think it's acceptable for test code. It actually makes it easier to
follow, because every extra helper function is a bit of distraction
and context switch when reading the code.

My hope that with time we'll clean this up to use BPF skeleton and the
code will be clean without unnecessary repetition.

>
> > +
> >       err = bpf_object__load(freplace_obj);
> >       if (CHECK(err, "freplace_obj_load", "err %d\n", err))
> >               goto out;
> >
> > -     prog = bpf_program__next(NULL, freplace_obj);
> >       freplace_link = bpf_program__attach_trace(prog);
> >       if (!ASSERT_OK_PTR(freplace_link, "freplace_attach_trace"))
> >               goto out;
> >
> > -     opts.attach_prog_fd = bpf_program__fd(prog);
> > -     fmod_obj = bpf_object__open_file(fmod_ret_name, &opts);
> > +     fmod_obj = bpf_object__open_file(fmod_ret_name, NULL);
> >       if (!ASSERT_OK_PTR(fmod_obj, "fmod_obj_open"))
> >               goto out;
> >
> > +     attach_prog_fd = bpf_program__fd(prog);
> > +     prog = bpf_program__next(NULL, fmod_obj);
> > +     err = bpf_program__set_attach_target(prog, attach_prog_fd, NULL);
> > +     ASSERT_OK(err, "fmod_ret_set_attach_target");
> > +
> >       err = bpf_object__load(fmod_obj);
> >       if (CHECK(!err, "fmod_obj_load", "loading fmod_ret should fail\n"))
> >               goto out;
> > @@ -322,14 +330,14 @@ static void test_func_sockmap_update(void)
> >   }
> >
> >   static void test_obj_load_failure_common(const char *obj_file,
> > -                                       const char *target_obj_file)
> > -
> > +                                      const char *target_obj_file)
> >   {
> >       /*
> >        * standalone test that asserts failure to load freplace prog
> >        * because of invalid return code.
> >        */
> >       struct bpf_object *obj = NULL, *pkt_obj;
> > +     struct bpf_program *prog;
> >       int err, pkt_fd;
> >       __u32 duration = 0;
> >
> > @@ -339,14 +347,15 @@ static void test_obj_load_failure_common(const char *obj_file,
> >       if (CHECK(err, "tgt_prog_load", "file %s err %d errno %d\n",
> >                 target_obj_file, err, errno))
> >               return;
> > -     DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
> > -                         .attach_prog_fd = pkt_fd,
> > -                        );
> >
> > -     obj = bpf_object__open_file(obj_file, &opts);
> > +     obj = bpf_object__open_file(obj_file, NULL);
> >       if (!ASSERT_OK_PTR(obj, "obj_open"))
> >               goto close_prog;
> >
> > +     prog = bpf_program__next(NULL, obj);
> > +     err = bpf_program__set_attach_target(prog, pkt_fd, NULL);
> > +     ASSERT_OK(err, "set_attach_target");
> > +
> >       /* It should fail to load the program */
> >       err = bpf_object__load(obj);
> >       if (CHECK(!err, "bpf_obj_load should fail", "err %d\n", err))
> >
