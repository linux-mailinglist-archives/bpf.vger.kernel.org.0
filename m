Return-Path: <bpf+bounces-12786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB67D06A1
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 04:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DDE281425
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 02:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B115811;
	Fri, 20 Oct 2023 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci-edu.20230601.gappssmtp.com header.i=@uci-edu.20230601.gappssmtp.com header.b="nW4HlEUT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E602A20
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 02:50:49 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2BE12D
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:50:46 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b625ed7208so166067241.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci-edu.20230601.gappssmtp.com; s=20230601; t=1697770246; x=1698375046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDwGFRb6s4YhaPA5Fm7vRZkpBMQMj4IOjCNDfe+XgPY=;
        b=nW4HlEUTR2T0eQ/KnONKpOoWMPd9cMF0KYYExlomKvVL2Nna5u7MMw/UvvUbYNKLtT
         4FC3gIOjYXdjgB6gmewFA8CpRe2LkPYpbOesSm2dX10MXS0hfQH2eRpcee8Ry7zF48j7
         TZafdGM6ySn2AuKIQtm3K5DTCQ7eNAGbxJYPXveLN0FEz6jX/xMpz1aPbN3xwRDRfBAI
         /hrcC4WW/C8THeCgeWNJ9i4DIjBJCXYTnqND5XKRxenBIZCSgIcgzxk9hZ1yl5seynLV
         iLpwy8J44cTXf4Sm3SXMCOrVEiwjs8zKO4OL3Gtj9vohtpVskGoxq+GhvroSnJ3UZ2CN
         7seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697770246; x=1698375046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDwGFRb6s4YhaPA5Fm7vRZkpBMQMj4IOjCNDfe+XgPY=;
        b=Oztnph8WwB9rfnrXjYSSqZ9qECtTg2MKlKBh6wHao+0+0DefuRzri8et4961+Gu6TL
         pJm8zAYkH6fKPW281ZqD4ok/uFzzp+DJ6vMq9hPs9tnJlgebzZs9cLTj/+Zqa4ES8bIz
         ihq/XHo16AUmdIAq2PwCXCjcaD8Pzfd8Se8xNqZG4zCL4mAYlmWlro0BQirsog1GN8rh
         u+Irb4PdW4n7bAU/2zF6lhKo41EudwVfceHgxnqirWKB/DZ9V9IClsYEBxckz+uKY+2D
         yPuPyTE2gzq2mjJYSWsFStkB2qD9F7cIZ09JU1dbrw81i4AVMx4FqHqcB/BfkMtm9sf2
         VXig==
X-Gm-Message-State: AOJu0YzalK7EHWSJj9ktd7i1UpWgYFd9rfJrzkRbYAe5Qn1FHv/7zQ8L
	zUZaFAjLqpOhRvMauFUJu/P8iOVrOESC281tiD+DhQ==
X-Google-Smtp-Source: AGHT+IGjrWjOrAU4NxROk7rPHSyxkbv0daZmdbqpFqGc4TloExXu1ng+yLtgSqn/alc3Mz5GkzI8/aOY3qX8VErGoV8=
X-Received: by 2002:a67:e050:0:b0:457:e32d:1732 with SMTP id
 n16-20020a67e050000000b00457e32d1732mr734619vsl.4.1697770245815; Thu, 19 Oct
 2023 19:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020014214.2471419-1-houtao@huaweicloud.com> <20231020014214.2471419-3-houtao@huaweicloud.com>
In-Reply-To: <20231020014214.2471419-3-houtao@huaweicloud.com>
From: Hsin-Wei Hung <hsinweih@uci.edu>
Date: Thu, 19 Oct 2023 19:50:09 -0700
Message-ID: <CABcoxUYdAxUuMp=YtfrqvHsF==yHkCBSbrVDu3uzVkizbSH9OA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test race between map uref
 release and bpf timer init
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 6:41=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Test race between the release of map ref and bpf_timer_init():
> 1) create one thread to add array map with bpf_timer into array of
>    arrays map repeatedly.
> 2) create another thread to call getpgid() and call bpf_timer_init()
>    in the attached bpf program repeatedly.
> 3) synchronize these two threads through pthread barrier.
>
> It is a bit hard to trigger the kmemleak by only running the test. I
> managed to reproduce the kmemleak by injecting a delay between
> t->timer.function =3D bpf_timer_cb and timer->timer =3D t in
> bpf_timer_init().

