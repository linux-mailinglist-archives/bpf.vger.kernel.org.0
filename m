Return-Path: <bpf+bounces-20429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B1883E460
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 22:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F8A1C21CCC
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 21:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC78250E8;
	Fri, 26 Jan 2024 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="g1emrys3"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE19E1CD34;
	Fri, 26 Jan 2024 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306238; cv=none; b=tHPGEkQmJPtu2phGjqyonFgfucEg7JkZ01DMEQJ6ckDFiIgYzAC3Da614aLb5rInH3/mzFOvG3smcVVVyYSk5i15SAYR3Eg7Xy3ltfLjXK4x6IV32BHfCcrBRmMW1UfY9ZHP/KB4gzRnFv9N3v3VO+pctefxA20X/SnuuBGNLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306238; c=relaxed/simple;
	bh=kfDIGcdH5XP/+YumLwOZLp4JQDnAo86T6d1jRuRoxK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f56QVtKumq8hJOZnOEf31VhjeyyEHpzqIBG8UpKe6sADSLIQ03W+qWcTAJ5p33K6HmlI8AFGe9FyLf9pS7CAAYcvh6/CUPnDf4EBMYNHWTJdOlhqFDBfr6z1aPSljniFag1tdHC+BbGfAIcVpa7c8YF8J05l6PQdfFDLk8+rkzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=g1emrys3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=/TMA92RsZUMH0FTt4qmkwa2vPWIlYiTuDsg9qNZhQJc=; b=g1emrys3LJ+kum7ECn8jKorDqV
	WKqimeHnMyrzhKz8flMZ13M6Bvyjc09m1kFVTwNi8NArsmxZFgUUhmQOW99rGos4uRxAhDH+XthoP
	5A/oYCMJZpBquiONXYi1LevexpzmhJ2rSPWzRZfMO31uPs3/FCWw7K0VKMqiZu1mcvjJL+tjpm4XR
	FVgDqSJA3OynuqiJUz0MyJJRbb9HgLDBME4PB4gJtQUq+XIvB8hv+smOlUHwjZYSVI4M5LJqR4rLg
	//hkf6uV+2KzAFRVMqShMDTykSq4LDSxQfcHJPuoAfYRhiELySu+xmDO7Aid+9tsANdYzc5Byplsq
	U/eqm+IA==;
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rTUCF-0008FA-9M; Fri, 26 Jan 2024 22:57:11 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2024-01-26
Date: Fri, 26 Jan 2024 22:57:10 +0100
Message-Id: <20240126215710.19855-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27166/Fri Jan 26 10:46:50 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 107 non-merge commits during the last 4 day(s) which contain
a total of 101 files changed, 6009 insertions(+), 1260 deletions(-).

The main changes are:

1) Add BPF token support to delegate a subset of BPF subsystem functionality from
   privileged system-wide daemons such as systemd through special mount options
   for userns-bound BPF fs to a trusted & unprivileged application. With addressed
   changes from Christian and Linus' reviews, from Andrii Nakryiko.

2) Support registration of struct_ops types from modules which helps projects like
   fuse-bpf that seeks to implement a new struct_ops type, from Kui-Feng Lee.

3) Add support for retrieval of cookies for perf/kprobe multi links, from Jiri Olsa.

4) Bigger batch of prep-work for the BPF verifier to eventually support preserving
   boundaries and tracking scalars on narrowing fills, from Maxim Mikityanskiy.

5) Extend the tc BPF flavor to support arbitrary TCP SYN cookies to help with
   the scenario of SYN floods, from Kuniyuki Iwashima.

6) Add code generation to inline the bpf_kptr_xchg() helper which improves
   performance when stashing/popping the allocated BPF objects, from Hou Tao.

7) Extend BPF verifier to track aligned ST stores as imprecise spilled
   registers, from Yonghong Song.

8) Several fixes to BPF selftests around inline asm constraints and unsupported
   VLA code generation, from Jose E. Marchesi.

