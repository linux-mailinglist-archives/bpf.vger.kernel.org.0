Return-Path: <bpf+bounces-4014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79625747B49
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 03:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A261628101A
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 01:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D660D81C;
	Wed,  5 Jul 2023 01:47:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E0263C
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 01:47:32 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AB3E6B;
	Tue,  4 Jul 2023 18:47:29 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-bff27026cb0so6853114276.1;
        Tue, 04 Jul 2023 18:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688521648; x=1691113648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeTI5CIgCuzpnmKQkmyDNT2MsTKNPd7hIKAG/64uJMo=;
        b=gzlIekoMzg7JOa19C35HRHyUbSQoFSVInnXVxHRTrxmjKNiXn9Q3el5dtOsGSCRE1X
         AMhaWWkH5nU+isI9r5Zb9cuIfQsEvWBQPy0RLjibvLN58u1SLp5LPRh/s54QSw95ghzl
         6RNWZYie6yflRN5IT2SAP7BA8GeoBHwmdEEZZJM0Tzzv0AOQMZ0BYsUFywUZK9B4+a2j
         kL8hx4LvQLc31ymBYaJ0T7XMa5AGixEy8W0Avq1NRd9mCBU2tgk9DQ7eVkclyCAVKiZj
         17+R7NVPFTGf0v8lu2JFb8AklUvrbcgICOgiYw0I5qTAqkBVEl5+LJAes935vfhQlp2A
         BGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688521648; x=1691113648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeTI5CIgCuzpnmKQkmyDNT2MsTKNPd7hIKAG/64uJMo=;
        b=VReieUGTOUxusL+GyTEzGmwiLL187Xk7bXpmJS01HozOGuCEOZ09XMDefPtj/j7L0/
         /YQc83cRux3VHwLkH6hVq68AXWmojR1ad7zFjkuhum5LOid9XZiyuKj8O5uKzCXdCNru
         9JWS6U6v4PdqoCSp3BdfciA/CxDAHjR72jqDlTSZmd1yek5BwiCclhdzhJHjEMVadrOF
         vioz7J14zUjDJB73MiWDav0dRlZApevO7y4cJpdxRAGcfJnWzYROvf2x2iXax7clvVxj
         oNeZawc8eN5l2c5xrhdthZcKriyiY7BH5vzPPpS9seOdfIShMdycjl5QiIehpuQUyjCA
         YmmQ==
X-Gm-Message-State: ABy/qLai6JuNMLMyPaIZe1VCjR9QUcslxuK6bsTZlmS/M6kTDxmRO+vX
	W/yg5Tv8r41+tcVPpW1bdc2xs26Uy39ttFfg5f8=
X-Google-Smtp-Source: APBJJlE+FppHHJSrMCSPQcYjoXmRud0eVvdpbLv0QenjdRLMJ4L66B+LGHml9gGqST0TfKNkmOtNrGSzVHQYVZ2H9j8=
X-Received: by 2002:a0d:c886:0:b0:56c:f0c7:90cf with SMTP id
 k128-20020a0dc886000000b0056cf0c790cfmr15274911ywd.48.1688521648377; Tue, 04
 Jul 2023 18:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627115319.13128-1-imagedong@tencent.com> <20230627115319.13128-4-imagedong@tencent.com>
In-Reply-To: <20230627115319.13128-4-imagedong@tencent.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 5 Jul 2023 09:47:16 +0800
Message-ID: <CADxym3YSgEsmNQNiFFZsi=2F3np-zJFFCc3dHMrR5+JoM2353w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/3] selftests/bpf: add testcase for TRACING
 with 6+ arguments
