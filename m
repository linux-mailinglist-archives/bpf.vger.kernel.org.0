Return-Path: <bpf+bounces-2308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7A472A9A6
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 09:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EA71C20EA2
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 07:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4379C3;
	Sat, 10 Jun 2023 07:01:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62CD1878
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 07:01:53 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08D43AA5;
	Sat, 10 Jun 2023 00:01:50 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 3f1490d57ef6-b9e6ec482b3so2458381276.3;
        Sat, 10 Jun 2023 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686380510; x=1688972510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xAXJTHgYn8Ldx/+53+yK5kSj7EjdhGs+jf5NNgnKWs=;
        b=CtcNrC4XUIq1QCD9WPU0QJFfKZ+p67faFld4t/dH2VZ2VdWWZ+CLp4HoghjHckota7
         9aOX9s61xoTJ1jisUaFmg94mm26+HPSZ/OXrgjk0As2nK4dxFyMhqNHbaVDM6naJF0yy
         jE+MdW2NcSHRc+Uny8AjNgEQ1z3tVE1YhxUo/4iQ/5DPI00b33qnwSMGArvXaQfA4L1t
         +o535G8n6Cq6DS65aTeYCeXo8vG2NtUdm1mJnzqCxRyMl/GAQxQocZR7OcNYn8k1Xmuc
         xTpqQ7R12zagkx0/jxUond6sbinwA8t6LWtCKQFpIKOAPs/NFonjAvobUPh0UDjmn981
         3MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686380510; x=1688972510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xAXJTHgYn8Ldx/+53+yK5kSj7EjdhGs+jf5NNgnKWs=;
        b=j+qZmbeGclAfp59GDODW1aWSKS3SP/ZFxvuTLiFzLRmH34uZA3zgCyBECF2pHrIQHp
         siZROLR7AN/Ygg7LxpvcvmiFRSxk0RLpmK9i4JkxvuzzSORo8edtkllGdB1JVKDpkbbZ
         NgN8QHKj/LcciMv3IX8zj3nFSHWN8rWnb0NvBfR/4Sm3DLOMXH9dEBdz0zndyI/SNZSY
         cwYN/WzrMDarOXwZXmTTY2SyKK6tzg/EnDR4kwzqqx6NYsnm8Z0DRneAATGN0m8SKsur
         2J0iPhre3Ui3YsdMCWPVCsYfKvZfjBsSbBkGz627E7CwAL54TF8c8T3HlzBwmHmrL6Fs
         K0Sg==
X-Gm-Message-State: AC+VfDxo0RHrQI+x+IvxX5TBaGjLQpZXTp9b9mli4uJzsR+c39S6YmHp
	uYy7Y4uzz3pwry3V2CQn+bCmjxSwe8+ap9YmBRE=
X-Google-Smtp-Source: ACHHUZ4mHFQTMPoEncM+OA8Q5aKcDmmrEL+plkeb5wxhv3qwP1nN3QJ//pntgqzOtpCEGRoY/E2btK2dOO2MMFMqaMU=
X-Received: by 2002:a25:ef12:0:b0:ba8:6e44:616d with SMTP id
 g18-20020a25ef12000000b00ba86e44616dmr2183478ybd.59.1686380509673; Sat, 10
 Jun 2023 00:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230609095653.1406173-1-imagedong@tencent.com>
 <20230609095653.1406173-4-imagedong@tencent.com> <50d29ea7-09b8-9026-e127-8c21a4bb9706@meta.com>
In-Reply-To: <50d29ea7-09b8-9026-e127-8c21a4bb9706@meta.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 10 Jun 2023 15:01:38 +0800
Message-ID: <CADxym3YzHBU6E8dtAucwsZ0MJ_WZzFkRB8anbJHPmYqmNnu+eA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: add testcase for
 FENTRY/FEXIT with 6+ arguments
To: Yonghong Song <yhs@meta.com>
Cc: andrii.nakryiko@gmail.com, alan.maguire@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 10, 2023 at 11:29=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 6/9/23 2:56 AM, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > Add test9/test10 in fexit_test.c and fentry_test.c to test the fentry
> > and fexit whose target function have 7/12 arguments.
> >
> > Correspondingly, add bpf_testmod_fentry_test7() and
> > bpf_testmod_fentry_test12() to bpf_testmod.c
> >
> > And the testcases passed:
> >
> > ./test_progs -t fexit
> > Summary: 5/12 PASSED, 0 SKIPPED, 0 FAILED
> >
> > ./test_progs -t fentry
> > Summary: 3/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> > v4:
> > - use different type for args in bpf_testmod_fentry_test{7,12}
> > - add testcase for grabage values in ctx
> > v3:
> > - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
> >    bpf_testmod_fentry_test{7,12} meanwhile
> > - get return value by bpf_get_func_ret() in
> >    "fexit/bpf_testmod_fentry_test12", as we don't change ___bpf_ctx_cas=
t()
> >    in this version
> > ---
> >   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++-
> >   .../selftests/bpf/prog_tests/fentry_fexit.c   |  4 +-
> >   .../selftests/bpf/prog_tests/fentry_test.c    |  2 +
> >   .../selftests/bpf/prog_tests/fexit_test.c     |  2 +
> >   .../testing/selftests/bpf/progs/fentry_test.c | 33 +++++++++++
> >   .../testing/selftests/bpf/progs/fexit_test.c  | 57 ++++++++++++++++++=
+
> >   6 files changed, 115 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/to=
ols/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index cf216041876c..66615fdbe3df 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -191,6 +191,19 @@ noinline int bpf_testmod_fentry_test3(char a, int =
b, u64 c)
> >       return a + b + c;
> >   }
> >
> > +noinline int bpf_testmod_fentry_test7(u64 a, void *b, short c, int d,
> > +                                   void *e, u64 f, u64 g)
> > +{
> > +     return a + (long)b + c + d + (long)e + f + g;
> > +}
> > +
> > +noinline int bpf_testmod_fentry_test12(u64 a, void *b, short c, int d,
> > +                                    void *e, u64 f, u64 g, u64 h,
> > +                                    u64 i, u64 j, u64 k, u64 l)
> > +{
> > +     return a + (long)b + c + d + (long)e + f + g + h + i + j + k + l;
> > +}
>
> It would be great to add a couple cases with struct arguments
> where each struct has 8 < struct_size <=3D 16.

