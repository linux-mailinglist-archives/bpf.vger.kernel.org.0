Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965FA4BCBB1
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 03:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiBTC2R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 21:28:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiBTC2R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 21:28:17 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB504EF59
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:27:57 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id t11so6335209ioi.7
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CHTfPZlOgCL03Z5TS4zkp0crLCDm814Au2kP/hTnHjg=;
        b=DcqzbgnmsfJU+OXhXiZKgIUUvWNbNE3n3CR4Lk5uYdH0DI/r/xnLV/+nUJJlpjgdMK
         ++HHdt8LiNQ1fWBG8/7yMoj6E+8oNL2pVRZBRBNVXO3RWlVZx5UGwqkYCM7esJoIbrZx
         FvTzVc1hjRa/Nx2cxknsq7+cIyvN4jm1J/P9mXGfjbx4lmejqe+8VcLK4xDqukQfgyiL
         3xqmvnN2LKwuf8h8FulP2j2dGRuvit/ITF9uS1vYgFjxfxyc/tbWf2OzYJrHCi2K8O8m
         BZTsRE+8DcunBYJtP7JAL1evn9acP5PSgnRdlGgMW+f0Eh0UZlVHdJDXiHPRcIt3f603
         KJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CHTfPZlOgCL03Z5TS4zkp0crLCDm814Au2kP/hTnHjg=;
        b=5VB+xOlxK/69TBRKdeuQhyr8RicE+1emz158D2nlns9z6fZcSU08gwnRLUwkDNPyYa
         JVDZsRdonEP59kE9sgCA00AR82i3O9OWUfIEMff/kEuYCb6D8Y/l0kbMR1Z1ZSq8ppzS
         d1wgs7zMcCOssG8Yln6dfzOcBGOuHfRNeKrInamTggbwCJK50CvmB5PwpxQKTwO1PoEo
         J9DnHYaD9BAtNMj0b5RQ4qU5pzwyUmlkA6nOuXz8Y2AppPhlhkuXIVMRhk38h9TYx9Sj
         0C2bz2XTecsvV4CB6sT6gyM9h5CesVDai0TqIFp5/Ry6XzPRI0Zju0NLZrxKJi9yn6ZW
         IiWA==
X-Gm-Message-State: AOAM531AOclbi7S9eteiFi4Iri1xD38rVQ/8iXSZiA+10qh5GdPV9NY4
        oYbptS4m0gmdE2laciarEyAiHxQKN7v4cjKuTMg=
X-Google-Smtp-Source: ABdhPJwg5zRKcmsk1AJkMvs98HSiAfHl7D9sj9HmGICyVPnnFGzsVF4zEdw+kPc8ZIL+1nQu7jgtOFIGF/D2c6piI0k=
X-Received: by 2002:a02:aa85:0:b0:314:c152:4c89 with SMTP id
 u5-20020a02aa85000000b00314c1524c89mr4331186jai.93.1645324076418; Sat, 19 Feb
 2022 18:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20220220022454.2717579-1-andrii@kernel.org>
