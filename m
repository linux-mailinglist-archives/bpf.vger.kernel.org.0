Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF74F13B656
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 01:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAOAH0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 19:07:26 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43604 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgAOAH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 19:07:26 -0500
Received: by mail-qv1-f68.google.com with SMTP id p2so6586397qvo.10
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 16:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZ5TQTHLvBkgSIMFSTGordril+XRjdslLwpU0/v7Tfc=;
        b=WWoKmxhgH/uDProYawLk1xRPeugymorJi51Cyt3zSfDvkx96ZW57PseV2Qu4bihoeZ
         ClkydzBstqq252huOlSmTF2lHHJUx98SMZUKrpNDlEhmEOkCAZbhSwhrGAX/IV0x4nSD
         +5ihFo9aicfO14y5cOZPpUhFuyINt2PTnvWbY0kv74qRhGcV+Dh6MtdV6DY9Llb9iFv+
         9JaFHCnzuQ4i2er//TjB78gxZAMidc5xNBZFHKh3IgJDBBBDp7cHxZEkFsCAXkVHSlqN
         hRdWJSHgzH7MSGqvwOHntEGhdCcsFO8M/5366Ls3cLKUtRiZuGEKBZD/sYTpvxkMDj+F
         gP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZ5TQTHLvBkgSIMFSTGordril+XRjdslLwpU0/v7Tfc=;
        b=Sy+MhYeLZC71TTmvfNdCTc6KmcRocVNAb0TIXsFKHjT3KGWSri7l74Ly3j6shT7m9i
         fMG0rSyB+7Sq0VUlckFXoY2hpfatPrBjopMMxSkWoVVw5u5zarmW82rCx+WMm8a6kVQt
         9/xY5KHwqodGeqvBUcDYjryHhsslhIWqYw7pPi5/lYPhhyObbyXWb6L4ndmbd6xq2ZoS
         k0eRD5JoxMNlXarwBu/MUjgmLMxyKKWtK2yld1qM731ntbe6d39S1I6WJbvvlhWoXGfk
         H/rJoX7AR41zb164zuuQscAL5ftUFUAdJOixtamswNP92KfNGgnr1IZXO6uJaQVRxY1b
         hAWA==
X-Gm-Message-State: APjAAAXDtOYHVBMWcF5FZvqDidMakrm4kZG7msqyRVPAbyt6zKv3P4rE
        tfElbFW6nZ0VK/2sJi1rJ32tFV/OGQbpgMHElgEXJg==
X-Google-Smtp-Source: APXvYqwdXQKVv9PLKW6dYLt4/H79UJrNfyW2ldPIL6L0643hQk9YMCigdvjZGLaFmVoW0iYpQCi6v05sIhaVwKqQVso=
X-Received: by 2002:ad4:514e:: with SMTP id g14mr19593105qvq.196.1579046844467;
 Tue, 14 Jan 2020 16:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20200114211143.3201505-1-yhs@fb.com> <20200114211145.3201733-1-yhs@fb.com>
In-Reply-To: <20200114211145.3201733-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Jan 2020 16:07:13 -0800
Message-ID: <CAEf4BzaOwdx8BapMG+dd=_Fz2tpn_KJE4yOGuKVo_7sbFFM13w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] tools/bpf: add self tests for bpf_send_signal_thread()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 14, 2020 at 1:12 PM Yonghong Song <yhs@fb.com> wrote:
>
> The test_progs send_signal() is amended to test
> bpf_send_signal_thread() as well.
>
>    $ ./test_progs -n 40
>    #40/1 send_signal_tracepoint:OK
>    #40/2 send_signal_perf:OK
>    #40/3 send_signal_nmi:OK
>    #40/4 send_signal_tracepoint_thread:OK
>    #40/5 send_signal_perf_thread:OK
>    #40/6 send_signal_nmi_thread:OK
>    #40 send_signal:OK
>    Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED
>
> Also took this opportunity to rewrite the send_signal test
> using skeleton framework and array mmap to make code
> simpler and more readable.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

thanks for converting, see some stuff you don't need to do with skeleton below

