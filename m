Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 998F4140B05
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 14:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgAQNhX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 08:37:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26861 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727231AbgAQNgp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jan 2020 08:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579268203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9UHfRadrERMA1dU8MCwmB7dMaKqgeyt0Vqi49f22blc=;
        b=cTfpSQgPAi5a08qqHyDqqFCDF6RUC+IqqzNlrU6XAF74EzGARq2KKwZcN6HqbFbgx44uQG
        cp1oEd8UL5ROciz5I6EZ/4L4qE5Gid5UIuJZQkWd366SVpedH0zz1VOBCI1JRYhpvBMIuU
        RNU0NNYXGIg91yO8++AWb513RhHpgFk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-G8HrTCYuNHiepVUmgattag-1; Fri, 17 Jan 2020 08:36:42 -0500
X-MC-Unique: G8HrTCYuNHiepVUmgattag-1
Received: by mail-lf1-f69.google.com with SMTP id i29so4355670lfc.18
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 05:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=9UHfRadrERMA1dU8MCwmB7dMaKqgeyt0Vqi49f22blc=;
        b=ntoWl292hkGWmzlpaZ9SxiXTm7x94LqZQ8Gg+cw1XRMGE3O+S6xY2XNAh3mXR/3vYh
         1LdbBYJ0FdUKeYnL6c5bjDK0m+uv3ACihVAGP4vcWKRweSSWZMRwVH6nVKqJwJVPGWg6
         F+XzNYcd6ai80MGX+a/TU4SZ+Iv32ixmAV2i8we5w/egUuRTp7I7n+jAEWL4ZIh8HrPH
         votXWLHb9/AVfPyVGlvjsC9zrTQKorh6qK/1ExYjHQulmM9oUNRl4wNRi+z6iih5BXn4
         tYV/Q45JimpYFvOsSf2/KRuGpAbe+xNtchtvnx8+cLoWWfdOFFNh/7E6Tt1jt8pxZNMr
         rgDQ==
X-Gm-Message-State: APjAAAVvEMsM19XtRdeojYzp/6L7CuO+OfjLQjW2FuZCJuvsd0WdaKKi
        B7IegF8Bu0Mf05Mx6eYVar+1BLcyDmgUJkoe75BdCSGRH/ZZ4kTEjhdUtYNQ9PjPCrq4F63cH84
        hOiAIxTGsiDxE
X-Received: by 2002:a2e:8316:: with SMTP id a22mr5562709ljh.141.1579268200717;
        Fri, 17 Jan 2020 05:36:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3yrkOVyuX4zFdp7e3Ukmu9NChlM1OeWzm2a0yJyiWFBPYA3QiZ2IAyc8ifsIuGPXY653WYQ==
X-Received: by 2002:a2e:8316:: with SMTP id a22mr5562677ljh.141.1579268200380;
        Fri, 17 Jan 2020 05:36:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b19sm12450246ljk.25.2020.01.17.05.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:36:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2650D1804D6; Fri, 17 Jan 2020 14:36:37 +0100 (CET)
Subject: [PATCH bpf-next v4 00/10] tools: Use consistent libbpf include paths
 everywhere
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Fri, 17 Jan 2020 14:36:37 +0100
Message-ID: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We are currently being somewhat inconsistent with the libbpf include paths,
which makes it difficult to move files from the kernel into an external
libbpf-using project without adjusting include paths.

Having the bpf/ subdir of $INCLUDEDIR in the include path has never been a
requirement for building against libbpf before, and indeed the libbpf pkg-config
file doesn't include it. So let's make all libbpf includes across the kernel
tree use the bpf/ prefix in their includes. Since bpftool skeleton generation
emits code with a libbpf include, this also ensures that those can be used in
existing external projects using the regular pkg-config include path.

This turns out to be a somewhat invasive change in the number of files touched;
however, the actual changes to files are fairly trivial (most of them are simply
made with 'sed'). The series is split to make the change for one tool subdir at
a time, while trying not to break the build along the way. It is structured like
this:

