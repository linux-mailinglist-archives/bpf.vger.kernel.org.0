Return-Path: <bpf+bounces-4855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D428F750BFD
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEEF280D60
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC492416B;
	Wed, 12 Jul 2023 15:11:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E624160
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 15:11:56 +0000 (UTC)
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00291BC9;
	Wed, 12 Jul 2023 08:11:55 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-57eb0df5265so6570407b3.3;
        Wed, 12 Jul 2023 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689174715; x=1691766715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H+XFKPC8Y5xjjIB6z4jmZFgXWxD1qGfV/usqzcEesQ=;
        b=dtEjciHriK4KjQp+DlWxxLcpdalO4+DHz0p937NjJhg6WKGJpgAlHNykZ5TeX8KWpI
         qzh88l5BUG6AxEXlgT2XTvQHcx4TEN4aHpnat6+KnmyhX8lUlTenPKi28VbqOC8gy/i3
         o7u1SxLb3u1DzUfmiBTRsi94vgmDSkpICCpO733O7uFralwEtGIZ6cigg4Y003mc6uDt
         lDDLeXdsMwPq4FaBxhlC+OQ1663VrkGGDFy17xni8zzHhgt/W7MNknT7lt9rcndjQfRw
         e2OHi9dfE10ZFH9DF4MEbGgLpZDRkgfv2EAP/Z5ocd+tp8kTddq8lzRpGF7QKTnhM2yu
         rrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174715; x=1691766715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H+XFKPC8Y5xjjIB6z4jmZFgXWxD1qGfV/usqzcEesQ=;
        b=RdfALDmN35/QqO6EQxXTgy5bw1RBl7EkSTLfXGtHLNJk5zVtrXi2Ju8edDnlH45x4O
         mQ3dqiWbFNTchv8T1Y43VnikAxwigS/1sTKO5/eRVXEFo43GhMAD4aeS968kSYJcVpDY
         xXzOjqkSTiLhnp+loIbge01UiH1fLbU3Y64wp2rxmFl/ciJtEV2XDzm73XXxbgHF09UQ
         mCWyXuNvQLYtUP3KHAFoaDquMHv3Cg80LeSNjK3M8MtAYggn6BGErt2WocpMsTkxSKUG
         bFjzNhsPJ+q4SRWGgB9y7UKBEguDp0gYiu0GRAslUwsUdynfTaq/HlsutAsy9O3J2zcg
         Zq6A==
X-Gm-Message-State: ABy/qLYqdJAYW1dCS+2UrbWpclVJooGd1OrLsIKbKPPjcvYT9gmBUJoJ
	1J5b4c2Zall9l6fH0XbUNXJ1xSvKBuuRT2YpgtU=
X-Google-Smtp-Source: APBJJlGpeoro6Vbke/rk0B8kRn2QGwgrQpDLdHIadb2NCaVwr6MqzdSeGpljXFgSQulaafdbN+CSygkQ4RNuf27Eq1c=
X-Received: by 2002:a5b:b8e:0:b0:c60:bd1a:fea1 with SMTP id
 l14-20020a5b0b8e000000b00c60bd1afea1mr14933532ybq.57.1689174714649; Wed, 12
 Jul 2023 08:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712084746.833965-1-imagedong@tencent.com>
 <20230712084746.833965-4-imagedong@tencent.com> <CAADnVQ+YHqQP_p-9iF+pETvoh3VGqOkcSZreDKVZQ5BUZQBOcQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+YHqQP_p-9iF+pETvoh3VGqOkcSZreDKVZQ5BUZQBOcQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 12 Jul 2023 23:11:43 +0800
