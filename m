Return-Path: <bpf+bounces-33317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1232991B440
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 02:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E43B220B5
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 00:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF2F3FF1;
	Fri, 28 Jun 2024 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph1Jfkjd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7474C98
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535521; cv=none; b=bLHAIMqOmW+ncMs2wasZsEKWXDuOpUsVRRxuJZ/aQiWwXA86Kk2gUukf5U0FrdoWof14V4zX8j1OR+6S++881oRZ7kmT8HCfmbdF/sfn4l1S6HtNLr6g+JergG8Ze9nNSWzAuwZmRaEJT/yDiEbDu8HDmx2PerlY0YTH+qIyUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535521; c=relaxed/simple;
	bh=fbOO5B5xRyJwp0n/CE+dwE1/5MXxAqaAVH9tf8X7AjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBJmRp8YbJN7zluhMrrKpsOVgHG9KwaWeQC8F2DRe3PwprWGLtAI+Zuz/Q4mHoxrSWXNwhPWLIkcL3VQLrRmQVczNuP6A3C4wHpjsvuN/vA5V2aFwK46oWpP3Bm0aTAEC223ydo1YawyBmNhtU1iv+sMMewFM7vadooPgpiAi6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph1Jfkjd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42138eadf64so337035e9.3
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 17:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719535519; x=1720140319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERSkBWbf2b19JtSlmoSwZbFVYESvo7IBUdrewcnm4u8=;
        b=Ph1JfkjdguvwlrF46HzxqxvFrNIXtm3/yOezhmw78zJ7ovOmraQDrUO27St4Rg2t/B
         ONJadAJRlnbJSZFWbgzOElX5N0WuQun6UNPX/p0WrmQP2NB9eTA6+0PbYez4ey39jS+W
         YPQboWX6sG6aBo8OtltE5fO9Qj64qEw9ozbxlcMMN+72WBmmW/VFbkeOuP7qCRAGBFDK
         rRt01VX/X49HOU7eW0bScWgQ55GbHrLL62PphtRmTF3b6m1UrqF4YmUWwJGlB49B8LSP
         q0/JPqGf8XaFiwcvkicbqvthVyPcCNn/VVQ//neIbm0KKpl8eCBfuzmoHGIsJ8HpNNnZ
         Zr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719535519; x=1720140319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERSkBWbf2b19JtSlmoSwZbFVYESvo7IBUdrewcnm4u8=;
        b=SjFfzKr8fDwHpxhittyW8XRD0vM2ewOI0+pG9fGpJym51eV4pz4qySRVSTh3Zisp9Z
         bspOwURm5iAqFsJ0Ruc/Vy/Yo59VMkg7VK6hpHBg6NOH+hN9fThXB8Zkkc8BZZbEpcmy
         1RTrmsgmPv1W25T0oOR4DO+Gk1OeDlsZ/35cyf/6xhaGSzvO2az/sSxtOooEZSDF8/9z
         JjJ2HELnbWxa6e0VWjI0+Y7Af7sE4LszG4BbBf6lDlzCRT6mjtLoJeWoQHst7pLvUmUb
         2LpK2KnhNKItJqH35dHew8TREicKDZ51ucQeXn+WBYa8aFHfJ3jkkpfaMt4+t1p1etlj
         lhEg==
X-Forwarded-Encrypted: i=1; AJvYcCU7JF5DYU63KVh0xbYhX8P82Cvnju8cXled0n/7kIPO24IT86kvTNuBqQ3u/nW5TqTTTv9VeTNnH0TMrO1gfKPLb+Zs
X-Gm-Message-State: AOJu0Yz1C902M1YTYUghHRYk8nH64UBGvhKQmS5okZz9QkiGQ/c82gvX
	7W1aRMuvjEvXPmD6bWoxU9VF45QEzHGLDeZGKx2bqhoDSYqrgUEDPByVl3f6Gn/RTBH6H4hrrlH
	ftXNcaA+Vai3jgSaKkGcMgIexAUU=
X-Google-Smtp-Source: AGHT+IEVA/4cDRAgD0riUHKRXyRBhGucoXj1Z9kBiVKogKG0vWwNdR/0nZhMb+rR6neomrZE34ALqzOJ/5qxNToG7gc=
X-Received: by 2002:a05:6000:1545:b0:366:e9f9:99c1 with SMTP id
 ffacd0b85a97d-366e9f9a8c7mr11100837f8f.53.1719535518447; Thu, 27 Jun 2024
 17:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627090900.20017-1-iii@linux.ibm.com> <20240627090900.20017-10-iii@linux.ibm.com>
