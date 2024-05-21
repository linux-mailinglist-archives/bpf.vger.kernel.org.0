Return-Path: <bpf+bounces-30088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC74C8CA788
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 07:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835AF2822AD
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 05:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2B32E85E;
	Tue, 21 May 2024 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVrDvF/8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664D610C
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716267930; cv=none; b=F1Z7XzRNm6roEXnM6uksfvnf/kVwua/hMu4mTyWWDuIykI7kExpBhBOzMRdc9J7Pi12+HinZllL4gSH91ZHmY4Law8Y3NysatXbhbMjNgakTfSJ4eZTizqLL6yMWPYAaZlOO0xsz9vOUdOfU1ZMA5UDOzt4AeREfv+q5nY/Jzv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716267930; c=relaxed/simple;
	bh=/8HUVTjrAJ8tUzF4HfsquKWjSNokSKO9JPIqu2bkZLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph6QyctBeXsxI0GPYlW2RzX+ks92snQ/xijic4mZf1090V/j1hPFE3Yscy2X2oqGYfcutL85N6gcpmsG3/QPSFQ77wMhr18HIXsaYWdDtGhy3a/Z3PFlPs8Mt/MJBaIavkPbeDhtzl8dKpJ8cNMbupeoe7xrGTV/75jz+JuZBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVrDvF/8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-354cd8da8b9so628436f8f.0
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 22:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716267927; x=1716872727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yblH263Nbykd3X5HQaWaA72wyQoYHx5y0IXfD1SSYc=;
        b=SVrDvF/87jUDWJwgTLZWGefl+yCNSFJv4M6RTVWK8x6fTL5fkx3bUD5Y9EENH7N7wx
         ABTEtjMKO+HgIikXg21ZHGlfGqWtzDfhdynT4Lg63ZgKu4rv3ShbJE/1HZBM33X0AAdQ
         5CB5mLFG7iy0ljravRylts97DI3RZGs9OL7jTWzzx5fcKw4yFJaZo3Q0ZAmjIVy6MvHH
         bM7vSH+KrEM1ZdL9qu/sTeC2HhOT9jdtfyDIKg57bK/WUwFfVpuCf67JBVQbcXVbaNg3
         bua0DbGOpgNOwuD5HgyrvVdstE4EQA/iVnMuSQRAPWAB1Jbh2FRfjixQ16Owot6Hmp2/
         nmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716267927; x=1716872727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yblH263Nbykd3X5HQaWaA72wyQoYHx5y0IXfD1SSYc=;
        b=P/gVV/tSHiB719/6ABGg9ZgCmSURR/3kAfqki7bzWnAJh5NBTyYJKcWvGYz9GopLzK
         CSy28np7Ttc8YKzK1b2EGbLJowipuKRii589aOleosH122smzd3OaSpVrEWfoC8nSnyH
         pCPOtgxhMTwYCbyD2JcgQyaR2XM7axZOwfT0nN45hn9v90hx00i8wo/Cz4XaZXyidEVc
         5h/TrBbYVluicL5jYY0vgasMQZdtF3POP+yvA2GiWZxNwZNH/8OOn8IrSd0fhIK6+o9x
         qKKBIKgUguIIM+pHLWHoaygVV1d0vVjdfZw/gmRKA5rimvB5VWEuHa07Qj4bYzirZhKZ
         ln2g==
X-Forwarded-Encrypted: i=1; AJvYcCVvP1t2bg5Slcb2m4DRufh80UXdWkIQ1/WLXvslawLC411GcugrtMT+lSt0kro1IEquc6y84EIHu0DF7VcENajBaaql
X-Gm-Message-State: AOJu0YxtklWQAJ0mT80jMoDu1NVFBLfvUZTHdskpbJhmU9BJRdcGQmbL
	repF5AFILtGyl4zE138RIUdZ49iQAzaUnjrglwxqTHgq9fV8cWLBLvecDtYjZqi/qzAWtPO6TyQ
	/NWxlPWTtov3Otb+IQht8g1lsaYk=