9) Various updates to the BPF IETF instruction set draft document such as the
   introduction of conformance groups for instructions, from Dave Thaler.

10) Fix BPF verifier to make infinite loop detection in is_state_visited()
    exact to catch some too lax spill/fill corner cases, from Eduard Zingerman.

11) Refactor the BPF verifier pointer ALU check to allow ALU explicitly instead
    of implicitly for various register types, from Hao Sun.

12) Fix the flaky tc_redirect_dtime BPF selftest due to slowness in neighbor
    advertisement at setup time, from Martin KaFai Lau.

13) Change BPF selftests to skip callback tests for the case when the JIT is
    disabled, from Tiezhu Yang.

14) Add a small extension to libbpf which allows to auto create a map-in-map's
    inner map, from Andrey Grafin.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Christian Brauner, David Vernet, Eduard Zingerman, Eric 
Dumazet, Hou Tao, Jiri Olsa, John Fastabend, kernel test robot, Kuniyuki 
Iwashima, Paul Moore, Quentin Monnet, Simon Horman, Song Liu, Yafang 
Shao, Yonghong Song

----------------------------------------------------------------

The following changes since commit 2121c43f88f593eea51d483bedd638cb0623c7e2:

  Merge branch 'inet_diag-remove-three-mutexes-in-diag-dumps' (2024-01-23 15:18:43 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to fa7178b0f12e55a4f2d4906df3f25d6d4f88d962:

  selftests/bpf: Add missing line break in test_verifier (2024-01-26 11:09:32 -0800)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (4):
      Merge branch 'bpf-inline-bpf_kptr_xchg'
      bpf: Minor improvements for bpf_cmp.
      Merge branch 'enable-the-inline-of-kptr_xchg-for-arm64'
      Merge branch 'bpf-add-cookies-retrieval-for-perf-kprobe-multi-links'

Andrey Grafin (2):
      libbpf: Apply map_set_def_max_entries() for inner_maps on creation
      selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY values

Andrii Nakryiko (38):
      selftests/bpf: fix test_loader check message
      bpf: make sure scalar args don't accept __arg_nonnull tag
      bpf: prepare btf_prepare_func_args() for multiple tags per argument
      bpf: support multiple tags per argument
      selftests/bpf: detect testing prog flags support
      libbpf: call dup2() syscall directly
      Merge branch 'skip-callback-tests-if-jit-is-disabled-in-test_verifier'
      bpf: Align CAP_NET_ADMIN checks with bpf_capable() approach
      bpf: Add BPF token delegation mount options to BPF FS
      bpf: Introduce BPF token object
      bpf: Add BPF token support to BPF_MAP_CREATE command
      bpf: Add BPF token support to BPF_BTF_LOAD command
      bpf: Add BPF token support to BPF_PROG_LOAD command
      bpf: Take into account BPF token when fetching helper protos
      bpf: Consistently use BPF token throughout BPF verifier logic
      bpf,lsm: Refactor bpf_prog_alloc/bpf_prog_free LSM hooks
      bpf,lsm: Refactor bpf_map_alloc/bpf_map_free LSM hooks
      bpf,lsm: Add BPF token LSM hooks
      libbpf: Add bpf_token_create() API
      libbpf: Add BPF token support to bpf_map_create() API
      libbpf: Add BPF token support to bpf_btf_load() API
      libbpf: Add BPF token support to bpf_prog_load() API
      selftests/bpf: Add BPF token-enabled tests
      bpf,selinux: Allocate bpf_security_struct per BPF token
      bpf: Fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
      bpf: Support symbolic BPF FS delegation mount options
      selftests/bpf: Utilize string values for delegate_xxx mount options
      libbpf: Split feature detectors definitions from cached results
      libbpf: Further decouple feature checking logic from bpf_object
      libbpf: Move feature detection code into its own file
      libbpf: Wire up token_fd into feature probing logic
      libbpf: Wire up BPF token support at BPF object level
      selftests/bpf: Add BPF object loading tests with explicit token passing
      selftests/bpf: Add tests for BPF object load with implicit token
      libbpf: Support BPF token path setting through LIBBPF_BPF_TOKEN_PATH envvar
      selftests/bpf: Add tests for LIBBPF_BPF_TOKEN_PATH envvar
      selftests/bpf: Incorporate LSM policy to token-based tests
      Merge branch 'bpf-token'

Artem Savkov (1):
      selftests/bpf: Fix potential premature unload in bpf_testmod

Daniel Borkmann (1):
      bpf: Sync uapi bpf.h header for the tooling infra

Dave Thaler (3):
      Introduce concept of conformance groups
      bpf, docs: Clarify that MOVSX is only for BPF_X not BPF_K
      bpf, docs: Clarify definitions of various instructions

Dima Tisnek (1):
      libbpf: Correct bpf_core_read.h comment wrt bpf_core_relo struct

Eduard Zingerman (3):
      bpf: make infinite loop detection in is_state_visited() exact
      selftests/bpf: check if imprecise stack spills confuse infinite loop detection
      bpf: One more maintainer for libbpf and BPF selftests

Hao Sun (1):
      bpf: Refactor ptr alu checking rules to allow alu explicitly

Hou Tao (5):
      bpf: Support inlining bpf_kptr_xchg() helper
      selftests/bpf: Factor out get_xlated_program() helper
      selftests/bpf: Test the inlining of bpf_kptr_xchg()
      bpf, arm64: Enable the inline of bpf_kptr_xchg()
      selftests/bpf: Enable kptr_xchg_inline test for arm64

Jiri Olsa (8):
      bpf: Add cookie to perf_event bpf_link_info records
      bpf: Store cookies in kprobe_multi bpf_link_info data
      bpftool: Fix wrong free call in do_show_link
      selftests/bpf: Add cookies check for kprobe_multi fill_link_info test
      selftests/bpf: Add cookies check for perf_event fill_link_info test
      selftests/bpf: Add fill_link_info test for perf event
      bpftool: Display cookie for perf event link probes
      bpftool: Display cookie for kprobe multi link

Jose E. Marchesi (3):
      bpf: avoid VLAs in progs/test_xdp_dynptr.c
      bpf: fix constraint in test_tcpbpf_kern.c
      bpf: Use r constraint instead of p constraint in selftests

Kui-Feng Lee (15):
      bpf: refactory struct_ops type initialization to a function.
      bpf: get type information with BTF_ID_LIST
      bpf, net: introduce bpf_struct_ops_desc.
      bpf: add struct_ops_tab to btf.
      bpf: make struct_ops_map support btfs other than btf_vmlinux.
      bpf: pass btf object id in bpf_map_info.
      bpf: lookup struct_ops types from a given module BTF.
      bpf: pass attached BTF to the bpf_struct_ops subsystem
      bpf: hold module refcnt in bpf_struct_ops map creation and prog verification.
      bpf: validate value_type
      bpf, net: switch to dynamic registration
      libbpf: Find correct module BTFs for struct_ops maps and progs.
      bpf: export btf_ctx_access to modules.
      selftests/bpf: test case for register_bpf_struct_ops().
      bpf: Fix error checks against bpf_get_btf_vmlinux().

Kuniyuki Iwashima (7):
      tcp: Move tcp_ns_to_ts() to tcp.h
      tcp: Move skb_steal_sock() to request_sock.h
      bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
      bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
      bpf: tcp: Support arbitrary SYN Cookie.
      selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
      bpf: Define struct bpf_tcp_req_attrs when CONFIG_SYN_COOKIES=n.

Martin KaFai Lau (5):
      Merge branch 'bpf: tcp: Support arbitrary SYN Cookie at TC.'
      Merge branch 'Registrating struct_ops types from modules'
      selftests/bpf: Fix the flaky tc_redirect_dtime test
      selftests/bpf: Wait for the netstamp_needed_key static key to be turned on
      libbpf: Ensure undefined bpf_attr field stays 0

Maxim Mikityanskiy (7):
      selftests/bpf: Fix the u64_offset_to_skb_data test
      bpf: Make bpf_for_each_spilled_reg consider narrow spills
      selftests/bpf: Add a test case for 32-bit spill tracking
      bpf: Add the assign_scalar_id_before_mov function
      bpf: Add the get_reg_width function
      bpf: Assign ID to scalars on spill
      selftests/bpf: Test assigning ID to scalars on spill

Nathan Chancellor (1):
      selftests/bpf: Update LLVM Phabricator links

Randy Dunlap (1):
      net: filter: fix spelling mistakes

Tiezhu Yang (4):
      bpftool: Silence build warning about calloc()
      selftests/bpf: Move is_jit_enabled() into testing_helpers
      selftests/bpf: Skip callback tests if jit is disabled in test_verifier
      selftests/bpf: Add missing line break in test_verifier

Victor Stewart (1):
      bpf, docs: Fix bpf_redirect_peer header doc

Yonghong Song (3):
      bpf: Track aligned st store as imprecise spilled registers
      selftests/bpf: Add a selftest with not-8-byte aligned BPF_ST
      docs/bpf: Fix an incorrect statement in verifier.rst

 .../bpf/standardization/instruction-set.rst        |   80 +-
 Documentation/bpf/verifier.rst                     |    2 +-
 MAINTAINERS                                        |    3 +
 arch/arm64/net/bpf_jit_comp.c                      |    5 +
 arch/x86/net/bpf_jit_comp.c                        |    5 +
 drivers/media/rc/bpf-lirc.c                        |    2 +-
 include/linux/bpf.h                                |  142 ++-
 include/linux/bpf_verifier.h                       |    3 +-
 include/linux/btf.h                                |   13 +
 include/linux/filter.h                             |    3 +-
 include/linux/lsm_hook_defs.h                      |   15 +-
 include/linux/security.h                           |   43 +-
 include/net/request_sock.h                         |   39 +
 include/net/sock.h                                 |   25 -
 include/net/tcp.h                                  |   45 +
 include/uapi/linux/bpf.h                           |   78 +-
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/arraymap.c                              |    2 +-
 kernel/bpf/bpf_lsm.c                               |   15 +-
 kernel/bpf/bpf_struct_ops.c                        |  433 ++++----
 kernel/bpf/bpf_struct_ops_types.h                  |   12 -
 kernel/bpf/btf.c                                   |  268 ++++-
 kernel/bpf/cgroup.c                                |    6 +-
 kernel/bpf/core.c                                  |   13 +-
 kernel/bpf/helpers.c                               |    7 +-
 kernel/bpf/inode.c                                 |  276 ++++-
 kernel/bpf/syscall.c                               |  234 +++--
 kernel/bpf/token.c                                 |  278 ++++++
 kernel/bpf/verifier.c                              |  148 ++-
 kernel/trace/bpf_trace.c                           |   17 +-
 net/bpf/bpf_dummy_struct_ops.c                     |   22 +-
 net/core/filter.c                                  |  155 ++-
 net/core/sock.c                                    |   14 +-
 net/ipv4/bpf_tcp_ca.c                              |   22 +-
 net/ipv4/syncookies.c                              |   40 +-
 net/ipv6/syncookies.c                              |   13 +-
 net/netfilter/nf_bpf_link.c                        |    2 +-
 security/security.c                                |  101 +-
 security/selinux/hooks.c                           |   47 +-
 tools/bpf/bpftool/link.c                           |   94 +-
 tools/bpf/bpftool/prog.c                           |    2 +-
 tools/include/uapi/linux/bpf.h                     |   79 +-
 tools/lib/bpf/Build                                |    2 +-
 tools/lib/bpf/bpf.c                                |   42 +-
 tools/lib/bpf/bpf.h                                |   38 +-
 tools/lib/bpf/bpf_core_read.h                      |    2 +-
 tools/lib/bpf/btf.c                                |   10 +-
 tools/lib/bpf/elf.c                                |    2 -
 tools/lib/bpf/features.c                           |  503 ++++++++++
 tools/lib/bpf/libbpf.c                             |  604 +++--------
 tools/lib/bpf/libbpf.h                             |   21 +-
 tools/lib/bpf/libbpf.map                           |    1 +
 tools/lib/bpf/libbpf_internal.h                    |   50 +-
 tools/lib/bpf/libbpf_probes.c                      |   12 +-
 tools/lib/bpf/str_error.h                          |    3 +
 tools/testing/selftests/bpf/README.rst             |   32 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |   21 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   10 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   75 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h        |    5 +
 tools/testing/selftests/bpf/config                 |    1 +
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |    2 +-
 .../testing/selftests/bpf/prog_tests/ctx_rewrite.c |   44 -
 .../selftests/bpf/prog_tests/fill_link_info.c      |  114 ++-
 .../selftests/bpf/prog_tests/kptr_xchg_inline.c    |   51 +
 .../selftests/bpf/prog_tests/libbpf_probes.c       |    4 +
 .../testing/selftests/bpf/prog_tests/libbpf_str.c  |    6 +
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |    2 +-
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |   90 +-
 .../bpf/prog_tests/tcp_custom_syncookie.c          |  150 +++
 .../bpf/prog_tests/test_struct_ops_module.c        |   75 ++
 tools/testing/selftests/bpf/prog_tests/token.c     | 1052 ++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/xdpwall.c   |    2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    2 +-
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |   16 +
 tools/testing/selftests/bpf/progs/iters.c          |    4 +-
 .../testing/selftests/bpf/progs/kptr_xchg_inline.c |   48 +
 tools/testing/selftests/bpf/progs/priv_map.c       |   13 +
 tools/testing/selftests/bpf/progs/priv_prog.c      |   13 +
 .../selftests/bpf/progs/struct_ops_module.c        |   30 +
 .../selftests/bpf/progs/test_core_reloc_type_id.c  |    2 +-
 .../selftests/bpf/progs/test_fill_link_info.c      |    6 +
 .../testing/selftests/bpf/progs/test_map_in_map.c  |   26 +
 tools/testing/selftests/bpf/progs/test_siphash.h   |   64 ++
 .../bpf/progs/test_tcp_custom_syncookie.c          |  572 +++++++++++
 .../bpf/progs/test_tcp_custom_syncookie.h          |  140 +++
 .../testing/selftests/bpf/progs/test_tcpbpf_kern.c |    2 +-
 .../testing/selftests/bpf/progs/test_xdp_dynptr.c  |   10 +-
 tools/testing/selftests/bpf/progs/token_lsm.c      |   32 +
 .../bpf/progs/verifier_direct_packet_access.c      |    2 +-
 .../testing/selftests/bpf/progs/verifier_loops1.c  |   24 +
 .../selftests/bpf/progs/verifier_spill_fill.c      |  229 ++++-
 tools/testing/selftests/bpf/test_loader.c          |    4 +-
 tools/testing/selftests/bpf/test_maps.c            |    6 +-
 tools/testing/selftests/bpf/test_progs.c           |   18 -
 tools/testing/selftests/bpf/test_sock_addr.c       |    3 +-
 tools/testing/selftests/bpf/test_verifier.c        |   60 +-
 tools/testing/selftests/bpf/testing_helpers.c      |   92 +-
 tools/testing/selftests/bpf/testing_helpers.h      |    8 +
 .../selftests/bpf/verifier/bpf_loop_inline.c       |    6 +
 tools/testing/selftests/bpf/verifier/precise.c     |    6 +-
 101 files changed, 6009 insertions(+), 1260 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
 create mode 100644 kernel/bpf/token.c
 create mode 100644 tools/lib/bpf/features.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_inline.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_siphash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
 create mode 100644 tools/testing/selftests/bpf/progs/token_lsm.c