- Patch 1-3: Trivial fixes to Makefiles for issues I discovered while changing
  the include paths.

- Patch 4-8: Change the include directives to use the bpf/ prefix, and updates
  Makefiles to make sure tools/lib/ is part of the include path, but without
  removing tools/lib/bpf

- Patch 9-10: Remove tools/lib/bpf from include paths to make sure we don't
  inadvertently re-introduce includes without the bpf/ prefix.

Changelog:

v4:
  - Move runqslower error on missing BTF into make rule
  - Make sure we don't always force a rebuild selftests
  - Rebase on latest bpf-next (dropping patch 11)

v3:
  - Don't add the kernel build dir to the runqslower Makefile, pass it in from
    selftests instead.
  - Use libbpf's 'make install_headers' in selftests instead of trying to
    generate bpf_helper_defs.h in-place (to also work on read-only filesystems).
  - Use a scratch builddir for both libbpf and bpftool when building in selftests.
  - Revert bpf_helpers.h to quoted include instead of angled include with a bpf/
    prefix.
  - Fix a few style nits from Andrii

v2:
  - Do a full cleanup of libbpf includes instead of just changing the
    bpf_helper_defs.h include.

---

Toke Høiland-Jørgensen (10):
      samples/bpf: Don't try to remove user's homedir on clean
      tools/bpf/runqslower: Fix override option for VMLINUX_BTF
      selftests: Pass VMLINUX_BTF to runqslower Makefile
      tools/runqslower: Use consistent include paths for libbpf
      selftests: Use consistent include paths for libbpf
      bpftool: Use consistent include paths for libbpf
      perf: Use consistent include paths for libbpf
      samples/bpf: Use consistent include paths for libbpf
      selftests: Remove tools/lib/bpf from include path
      tools/runqslower: Remove tools/lib/bpf from include path


 samples/bpf/Makefile                               |    5 +-
 samples/bpf/cpustat_kern.c                         |    2 -
 samples/bpf/fds_example.c                          |    2 -
 samples/bpf/hbm.c                                  |    4 +
 samples/bpf/hbm_kern.h                             |    4 +
 samples/bpf/ibumad_kern.c                          |    2 -
 samples/bpf/ibumad_user.c                          |    2 -
 samples/bpf/lathist_kern.c                         |    2 -
 samples/bpf/lwt_len_hist_kern.c                    |    2 -
 samples/bpf/map_perf_test_kern.c                   |    4 +
 samples/bpf/offwaketime_kern.c                     |    4 +
 samples/bpf/offwaketime_user.c                     |    2 -
 samples/bpf/parse_ldabs.c                          |    2 -
 samples/bpf/parse_simple.c                         |    2 -
 samples/bpf/parse_varlen.c                         |    2 -
 samples/bpf/sampleip_kern.c                        |    4 +
 samples/bpf/sampleip_user.c                        |    2 -
 samples/bpf/sock_flags_kern.c                      |    2 -
 samples/bpf/sockex1_kern.c                         |    2 -
 samples/bpf/sockex1_user.c                         |    2 -
 samples/bpf/sockex2_kern.c                         |    2 -
 samples/bpf/sockex2_user.c                         |    2 -
 samples/bpf/sockex3_kern.c                         |    2 -
 samples/bpf/spintest_kern.c                        |    4 +
 samples/bpf/spintest_user.c                        |    2 -
 samples/bpf/syscall_tp_kern.c                      |    2 -
 samples/bpf/task_fd_query_kern.c                   |    2 -
 samples/bpf/task_fd_query_user.c                   |    2 -
 samples/bpf/tc_l2_redirect_kern.c                  |    2 -
 samples/bpf/tcbpf1_kern.c                          |    2 -
 samples/bpf/tcp_basertt_kern.c                     |    4 +
 samples/bpf/tcp_bufs_kern.c                        |    4 +
 samples/bpf/tcp_clamp_kern.c                       |    4 +
 samples/bpf/tcp_cong_kern.c                        |    4 +
 samples/bpf/tcp_dumpstats_kern.c                   |    4 +
 samples/bpf/tcp_iw_kern.c                          |    4 +
 samples/bpf/tcp_rwnd_kern.c                        |    4 +
 samples/bpf/tcp_synrto_kern.c                      |    4 +
 samples/bpf/tcp_tos_reflect_kern.c                 |    4 +
 samples/bpf/test_cgrp2_tc_kern.c                   |    2 -
 samples/bpf/test_current_task_under_cgroup_kern.c  |    2 -
 samples/bpf/test_lwt_bpf.c                         |    2 -
 samples/bpf/test_map_in_map_kern.c                 |    4 +
 samples/bpf/test_overhead_kprobe_kern.c            |    4 +
 samples/bpf/test_overhead_raw_tp_kern.c            |    2 -
 samples/bpf/test_overhead_tp_kern.c                |    2 -
 samples/bpf/test_probe_write_user_kern.c           |    4 +
 samples/bpf/trace_event_kern.c                     |    4 +
 samples/bpf/trace_event_user.c                     |    2 -
 samples/bpf/trace_output_kern.c                    |    2 -
 samples/bpf/trace_output_user.c                    |    2 -
 samples/bpf/tracex1_kern.c                         |    4 +
 samples/bpf/tracex2_kern.c                         |    4 +
 samples/bpf/tracex3_kern.c                         |    4 +
 samples/bpf/tracex4_kern.c                         |    4 +
 samples/bpf/tracex5_kern.c                         |    4 +
 samples/bpf/tracex6_kern.c                         |    2 -
 samples/bpf/tracex7_kern.c                         |    2 -
 samples/bpf/xdp1_kern.c                            |    2 -
 samples/bpf/xdp1_user.c                            |    4 +
 samples/bpf/xdp2_kern.c                            |    2 -
 samples/bpf/xdp2skb_meta_kern.c                    |    2 -
 samples/bpf/xdp_adjust_tail_kern.c                 |    2 -
 samples/bpf/xdp_adjust_tail_user.c                 |    4 +
 samples/bpf/xdp_fwd_kern.c                         |    2 -
 samples/bpf/xdp_fwd_user.c                         |    2 -
 samples/bpf/xdp_monitor_kern.c                     |    2 -
 samples/bpf/xdp_redirect_cpu_kern.c                |    2 -
 samples/bpf/xdp_redirect_cpu_user.c                |    2 -
 samples/bpf/xdp_redirect_kern.c                    |    2 -
 samples/bpf/xdp_redirect_map_kern.c                |    2 -
 samples/bpf/xdp_redirect_map_user.c                |    2 -
 samples/bpf/xdp_redirect_user.c                    |    2 -
 samples/bpf/xdp_router_ipv4_kern.c                 |    2 -
 samples/bpf/xdp_router_ipv4_user.c                 |    2 -
 samples/bpf/xdp_rxq_info_kern.c                    |    2 -
 samples/bpf/xdp_rxq_info_user.c                    |    4 +
 samples/bpf/xdp_sample_pkts_kern.c                 |    2 -
 samples/bpf/xdp_sample_pkts_user.c                 |    2 -
 samples/bpf/xdp_tx_iptunnel_kern.c                 |    2 -
 samples/bpf/xdp_tx_iptunnel_user.c                 |    2 -
 samples/bpf/xdpsock_kern.c                         |    2 -
 samples/bpf/xdpsock_user.c                         |    6 +-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst    |    2 -
 tools/bpf/bpftool/Makefile                         |    2 -
 tools/bpf/bpftool/btf.c                            |    8 +--
 tools/bpf/bpftool/btf_dumper.c                     |    2 -
 tools/bpf/bpftool/cgroup.c                         |    2 -
 tools/bpf/bpftool/common.c                         |    4 +
 tools/bpf/bpftool/feature.c                        |    4 +
 tools/bpf/bpftool/gen.c                            |   10 ++--
 tools/bpf/bpftool/jit_disasm.c                     |    2 -
 tools/bpf/bpftool/main.c                           |    4 +
 tools/bpf/bpftool/map.c                            |    4 +
 tools/bpf/bpftool/map_perf_ring.c                  |    4 +
 tools/bpf/bpftool/net.c                            |    8 +--
 tools/bpf/bpftool/netlink_dumper.c                 |    4 +
 tools/bpf/bpftool/perf.c                           |    2 -
 tools/bpf/bpftool/prog.c                           |    6 +-
 tools/bpf/bpftool/xlated_dumper.c                  |    2 -
 tools/bpf/runqslower/Makefile                      |   23 ++++----
 tools/bpf/runqslower/runqslower.bpf.c              |    2 -
 tools/bpf/runqslower/runqslower.c                  |    4 +
 tools/perf/examples/bpf/5sec.c                     |    2 -
 tools/perf/examples/bpf/empty.c                    |    2 -
 tools/perf/examples/bpf/sys_enter_openat.c         |    2 -
 tools/perf/include/bpf/pid_filter.h                |    2 -
 tools/perf/include/bpf/stdio.h                     |    2 -
 tools/perf/include/bpf/unistd.h                    |    2 -
 tools/testing/selftests/bpf/.gitignore             |    2 -
 tools/testing/selftests/bpf/Makefile               |   57 +++++++++++++-------
 tools/testing/selftests/bpf/bpf_tcp_helpers.h      |    4 +
 tools/testing/selftests/bpf/bpf_trace_helpers.h    |    2 -
 tools/testing/selftests/bpf/bpf_util.h             |    2 -
 tools/testing/selftests/bpf/prog_tests/cpu_mask.c  |    2 -
 .../testing/selftests/bpf/prog_tests/perf_buffer.c |    2 -
 tools/testing/selftests/bpf/progs/bpf_dctcp.c      |    4 +
 tools/testing/selftests/bpf/progs/bpf_flow.c       |    4 +
 tools/testing/selftests/bpf/progs/connect4_prog.c  |    4 +
 tools/testing/selftests/bpf/progs/connect6_prog.c  |    4 +
 tools/testing/selftests/bpf/progs/dev_cgroup.c     |    2 -
 tools/testing/selftests/bpf/progs/fentry_test.c    |    2 -
 tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c  |    2 -
 .../selftests/bpf/progs/fexit_bpf2bpf_simple.c     |    2 -
 tools/testing/selftests/bpf/progs/fexit_test.c     |    2 -
 .../selftests/bpf/progs/get_cgroup_id_kern.c       |    2 -
 tools/testing/selftests/bpf/progs/kfree_skb.c      |    4 +
 tools/testing/selftests/bpf/progs/loop1.c          |    4 +
 tools/testing/selftests/bpf/progs/loop2.c          |    4 +
 tools/testing/selftests/bpf/progs/loop3.c          |    4 +
 tools/testing/selftests/bpf/progs/loop4.c          |    2 -
 tools/testing/selftests/bpf/progs/loop5.c          |    2 -
 tools/testing/selftests/bpf/progs/netcnt_prog.c    |    2 -
 tools/testing/selftests/bpf/progs/pyperf.h         |    2 -
 .../testing/selftests/bpf/progs/sample_map_ret0.c  |    2 -
 tools/testing/selftests/bpf/progs/sendmsg4_prog.c  |    4 +
 tools/testing/selftests/bpf/progs/sendmsg6_prog.c  |    4 +
 .../selftests/bpf/progs/socket_cookie_prog.c       |    4 +
 .../selftests/bpf/progs/sockmap_parse_prog.c       |    4 +
 .../selftests/bpf/progs/sockmap_tcp_msg_prog.c     |    4 +
 .../selftests/bpf/progs/sockmap_verdict_prog.c     |    4 +
 .../testing/selftests/bpf/progs/sockopt_inherit.c  |    2 -
 tools/testing/selftests/bpf/progs/sockopt_multi.c  |    2 -
 tools/testing/selftests/bpf/progs/sockopt_sk.c     |    2 -
 tools/testing/selftests/bpf/progs/strobemeta.h     |    2 -
 tools/testing/selftests/bpf/progs/tailcall1.c      |    2 -
 tools/testing/selftests/bpf/progs/tailcall2.c      |    2 -
 tools/testing/selftests/bpf/progs/tailcall3.c      |    2 -
 tools/testing/selftests/bpf/progs/tailcall4.c      |    2 -
 tools/testing/selftests/bpf/progs/tailcall5.c      |    2 -
 tools/testing/selftests/bpf/progs/tcp_rtt.c        |    2 -
 .../testing/selftests/bpf/progs/test_adjust_tail.c |    2 -
 .../selftests/bpf/progs/test_attach_probe.c        |    2 -
 tools/testing/selftests/bpf/progs/test_btf_haskv.c |    2 -
 tools/testing/selftests/bpf/progs/test_btf_newkv.c |    2 -
 tools/testing/selftests/bpf/progs/test_btf_nokv.c  |    2 -
 .../testing/selftests/bpf/progs/test_core_extern.c |    2 -
 .../selftests/bpf/progs/test_core_reloc_arrays.c   |    4 +
 .../bpf/progs/test_core_reloc_bitfields_direct.c   |    4 +
 .../bpf/progs/test_core_reloc_bitfields_probed.c   |    4 +
 .../bpf/progs/test_core_reloc_existence.c          |    4 +
 .../selftests/bpf/progs/test_core_reloc_flavors.c  |    4 +
 .../selftests/bpf/progs/test_core_reloc_ints.c     |    4 +
 .../selftests/bpf/progs/test_core_reloc_kernel.c   |    4 +
 .../selftests/bpf/progs/test_core_reloc_misc.c     |    4 +
 .../selftests/bpf/progs/test_core_reloc_mods.c     |    4 +
 .../selftests/bpf/progs/test_core_reloc_nesting.c  |    4 +
 .../bpf/progs/test_core_reloc_primitives.c         |    4 +
 .../bpf/progs/test_core_reloc_ptr_as_arr.c         |    4 +
 .../selftests/bpf/progs/test_core_reloc_size.c     |    4 +
 .../selftests/bpf/progs/test_get_stack_rawtp.c     |    2 -
 .../testing/selftests/bpf/progs/test_global_data.c |    2 -
 .../selftests/bpf/progs/test_global_func1.c        |    2 -
 .../selftests/bpf/progs/test_global_func3.c        |    2 -
 .../selftests/bpf/progs/test_global_func5.c        |    2 -
 .../selftests/bpf/progs/test_global_func6.c        |    2 -
 .../selftests/bpf/progs/test_global_func7.c        |    2 -
 tools/testing/selftests/bpf/progs/test_l4lb.c      |    4 +
 .../selftests/bpf/progs/test_l4lb_noinline.c       |    4 +
 .../selftests/bpf/progs/test_lirc_mode2_kern.c     |    2 -
 .../selftests/bpf/progs/test_lwt_ip_encap.c        |    4 +
 .../selftests/bpf/progs/test_lwt_seg6local.c       |    4 +
 .../testing/selftests/bpf/progs/test_map_in_map.c  |    2 -
 tools/testing/selftests/bpf/progs/test_map_lock.c  |    2 -
 tools/testing/selftests/bpf/progs/test_mmap.c      |    2 -
 tools/testing/selftests/bpf/progs/test_obj_id.c    |    2 -
 tools/testing/selftests/bpf/progs/test_overhead.c  |    4 +
 .../testing/selftests/bpf/progs/test_perf_buffer.c |    2 -
 tools/testing/selftests/bpf/progs/test_pinning.c   |    2 -
 .../selftests/bpf/progs/test_pinning_invalid.c     |    2 -
 .../testing/selftests/bpf/progs/test_pkt_access.c  |    4 +
 .../selftests/bpf/progs/test_pkt_md_access.c       |    2 -
 .../testing/selftests/bpf/progs/test_probe_user.c  |    4 +
 .../selftests/bpf/progs/test_queue_stack_map.h     |    2 -
 .../testing/selftests/bpf/progs/test_rdonly_maps.c |    2 -
 tools/testing/selftests/bpf/progs/test_seg6_loop.c |    4 +
 .../bpf/progs/test_select_reuseport_kern.c         |    4 +
 .../selftests/bpf/progs/test_send_signal_kern.c    |    2 -
 .../selftests/bpf/progs/test_sk_lookup_kern.c      |    4 +
 .../selftests/bpf/progs/test_skb_cgroup_id_kern.c  |    2 -
 tools/testing/selftests/bpf/progs/test_skb_ctx.c   |    2 -
 tools/testing/selftests/bpf/progs/test_skeleton.c  |    2 -
 .../selftests/bpf/progs/test_sock_fields_kern.c    |    4 +
 tools/testing/selftests/bpf/progs/test_spin_lock.c |    2 -
 .../selftests/bpf/progs/test_stacktrace_build_id.c |    2 -
 .../selftests/bpf/progs/test_stacktrace_map.c      |    2 -
 .../selftests/bpf/progs/test_sysctl_loop1.c        |    2 -
 .../selftests/bpf/progs/test_sysctl_loop2.c        |    2 -
 .../testing/selftests/bpf/progs/test_sysctl_prog.c |    2 -
 tools/testing/selftests/bpf/progs/test_tc_edt.c    |    4 +
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |    4 +
 .../bpf/progs/test_tcp_check_syncookie_kern.c      |    4 +
 .../testing/selftests/bpf/progs/test_tcp_estats.c  |    2 -
 .../testing/selftests/bpf/progs/test_tcpbpf_kern.c |    4 +
 .../selftests/bpf/progs/test_tcpnotify_kern.c      |    4 +
 .../testing/selftests/bpf/progs/test_tracepoint.c  |    2 -
 .../testing/selftests/bpf/progs/test_tunnel_kern.c |    4 +
 .../selftests/bpf/progs/test_verif_scale1.c        |    2 -
 .../selftests/bpf/progs/test_verif_scale2.c        |    2 -
 .../selftests/bpf/progs/test_verif_scale3.c        |    2 -
 tools/testing/selftests/bpf/progs/test_xdp.c       |    4 +
 .../testing/selftests/bpf/progs/test_xdp_bpf2bpf.c |    2 -
 tools/testing/selftests/bpf/progs/test_xdp_loop.c  |    4 +
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |    2 -
 .../selftests/bpf/progs/test_xdp_noinline.c        |    4 +
 .../selftests/bpf/progs/test_xdp_redirect.c        |    2 -
 tools/testing/selftests/bpf/progs/test_xdp_vlan.c  |    4 +
 tools/testing/selftests/bpf/progs/xdp_dummy.c      |    2 -
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |    2 -
 tools/testing/selftests/bpf/progs/xdp_tx.c         |    2 -
 tools/testing/selftests/bpf/progs/xdping_kern.c    |    4 +
 tools/testing/selftests/bpf/test_cpp.cpp           |    6 +-
 tools/testing/selftests/bpf/test_hashmap.c         |    2 -
 tools/testing/selftests/bpf/test_progs.h           |    2 -
 tools/testing/selftests/bpf/test_sock.c            |    2 -
 tools/testing/selftests/bpf/test_sockmap_kern.h    |    4 +
 tools/testing/selftests/bpf/test_sysctl.c          |    2 -
 tools/testing/selftests/bpf/trace_helpers.h        |    2 -
 238 files changed, 388 insertions(+), 369 deletions(-)

