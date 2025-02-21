Return-Path: <bpf+bounces-52209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5CA3FED0
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 19:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38173A5700
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 18:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDB02512FD;
	Fri, 21 Feb 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIKDrvkZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17181250BFE
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162427; cv=none; b=FL7F0NCs3rB4rOzL+aF0PP23mIPnydb3wLWgFIbOFM3c2se9x7w6uJ7kO2yvD3btX7iW6uAMhCNcMEx3vT6n3tE4FXxZxwnQlWVFAQC/A1sUCJ5Ojp0+iRQ3CwKkl+JOmwJscOJ9HdSsbtXmt9b6XyvfgzbfzWeo/TEzGLpB1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162427; c=relaxed/simple;
	bh=KJipXS6dsqh8cGXayXdwCocEvVsAEponS7p1QCZPm5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4d0jI9EVloOI2t2KcmZj7XC6W+8YRe93ycQdBjiKccDBN+vPKYfwHvRvFkXW1JAXThvAN2eKzPYBLHoRUGLr6FWR2ZVzIzFmimaUdmnjlwX6R1z8tbfu7DPJjag3LNmjI79NpRUDanfw+l6pU8FKHJ6ajuT7Gm0TuSMuMt6t/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIKDrvkZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22101839807so52062215ad.3
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740162423; x=1740767223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Eu5biRJR0BUSiaN/w9KxdjNHWyMVIS8FF0rxdSpGMA=;
        b=BIKDrvkZqcCSXMUv//bCrNDIZ2azOvwBAdWM61Wjm/+2ulTcbGgUesrFXpfjPwCXQX
         2eGcCvpG/VLbTUmsBWgWGXJmg791Hct0KTcYKtob2giAjG61PM0Zz3MLDRnpgZQtOHkt
         Slzhh2xutwilpBcGx3EdRFIXRniSuqOJ57nAJCBglRL0pswHurJzCpVlNjKt4oKyfvWo
         dZOQpg+Kj5ub0qYoXLd8L62g6MYAx0vQCGbvhm/gzRn7Xg5L7auyRkIUdw9fMZ1ZxEMm
         Jq+nlYYWwshg0F58tX5ZiX34anPDOxgOHUxgZuFMqtmygkiQOXzgw9QAs5XAUKYy5p0q
         qlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162423; x=1740767223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Eu5biRJR0BUSiaN/w9KxdjNHWyMVIS8FF0rxdSpGMA=;
        b=k48oMHZ4ibwIIKOhTgGpcWkZGaA6VNaW+bprrONtpkAaSIdZ5P5jL6PHGNflqLrr1S
         Sk5j4t6bpDL+SDrTH6OrN4E5EFJGuVmHK9pwKBlt7Sx4dXcSXfylGYTxxXtUS68xLBYj
         lzkc0i6UbD98f9SOIkivUleLCFeKRWSTXLiXHa19CJfXP3nERpAxcsOG6aSFGlNDN8Ll
         sd5r4OuhFVVPS5qIB51k0iI8jItZ2Q55PtG9yq5fpX0CgvmI9PuCIYTCkkRu5GyHGyYs
         S/Ac3yN+3ZkbiuiWRf/M4IbrYqk/ZMX4KJVFQeabWCbdg8UfZB0PkC1tf3uLX20hoRNK
         4tjg==
X-Forwarded-Encrypted: i=1; AJvYcCWbusK7wAtcdI0SSr8X/ABpDoPCfzh88oTmNjSNSmlF4zNJv1UYHF5itLactIv0gIFSwaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUr4QlNQic7JvoJSN7WDxMcXW6Cadt7ygaZDkZQ8BaHJiBCqCm
	z1yGb0VN3oxREqGeW2vs6NhNx7y2i+IlEulQrTZEbr/QEPxylN+xlj4L/Pj/n1SfjEtFhREQDqj
	oCa8qBkVVQJNLLPII/80eLZzlMI0=
X-Gm-Gg: ASbGncvQIPTSAUFlLG+zW1TqVx4eYcts7tCAvEJ+jSXJW+bgi2vB43DvTGqwHTNrz/N
	2PkGmFw6R4I92fL5bdPj8MNtWBxrL+PFqCpSR0xN21TssZ1nXFqlOEZg1FkaW3g84+ZNfkQSt2T
	7783qGEg==
