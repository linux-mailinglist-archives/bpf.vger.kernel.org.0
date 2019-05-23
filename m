Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3023274D7
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 05:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfEWDsM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 23:48:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39550 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfEWDsM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 23:48:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id y42so5135111qtk.6;
        Wed, 22 May 2019 20:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YA0Ty5wYr+L6OYmKLUsjfkNFrIDUz/CzOxfzF5aKEp8=;
        b=fzYwZSWaJZxWqAxrHH7xN1gN537Hucxi8UF4m7DxYgI+ThFN637bt1JawZXzr0CNUr
         mUWa3o6224/kQEE7+5iL2mPlu6THI+T6S7xGINGH7JYbhPevq1fNYQUy2Jdiu33RWnjG
         3q9ScUJj87qaZQCjhF8S/N0Ciif0nWR0iAp7tMqVyouSaA8bwUi8+se/SyKIeJXC+pUn
         1KsAHgt4uw0pN0an0rRWqehpeogPhXiabRSnt84w6jwqZMN0iu7PSPnQQNFH5MHf2wlv
         hTwpVubCB1dP2Ucjjer4MzIAmrN4qoMq18GML9BwdAhnH/f7T53xUEyd0Q3jhvuXIi9G
         HtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YA0Ty5wYr+L6OYmKLUsjfkNFrIDUz/CzOxfzF5aKEp8=;
        b=Tivg6oZUOe//wWWc/CbfCFMyKfrNxlc5dyLAnWZVxSpAtaTyGaAEzBJqS3OzVOS9HL
         7UV2aWHi14H2BwYAbmxCRUAlDH511MEQOcZqoVupVFP0EY2B1Jj/Mn8hdKePqArS2zpc
         oNnMUOt1T50ttsVWTbIOCVKXyE35PWe4B/qJTey78d9U71Ar5dw8Nof9tqgVjONxqcRD
         fIM5EMAV/ZHuaRquS5f66Ngc210rLryKa/ieRTo/AhtGBdjp6Uc6sp+MaDyDMUs6EGn1
         7dgTVT9cJFo6fuuNTbqvh7q7myTKu4fzguS8VPY3WsB4m2rhXV8QRYkNJdJdxXO88gWe
         NaLw==
X-Gm-Message-State: APjAAAVzxZ2APbwE9E93zEVVqBKTxpzAqMDdFqut495FSBhQICW7WcbJ
        tTe1jGFjNoWKEKPvpYbIck3jZjNBaNxKc5Kb8po=
X-Google-Smtp-Source: APXvYqx9agXjNfJLHVgdJ9nDFGc8mHSAVLpC2jUR4Ctnh1V3GkitOYwKn5yN29+72AJDY49wHea3seMg6bZoH0F3n4o=
X-Received: by 2002:ac8:30d3:: with SMTP id w19mr76268031qta.171.1558583290763;
 Wed, 22 May 2019 20:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190522231636.505712-1-yhs@fb.com> <20190522231639.506052-1-yhs@fb.com>
In-Reply-To: <20190522231639.506052-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 May 2019 20:47:59 -0700
Message-ID: <CAEf4BzZb0qAh992bpz+fSZXHXBkqCSCFpttZHKLppdCr4ouUVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] tools/bpf: add selftest in test_progs for
 bpf_send_signal() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 22, 2019 at 4:16 PM Yonghong Song <yhs@fb.com> wrote:
