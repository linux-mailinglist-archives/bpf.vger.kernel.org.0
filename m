Return-Path: <bpf+bounces-66134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B91FB2E955
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 02:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAB65E0CA8
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB881E5B64;
	Thu, 21 Aug 2025 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vc3VbYFJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D191D5170
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755735032; cv=none; b=jbAZmat2HzmKQXZjqNkySsvC9ncIaLn35K6I5yC7U0G4HL4YpiJw2VQ6mLhWcMMIz2kF6tYMp84awuCl9kpMcAeHXe7ClGkhTAIeNGM66e59tbN8v1v5FDkvBrz3oDMqry+Cudi7/Rq+Snq/PqujFFuoXu8p2zzStA5t615YMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755735032; c=relaxed/simple;
	bh=T+dPJnLznZuircGeJuG5Y87zq5rCVPzvpeoAKQgd8zQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MyjQTEgNETuE2wQXYLKJgtQ8tngEbsAw1wJjrR1nD4/Wl0VXElgH6m2c/ct5/J5cDYCY19biu2M7C3DK1ZWQrM/Lg6kUPB94QWTHuXY/kWzu5UPGqubWiqIN8PhiVy1SN3VoEzp4XhiGNOSMdVHL4e5dnamKwJD+BuePY0S2+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vc3VbYFJ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755735026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlqBJgiy8ZrhCjThgHLZ6QTjjE0fi9lihZzSHbRGkrk=;
	b=Vc3VbYFJWq9UVKjE5ENOl+s4vSDnLXkPqurSxWGKhwqI232XZOefnBwWGLD0P9tRuh0ipM
	XeS5H23p80tD7x8yrOpRGzBlMyNlf5kT6Me9zvtZ62U18mcNX985O8L1rXVq4nLN4AsqwN
	E86HjhL1B/wDuxzYp5Pwdq7xSzheqHI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko
 <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/14] bpf: selftests: bpf OOM handler test
