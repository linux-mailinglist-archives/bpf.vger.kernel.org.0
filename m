Return-Path: <bpf+bounces-30122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B408CB1FE
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B01F222E5
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9121CD1F;
	Tue, 21 May 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aic2Z0Vo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C93182DB
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308042; cv=none; b=L8yuPqrpj9QH4mFt6JPyWoXa1vtE7AhI+aNwwcniEXylCX2j4G+4FpvZm91/OA5ZdzyPLv7GTMfhWjRo6eFh28zOHVf7nfRD+Tbp7A7deYf1upQ0lNgZ47uUh/zdJMA7vRoIuN0KrS587vpO8lwF4fc6J38l7q6eLPBGEarhkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308042; c=relaxed/simple;
	bh=BsCWv3xfDAdSJcM0cts3uJysCb8K5lzo1Os/E8MkZy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apqbq03KCIqtGmIheA7paIaaM2BVD9P7tEb3nud0smjWAimaM7NkGf0iHzIJfAMjoEOrE8I05Zl3VCk+s9nUZ8/9ogZuPQ36uLdcx/Xuo0B9/9zxhnWmoHpsN9I4KFhPprKuHKjhfBJNYtXm6h1PQDu0zV13wwjIpL9E82Pd9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aic2Z0Vo; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-65c5a29f7f0so1565736a12.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716308040; x=1716912840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm7lOOnWHrNWseibicdBmhD9UcAvPkpSfcVgr1RIqZY=;
        b=Aic2Z0VoRM7NqTcCdYN/jguJSmLhxvSGn/gWpSd9tTdrAHkrD+es7wTYEvQ8uZU3TJ
         rZ3+7iZiM0YYTkF5irh14XM4UeARPnd9Z0JEoRJL/wUcw6NuV3lhYyrrawH9w5hZkdq7
         Kag0xmHoDMBJsLJqWutj65q8g0AqWVS7O0kdF/anOU7PhaV5as5UEO8y8FzybXBnZNAp
         0LlKYyUEfMnAoJshT0xEmDbwJuOT7oeidUTcQjsAWKBf38eCM08K5y04BCvnq/zlc5/b
         WwIrzs+0zeVPWrdmKPkhDgWsx3gQsBEtwpG9NsGfQAB58hYsPbg/XDeIh11wgTsef4T0
         UDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716308040; x=1716912840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm7lOOnWHrNWseibicdBmhD9UcAvPkpSfcVgr1RIqZY=;
        b=rxzli0JJ+N09NZYWEx801IEaj47bvXKrHLqr284n15WDA/dKWfhCTtCEUaI8dndMST
         iF5cyGASm+YU4+wFNwNjJtH2MOCHlLhFn7JLCoIkimXajlYleuxDi15QRpL3cnlRMJY5
         ftJbrLc2Q9ZtdAOUkyW7GRZ06uX3qg6R8mX9nB5xUpC7VA1/Nedo1N4Q/9vB6KQf6dI7
         SrrtELb7CGMI7TnhIH/46p0AmXayJVAF+4wX2d7q2yJ93v2M8dubLZUGqEYPkf8MQRp1
         XTAoym4/UXSKleiYWcNqrlHZs23usf6COL8BniSR4e5jGjVnldm7WgWDRQYnNcTsfn/r
         HjWg==
X-Forwarded-Encrypted: i=1; AJvYcCUGJ6LEm99W0xrbACGLFZqEarsIK52RDY60wtHwDQxzsbxLC4IRV0hcv3DazFmGW6YtuzRlTmhzS52C39h0cplmreKs
X-Gm-Message-State: AOJu0YyH1Q3uXeBPacw6TWTPuCFHPgOUyI2pCbp2HWN3d+lRtT9KCG4M
	lhLf9wS3Q77IlZTXyDJdO0wB1y5K8A5QwzVK/pIy3Pyr2CfFJ1bL/Om4q0QQ0Lr3uSluKbjuWPr
	qIY0lm/n6wDllAT8TiQetZPwKKRI=