In-Reply-To: <20240627090900.20017-10-iii@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jun 2024 17:45:07 -0700
Message-ID: <CAADnVQ+FZMehV4-=SR-V7cZyGdKrnxBj64+7UL0br+jXMNPxFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] selftests/bpf: Add UAF tests for arena atomics
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:09=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Check that __sync_*() functions don't cause kernel panics when handling
> freed arena pages.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  .../selftests/bpf/prog_tests/arena_atomics.c  | 16 +++++++
>  .../selftests/bpf/progs/arena_atomics.c       | 43 +++++++++++++++++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/too=
ls/testing/selftests/bpf/prog_tests/arena_atomics.c
> index 0807a48a58ee..38eef4cc5c80 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
> @@ -146,6 +146,20 @@ static void test_xchg(struct arena_atomics *skel)
>         ASSERT_EQ(skel->arena->xchg32_result, 1, "xchg32_result");
>  }
>
> +static void test_uaf(struct arena_atomics *skel)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       int err, prog_fd;
> +
> +       /* No need to attach it, just run it directly */
> +       prog_fd =3D bpf_program__fd(skel->progs.uaf);
> +       err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +       if (!ASSERT_OK(err, "test_run_opts err"))
> +               return;
> +       if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> +               return;
> +}
> +
>  void test_arena_atomics(void)
>  {
>         struct arena_atomics *skel;
> @@ -180,6 +194,8 @@ void test_arena_atomics(void)
>                 test_cmpxchg(skel);
>         if (test__start_subtest("xchg"))
>                 test_xchg(skel);
> +       if (test__start_subtest("uaf"))
> +               test_uaf(skel);
>
>  cleanup:
>         arena_atomics__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/te=
sting/selftests/bpf/progs/arena_atomics.c
> index 55f10563208d..a86c8cdf1a30 100644
> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> @@ -176,3 +176,46 @@ int xchg(const void *ctx)
>
>         return 0;
>  }
> +
> +SEC("syscall")
> +int uaf(const void *ctx)
> +{
> +       if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
> +               return 0;
> +#ifdef ENABLE_ATOMICS_TESTS
> +       void __arena *page;
> +
> +       page =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +       bpf_arena_free_pages(&arena, page, 1);
> +
> +       __sync_fetch_and_add((__u32 __arena *)page, 1);
> +       __sync_add_and_fetch((__u32 __arena *)page, 1);
> +       __sync_fetch_and_sub((__u32 __arena *)page, 1);
> +       __sync_sub_and_fetch((__u32 __arena *)page, 1);
> +       __sync_fetch_and_and((__u32 __arena *)page, 1);
> +       __sync_and_and_fetch((__u32 __arena *)page, 1);
> +       __sync_fetch_and_or((__u32 __arena *)page, 1);
> +       __sync_or_and_fetch((__u32 __arena *)page, 1);
> +       __sync_fetch_and_xor((__u32 __arena *)page, 1);
> +       __sync_xor_and_fetch((__u32 __arena *)page, 1);
> +       __sync_val_compare_and_swap((__u32 __arena *)page, 0, 1);
> +       __sync_lock_test_and_set((__u32 __arena *)page, 1);
> +
> +       __sync_fetch_and_add((__u64 __arena *)page, 1);
> +       __sync_add_and_fetch((__u64 __arena *)page, 1);
> +       __sync_fetch_and_sub((__u64 __arena *)page, 1);
> +       __sync_sub_and_fetch((__u64 __arena *)page, 1);
> +       __sync_fetch_and_and((__u64 __arena *)page, 1);
> +       __sync_and_and_fetch((__u64 __arena *)page, 1);
> +       __sync_fetch_and_or((__u64 __arena *)page, 1);
> +       __sync_or_and_fetch((__u64 __arena *)page, 1);
> +       __sync_fetch_and_xor((__u64 __arena *)page, 1);
> +       __sync_xor_and_fetch((__u64 __arena *)page, 1);
> +       __sync_val_compare_and_swap((__u64 __arena *)page, 0, 1);
> +       __sync_lock_test_and_set((__u64 __arena *)page, 1);
> +#endif

Needs to be gated to exclude x86.
Not sure about arm64.

