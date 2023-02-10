Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB15E692B6E
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 00:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBJXjB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 18:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjBJXi7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 18:38:59 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666E1831EC
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 15:38:36 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id c26so14917459ejz.10
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 15:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YjQRA50VlVZqpB19hw7HQcbCcXZP6aRNrImymdLVUQA=;
        b=AcFovtm9IBIwoZOB5qBQ3qmZT5oSJ8FnxSrYiCzXJIgNpcdfA3VtKu0khWjdKt3S3Q
         UF1miJmx1R8N9FNsoyzl7g9LPy+qBcYW5bclDZz7ymj4tllQORvBdZfF/Mz4Nfu8QWg8
         MvlDuKwX4jqLGoHZw1a9V2lc0mymJiP+hhkmWoko2+pYnPaADxmQmgD0xEDxKBPDH20c
         w/kOJzJxdMUFd8kJmamGE2t4UoRJAjV5EUxxOt5HLJLJw6KFiBxT+n4B0kx6vu5HRM5m
         BgaTUTDhMFM/z5th99RdE50p4ypHiD3BytBXz+5A9BHHumUfVszhqbOQgNXjkEic2vCk
         jkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjQRA50VlVZqpB19hw7HQcbCcXZP6aRNrImymdLVUQA=;
        b=hZ3yqY0b3DjkhRRFzMtZk9OUdnYKrkKMFmkHKLW5dVsRxBsl+b/DNCs/DwT8QbG67f
         cZcjCU/9x3t9Wlz6yJTVllNAoeBWBjnpAouvqbG9vKhj35B/g/cRoZYv6Bw5j5B3gJ0f
         lcZiGbnrZ8fZxOWWYSfu5fEH01/Il7hkL421yFxXbv/+Oa11Ui8NIG9CqgEhDSFH/5vH
         5KvdauxwoIjOURLx0a1/kQiRlAvPvYx5soIezfr0NVHfJB/E+1vezAkiYQBqlYHfMVmb
         CQAsFieA/mFjUPWeiLTn1Cu5OrwQHWK1b6p0mqJQUf1axsMLJIcNLDI3WFQ2bkiCrSyn
         0nCQ==
X-Gm-Message-State: AO0yUKXI9hdyf1g3/P9EQsiDTcOnktACXdV1GdZNnQPMR2zlwNfceIgG
        /v8Jac24bJzSt9l4z7vAFe8IaC/0DFU8zA/4S/Qd4kmk
X-Google-Smtp-Source: AK7set+S1BjWF6mfCmFYZ2Wew2IKC2MCBBRSt8H5sjfKILKXCTPO8FNQYVr9M3Q4m+YE+G8Fvcbrfo9VjYHUK7D1D/4=
X-Received: by 2002:a17:906:3c11:b0:88d:ba79:4312 with SMTP id
 h17-20020a1709063c1100b0088dba794312mr2016495ejg.2.1676072310940; Fri, 10 Feb
 2023 15:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20230210001210.395194-1-iii@linux.ibm.com>
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Feb 2023 15:38:19 -0800
Message-ID: <CAEf4BzZo9=S4cqy0T+q4XfKaPZxSGdibDN0c3yHmBuCSAqf8Mg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/16] selftests/bpf: Add Memory Sanitizer support
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 9, 2023 at 4:12 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> v1: https://lore.kernel.org/bpf/20230208205642.270567-1-iii@linux.ibm.com/
> v1 -> v2:
> - Apply runqslower's EXTRA_CFLAGS and EXTRA_LDFLAGS unconditionally.
> - Use u64 for uretprobe_byname2_rc.
> - Use BPF_UPROBE() instead of PT_REGS_xxx().
> - Use void * instead of char * for pointer arithmetic.
> - Rename libbpf_mark_defined() to __libbpf_mark_mem_written(), add
>   convenience wrappers.
> - Add a comment about defined(__has_feature) &&
>   __has_feature(memory_sanitizer).
> - Extract is_percpu_bpf_map_type().
> - Introduce bpf_get_{map,prog,link,btf}_info_by_fd() and convert all
>   code to use them. If it's too early for that, in particular for
>   samples and perf, the respective patches can be dropped.

perf is too early, the rest is fine

I applied first 7 patches for now, I'll go review the rest a bit later.

