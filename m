Return-Path: <bpf+bounces-4827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667E974FE7B
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 06:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0425C1C210BB
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 04:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535DB80E;
	Wed, 12 Jul 2023 04:47:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBE635
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 04:47:34 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13180100;
	Tue, 11 Jul 2023 21:47:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b734aea34aso13492621fa.0;
        Tue, 11 Jul 2023 21:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689137251; x=1691729251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwPc8BS7NtCm9mMgLjXyO4ZiPUAKVIu/YEVpLeQJeCM=;
        b=d4QyILDU2VZw1RN1/Gj/iMRIjLyksBxC8gZZc6G8syRMMufhV4/wCUunj2SMAoxRUd
         JGxRRMu4VT6L/1nZLf2cVp5PvQscMjqhoXymmjfrFXbUukQAu/uPaBztZK8kexm0OXua
         HKUTNPjMqYMVKfIDahHjiP4uyePHJvNf4uqlnLi7j7kmX4zH7IjhMAmD4S7ZMsd7JuEy
         8ukojGkkYAIkmgI4IAn1FdNXOVBKeLmLGyFcKJKlZ/DdJ2/OIGG0uYQzy11Z2Q3b1Kmp
         ZiJfQFvmtEYT8+y5uwXsxesqy5f7T6TUdnMxv2Wb1afB331jj96B+hmCuh8zLqzQ5nXO
         8Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137251; x=1691729251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwPc8BS7NtCm9mMgLjXyO4ZiPUAKVIu/YEVpLeQJeCM=;
        b=GZkmQPrcdz/ZLS+nczW7cH9owS4/wv6hSnAR1zSX2KmMt41NWf4DhmQ7NXvmCHMFMA
         ZzS3jmX+3xpSPGcFMnVoKV0YdiqdZvfPOarObFi+iRd/LgvqJ11dwXOcPpAm3ecUG7as
         r84NlnwKAy/QHVcY/bW0+5/U+2RJY3K3cQROR5UhcTVjA6xyGdrEQr5V8uBtAG8KG4N3
         tUatmeKKdfIPNh0r7t385jixmtB/HXwNTXsBlUbS8GQYfEUDi4OCPnAL66iSjEmXse8T
         5jp+Xzj0pDadBNH51JKyFyoHNBuRjVEPnFbjzwBkoCcYwkohA6g9lhC4YIbu9NxE1dpu
         S6Yw==
X-Gm-Message-State: ABy/qLYC4cxhxkoLpb9GytJIQTas2TUpaSPnNyniwLM8WCYhi7fyqrps
	II8n+pKKLD+hBvd/1OY6O17qs2nd4n+zLhl6+xwgE1Cq04g=
X-Google-Smtp-Source: APBJJlEkVy2OhrjUteY8ZTlt4SuQ8EcMAzsIWs77xzA6O26UfZ/0XvB4d4SK1mc8zsp1tIa9mBao8k+mynw+chrdoVI=
X-Received: by 2002:ac2:5b83:0:b0:4f9:cd02:4aec with SMTP id
 o3-20020ac25b83000000b004f9cd024aecmr14085028lfn.29.1689137250886; Tue, 11
 Jul 2023 21:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710104834.947884-1-imagedong@tencent.com>
 <20230710104834.947884-4-imagedong@tencent.com> <20230711232522.54dbqdxkfbjvbvgi@macbook-pro-8.dhcp.thefacebook.com>
 <CADxym3Zu1eYTVzprqe7_8zxhzaZHKAvVKKusa-uK150Huq1mnQ@mail.gmail.com>
In-Reply-To: <CADxym3Zu1eYTVzprqe7_8zxhzaZHKAvVKKusa-uK150Huq1mnQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 21:47:19 -0700
Message-ID: <CAADnVQKqMXiFscvqdMyZVkMk=dqTLy45Yg8jecYhp3aUwnqPig@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next v8 3/3] selftests/bpf: add testcase for
 TRACING with 6+ arguments
To: Menglong Dong <menglong8.dong@gmail.com>
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

