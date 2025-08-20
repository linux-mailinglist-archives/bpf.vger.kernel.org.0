Return-Path: <bpf+bounces-66108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD2B2E665
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 22:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156D6A2373A
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 20:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E27D296BC9;
	Wed, 20 Aug 2025 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZBasapC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DABC272805;
	Wed, 20 Aug 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721402; cv=none; b=cRS4bDPoKJKY2Kss07Bd64RE6HmMbQiAVoxY52Ts4FYuX1aRdqmENYrzV7Q99jywXAJVrO+SR65CYDwcBj8/ui83z05oxvB8yjOg73fxPwTw3KwAwlvxK56guCIoV9XfEy8aU/UmSavKDCKvDKbQVJzVnpIF82Q28k4nbwCGO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721402; c=relaxed/simple;
	bh=eYKAdJpEAzFxJchXm4gocNfC64jjCunkg29L3pb8OUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlbYK+7PmoOx557VeJcV1nSotPsU9Upp8XQ/A/63fRcVM7HF56VUQE/Vtxa9zVdhUYspg/3MXh7jkwGuEEE9kgW9ouqf6we2eIt1s58XPnoB/acMFwrQcgIfdSCftgMw57uWWbHeecH6od5vD9LCb9K0R/vI3py21e1fiaK9DIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZBasapC; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47174beb13so143383a12.2;
        Wed, 20 Aug 2025 13:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755721400; x=1756326200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xar26Fk7Vgh0oRtfSyJq7JbIEeQDQwbrb9OyTQGXg9c=;
        b=JZBasapChlcRoffOYS/hLf83xtp+yG8hd/1OqGYHO3o8ACbuYhxbVHQDsVEE1Y1juz
         PIQr4FbGV9emkvJVsNlneM+n3b3z1OeqirrMkiSjNSp2xu4F2CE2Om01VYwa79u/pZKA
         YgfbYWPQNXveYuymQpfO380r2lA4wviOiK/cYCJiz+w9cBApIJc7wDmTjgGQO3pTIPJn
         HyZ5pIru8BRWCoKgY+ZqXoFGSIyUbUh7oDxfNng+Oz0oUYR17e7UKJMd79HcP3gubrbz
         iBYiT1wLmEi9len/04XylXIO1FBlBvzESGno56jTENpawQphm9eJxpHw9C7T0zXa5x6P
         zZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755721400; x=1756326200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xar26Fk7Vgh0oRtfSyJq7JbIEeQDQwbrb9OyTQGXg9c=;
        b=Zk18ZTzIhUkff03zrdbjfsTiv9AN2dZH6yatp+xasy8t+Tov7TwLUsAhWcLQOhBhE8
         RTjvyda2Pnq5T9uElX6qW9NrGTuNJ6kIo4UzA93B7eo8bzIBjLd3dAQevVQGuqY9AM6X
         R3DUsOwtpgdSl9Mi5bK15HnffE0ZmodGUW9iBnt9jG9892e1hXaeOglz35VJ5LKQ/eFo
         gFWKAuu6aan2petiDCFyFVfVWVZv1/p8u2J/WMwmIsgLwqbXL+mrGtLS0fVaK/dC/R4g
         AZC5RrlX4cuBNYcv02BMJLSAkFhKvKpr/lJXAwwJnvCRRUl9KnaY0L82ie+YKIg0g+c6
         2cFg==
X-Forwarded-Encrypted: i=1; AJvYcCUQPkxyGMpjgTpR2SKs/yun98HrSAWYGlj+2S2Suqxf0lVZU/Th+mFDtpDadR9yx4Z01/yOFvomRCcr4XGp@vger.kernel.org, AJvYcCX5rlqqrsK9K3S6dwVSwZpH7CNaujyH6YjcH/bUnHnQYv2RCk+R32GNwpZNKfv/jqO95Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+BlND9GBxZb/LwFkUwn+qsQ0UrThQ2FU2ByiJxG+2TnHJfY5
	2wZJcGFSDVGes65Fd1yLLxZEu/iXRbugN838jSDs15DDZE3/O7b/vM2gt8NZyK+Vd7YWsT18tYU
	iRqRioevABYUGVQLPfjo1eiauVL44Ze0=
