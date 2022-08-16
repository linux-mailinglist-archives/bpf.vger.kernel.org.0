Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAC0595450
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 09:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiHPH7w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 03:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiHPH73 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 03:59:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F17F23FA
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 22:16:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dc19so16889072ejb.12
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 22:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Aq2gasN22jd2jwkGnCCqHVNByxPto/JyX+mmkBOCmzU=;
        b=OvodXz6+/wkN/rlYJ+Qa9FXYp1ZTk4wmIozwmTAWo9Sma2qKE7pw7UHhIf4A5KaPw4
         VjEeid3obz2lksCAV2iMryyxCYmRJiUgFnYq92r7JdTGCKWHugdcfFf3JmQwW4y13pH4
         cnUec3jgpOAgDXTPSKBA5uPjnuSOH5yA1D031vskfDlV0KVMhGAAamgrq7F0Jo7LA44g
         4C+tHdENlU8YuRpRdcT+LMaKW5UI+QhvF3/seS9adP/Wknrn3FjdHMnrZ9Cv+GtrXP73
         4L5E2j6+uhoTr/fxdvF/55zNoAt2at50vVMrJLjk6ncNjZokr/l1N4nE7LCtKdac8Qp0
         IQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Aq2gasN22jd2jwkGnCCqHVNByxPto/JyX+mmkBOCmzU=;
        b=hDr9Nz+MCaCRNJf9qI+Pm83c2fapXD65w0Y0YACpZkNqaiJxtMM1uMY2q7GkXvDi40
         dUOW5ytf0zGHyRJRLdcmIFAlakupAi6YLhwRolt7s+bZk2JDNIqCGz/HM0YwG8QHnBCJ
         3fyxMW+t1mDR+lZnpbnuYnU9iZwgfRsLXYHndreQmgGU3nqBczkAmvRii0kgZeFLnD3Q
         kPcyR6gq+qmryAqus50a4Xiov1i/mrPWRN+F/Y/5g4C4R4bY22xlub9ZNh6UAOeFRFSr
         S0uzhzXj3fz6tzn3jVDC8qvUVBuJ2s84rbQXjsSEUEMgFmm66aMdGfrDY5X+BZ8AycCl
         QqdQ==
X-Gm-Message-State: ACgBeo1Lzk5z/BLB3bIp4+TzAiQ1DEXCEmrGN5T3xbKCu/Bz/ZS/pKas
        YRnkO/kCfCAV4pQOJ2fE9mLg9++o8TXxIJ92NN8=
X-Google-Smtp-Source: AA6agR4r0aK8mdYyB8ke4Cjny9I38YVCdFkRmG2s40XKy6ZXUpQgN769ORh/tj1VE5QW6jMjkPEk55NZl1UEF5TWdgk=
X-Received: by 2002:a17:907:1611:b0:733:636:5686 with SMTP id
 hb17-20020a170907161100b0073306365686mr12507870ejc.226.1660626969603; Mon, 15
 Aug 2022 22:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220811001654.1316689-1-kuifeng@fb.com> <20220811001654.1316689-4-kuifeng@fb.com>
In-Reply-To: <20220811001654.1316689-4-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Aug 2022 22:15:58 -0700
Message-ID: <CAEf4BzYBQmNDAi5k0Af2eu=KfBKY_ZQOV8JjzP7cjpEjPqzDug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Test parameterized task
 BPF iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 10, 2022 at 5:17 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Test iterators of vma, files, and tasks of tasks.
>
> Ensure the API works appropriately to visit all tasks,
> tasks in a process, or a particular task.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 204 ++++++++++++++++--
>  .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>  .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
>  .../selftests/bpf/progs/bpf_iter_task_file.c  |   7 +
>  .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
>  5 files changed, 203 insertions(+), 25 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index a33874b081b6..e66f1f3db562 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2020 Facebook */
>  #include <test_progs.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <signal.h>
>  #include "bpf_iter_ipv6_route.skel.h"
>  #include "bpf_iter_netlink.skel.h"
>  #include "bpf_iter_bpf_map.skel.h"
> @@ -42,13 +45,13 @@ static void test_btf_id_or_null(void)
>         }
>  }
>
> -static void do_dummy_read(struct bpf_program *prog)
> +static void do_dummy_read(struct bpf_program *prog, struct bpf_iter_attach_opts *opts)

