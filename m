Return-Path: <bpf+bounces-60775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D7ADBC73
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 00:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112593B622E
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD9209F2E;
	Mon, 16 Jun 2025 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDlJAc/6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB85522F
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111260; cv=none; b=WoicsivKzu1XR+oMG3tZY40jtwRhpdpRfwZ7PTcHMnmogZMzzocOW9cRdNYs6QtcuhO28vV3PaMmsiqyaudLRF15c6dENLMdwJ+Kdyuq81DTReMUt+rGUcrfOg33NMhyWCwH8cXc5xCxeJrJeKSrS8To5ekCL5jATkbBHTHzqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111260; c=relaxed/simple;
	bh=9kYi1DfUHH5p3QFv7iq8x1q6fan+ZYn+gaXctuKAHCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts5m63hbTD7l1yXMmKiEhqFToOi/HeAYyiRtQSlIeHfkpjqguoZeFNthWhW4QIGKtx4HCzUYLBSc/nAnXJAgE2ZDHyTJP+ezi3Fb9p7FMgYKuDEaIxkYIK/1NKZyIqycvS0BQ80u+cY/xTF0BOhGJ+Ekq2GaO6H41RuAgwOZLz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDlJAc/6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235e1d710d8so61203335ad.1
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750111258; x=1750716058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYpRkXtyr232xuBCvZHhuqsEvwZAcYWXgJ62YNXWq2k=;
        b=QDlJAc/6BE6goKRka7ZPVQ4pzhZS0yTwc+KEv7+ONu2p3V+dIuNUSWaipUhSNNcnMr
         lbZABsGHyyzIbW/r8kmru1drEUADclXzp2ImPbQBub1iKVEKeiE4gbsGw2t9zv1Lzsx+
         b0uJ0a8ZmE5/aEspLsw0l9IwwEhXUg06WXUxDfNY4F/2IM8hhR6v5IFAYHuOu5Jzu9F/
         rMsBh2v5s8KMefu/PDYhGtHy6KtazBOV48xZ9sQ6VPRhkW0SHMDhs4dW2ZEK28OSM7mX
         7by0OPLqYtv1Je1gBNsojxLBJmRyAAThqKWu4HguXRMlj//6ZUasmdXwf5E662D4arAJ
         Vqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750111258; x=1750716058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYpRkXtyr232xuBCvZHhuqsEvwZAcYWXgJ62YNXWq2k=;
        b=TrfX0t2zErV+iYTs8AMoWevlmLef2ag2+sFyXs7JxeT9drTtnKhwDb1+QU9pfnir6e
         Z8cjmr8v9WfvEtmXsCCNEYdEqf1iUcDHJ0PBYgXpZxMmmkbAnFU93KTipPhvdoTb9IXJ
         bdbHCN4YBj7bUT+PMWCXWwkmFYYfRpO6PhQRFgDMfdFtNksIUsE6ArXVSLLqIJK9H4wx
         RY/o+6wd9yF+t6pQCc5yymmz92Qs53Nz9wa5Ir/c8IePiebXG8oh+ZXIj1qOHQrxpY7L
         cV6mGYtmTmgFGSO7Px8x5KoHNxTFb+U2tUZVCgVYffjsgn6/Mzja7MG3xNR6Uvsi/Nlp
         lTaw==
X-Gm-Message-State: AOJu0YxeCdHbhyfOWrHVaCNUKJlqCwOC6tDlrkjf2ikKT+WVcMeuCtHM
	moSawSM23qJ7Xixi9snS2DAH5DJ0zjZpzFAkHXhtAA8UX26RkPomYLDq/CGp3ALBs9R0XzrmUj6
	02zUwbhndyTwvxh7R3HBcyY1tg5sIA3k=
X-Gm-Gg: ASbGncu5e9OAGG4x2N5MQ6ut/3YGaW5oMuuV7ON0yy3VzR09bJcgQ13pkF3MSPEdAqa
	FUCAPvX5+ZvcR1xLgx4xPB/geSnuIiQnYEyEUL4aDM2H3WLlDXAAtbC2uml2VX5BWYecqGyz8jM
	G86Ohl2wLzxDXY0XDd/Bxt01SgP9fUhrW4PKWsnkK3fm4EEnFfDLMwWonXext9juOy4MMnpw==