In-Reply-To: <CAEf4BzZL+W0AYcr_+6oeV4+uOjam9hFSneCux93GnNRPdyqapA@mail.gmail.com>
	(Andrii Nakryiko's message of "Wed, 20 Aug 2025 13:23:05 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-11-roman.gushchin@linux.dev>
	<CAEf4BzZL+W0AYcr_+6oeV4+uOjam9hFSneCux93GnNRPdyqapA@mail.gmail.com>
Date: Wed, 20 Aug 2025 17:10:18 -0700
Message-ID: <874iu1mt5h.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Aug 18, 2025 at 10:05=E2=80=AFAM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> Implement a pseudo-realistic test for the OOM handling
>> functionality.
>>
>> The OOM handling policy which is implemented in bpf is to
>> kill all tasks belonging to the biggest leaf cgroup, which
>> doesn't contain unkillable tasks (tasks with oom_score_adj
>> set to -1000). Pagecache size is excluded from the accounting.
>>
>> The test creates a hierarchy of memory cgroups, causes an
>> OOM at the top level, checks that the expected process will be
>> killed and checks memcg's oom statistics.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  .../selftests/bpf/prog_tests/test_oom.c       | 229 ++++++++++++++++++
>>  tools/testing/selftests/bpf/progs/test_oom.c  | 108 +++++++++
>>  2 files changed, 337 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_oom.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom.c b/tools/t=
esting/selftests/bpf/prog_tests/test_oom.c
>> new file mode 100644
>> index 000000000000..eaeb14a9d18f
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_oom.c
>> @@ -0,0 +1,229 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <test_progs.h>
>> +#include <bpf/btf.h>
>> +#include <bpf/bpf.h>
>> +
>> +#include "cgroup_helpers.h"
>> +#include "test_oom.skel.h"
>> +
>> +struct cgroup_desc {
>> +       const char *path;
>> +       int fd;
>> +       unsigned long long id;
>> +       int pid;
>> +       size_t target;
>> +       size_t max;
>> +       int oom_score_adj;
>> +       bool victim;
>> +};
>> +
>> +#define MB (1024 * 1024)
>> +#define OOM_SCORE_ADJ_MIN      (-1000)
>> +#define OOM_SCORE_ADJ_MAX      1000
>> +
>> +static struct cgroup_desc cgroups[] =3D {
>> +       { .path =3D "/oom_test", .max =3D 80 * MB},
>> +       { .path =3D "/oom_test/cg1", .target =3D 10 * MB,
>> +         .oom_score_adj =3D OOM_SCORE_ADJ_MAX },
>> +       { .path =3D "/oom_test/cg2", .target =3D 40 * MB,
>> +         .oom_score_adj =3D OOM_SCORE_ADJ_MIN },
>> +       { .path =3D "/oom_test/cg3" },
>> +       { .path =3D "/oom_test/cg3/cg4", .target =3D 30 * MB,
>> +         .victim =3D true },
>> +       { .path =3D "/oom_test/cg3/cg5", .target =3D 20 * MB },
>> +};
>> +
>> +static int spawn_task(struct cgroup_desc *desc)
>> +{
>> +       char *ptr;
>> +       int pid;
>> +
>> +       pid =3D fork();
>> +       if (pid < 0)
>> +               return pid;
>> +
>> +       if (pid > 0) {
>> +               /* parent */
>> +               desc->pid =3D pid;
>> +               return 0;
>> +       }
>> +
>> +       /* child */
>> +       if (desc->oom_score_adj) {
>> +               char buf[64];
>> +               int fd =3D open("/proc/self/oom_score_adj", O_WRONLY);
>> +
>> +               if (fd < 0)
>> +                       return -1;
>> +
>> +               snprintf(buf, sizeof(buf), "%d", desc->oom_score_adj);
>> +               write(fd, buf, sizeof(buf));
>> +               close(fd);
>> +       }
>> +
>> +       ptr =3D (char *)malloc(desc->target);
>> +       if (!ptr)
>> +               return -ENOMEM;
>> +
>> +       memset(ptr, 'a', desc->target);
>> +
>> +       while (1)
>> +               sleep(1000);
>> +
>> +       return 0;
>> +}
>> +
>> +static void setup_environment(void)
>> +{
>> +       int i, err;
>> +
>> +       err =3D setup_cgroup_environment();
>> +       if (!ASSERT_OK(err, "setup_cgroup_environment"))
>> +               goto cleanup;
>> +
>> +       for (i =3D 0; i < ARRAY_SIZE(cgroups); i++) {
>> +               cgroups[i].fd =3D create_and_get_cgroup(cgroups[i].path);
>> +               if (!ASSERT_GE(cgroups[i].fd, 0, "create_and_get_cgroup"=
))
>> +                       goto cleanup;
>> +
>> +               cgroups[i].id =3D get_cgroup_id(cgroups[i].path);
>> +               if (!ASSERT_GT(cgroups[i].id, 0, "get_cgroup_id"))
>> +                       goto cleanup;
>> +
>> +               /* Freeze the top-level cgroup */
>> +               if (i =3D=3D 0) {
>> +                       /* Freeze the top-level cgroup */
>> +                       err =3D write_cgroup_file(cgroups[i].path, "cgro=
up.freeze", "1");
>> +                       if (!ASSERT_OK(err, "freeze cgroup"))
>> +                               goto cleanup;
>> +               }
>> +
>> +               /* Recursively enable the memory controller */
>> +               if (!cgroups[i].target) {
>> +
>> +                       err =3D write_cgroup_file(cgroups[i].path, "cgro=
up.subtree_control",
>> +                                               "+memory");
>> +                       if (!ASSERT_OK(err, "enable memory controller"))
>> +                               goto cleanup;
>> +               }
>> +
>> +               /* Set memory.max */
>> +               if (cgroups[i].max) {
>> +                       char buf[256];
>> +
>> +                       snprintf(buf, sizeof(buf), "%lu", cgroups[i].max=
);
>> +                       err =3D write_cgroup_file(cgroups[i].path, "memo=
ry.max", buf);
>> +                       if (!ASSERT_OK(err, "set memory.max"))
>> +                               goto cleanup;
>> +
>> +                       snprintf(buf, sizeof(buf), "0");
>> +                       write_cgroup_file(cgroups[i].path, "memory.swap.=
max", buf);
>> +
>> +               }
>> +
>> +               /* Spawn tasks creating memory pressure */
>> +               if (cgroups[i].target) {
>> +                       char buf[256];
>> +
>> +                       err =3D spawn_task(&cgroups[i]);
>> +                       if (!ASSERT_OK(err, "spawn task"))
>> +                               goto cleanup;
>> +
>> +                       snprintf(buf, sizeof(buf), "%d", cgroups[i].pid);
>> +                       err =3D write_cgroup_file(cgroups[i].path, "cgro=
up.procs", buf);
>> +                       if (!ASSERT_OK(err, "put child into a cgroup"))
>> +                               goto cleanup;
>> +               }
>> +       }
>> +
>> +       return;
>> +
>> +cleanup:
>> +       cleanup_cgroup_environment();
>> +}
>> +
>> +static int run_and_wait_for_oom(void)
>> +{
>> +       int ret =3D -1;
>> +       bool first =3D true;
>> +       char buf[4096] =3D {};
>> +       size_t size;
>> +
>> +       /* Unfreeze the top-level cgroup */
>> +       ret =3D write_cgroup_file(cgroups[0].path, "cgroup.freeze", "0");
>> +       if (!ASSERT_OK(ret, "freeze cgroup"))
>> +               return -1;
>> +
>> +       for (;;) {
>> +               int i, status;
>> +               pid_t pid =3D wait(&status);
>> +
>> +               if (pid =3D=3D -1) {
>> +                       if (errno =3D=3D EINTR)
>> +                               continue;
>> +                       /* ECHILD */
>> +                       break;
>> +               }
>> +
>> +               if (!first)
>> +                       continue;
>> +
>> +               first =3D false;
>> +
>> +               /* Check which process was terminated first */
>> +               for (i =3D 0; i < ARRAY_SIZE(cgroups); i++) {
>> +                       if (!ASSERT_OK(cgroups[i].victim !=3D
>> +                                      (pid =3D=3D cgroups[i].pid),
>> +                                      "correct process was killed")) {
>> +                               ret =3D -1;
>> +                               break;
>> +                       }
>> +
>> +                       if (!cgroups[i].victim)
>> +                               continue;
>> +
>> +                       /* Check the memcg oom counter */
>> +                       size =3D read_cgroup_file(cgroups[i].path,
>> +                                               "memory.events",
>> +                                               buf, sizeof(buf));
>> +                       if (!ASSERT_OK(size <=3D 0, "read memory.events"=
)) {
>> +                               ret =3D -1;
>> +                               break;
>> +                       }
>> +
>> +                       if (!ASSERT_OK(strstr(buf, "oom_kill 1") =3D=3D =
NULL,
>> +                                      "oom_kill count check")) {
>> +                               ret =3D -1;
>> +                               break;
>> +                       }
>> +               }
>> +
>> +               /* Kill all remaining tasks */
>> +               for (i =3D 0; i < ARRAY_SIZE(cgroups); i++)
>> +                       if (cgroups[i].pid && cgroups[i].pid !=3D pid)
>> +                               kill(cgroups[i].pid, SIGKILL);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +void test_oom(void)
>> +{
>> +       struct test_oom *skel;
>> +       int err;
>> +
>> +       setup_environment();
>> +
>> +       skel =3D test_oom__open_and_load();
>> +       err =3D test_oom__attach(skel);
>> +       if (CHECK_FAIL(err))
>> +               goto cleanup;
>> +
>> +       /* Unfreeze all child tasks and create the memory pressure */
>> +       err =3D run_and_wait_for_oom();
>> +       CHECK_FAIL(err);
>> +
>> +cleanup:
>> +       cleanup_cgroup_environment();
>> +       test_oom__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_oom.c b/tools/testin=
g/selftests/bpf/progs/test_oom.c
>> new file mode 100644
>> index 000000000000..ca83563fc9a8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_oom.c
>> @@ -0,0 +1,108 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") =3D "GPL";
>> +
>> +#define OOM_SCORE_ADJ_MIN      (-1000)
>> +
>> +void bpf_rcu_read_lock(void) __ksym;
>> +void bpf_rcu_read_unlock(void) __ksym;
>> +struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
>> +void bpf_task_release(struct task_struct *p) __ksym;
>> +struct mem_cgroup *bpf_get_root_mem_cgroup(void) __ksym;
>> +struct mem_cgroup *bpf_get_mem_cgroup(struct cgroup_subsys_state *css) =
__ksym;
>> +void bpf_put_mem_cgroup(struct mem_cgroup *memcg) __ksym;
>> +int bpf_oom_kill_process(struct oom_control *oc, struct task_struct *ta=
sk,
>> +                        const char *message__str) __ksym;
>
> These declarations should come from vmlinux.h, if you don't get them,
> you might not have recent enough pahole.

Indeed. Fixed, thanks!