there are a bunch of uses of do_dummy_read that don't need to pass
opts and adding this argument causes unnecessary churn. why not add
do_dummy_read_opts() instead and only modify places that do need to
pass opts?

>  {
>         struct bpf_link *link;
>         char buf[16] = {};
>         int iter_fd, len;
>
> -       link = bpf_program__attach_iter(prog, NULL);
> +       link = bpf_program__attach_iter(prog, opts);
>         if (!ASSERT_OK_PTR(link, "attach_iter"))
>                 return;
>
> @@ -91,7 +94,7 @@ static void test_ipv6_route(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_ipv6_route__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_ipv6_route);
> +       do_dummy_read(skel->progs.dump_ipv6_route, NULL);
>
>         bpf_iter_ipv6_route__destroy(skel);
>  }
> @@ -104,7 +107,7 @@ static void test_netlink(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_netlink__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_netlink);
> +       do_dummy_read(skel->progs.dump_netlink, NULL);
>
>         bpf_iter_netlink__destroy(skel);
>  }
> @@ -117,24 +120,139 @@ static void test_bpf_map(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_map__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_bpf_map);
> +       do_dummy_read(skel->progs.dump_bpf_map, NULL);
>
>         bpf_iter_bpf_map__destroy(skel);
>  }
>
> -static void test_task(void)
> +static int pidfd_open(pid_t pid, unsigned int flags)
> +{
> +       return syscall(SYS_pidfd_open, pid, flags);
> +}
> +
> +static void check_bpf_link_info(const struct bpf_program *prog)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);

nit: prefer LIBBPF_OPTS, DECLARE_LIBBPF_OPTS is verbose legacy name

> +       union bpf_iter_link_info linfo;
> +       struct bpf_link_info info = {};
> +       __u32 info_len;
> +       struct bpf_link *link;
> +       int err;
> +
> +       memset(&linfo, 0, sizeof(linfo));
> +       linfo.task.tid = getpid();
> +       opts.link_info = &linfo;
> +       opts.link_info_len = sizeof(linfo);
> +
> +       link = bpf_program__attach_iter(prog, &opts);
> +       if (!ASSERT_OK_PTR(link, "attach_iter"))
> +               return;
> +
> +       info_len = sizeof(info);
> +       err = bpf_obj_get_info_by_fd(bpf_link__fd(link), &info, &info_len);
> +       if (ASSERT_OK(err, "bpf_obj_get_info_by_fd"))
> +               ASSERT_EQ(info.iter.task.tid, getpid(), "check_task_tid");

nit: for checks that can't crash even if some error happened, it's
best to not nest them, so just:

ASSERT_OK(err, ...);
ASSERT_EQ(info.iter.task.tid, ...);

both will probably fail if err != 0, but that's fine

> +
> +       bpf_link__destroy(link);
> +}
> +
> +static pthread_mutex_t do_nothing_mutex;
> +
> +static void *do_nothing_wait(void *arg)
> +{
> +       pthread_mutex_lock(&do_nothing_mutex);
> +       pthread_mutex_unlock(&do_nothing_mutex);
> +

nice, clever!

> +       pthread_exit(arg);
> +}
> +
> +static void test_task_(struct bpf_iter_attach_opts *opts, int num_unknown, int num_known)
>  {
>         struct bpf_iter_task *skel;
> +       pthread_t thread_id;
> +       void *ret;
>
>         skel = bpf_iter_task__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_task);
> +       if (!ASSERT_OK(pthread_mutex_init(&do_nothing_mutex, NULL), "pthread_mutex_init"))
> +               goto done;
> +       if (!ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock"))
> +               goto done;
> +
> +       if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
> +                 "pthread_create"))
> +               goto done;
> +
> +
> +       skel->bss->tid = getpid();
> +
> +       do_dummy_read(skel->progs.dump_task, opts);
> +
> +       if (!ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unlock"))
> +               goto done;
> +
> +       if (num_unknown >= 0)
> +               ASSERT_EQ(skel->bss->num_unknown_tid, num_unknown, "check_num_unknown_tid");
> +       if (num_known >= 0)
> +               ASSERT_EQ(skel->bss->num_known_tid, num_known, "check_num_known_tid");
>
> +       ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
> +                    "pthread_join");

