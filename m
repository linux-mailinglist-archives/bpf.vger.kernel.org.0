Return-Path: <bpf+bounces-30087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C27338CA77C
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 06:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15F9B21E75
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 04:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B46286BD;
	Tue, 21 May 2024 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0yFqc97"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1306125
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716267295; cv=none; b=hhfrmm4LaCkj5c3JGvKua+6YpGFdKuB58eFKghNixXCUDOEinb5SzTNg1R98gOZa2s29YPsebmKB6xX/dPaqO2N+HU7FnfuMMinfE3jFGHCjBEG8dMekf1wsVnA0kKIULxvJcOagu/DRBs/klcd5wsRVYn03giuACqmWUnlrfVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716267295; c=relaxed/simple;
	bh=VSUhZOOlsUoh71Q44pcpzujNeX2dJ5dS460pZ7l5PlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hfnp+/9wChUGUVNZ9XI3R2QvMMyOJn872z5NMnY5aHuQVTnRmBwozlHd6FpG0/Ei3/72jTfmz4sPWuc74I4npl2ZA7IdReNPhSaVfNDLs1A8RT4dhJ7klIE5mrVZpgX1ulLHhO2oNP+TdHf5hZXvWRP2bHOdHQadZfckA7nKBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0yFqc97; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eeb1a4c10aso97962075ad.3
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 21:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716267293; x=1716872093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFmIQ4JTOcquvuPpsBqSC7VuGai7jlk57yd6W0Lesv0=;
        b=O0yFqc97yv13Jk6/mXKlXEXKDl1Mr6uTZxDysTb7z5/pOo1G/Vr6CcTB6BxLQoRaTU
         H63K2pjDb5xzDqQ0k89/Q+J9+HmrboIoZYKkgWgu3xjjzAj8yYFN4Zub182uySs6s0Wc
         4ZQ5u3OsvUZYgvbzN7c7Kk27/6TbOzdcoNL9dyuAu0yWO+fmakWtacPEIuxjmyuS+mOO
         V4pdIw+dEYSVaytkxZriCRnHzk1jCNEQ9ds/mKwfwI3hpINm8BhoPfY3eVcFybsy+xrr
         8DruozX+sC0CI0owDrcpiSh8n4e2aRNtE3/z0QbiA3X8h6pG5hG9pSNXmCcmd4Aig1f0
         eF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716267293; x=1716872093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFmIQ4JTOcquvuPpsBqSC7VuGai7jlk57yd6W0Lesv0=;
        b=kizkYDW6cbjcBeJQxBHQm7VIxfK5glsj9+OgoFgu8bT78Msm/O6nluFQ+mr/17fL4d
         CYdw+aPN7slmjc0mbwvG//Eb8XIUe7yZsiMTEy4pZgZCgaN42wgsP0ncaBBM3vOC2YSP
         7hBraOudjGhy9Ndl0L1UYex9je+1GS6xmYIDqUoE13MbCwOI2PhZNFRmVY0R4OXQiPSV
         1HCbfLxlxexO/BwDavYFYUxXq1HMOiEeFjGPJtMF3tf27zPpZYdEZsOkRiaruxuOdS1s
         NBaqX+bxON6Jkzd6Tjyk5f3O5bML7Valsw68f5qy1hFMq6HJiFKmDbP8vyx+Jnqf0U/u
         9Ovg==
X-Gm-Message-State: AOJu0YyKf2NOjc+JwzdC5ROxJkhDpWH+Yq8kbAl7OOV10zFNozzuISKq
	h87+cgFkRTBh8X1nqajtQ5c5U07qr6l333YuGNOYwNaT7RFoJgZ/VuRMOqwNdgMmtS9W8v35nNp
	lNwGx/GIgcgi5Ujj4XauLhYP67F2ylHNP
X-Google-Smtp-Source: AGHT+IGDJ0r3MkWY7ObyFdfEZbbKHyGAR1qlO/cPC/nIAhTGb6GF1+Uq/3/D7c7qjm5SaoB1/iMpkXSu7aNgrMfn2mg=
X-Received: by 2002:a17:90b:100d:b0:2b6:2ef4:e2aa with SMTP id
 98e67ed59e1d1-2b6cc780466mr24522315a91.25.1716267292693; Mon, 20 May 2024
 21:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520234720.1748918-1-andrii@kernel.org> <20240520234720.1748918-6-andrii@kernel.org>