>
> The test covered both nmi and tracepoint perf events.
>   $ ./test_progs
>   ...
>   test_send_signal_tracepoint:PASS:tracepoint 0 nsec
>   ...
>   test_send_signal_common:PASS:tracepoint 0 nsec
>   ...
>   test_send_signal_common:PASS:perf_event 0 nsec
>   ...
>   test_send_signal:OK
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Looks good to me, just minor nits below.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/bpf_helpers.h     |   1 +
>  .../selftests/bpf/prog_tests/send_signal.c    | 193 ++++++++++++++++++
>  .../bpf/progs/test_send_signal_kern.c         |  51 +++++
>  3 files changed, 245 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/send_signal.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_send_signal_kern.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
> index 5f6f9e7aba2a..cb02521b8e58 100644
> --- a/tools/testing/selftests/bpf/bpf_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_helpers.h
> @@ -216,6 +216,7 @@ static void *(*bpf_sk_storage_get)(void *map, struct bpf_sock *sk,
>         (void *) BPF_FUNC_sk_storage_get;
>  static int (*bpf_sk_storage_delete)(void *map, struct bpf_sock *sk) =
>         (void *)BPF_FUNC_sk_storage_delete;
> +static int (*bpf_send_signal)(unsigned sig) = (void *)BPF_FUNC_send_signal;
>
>  /* llvm builtin functions that eBPF C program may use to
>   * emit BPF_LD_ABS and BPF_LD_IND instructions
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> new file mode 100644
> index 000000000000..ff2cabd3d8c4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +
> +static volatile int sigusr1_received = 0;
> +
> +static void sigusr1_handler(int signum)
> +{
> +       sigusr1_received++;
> +}
> +
> +static int test_send_signal_common(struct perf_event_attr *attr,
> +                                   int prog_type,
> +                                   const char *test_name)
> +{
> +       int err = -1, pmu_fd, prog_fd, info_map_fd, status_map_fd;
> +       const char *file = "./test_send_signal_kern.o";
> +       struct bpf_object *obj = NULL;
> +       int pipe_c2p[2], pipe_p2c[2];
> +       __u32 key = 0, duration = 0;
> +       char buf[256];
> +       pid_t pid;
> +       __u64 val;
> +
> +       if (CHECK(pipe(pipe_c2p), test_name,
> +                 "pipe pipe_c2p error: %s\n", strerror(errno)))
> +               goto no_fork_done;
> +
> +       if (CHECK(pipe(pipe_p2c), test_name,
> +                 "pipe pipe_p2c error: %s\n", strerror(errno))) {
> +               close(pipe_c2p[0]);
> +               close(pipe_c2p[1]);
> +               goto no_fork_done;
> +       }
> +
> +       pid = fork();
> +       if (CHECK(pid < 0, test_name, "fork error: %s\n", strerror(errno))) {
> +               close(pipe_c2p[0]);
> +               close(pipe_c2p[1]);
> +               close(pipe_p2c[0]);
> +               close(pipe_p2c[1]);
> +               goto no_fork_done;
> +       }
> +
> +       if (pid == 0) {
> +               /* install signal handler and notify parent */
> +               signal(SIGUSR1, sigusr1_handler);
> +
> +               close(pipe_c2p[0]); /* close read */
> +               close(pipe_p2c[1]); /* close write */
> +
> +               /* notify parent signal handler is installed */
> +               write(pipe_c2p[1], buf, 1);
> +
> +               /* make sense parent enabled bpf program to send_signal */

typo? sense => sure?

> +               read(pipe_p2c[0], buf, 1);
> +
> +               /* wait a little for signal handler */
> +               sleep(1);
> +
> +               if (sigusr1_received)
> +                       write(pipe_c2p[1], "2", 1);
> +               else
> +                       write(pipe_c2p[1], "0", 1);
> +
> +               /* wait for parent notification and exit */
> +               read(pipe_p2c[0], buf, 1);
> +
> +               close(pipe_c2p[1]);
> +               close(pipe_p2c[0]);
> +               exit(0);
> +       }
> +
> +       close(pipe_c2p[1]); /* close write */
> +       close(pipe_p2c[0]); /* close read */
> +
> +       err = bpf_prog_load(file, prog_type, &obj, &prog_fd);
> +       if (CHECK(err < 0, test_name, "bpf_prog_load error: %s\n",
> +                 strerror(errno)))
> +               goto prog_load_failure;
> +
> +       pmu_fd = syscall(__NR_perf_event_open, attr, pid, -1,
> +                        -1 /* group id */, 0 /* flags */);
> +       if (CHECK(pmu_fd < 0, test_name, "perf_event_open error: %s\n",
> +                 strerror(errno))) {
> +               err = -1;
> +               goto close_prog;
> +       }
> +
> +       err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
> +       if (CHECK(err < 0, test_name, "ioctl perf_event_ioc_enable error: %s\n",
> +                 strerror(errno)))
> +               goto disable_pmu;
> +
> +       err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
> +       if (CHECK(err < 0, test_name, "ioctl perf_event_ioc_set_bpf error: %s\n",
> +                 strerror(errno)))
> +               goto disable_pmu;
> +
> +       err = -1;
> +       info_map_fd = bpf_object__find_map_fd_by_name(obj, "info_map");
> +       if (CHECK(info_map_fd < 0, test_name, "find map %s error\n", "info_map"))
> +               goto disable_pmu;
> +
> +       status_map_fd = bpf_object__find_map_fd_by_name(obj, "status_map");
> +       if (CHECK(status_map_fd < 0, test_name, "find map %s error\n", "status_map"))
> +               goto disable_pmu;
> +
> +       /* wait until child signal handler installed */
> +       read(pipe_c2p[0], buf, 1);
> +
> +       /* trigger the bpf send_signal */
> +       key = 0;
> +       val = (((__u64)(SIGUSR1)) << 32) | pid;
> +       bpf_map_update_elem(info_map_fd, &key, &val, 0);
> +
> +       /* notify child that bpf program can send_signal now */
> +       write(pipe_p2c[1], buf, 1);
> +
> +       /* wait for result */
> +       read(pipe_c2p[0], buf, 1);
> +
> +       err = CHECK(buf[0] != '2', test_name, "incorrect result\n");
> +
> +       /* notify child safe to exit */
> +       write(pipe_p2c[1], buf, 1);
> +
> +disable_pmu:
> +       close(pmu_fd);
> +close_prog:
> +       bpf_object__close(obj);
> +prog_load_failure:
> +       close(pipe_c2p[0]);
> +       close(pipe_p2c[1]);
> +       wait(NULL);
> +no_fork_done:
> +       return err;
> +}
> +
> +static int test_send_signal_tracepoint(void)
> +{
> +       struct perf_event_attr attr = {
> +               .type = PERF_TYPE_TRACEPOINT,
> +               .sample_type = PERF_SAMPLE_RAW | PERF_SAMPLE_CALLCHAIN,
> +               .sample_period = 1,
> +               .wakeup_events = 1,
> +       };
> +       __u32 duration = 0;
> +       int bytes, efd;
> +       char buf[256];
> +
> +       snprintf(buf, sizeof(buf),
> +                "/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id");

You could do it statically:

char buf[256] = "/sys/...../id";

> +       efd = open(buf, O_RDONLY, 0);
> +       if (CHECK(efd < 0, "tracepoint",
> +                 "open syscalls/sys_enter_nanosleep/id failure: %s\n",
> +                 strerror(errno)))
> +               return -1;
> +
> +       bytes = read(efd, buf, sizeof(buf));
> +       close(efd);
> +       if (CHECK(bytes <= 0 || bytes >= sizeof(buf), "tracepoint",
> +                 "read syscalls/sys_enter_nanosleep/id failure: %s\n",
> +                 strerror(errno)))
> +               return -1;
> +
> +       attr.config = strtol(buf, NULL, 0);
> +
> +       return test_send_signal_common(&attr, BPF_PROG_TYPE_TRACEPOINT, "tracepoint");
> +}
> +
> +static int test_send_signal_nmi(void)
> +{
> +       struct perf_event_attr attr = {
> +               .sample_freq = 50,
> +               .freq = 1,
> +               .type = PERF_TYPE_HARDWARE,
> +               .config = PERF_COUNT_HW_CPU_CYCLES,
> +       };
> +
> +       return test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT, "perf_event");
> +}
> +
> +void test_send_signal(void)
> +{
> +       int ret = 0;
> +
> +       ret |= test_send_signal_tracepoint();
> +       ret |= test_send_signal_nmi();
> +       if (!ret)
> +               printf("test_send_signal:OK\n");
> +       else
> +               printf("test_send_signal:FAIL\n");
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> new file mode 100644
> index 000000000000..45a1a1a2c345
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2019 Facebook
> +#include <linux/bpf.h>
> +#include <linux/version.h>
> +#include "bpf_helpers.h"
> +
> +struct bpf_map_def SEC("maps") info_map = {
> +       .type = BPF_MAP_TYPE_ARRAY,
> +       .key_size = sizeof(__u32),
> +       .value_size = sizeof(__u64),
> +       .max_entries = 1,
> +};
> +
> +BPF_ANNOTATE_KV_PAIR(info_map, __u32, __u64);
> +
> +struct bpf_map_def SEC("maps") status_map = {
> +       .type = BPF_MAP_TYPE_ARRAY,
> +       .key_size = sizeof(__u32),
> +       .value_size = sizeof(__u64),
> +       .max_entries = 1,
> +};
> +
> +BPF_ANNOTATE_KV_PAIR(status_map, __u32, __u64);
> +
> +SEC("send_signal_demo")
> +int bpf_send_signal_test(void *ctx)
> +{
> +       __u64 *info_val, *status_val;
> +       __u32 key = 0, pid, sig;
> +       int ret;
> +
> +       status_val = bpf_map_lookup_elem(&status_map, &key);
> +       if (!status_val || *status_val != 0)
> +               return 0;
> +
> +       info_val = bpf_map_lookup_elem(&info_map, &key);
> +       if (!info_val || *info_val == 0)
> +               return 0;
> +
> +       sig = *info_val >> 32;
> +       pid = *info_val & 0xffffFFFF;
> +
> +       if ((bpf_get_current_pid_tgid() >> 32) == pid) {
> +               ret = bpf_send_signal(sig);
> +               if (ret == 0)
> +                       *status_val = 1;
> +       }
> +
> +       return 0;
> +}
> +char __license[] SEC("license") = "GPL";
> --
> 2.17.1
>