In-Reply-To: <20220220022454.2717579-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 19 Feb 2022 18:27:45 -0800
Message-ID: <CAEf4BzYOMiP=QnX7dAna8B6wK35cNgLAe_huWhuBJhDxTfvrKg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: fix btfgen tests
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez?= <mauricio@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 19, 2022 at 6:25 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> There turned out to be a few problems with btfgen selftests.
>
> First, core_btfgen tests are failing in BPF CI due to the use of
> full-featured bpftool, which has extra dependencies on libbfd, libcap,
> etc, which are present in BPF CI's build environment, but those shared
> libraries are missing in QEMU image in which test_progs is running.
>
> To fix this problem, use minimal bootstrap version of bpftool instead.
> It only depend on libelf and libz, same as libbpf, so doesn't add any
> new requirements (and bootstrap bpftool still implementes entire
> `bpftool gen` functionality, which is quite convenient).
>
> Second problem is even more interesting. Both core_btfgen and core_reloc
> reuse the same set of struct core_reloc_test_case array of test case
> definitions. That in itself is not a problem, but btfgen test replaces
> test_case->btf_src_file property with the path to temporary file into
> which minimized BTF is output by bpftool. This interferes with original
> core_reloc tests, depending on order of tests execution (core_btfgen is
> run first in sequential mode and skrews up subsequent core_reloc run by
> pointing to already deleted temporary file, instead of the original BTF
> files) and whether those two runs share the same process (in parallel
> mode the chances are high for them to run in two separate processes and
> so not interfere with each other).
>
> To prevent this interference, create and use local copy of a test
> definition. Mark original array as constant to catch accidental
> modifcations. Note that setup_type_id_case_success() and
> setup_type_id_case_success() still modify common test_case->output
> memory area, but it is ok as each setup function has to re-initialize it
> completely anyways. In sequential mode it leads to deterministic and
> correct initialization. In parallel mode they will either each have
> their own process, or if core_reloc and core_btfgen happen to be run by
> the same worker process, they will still do that sequentially within the
> worker process. If they are sharded across multiple processes, they
> don't really share anything anyways.
>
> Also, rename core_btfgen into core_reloc_btfgen, as it is indeed just
> a "flavor" of core_reloc test, not an independent set of tests. So make
> it more obvious.
>
> Cc: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> Fixes: 704c91e59fe0 ("selftests/bpf: Test "bpftool gen min_core_btf")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/core_reloc.c       | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
> index 8fbb40a832d5..5c5e5e72d9fe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> @@ -512,7 +512,7 @@ static int __trigger_module_test_read(const struct co=
re_reloc_test_case *test)
>  }
>
>
> -static struct core_reloc_test_case test_cases[] =3D {
> +static const struct core_reloc_test_case test_cases[] =3D {
>         /* validate we can find kernel image and use its BTF for relocs *=
/
>         {
>                 .case_name =3D "kernel",
> @@ -843,7 +843,7 @@ static int run_btfgen(const char *src_btf, const char=
 *dst_btf, const char *objp
>         int n;
>
>         n =3D snprintf(command, sizeof(command),
> -                    "./tools/build/bpftool/bpftool gen min_core_btf %s %=
s %s",
> +                    "./tools/build/bpftool/bootstrap/bpftool gen min_cor=
e_btf %s %s %s",
>                      src_btf, dst_btf, objpath);
>         if (n < 0 || n >=3D sizeof(command))
>                 return -1;
> @@ -855,7 +855,7 @@ static void run_core_reloc_tests(bool use_btfgen)
>  {
>         const size_t mmap_sz =3D roundup_page(sizeof(struct data));
>         DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts);
> -       struct core_reloc_test_case *test_case;
> +       struct core_reloc_test_case *test_case, test_case_copy;
>         const char *tp_name, *probe_name;
>         int err, i, equal, fd;
>         struct bpf_link *link =3D NULL;
> @@ -870,7 +870,10 @@ static void run_core_reloc_tests(bool use_btfgen)
>
>         for (i =3D 0; i < ARRAY_SIZE(test_cases); i++) {
>                 char btf_file[] =3D "/tmp/core_reloc.btf.XXXXXX";
> -               test_case =3D &test_cases[i];
> +
> +               test_case_copy =3D test_cases[i];
> +               test_case =3D &test_case_copy;
> +
>                 if (!test__start_subtest(test_case->case_name))
>                         continue;
>
> @@ -881,6 +884,7 @@ static void run_core_reloc_tests(bool use_btfgen)
>
>                 /* generate a "minimal" BTF file and use it as source */
>                 if (use_btfgen) {
> +

argh, unnecessary leftover from my local changes. Hopefully it can be
cleaned up during applying so that I don't spam the mailing list
unnecessarily.

>                         if (!test_case->btf_src_file || test_case->fails)=
 {
>                                 test__skip();
>                                 continue;
> @@ -989,7 +993,8 @@ static void run_core_reloc_tests(bool use_btfgen)
>                         CHECK_FAIL(munmap(mmap_data, mmap_sz));
>                         mmap_data =3D NULL;
>                 }
> -               remove(btf_file);
> +               if (use_btfgen)
> +                       remove(test_case->btf_src_file);
>                 bpf_link__destroy(link);
>                 link =3D NULL;
>                 bpf_object__close(obj);
> @@ -1001,7 +1006,7 @@ void test_core_reloc(void)
>         run_core_reloc_tests(false);
>  }
>
> -void test_core_btfgen(void)
> +void test_core_reloc_btfgen(void)
>  {
>         run_core_reloc_tests(true);
>  }
> --
> 2.30.2
>