X-Google-Smtp-Source: AGHT+IGOQUJNyoNnWyGqnQ19VPoD28DAlxO8qKW7kf2aqG016g5uYTsIeDT60n5iqRuxj3gF9FwTJQx1PQidQVpwlXs=
X-Received: by 2002:a5d:4801:0:b0:34d:2343:b881 with SMTP id
 ffacd0b85a97d-3504a96a343mr21724443f8f.43.1716267926858; Mon, 20 May 2024
 22:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520234720.1748918-1-andrii@kernel.org> <20240520234720.1748918-6-andrii@kernel.org>
 <CAEf4BzaZxUV4t5T8itBydzgm2r4XKThZ9WQLgsJ9auZEfQTntg@mail.gmail.com>
In-Reply-To: <CAEf4BzaZxUV4t5T8itBydzgm2r4XKThZ9WQLgsJ9auZEfQTntg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 May 2024 22:05:13 -0700
Message-ID: <CAADnVQLZZiMDkc6O0WCnBxkJKkeXubUPtCQO5h8BihJ0DeS=yQ@mail.gmail.com>
Subject: Re: [PATCH bpf 5/5] selftests/bpf: extend multi-uprobe tests with USDTs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 9:54=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 20, 2024 at 4:47=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > Validate libbpf's USDT-over-multi-uprobe logic by adding USDTs to
> > existing multi-uprobe tests. This checks correct libbpf fallback to
> > singular uprobes (when run on older kernels with buggy PID filtering).
> > We reuse already established child process and child thread testing
> > infrastructure, so additions are minimal. These test fail on either
> > older kernels or older version of libbpf that doesn't detect PID
> > filtering problems.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 22 +++++++++++++
> >  .../selftests/bpf/progs/uprobe_multi.c        | 33 +++++++++++++++++--
> >  2 files changed, 53 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c=
 b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index 677232d31432..85d46e568e90 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -8,6 +8,7 @@