this will have better "debuggability" if expressed as more
semantically meaningful checks:

ASSERT_OK(pthread_join(...), ...);
ASSERT_NULL(ret, ...);

It's also easier to follow what is actually expected

> +
> +done:
>         bpf_iter_task__destroy(skel);
>  }
>
> +static void test_task(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +       union bpf_iter_link_info linfo;
> +
> +       memset(&linfo, 0, sizeof(linfo));
> +       linfo.task.tid = getpid();
> +       opts.link_info = &linfo;
> +       opts.link_info_len = sizeof(linfo);
> +
> +       test_task_(&opts, 0, 1);
> +
> +       test_task_(NULL, -1, 1);
> +}
> +
> +static void test_task_tgid(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +       union bpf_iter_link_info linfo;
> +
> +       memset(&linfo, 0, sizeof(linfo));
> +       linfo.task.tgid = getpid();
> +       opts.link_info = &linfo;
> +       opts.link_info_len = sizeof(linfo);
> +
> +       test_task_(&opts, 1, 1);
> +}
> +
> +static void test_task_pidfd(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +       union bpf_iter_link_info linfo;
> +       int pidfd;
> +
> +       pidfd = pidfd_open(getpid(), 0);
> +       if (!ASSERT_GE(pidfd, 0, "pidfd_open"))
> +               return;
> +
> +       memset(&linfo, 0, sizeof(linfo));
> +       linfo.task.pid_fd = pidfd;
> +       opts.link_info = &linfo;
> +       opts.link_info_len = sizeof(linfo);
> +
> +       test_task_(&opts, 1, 1);
> +
> +       close(pidfd);
> +}
> +
>  static void test_task_sleepable(void)
>  {
>         struct bpf_iter_task *skel;
> @@ -143,7 +261,7 @@ static void test_task_sleepable(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_task_sleepable);
> +       do_dummy_read(skel->progs.dump_task_sleepable, NULL);
>
>         ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task, 0,
>                   "num_expected_failure_copy_from_user_task");
> @@ -161,8 +279,8 @@ static void test_task_stack(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_task_stack__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_task_stack);
> -       do_dummy_read(skel->progs.get_task_user_stacks);
> +       do_dummy_read(skel->progs.dump_task_stack, NULL);
> +       do_dummy_read(skel->progs.get_task_user_stacks, NULL);
>
>         bpf_iter_task_stack__destroy(skel);
>  }
> @@ -174,7 +292,9 @@ static void *do_nothing(void *arg)
>
>  static void test_task_file(void)
>  {
> +       DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
>         struct bpf_iter_task_file *skel;
> +       union bpf_iter_link_info linfo;
>         pthread_t thread_id;
>         void *ret;
>
> @@ -188,15 +308,31 @@ static void test_task_file(void)
>                   "pthread_create"))
>                 goto done;
>
> -       do_dummy_read(skel->progs.dump_task_file);
> +       memset(&linfo, 0, sizeof(linfo));
> +       linfo.task.tid = getpid();
> +       opts.link_info = &linfo;
> +       opts.link_info_len = sizeof(linfo);
> +
> +       do_dummy_read(skel->progs.dump_task_file, &opts);
>
>         if (!ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
>                   "pthread_join"))
>                 goto done;
>
>         ASSERT_EQ(skel->bss->count, 0, "check_count");
> +       ASSERT_EQ(skel->bss->unique_tgid_count, 1, "check_unique_tgid_count");
>
> -done:
> +       skel->bss->count = 0;
> +       skel->bss->unique_tgid_count = 0;
> +
> +       do_dummy_read(skel->progs.dump_task_file, NULL);
> +
> +       ASSERT_GE(skel->bss->count, 0, "check_count");
> +       ASSERT_GE(skel->bss->unique_tgid_count, 1, "check_unique_tgid_count");
> +
> +       check_bpf_link_info(skel->progs.dump_task_file);
> +
> + done:
>         bpf_iter_task_file__destroy(skel);
>  }
>
> @@ -274,7 +410,7 @@ static void test_tcp4(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_tcp4__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_tcp4);
> +       do_dummy_read(skel->progs.dump_tcp4, NULL);
>
>         bpf_iter_tcp4__destroy(skel);
>  }
> @@ -287,7 +423,7 @@ static void test_tcp6(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_tcp6__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_tcp6);
> +       do_dummy_read(skel->progs.dump_tcp6, NULL);
>
>         bpf_iter_tcp6__destroy(skel);
>  }
> @@ -300,7 +436,7 @@ static void test_udp4(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_udp4__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_udp4);
> +       do_dummy_read(skel->progs.dump_udp4, NULL);
>
>         bpf_iter_udp4__destroy(skel);
>  }
> @@ -313,7 +449,7 @@ static void test_udp6(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_udp6__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_udp6);
> +       do_dummy_read(skel->progs.dump_udp6, NULL);
>
>         bpf_iter_udp6__destroy(skel);
>  }
> @@ -326,7 +462,7 @@ static void test_unix(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_unix__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_unix);
> +       do_dummy_read(skel->progs.dump_unix, NULL);
>
>         bpf_iter_unix__destroy(skel);
>  }
> @@ -988,7 +1124,7 @@ static void test_bpf_sk_storage_get(void)
>         if (!ASSERT_OK(err, "bpf_map_update_elem"))
>                 goto close_socket;
>
> -       do_dummy_read(skel->progs.fill_socket_owner);
> +       do_dummy_read(skel->progs.fill_socket_owner, NULL);
>
>         err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
>         if (CHECK(err || val != getpid(), "bpf_map_lookup_elem",
> @@ -996,7 +1132,7 @@ static void test_bpf_sk_storage_get(void)
>             getpid(), val, err))
>                 goto close_socket;
>
> -       do_dummy_read(skel->progs.negate_socket_local_storage);
> +       do_dummy_read(skel->progs.negate_socket_local_storage, NULL);
>
>         err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
>         CHECK(err || val != -getpid(), "bpf_map_lookup_elem",
> @@ -1116,7 +1252,7 @@ static void test_link_iter(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_link__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_bpf_link);
> +       do_dummy_read(skel->progs.dump_bpf_link, NULL);
>
>         bpf_iter_bpf_link__destroy(skel);
>  }
> @@ -1129,7 +1265,7 @@ static void test_ksym_iter(void)
>         if (!ASSERT_OK_PTR(skel, "bpf_iter_ksym__open_and_load"))
>                 return;
>
> -       do_dummy_read(skel->progs.dump_ksym);
> +       do_dummy_read(skel->progs.dump_ksym, NULL);
>
>         bpf_iter_ksym__destroy(skel);
>  }
> @@ -1154,7 +1290,7 @@ static void str_strip_first_line(char *str)
>         *dst = '\0';
>  }
>
> -static void test_task_vma(void)
> +static void test_task_vma_(struct bpf_iter_attach_opts *opts)
>  {
>         int err, iter_fd = -1, proc_maps_fd = -1;
>         struct bpf_iter_task_vma *skel;
> @@ -1166,13 +1302,14 @@ static void test_task_vma(void)
>                 return;
>
>         skel->bss->pid = getpid();
> +       skel->bss->one_task = opts ? 1 : 0;
>
>         err = bpf_iter_task_vma__load(skel);
>         if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
>                 goto out;
>
>         skel->links.proc_maps = bpf_program__attach_iter(
> -               skel->progs.proc_maps, NULL);
> +               skel->progs.proc_maps, opts);
>
>         if (!ASSERT_OK_PTR(skel->links.proc_maps, "bpf_program__attach_iter")) {
>                 skel->links.proc_maps = NULL;
> @@ -1211,12 +1348,29 @@ static void test_task_vma(void)
>         str_strip_first_line(proc_maps_output);
>
>         ASSERT_STREQ(task_vma_output, proc_maps_output, "compare_output");
> +
> +       check_bpf_link_info(skel->progs.proc_maps);
> +
>  out:
>         close(proc_maps_fd);
>         close(iter_fd);
>         bpf_iter_task_vma__destroy(skel);
>  }
>
> +static void test_task_vma(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +       union bpf_iter_link_info linfo;
> +
> +       memset(&linfo, 0, sizeof(linfo));
> +       linfo.task.tid = getpid();
> +       opts.link_info = &linfo;
> +       opts.link_info_len = sizeof(linfo);
> +
> +       test_task_vma_(&opts);
> +       test_task_vma_(NULL);
> +}
> +
>  void test_bpf_iter(void)
>  {
>         if (test__start_subtest("btf_id_or_null"))
> @@ -1229,6 +1383,10 @@ void test_bpf_iter(void)
>                 test_bpf_map();
>         if (test__start_subtest("task"))
>                 test_task();
> +       if (test__start_subtest("task_tgid"))
> +               test_task_tgid();
> +       if (test__start_subtest("task_pidfd"))
> +               test_task_pidfd();
>         if (test__start_subtest("task_sleepable"))
>                 test_task_sleepable();
>         if (test__start_subtest("task_stack"))
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index 5fce7008d1ff..32c34ce9cbeb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -764,7 +764,7 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
>
>         /* union with nested struct */
>         TEST_BTF_DUMP_DATA(btf, d, "union", str, union bpf_iter_link_info, BTF_F_COMPACT,
> -                          "(union bpf_iter_link_info){.map = (struct){.map_fd = (__u32)1,},}",
> +                          "(union bpf_iter_link_info){.map = (struct){.map_fd = (__u32)1,},.task = (struct){.tid = (__u32)1,},}",
>                            { .map = { .map_fd = 1 }});
>
>         /* struct skb with nested structs/unions; because type output is so
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> index d22741272692..96131b9a1caa 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> @@ -6,6 +6,10 @@
>
>  char _license[] SEC("license") = "GPL";
>
> +uint32_t tid = 0;
> +int num_unknown_tid = 0;
> +int num_known_tid = 0;
> +
>  SEC("iter/task")
>  int dump_task(struct bpf_iter__task *ctx)
>  {
> @@ -18,6 +22,11 @@ int dump_task(struct bpf_iter__task *ctx)
>                 return 0;
>         }
>
> +       if (task->pid != tid)
> +               num_unknown_tid++;
> +       else
> +               num_known_tid++;
> +
>         if (ctx->meta->seq_num == 0)
>                 BPF_SEQ_PRINTF(seq, "    tgid      gid\n");
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
> index 6e7b400888fe..031455ed8748 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
> @@ -7,6 +7,8 @@ char _license[] SEC("license") = "GPL";
>
>  int count = 0;
>  int tgid = 0;
> +int last_tgid = -1;
> +int unique_tgid_count = 0;
>
>  SEC("iter/task_file")
>  int dump_task_file(struct bpf_iter__task_file *ctx)
> @@ -27,6 +29,11 @@ int dump_task_file(struct bpf_iter__task_file *ctx)
>         if (tgid == task->tgid && task->tgid != task->pid)
>                 count++;
>
> +       if (last_tgid != task->tgid) {
> +               last_tgid = task->tgid;
> +               unique_tgid_count++;
> +       }
> +
>         BPF_SEQ_PRINTF(seq, "%8d %8d %8d %lx\n", task->tgid, task->pid, fd,
>                        (long)file->f_op);
>         return 0;
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
> index 4ea6a37d1345..44f4a31c2ddd 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
> @@ -20,6 +20,7 @@ char _license[] SEC("license") = "GPL";
>  #define D_PATH_BUF_SIZE 1024
>  char d_path_buf[D_PATH_BUF_SIZE] = {};
>  __u32 pid = 0;
> +__u32 one_task = 0;
>
>  SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
>  {
> @@ -33,8 +34,11 @@ SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
>                 return 0;
>
>         file = vma->vm_file;
> -       if (task->tgid != pid)
> +       if (task->tgid != pid) {
> +               if (one_task)
> +                       BPF_SEQ_PRINTF(seq, "unexpected task (%d != %d)", task->tgid, pid);
>                 return 0;
> +       }
>         perm_str[0] = (vma->vm_flags & VM_READ) ? 'r' : '-';
>         perm_str[1] = (vma->vm_flags & VM_WRITE) ? 'w' : '-';
>         perm_str[2] = (vma->vm_flags & VM_EXEC) ? 'x' : '-';
> --
> 2.30.2
>

It would be great to have a test that uses task_vma iterator to
calculate the same value that get_uprobe_offset() does through
/proc/self/maps. Can you add such test? I'd also calculate the number
of iterated tasks to make sure we only go through one task.

This is the most direct intended use case for parameterized task iter,
so would be nice to have a test proving it does work and it works as
expected. Thanks!
