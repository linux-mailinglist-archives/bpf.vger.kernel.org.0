Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C902255F239
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 02:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiF2AKH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 20:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiF2AKE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 20:10:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3860275D9
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 17:09:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v9so4313034wrp.7
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+xrhxnzA4jD8FPHCJIxOrhkhQm+X4+uf+qWir4XeKU=;
        b=Irtxg47SszOGrdhPtvON+yWQ3ICPKVgPN92DJbt5hoj3+EPfUyh8gbDC2tYHke8k7Y
         0xjBqWGPHRGJc9Azei2Y1Grqnkwkf8zqmpIaQPmrJWS8QPqOZ80Y/GxWxwpxjUggf3K7
         Ju7nI/boEjrqPPUhZxgL1jRgqHiTPSwzUy5Dd/D6xAdM/95KHZTJjjuDVyfNaXIDaomh
         GVQj1uNW5j4fQPLRTO0pO2y3dfvtiaXyqPOfJ7n4cUHLOTwWtUPuCW+qtJ5J0fBh5upI
         5oa2q6ZnoDDGmSMSgOCHAhSd9T1GZ19IR/BwPUtazcpts5Q/AsKxpeLpS5PaBvX2ejVv
         usBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+xrhxnzA4jD8FPHCJIxOrhkhQm+X4+uf+qWir4XeKU=;
        b=BxU3bG9zxfYQAuwe2VI0BWt+tNi21RQpdzjFUxKiW8DePxgY1rW6rCbtP7g1zQRMqu
         J9owHVT5S3Aq9/AUrwSJjx+KXBvVqHsONSHs/GEGMXUsa+4ta9P9+b8+RVJdtfoaqsZp
         agYu9a+ofCsE2MJLhmbmpYtF6Cs4t70yXWLG5/QkBG1Aub7qGATwpgi+7gBWv4ypRQ6c
         Eqcq8fzgPntvDtp+S56hI8rQ7fpCy5g6QNTl19cddNZkAb1PnMw6tEk5v6b46cIeoLFW
         9KLiBJaomAZH3vwhFgGvP2bZ/uTMf8dMBUuPlLYtWnOjF//aF3+DXn8pQWt35y8KeYEL
         GqPQ==
X-Gm-Message-State: AJIora+JmQUqV9U1ajizPs0rKOou3aJgXZYJK32+7Q4fFHwi6VC1BTeO
        lyFNnRF2ffsW59Ra1JihgUagdCN8FlofCCAUjD9m/A==
X-Google-Smtp-Source: AGRyM1sYPfS5xlH4mqAto1ZZ4JNou/lZoZa6++Zur2Z7S7C7ouItxETmvfzJJEC1kYAQ50lFPk7RvORVU5kthBJLmt0=
X-Received: by 2002:a5d:6ac4:0:b0:21b:a724:1711 with SMTP id
 u4-20020a5d6ac4000000b0021ba7241711mr360823wrw.80.1656461398132; Tue, 28 Jun
 2022 17:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220610194435.2268290-1-yosryahmed@google.com>
 <20220610194435.2268290-9-yosryahmed@google.com> <00df1932-38fe-c6f8-49d0-3a44affb1268@fb.com>
 <CAJD7tkaNnx6ebFrMxWgkJbtx=Qoe+cEwnjtWeY5=EAaVktrenw@mail.gmail.com> <CAJD7tkZ3AEPEUD9V-5nxUgmS5SLc6qp50ZyrRoAQgdzPM=a-Hg@mail.gmail.com>