X-Gm-Gg: ASbGncv9aA/zh1fjLwTWaJYyCONvLwsoDEiDRK1xthBYERoSuU2fUWzutIexbuSR76/
	XUDiiHuFK8dNWE6N8rYl5a712KirZuWZfo6qxtTr8qnrErJc+0hSRjgw/B6K76zGEX8gZKXLBzr
	xhKfi6L5+NSFIGYjwbzr7BTB3B314qbGOPCWDpc4QyxyS9du40viwkvQkgfTFz5+KQ72e4nQN1C
	6ddADi8uaJzUX38TJESF+loltOeN8zFqg==
X-Google-Smtp-Source: AGHT+IG/o+jqEz7MRGxhpE50JuhTkZh+GVplyCSf3EZMyZt5fBnjWyasiEEWrfzosT4slxa39kM963FxIztoBJRv9qw=
X-Received: by 2002:a17:90b:2b48:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-324ed1bf522mr209863a91.17.1755721400194; Wed, 20 Aug 2025
 13:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev> <20250818170136.209169-11-roman.gushchin@linux.dev>
In-Reply-To: <20250818170136.209169-11-roman.gushchin@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 13:23:05 -0700
X-Gm-Features: Ac12FXwezbVvL0viCZVuAjNFUFHCHczXXpW3UtjzCHu_V1oLZOOrYvMnXKpxRX4
Message-ID: <CAEf4BzZL+W0AYcr_+6oeV4+uOjam9hFSneCux93GnNRPdyqapA@mail.gmail.com>
Subject: Re: [PATCH v1 10/14] bpf: selftests: bpf OOM handler test
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:05=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Implement a pseudo-realistic test for the OOM handling
> functionality.
>
> The OOM handling policy which is implemented in bpf is to
> kill all tasks belonging to the biggest leaf cgroup, which
> doesn't contain unkillable tasks (tasks with oom_score_adj
> set to -1000). Pagecache size is excluded from the accounting.
>
> The test creates a hierarchy of memory cgroups, causes an
> OOM at the top level, checks that the expected process will be
> killed and checks memcg's oom statistics.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/test_oom.c       | 229 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_oom.c  | 108 +++++++++
>  2 files changed, 337 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_oom.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom.c b/tools/te=
sting/selftests/bpf/prog_tests/test_oom.c
> new file mode 100644
> index 000000000000..eaeb14a9d18f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_oom.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include <bpf/bpf.h>
> +
> +#include "cgroup_helpers.h"
> +#include "test_oom.skel.h"
> +
> +struct cgroup_desc {
> +       const char *path;
> +       int fd;
> +       unsigned long long id;
> +       int pid;
> +       size_t target;
> +       size_t max;
> +       int oom_score_adj;
> +       bool victim;
> +};
> +
> +#define MB (1024 * 1024)
> +#define OOM_SCORE_ADJ_MIN      (-1000)
> +#define OOM_SCORE_ADJ_MAX      1000
> +
> +static struct cgroup_desc cgroups[] =3D {
> +       { .path =3D "/oom_test", .max =3D 80 * MB},
> +       { .path =3D "/oom_test/cg1", .target =3D 10 * MB,
> +         .oom_score_adj =3D OOM_SCORE_ADJ_MAX },
> +       { .path =3D "/oom_test/cg2", .target =3D 40 * MB,
> +         .oom_score_adj =3D OOM_SCORE_ADJ_MIN },
> +       { .path =3D "/oom_test/cg3" },
> +       { .path =3D "/oom_test/cg3/cg4", .target =3D 30 * MB,
> +         .victim =3D true },
> +       { .path =3D "/oom_test/cg3/cg5", .target =3D 20 * MB },
> +};
> +
> +static int spawn_task(struct cgroup_desc *desc)
> +{
> +       char *ptr;
> +       int pid;
> +
> +       pid =3D fork();
> +       if (pid < 0)
> +               return pid;
> +
> +       if (pid > 0) {
> +               /* parent */
> +               desc->pid =3D pid;
> +               return 0;
> +       }
> +
> +       /* child */
> +       if (desc->oom_score_adj) {
> +               char buf[64];
> +               int fd =3D open("/proc/self/oom_score_adj", O_WRONLY);
> +
> +               if (fd < 0)
> +                       return -1;
> +
> +               snprintf(buf, sizeof(buf), "%d", desc->oom_score_adj);
> +               write(fd, buf, sizeof(buf));
> +               close(fd);
> +       }
> +
> +       ptr =3D (char *)malloc(desc->target);
> +       if (!ptr)
> +               return -ENOMEM;
> +
> +       memset(ptr, 'a', desc->target);
> +
> +       while (1)
> +               sleep(1000);
> +
> +       return 0;
> +}
> +
> +static void setup_environment(void)
> +{
> +       int i, err;
> +
> +       err =3D setup_cgroup_environment();
> +       if (!ASSERT_OK(err, "setup_cgroup_environment"))
> +               goto cleanup;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(cgroups); i++) {
> +               cgroups[i].fd =3D create_and_get_cgroup(cgroups[i].path);
> +               if (!ASSERT_GE(cgroups[i].fd, 0, "create_and_get_cgroup")=
)
> +                       goto cleanup;
> +
> +               cgroups[i].id =3D get_cgroup_id(cgroups[i].path);
> +               if (!ASSERT_GT(cgroups[i].id, 0, "get_cgroup_id"))
> +                       goto cleanup;
> +
> +               /* Freeze the top-level cgroup */
> +               if (i =3D=3D 0) {
> +                       /* Freeze the top-level cgroup */
> +                       err =3D write_cgroup_file(cgroups[i].path, "cgrou=
p.freeze", "1");
> +                       if (!ASSERT_OK(err, "freeze cgroup"))
> +                               goto cleanup;
> +               }
> +
> +               /* Recursively enable the memory controller */
> +               if (!cgroups[i].target) {
> +
> +                       err =3D write_cgroup_file(cgroups[i].path, "cgrou=
p.subtree_control",
> +                                               "+memory");
> +                       if (!ASSERT_OK(err, "enable memory controller"))
> +                               goto cleanup;
> +               }
> +
> +               /* Set memory.max */
> +               if (cgroups[i].max) {
> +                       char buf[256];
> +
> +                       snprintf(buf, sizeof(buf), "%lu", cgroups[i].max)=
;
> +                       err =3D write_cgroup_file(cgroups[i].path, "memor=
y.max", buf);
> +                       if (!ASSERT_OK(err, "set memory.max"))
> +                               goto cleanup;
> +
> +                       snprintf(buf, sizeof(buf), "0");
> +                       write_cgroup_file(cgroups[i].path, "memory.swap.m=
ax", buf);
> +
> +               }
> +
> +               /* Spawn tasks creating memory pressure */
> +               if (cgroups[i].target) {
> +                       char buf[256];
> +
> +                       err =3D spawn_task(&cgroups[i]);
> +                       if (!ASSERT_OK(err, "spawn task"))
> +                               goto cleanup;
> +
> +                       snprintf(buf, sizeof(buf), "%d", cgroups[i].pid);
> +                       err =3D write_cgroup_file(cgroups[i].path, "cgrou=
p.procs", buf);
> +                       if (!ASSERT_OK(err, "put child into a cgroup"))
> +                               goto cleanup;
> +               }
> +       }
> +
> +       return;
> +
> +cleanup:
> +       cleanup_cgroup_environment();
> +}
> +
> +static int run_and_wait_for_oom(void)
> +{
> +       int ret =3D -1;
> +       bool first =3D true;
> +       char buf[4096] =3D {};
> +       size_t size;
> +
> +       /* Unfreeze the top-level cgroup */
> +       ret =3D write_cgroup_file(cgroups[0].path, "cgroup.freeze", "0");
> +       if (!ASSERT_OK(ret, "freeze cgroup"))
> +               return -1;
> +
> +       for (;;) {
> +               int i, status;
> +               pid_t pid =3D wait(&status);
> +
> +               if (pid =3D=3D -1) {
> +                       if (errno =3D=3D EINTR)
> +                               continue;
> +                       /* ECHILD */
> +                       break;
> +               }
> +
> +               if (!first)
> +                       continue;
> +
> +               first =3D false;
> +
> +               /* Check which process was terminated first */
> +               for (i =3D 0; i < ARRAY_SIZE(cgroups); i++) {
> +                       if (!ASSERT_OK(cgroups[i].victim !=3D
> +                                      (pid =3D=3D cgroups[i].pid),
> +                                      "correct process was killed")) {
> +                               ret =3D -1;
> +                               break;
> +                       }
> +
> +                       if (!cgroups[i].victim)
> +                               continue;
> +
> +                       /* Check the memcg oom counter */
> +                       size =3D read_cgroup_file(cgroups[i].path,
> +                                               "memory.events",
> +                                               buf, sizeof(buf));
> +                       if (!ASSERT_OK(size <=3D 0, "read memory.events")=
) {
> +                               ret =3D -1;
> +                               break;
> +                       }
> +
> +                       if (!ASSERT_OK(strstr(buf, "oom_kill 1") =3D=3D N=
ULL,
> +                                      "oom_kill count check")) {
> +                               ret =3D -1;
> +                               break;
> +                       }
> +               }
> +
> +               /* Kill all remaining tasks */
> +               for (i =3D 0; i < ARRAY_SIZE(cgroups); i++)
> +                       if (cgroups[i].pid && cgroups[i].pid !=3D pid)
> +                               kill(cgroups[i].pid, SIGKILL);
> +       }
> +
> +       return ret;
> +}
> +
> +void test_oom(void)
> +{
> +       struct test_oom *skel;
> +       int err;
> +
> +       setup_environment();
> +
> +       skel =3D test_oom__open_and_load();
> +       err =3D test_oom__attach(skel);
> +       if (CHECK_FAIL(err))
> +               goto cleanup;
> +
> +       /* Unfreeze all child tasks and create the memory pressure */
> +       err =3D run_and_wait_for_oom();
> +       CHECK_FAIL(err);
> +
> +cleanup:
> +       cleanup_cgroup_environment();
> +       test_oom__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_oom.c b/tools/testing=
/selftests/bpf/progs/test_oom.c
> new file mode 100644
> index 000000000000..ca83563fc9a8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_oom.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +#define OOM_SCORE_ADJ_MIN      (-1000)
> +
> +void bpf_rcu_read_lock(void) __ksym;
> +void bpf_rcu_read_unlock(void) __ksym;
> +struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
> +void bpf_task_release(struct task_struct *p) __ksym;
> +struct mem_cgroup *bpf_get_root_mem_cgroup(void) __ksym;
> +struct mem_cgroup *bpf_get_mem_cgroup(struct cgroup_subsys_state *css) _=
_ksym;
> +void bpf_put_mem_cgroup(struct mem_cgroup *memcg) __ksym;
> +int bpf_oom_kill_process(struct oom_control *oc, struct task_struct *tas=
k,
> +                        const char *message__str) __ksym;

These declarations should come from vmlinux.h, if you don't get them,
you might not have recent enough pahole.

At the very least these should all be __ksym __weak, not just __ksym
(but I'd rather not add them, though).

[...]