> - Unpoison infos returned by these functions, paying attention to
>   potentially missing fields. Use macros to reduce boilerplate.
> - Move capget() unpoisoning to LLVM [5].
> - With that, only a few cases remain where data needs to be
>   unpoisoned in selftests.
>
> Hi,
>
> This series adds support for building selftests with Memory Sanitizer
> [1] - a compiler instrumentation for detecting usages of undefined
> memory.
>
> The primary motivation is to make sure that such usages do not occur
> during testing, since the ones that have not been caught yet are likely
> to affect the CI results on s390x. The secondary motivation is to be
> able to use libbpf in applications instrumented with MSan (it requires
> all code running in a process to be instrumented).
>
> MSan has found one real issue (fixed by patch 7), and of course a
> number of false positives. This rest of this series deals with
> preparing the build infrastructure and adding MSan annotations to
> libbpf and selftests.
>
> The setup I'm using is as follows:
>
> - Instrumented zlib-ng and patched elfutils [2].
> - Patched LLVM [3, 4, 5].
> - Clang-built kernel.
> - Building tests with MSan:
>
>       make \
>           -C tools/testing/selftests/bpf \
>           CC="ccache clang-17" \
>           LD=ld \
>           HOSTCC="ccache clang-17" \
>           HOSTLD=ld \
>           LLVM=1 \
>           LLVM_SUFFIX=-17 \
>           OBJCOPY=objcopy \
>           CLANG="ccache clang-17" \
>           LLVM_STRIP=llvm-strip-17 \
>           LLC=llc-17 \
>           BPF_GCC= \
>           SAN_CFLAGS="-fsanitize=memory \
>                       -fsanitize-memory-track-origins \
>                       -I$PWD/../zlib-ng/dist/include \
>                       -I$PWD/../elfutils/dist/include" \
>           SAN_LDFLAGS="-fsanitize=memory \
>                        -fsanitize-memory-track-origins \
>                        -L$PWD/../zlib-ng/dist/lib \
>                        -L$PWD/../elfutils/dist/lib" \
>           CROSS_COMPILE=s390x-linux-gnu-
>
>   It's a lot of options, but most of them are trivial: setting up LLVM
>   toolchain, taking in account s390x quirks, setting up MSan and
>   disabling bpf-gcc. The CROSS_COMPILE one is a hack: instrumenting
>   bpftool turned out to be too complicated from the build system
>   perspective, so having CROSS_COMPILE forces compiling the host libbpf
>   uninstrumented and guest libbpf instrumented.
>
> - Running tests with MSan on s390x:
>
>       LD_LIBRARY_PATH=<instrumented libs> ./test_progs
>       ...
>       Summary: 282/1624 PASSED, 23 SKIPPED, 4 FAILED
>
>   The 4 failures happen without MSan too, they are already known and
>   denylisted.
>
> Best regards,
> Ilya
>
> [1] https://clang.llvm.org/docs/MemorySanitizer.html
> [2] https://sourceware.org/pipermail/elfutils-devel/2023q1/005831.html
> [3] https://reviews.llvm.org/D143296
> [4] https://reviews.llvm.org/D143330
> [5] https://reviews.llvm.org/D143660
>
> Ilya Leoshkevich (16):
>   selftests/bpf: Quote host tools
>   tools: runqslower: Add EXTRA_CFLAGS and EXTRA_LDFLAGS support
>   selftests/bpf: Split SAN_CFLAGS and SAN_LDFLAGS
>   selftests/bpf: Forward SAN_CFLAGS and SAN_LDFLAGS to runqslower and
>     libbpf
>   selftests/bpf: Attach to fopen()/fclose() in uprobe_autoattach
>   selftests/bpf: Attach to fopen()/fclose() in attach_probe
>   libbpf: Fix alen calculation in libbpf_nla_dump_errormsg()
>   libbpf: Introduce bpf_{btf,link,map,prog}_get_info_by_fd()
>   libbpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
>   bpftool: Use bpf_{btf,link,map,prog}_get_info_by_fd()
>   perf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
>   samples/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
>   selftests/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
>   libbpf: Factor out is_percpu_bpf_map_type()
>   libbpf: Add MSan annotations
>   selftests/bpf: Add MSan annotations
>
>  samples/bpf/test_map_in_map_user.c            |   2 +-
>  samples/bpf/xdp1_user.c                       |   2 +-
>  samples/bpf/xdp_adjust_tail_user.c            |   2 +-
>  samples/bpf/xdp_fwd_user.c                    |   4 +-
>  samples/bpf/xdp_redirect_cpu_user.c           |   4 +-
>  samples/bpf/xdp_rxq_info_user.c               |   2 +-
>  samples/bpf/xdp_sample_pkts_user.c            |   2 +-
>  samples/bpf/xdp_tx_iptunnel_user.c            |   2 +-
>  tools/bpf/bpftool/btf.c                       |  13 +-
>  tools/bpf/bpftool/btf_dumper.c                |   4 +-
>  tools/bpf/bpftool/cgroup.c                    |   4 +-
>  tools/bpf/bpftool/common.c                    |  13 +-
>  tools/bpf/bpftool/link.c                      |   4 +-
>  tools/bpf/bpftool/main.h                      |   3 +-
>  tools/bpf/bpftool/map.c                       |   8 +-
>  tools/bpf/bpftool/prog.c                      |  24 +--
>  tools/bpf/bpftool/struct_ops.c                |   6 +-
>  tools/bpf/runqslower/Makefile                 |   2 +
>  tools/lib/bpf/bpf.c                           | 179 +++++++++++++++++-
>  tools/lib/bpf/bpf.h                           |  13 ++
>  tools/lib/bpf/btf.c                           |   9 +-
>  tools/lib/bpf/libbpf.c                        |  26 +--
>  tools/lib/bpf/libbpf.map                      |   5 +
>  tools/lib/bpf/libbpf_internal.h               |  46 +++++
>  tools/lib/bpf/netlink.c                       |   2 +-
>  tools/lib/bpf/nlattr.c                        |   2 +-
>  tools/lib/bpf/ringbuf.c                       |   4 +-
>  tools/perf/util/bpf-utils.c                   |   4 +-
>  tools/perf/util/bpf_counter.c                 |   2 +-
>  tools/perf/util/bpf_counter.h                 |   6 +-
>  tools/testing/selftests/bpf/Makefile          |  17 +-
>  .../bpf/map_tests/map_in_map_batch_ops.c      |   2 +-
>  .../selftests/bpf/prog_tests/attach_probe.c   |  10 +-
>  .../selftests/bpf/prog_tests/bpf_iter.c       |   8 +-
>  .../selftests/bpf/prog_tests/bpf_obj_id.c     |  20 +-
>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |   3 +
>  tools/testing/selftests/bpf/prog_tests/btf.c  |  24 +--
>  .../selftests/bpf/prog_tests/btf_map_in_map.c |   2 +-
>  .../selftests/bpf/prog_tests/check_mtu.c      |   2 +-
>  .../selftests/bpf/prog_tests/enable_stats.c   |   2 +-
>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  14 +-
>  .../bpf/prog_tests/flow_dissector_reattach.c  |  10 +-
>  .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |   4 +-
>  .../selftests/bpf/prog_tests/lsm_cgroup.c     |   3 +-
>  .../selftests/bpf/prog_tests/metadata.c       |   8 +-
>  tools/testing/selftests/bpf/prog_tests/mmap.c |   2 +-
>  .../selftests/bpf/prog_tests/perf_link.c      |   2 +-
>  .../selftests/bpf/prog_tests/pinning.c        |   2 +-
>  .../selftests/bpf/prog_tests/prog_run_opts.c  |   2 +-
>  .../selftests/bpf/prog_tests/recursion.c      |   4 +-
>  .../selftests/bpf/prog_tests/send_signal.c    |   2 +
>  .../selftests/bpf/prog_tests/sockmap_basic.c  |   6 +-
>  .../bpf/prog_tests/task_local_storage.c       |   8 +-
>  .../testing/selftests/bpf/prog_tests/tc_bpf.c |   4 +-
>  .../bpf/prog_tests/tp_attach_query.c          |   9 +-
>  .../bpf/prog_tests/unpriv_bpf_disabled.c      |   8 +-
>  .../bpf/prog_tests/uprobe_autoattach.c        |  14 +-
>  .../selftests/bpf/prog_tests/verif_stats.c    |   5 +-
>  .../selftests/bpf/prog_tests/xdp_attach.c     |   4 +-
>  .../selftests/bpf/prog_tests/xdp_bonding.c    |   3 +
>  .../bpf/prog_tests/xdp_cpumap_attach.c        |   8 +-
>  .../bpf/prog_tests/xdp_devmap_attach.c        |   8 +-
>  .../selftests/bpf/prog_tests/xdp_info.c       |   2 +-
>  .../selftests/bpf/prog_tests/xdp_link.c       |  10 +-
>  .../selftests/bpf/progs/test_attach_probe.c   |  11 +-
>  .../bpf/progs/test_uprobe_autoattach.c        |  16 +-
>  tools/testing/selftests/bpf/test_maps.c       |   2 +-
>  .../selftests/bpf/test_skb_cgroup_id_user.c   |   2 +-
>  .../bpf/test_tcp_check_syncookie_user.c       |   2 +-
>  tools/testing/selftests/bpf/test_verifier.c   |   8 +-
>  tools/testing/selftests/bpf/testing_helpers.c |   2 +-
>  tools/testing/selftests/bpf/xdp_synproxy.c    |  15 +-
>  72 files changed, 478 insertions(+), 211 deletions(-)
>
> --
> 2.39.1
>
