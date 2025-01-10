Return-Path: <bpf+bounces-48594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF9A09D8B
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F08116B4FD
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87D214A9E;
	Fri, 10 Jan 2025 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmSkYfEF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71810212B0D
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546493; cv=none; b=Uexqondnn6/h1l6cVEuhnlYxI79zKNJ1qCW0rB8Zo3kMCHUrmTu8dZUJ8Sb2C7lHnIS+WOAdObTUWqqg/1o2r4XQlj3J5HeZtdDUD+p0lW+vdAIBn1rfZheRhHxwHYuCaA247FCw9t5R1tEWbY58hTDZVZ07mHfyLkyt6fqxmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546493; c=relaxed/simple;
	bh=eyi5MP9OGmEGcTGWfS0EBHNhkdqf8SUCGifmts8+nw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVnUaLRxpnJqefy7GTZu19UsEF25OUpILdQD9H4u1UaLd6BlqCBmGj80bZDW+Y492+LKxGKEL0QugbnpGR5BEZ1vy4OiuBAXkjP8olbhLF1oa7MVWLVHom9vc1zzsseSX8bSXhPxBwhtHy8mc4RHMjKM+aTH2LzDgb+7oanQFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmSkYfEF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso3304121a91.0
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 14:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736546491; x=1737151291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xVaG7BPrwWVqfXJ56Ko/Gx/Ry3hlHW50pgwCtZO10A=;
        b=TmSkYfEF8QcG7ddB2/GxjcEU39iDYrOMF3JQk4JPZ82hgoqdJrxe4nV988Bx9KxpaE
         70NANE9gRm/a5hovP6ccNraPKgy42ChonJ52sccDHlttVEwEEdjqrolfsbxiQieDylll
         x7TqgzfNnB8fzty0jVj2HjFa3pbSHi7j/J53jfLNY4EUVAo45NgJXz+8fobEqdD8G88v
         vgwUPCXHpL/7cm1svRozOibO9QU9L1+IsFAtQG7DO6bwsNFvU7RS2foXqZQM0tVSr9PS
         6RinrEiwae59a9wE5D8Dn5PfCp9OG53MDukU5D4UIxowUliowjzl5LwfAGQkM9eT7aZy
         d5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736546491; x=1737151291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xVaG7BPrwWVqfXJ56Ko/Gx/Ry3hlHW50pgwCtZO10A=;
        b=UUN2YoYiMANV4q1KeY8gjr+qCDpx2CYgU23VGj4V36LAkw317rUCX5dBKx3Iu2mast
         pqd/1bie9drjnQ0fU3QoE+H1wqNhbCq8SOdEUP0x1WsZ17OEgujO8QV06Dk0p4l8D0Tf
         GSrZy+IIQtWJiS720dTHJu7It+5WQvlDDC7atXAXkVxjHzN6d22ZipQJ6uMMxsKy6cYh
         0gY/IZ04EehRAriNDZ1bCQEg73cfWJxA5L/yEYUOaOjivq01uUwjGsixZXQ9afvnmClN
         17aEo0ChPeevi/drps9y5W8d2PML8prZraOB8K79sT8QjQZTrMoyA2xp8SjU5nZ8Gj1Y
         OQ7A==
X-Gm-Message-State: AOJu0Yy2+jqXTpOmv2NKEoXq4b8ZTF9Iy/nAtxJplYhRsNtr1+EV9rIw
	cIrJ8dkeBZskWJCC6WFjcMN+bumGbbVBxWqDgeJLdZXuIyR4e/OvJWqgqg1YrB9tSXvN9zIY6In
	ZLvfhli0Y+a81ydlrQ9YHUJAjllYTbw==
X-Gm-Gg: ASbGncuMAgF3AWVAg6NdLjR7DIKwtmHuguDq63SZuZIbw3qLHD7M8zY6gJXjOFbydGK
	9Oe7uhHEx9QCH/NqjFSh8Ts7pRhVjgzXzoT7vRTGER+ED2VgepH89+g==
X-Google-Smtp-Source: AGHT+IFA1D6dtouSmBLLDoBe3rsVJozlIk7ntkWozV0pB94F/MlCNeMV5QpP2vNf57S2uPnc4TMquKQKSeTWaWOffvI=
X-Received: by 2002:a17:90b:540b:b0:2f2:3efd:96da with SMTP id
 98e67ed59e1d1-2f548f4ea9emr19631765a91.24.1736546490666; Fri, 10 Jan 2025
 14:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107020632.170883-1-linux@jordanrome.com> <20250107020632.170883-2-linux@jordanrome.com>
