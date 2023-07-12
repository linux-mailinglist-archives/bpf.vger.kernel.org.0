Return-Path: <bpf+bounces-4852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6F9750B72
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CEE281562
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776A134CC8;
	Wed, 12 Jul 2023 14:55:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D927726
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 14:55:00 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB4419A0;
	Wed, 12 Jul 2023 07:54:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so116783451fa.3;
        Wed, 12 Jul 2023 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689173697; x=1691765697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuD0fZnGZjlCDJR6lREdeMnKB9PqpH7PglGgOZrLCEg=;
        b=Tzz6c9mBIqg//mIFCbu6eA9gfU+y/sPx3E8LwY3cK/HVRvvinzlWPze5+BuG4ku3rz
         83M/czrKTdqeBy6anscv2AhyKHM+c/vcq4JglX8Yhgoc7YzclPVsJ6aeVDmE9z7Ph/ZP
         b7nDU+0ABDLQCk9fEq7RJQogmeLvIbKARHanOIBfkK+10BMl4HWqGvwjTQsltiXfU/SK
         WJcm7BC5ri8b1duyOVus0l0ZxxRpC0854AUzstDHarkS9mLCZjhU3Pna6LH9Dr53VYPd
         uOu5JThRGporhr+Ob0zKlhjibVpKLrSwM1sA/iMFv1YzJF2px709q/i2ODjJomt+aMFZ
         Q+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173697; x=1691765697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuD0fZnGZjlCDJR6lREdeMnKB9PqpH7PglGgOZrLCEg=;
        b=Jc7x8JaVcP62ci3wDdjgx14Kx2CwoZyqq6gn4bbtakyz5f9aOcCgEM83nAh3iHwxs0
         wjpBK+Pu94dLbG1UnZ9sS4STcNPCxRvHkB5TjkiwO8ayDAFrkofJp/RRViBk+BAok7dr
         565f5MqAC5eYWwHS36BYPbXOM2ZH5OqZhWY2nHTgSP9fSdQ0kvgajdJ91wXHLGB3/kXb
         n9cQFC5IrX6zwszi3cZ7pJ/FqlBUvrs6QX053vXnfuJ92QucJf8TZNYx3YEtygVHckaU
         r1VER9UhXevD7PCaTo/LO94CWr5RYrW/ZJaYn79mvwABlx0RFtZmi7O+OyUxdU8V8zko
         18tQ==
X-Gm-Message-State: ABy/qLZF6uWdAMkw1naVEJPcKy/LdsukVv14sMHu4j2Sg8HQU4KbKAQG
	+fdbV2JHODt8Osr12MqxP3okcuNComdV+DiIPd8=
X-Google-Smtp-Source: APBJJlH4O0lOH5eccwckjf8KnT543Xn+pXgLsz4AHnPVeJpRtpL2+8UyhleR2V/eRO7+gDWWZKlw1O6u0iNxdXS/pYQ=
X-Received: by 2002:a05:651c:104b:b0:2b6:fe75:b8f3 with SMTP id
 x11-20020a05651c104b00b002b6fe75b8f3mr16619412ljm.29.1689173696507; Wed, 12
 Jul 2023 07:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712084746.833965-1-imagedong@tencent.com> <20230712084746.833965-4-imagedong@tencent.com>
In-Reply-To: <20230712084746.833965-4-imagedong@tencent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jul 2023 07:54:45 -0700
Message-ID: <CAADnVQ+YHqQP_p-9iF+pETvoh3VGqOkcSZreDKVZQ5BUZQBOcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 3/3] selftests/bpf: add testcase for TRACING
 with 6+ arguments
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 1:50=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
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
> v9:
> - change the way to test fmod_ret
> v8:
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
>  net/bpf/test_run.c                            | 14 ++++-
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |  2 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 49 ++++++++++++++++-
>  .../selftests/bpf/prog_tests/fentry_test.c    | 43 +++++++++++++--
>  .../selftests/bpf/prog_tests/fexit_test.c     | 43 +++++++++++++--
>  .../selftests/bpf/prog_tests/modify_return.c  | 10 ++--
>  .../selftests/bpf/prog_tests/tracing_struct.c | 19 +++++++
>  .../selftests/bpf/progs/fentry_many_args.c    | 39 ++++++++++++++
>  .../selftests/bpf/progs/fexit_many_args.c     | 40 ++++++++++++++
>  .../selftests/bpf/progs/modify_return.c       | 40 ++++++++++++++
>  .../selftests/bpf/progs/tracing_struct.c      | 54 +++++++++++++++++++
>  11 files changed, 340 insertions(+), 13 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_many_args.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fexit_many_args.c
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 63b11f7a5392..7d47f53f20c1 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -565,6 +565,13 @@ __bpf_kfunc int bpf_modify_return_test(int a, int *b=
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
> @@ -600,6 +607,7 @@ __diag_pop();
>
>  BTF_SET8_START(bpf_test_modify_return_ids)
>  BTF_ID_FLAGS(func, bpf_modify_return_test)
> +BTF_ID_FLAGS(func, bpf_modify_return_test2)
>  BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
>  BTF_SET8_END(bpf_test_modify_return_ids)
>
> @@ -667,7 +675,11 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
>         case BPF_MODIFY_RETURN:
>                 ret =3D bpf_modify_return_test(1, &b);
>                 if (b !=3D 2)
> -                       side_effect =3D 1;
> +                       side_effect++;
> +               b =3D 2;
> +               ret +=3D bpf_modify_return_test2(1, &b, 3, 4, (void *)5, =
6, 7);
> +               if (b !=3D 2)
> +                       side_effect++;

Looks better, but now two tests are failing:
Error: #85 get_func_args_test
Error: #252 trampoline_count

See BPF CI.

I suspect you haven't rerun the whole test_progs after your changes.
Please do so in the future.