In-Reply-To: <CAJD7tkZ3AEPEUD9V-5nxUgmS5SLc6qp50ZyrRoAQgdzPM=a-Hg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Jun 2022 17:09:21 -0700
Message-ID: <CAJD7tkarwnbcqR1DUN-iJmt0k_njwBfDMd=P8ket8DfEfRRYjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 8/8] bpf: add a selftest for cgroup
 hierarchical stats collection
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 28, 2022 at 12:14 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Mon, Jun 27, 2022 at 11:47 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 11:14 PM Yonghong Song <yhs@fb.com> wrote:
> > >
> > >
> > >
> > > On 6/10/22 12:44 PM, Yosry Ahmed wrote:
> > > > Add a selftest that tests the whole workflow for collecting,
> > > > aggregating (flushing), and displaying cgroup hierarchical stats.
> > > >
> > > > TL;DR:
> > > > - Whenever reclaim happens, vmscan_start and vmscan_end update
> > > >    per-cgroup percpu readings, and tell rstat which (cgroup, cpu) pairs
> > > >    have updates.
> > > > - When userspace tries to read the stats, vmscan_dump calls rstat to flush
> > > >    the stats, and outputs the stats in text format to userspace (similar
> > > >    to cgroupfs stats).
> > > > - rstat calls vmscan_flush once for every (cgroup, cpu) pair that has
> > > >    updates, vmscan_flush aggregates cpu readings and propagates updates
> > > >    to parents.
> > > >
> > > > Detailed explanation:
> > > > - The test loads tracing bpf programs, vmscan_start and vmscan_end, to
> > > >    measure the latency of cgroup reclaim. Per-cgroup ratings are stored in
> > > >    percpu maps for efficiency. When a cgroup reading is updated on a cpu,
> > > >    cgroup_rstat_updated(cgroup, cpu) is called to add the cgroup to the
> > > >    rstat updated tree on that cpu.
> > > >
> > > > - A cgroup_iter program, vmscan_dump, is loaded and pinned to a file, for
> > > >    each cgroup. Reading this file invokes the program, which calls
> > > >    cgroup_rstat_flush(cgroup) to ask rstat to propagate the updates for all
> > > >    cpus and cgroups that have updates in this cgroup's subtree. Afterwards,
> > > >    the stats are exposed to the user. vmscan_dump returns 1 to terminate
> > > >    iteration early, so that we only expose stats for one cgroup per read.
> > > >
> > > > - An ftrace program, vmscan_flush, is also loaded and attached to
> > > >    bpf_rstat_flush. When rstat flushing is ongoing, vmscan_flush is invoked
> > > >    once for each (cgroup, cpu) pair that has updates. cgroups are popped
> > > >    from the rstat tree in a bottom-up fashion, so calls will always be
> > > >    made for cgroups that have updates before their parents. The program
> > > >    aggregates percpu readings to a total per-cgroup reading, and also
> > > >    propagates them to the parent cgroup. After rstat flushing is over, all
> > > >    cgroups will have correct updated hierarchical readings (including all
> > > >    cpus and all their descendants).
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > >
> > > There are a selftest failure with test:
> > >
> > > get_cgroup_vmscan_delay:PASS:output format 0 nsec
> > > get_cgroup_vmscan_delay:PASS:cgroup_id 0 nsec
> > > get_cgroup_vmscan_delay:PASS:vmscan_reading 0 nsec
> > > get_cgroup_vmscan_delay:PASS:read cgroup_iter 0 nsec
> > > get_cgroup_vmscan_delay:PASS:output format 0 nsec
> > > get_cgroup_vmscan_delay:PASS:cgroup_id 0 nsec
> > > get_cgroup_vmscan_delay:FAIL:vmscan_reading unexpected vmscan_reading:
> > > actual 0 <= expected 0
> > > check_vmscan_stats:FAIL:child1_vmscan unexpected child1_vmscan: actual
> > > 781874 != expected 382092
> > > check_vmscan_stats:FAIL:child2_vmscan unexpected child2_vmscan: actual
> > > -1 != expected -2
> > > check_vmscan_stats:FAIL:test_vmscan unexpected test_vmscan: actual
> > > 781874 != expected 781873
> > > check_vmscan_stats:FAIL:root_vmscan unexpected root_vmscan: actual 0 <
> > > expected 781874
> > > destroy_progs:PASS:remove cgroup_iter pin 0 nsec
> > > destroy_progs:PASS:remove cgroup_iter pin 0 nsec
> > > destroy_progs:PASS:remove cgroup_iter pin 0 nsec
> > > destroy_progs:PASS:remove cgroup_iter pin 0 nsec
> > > destroy_progs:PASS:remove cgroup_iter pin 0 nsec
> > > destroy_progs:PASS:remove cgroup_iter pin 0 nsec
> > > destroy_progs:PASS:remove cgroup_iter pin 0 nsec
> > > destroy_progs:PASS:remove cgroup_iter root pin 0 nsec
> > > cleanup_bpffs:PASS:rmdir /sys/fs/bpf/vmscan/ 0 nsec
> > > #33      cgroup_hierarchical_stats:FAIL
> > >
> >
> > The test is passing on my setup. I am trying to figure out if there is
> > something outside the setup done by the test that can cause the test
> > to fail.
> >
>
> I can't reproduce the failure on my machine. It seems like for some
> reason reclaim is not invoked in one of the test cgroups which results
> in the expected stats not being there. I have a few suspicions as to
> what might cause this but I am not sure.
>
> If you have the capacity, do you mind re-running the test with the
> attached diff1.patch? (and maybe diff2.patch if that fails, this will
> cause OOMs in the test cgroup, you might see some process killed
> warnings).
> Thanks!
>

In addition to that, it looks like one of the cgroups has a "0" stat
which shouldn't happen unless one of the map update/lookup operations
failed, which should log something using bpf_printk. I need to
reproduce the test failure to investigate this properly. Did you
observe this failure on your machine or in CI? Any instructions on how
to reproduce or system setup?