To: daniel@iogearbox.net, yhs@meta.com
Cc: ast@kernel.org, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 7:54=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> Add fentry_many_args.c and fexit_many_args.c to test the fentry/fexit
> with 7/11 arguments. As this feature is not supported by arm64 yet, we
> disable these testcases for arm64 in DENYLIST.aarch64. We can combine
> them with fentry_test.c/fexit_test.c when arm64 is supported too.
>
> Correspondingly, add bpf_testmod_fentry_test7() and
> bpf_testmod_fentry_test11() to bpf_testmod.c
>
> Meanwhile, add bpf_modify_return_test2() to test_run.c to test the
> MODIFY_RETURN with 7 arguments.
>
> Add bpf_testmod_test_struct_arg_7/bpf_testmod_test_struct_arg_7 in
> bpf_testmod.c to test the struct in the arguments.
>
> And the testcases passed on x86_64:
>
> ./test_progs -t fexit
> Summary: 5/14 PASSED, 0 SKIPPED, 0 FAILED
>
> ./test_progs -t fentry
> Summary: 3/2 PASSED, 0 SKIPPED, 0 FAILED
>
> ./test_progs -t modify_return
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> ./test_progs -t tracing_struct
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
> v7:
> - split the testcases, and add fentry_many_args/fexit_many_args to
>   DENYLIST.aarch64
> v6:
> - add testcases to tracing_struct.c instead of fentry_test.c and
>   fexit_test.c
> v5:
> - add testcases for MODIFY_RETURN
> v4:
> - use different type for args in bpf_testmod_fentry_test{7,12}
> - add testcase for grabage values in ctx
> v3:
> - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
>   bpf_testmod_fentry_test{7,12} meanwhile
> - get return value by bpf_get_func_ret() in
>   "fexit/bpf_testmod_fentry_test12", as we don't change ___bpf_ctx_cast()
>   in this version
> ---
>  net/bpf/test_run.c                            | 23 ++++++--
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |  2 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 49 ++++++++++++++++-
>  .../selftests/bpf/prog_tests/fentry_test.c    | 43 +++++++++++++--
>  .../selftests/bpf/prog_tests/fexit_test.c     | 43 +++++++++++++--
>  .../selftests/bpf/prog_tests/modify_return.c  | 20 ++++++-
>  .../selftests/bpf/prog_tests/tracing_struct.c | 19 +++++++
>  .../selftests/bpf/progs/fentry_many_args.c    | 39 ++++++++++++++
>  .../selftests/bpf/progs/fexit_many_args.c     | 40 ++++++++++++++
>  .../selftests/bpf/progs/modify_return.c       | 40 ++++++++++++++
>  .../selftests/bpf/progs/tracing_struct.c      | 54 +++++++++++++++++++
>  11 files changed, 358 insertions(+), 14 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_many_args.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fexit_many_args.c
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 2321bd2f9964..df58e8bf5e07 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -561,6 +561,13 @@ __bpf_kfunc int bpf_modify_return_test(int a, int *b=
)
>         return a + *b;
>  }
>
> +__bpf_kfunc int bpf_modify_return_test2(int a, int *b, short c, int d,
> +                                       void *e, char f, int g)
> +{
> +       *b +=3D 1;
> +       return a + *b + c + d + (long)e + f + g;
> +}
> +
>  int noinline bpf_fentry_shadow_test(int a)
>  {
>         return a + 1;
> @@ -596,9 +603,13 @@ __diag_pop();
>
>  BTF_SET8_START(bpf_test_modify_return_ids)
>  BTF_ID_FLAGS(func, bpf_modify_return_test)
> +BTF_ID_FLAGS(func, bpf_modify_return_test2)
>  BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
>  BTF_SET8_END(bpf_test_modify_return_ids)
>
> +BTF_ID_LIST(bpf_modify_return_test_id)
> +BTF_ID(func, bpf_modify_return_test)
> +
>  static const struct btf_kfunc_id_set bpf_test_modify_return_set =3D {
>         .owner =3D THIS_MODULE,
>         .set   =3D &bpf_test_modify_return_ids,
> @@ -661,9 +672,15 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
>                         goto out;
>                 break;
>         case BPF_MODIFY_RETURN:
> -               ret =3D bpf_modify_return_test(1, &b);
> -               if (b !=3D 2)
> -                       side_effect =3D 1;
> +               if (prog->aux->attach_btf_id =3D=3D *bpf_modify_return_te=
st_id) {
> +                       ret =3D bpf_modify_return_test(1, &b);
> +                       if (b !=3D 2)
> +                               side_effect =3D 1;
> +               } else {
> +                       ret =3D bpf_modify_return_test2(1, &b, 3, 4, (voi=
d *)5, 6, 7);
> +                       if (b !=3D 2)
> +                               side_effect =3D 1;
> +               }
>                 break;
>         default:
>                 goto out;
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing=
/selftests/bpf/DENYLIST.aarch64
> index 08adc805878b..3b61e8b35d62 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -10,3 +10,5 @@ kprobe_multi_test/link_api_addrs                 # link=
_fd unexpected link_fd: a
>  kprobe_multi_test/link_api_syms                  # link_fd unexpected li=
nk_fd: actual -95 < expected 0
>  kprobe_multi_test/skel_api                       # libbpf: failed to loa=
d BPF skeleton 'kprobe_multi': -3
>  module_attach                                    # prog 'kprobe_multi': =
failed to auto-attach: -95
> +fentry_test/fentry_many_args                     # fentry_many_args:FAIL=
:fentry_many_args_attach unexpected error: -524
> +fexit_test/fexit_many_args                       # fexit_many_args:FAIL:=
fexit_many_args_attach unexpected error: -524
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index aaf6ef1201c7..a6f991b56345 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -34,6 +34,11 @@ struct bpf_testmod_struct_arg_3 {
>         int b[];
>  };
>
> +struct bpf_testmod_struct_arg_4 {
> +       u64 a;
> +       int b;
> +};
> +
>  __diag_push();
>  __diag_ignore_all("-Wmissing-prototypes",
>                   "Global functions as their definitions will be in bpf_t=
estmod.ko BTF");
> @@ -75,6 +80,24 @@ bpf_testmod_test_struct_arg_6(struct bpf_testmod_struc=
t_arg_3 *a) {
>         return bpf_testmod_test_struct_arg_result;
>  }
>
> +noinline int
> +bpf_testmod_test_struct_arg_7(u64 a, void *b, short c, int d, void *e,
> +                             struct bpf_testmod_struct_arg_4 f)
> +{
> +       bpf_testmod_test_struct_arg_result =3D a + (long)b + c + d +
> +               (long)e + f.a + f.b;
> +       return bpf_testmod_test_struct_arg_result;
> +}
> +
> +noinline int
> +bpf_testmod_test_struct_arg_8(u64 a, void *b, short c, int d, void *e,
> +                             struct bpf_testmod_struct_arg_4 f, int g)
> +{
> +       bpf_testmod_test_struct_arg_result =3D a + (long)b + c + d +
> +               (long)e + f.a + f.b + g;
> +       return bpf_testmod_test_struct_arg_result;
> +}
> +
>  __bpf_kfunc void
>  bpf_testmod_test_mod_kfunc(int i)
>  {
> @@ -191,6 +214,20 @@ noinline int bpf_testmod_fentry_test3(char a, int b,=
 u64 c)
>         return a + b + c;
>  }
>
> +noinline int bpf_testmod_fentry_test7(u64 a, void *b, short c, int d,
> +                                     void *e, char f, int g)
> +{
> +       return a + (long)b + c + d + (long)e + f + g;
> +}
> +
> +noinline int bpf_testmod_fentry_test11(u64 a, void *b, short c, int d,
> +                                      void *e, char f, int g,
> +                                      unsigned int h, long i, __u64 j,
> +                                      unsigned long k)
> +{
> +       return a + (long)b + c + d + (long)e + f + g + h + i + j + k;
> +}
> +
>  int bpf_testmod_fentry_ok;
>
>  noinline ssize_t
> @@ -206,6 +243,7 @@ bpf_testmod_test_read(struct file *file, struct kobje=
ct *kobj,
>         struct bpf_testmod_struct_arg_1 struct_arg1 =3D {10};
>         struct bpf_testmod_struct_arg_2 struct_arg2 =3D {2, 3};
>         struct bpf_testmod_struct_arg_3 *struct_arg3;
> +       struct bpf_testmod_struct_arg_4 struct_arg4 =3D {21, 22};
>         int i =3D 1;
>
>         while (bpf_testmod_return_ptr(i))
> @@ -216,6 +254,11 @@ bpf_testmod_test_read(struct file *file, struct kobj=
ect *kobj,
>         (void)bpf_testmod_test_struct_arg_3(1, 4, struct_arg2);
>         (void)bpf_testmod_test_struct_arg_4(struct_arg1, 1, 2, 3, struct_=
arg2);
>         (void)bpf_testmod_test_struct_arg_5();
> +       (void)bpf_testmod_test_struct_arg_7(16, (void *)17, 18, 19,
> +                                           (void *)20, struct_arg4);
> +       (void)bpf_testmod_test_struct_arg_8(16, (void *)17, 18, 19,
> +                                           (void *)20, struct_arg4, 23);
> +
>
>         struct_arg3 =3D kmalloc((sizeof(struct bpf_testmod_struct_arg_3) =
+
>                                 sizeof(int)), GFP_KERNEL);
> @@ -243,7 +286,11 @@ bpf_testmod_test_read(struct file *file, struct kobj=
ect *kobj,
>
>         if (bpf_testmod_fentry_test1(1) !=3D 2 ||
>             bpf_testmod_fentry_test2(2, 3) !=3D 5 ||
> -           bpf_testmod_fentry_test3(4, 5, 6) !=3D 15)
> +           bpf_testmod_fentry_test3(4, 5, 6) !=3D 15 ||
> +           bpf_testmod_fentry_test7(16, (void *)17, 18, 19, (void *)20,
> +                       21, 22) !=3D 133 ||
> +           bpf_testmod_fentry_test11(16, (void *)17, 18, 19, (void *)20,
> +                       21, 22, 23, 24, 25, 26) !=3D 231)
>                 goto out;
>
>         bpf_testmod_fentry_ok =3D 1;
> diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_test.c b/tools=
/testing/selftests/bpf/prog_tests/fentry_test.c
> index c0d1d61d5f66..aee1bc77a17f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fentry_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
> @@ -2,8 +2,9 @@
>  /* Copyright (c) 2019 Facebook */
>  #include <test_progs.h>
>  #include "fentry_test.lskel.h"
> +#include "fentry_many_args.skel.h"
>
> -static int fentry_test(struct fentry_test_lskel *fentry_skel)
> +static int fentry_test_common(struct fentry_test_lskel *fentry_skel)
>  {
>         int err, prog_fd, i;
>         int link_fd;
> @@ -37,7 +38,7 @@ static int fentry_test(struct fentry_test_lskel *fentry=
_skel)
>         return 0;
>  }
>
> -void test_fentry_test(void)
> +static void fentry_test(void)
>  {
>         struct fentry_test_lskel *fentry_skel =3D NULL;
>         int err;
> @@ -46,13 +47,47 @@ void test_fentry_test(void)
>         if (!ASSERT_OK_PTR(fentry_skel, "fentry_skel_load"))
>                 goto cleanup;
>
> -       err =3D fentry_test(fentry_skel);
> +       err =3D fentry_test_common(fentry_skel);
>         if (!ASSERT_OK(err, "fentry_first_attach"))
>                 goto cleanup;
>
> -       err =3D fentry_test(fentry_skel);
> +       err =3D fentry_test_common(fentry_skel);
>         ASSERT_OK(err, "fentry_second_attach");
>
>  cleanup:
>         fentry_test_lskel__destroy(fentry_skel);
>  }
> +
> +static void fentry_many_args(void)
> +{
> +       struct fentry_many_args *fentry_skel =3D NULL;
> +       int err;
> +
> +       fentry_skel =3D fentry_many_args__open_and_load();
> +       if (!ASSERT_OK_PTR(fentry_skel, "fentry_many_args_skel_load"))
> +               goto cleanup;
> +
> +       err =3D fentry_many_args__attach(fentry_skel);
> +       if (!ASSERT_OK(err, "fentry_many_args_attach"))
> +               goto cleanup;
> +
> +       ASSERT_OK(trigger_module_test_read(1), "trigger_read");
> +
> +       ASSERT_EQ(fentry_skel->bss->test1_result, 1,
> +                 "fentry_many_args_result1");
> +       ASSERT_EQ(fentry_skel->bss->test2_result, 1,
> +                 "fentry_many_args_result2");
> +       ASSERT_EQ(fentry_skel->bss->test3_result, 1,
> +                 "fentry_many_args_result3");
> +
> +cleanup:
> +       fentry_many_args__destroy(fentry_skel);
> +}
> +

Hello,

Is there anything else that needs to be improved in this series?
Is it about the ugly function naming of "fentry_many_args"?

Sorry for the bother, but it has been pending for a while :)

Thanks!
Menglong Dong

> +void test_fentry_test(void)
> +{
> +       if (test__start_subtest("fentry"))
> +               fentry_test();
> +       if (test__start_subtest("fentry_many_args"))
> +               fentry_many_args();
> +}
> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_test.c b/tools/=
testing/selftests/bpf/prog_tests/fexit_test.c
> index 101b7343036b..1c13007e37dd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
> @@ -2,8 +2,9 @@
>  /* Copyright (c) 2019 Facebook */
>  #include <test_progs.h>
>  #include "fexit_test.lskel.h"
> +#include "fexit_many_args.skel.h"
>
> -static int fexit_test(struct fexit_test_lskel *fexit_skel)
> +static int fexit_test_common(struct fexit_test_lskel *fexit_skel)
>  {
>         int err, prog_fd, i;
>         int link_fd;
> @@ -37,7 +38,7 @@ static int fexit_test(struct fexit_test_lskel *fexit_sk=
el)
>         return 0;
>  }
>
> -void test_fexit_test(void)
> +static void fexit_test(void)
>  {
>         struct fexit_test_lskel *fexit_skel =3D NULL;
>         int err;
> @@ -46,13 +47,47 @@ void test_fexit_test(void)
>         if (!ASSERT_OK_PTR(fexit_skel, "fexit_skel_load"))
>                 goto cleanup;
>
> -       err =3D fexit_test(fexit_skel);
> +       err =3D fexit_test_common(fexit_skel);
>         if (!ASSERT_OK(err, "fexit_first_attach"))
>                 goto cleanup;
>
> -       err =3D fexit_test(fexit_skel);
> +       err =3D fexit_test_common(fexit_skel);
>         ASSERT_OK(err, "fexit_second_attach");
>
>  cleanup:
>         fexit_test_lskel__destroy(fexit_skel);
>  }
> +
> +static void fexit_many_args(void)
> +{
> +       struct fexit_many_args *fexit_skel =3D NULL;
> +       int err;
> +
> +       fexit_skel =3D fexit_many_args__open_and_load();
> +       if (!ASSERT_OK_PTR(fexit_skel, "fexit_many_args_skel_load"))
> +               goto cleanup;
> +
> +       err =3D fexit_many_args__attach(fexit_skel);
> +       if (!ASSERT_OK(err, "fexit_many_args_attach"))
> +               goto cleanup;
> +
> +       ASSERT_OK(trigger_module_test_read(1), "trigger_read");
> +
> +       ASSERT_EQ(fexit_skel->bss->test1_result, 1,
> +                 "fexit_many_args_result1");
> +       ASSERT_EQ(fexit_skel->bss->test2_result, 1,
> +                 "fexit_many_args_result2");
> +       ASSERT_EQ(fexit_skel->bss->test3_result, 1,
> +                 "fexit_many_args_result3");
> +
> +cleanup:
> +       fexit_many_args__destroy(fexit_skel);
> +}
> +
> +void test_fexit_test(void)
> +{
> +       if (test__start_subtest("fexit"))
> +               fexit_test();
> +       if (test__start_subtest("fexit_many_args"))
> +               fexit_many_args();
> +}
> diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/too=
ls/testing/selftests/bpf/prog_tests/modify_return.c
> index 5d9955af6247..93febb6d81ef 100644
> --- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
> +++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
> @@ -11,7 +11,8 @@
>  #define UPPER(x) ((x) >> 16)
>
>
> -static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 w=
ant_ret)
> +static void run_test(__u32 input_retval, __u16 want_side_effect,
> +                    __s16 want_ret, __s16 want_ret2)
>  {
>         struct modify_return *skel =3D NULL;
>         int err, prog_fd;
> @@ -41,6 +42,19 @@ static void run_test(__u32 input_retval, __u16 want_si=
de_effect, __s16 want_ret)
>         ASSERT_EQ(skel->bss->fexit_result, 1, "modify_return fexit_result=
");
>         ASSERT_EQ(skel->bss->fmod_ret_result, 1, "modify_return fmod_ret_=
result");
>
> +       prog_fd =3D bpf_program__fd(skel->progs.fmod_ret_test2);
> +       err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +       ASSERT_OK(err, "test_run");
> +
> +       side_effect =3D UPPER(topts.retval);
> +       ret =3D LOWER(topts.retval);
> +
> +       ASSERT_EQ(ret, want_ret2, "test_run ret2");
> +       ASSERT_EQ(side_effect, want_side_effect, "modify_return side_effe=
ct2");
> +       ASSERT_EQ(skel->bss->fentry_result2, 1, "modify_return fentry_res=
ult2");
> +       ASSERT_EQ(skel->bss->fexit_result2, 1, "modify_return fexit_resul=
t2");
> +       ASSERT_EQ(skel->bss->fmod_ret_result2, 1, "modify_return fmod_ret=
_result2");
> +
>  cleanup:
>         modify_return__destroy(skel);
>  }
> @@ -50,8 +64,10 @@ void serial_test_modify_return(void)
>  {
>         run_test(0 /* input_retval */,
>                  1 /* want_side_effect */,
> -                4 /* want_ret */);
> +                4 /* want_ret */,
> +                29 /* want_ret */);
>         run_test(-EINVAL /* input_retval */,
>                  0 /* want_side_effect */,
> +                -EINVAL /* want_ret */,
>                  -EINVAL /* want_ret */);
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/to=
ols/testing/selftests/bpf/prog_tests/tracing_struct.c
> index 1c75a32186d6..fe0fb0c9849a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
> @@ -55,6 +55,25 @@ static void test_fentry(void)
>
>         ASSERT_EQ(skel->bss->t6, 1, "t6 ret");
>
> +       ASSERT_EQ(skel->bss->t7_a, 16, "t7:a");
> +       ASSERT_EQ(skel->bss->t7_b, 17, "t7:b");
> +       ASSERT_EQ(skel->bss->t7_c, 18, "t7:c");
> +       ASSERT_EQ(skel->bss->t7_d, 19, "t7:d");
> +       ASSERT_EQ(skel->bss->t7_e, 20, "t7:e");
> +       ASSERT_EQ(skel->bss->t7_f_a, 21, "t7:f.a");
> +       ASSERT_EQ(skel->bss->t7_f_b, 22, "t7:f.b");
> +       ASSERT_EQ(skel->bss->t7_ret, 133, "t7 ret");
> +
> +       ASSERT_EQ(skel->bss->t8_a, 16, "t8:a");
> +       ASSERT_EQ(skel->bss->t8_b, 17, "t8:b");
> +       ASSERT_EQ(skel->bss->t8_c, 18, "t8:c");
> +       ASSERT_EQ(skel->bss->t8_d, 19, "t8:d");
> +       ASSERT_EQ(skel->bss->t8_e, 20, "t8:e");
> +       ASSERT_EQ(skel->bss->t8_f_a, 21, "t8:f.a");
> +       ASSERT_EQ(skel->bss->t8_f_b, 22, "t8:f.b");
> +       ASSERT_EQ(skel->bss->t8_g, 23, "t8:g");
> +       ASSERT_EQ(skel->bss->t8_ret, 156, "t8 ret");
> +
>         tracing_struct__detach(skel);
>  destroy_skel:
>         tracing_struct__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/fentry_many_args.c b/tools=
/testing/selftests/bpf/progs/fentry_many_args.c
> new file mode 100644
> index 000000000000..b61bb92fee2c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fentry_many_args.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Tencent */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +__u64 test1_result =3D 0;
> +SEC("fentry/bpf_testmod_fentry_test7")
> +int BPF_PROG(test1, __u64 a, void *b, short c, int d, void *e, char f,
> +            int g)
> +{
> +       test1_result =3D a =3D=3D 16 && b =3D=3D (void *)17 && c =3D=3D 1=
8 && d =3D=3D 19 &&
> +               e =3D=3D (void *)20 && f =3D=3D 21 && g =3D=3D 22;
> +       return 0;
> +}
> +
> +__u64 test2_result =3D 0;
> +SEC("fentry/bpf_testmod_fentry_test11")
> +int BPF_PROG(test2, __u64 a, void *b, short c, int d, void *e, char f,
> +            int g, unsigned int h, long i, __u64 j, unsigned long k)
> +{
> +       test2_result =3D a =3D=3D 16 && b =3D=3D (void *)17 && c =3D=3D 1=
8 && d =3D=3D 19 &&
> +               e =3D=3D (void *)20 && f =3D=3D 21 && g =3D=3D 22 && h =
=3D=3D 23 &&
> +               i =3D=3D 24 && j =3D=3D 25 && k =3D=3D 26;
> +       return 0;
> +}
> +
> +__u64 test3_result =3D 0;
> +SEC("fentry/bpf_testmod_fentry_test11")
> +int BPF_PROG(test3, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f=
,
> +            __u64 g, __u64 h, __u64 i, __u64 j, __u64 k)
> +{
> +       test3_result =3D a =3D=3D 16 && b =3D=3D 17 && c =3D=3D 18 && d =
=3D=3D 19 &&
> +               e =3D=3D 20 && f =3D=3D 21 && g =3D=3D 22 && h =3D=3D 23 =
&&
> +               i =3D=3D 24 && j =3D=3D 25 && k =3D=3D 26;
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fexit_many_args.c b/tools/=
testing/selftests/bpf/progs/fexit_many_args.c
> new file mode 100644
> index 000000000000..53b335c2dafb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/fexit_many_args.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Tencent */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +__u64 test1_result =3D 0;
> +SEC("fexit/bpf_testmod_fentry_test7")
> +int BPF_PROG(test1, __u64 a, void *b, short c, int d, void *e, char f,
> +            int g, int ret)
> +{
> +       test1_result =3D a =3D=3D 16 && b =3D=3D (void *)17 && c =3D=3D 1=
8 && d =3D=3D 19 &&
> +               e =3D=3D (void *)20 && f =3D=3D 21 && g =3D=3D 22 && ret =
=3D=3D 133;
> +       return 0;
> +}
> +
> +__u64 test2_result =3D 0;
> +SEC("fexit/bpf_testmod_fentry_test11")
> +int BPF_PROG(test2, __u64 a, void *b, short c, int d, void *e, char f,
> +            int g, unsigned int h, long i, __u64 j, unsigned long k,
> +            int ret)
> +{
> +       test2_result =3D a =3D=3D 16 && b =3D=3D (void *)17 && c =3D=3D 1=
8 && d =3D=3D 19 &&
> +               e =3D=3D (void *)20 && f =3D=3D 21 && g =3D=3D 22 && h =
=3D=3D 23 &&
> +               i =3D=3D 24 && j =3D=3D 25 && k =3D=3D 26 && ret =3D=3D 2=
31;
> +       return 0;
> +}
> +
> +__u64 test3_result =3D 0;
> +SEC("fexit/bpf_testmod_fentry_test11")
> +int BPF_PROG(test3, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f=
,
> +            __u64 g, __u64 h, __u64 i, __u64 j, __u64 k, __u64 ret)
> +{
> +       test3_result =3D a =3D=3D 16 && b =3D=3D 17 && c =3D=3D 18 && d =
=3D=3D 19 &&
> +               e =3D=3D 20 && f =3D=3D 21 && g =3D=3D 22 && h =3D=3D 23 =
&&
> +               i =3D=3D 24 && j =3D=3D 25 && k =3D=3D 26 && ret =3D=3D 2=
31;
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/modify_return.c b/tools/te=
sting/selftests/bpf/progs/modify_return.c
> index 8b7466a15c6b..3376d4849f58 100644
> --- a/tools/testing/selftests/bpf/progs/modify_return.c
> +++ b/tools/testing/selftests/bpf/progs/modify_return.c
> @@ -47,3 +47,43 @@ int BPF_PROG(fexit_test, int a, __u64 b, int ret)
>
>         return 0;
>  }
> +
> +static int sequence2;
> +
> +__u64 fentry_result2 =3D 0;
> +SEC("fentry/bpf_modify_return_test2")
> +int BPF_PROG(fentry_test2, int a, int *b, short c, int d, void *e, char =
f,
> +            int g)
> +{
> +       sequence2++;
> +       fentry_result2 =3D (sequence2 =3D=3D 1);
> +       return 0;
> +}
> +
> +__u64 fmod_ret_result2 =3D 0;
> +SEC("fmod_ret/bpf_modify_return_test2")
> +int BPF_PROG(fmod_ret_test2, int a, int *b, short c, int d, void *e, cha=
r f,
> +            int g, int ret)
> +{
> +       sequence2++;
> +       /* This is the first fmod_ret program, the ret passed should be 0=
 */
> +       fmod_ret_result2 =3D (sequence2 =3D=3D 2 && ret =3D=3D 0);
> +       return input_retval;
> +}
> +
> +__u64 fexit_result2 =3D 0;
> +SEC("fexit/bpf_modify_return_test2")
> +int BPF_PROG(fexit_test2, int a, int *b, short c, int d, void *e, char f=
,
> +            int g, int ret)
> +{
> +       sequence2++;
> +       /* If the input_reval is non-zero a successful modification shoul=
d have
> +        * occurred.
> +        */
> +       if (input_retval)
> +               fexit_result2 =3D (sequence2 =3D=3D 3 && ret =3D=3D input=
_retval);
> +       else
> +               fexit_result2 =3D (sequence2 =3D=3D 3 && ret =3D=3D 29);
> +
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/tracing_struct.c b/tools/t=
esting/selftests/bpf/progs/tracing_struct.c
> index c435a3a8328a..515daef3c84b 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_struct.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_struct.c
> @@ -18,6 +18,11 @@ struct bpf_testmod_struct_arg_3 {
>         int b[];
>  };
>
> +struct bpf_testmod_struct_arg_4 {
> +       u64 a;
> +       int b;
> +};
> +
>  long t1_a_a, t1_a_b, t1_b, t1_c, t1_ret, t1_nregs;
>  __u64 t1_reg0, t1_reg1, t1_reg2, t1_reg3;
>  long t2_a, t2_b_a, t2_b_b, t2_c, t2_ret;
> @@ -25,6 +30,9 @@ long t3_a, t3_b, t3_c_a, t3_c_b, t3_ret;
>  long t4_a_a, t4_b, t4_c, t4_d, t4_e_a, t4_e_b, t4_ret;
>  long t5_ret;
>  int t6;
> +long t7_a, t7_b, t7_c, t7_d, t7_e, t7_f_a, t7_f_b, t7_ret;
> +long t8_a, t8_b, t8_c, t8_d, t8_e, t8_f_a, t8_f_b, t8_g, t8_ret;
> +
>
>  SEC("fentry/bpf_testmod_test_struct_arg_1")
>  int BPF_PROG2(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, int=
, b, int, c)
> @@ -130,4 +138,50 @@ int BPF_PROG2(test_struct_arg_11, struct bpf_testmod=
_struct_arg_3 *, a)
>         return 0;
>  }
>
> +SEC("fentry/bpf_testmod_test_struct_arg_7")
> +int BPF_PROG2(test_struct_arg_12, __u64, a, void *, b, short, c, int, d,
> +             void *, e, struct bpf_testmod_struct_arg_4, f)
> +{
> +       t7_a =3D a;
> +       t7_b =3D (long)b;
> +       t7_c =3D c;
> +       t7_d =3D d;
> +       t7_e =3D (long)e;
> +       t7_f_a =3D f.a;
> +       t7_f_b =3D f.b;
> +       return 0;
> +}
> +
> +SEC("fexit/bpf_testmod_test_struct_arg_7")
> +int BPF_PROG2(test_struct_arg_13, __u64, a, void *, b, short, c, int, d,
> +             void *, e, struct bpf_testmod_struct_arg_4, f, int, ret)
> +{
> +       t7_ret =3D ret;
> +       return 0;
> +}
> +
> +SEC("fentry/bpf_testmod_test_struct_arg_8")
> +int BPF_PROG2(test_struct_arg_14, __u64, a, void *, b, short, c, int, d,
> +             void *, e, struct bpf_testmod_struct_arg_4, f, int, g)
> +{
> +       t8_a =3D a;
> +       t8_b =3D (long)b;
> +       t8_c =3D c;
> +       t8_d =3D d;
> +       t8_e =3D (long)e;
> +       t8_f_a =3D f.a;
> +       t8_f_b =3D f.b;
> +       t8_g =3D g;
> +       return 0;
> +}
> +
> +SEC("fexit/bpf_testmod_test_struct_arg_8")
> +int BPF_PROG2(test_struct_arg_15, __u64, a, void *, b, short, c, int, d,
> +             void *, e, struct bpf_testmod_struct_arg_4, f, int, g,
> +             int, ret)
> +{
> +       t8_ret =3D ret;
> +       return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.40.1
>