X-Google-Smtp-Source: AGHT+IEAd4mHa1pi52o3TepVtLEXnmXHvzYVIVVKAwI1S1DEpPKIRcIGu7S/Gjpx9FWENRxkzKo+1jbWzHeoVPyG+0E=
X-Received: by 2002:a17:90b:4b01:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2fce77a01b4mr6407242a91.6.1740162421754; Fri, 21 Feb 2025
 10:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213152125.1837400-1-linux@jordanrome.com>
 <20250213152125.1837400-3-linux@jordanrome.com> <386d3514-1822-45a2-a2c5-1567a0d599a5@hetzner-cloud.de>
In-Reply-To: <386d3514-1822-45a2-a2c5-1567a0d599a5@hetzner-cloud.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Feb 2025 10:26:48 -0800
X-Gm-Features: AWEUYZlGFBwkHU-DR7eROtUFykQhDaWOD5EhsO_wokFRHicQsSKin9GSzYrAUN8
Message-ID: <CAEf4BzYu9R0_0YghpXaE5-Ojds7W7eURyp+3BsaC4BHp=ZVszg@mail.gmail.com>
Subject: Re: [bpf-next v8 3/3] selftests/bpf: Add tests for bpf_copy_from_user_task_str
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:01=E2=80=AFAM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> Hi,
>
> I'm not sure what I'm doing wrong, but after rebasing on latest bpf-next
> which includes this patch, I'm no longer able to build the bpf selftests:
>
> # pushd tools/testing/selftests/bpf/
> # make -j80
> [...]
>    GEN-SKEL [test_progs] bpf_iter_task_vmas.skel.h
>    CLNG-BPF [test_progs] bpf_iter_tasks.bpf.o
> progs/bpf_iter_tasks.c:98:8: error: call to undeclared function 'bpf_copy=
_from_user_task_str'; ISO C99 and later do not support implicit function de=
clarations [-Wimplicit-function-declaration]
>     98 |         ret =3D bpf_copy_from_user_task_str((char *)task_str1, s=
izeof(task_str1), ptr, task, 0);
>        |               ^
> 1 error generated.
> make: *** [Makefile:733: /root/linux/tools/testing/selftests/bpf/bpf_iter=
_tasks.bpf.o] Error 1
>
> I suppose the function definition should be in the vmlinux.h?
>

Yes, it should be in vmlinux.h, and if you don't have it, then you
must have a bit too old pahole.

$ git tag --contains ce4d0bc0200e3
v1.27
v1.28