>
> > >
> > > Also an existing test also failed.
> > >
> > > btf_dump_data:PASS:find type id 0 nsec
> > >
> > >
> > > btf_dump_data:PASS:failed/unexpected type_sz 0 nsec
> > >
> > >
> > > btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> > > expected/actual match: actual '(union bpf_iter_link_info){.map =
> > > (struct){.map_fd = (__u32)1,},.cgroup '
> > > test_btf_dump_struct_data:PASS:find struct sk_buff 0 nsec
> > >
> >
> > Yeah I see what happened there. bpf_iter_link_info was changed by the
> > patch that introduced cgroup_iter, and this specific union is used by
> > the test to test the "union with nested struct" btf dumping. I will
> > add a patch in the next version that updates the btf_dump_data test
> > accordingly. Thanks.
> >
> > >
> > > test_btf_dump_struct_data:PASS:unexpected return value dumping sk_buff 0
> > > nsec
> > >
> > > btf_dump_data:PASS:verify prefix match 0 nsec
> > >
> > >
> > > btf_dump_data:PASS:find type id 0 nsec
> > >
> > >
> > > btf_dump_data:PASS:failed to return -E2BIG 0 nsec
> > >
> > >
> > > btf_dump_data:PASS:ensure expected/actual match 0 nsec
> > >
> > >
> > > btf_dump_data:PASS:verify prefix match 0 nsec
> > >
> > >
> > > btf_dump_data:PASS:find type id 0 nsec
> > >
> > >
> > > btf_dump_data:PASS:failed to return -E2BIG 0 nsec
> > >
> > >
> > > btf_dump_data:PASS:ensure expected/actual match 0 nsec
> > >
> > >
> > > #21/14   btf_dump/btf_dump: struct_data:FAIL
> > >
> > > please take a look.
> > >
> > > > ---
> > > >   .../prog_tests/cgroup_hierarchical_stats.c    | 351 ++++++++++++++++++
> > > >   .../bpf/progs/cgroup_hierarchical_stats.c     | 234 ++++++++++++
> > > >   2 files changed, 585 insertions(+)
> > > >   create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> > > >   create mode 100644 tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> > > > new file mode 100644
> > > > index 0000000000000..b78a4043da49a
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> > > > @@ -0,0 +1,351 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Functions to manage eBPF programs attached to cgroup subsystems
> > > > + *
> > > > + * Copyright 2022 Google LLC.
> > > > + */
> > > > +#include <errno.h>
> > > > +#include <sys/types.h>
> > > > +#include <sys/mount.h>
> > > > +#include <sys/stat.h>
> > > > +#include <unistd.h>
> > > > +
> > > > +#include <test_progs.h>
> > > > +#include <bpf/libbpf.h>
> > > > +#include <bpf/bpf.h>
> > > > +
> > > > +#include "cgroup_helpers.h"
> > > > +#include "cgroup_hierarchical_stats.skel.h"
> > > > +
> > > > +#define PAGE_SIZE 4096
> > > > +#define MB(x) (x << 20)
> > > > +
> > > > +#define BPFFS_ROOT "/sys/fs/bpf/"
> > > > +#define BPFFS_VMSCAN BPFFS_ROOT"vmscan/"
> > > > +
> > > > +#define CG_ROOT_NAME "root"
> > > > +#define CG_ROOT_ID 1
> > > > +
> > > > +#define CGROUP_PATH(p, n) {.path = #p"/"#n, .name = #n}
> > > > +
> > > > +static struct {
> > > > +     const char *path, *name;
> > > > +     unsigned long long id;
> > > > +     int fd;
> > > > +} cgroups[] = {
> > > > +     CGROUP_PATH(/, test),
> > > > +     CGROUP_PATH(/test, child1),
> > > > +     CGROUP_PATH(/test, child2),
> > > > +     CGROUP_PATH(/test/child1, child1_1),
> > > > +     CGROUP_PATH(/test/child1, child1_2),
> > > > +     CGROUP_PATH(/test/child2, child2_1),
> > > > +     CGROUP_PATH(/test/child2, child2_2),
> > > > +};
> > > > +
> > > > +#define N_CGROUPS ARRAY_SIZE(cgroups)
> > > > +#define N_NON_LEAF_CGROUPS 3
> > > > +
> > > > +int root_cgroup_fd;
> > > > +bool mounted_bpffs;
> > > > +
> > > > +static int read_from_file(const char *path, char *buf, size_t size)
> > > > +{
> > > > +     int fd, len;
> > > > +
> > > > +     fd = open(path, O_RDONLY);
> > > > +     if (fd < 0) {
> > > > +             log_err("Open %s", path);
> > > > +             return -errno;
> > > > +     }
> > > > +     len = read(fd, buf, size);
> > > > +     if (len < 0)
> > > > +             log_err("Read %s", path);
> > > > +     else
> > > > +             buf[len] = 0;
> > > > +     close(fd);
> > > > +     return len < 0 ? -errno : 0;
> > > > +}
> > > > +
> > > > +static int setup_bpffs(void)
> > > > +{
> > > > +     int err;
> > > > +
> > > > +     /* Mount bpffs */
> > > > +     err = mount("bpf", BPFFS_ROOT, "bpf", 0, NULL);
> > > > +     mounted_bpffs = !err;
> > > > +     if (!ASSERT_OK(err && errno != EBUSY, "mount bpffs"))
> > > > +             return err;
> > > > +
> > > > +     /* Create a directory to contain stat files in bpffs */
> > > > +     err = mkdir(BPFFS_VMSCAN, 0755);
> > > > +     ASSERT_OK(err, "mkdir bpffs");
> > > > +     return err;
> > > > +}
> > > > +
> > > > +static void cleanup_bpffs(void)
> > > > +{
> > > > +     /* Remove created directory in bpffs */
> > > > +     ASSERT_OK(rmdir(BPFFS_VMSCAN), "rmdir "BPFFS_VMSCAN);
> > > > +
> > > > +     /* Unmount bpffs, if it wasn't already mounted when we started */
> > > > +     if (mounted_bpffs)
> > > > +             return;
> > > > +     ASSERT_OK(umount(BPFFS_ROOT), "unmount bpffs");
> > > > +}
> > > > +
> > > > +static int setup_cgroups(void)
> > > > +{
> > > > +     int i, fd, err;
> > > > +
> > > > +     err = setup_cgroup_environment();
> > > > +     if (!ASSERT_OK(err, "setup_cgroup_environment"))
> > > > +             return err;
> > > > +
> > > > +     root_cgroup_fd = get_root_cgroup();
> > > > +     if (!ASSERT_GE(root_cgroup_fd, 0, "get_root_cgroup"))
> > > > +             return root_cgroup_fd;
> > > > +
> > > > +     for (i = 0; i < N_CGROUPS; i++) {
> > > > +             fd = create_and_get_cgroup(cgroups[i].path);
> > > > +             if (!ASSERT_GE(fd, 0, "create_and_get_cgroup"))
> > > > +                     return fd;
> > > > +
> > > > +             cgroups[i].fd = fd;
> > > > +             cgroups[i].id = get_cgroup_id(cgroups[i].path);
> > > > +
> > > > +             /*
> > > > +              * Enable memcg controller for the entire hierarchy.
> > > > +              * Note that stats are collected for all cgroups in a hierarchy
> > > > +              * with memcg enabled anyway, but are only exposed for cgroups
> > > > +              * that have memcg enabled.
> > > > +              */
> > > > +             if (i < N_NON_LEAF_CGROUPS) {
> > > > +                     err = enable_controllers(cgroups[i].path, "memory");
> > > > +                     if (!ASSERT_OK(err, "enable_controllers"))
> > > > +                             return err;
> > > > +             }
> > > > +     }
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void cleanup_cgroups(void)
> > > > +{
> > > > +     close(root_cgroup_fd);
> > > > +     for (int i = 0; i < N_CGROUPS; i++)
> > > > +             close(cgroups[i].fd);
> > > > +     cleanup_cgroup_environment();
> > > > +}
> > > > +
> > > > +
> > > > +static int setup_hierarchy(void)
> > > > +{
> > > > +     return setup_bpffs() || setup_cgroups();
> > > > +}
> > > > +
> > > > +static void destroy_hierarchy(void)
> > > > +{
> > > > +     cleanup_cgroups();
> > > > +     cleanup_bpffs();
> > > > +}
> > > > +
> > > > +static void alloc_anon(size_t size)
> > > > +{
> > > > +     char *buf, *ptr;
> > > > +
> > > > +     buf = malloc(size);
> > > > +     for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
> > > > +             *ptr = 0;
> > > > +     free(buf);
> > > > +}
> > > > +
> > > > +static int induce_vmscan(void)
> > > > +{
> > > > +     char size[128];
> > > > +     int i, err;
> > > > +
> > > > +     /*
> > > > +      * Set memory.high for test parent cgroup to 1 MB to throttle
> > > > +      * allocations and invoke reclaim in children.
> > > > +      */
> > > > +     snprintf(size, 128, "%d", MB(1));
> > > > +     err = write_cgroup_file(cgroups[0].path, "memory.high", size);
> > > > +     if (!ASSERT_OK(err, "write memory.high"))
> > > > +             return err;
> > > > +     /*
> > > > +      * In every leaf cgroup, run a memory hog for a few seconds to induce
> > > > +      * reclaim then kill it.
> > > > +      */
> > > > +     for (i = N_NON_LEAF_CGROUPS; i < N_CGROUPS; i++) {
> > > > +             pid_t pid = fork();
> > > > +
> > > > +             if (pid == 0) {
> > > > +                     /* Join cgroup in the parent process workdir */
> > > > +                     join_parent_cgroup(cgroups[i].path);
> > > > +
> > > > +                     /* Allocate more memory than memory.high */
> > > > +                     alloc_anon(MB(2));
> > > > +                     exit(0);
> > > > +             } else {
> > > > +                     /* Wait for child to cause reclaim then kill it */
> > > > +                     if (!ASSERT_GT(pid, 0, "fork"))
> > > > +                             return pid;
> > > > +                     sleep(2);
> > > > +                     kill(pid, SIGKILL);
> > > > +                     waitpid(pid, NULL, 0);
> > > > +             }
> > > > +     }
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static unsigned long long get_cgroup_vmscan_delay(unsigned long long cgroup_id,
> > > > +                                               const char *file_name)
> > > > +{
> > > > +     char buf[128], path[128];
> > > > +     unsigned long long vmscan = 0, id = 0;
> > > > +     int err;
> > > > +
> > > > +     /* For every cgroup, read the file generated by cgroup_iter */
> > > > +     snprintf(path, 128, "%s%s", BPFFS_VMSCAN, file_name);
> > > > +     err = read_from_file(path, buf, 128);
> > > > +     if (!ASSERT_OK(err, "read cgroup_iter"))
> > > > +             return 0;
> > > > +
> > > > +     /* Check the output file formatting */
> > > > +     ASSERT_EQ(sscanf(buf, "cg_id: %llu, total_vmscan_delay: %llu\n",
> > > > +                      &id, &vmscan), 2, "output format");
> > > > +
> > > > +     /* Check that the cgroup_id is displayed correctly */
> > > > +     ASSERT_EQ(id, cgroup_id, "cgroup_id");
> > > > +     /* Check that the vmscan reading is non-zero */
> > > > +     ASSERT_GT(vmscan, 0, "vmscan_reading");
> > > > +     return vmscan;
> > > > +}
> > > > +
> > > > +static void check_vmscan_stats(void)
> > > > +{
> > > > +     int i;
> > > > +     unsigned long long vmscan_readings[N_CGROUPS], vmscan_root;
> > > > +
> > > > +     for (i = 0; i < N_CGROUPS; i++)
> > > > +             vmscan_readings[i] = get_cgroup_vmscan_delay(cgroups[i].id,
> > > > +                                                          cgroups[i].name);
> > > > +
> > > > +     /* Read stats for root too */
> > > > +     vmscan_root = get_cgroup_vmscan_delay(CG_ROOT_ID, CG_ROOT_NAME);
> > > > +
> > > > +     /* Check that child1 == child1_1 + child1_2 */
> > > > +     ASSERT_EQ(vmscan_readings[1], vmscan_readings[3] + vmscan_readings[4],
> > > > +               "child1_vmscan");
> > > > +     /* Check that child2 == child2_1 + child2_2 */
> > > > +     ASSERT_EQ(vmscan_readings[2], vmscan_readings[5] + vmscan_readings[6],
> > > > +               "child2_vmscan");
> > > > +     /* Check that test == child1 + child2 */
> > > > +     ASSERT_EQ(vmscan_readings[0], vmscan_readings[1] + vmscan_readings[2],
> > > > +               "test_vmscan");
> > > > +     /* Check that root >= test */
> > > > +     ASSERT_GE(vmscan_root, vmscan_readings[1], "root_vmscan");
> > > > +}
> > > > +
> > > > +static int setup_cgroup_iter(struct cgroup_hierarchical_stats *obj, int cgroup_fd,
> > > > +                          const char *file_name)
> > > > +{
> > > > +     DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> > > > +     union bpf_iter_link_info linfo = {};
> > > > +     struct bpf_link *link;
> > > > +     char path[128];
> > > > +     int err;
> > > > +
> > > > +     /*
> > > > +      * Create an iter link, parameterized by cgroup_fd.
> > > > +      * We only want to traverse one cgroup, so set the traversal order to
> > > > +      * "pre", and return 1 from dump_vmscan to stop iteration after the
> > > > +      * first cgroup.
> > > > +      */
> > > > +     linfo.cgroup.cgroup_fd = cgroup_fd;
> > > > +     linfo.cgroup.traversal_order = BPF_ITER_CGROUP_PRE;
> > > > +     opts.link_info = &linfo;
> > > > +     opts.link_info_len = sizeof(linfo);
> > > > +     link = bpf_program__attach_iter(obj->progs.dump_vmscan, &opts);
> > > > +     if (!ASSERT_OK_PTR(link, "attach iter"))
> > > > +             return libbpf_get_error(link);
> > > > +
> > > > +     /* Pin the link to a bpffs file */
> > > > +     snprintf(path, 128, "%s%s", BPFFS_VMSCAN, file_name);
> > > > +     err = bpf_link__pin(link, path);
> > > > +     ASSERT_OK(err, "pin cgroup_iter");
> > > > +     return err;
> > > > +}
> > > > +
> > > > +static int setup_progs(struct cgroup_hierarchical_stats **skel)
> > > > +{
> > > > +     int i, err;
> > > > +     struct bpf_link *link;
> > > > +     struct cgroup_hierarchical_stats *obj;
> > > > +
> > > > +     obj = cgroup_hierarchical_stats__open_and_load();
> > > > +     if (!ASSERT_OK_PTR(obj, "open_and_load"))
> > > > +             return libbpf_get_error(obj);
> > > > +
> > > > +     /* Attach cgroup_iter program that will dump the stats to cgroups */
> > > > +     for (i = 0; i < N_CGROUPS; i++) {
> > > > +             err = setup_cgroup_iter(obj, cgroups[i].fd, cgroups[i].name);
> > > > +             if (!ASSERT_OK(err, "setup_cgroup_iter"))
> > > > +                     return err;
> > > > +     }
> > > > +     /* Also dump stats for root */
> > > > +     err = setup_cgroup_iter(obj, root_cgroup_fd, CG_ROOT_NAME);
> > > > +     if (!ASSERT_OK(err, "setup_cgroup_iter"))
> > > > +             return err;
> > > > +
> > > > +     /* Attach rstat flusher */
> > > > +     link = bpf_program__attach(obj->progs.vmscan_flush);
> > > > +     if (!ASSERT_OK_PTR(link, "attach rstat"))
> > > > +             return libbpf_get_error(link);
> > > > +
> > > > +     /* Attach tracing programs that will calculate vmscan delays */
> > > > +     link = bpf_program__attach(obj->progs.vmscan_start);
> > > > +     if (!ASSERT_OK_PTR(obj, "attach raw_tracepoint"))
> > > > +             return libbpf_get_error(obj);
> > > > +
> > > > +     link = bpf_program__attach(obj->progs.vmscan_end);
> > > > +     if (!ASSERT_OK_PTR(obj, "attach raw_tracepoint"))
> > > > +             return libbpf_get_error(obj);
> > > > +
> > > > +     *skel = obj;
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +void destroy_progs(struct cgroup_hierarchical_stats *skel)
> > > > +{
> > > > +     char path[128];
> > > > +     int i;
> > > > +
> > > > +     for (i = 0; i < N_CGROUPS; i++) {
> > > > +             /* Delete files in bpffs that cgroup_iters are pinned in */
> > > > +             snprintf(path, 128, "%s%s", BPFFS_VMSCAN,
> > > > +                      cgroups[i].name);
> > > > +             ASSERT_OK(remove(path), "remove cgroup_iter pin");
> > > > +     }
> > > > +
> > > > +     /* Delete root file in bpffs */
> > > > +     snprintf(path, 128, "%s%s", BPFFS_VMSCAN, CG_ROOT_NAME);
> > > > +     ASSERT_OK(remove(path), "remove cgroup_iter root pin");
> > > > +     cgroup_hierarchical_stats__destroy(skel);
> > > > +}
> > > > +
> > > > +void test_cgroup_hierarchical_stats(void)
> > > > +{
> > > > +     struct cgroup_hierarchical_stats *skel = NULL;
> > > > +
> > > > +     if (setup_hierarchy())
> > > > +             goto hierarchy_cleanup;
> > > > +     if (setup_progs(&skel))
> > > > +             goto cleanup;
> > > > +     if (induce_vmscan())
> > > > +             goto cleanup;
> > > > +     check_vmscan_stats();
> > > > +cleanup:
> > > > +     destroy_progs(skel);
> > > > +hierarchy_cleanup:
> > > > +     destroy_hierarchy();
> > > > +}
> > > > diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> > > > new file mode 100644
> > > > index 0000000000000..fd2028f1ed70b
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> > > > @@ -0,0 +1,234 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Functions to manage eBPF programs attached to cgroup subsystems
> > > > + *
> > > > + * Copyright 2022 Google LLC.
> > > > + */
> > > > +#include "vmlinux.h"
> > > > +#include <bpf/bpf_helpers.h>
> > > > +#include <bpf/bpf_tracing.h>
> > > > +
> > > > +char _license[] SEC("license") = "GPL";
> > > > +
> > > > +/*
> > > > + * Start times are stored per-task, not per-cgroup, as multiple tasks in one
> > > > + * cgroup can perform reclain concurrently.
> > > > + */
> > > > +struct {
> > > > +     __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > > > +     __uint(map_flags, BPF_F_NO_PREALLOC);
> > > > +     __type(key, int);
> > > > +     __type(value, __u64);
> > > > +} vmscan_start_time SEC(".maps");
> > > > +
> > > > +struct vmscan_percpu {
> > > > +     /* Previous percpu state, to figure out if we have new updates */
> > > > +     __u64 prev;
> > > > +     /* Current percpu state */
> > > > +     __u64 state;
> > > > +};
> > > > +
> > > > +struct vmscan {
> > > > +     /* State propagated through children, pending aggregation */
> > > > +     __u64 pending;
> > > > +     /* Total state, including all cpus and all children */
> > > > +     __u64 state;
> > > > +};
> > > > +
> > > > +struct {
> > > > +     __uint(type, BPF_MAP_TYPE_PERCPU_HASH);
> > > > +     __uint(max_entries, 10);
> > > > +     __type(key, __u64);
> > > > +     __type(value, struct vmscan_percpu);
> > > > +} pcpu_cgroup_vmscan_elapsed SEC(".maps");
> > > > +
> > > > +struct {
> > > > +     __uint(type, BPF_MAP_TYPE_HASH);
> > > > +     __uint(max_entries, 10);
> > > > +     __type(key, __u64);
> > > > +     __type(value, struct vmscan);
> > > > +} cgroup_vmscan_elapsed SEC(".maps");
> > > > +
> > > > +extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __ksym;
> > > > +extern void cgroup_rstat_flush(struct cgroup *cgrp) __ksym;
> > > > +
> > > > +static inline struct cgroup *task_memcg(struct task_struct *task)
> > > > +{
> > > > +     return task->cgroups->subsys[memory_cgrp_id]->cgroup;
> > > > +}
> > > > +
> > > > +static inline uint64_t cgroup_id(struct cgroup *cgrp)
> > > > +{
> > > > +     return cgrp->kn->id;
> > > > +}
> > > > +
> > > > +static inline int create_vmscan_percpu_elem(__u64 cg_id, __u64 state)
> > > > +{
> > > > +     struct vmscan_percpu pcpu_init = {.state = state, .prev = 0};
> > > > +
> > > > +     if (bpf_map_update_elem(&pcpu_cgroup_vmscan_elapsed, &cg_id,
> > > > +                             &pcpu_init, BPF_NOEXIST)) {
> > > > +             bpf_printk("failed to create pcpu entry for cgroup %llu\n"
> > > > +                        , cg_id);
> > > > +             return 1;
> > > > +     }
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static inline int create_vmscan_elem(__u64 cg_id, __u64 state, __u64 pending)
> > > > +{
> > > > +     struct vmscan init = {.state = state, .pending = pending};
> > > > +
> > > > +     if (bpf_map_update_elem(&cgroup_vmscan_elapsed, &cg_id,
> > > > +                             &init, BPF_NOEXIST)) {
> > > > +             bpf_printk("failed to create entry for cgroup %llu\n"
> > > > +                        , cg_id);
> > > > +             return 1;
> > > > +     }
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
> > > > +int BPF_PROG(vmscan_start, struct lruvec *lruvec, struct scan_control *sc)
> > > > +{
> > > > +     struct task_struct *task = bpf_get_current_task_btf();
> > > > +     __u64 *start_time_ptr;
> > > > +
> > > > +     start_time_ptr = bpf_task_storage_get(&vmscan_start_time, task, 0,
> > > > +                                       BPF_LOCAL_STORAGE_GET_F_CREATE);
> > > > +     if (!start_time_ptr) {
> > > > +             bpf_printk("error retrieving storage\n");
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     *start_time_ptr = bpf_ktime_get_ns();
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +SEC("tp_btf/mm_vmscan_memcg_reclaim_end")
> > > > +int BPF_PROG(vmscan_end, struct lruvec *lruvec, struct scan_control *sc)
> > > > +{
> > > > +     struct vmscan_percpu *pcpu_stat;
> > > > +     struct task_struct *current = bpf_get_current_task_btf();
> > > > +     struct cgroup *cgrp;
> > > > +     __u64 *start_time_ptr;
> > > > +     __u64 current_elapsed, cg_id;
> > > > +     __u64 end_time = bpf_ktime_get_ns();
> > > > +
> > > > +     /*
> > > > +      * cgrp is the first parent cgroup of current that has memcg enabled in
> > > > +      * its subtree_control, or NULL if memcg is disabled in the entire tree.
> > > > +      * In a cgroup hierarchy like this:
> > > > +      *                               a
> > > > +      *                              / \
> > > > +      *                             b   c
> > > > +      *  If "a" has memcg enabled, while "b" doesn't, then processes in "b"
> > > > +      *  will accumulate their stats directly to "a". This makes sure that no
> > > > +      *  stats are lost from processes in leaf cgroups that don't have memcg
> > > > +      *  enabled, but only exposes stats for cgroups that have memcg enabled.
> > > > +      */
> > > > +     cgrp = task_memcg(current);
> > > > +     if (!cgrp)
> > > > +             return 0;
> > > > +
> > > > +     cg_id = cgroup_id(cgrp);
> > > > +     start_time_ptr = bpf_task_storage_get(&vmscan_start_time, current, 0,
> > > > +                                           BPF_LOCAL_STORAGE_GET_F_CREATE);
> > > > +     if (!start_time_ptr) {
> > > > +             bpf_printk("error retrieving storage local storage\n");
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     current_elapsed = end_time - *start_time_ptr;
> > > > +     pcpu_stat = bpf_map_lookup_elem(&pcpu_cgroup_vmscan_elapsed,
> > > > +                                     &cg_id);
> > > > +     if (pcpu_stat)
> > > > +             __sync_fetch_and_add(&pcpu_stat->state, current_elapsed);
> > > > +     else
> > > > +             create_vmscan_percpu_elem(cg_id, current_elapsed);
> > > > +
> > > > +     cgroup_rstat_updated(cgrp, bpf_get_smp_processor_id());
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +SEC("fentry/bpf_rstat_flush")
> > > > +int BPF_PROG(vmscan_flush, struct cgroup *cgrp, struct cgroup *parent, int cpu)
> > > > +{
> > > > +     struct vmscan_percpu *pcpu_stat;
> > > > +     struct vmscan *total_stat, *parent_stat;
> > > > +     __u64 cg_id = cgroup_id(cgrp);
> > > > +     __u64 parent_cg_id = parent ? cgroup_id(parent) : 0;
> > > > +     __u64 *pcpu_vmscan;
> > > > +     __u64 state;
> > > > +     __u64 delta = 0;
> > > > +
> > > > +     /* Add CPU changes on this level since the last flush */
> > > > +     pcpu_stat = bpf_map_lookup_percpu_elem(&pcpu_cgroup_vmscan_elapsed,
> > > > +                                            &cg_id, cpu);
> > > > +     if (pcpu_stat) {
> > > > +             state = pcpu_stat->state;
> > > > +             delta += state - pcpu_stat->prev;
> > > > +             pcpu_stat->prev = state;
> > > > +     }
> > > > +
> > > > +     total_stat = bpf_map_lookup_elem(&cgroup_vmscan_elapsed, &cg_id);
> > > > +     if (!total_stat) {
> > > > +             create_vmscan_elem(cg_id, delta, 0);
> > > > +             goto update_parent;
> > > > +     }
> > > > +
> > > > +     /* Collect pending stats from subtree */
> > > > +     if (total_stat->pending) {
> > > > +             delta += total_stat->pending;
> > > > +             total_stat->pending = 0;
> > > > +     }
> > > > +
> > > > +     /* Propagate changes to this cgroup's total */
> > > > +     total_stat->state += delta;
> > > > +
> > > > +update_parent:
> > > > +     /* Skip if there are no changes to propagate, or no parent */
> > > > +     if (!delta || !parent_cg_id)
> > > > +             return 0;
> > > > +
> > > > +     /* Propagate changes to cgroup's parent */
> > > > +     parent_stat = bpf_map_lookup_elem(&cgroup_vmscan_elapsed,
> > > > +                                       &parent_cg_id);
> > > > +     if (parent_stat)
> > > > +             parent_stat->pending += delta;
> > > > +     else
> > > > +             create_vmscan_elem(parent_cg_id, 0, delta);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +SEC("iter.s/cgroup")
> > > > +int BPF_PROG(dump_vmscan, struct bpf_iter_meta *meta, struct cgroup *cgrp)
> > > > +{
> > > > +     struct seq_file *seq = meta->seq;
> > > > +     struct vmscan *total_stat;
> > > > +     __u64 cg_id = cgroup_id(cgrp);
> > > > +
> > > > +     /* Do nothing for the terminal call */
> > > > +     if (!cgrp)
> > > > +             return 1;
> > > > +
> > > > +     /* Flush the stats to make sure we get the most updated numbers */
> > > > +     cgroup_rstat_flush(cgrp);
> > > > +
> > > > +     total_stat = bpf_map_lookup_elem(&cgroup_vmscan_elapsed, &cg_id);
> > > > +     if (!total_stat) {
> > > > +             bpf_printk("error finding stats for cgroup %llu\n", cg_id);
> > > > +             BPF_SEQ_PRINTF(seq, "cg_id: %llu, total_vmscan_delay: -1\n",
> > > > +                            cg_id);
> > > > +             return 1;
> > > > +     }
> > > > +     BPF_SEQ_PRINTF(seq, "cg_id: %llu, total_vmscan_delay: %llu\n",
> > > > +                    cg_id, total_stat->state);
> > > > +
> > > > +     /*
> > > > +      * We only dump stats for one cgroup here, so return 1 to stop
> > > > +      * iteration after the first cgroup.
> > > > +      */
> > > > +     return 1;
> > > > +}