X-Google-Smtp-Source: AGHT+IEzUAa/cnXqRTfrK12exIS28acAsWi33wKgcHuhR5CZFcAfpYXfxGf+aKYovPqU71F0WFDylGVg92TkwZ1IUyk=
X-Received: by 2002:a17:902:c412:b0:234:c5c1:9b84 with SMTP id
 d9443c01a7336-2366b3f8345mr156833525ad.37.1750111257730; Mon, 16 Jun 2025
 15:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615185345.2756663-1-yonghong.song@linux.dev> <20250615185351.2757391-1-yonghong.song@linux.dev>
In-Reply-To: <20250615185351.2757391-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Jun 2025 15:00:45 -0700
X-Gm-Features: AX0GCFvgLakYdWWpvczKDSLh1AK1dCGQ7CnpzXE5BISW6KEYS5vuKxF4Iii7r8Y
Message-ID: <CAEf4BzZmzrT7+nB0eyK-iLv+un68VtLY-TAq3G5Pti=sjM41TQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Refactor the failed
 assertion to another subtest
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 11:54=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> When building the selftest with arm64/clang20, the following test failed:
>     ...
>     ubtest_multispec_usdt:PASS:usdt_100_called 0 nsec
>     subtest_multispec_usdt:PASS:usdt_100_sum 0 nsec
>     subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0=
xaaaad82a2a80
>     #469/2   usdt/multispec:FAIL
>     #469     usdt:FAIL
>
> The failed assertion
>     subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0=
xaaaad82a2a80
> is caused by bpf_program__attach_usdt() which is expected to fail. But
> with arm64/clang20 bpf_program__attach_usdt() actually succeeded.

I think I missed that it's unexpected *success* that is causing
issues. If that's so, then I think it might be more straightforward to
just ensure that test is expectedly failing regardless of compiler
code generation logic. Maybe something along the following lines:

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c
b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 495d66414b57..fdd8642cfdff 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -190,11 +190,21 @@ static void __always_inline f300(int x)
        STAP_PROBE1(test, usdt_300, x);
 }

+#define RP10(F, X)  F(*(X+0)); F(*(X+1));F(*(X+2)); F(*(X+3)); F(*(X+4)); =
\
+                   F(*(X+5)); F(*(X+6)); F(*(X+7)); F(*(X+8)); F(*(X+9));
+#define RP100(F, X) RP10(F,X+
0);RP10(F,X+10);RP10(F,X+20);RP10(F,X+30);RP10(F,X+40); \
+
RP10(F,X+50);RP10(F,X+60);RP10(F,X+70);RP10(F,X+80);RP10(F,X+90);
+
 __weak void trigger_300_usdts(void)
 {
-       R100(f300, 0);
-       R100(f300, 100);
-       R100(f300, 200);
+       volatile int arr[300], i;
+
+       for (i =3D 0; i < 300; i++)
+               arr[i] =3D 300;
+
+       RP100(f300, arr + 0);
+       RP100(f300, arr + 100);
+       RP100(f300, arr + 200);
 }


So basically force the compiler to use 300 different locations for
each of 300 USDT instantiations? I didn't check how that will look
like on arm64, but on x86 gcc it seems to generate what is expected of
it.

Can you please try it on arm64 and see if that works?