> >  #include "uprobe_multi_usdt.skel.h"
> >  #include "bpf/libbpf_internal.h"
> >  #include "testing_helpers.h"
> > +#include "../sdt.h"
> >
> >  static char test_data[] =3D "test_data";
> >
> > @@ -26,6 +27,11 @@ noinline void uprobe_multi_func_3(void)
> >         asm volatile ("");
> >  }
> >
> > +noinline void usdt_trigger(void)
> > +{
> > +       STAP_PROBE(test, pid_filter_usdt);
> > +}
> > +
> >  struct child {
> >         int go[2];
> >         int c2p[2]; /* child -> parent channel */
> > @@ -269,8 +275,24 @@ __test_attach_api(const char *binary, const char *=
pattern, struct bpf_uprobe_mul
> >         if (!ASSERT_OK_PTR(skel->links.uprobe_extra, "bpf_program__atta=
ch_uprobe_multi"))
> >                 goto cleanup;
> >
> > +       /* Attach (uprobe-backed) USDTs */
> > +       skel->links.usdt_pid =3D bpf_program__attach_usdt(skel->progs.u=
sdt_pid, pid, binary,
> > +                                                       "test", "pid_fi=
lter_usdt", NULL);
> > +       if (!ASSERT_OK_PTR(skel->links.usdt_pid, "attach_usdt_pid"))
> > +               goto cleanup;
> > +
> > +       skel->links.usdt_extra =3D bpf_program__attach_usdt(skel->progs=
.usdt_extra, -1, binary,
> > +                                                         "test", "pid_=
filter_usdt", NULL);
> > +       if (!ASSERT_OK_PTR(skel->links.usdt_extra, "attach_usdt_extra")=
)
> > +               goto cleanup;
> > +
> >         uprobe_multi_test_run(skel, child);
> >
> > +       ASSERT_FALSE(skel->bss->bad_pid_seen_usdt, "bad_pid_seen_usdt")=
;
> > +       if (child) {
> > +               ASSERT_EQ(skel->bss->child_pid_usdt, child->pid, "usdt_=
multi_child_pid");
> > +               ASSERT_EQ(skel->bss->child_tid_usdt, child->tid, "usdt_=
multi_child_tid");
> > +       }
> >  cleanup:
> >         uprobe_multi__destroy(skel);
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/t=
esting/selftests/bpf/progs/uprobe_multi.c
> > index 86a7ff5d3726..44190efcdba2 100644
> > --- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
> > +++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> > @@ -1,8 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include <linux/bpf.h>
> > +#include "vmlinux.h"
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> > -#include <stdbool.h>
> > +#include <bpf/usdt.bpf.h>
> >
> >  char _license[] SEC("license") =3D "GPL";
> >
> > @@ -23,9 +23,12 @@ __u64 uprobe_multi_sleep_result =3D 0;
> >  int pid =3D 0;
> >  int child_pid =3D 0;
> >  int child_tid =3D 0;
> > +int child_pid_usdt =3D 0;
> > +int child_tid_usdt =3D 0;
> >
> >  int expect_pid =3D 0;
> >  bool bad_pid_seen =3D false;
> > +bool bad_pid_seen_usdt =3D false;
> >
> >  bool test_cookie =3D false;
> >  void *user_ptr =3D 0;
> > @@ -112,3 +115,29 @@ int uprobe_extra(struct pt_regs *ctx)
> >         /* we need this one just to mix PID-filtered and global uprobes=
 */
> >         return 0;
> >  }
> > +
> > +SEC("usdt")
> > +int usdt_pid(struct pt_regs *ctx)
> > +{
> > +       __u64 cur_pid_tgid =3D bpf_get_current_pid_tgid();
> > +       __u32 cur_pid;
> > +
> > +       cur_pid =3D cur_pid_tgid >> 32;
> > +       if (pid && cur_pid !=3D pid)
> > +               return 0;
> > +
> > +       if (expect_pid && cur_pid !=3D expect_pid)
> > +               bad_pid_seen_usdt =3D true;
> > +
> > +       child_pid_usdt =3D cur_pid_tgid >> 32;
> > +       child_tid_usdt =3D (__u32)cur_pid_tgid;
> > +
> > +       return 0;
> > +}
> > +
> > +SEC("usdt")
> > +int usdt_extra(struct pt_regs *ctx)
> > +{
> > +       /* we need this one just to mix PID-filtered and global USDT pr=
obes */
> > +       return 0;
> > +}
> > --
> > 2.43.0
> >
>
> I lost the following during the final rebase before submitting,
> sigh... With the piece below tests are passing again:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 85d46e568e90..bf6ca8e3eb13 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -96,6 +96,7 @@ static struct child *spawn_child(void)
>                 uprobe_multi_func_1();
>                 uprobe_multi_func_2();
>                 uprobe_multi_func_3();
> +               usdt_trigger();
>
>                 exit(errno);
>         }
> @@ -123,6 +124,7 @@ static void *child_thread(void *ctx)
>         uprobe_multi_func_1();
>         uprobe_multi_func_2();
>         uprobe_multi_func_3();
> +       usdt_trigger();
>
>         err =3D 0;
>         pthread_exit(&err);
> @@ -188,6 +190,7 @@ static void uprobe_multi_test_run(struct
> uprobe_multi *skel, struct child *child
>                 uprobe_multi_func_1();
>                 uprobe_multi_func_2();
>                 uprobe_multi_func_3();
> +               usdt_trigger();
>         }
>
>         if (child)
>
>
> I'll wait till tomorrow for any feedback and will post v2.

pls wait for review from Jiri.

> I'm also curious about logistics? Do we want to get everything through
> the bpf tree? Or bpf-next? Or split somehow? Thoughts?

I think the whole thing through bpf tree makes it the easiest for everyone.