In-Reply-To: <20250107020632.170883-2-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 14:01:18 -0800
X-Gm-Features: AbW1kvY1FFGBVFDb8cTCIBl-8iqmqwC__rSKToTFCUZAFx3YWKxLdBaqzxIYCK4
Message-ID: <CAEf4BzacGVVfstC+upqJm+JmzuhAYAht_g1ZfMBAPezgzEQtpQ@mail.gmail.com>
Subject: Re: [bpf-next v2 2/2] selftests/bpf: Add tests for bpf_copy_from_user_task_str
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 6:20=E2=80=AFPM Jordan Rome <linux@jordanrome.com> w=
rote:
>
> This adds tests for both the happy path and the
> error path (with and without the BPF_F_PAD_ZEROS flag).
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       |  7 +++
>  .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
>  .../selftests/bpf/progs/bpf_iter_tasks.c      | 55 +++++++++++++++++++
>  .../selftests/bpf/progs/read_vsyscall.c       |  6 +-
>  4 files changed, 67 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
> index 6f1bfacd7375..8ed864793bd1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -34,6 +34,8 @@
>  #include "bpf_iter_ksym.skel.h"
>  #include "bpf_iter_sockmap.skel.h"
>
> +static char test_data[] =3D "test_data";
> +
>  static void test_btf_id_or_null(void)
>  {
>         struct bpf_iter_test_kern3 *skel;
> @@ -328,12 +330,17 @@ static void test_task_sleepable(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
>                 return;
>
> +       skel->bss->user_ptr =3D test_data;
>         do_dummy_read(skel->progs.dump_task_sleepable);
>
>         ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task, 0,
>                   "num_expected_failure_copy_from_user_task");
>         ASSERT_GT(skel->bss->num_success_copy_from_user_task, 0,
>                   "num_success_copy_from_user_task");
> +       ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task_str=
, 0,
> +                 "num_expected_failure_copy_from_user_task_str");
> +       ASSERT_GT(skel->bss->num_success_copy_from_user_task_str, 0,
> +                 "num_success_copy_from_user_task_str");
>
>         bpf_iter_tasks__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/too=
ls/testing/selftests/bpf/prog_tests/read_vsyscall.c
> index c7b9ba8b1d06..a8d1eaa67020 100644
> --- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> @@ -24,6 +24,7 @@ struct read_ret_desc {
>         { .name =3D "copy_from_user", .ret =3D -EFAULT },
>         { .name =3D "copy_from_user_task", .ret =3D -EFAULT },
>         { .name =3D "copy_from_user_str", .ret =3D -EFAULT },
> +       { .name =3D "copy_from_user_task_str", .ret =3D -EFAULT },
>  };
>
>  void test_read_vsyscall(void)
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools/t=
esting/selftests/bpf/progs/bpf_iter_tasks.c
> index bc10c4e4b4fa..90691e34b915 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> @@ -9,6 +9,7 @@ char _license[] SEC("license") =3D "GPL";
>  uint32_t tid =3D 0;
>  int num_unknown_tid =3D 0;
>  int num_known_tid =3D 0;
> +void *user_ptr =3D 0;
>
>  SEC("iter/task")
>  int dump_task(struct bpf_iter__task *ctx)
> @@ -35,7 +36,9 @@ int dump_task(struct bpf_iter__task *ctx)
>  }
>
>  int num_expected_failure_copy_from_user_task =3D 0;
> +int num_expected_failure_copy_from_user_task_str =3D 0;
>  int num_success_copy_from_user_task =3D 0;
> +int num_success_copy_from_user_task_str =3D 0;
>
>  SEC("iter.s/task")
>  int dump_task_sleepable(struct bpf_iter__task *ctx)
> @@ -44,6 +47,9 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
>         struct task_struct *task =3D ctx->task;
>         static const char info[] =3D "    =3D=3D=3D END =3D=3D=3D";
>         struct pt_regs *regs;
> +       char task_str1[10] =3D "aaaaaaaaaa";
> +       char task_str2[10], task_str3[10];
> +       char task_str4[20] =3D "aaaaaaaaaaaaaaaaaaaa";
>         void *ptr;
>         uint32_t user_data =3D 0;
>         int ret;
> @@ -78,8 +84,57 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
>                 BPF_SEQ_PRINTF(seq, "%s\n", info);
>                 return 0;
>         }
> +
>         ++num_success_copy_from_user_task;
>
> +       /* Read an invalid pointer and ensure we get an error */
> +       ptr =3D NULL;
> +       ret =3D bpf_copy_from_user_task_str((char *)task_str1, sizeof(tas=
k_str1), ptr, task, 0);
> +       if (ret >=3D 0 || task_str1[9] !=3D 'a') {
> +               BPF_SEQ_PRINTF(seq, "%s\n", info);
> +               return 0;
> +       }
> +
> +       /* Read an invalid pointer and ensure we get error with pad zeros=
 flag */