X-Google-Smtp-Source: AGHT+IElBn/vn/g3UMuhL/27l3WpiRIxlFtxMwc0VDKaisicRu1s0vdByK0UhTabWfbcgejgOMDk2BcYtD+4ltd8iVI=
X-Received: by 2002:a17:90a:7789:b0:2a5:f70c:9ec6 with SMTP id
 98e67ed59e1d1-2b6cc97d18fmr29327113a91.24.1716308040362; Tue, 21 May 2024
 09:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520234720.1748918-1-andrii@kernel.org> <20240520234720.1748918-6-andrii@kernel.org>
 <CAEf4BzaZxUV4t5T8itBydzgm2r4XKThZ9WQLgsJ9auZEfQTntg@mail.gmail.com> <Zkxxqayh9VtHGQuj@krava>
In-Reply-To: <Zkxxqayh9VtHGQuj@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 May 2024 09:13:48 -0700
Message-ID: <CAEf4Bza0BE9rUFdHWETKTH4-hVGnmGo73Q5EZQkwZ+u_pQP0Pg@mail.gmail.com>
Subject: Re: [PATCH bpf 5/5] selftests/bpf: extend multi-uprobe tests with USDTs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 3:04=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, May 20, 2024 at 09:54:40PM -0700, Andrii Nakryiko wrote:
> > On Mon, May 20, 2024 at 4:47=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > Validate libbpf's USDT-over-multi-uprobe logic by adding USDTs to
> > > existing multi-uprobe tests. This checks correct libbpf fallback to
> > > singular uprobes (when run on older kernels with buggy PID filtering)=
.
> > > We reuse already established child process and child thread testing
> > > infrastructure, so additions are minimal. These test fail on either
> > > older kernels or older version of libbpf that doesn't detect PID
> > > filtering problems.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  .../bpf/prog_tests/uprobe_multi_test.c        | 22 +++++++++++++
> > >  .../selftests/bpf/progs/uprobe_multi.c        | 33 +++++++++++++++++=
--
> > >  2 files changed, 53 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test=
.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > > index 677232d31432..85d46e568e90 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > > @@ -8,6 +8,7 @@
> > >  #include "uprobe_multi_usdt.skel.h"
> > >  #include "bpf/libbpf_internal.h"
> > >  #include "testing_helpers.h"
> > > +#include "../sdt.h"
> > >
> > >  static char test_data[] =3D "test_data";
> > >
> > > @@ -26,6 +27,11 @@ noinline void uprobe_multi_func_3(void)
> > >         asm volatile ("");
> > >  }
> > >
> > > +noinline void usdt_trigger(void)
> > > +{
> > > +       STAP_PROBE(test, pid_filter_usdt);
> > > +}
> > > +
> > >  struct child {
> > >         int go[2];
> > >         int c2p[2]; /* child -> parent channel */
> > > @@ -269,8 +275,24 @@ __test_attach_api(const char *binary, const char=
 *pattern, struct bpf_uprobe_mul
> > >         if (!ASSERT_OK_PTR(skel->links.uprobe_extra, "bpf_program__at=
tach_uprobe_multi"))
> > >                 goto cleanup;
> > >
> > > +       /* Attach (uprobe-backed) USDTs */
> > > +       skel->links.usdt_pid =3D bpf_program__attach_usdt(skel->progs=
.usdt_pid, pid, binary,
> > > +                                                       "test", "pid_=
filter_usdt", NULL);
> > > +       if (!ASSERT_OK_PTR(skel->links.usdt_pid, "attach_usdt_pid"))
> > > +               goto cleanup;
> > > +
> > > +       skel->links.usdt_extra =3D bpf_program__attach_usdt(skel->pro=
gs.usdt_extra, -1, binary,
> > > +                                                         "test", "pi=
d_filter_usdt", NULL);
> > > +       if (!ASSERT_OK_PTR(skel->links.usdt_extra, "attach_usdt_extra=
"))
> > > +               goto cleanup;
> > > +
> > >         uprobe_multi_test_run(skel, child);
> > >
> > > +       ASSERT_FALSE(skel->bss->bad_pid_seen_usdt, "bad_pid_seen_usdt=
");
> > > +       if (child) {
> > > +               ASSERT_EQ(skel->bss->child_pid_usdt, child->pid, "usd=
t_multi_child_pid");
> > > +               ASSERT_EQ(skel->bss->child_tid_usdt, child->tid, "usd=
t_multi_child_tid");
> > > +       }
> > >  cleanup:
> > >         uprobe_multi__destroy(skel);
> > >  }
> > > diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools=
/testing/selftests/bpf/progs/uprobe_multi.c
> > > index 86a7ff5d3726..44190efcdba2 100644
> > > --- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
> > > +++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> > > @@ -1,8 +1,8 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > > -#include <linux/bpf.h>
> > > +#include "vmlinux.h"
> > >  #include <bpf/bpf_helpers.h>
> > >  #include <bpf/bpf_tracing.h>
> > > -#include <stdbool.h>
> > > +#include <bpf/usdt.bpf.h>
> > >
> > >  char _license[] SEC("license") =3D "GPL";
> > >
> > > @@ -23,9 +23,12 @@ __u64 uprobe_multi_sleep_result =3D 0;
> > >  int pid =3D 0;
> > >  int child_pid =3D 0;
> > >  int child_tid =3D 0;
> > > +int child_pid_usdt =3D 0;
> > > +int child_tid_usdt =3D 0;
> > >
> > >  int expect_pid =3D 0;
> > >  bool bad_pid_seen =3D false;
> > > +bool bad_pid_seen_usdt =3D false;
> > >
> > >  bool test_cookie =3D false;
> > >  void *user_ptr =3D 0;
> > > @@ -112,3 +115,29 @@ int uprobe_extra(struct pt_regs *ctx)
> > >         /* we need this one just to mix PID-filtered and global uprob=
es */
> > >         return 0;
> > >  }
> > > +
> > > +SEC("usdt")
> > > +int usdt_pid(struct pt_regs *ctx)
> > > +{
> > > +       __u64 cur_pid_tgid =3D bpf_get_current_pid_tgid();
> > > +       __u32 cur_pid;
> > > +
> > > +       cur_pid =3D cur_pid_tgid >> 32;
> > > +       if (pid && cur_pid !=3D pid)
> > > +               return 0;
> > > +
> > > +       if (expect_pid && cur_pid !=3D expect_pid)
> > > +               bad_pid_seen_usdt =3D true;
> > > +
> > > +       child_pid_usdt =3D cur_pid_tgid >> 32;
> > > +       child_tid_usdt =3D (__u32)cur_pid_tgid;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +SEC("usdt")
> > > +int usdt_extra(struct pt_regs *ctx)
> > > +{
> > > +       /* we need this one just to mix PID-filtered and global USDT =
probes */
> > > +       return 0;
> > > +}
> > > --
> > > 2.43.0
> > >
> >
> > I lost the following during the final rebase before submitting,
> > sigh... With the piece below tests are passing again:
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index 85d46e568e90..bf6ca8e3eb13 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -96,6 +96,7 @@ static struct child *spawn_child(void)
> >                 uprobe_multi_func_1();
> >                 uprobe_multi_func_2();
> >                 uprobe_multi_func_3();
> > +               usdt_trigger();
> >
> >                 exit(errno);
> >         }
> > @@ -123,6 +124,7 @@ static void *child_thread(void *ctx)
> >         uprobe_multi_func_1();
> >         uprobe_multi_func_2();
> >         uprobe_multi_func_3();
> > +       usdt_trigger();
> >
> >         err =3D 0;
> >         pthread_exit(&err);
> > @@ -188,6 +190,7 @@ static void uprobe_multi_test_run(struct
> > uprobe_multi *skel, struct child *child
> >                 uprobe_multi_func_1();
> >                 uprobe_multi_func_2();
> >                 uprobe_multi_func_3();
> > +               usdt_trigger();
> >         }
> >
> >         if (child)
> >
> >
> > I'll wait till tomorrow for any feedback and will post v2.
>
> tests are passing for me with the changes above
>
> >
> > I'm also curious about logistics? Do we want to get everything through
> > the bpf tree? Or bpf-next? Or split somehow? Thoughts?
> >
> > I think the fix in patch #1 is important enough to backport to stable
> > kernels (multi-uprobes went into upstream v6.6 kernel, FYI).
>
> agreed, perhaps also the patch #3 for libbpf detection?

no one should be building libbpf from kernel sources, Github is the
authoritative source code for packaging. So I think it's not necessary
to backport libbpf. Tests will keep passing with just patch #1.

>
> jirka