Message-ID: <CADxym3YhoNcsPzHLzW0XBLtTW0KjTF4YViAwmboeYyS1cwMwaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 3/3] selftests/bpf: add testcase for TRACING
 with 6+ arguments
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, David Ahern <dsahern@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 10:54=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 12, 2023 at 1:50=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
> >
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > Add fentry_many_args.c and fexit_many_args.c to test the fentry/fexit
> > with 7/11 arguments. As this feature is not supported by arm64 yet, we
> > disable these testcases for arm64 in DENYLIST.aarch64. We can combine
> > them with fentry_test.c/fexit_test.c when arm64 is supported too.
> >
> > Correspondingly, add bpf_testmod_fentry_test7() and
> > bpf_testmod_fentry_test11() to bpf_testmod.c
> >
> > Meanwhile, add bpf_modify_return_test2() to test_run.c to test the
> > MODIFY_RETURN with 7 arguments.
> >
> > Add bpf_testmod_test_struct_arg_7/bpf_testmod_test_struct_arg_7 in
> > bpf_testmod.c to test the struct in the arguments.
> >
> > And the testcases passed on x86_64:
> >
> > ./test_progs -t fexit
> > Summary: 5/14 PASSED, 0 SKIPPED, 0 FAILED
> >
> > ./test_progs -t fentry
> > Summary: 3/2 PASSED, 0 SKIPPED, 0 FAILED
> >
> > ./test_progs -t modify_return
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > ./test_progs -t tracing_struct
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> > v9:
> > - change the way to test fmod_ret
> > v8:
> > - split the testcases, and add fentry_many_args/fexit_many_args to
> >   DENYLIST.aarch64
> > v6:
> > - add testcases to tracing_struct.c instead of fentry_test.c and
> >   fexit_test.c
> > v5:
> > - add testcases for MODIFY_RETURN
> > v4:
> > - use different type for args in bpf_testmod_fentry_test{7,12}
> > - add testcase for grabage values in ctx
> > v3:
> > - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
> >   bpf_testmod_fentry_test{7,12} meanwhile
> > - get return value by bpf_get_func_ret() in
> >   "fexit/bpf_testmod_fentry_test12", as we don't change ___bpf_ctx_cast=
()
> >   in this version
> > ---
> >  net/bpf/test_run.c                            | 14 ++++-
> >  tools/testing/selftests/bpf/DENYLIST.aarch64  |  2 +
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 49 ++++++++++++++++-
> >  .../selftests/bpf/prog_tests/fentry_test.c    | 43 +++++++++++++--
> >  .../selftests/bpf/prog_tests/fexit_test.c     | 43 +++++++++++++--
> >  .../selftests/bpf/prog_tests/modify_return.c  | 10 ++--
> >  .../selftests/bpf/prog_tests/tracing_struct.c | 19 +++++++
> >  .../selftests/bpf/progs/fentry_many_args.c    | 39 ++++++++++++++
> >  .../selftests/bpf/progs/fexit_many_args.c     | 40 ++++++++++++++
> >  .../selftests/bpf/progs/modify_return.c       | 40 ++++++++++++++
> >  .../selftests/bpf/progs/tracing_struct.c      | 54 +++++++++++++++++++
> >  11 files changed, 340 insertions(+), 13 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/fentry_many_args.=
c
> >  create mode 100644 tools/testing/selftests/bpf/progs/fexit_many_args.c
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 63b11f7a5392..7d47f53f20c1 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -565,6 +565,13 @@ __bpf_kfunc int bpf_modify_return_test(int a, int =
*b)
> >         return a + *b;
> >  }
> >
> > +__bpf_kfunc int bpf_modify_return_test2(int a, int *b, short c, int d,
> > +                                       void *e, char f, int g)
> > +{
> > +       *b +=3D 1;
> > +       return a + *b + c + d + (long)e + f + g;
> > +}
> > +
> >  int noinline bpf_fentry_shadow_test(int a)
> >  {
> >         return a + 1;
> > @@ -600,6 +607,7 @@ __diag_pop();
> >
> >  BTF_SET8_START(bpf_test_modify_return_ids)
> >  BTF_ID_FLAGS(func, bpf_modify_return_test)
> > +BTF_ID_FLAGS(func, bpf_modify_return_test2)
> >  BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
> >  BTF_SET8_END(bpf_test_modify_return_ids)
> >
> > @@ -667,7 +675,11 @@ int bpf_prog_test_run_tracing(struct bpf_prog *pro=
g,
> >         case BPF_MODIFY_RETURN:
> >                 ret =3D bpf_modify_return_test(1, &b);
> >                 if (b !=3D 2)
> > -                       side_effect =3D 1;
> > +                       side_effect++;
> > +               b =3D 2;
> > +               ret +=3D bpf_modify_return_test2(1, &b, 3, 4, (void *)5=
, 6, 7);
> > +               if (b !=3D 2)
> > +                       side_effect++;
>
> Looks better, but now two tests are failing:
> Error: #85 get_func_args_test
> Error: #252 trampoline_count
>
> See BPF CI.
>
> I suspect you haven't rerun the whole test_progs after your changes.
> Please do so in the future.

......Yes, I didn't run the whole tests, and it seems that
some other test cases also use the bpf_modify_return_test().

I'll run the whole test_progs, sorry for the bother......

Thanks!
Menglong Dong