> +       ptr =3D NULL;
> +       ret =3D bpf_copy_from_user_task_str((char *)task_str1, sizeof(tas=
k_str1), ptr, task, BPF_F_PAD_ZEROS);
> +       if (ret >=3D 0 || task_str1[9] !=3D '\0') {
> +               BPF_SEQ_PRINTF(seq, "%s\n", info);
> +               return 0;
> +       }
> +
> +       ++num_expected_failure_copy_from_user_task_str;
> +
> +       /* Same length as the string */
> +       ret =3D bpf_copy_from_user_task_str((char *)task_str2, 10, user_p=
tr, task, 0);
> +       if (bpf_strncmp(task_str2, 10, "test_data\0") !=3D 0 || ret !=3D =
10) {
> +               BPF_SEQ_PRINTF(seq, "%s\n", info);
> +               return 0;
> +       }
> +
> +       /* Shorter length than the string */
> +       ret =3D bpf_copy_from_user_task_str((char *)task_str3, 9, user_pt=
r, task, 0);
> +       if (bpf_strncmp(task_str3, 9, "test_dat\0") !=3D 0 || ret !=3D 9)=
 {
> +               BPF_SEQ_PRINTF(seq, "%s\n", info);
> +               return 0;
> +       }
> +
> +       /* Longer length than the string */
> +       ret =3D bpf_copy_from_user_task_str((char *)task_str4, 20, user_p=
tr, task, 0);
> +       if (bpf_strncmp(task_str4, 10, "test_data\0") !=3D 0 || ret !=3D =
10 || task_str4[sizeof(task_str4) - 1] !=3D 'a') {
> +               BPF_SEQ_PRINTF(seq, "%s\n", info);
> +               return 0;
> +       }
> +
> +       /* Longer length than the string with pad zeros flag */
> +       ret =3D bpf_copy_from_user_task_str((char *)task_str4, 20, user_p=
tr, task, BPF_F_PAD_ZEROS);
> +       if (bpf_strncmp(task_str4, 10, "test_data\0") !=3D 0 || ret !=3D =
10 || task_str4[sizeof(task_str4) - 1] !=3D '\0') {

looks like a long string, please check 100 character limit

> +               BPF_SEQ_PRINTF(seq, "%s\n", info);
> +               return 0;

nit: this BPF_SEQ_PRINTF() + return 0 repetition is... repetitive :)
`goto drop_out;` maybe?

> +       }
> +
> +       ++num_success_copy_from_user_task_str;
> +
>         if (ctx->meta->seq_num =3D=3D 0)
>                 BPF_SEQ_PRINTF(seq, "    tgid      gid     data\n");
>
> diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/te=
sting/selftests/bpf/progs/read_vsyscall.c
> index 39ebef430059..623c1c5bd2d0 100644
> --- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
> +++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
> @@ -8,14 +8,15 @@
>
>  int target_pid =3D 0;
>  void *user_ptr =3D 0;
> -int read_ret[9];
> +int read_ret[10];
>
>  char _license[] SEC("license") =3D "GPL";
>
>  /*
> - * This is the only kfunc, the others are helpers
> + * These are the kfuncs, the others are helpers
>   */
>  int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __k=
sym;
> +int bpf_copy_from_user_task_str(void *dst, u32, const void *, struct tas=
k_struct *, u64) __weak __ksym;

these definitions should be coming from vmlinux.h, no need to add them
manually anymore

>
>  SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>  int do_probe_read(void *ctx)
> @@ -47,6 +48,7 @@ int do_copy_from_user(void *ctx)
>         read_ret[7] =3D bpf_copy_from_user_task(buf, sizeof(buf), user_pt=
r,
>                                               bpf_get_current_task_btf(),=
 0);
>         read_ret[8] =3D bpf_copy_from_user_str((char *)buf, sizeof(buf), =
user_ptr, 0);
> +       read_ret[9] =3D bpf_copy_from_user_task_str((char *)buf, sizeof(b=
uf), user_ptr, bpf_get_current_task_btf(), 0);

please drop all those (char *) casts, in C any pointer is implicitly
castable to `void *` and `void *` is (implicitly) castable to any
other pointer. C++ is stricter, but in C it's canonical to not do
casting

>
>         return 0;
>  }
> --
> 2.43.5
>