On Tue, Jul 11, 2023 at 9:00=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Wed, Jul 12, 2023 at 7:25=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 10, 2023 at 06:48:34PM +0800, menglong8.dong@gmail.com wrot=
e:
> > > From: Menglong Dong <imagedong@tencent.com>
> > >
> > > Add fentry_many_args.c and fexit_many_args.c to test the fentry/fexit
> > > with 7/11 arguments. As this feature is not supported by arm64 yet, w=
e
> > > disable these testcases for arm64 in DENYLIST.aarch64. We can combine
> > > them with fentry_test.c/fexit_test.c when arm64 is supported too.
> > >
> > > Correspondingly, add bpf_testmod_fentry_test7() and
> > > bpf_testmod_fentry_test11() to bpf_testmod.c
> > >
> > > Meanwhile, add bpf_modify_return_test2() to test_run.c to test the
> > > MODIFY_RETURN with 7 arguments.
> > >
> > > Add bpf_testmod_test_struct_arg_7/bpf_testmod_test_struct_arg_7 in
> > > bpf_testmod.c to test the struct in the arguments.
> > >
> > > And the testcases passed on x86_64:
> > >
> > > ./test_progs -t fexit
> > > Summary: 5/14 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > ./test_progs -t fentry
> > > Summary: 3/2 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > ./test_progs -t modify_return
> > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > ./test_progs -t tracing_struct
> > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > Acked-by: Yonghong Song <yhs@fb.com>
> > > ---
> > > v8:
> > > - split the testcases, and add fentry_many_args/fexit_many_args to
> > >   DENYLIST.aarch64
> > > v6:
> > > - add testcases to tracing_struct.c instead of fentry_test.c and
> > >   fexit_test.c
> > > v5:
> > > - add testcases for MODIFY_RETURN
> > > v4:
> > > - use different type for args in bpf_testmod_fentry_test{7,12}
> > > - add testcase for grabage values in ctx
> > > v3:
> > > - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
> > >   bpf_testmod_fentry_test{7,12} meanwhile
> > > - get return value by bpf_get_func_ret() in
> > >   "fexit/bpf_testmod_fentry_test12", as we don't change ___bpf_ctx_ca=
st()
> > >   in this version
> > > ---
> > >  net/bpf/test_run.c                            | 23 ++++++--
> > >  tools/testing/selftests/bpf/DENYLIST.aarch64  |  2 +
> > >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 49 ++++++++++++++++-
> > >  .../selftests/bpf/prog_tests/fentry_test.c    | 43 +++++++++++++--
> > >  .../selftests/bpf/prog_tests/fexit_test.c     | 43 +++++++++++++--
> > >  .../selftests/bpf/prog_tests/modify_return.c  | 20 ++++++-
> > >  .../selftests/bpf/prog_tests/tracing_struct.c | 19 +++++++
> > >  .../selftests/bpf/progs/fentry_many_args.c    | 39 ++++++++++++++
> > >  .../selftests/bpf/progs/fexit_many_args.c     | 40 ++++++++++++++
> > >  .../selftests/bpf/progs/modify_return.c       | 40 ++++++++++++++
> > >  .../selftests/bpf/progs/tracing_struct.c      | 54 +++++++++++++++++=
++
> > >  11 files changed, 358 insertions(+), 14 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/fentry_many_arg=
s.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/fexit_many_args=
.c
> > >
> > > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > > index 63b11f7a5392..1c59fa60077b 100644
> > > --- a/net/bpf/test_run.c
> > > +++ b/net/bpf/test_run.c
> > > @@ -565,6 +565,13 @@ __bpf_kfunc int bpf_modify_return_test(int a, in=
t *b)
> > >       return a + *b;
> > >  }
> > >
> > > +__bpf_kfunc int bpf_modify_return_test2(int a, int *b, short c, int =
d,
> > > +                                     void *e, char f, int g)
> > > +{
> > > +     *b +=3D 1;
> > > +     return a + *b + c + d + (long)e + f + g;
> > > +}
> > > +
> > >  int noinline bpf_fentry_shadow_test(int a)
> > >  {
> > >       return a + 1;
> > > @@ -600,9 +607,13 @@ __diag_pop();
> > >
> > >  BTF_SET8_START(bpf_test_modify_return_ids)
> > >  BTF_ID_FLAGS(func, bpf_modify_return_test)
> > > +BTF_ID_FLAGS(func, bpf_modify_return_test2)
> > >  BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
> > >  BTF_SET8_END(bpf_test_modify_return_ids)
> > >
> > > +BTF_ID_LIST(bpf_modify_return_test_id)
> > > +BTF_ID(func, bpf_modify_return_test)
> > > +
> > >  static const struct btf_kfunc_id_set bpf_test_modify_return_set =3D =
{
> > >       .owner =3D THIS_MODULE,
> > >       .set   =3D &bpf_test_modify_return_ids,
> > > @@ -665,9 +676,15 @@ int bpf_prog_test_run_tracing(struct bpf_prog *p=
rog,
> > >                       goto out;
> > >               break;
> > >       case BPF_MODIFY_RETURN:
> > > -             ret =3D bpf_modify_return_test(1, &b);
> > > -             if (b !=3D 2)
> > > -                     side_effect =3D 1;
> > > +             if (prog->aux->attach_btf_id =3D=3D *bpf_modify_return_=
test_id) {
> > > +                     ret =3D bpf_modify_return_test(1, &b);
> > > +                     if (b !=3D 2)
> > > +                             side_effect =3D 1;
> > > +             } else {
> > > +                     ret =3D bpf_modify_return_test2(1, &b, 3, 4, (v=
oid *)5, 6, 7);
> > > +                     if (b !=3D 2)
> > > +                             side_effect =3D 1;
> >
> > Patches 1 and 2 look good, but I don't like where this check will lead =
us:
> > attach_btf_id =3D=3D *bpf_modify_return_test_id...
> >
>
> Yeah, I don't like it either, which makes the code weak.
>
> > When Jiri did a conversion of all test func into bpf_testmod.ko I forgo=
t
> > why we couldn't move fmod_ret tests as well.
> > Whatever it was the extra attach_btf_id check will make it worse.
> >
>
> I think it's because the side effect can't be verified
> by the BPF program, which makes it have to be run by
> bpf_prog_test_run_opts().
>
> > For now please think of a way to test fmod_ret when bpf_prog_test_run_t=
racing()
> > does something unconditional like:
> >         ret =3D bpf_modify_return_test(1, &b);
> >         if (b !=3D 2)
> >                 side_effect++;
> >         ret =3D bpf_modify_return_test2(1, &b, 3, 4, (void *)5, 6, 7);
>
> Should it be like this?
>
> ret +=3D bpf_modify_return_test2(1, &b, 3, 4, (void *)5, 6, 7);
>
> Or the return of bpf_modify_return_test() can't be verified.

Fine by me.
As long as attach_btf_id check is removed. It's good.