In-Reply-To: <20240520234720.1748918-6-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 May 2024 21:54:40 -0700
Message-ID: <CAEf4BzaZxUV4t5T8itBydzgm2r4XKThZ9WQLgsJ9auZEfQTntg@mail.gmail.com>
Subject: Re: [PATCH bpf 5/5] selftests/bpf: extend multi-uprobe tests with USDTs
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 4:47=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Validate libbpf's USDT-over-multi-uprobe logic by adding USDTs to
> existing multi-uprobe tests. This checks correct libbpf fallback to
> singular uprobes (when run on older kernels with buggy PID filtering).
> We reuse already established child process and child thread testing
> infrastructure, so additions are minimal. These test fail on either
> older kernels or older version of libbpf that doesn't detect PID
> filtering problems.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 22 +++++++++++++
>  .../selftests/bpf/progs/uprobe_multi.c        | 33 +++++++++++++++++--
>  2 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 677232d31432..85d46e568e90 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -8,6 +8,7 @@
>  #include "uprobe_multi_usdt.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "testing_helpers.h"
> +#include "../sdt.h"
>
>  static char test_data[] =3D "test_data";
>
> @@ -26,6 +27,11 @@ noinline void uprobe_multi_func_3(void)
>         asm volatile ("");
>  }
>
> +noinline void usdt_trigger(void)
> +{
> +       STAP_PROBE(test, pid_filter_usdt);
> +}
> +
>  struct child {
>         int go[2];
>         int c2p[2]; /* child -> parent channel */
> @@ -269,8 +275,24 @@ __test_attach_api(const char *binary, const char *pa=
ttern, struct bpf_uprobe_mul
>         if (!ASSERT_OK_PTR(skel->links.uprobe_extra, "bpf_program__attach=
_uprobe_multi"))
>                 goto cleanup;
>
> +       /* Attach (uprobe-backed) USDTs */
> +       skel->links.usdt_pid =3D bpf_program__attach_usdt(skel->progs.usd=
t_pid, pid, binary,
> +                                                       "test", "pid_filt=
er_usdt", NULL);
> +       if (!ASSERT_OK_PTR(skel->links.usdt_pid, "attach_usdt_pid"))
> +               goto cleanup;
> +
> +       skel->links.usdt_extra =3D bpf_program__attach_usdt(skel->progs.u=
sdt_extra, -1, binary,
> +                                                         "test", "pid_fi=
lter_usdt", NULL);
> +       if (!ASSERT_OK_PTR(skel->links.usdt_extra, "attach_usdt_extra"))
> +               goto cleanup;
> +
>         uprobe_multi_test_run(skel, child);
>
> +       ASSERT_FALSE(skel->bss->bad_pid_seen_usdt, "bad_pid_seen_usdt");
> +       if (child) {
> +               ASSERT_EQ(skel->bss->child_pid_usdt, child->pid, "usdt_mu=
lti_child_pid");
> +               ASSERT_EQ(skel->bss->child_tid_usdt, child->tid, "usdt_mu=
lti_child_tid");
> +       }
>  cleanup:
>         uprobe_multi__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/tes=
ting/selftests/bpf/progs/uprobe_multi.c
> index 86a7ff5d3726..44190efcdba2 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> -#include <stdbool.h>
> +#include <bpf/usdt.bpf.h>
>
>  char _license[] SEC("license") =3D "GPL";
>
> @@ -23,9 +23,12 @@ __u64 uprobe_multi_sleep_result =3D 0;
>  int pid =3D 0;
>  int child_pid =3D 0;
>  int child_tid =3D 0;
> +int child_pid_usdt =3D 0;
> +int child_tid_usdt =3D 0;
>
>  int expect_pid =3D 0;
>  bool bad_pid_seen =3D false;
> +bool bad_pid_seen_usdt =3D false;
>
>  bool test_cookie =3D false;
>  void *user_ptr =3D 0;
> @@ -112,3 +115,29 @@ int uprobe_extra(struct pt_regs *ctx)
>         /* we need this one just to mix PID-filtered and global uprobes *=
/
>         return 0;
>  }
> +
> +SEC("usdt")
> +int usdt_pid(struct pt_regs *ctx)
> +{
> +       __u64 cur_pid_tgid =3D bpf_get_current_pid_tgid();
> +       __u32 cur_pid;
> +
> +       cur_pid =3D cur_pid_tgid >> 32;
> +       if (pid && cur_pid !=3D pid)
> +               return 0;
> +
> +       if (expect_pid && cur_pid !=3D expect_pid)
> +               bad_pid_seen_usdt =3D true;
> +
> +       child_pid_usdt =3D cur_pid_tgid >> 32;
> +       child_tid_usdt =3D (__u32)cur_pid_tgid;
> +
> +       return 0;
> +}
> +
> +SEC("usdt")
> +int usdt_extra(struct pt_regs *ctx)
> +{
> +       /* we need this one just to mix PID-filtered and global USDT prob=
es */
> +       return 0;
> +}
> --
> 2.43.0
>

I lost the following during the final rebase before submitting,
sigh... With the piece below tests are passing again:

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 85d46e568e90..bf6ca8e3eb13 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -96,6 +96,7 @@ static struct child *spawn_child(void)
                uprobe_multi_func_1();
                uprobe_multi_func_2();
                uprobe_multi_func_3();
+               usdt_trigger();

                exit(errno);
        }
@@ -123,6 +124,7 @@ static void *child_thread(void *ctx)
        uprobe_multi_func_1();
        uprobe_multi_func_2();
        uprobe_multi_func_3();
+       usdt_trigger();

        err =3D 0;
        pthread_exit(&err);
@@ -188,6 +190,7 @@ static void uprobe_multi_test_run(struct
uprobe_multi *skel, struct child *child
                uprobe_multi_func_1();
                uprobe_multi_func_2();
                uprobe_multi_func_3();
+               usdt_trigger();
        }

        if (child)


I'll wait till tomorrow for any feedback and will post v2.

I'm also curious about logistics? Do we want to get everything through
the bpf tree? Or bpf-next? Or split somehow? Thoughts?

I think the fix in patch #1 is important enough to backport to stable
kernels (multi-uprobes went into upstream v6.6 kernel, FYI).