Good idea. And I'll add extra test cases for the case
you mentioned before.

> >   __diag_pop();
> >
> >   int bpf_testmod_fentry_ok;
> > @@ -245,7 +258,11 @@ bpf_testmod_test_read(struct file *file, struct ko=
bject *kobj,
> >
> >       if (bpf_testmod_fentry_test1(1) !=3D 2 ||
> >           bpf_testmod_fentry_test2(2, 3) !=3D 5 ||
> > -         bpf_testmod_fentry_test3(4, 5, 6) !=3D 15)
> > +         bpf_testmod_fentry_test3(4, 5, 6) !=3D 15 ||
> > +         bpf_testmod_fentry_test7(16, (void *)17, 18, 19, (void *)20,
> > +                                  21, 22) !=3D 133 ||
> > +         bpf_testmod_fentry_test12(16, (void *)17, 18, 19, (void *)20,
> > +                                   21, 22, 23, 24, 25, 26, 27) !=3D 25=
8)
> >               goto out;
> >
> >       bpf_testmod_fentry_ok =3D 1;
> [...]
> > diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/tes=
ting/selftests/bpf/progs/fexit_test.c
> > index 8f1ccb7302e1..a6d8e03ff5b7 100644
> > --- a/tools/testing/selftests/bpf/progs/fexit_test.c
> > +++ b/tools/testing/selftests/bpf/progs/fexit_test.c
> > @@ -78,3 +78,60 @@ int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
> >               test8_result =3D 1;
> >       return 0;
> >   }
> > +
> > +__u64 test9_result =3D 0;
> > +SEC("fexit/bpf_testmod_fentry_test7")
> > +int BPF_PROG(test9, __u64 a, void *b, short c, int d, void *e, char f,
> > +          int g, int ret)
> > +{
> > +     test9_result =3D a =3D=3D 16 && b =3D=3D (void *)17 && c =3D=3D 1=
8 && d =3D=3D 19 &&
> > +             e =3D=3D (void *)20 && f =3D=3D 21 && g =3D=3D 22 && ret =
=3D=3D 133;
> > +     return 0;
> > +}
> > +
> > +__u64 test10_result =3D 0;
> > +SEC("fexit/bpf_testmod_fentry_test12")
> > +int BPF_PROG(test10, __u64 a, void *b, short c, int d, void *e, char f=
,
> > +          int g, unsigned int h, long i, __u64 j, unsigned long k,
> > +          unsigned char l)
> > +{
> > +     __u64 ret;
> > +     int err;
> > +
> > +     /* BPF_PROG() don't support 14 arguments, and ctx[12] can't be
> > +      * accessed yet. So we get the return value by bpf_get_func_ret()
> > +      * for now.
> > +      */
> > +     err =3D bpf_get_func_ret(ctx, &ret);
>
> Maybe just have 11 arguments for this test case?
>
> > +     if (err)
> > +             return 0;
> > +
> > +     test10_result =3D a =3D=3D 16 && b =3D=3D (void *)17 && c =3D=3D =
18 && d =3D=3D 19 &&
> > +             e =3D=3D (void *)20 && f =3D=3D 21 && g =3D=3D 22 && h =
=3D=3D 23 &&
> > +             i =3D=3D 24 && j =3D=3D 25 && k =3D=3D 26 && l =3D=3D 27 =
&&
> > +             (int)ret =3D=3D 258;
> > +     return 0;
> > +}
> > +
> > +__u64 test11_result =3D 0;
> > +SEC("fexit/bpf_testmod_fentry_test12")
> > +int BPF_PROG(test11, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u6=
4 f,
> > +          __u64 g, __u64 h, __u64 i, __u64 j, __u64 k, __u64 l)
> > +{
> > +     __u64 ret;
> > +     int err;
> > +
> > +     /* BPF_PROG() don't support 14 arguments, and ctx[12] can't be
> > +      * accessed yet. So we get the return value by bpf_get_func_ret()
> > +      * for now.
> > +      */
> > +     err =3D bpf_get_func_ret(ctx, &ret);
> > +     if (err)
> > +             return 0;
> > +
> > +     test11_result =3D a =3D=3D 16 && b =3D=3D 17 && c =3D=3D 18 && d =
=3D=3D 19 &&
> > +             e =3D=3D 20 && f =3D=3D 21 && g =3D=3D 22 && h =3D=3D 23 =
&&
> > +             i =3D=3D 24 && j =3D=3D 25 && k =3D=3D 26 && l =3D=3D 27 =
&&
> > +             ret =3D=3D 258;
> > +     return 0;
> > +}

