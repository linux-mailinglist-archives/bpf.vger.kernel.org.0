Return-Path: <bpf+bounces-75935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66948C9D7E2
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 02:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B506D4E509B
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 01:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13822B8CB;
	Wed,  3 Dec 2025 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIIbAjoT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B7DDAB
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724935; cv=none; b=GsUBhtd3nUtZ/7HW22zjD9uXqVHKW60sJXW0sa5Io+7diqTumiTkUP2ll62db/8hp9COYZVF7vkLOshaleKXldWU3HhHGKGZ5PHxRPnVLa5lKlBu5g7NQyZGcc6ISnlBdX7EYPLXcVdXOfVkpjPspHJMrEC/Qva3+YGHEeGYs8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724935; c=relaxed/simple;
	bh=/pMD5bWmHdRBvf4yKFtgHYmIt4rs553By1J0fnkw5HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5uxf/YryetFs/nJC8Ol0LkE4jJPZ8w61iBZKDGJKy4Qzizg/06AfKIY4CWZG7Is9ATB/Vb5CWcIf0vEBYEcTsLMIP5bgSZZeEK9qqbyEFUj8/H5Sxmc+Sg9FYMS40xTtskIunWTl8hXjuodzllaebQwde+KDiARHfDRgyo9PjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIIbAjoT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso26160145e9.2
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 17:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764724931; x=1765329731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+WY3aZ77NdSSZ7bHvGKcvVuNvrlczHOotCJwifC8BM=;
        b=jIIbAjoTnNabPceowEdVu+Qhgc4aryQp/owrk2DJLqSoQ4vl2FWuCRBdr/I+VIfUqZ
         4paBhBQWfEGJCPId+V5z/AP/UMS9IS/8SE2aRHljfs2IrIA/oTjuhMXktxX9BEYwoZbb
         2txtpBxaBEfX/6ROw5iAVVg2WfKMl88o7YmulAmeWC9yIPf2eK1cKbt3ouVlYS8YXkSH
         8GeISNAfMhA/qLIqAfnIsm6PLSR+5yjIISZj29FyXmFF3Qj+gQ1t2Ba6OaZXcGImRdLA
         U9Z6rOCma9eHdnKp+V+8GUeVqoDz90xs0Zorn1rJHLihlVKzFRcmCX13v5+3A1XZ58f/
         N5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724931; x=1765329731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+WY3aZ77NdSSZ7bHvGKcvVuNvrlczHOotCJwifC8BM=;
        b=uZioSD6sB1MFwssNxwcz8Z5AZED6rwvYomUgylfq9vj0xAX1fHbZF57GZUrkBBZ8sZ
         3FfePma1Mc7xh0VJGEPke8qzhaqMovFip7SbY1d2bprAEYthOjoDC6rmV7G3BMvBy3gh
         /2DdKClX/0eSkd/YG5wyknWznD4PRpGre7ZTGH2c/V9evMvzyk8kjVi7fSshX0vTLmHK
         lx3b1Ex3eGrn2d/sZAUwH89P+rnItj1wVUclNJE8u2qWKRxelg3LzSBVoPD57t6yYF6L
         DBqK8XGHCekYUvgzLhoFauPPJCXJiOUj/b30M+VvEvYKt32YIGp/a1JESaJzTyDbOTit
         mPew==
X-Forwarded-Encrypted: i=1; AJvYcCVl4T22A2OyWxI+EsmpEgjtbEiW/vFEgyBGH0QXb4EFO6/SzGV7+ynzN4t1QMjnfmVuorQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf+LldkdN4HktC38PwrENhcwsxXw2w64nELHp+Imw+8ApORwQL
	qc2vaVIvaezKieQSs8XHZ/7FkU31Qsd5eaFQRFq8KjCGWOskphD49ZZFXrxfgIYhRPFTCqFCWIL
	KnHNGQ5PDqSAGRNgW+rmNn1vLyHpWUZk=
X-Gm-Gg: ASbGnctblrGoX4pic6MU4L/fgkuiAeBGP8OO/U4IS50ONdhFckS3NP8Ml4/FMTuhpLk
	aPvkpwjcYJ2BSW01kJeo7VT9HS7Aq2KvSjqA+UpSnopKXKYawyoQM+ZLf3aVyLzKY4i4ar5nxVS
	BlgW5b1EouTu/9lcoNBJN1VCx+Mpzr8Ft5qUZBr8h/tn+oWZKZgfXwerd01H3Xep4sxPltP6KvB
	5O8pZwbRJMfT/TIjDA54aFSyEQUVmmsmeKHPoG2GrlPxR4GB4vP+r4xuRJET6a14pWSiQvucA2P
	0951f3kDkwoFL3nmk7ce/RygCz1zgUZ5Q/0i568=
