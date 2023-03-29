Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49136CF2D2
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 21:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjC2TMk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 15:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjC2TMi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 15:12:38 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C95A1FCA
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 12:12:37 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso17311955fac.4
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680117156; x=1682709156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK3Hbe6ZOWNwRuLRvmcB9jLheqbEaFgANrmxSq5mlDo=;
        b=cO0Ufh5sYVYzZ/xBvrm4GT+6o8yZCCesi+70ZMBj/C162M/iXmts14QYBYbKvKuYpO
         j7Xrg0WSU54gMM27wNHrCpRaUvmXchikXz+63GtjRqnM/4wu7UY3RziFXQFltNAhLEd0
         HhbfP5Uc3Rv4O5msNdEZfkl9EgF2odI3dtWGf8k7BOV5uFNeFIyXNB03MrxZ9BKhHL3B
         NYrevjpwMQW2VTR5VnctGuSuE4FLtb+8SbSrgDMSBLpgLrlhEk9X6YFwNMM8g9EuDqbb
         1VxAI6G6pqwrb3dgR2Xfu8ZMYlTGojMf/1tgTIErva6b616zosuR1BaSvvlJKXg7OBuR
         Za2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117156; x=1682709156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KK3Hbe6ZOWNwRuLRvmcB9jLheqbEaFgANrmxSq5mlDo=;
        b=F8EWhEwved9LNyVj1+CV6gdlbHDHPUVy+I9Y1XYiuLlpoO6zVr+BB5/hhDLh6R05qU
         d5R1AYKgrh0Hhpjj+acPuK+cMm4h38TePX5te6aqX8IDHWYX1qdCK2nfh01ZhVm1rNCw
         rOyltiEV++rYOLYZq1ZOaLDB8QxoTnXHwFAqlw21cklLE1Z+gY7Q18hi+B/fSl8i0OIZ
         1533s4aU5iSb1bkW2fK50lNT+e2DrvPDubklJaNlmDQLSr0/LNirHHbLNZkCPGj0j2/y
         F4Q5xTVf9U+0+NY0iQeBGJL3yrHYJ3U9QWzk7AwsjVFgD/F6Cb0BGME5cpmcZlXSq8S6
         gKQg==
X-Gm-Message-State: AAQBX9dKYwbEp35JD0tD+VFQJeCbsSY8uTulH0zdSRnpFa4OPWGuMVgl
        FP/PI+o1KAPeBMf/aUlyLZsKjQs03o2oBxcHEnk=
X-Google-Smtp-Source: AKy350Z7l8VFXNllT0zrTEOfrokyOgVFpNOtl8dzdhDVFLDUniLGxnzIuw4X7uWX8DTuany2PLmf/78BZlSNm9gdu48=
X-Received: by 2002:a05:6870:1258:b0:17e:a9eb:196b with SMTP id
 24-20020a056870125800b0017ea9eb196bmr5209842oao.4.1680117156404; Wed, 29 Mar
 2023 12:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230322215246.1675516-1-martin.lau@linux.dev>
 <20230322215246.1675516-6-martin.lau@linux.dev> <CADvTj4rP3kPODxARVTEs2HsNFOof-BZtr8OsEKdjgcGVOTqKaA@mail.gmail.com>
 <456bcd47-efa2-7e3d-78c0-5f41ecba477c@linux.dev>
In-Reply-To: <456bcd47-efa2-7e3d-78c0-5f41ecba477c@linux.dev>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 29 Mar 2023 13:12:24 -0600
Message-ID: <CADvTj4ouGHvPHEgZobUewY2ZjHZhTzJ96oCBAV8VO2xT2bPC0Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/5] selftests/bpf: Add bench for task storage creation
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        David Faust <david.faust@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 11:03=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 3/27/23 8:51 PM, James Hilliard wrote:
> >> diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_cre=
ate.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
> >> index 2814bab54d28..7c851c9d5e47 100644
> >> --- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
> >> +++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
> >> @@ -22,6 +22,13 @@ struct {
> >>          __type(value, struct storage);
> >>   } sk_storage_map SEC(".maps");
> >>
> >> +struct {
> >> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> >> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> >> +       __type(key, int);
> >> +       __type(value, struct storage);
> >> +} task_storage_map SEC(".maps");
> >> +
> >>   SEC("raw_tp/kmalloc")
> >>   int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
> >>               size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags,
> >> @@ -32,6 +39,24 @@ int BPF_PROG(kmalloc, unsigned long call_site, cons=
t void *ptr,
> >>          return 0;
> >>   }
> >>
> >> +SEC("tp_btf/sched_process_fork")
> >> +int BPF_PROG(fork, struct task_struct *parent, struct task_struct *ch=
ild)
> >
> > Apparently fork is a built-in function in bpf-gcc:
>
> It is also failing in a plain C program
>
> #>  gcc -Werror=3Dbuiltin-declaration-mismatch -o test test.c
> test.c:14:35: error: conflicting types for built-in function =E2=80=98for=
k=E2=80=99; expected
> =E2=80=98int(void)=E2=80=99 [-Werror=3Dbuiltin-declaration-mismatch]
>     14 | int __attribute__((__noinline__)) fork(long x, long y)
>        |                                   ^~~~
> cc1: some warnings being treated as errors
>
> #> clang -o test test.c
> succeed
>
> I am not too attached to the name but it seems something should be addres=
sed in
> the gcc instead.

Hmm, so it looks like it's marked as a builtin here:
https://github.com/gcc-mirror/gcc/blob/releases/gcc-12.1.0/gcc/builtins.def=
#L875

The macro for that is here:
https://github.com/gcc-mirror/gcc/blob/releases/gcc-12.1.0/gcc/builtins.def=
#L104-L111

Which has this comment:
/* Like DEF_LIB_BUILTIN, except that the function is not one that is
specified by ANSI/ISO C. So, when we're being fully conformant we
ignore the version of these builtins that does not begin with
__builtin. */

Looks like this builtin was originally added here:
https://github.com/gcc-mirror/gcc/commit/d1c38823924506d389ca58d02926ace21b=
df82fa

Based on this issue it looks like fork is treated as a builtin for
libgcov support:
https://gcc.gnu.org/bugzilla//show_bug.cgi?id=3D82457

So from my understanding fork is a gcc builtin when building with -std=3Dgn=
u11
but is not a builtin when building with -std=3Dc11.

So it looks like fork is translated to __gcov_fork when -std=3Dgnu* is set =
which
is why we get this error.

As this appears to be intended behavior for gcc I think the best option is
to just rename the function so that we don't run into issues when building
with gnu extensions like -std=3Dgnu11.

>
> >
> > In file included from progs/bench_local_storage_create.c:6:
> > progs/bench_local_storage_create.c:43:14: error: conflicting types for
> > built-in function 'fork'; expected 'int(void)'
> > [-Werror=3Dbuiltin-declaration-mismatch]
> >     43 | int BPF_PROG(fork, struct task_struct *parent, struct
> > task_struct *child)
> >        |              ^~~~
> >
> > I haven't been able to find this documented anywhere however.
>