>  .../selftests/bpf/prog_tests/send_signal.c    | 111 ++++++++++--------
>  .../bpf/progs/test_send_signal_kern.c         |  51 ++++----
>  2 files changed, 87 insertions(+), 75 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index b607112c64e7..14ec9cf218ed 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include <sys/mman.h>
> +#include "test_send_signal_kern.skel.h"
>
>  static volatile int sigusr1_received = 0;
>
> @@ -8,18 +10,26 @@ static void sigusr1_handler(int signum)
>         sigusr1_received++;
>  }
>
> +static size_t roundup_page(size_t sz)
> +{
> +       long page_size = sysconf(_SC_PAGE_SIZE);
> +       return (sz + page_size - 1) / page_size * page_size;
> +}
> +
>  static void test_send_signal_common(struct perf_event_attr *attr,
> -                                   int prog_type,
> +                                   bool is_tp, bool signal_thread,
>                                     const char *test_name)
>  {
> -       int err = -1, pmu_fd, prog_fd, info_map_fd, status_map_fd;
> -       const char *file = "./test_send_signal_kern.o";
> -       struct bpf_object *obj = NULL;
> +       const size_t bss_sz = roundup_page(sizeof(struct test_send_signal_kern__bss));
> +       struct test_send_signal_kern__bss *bss_data;
> +       struct test_send_signal_kern *skel;
>         int pipe_c2p[2], pipe_p2c[2];
> -       __u32 key = 0, duration = 0;
> +       struct bpf_map *bss_map;
> +       void *bss_mmaped = NULL;
> +       int err = -1, pmu_fd;
> +       __u32 duration = 0;
>         char buf[256];
>         pid_t pid;
> -       __u64 val;
>
>         if (CHECK(pipe(pipe_c2p), test_name,
>                   "pipe pipe_c2p error: %s\n", strerror(errno)))
> @@ -73,45 +83,50 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>         close(pipe_c2p[1]); /* close write */
>         close(pipe_p2c[0]); /* close read */
>
> -       err = bpf_prog_load(file, prog_type, &obj, &prog_fd);
> -       if (CHECK(err < 0, test_name, "bpf_prog_load error: %s\n",
> -                 strerror(errno)))
> -               goto prog_load_failure;
> +       skel = test_send_signal_kern__open_and_load();
> +       if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n"))
> +               goto skel_open_load_failure;
> +
> +       bss_map = skel->maps.bss;
> +       bss_mmaped = mmap(NULL, bss_sz, PROT_READ | PROT_WRITE, MAP_SHARED,
> +                         bpf_map__fd(bss_map), 0);
> +       if (CHECK(bss_mmaped == MAP_FAILED, "bss_mmap",
> +                 ".bss mmap failed: %d\n", errno)) {
> +               bss_mmaped = NULL;
> +               goto destroy_skel;
> +       }
> +
> +       bss_data = bss_mmaped;

You don't need to mmap() manually, it's all done automatically as part
of loading skeleton. Just use skel->bss->{pid,sig,signal_thread}
directly.

>
>         pmu_fd = syscall(__NR_perf_event_open, attr, pid, -1,
>                          -1 /* group id */, 0 /* flags */);
>         if (CHECK(pmu_fd < 0, test_name, "perf_event_open error: %s\n",
>                   strerror(errno))) {
>                 err = -1;
> -               goto close_prog;
> +               goto destroy_skel;
>         }
>
> -       err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
> -       if (CHECK(err < 0, test_name, "ioctl perf_event_ioc_enable error: %s\n",
> -                 strerror(errno)))
> -               goto disable_pmu;
> -
> -       err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
> -       if (CHECK(err < 0, test_name, "ioctl perf_event_ioc_set_bpf error: %s\n",
> -                 strerror(errno)))
> -               goto disable_pmu;
> -
> -       err = -1;
> -       info_map_fd = bpf_object__find_map_fd_by_name(obj, "info_map");
> -       if (CHECK(info_map_fd < 0, test_name, "find map %s error\n", "info_map"))
> -               goto disable_pmu;
> -
> -       status_map_fd = bpf_object__find_map_fd_by_name(obj, "status_map");
> -       if (CHECK(status_map_fd < 0, test_name, "find map %s error\n", "status_map"))
> -               goto disable_pmu;
> +       if (is_tp) {
> +               skel->links.send_signal_tp =
> +                       bpf_program__attach_perf_event(skel->progs.send_signal_tp, pmu_fd);
> +               if (CHECK(IS_ERR(skel->links.send_signal_tp), "attach_perf_event",
> +                       "err %ld\n", PTR_ERR(skel->links.send_signal_tp)))
> +                       goto disable_pmu;

tracepoint handler should be loaded automatically, so here you'll be
leaking already create bpf_link and creating a new one.

> +       } else {
> +               skel->links.send_signal_perf =
> +                       bpf_program__attach_perf_event(skel->progs.send_signal_perf, pmu_fd);
> +               if (CHECK(IS_ERR(skel->links.send_signal_perf), "attach_perf_event",
> +                       "err %ld\n", PTR_ERR(skel->links.send_signal_perf)))
> +                       goto disable_pmu;
> +       }
>
>         /* wait until child signal handler installed */
>         read(pipe_c2p[0], buf, 1);
>
>         /* trigger the bpf send_signal */
> -       key = 0;
> -       val = (((__u64)(SIGUSR1)) << 32) | pid;
> -       bpf_map_update_elem(info_map_fd, &key, &val, 0);
> +       bss_data->pid = pid;
> +       bss_data->sig = SIGUSR1;
> +       bss_data->signal_thread = signal_thread;
>
>         /* notify child that bpf program can send_signal now */
>         write(pipe_p2c[1], buf, 1);
> @@ -132,15 +147,15 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>
>  disable_pmu:
>         close(pmu_fd);
> -close_prog:
> -       bpf_object__close(obj);
> -prog_load_failure:
> +destroy_skel:
> +       test_send_signal_kern__destroy(skel);
> +skel_open_load_failure:
>         close(pipe_c2p[0]);
>         close(pipe_p2c[1]);
>         wait(NULL);
>  }
>
> -static void test_send_signal_tracepoint(void)
> +static void test_send_signal_tracepoint(bool signal_thread)
>  {
>         const char *id_path = "/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id";

You probably don't need this as well, because tracepoint BPF programs
should be auto-attached.

>         struct perf_event_attr attr = {
> @@ -168,10 +183,10 @@ static void test_send_signal_tracepoint(void)
>
>         attr.config = strtol(buf, NULL, 0);
>
> -       test_send_signal_common(&attr, BPF_PROG_TYPE_TRACEPOINT, "tracepoint");
> +       test_send_signal_common(&attr, true, signal_thread, "tracepoint");
>  }
>

[...]