I figured out that to trigger this issue reliably, I can insert
different delays using large bpf_loop() in allocation and release
paths. I have some extra code to filter out unwanted events. The
userspace program is similar. It just needs to try to call close(fd)
and syscall(SYS_getpgid) at the same time without delay. It is not a
stable test though due to the reference to the function.

SEC("tp/syscalls/sys_enter_close")
{
        ...
        bpf_loop(1000000, &delay_loop, NULL, 0);
}

SEC("fexit/bpf_map_kmalloc_node")gmai
{
        ...
        bpf_loop(2000000, &delay_loop, NULL, 0);
}

I can confirm that the v1 patch fixes memleak in v5.15. However, this
issue doesn't seem to affect net-next. At least since db559117828d
(bpf: Consolidate spin_lock, timer management into btf_record), the
leaked memory caused by the race would be freed in array_map_free().

>
> The following is the output of kmemleak after reproducing:
>
> unreferenced object 0xffff8881163d3780 (size 96):
>   comm "test_progs", pid 539, jiffies 4295358164 (age 23.276s)
>   hex dump (first 32 bytes):
>     80 37 3d 16 81 88 ff ff 00 00 00 00 00 00 00 00  .7=3D.............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000bbc3f059>] __kmem_cache_alloc_node+0x3b1/0x4a0
>     [<00000000a24ddf4d>] __kmalloc_node+0x57/0x140
>     [<000000004d577dbf>] bpf_map_kmalloc_node+0x5f/0x180
>     [<00000000bd8428d3>] bpf_timer_init+0xf6/0x1b0
>     [<0000000086d87323>] 0xffffffffc000c94e
>     [<000000005a09e655>] trace_call_bpf+0xc5/0x1c0
>     [<0000000051ab837b>] kprobe_perf_func+0x51/0x260
>     [<000000000069bbd1>] kprobe_dispatcher+0x61/0x70
>     [<000000007dceb75b>] kprobe_ftrace_handler+0x168/0x240
>     [<00000000d8721bd7>] 0xffffffffc02010f7
>     [<00000000e885b809>] __x64_sys_getpgid+0x1/0x20
>     [<000000007be835d8>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  .../bpf/prog_tests/timer_init_race.c          | 138 ++++++++++++++++++
>  .../selftests/bpf/progs/timer_init_race.c     |  56 +++++++
>  2 files changed, 194 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_init_rac=
e.c
>  create mode 100644 tools/testing/selftests/bpf/progs/timer_init_race.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/timer_init_race.c b/t=
ools/testing/selftests/bpf/prog_tests/timer_init_race.c
> new file mode 100644
> index 0000000000000..7bd57459e5048
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/timer_init_race.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "timer_init_race.skel.h"
> +
> +struct thread_ctx {
> +       struct bpf_map_create_opts opts;
> +       pthread_barrier_t barrier;
> +       int outer_map_fd;
> +       int start, abort;
> +       int loop, err;
> +};
> +
> +static int wait_for_start_or_abort(struct thread_ctx *ctx)
> +{
> +       while (!ctx->start && !ctx->abort)
> +               usleep(1);
> +       return ctx->abort ? -1 : 0;
> +}
> +
> +static void *close_map_fn(void *data)
> +{
> +       struct thread_ctx *ctx =3D data;
> +       int loop =3D ctx->loop, err =3D 0;
> +
> +       if (wait_for_start_or_abort(ctx) < 0)
> +               return NULL;
> +
> +       while (loop-- > 0) {
> +               int fd, zero =3D 0, i;
> +               volatile int s =3D 0;
> +
> +               fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, sizeof=
(struct bpf_timer),
> +                                   1, &ctx->opts);
> +               if (fd < 0) {
> +                       err |=3D 1;
> +                       pthread_barrier_wait(&ctx->barrier);
> +                       continue;
> +               }
> +
> +               if (bpf_map_update_elem(ctx->outer_map_fd, &zero, &fd, 0)=
 < 0)
> +                       err |=3D 2;
> +
> +               pthread_barrier_wait(&ctx->barrier);
> +               /* let bpf_timer_init run first */
> +               for (i =3D 0; i < 5000; i++)
> +                       s++;
> +               close(fd);
> +       }
> +
> +       ctx->err =3D err;
> +
> +       return NULL;
> +}
> +
> +static void *init_timer_fn(void *data)
> +{
> +       struct thread_ctx *ctx =3D data;
> +       int loop =3D ctx->loop;
> +
> +       if (wait_for_start_or_abort(ctx) < 0)
> +               return NULL;
> +
> +       while (loop-- > 0) {
> +               pthread_barrier_wait(&ctx->barrier);
> +               syscall(SYS_getpgid);
> +       }
> +
> +       return NULL;
> +}
> +
> +void test_timer_init_race(void)
> +{
> +       struct timer_init_race *skel;
> +       struct thread_ctx ctx;
> +       pthread_t tid[2];
> +       struct btf *btf;
> +       int err;
> +
> +       skel =3D timer_init_race__open();
> +       if (!ASSERT_OK_PTR(skel, "timer_init_race open"))
> +               return;
> +
> +       err =3D timer_init_race__load(skel);
> +       if (!ASSERT_EQ(err, 0, "timer_init_race load"))
> +               goto out;
> +
> +       memset(&ctx, 0, sizeof(ctx));
> +
> +       btf =3D bpf_object__btf(skel->obj);
> +       if (!ASSERT_OK_PTR(btf, "timer_init_race btf"))
> +               goto out;
> +
> +       LIBBPF_OPTS_RESET(ctx.opts);
> +       ctx.opts.btf_fd =3D bpf_object__btf_fd(skel->obj);
> +       if (!ASSERT_GE((int)ctx.opts.btf_fd, 0, "btf_fd"))
> +               goto out;
> +       ctx.opts.btf_key_type_id =3D btf__find_by_name(btf, "int");
> +       if (!ASSERT_GT(ctx.opts.btf_key_type_id, 0, "key_type_id"))
> +               goto out;
> +       ctx.opts.btf_value_type_id =3D btf__find_by_name_kind(btf, "inner=
_value", BTF_KIND_STRUCT);
> +       if (!ASSERT_GT(ctx.opts.btf_value_type_id, 0, "value_type_id"))
> +               goto out;
> +
> +       err =3D timer_init_race__attach(skel);
> +       if (!ASSERT_EQ(err, 0, "timer_init_race attach"))
> +               goto out;
> +
> +       skel->bss->tgid =3D getpid();
> +
> +       pthread_barrier_init(&ctx.barrier, NULL, 2);
> +       ctx.outer_map_fd =3D bpf_map__fd(skel->maps.outer_map);
> +       ctx.loop =3D 8;
> +
> +       err =3D pthread_create(&tid[0], NULL, close_map_fn, &ctx);
> +       if (!ASSERT_OK(err, "close_thread"))
> +               goto out;
> +
> +       err =3D pthread_create(&tid[1], NULL, init_timer_fn, &ctx);
> +       if (!ASSERT_OK(err, "init_thread")) {
> +               ctx.abort =3D 1;
> +               pthread_join(tid[0], NULL);
> +               goto out;
> +       }
> +
> +       ctx.start =3D 1;
> +       pthread_join(tid[0], NULL);
> +       pthread_join(tid[1], NULL);
> +
> +       ASSERT_EQ(ctx.err, 0, "error");
> +       ASSERT_EQ(skel->bss->cnt, 8, "cnt");
> +out:
> +       timer_init_race__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/timer_init_race.c b/tools/=
testing/selftests/bpf/progs/timer_init_race.c
> new file mode 100644
> index 0000000000000..ba67cb1786399
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/timer_init_race.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
> +#include <linux/bpf.h>
> +#include <time.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include "bpf_misc.h"
> +
> +struct inner_value {
> +       struct bpf_timer timer;
> +};
> +
> +struct inner_map_type {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __type(key, int);
> +       __type(value, struct inner_value);
> +       __uint(max_entries, 1);
> +} inner_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +       __type(key, int);
> +       __type(value, int);
> +       __uint(max_entries, 1);
> +       __array(values, struct inner_map_type);
> +} outer_map SEC(".maps") =3D {
> +       .values =3D {
> +               [0] =3D &inner_map,
> +       },
> +};
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int tgid =3D 0, cnt =3D 0;
> +
> +SEC("kprobe/" SYS_PREFIX "sys_getpgid")
> +int do_timer_init(void *ctx)
> +{
> +       struct inner_map_type *map;
> +       struct inner_value *value;
> +       int zero =3D 0;
> +
> +       if ((bpf_get_current_pid_tgid() >> 32) !=3D tgid)
> +               return 0;
> +
> +       map =3D bpf_map_lookup_elem(&outer_map, &zero);
> +       if (!map)
> +               return 0;
> +       value =3D bpf_map_lookup_elem(map, &zero);
> +       if (!value)
> +               return 0;
> +       bpf_timer_init(&value->timer, map, CLOCK_MONOTONIC);
> +       cnt++;
> +
> +       return 0;
> +}
> --
> 2.29.2
>