> # grep bpf_copy tools/include/vmlinux.h
> typedef u64 (*btf_bpf_copy_from_user)(void *, u32, const void *);
> typedef u64 (*btf_bpf_copy_from_user_task)(void *, u32, const void *, str=
uct task_struct *, u64);
>
> The kernel built from this revision is booted while trying to compile
> the selftests. I can also see that the kfunc is there when dumping withou=
t "format c":
>
> # bpftool btf dump file /sys/kernel/btf/vmlinux | grep bpf_copy_from_user=
_task_str
> [116060] FUNC 'bpf_copy_from_user_task_str' type_id=3D116059 linkage=3Dst=
atic
>
> But when dumping the vmlinux headers with "format c", I cannot see the kf=
unc.
> I'm not sure if this is normal:
>
> # bpftool btf dump file /sys/kernel/btf/vmlinux format c | grep bpf_copy_=
from_user_task_str
> #
>
> CONFIG_BPF SYSCALL is enabled. Are there other config options that
> have to be enabled that I may be missing?
>
> I'm trying this on a aarch64 system. I also tried to fully clean
> my working tree using `git clean -d -x -f`, which didn't help
> either.
>
> Thanks!
> Marcus
>
>
> Am 13.02.25 um 16:21 schrieb Jordan Rome:
> > This adds tests for both the happy path and the
> > error path (with and without the BPF_F_PAD_ZEROS flag).
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >   .../selftests/bpf/prog_tests/bpf_iter.c       |  68 +++++++++++
> >   .../selftests/bpf/prog_tests/read_vsyscall.c  |   1 +
> >   .../selftests/bpf/progs/bpf_iter_tasks.c      | 110 +++++++++++++++++=
+
> >   .../selftests/bpf/progs/read_vsyscall.c       |  11 +-
> >   4 files changed, 188 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_iter.c
> > index 6f1bfacd7375..add4a18c33bd 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > @@ -323,19 +323,87 @@ static void test_task_pidfd(void)
> >   static void test_task_sleepable(void)
> >   {
> >       struct bpf_iter_tasks *skel;
> > +     int pid, status, err, data_pipe[2], finish_pipe[2], c;
> > +     char *test_data =3D NULL;
> > +     char *test_data_long =3D NULL;
> > +     char *data[2];
> > +
> > +     if (!ASSERT_OK(pipe(data_pipe), "data_pipe") ||
> > +         !ASSERT_OK(pipe(finish_pipe), "finish_pipe"))
> > +             return;
> >
> >       skel =3D bpf_iter_tasks__open_and_load();
> >       if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
> >               return;
> >
> > +     pid =3D fork();
> > +     if (!ASSERT_GE(pid, 0, "fork"))
> > +             return;
> > +
> > +     if (pid =3D=3D 0) {
> > +             /* child */
> > +             close(data_pipe[0]);
> > +             close(finish_pipe[1]);
> > +
> > +             test_data =3D malloc(sizeof(char) * 10);
> > +             strncpy(test_data, "test_data", 10);
> > +             test_data[9] =3D '\0';
> > +
> > +             test_data_long =3D malloc(sizeof(char) * 5000);
> > +             for (int i =3D 0; i < 5000; ++i) {
> > +                     if (i % 2 =3D=3D 0)
> > +                             test_data_long[i] =3D 'b';
> > +                     else
> > +                             test_data_long[i] =3D 'a';
> > +             }
> > +             test_data_long[4999] =3D '\0';
> > +
> > +             data[0] =3D test_data;
> > +             data[1] =3D test_data_long;
> > +
> > +             write(data_pipe[1], &data, sizeof(data));
> > +
> > +             /* keep child alive until after the test */
> > +             err =3D read(finish_pipe[0], &c, 1);
> > +             if (err !=3D 1)
> > +                     exit(-1);
> > +
> > +             close(data_pipe[1]);
> > +             close(finish_pipe[0]);
> > +             _exit(0);
> > +     }
> > +
> > +     /* parent */
> > +     close(data_pipe[1]);
> > +     close(finish_pipe[0]);
> > +
> > +     err =3D read(data_pipe[0], &data, sizeof(data));
> > +     ASSERT_EQ(err, sizeof(data), "read_check");
> > +
> > +     skel->bss->user_ptr =3D data[0];
> > +     skel->bss->user_ptr_long =3D data[1];
> > +     skel->bss->pid =3D pid;
> > +
> >       do_dummy_read(skel->progs.dump_task_sleepable);
> >
> >       ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task, 0,
> >                 "num_expected_failure_copy_from_user_task");
> >       ASSERT_GT(skel->bss->num_success_copy_from_user_task, 0,
> >                 "num_success_copy_from_user_task");
> > +     ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task_str=
, 0,
> > +               "num_expected_failure_copy_from_user_task_str");
> > +     ASSERT_GT(skel->bss->num_success_copy_from_user_task_str, 0,
> > +               "num_success_copy_from_user_task_str");
> >
> >       bpf_iter_tasks__destroy(skel);
> > +
> > +     write(finish_pipe[1], &c, 1);
> > +     err =3D waitpid(pid, &status, 0);
> > +     ASSERT_EQ(err, pid, "waitpid");
> > +     ASSERT_EQ(status, 0, "zero_child_exit");
> > +
> > +     close(data_pipe[0]);
> > +     close(finish_pipe[1]);
> >   }
> >
> >   static void test_task_stack(void)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/t=
ools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> > index c7b9ba8b1d06..a8d1eaa67020 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> > @@ -24,6 +24,7 @@ struct read_ret_desc {
> >       { .name =3D "copy_from_user", .ret =3D -EFAULT },
> >       { .name =3D "copy_from_user_task", .ret =3D -EFAULT },
> >       { .name =3D "copy_from_user_str", .ret =3D -EFAULT },
> > +     { .name =3D "copy_from_user_task_str", .ret =3D -EFAULT },
> >   };
> >
> >   void test_read_vsyscall(void)
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools=
/testing/selftests/bpf/progs/bpf_iter_tasks.c
> > index bc10c4e4b4fa..966ee5a7b066 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> > @@ -9,6 +9,13 @@ char _license[] SEC("license") =3D "GPL";
> >   uint32_t tid =3D 0;
> >   int num_unknown_tid =3D 0;
> >   int num_known_tid =3D 0;
> > +void *user_ptr =3D 0;
> > +void *user_ptr_long =3D 0;
> > +uint32_t pid =3D 0;
> > +
> > +static char big_str1[5000];
> > +static char big_str2[5005];
> > +static char big_str3[4996];
> >
> >   SEC("iter/task")
> >   int dump_task(struct bpf_iter__task *ctx)
> > @@ -35,7 +42,9 @@ int dump_task(struct bpf_iter__task *ctx)
> >   }
> >
> >   int num_expected_failure_copy_from_user_task =3D 0;
> > +int num_expected_failure_copy_from_user_task_str =3D 0;
> >   int num_success_copy_from_user_task =3D 0;
> > +int num_success_copy_from_user_task_str =3D 0;
> >
> >   SEC("iter.s/task")
> >   int dump_task_sleepable(struct bpf_iter__task *ctx)
> > @@ -44,6 +53,9 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
> >       struct task_struct *task =3D ctx->task;
> >       static const char info[] =3D "    =3D=3D=3D END =3D=3D=3D";
> >       struct pt_regs *regs;
> > +     char task_str1[10] =3D "aaaaaaaaaa";
> > +     char task_str2[10], task_str3[10];
> > +     char task_str4[20] =3D "aaaaaaaaaaaaaaaaaaaa";
> >       void *ptr;
> >       uint32_t user_data =3D 0;
> >       int ret;
> > @@ -78,8 +90,106 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
> >               BPF_SEQ_PRINTF(seq, "%s\n", info);
> >               return 0;
> >       }
> > +
> >       ++num_success_copy_from_user_task;
> >
> > +     /* Read an invalid pointer and ensure we get an error */
> > +     ptr =3D NULL;
> > +     ret =3D bpf_copy_from_user_task_str((char *)task_str1, sizeof(tas=
k_str1), ptr, task, 0);
> > +     if (ret >=3D 0 || task_str1[9] !=3D 'a' || task_str1[0] !=3D '\0'=
) {
> > +             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +             return 0;
> > +     }
> > +
> > +     /* Read an invalid pointer and ensure we get error with pad zeros=
 flag */