>
> Checking usdt probes with usdt.test.o,
>
> with gcc11 build binary:
>   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x00000000000054f8, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[sp]
>   stapsdt              0x00000031       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x0000000000005510, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[sp, 4]
>   ...
>   stapsdt              0x00000032       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x0000000000005660, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[sp, 60]
>   ...
>   stapsdt              0x00000034       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x00000000000070e8, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[sp, 1192]
>   stapsdt              0x00000034       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x0000000000007100, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[sp, 1196]
>   ...
>   stapsdt              0x00000032       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x0000000000009ec4, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[sp, 60]
>
> with clang20 build binary:
>   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x00000000000009a0, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[x9]
>   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x00000000000009b8, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[x9]
>   ...
>   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x0000000000002590, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[x9]
>   stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x00000000000025a8, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[x8]
>   ...
>   stapsdt              0x0000002f       NT_STAPSDT (SystemTap probe descr=
iptors)
>     Provider: test
>     Name: usdt_300
>     Location: 0x0000000000007fdc, Base: 0x0000000000000000, Semaphore: 0x=
0000000000000008
>     Arguments: -4@[x10]
>
> There are total 301 locations for usdt_300. For gcc11 built binary, there=
 are
> 300 spec's. But for clang20 built binary, there are 3 spec's. The libbpf =
default
> BPF_USDT_MAX_SPEC_CNT is 256. So for gcc11, the above bpf_program__attach=
_usdt() will
> fail, but the function will succeed for clang20.
>
> Note that we cannot just change BPF_USDT_MAX_SPEC_CNT from 256 to 2 (thro=
ugh overwriting
> BPF_USDT_MAX_SPEC_CNT before usdt.bpf.h) since it will cause other test f=
ailures.
> We cannot just set BPF_USDT_MAX_SPEC_CNT to 2 for test_usdt_multispec.c s=
ince we
> have below in the Makefile:
>   test_usdt.skel.h-deps :=3D test_usdt.bpf.o test_usdt_multispec.bpf.o
> and the linker will enforce that BPF_USDT_MAX_SPEC_CNT values for both pr=
ogs must
> be the same.
>
> The refactoring does not change existing test result. But the future chan=
ge will
> allow to set BPF_USDT_MAX_SPEC_CNT to be 2 for arm64/clang20 case, which =
will have
> the same attachment failure as in gcc11.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 35 +++++++++++++------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 495d66414b57..dc29ef94312a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -270,18 +270,8 @@ static void subtest_multispec_usdt(void)
>          */
>         trigger_300_usdts();
>
> -       /* we'll reuse usdt_100 BPF program for usdt_300 test */
>         bpf_link__destroy(skel->links.usdt_100);
> -       skel->links.usdt_100 =3D bpf_program__attach_usdt(skel->progs.usd=
t_100, -1, "/proc/self/exe",
> -                                                       "test", "usdt_300=
", NULL);
> -       err =3D -errno;
> -       if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
> -               goto cleanup;
> -       ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
>
> -       /* let's check that there are no "dangling" BPF programs attached=
 due
> -        * to partial success of the above test:usdt_300 attachment
> -        */
>         bss->usdt_100_called =3D 0;
>         bss->usdt_100_sum =3D 0;
>
> @@ -312,6 +302,29 @@ static void subtest_multispec_usdt(void)
>         test_usdt__destroy(skel);
>  }
>
> +static void subtest_multispec_fail_usdt(void)
> +{
> +       LIBBPF_OPTS(bpf_usdt_opts, opts);
> +       struct test_usdt *skel;
> +       int err;
> +
> +       skel =3D test_usdt__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       skel->bss->my_pid =3D getpid();
> +
> +       skel->links.usdt_100 =3D bpf_program__attach_usdt(skel->progs.usd=
t_100, -1, "/proc/self/exe",
> +                                                       "test", "usdt_300=
", NULL);
> +       err =3D -errno;
> +       if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
> +               goto cleanup;
> +       ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
> +
> +cleanup:
> +       test_usdt__destroy(skel);
> +}
> +
>  static FILE *urand_spawn(int *pid)
>  {
>         FILE *f;
> @@ -422,6 +435,8 @@ void test_usdt(void)
>                 subtest_basic_usdt();
>         if (test__start_subtest("multispec"))
>                 subtest_multispec_usdt();
> +       if (test__start_subtest("multispec_fail"))
> +               subtest_multispec_fail_usdt();
>         if (test__start_subtest("urand_auto_attach"))
>                 subtest_urandom_usdt(true /* auto_attach */);
>         if (test__start_subtest("urand_pid_attach"))
> --
> 2.47.1
>