X-Google-Smtp-Source: AGHT+IEZPiDn6ShqkuIdilgas/r1CN9HX9hxB+EUwqJ2DZ9iEFPTR7ckrt5KLi2omsstyuSuQGr9BaixCvlkHpaFUos=
X-Received: by 2002:a5d:64c9:0:b0:429:d0b8:3850 with SMTP id
 ffacd0b85a97d-42f731f6a09mr291406f8f.48.1764724930681; Tue, 02 Dec 2025
 17:22:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202141944.2209-1-electronlsr@gmail.com> <20251202141944.2209-3-electronlsr@gmail.com>
In-Reply-To: <20251202141944.2209-3-electronlsr@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Dec 2025 17:21:59 -0800
X-Gm-Features: AWmQ_bmjDp76AGtK2oDFg7O2PT4muz01SgzrZrE4BlXdnWYrNXYeaoIKfF7ZsQk
Message-ID: <CAADnVQJQj=mdFbPf7nmc0+qZVC4RCK5AbJvNQv2W--tvGyzzVA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM
 regression test
To: Shuran Liu <electronlsr@gmail.com>
Cc: Song Liu <song@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Zesen Liu <ftyg@live.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni <haoran.ni.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 6:20=E2=80=AFAM Shuran Liu <electronlsr@gmail.com> w=
rote:
>
> Add a regression test for bpf_d_path() when invoked from an LSM program.
> The test attaches to the bprm_check_security hook, calls bpf_d_path() on
> the binary being executed, and verifies that a simple prefix comparison o=
n
> the returned pathname behaves correctly after the fix in patch 1.
>
> To avoid nondeterminism, the LSM program now filters based on the
> expected PID, which is populated from userspace before the test binary is
> executed. This prevents unrelated processes that also trigger the
> bprm_check_security LSM hook from overwriting test results. Parent and
> child processes are synchronized through a pipe to ensure the PID is set
> before the child execs the test binary.
>
> Per review feedback, the new LSM coverage is merged into the existing
> d_path selftest rather than adding new prog_tests/ or progs/ files. The
> loop that checks the pathname prefix now uses bpf_for(), which is a
> verifier-friendly way to express a small, fixed-iteration loop, and the
> temporary /tmp/bpf_d_path_test binary is removed in the test cleanup
> path.
>
> Co-developed-by: Zesen Liu <ftyg@live.com>
> Signed-off-by: Zesen Liu <ftyg@live.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  .../testing/selftests/bpf/prog_tests/d_path.c | 65 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
>  2 files changed, 98 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/test=
ing/selftests/bpf/prog_tests/d_path.c
> index ccc768592e66..202b44e6f482 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -195,6 +195,68 @@ static void test_d_path_check_types(void)
>         test_d_path_check_types__destroy(skel);
>  }
>
> +static void test_d_path_lsm(void)
> +{
> +       struct test_d_path *skel;
> +       int err;
> +       int pipefd[2];
> +       pid_t pid;
> +
> +       skel =3D test_d_path__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "d_path skeleton failed"))
> +               return;
> +
> +       err =3D test_d_path__attach(skel);
> +       if (!ASSERT_OK(err, "attach failed"))
> +               goto cleanup;
> +
> +       /* Prepare the test binary */
> +       system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
> +
> +       if (!ASSERT_OK(pipe(pipefd), "pipe failed"))
> +               goto cleanup;
> +
> +       pid =3D fork();
> +       if (!ASSERT_GE(pid, 0, "fork failed")) {
> +               close(pipefd[0]);
> +               close(pipefd[1]);
> +               goto cleanup;
> +       }
> +
> +       if (pid =3D=3D 0) {
> +               /* Child */
> +               char buf;
> +
> +               close(pipefd[1]);
> +               /* Wait for parent to set PID in BPF map */
> +               if (read(pipefd[0], &buf, 1) !=3D 1)
> +                       exit(1);
> +               close(pipefd[0]);
> +               execl("/tmp/bpf_d_path_test", "/tmp/bpf_d_path_test", NUL=
L);
> +               exit(1);
> +       }

No forks please. They often make selftest to be flaky.
Use simples possible way to test it.
Without forks and pipes.

pw-bot: cr