> > +     ptr =3D NULL;
> > +     ret =3D bpf_copy_from_user_task_str((char *)task_str1, sizeof(tas=
k_str1),
> > +                                       ptr, task, BPF_F_PAD_ZEROS);
> > +     if (ret >=3D 0 || task_str1[9] !=3D '\0' || task_str1[0] !=3D '\0=
') {
> > +             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +             return 0;
> > +     }
> > +
> > +     ++num_expected_failure_copy_from_user_task_str;
> > +
> > +     /* Same length as the string */
> > +     ret =3D bpf_copy_from_user_task_str((char *)task_str2, 10, user_p=
tr, task, 0);
> > +     /* only need to do the task pid check once */
> > +     if (bpf_strncmp(task_str2, 10, "test_data\0") !=3D 0 || ret !=3D =
10 || task->tgid !=3D pid) {
> > +             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +             return 0;
> > +     }
> > +
> > +     /* Shorter length than the string */
> > +     ret =3D bpf_copy_from_user_task_str((char *)task_str3, 2, user_pt=
r, task, 0);
> > +     if (bpf_strncmp(task_str3, 2, "t\0") !=3D 0 || ret !=3D 2) {
> > +             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +             return 0;
> > +     }
> > +
> > +     /* Longer length than the string */
> > +     ret =3D bpf_copy_from_user_task_str((char *)task_str4, 20, user_p=
tr, task, 0);
> > +     if (bpf_strncmp(task_str4, 10, "test_data\0") !=3D 0 || ret !=3D =
10
> > +         || task_str4[sizeof(task_str4) - 1] !=3D 'a') {
> > +             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +             return 0;
> > +     }
> > +
> > +     /* Longer length than the string with pad zeros flag */
> > +     ret =3D bpf_copy_from_user_task_str((char *)task_str4, 20, user_p=
tr, task, BPF_F_PAD_ZEROS);
> > +     if (bpf_strncmp(task_str4, 10, "test_data\0") !=3D 0 || ret !=3D =
10
> > +         || task_str4[sizeof(task_str4) - 1] !=3D '\0') {
> > +             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +             return 0;
> > +     }
> > +
> > +     /* Longer length than the string past a page boundary */
> > +     ret =3D bpf_copy_from_user_task_str(big_str1, 5000, user_ptr, tas=
k, 0);
> > +     if (bpf_strncmp(big_str1, 10, "test_data\0") !=3D 0 || ret !=3D 1=
0) {
> > +             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +             return 0;
> > +     }
> > +
> > +     /* String that crosses a page boundary */
> > +     ret =3D bpf_copy_from_user_task_str(big_str1, 5000, user_ptr_long=
, task, BPF_F_PAD_ZEROS);
> > +     if (bpf_strncmp(big_str1, 4, "baba") !=3D 0 || ret !=3D 5000
> > +         || bpf_strncmp(big_str1 + 4996, 4, "bab\0") !=3D 0) {
> > +             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +             return 0;
> > +     }
> > +
> > +     for (int i =3D 0; i < 4999; ++i) {
> > +             if (i % 2 =3D=3D 0) {
> > +                     if (big_str1[i] !=3D 'b') {
> > +                             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +                             return 0;
> > +                     }
> > +             } else {
> > +                     if (big_str1[i] !=3D 'a') {
> > +                             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +                             return 0;
> > +                     }
> > +             }
> > +     }
> > +
> > +     /* Longer length than the string that crosses a page boundary */
> > +     ret =3D bpf_copy_from_user_task_str(big_str2, 5005, user_ptr_long=
, task, BPF_F_PAD_ZEROS);
> > +     if (bpf_strncmp(big_str2, 4, "baba") !=3D 0 || ret !=3D 5000
> > +         || bpf_strncmp(big_str2 + 4996, 5, "bab\0\0") !=3D 0) {
> > +             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +             return 0;
> > +     }
> > +
> > +     /* Shorter length than the string that crosses a page boundary */
> > +     ret =3D bpf_copy_from_user_task_str(big_str3, 4996, user_ptr_long=
, task, 0);
> > +     if (bpf_strncmp(big_str3, 4, "baba") !=3D 0 || ret !=3D 4996
> > +         || bpf_strncmp(big_str3 + 4992, 4, "bab\0") !=3D 0) {
> > +             BPF_SEQ_PRINTF(seq, "%s\n", info);
> > +             return 0;
> > +     }
> > +
> > +     ++num_success_copy_from_user_task_str;
> > +
> >       if (ctx->meta->seq_num =3D=3D 0)
> >               BPF_SEQ_PRINTF(seq, "    tgid      gid     data\n");
> >
> > diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/=
testing/selftests/bpf/progs/read_vsyscall.c
> > index 39ebef430059..395591374d4f 100644
> > --- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
> > +++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
> > @@ -8,14 +8,16 @@
> >
> >   int target_pid =3D 0;
> >   void *user_ptr =3D 0;
> > -int read_ret[9];
> > +int read_ret[10];
> >
> >   char _license[] SEC("license") =3D "GPL";
> >
> >   /*
> > - * This is the only kfunc, the others are helpers
> > + * These are the kfuncs, the others are helpers
> >    */
> >   int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak =
__ksym;
> > +int bpf_copy_from_user_task_str(void *dst, u32, const void *,
> > +                             struct task_struct *, u64) __weak __ksym;
> >
> >   SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> >   int do_probe_read(void *ctx)
> > @@ -47,6 +49,11 @@ int do_copy_from_user(void *ctx)
> >       read_ret[7] =3D bpf_copy_from_user_task(buf, sizeof(buf), user_pt=
r,
> >                                             bpf_get_current_task_btf(),=
 0);
> >       read_ret[8] =3D bpf_copy_from_user_str((char *)buf, sizeof(buf), =
user_ptr, 0);
> > +     read_ret[9] =3D bpf_copy_from_user_task_str((char *)buf,
> > +                                               sizeof(buf),
> > +                                               user_ptr,
> > +                                               bpf_get_current_task_bt=
f(),
> > +                                               0);
> >
> >       return 0;
> >   }
> > --
> > 2.43.5
> >
> >
>
> --
> Best regards,
> Marcus Wichelmann
> Linux Networking Specialist
> Team SDN
>
> ______________________________
>
> Hetzner Cloud GmbH
> Feringastra=C3=9Fe 12A
> 85774 Unterf=C3=B6hring
> Germany
>
> Phone: +49 89 381690 150
> E-Mail: marcus.wichelmann@hetzner-cloud.de
>
> Handelsregister M=C3=BCnchen HRB 226782
> Gesch=C3=A4ftsf=C3=BChrer: Sebastian F=C3=A4rber, Markus Kalmuk
>
> ------------------
> For information on the processing of your personal
> data in the context of this contact, please see
> https://hetzner-cloud.de/datenschutz
> ------------------
>

