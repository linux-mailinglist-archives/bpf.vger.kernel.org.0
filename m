Return-Path: <bpf+bounces-5020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD7753CD4
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3431C21562
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411B134A1;
	Fri, 14 Jul 2023 14:16:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C220E8;
	Fri, 14 Jul 2023 14:16:04 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F561989;
	Fri, 14 Jul 2023 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=OFPh+hgr29BHyWa/jhpUnYhM6+PI4P5OZDyH0+C2GA4=; b=JtfVwhhnU3524Z0/MkgvVozZeu
	7jutK9yvf1qFhx1QwRoJ4EPo9+19ETanlQrwaMNBSWTgANtdylkenCwA+0zapfdgmeM5mC7PSPWiv
	6A3Y36Z51O4cgiIkXQ9o4/s9fBkHfv6UDbprtq234AID3TETfBy36+9+1eU6LKwZOunzmSveR5V1A
	iFVGgwFB7N4JbWWvMe5M82fzbPfTdYETi+1Z+6iA9pfzwiE8u9utUEeeNg8TD+Yuv/YwdWmbpbpC5
	J13WINdAhfEwCp7peNTPO33zqgurFbHfeyYHi/biFeRvUNKsCfOeZEo1nHsgi/9V1gNliz+jfZgU+
	H7Z+6Tpg==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qKJaR-000B1X-1x; Fri, 14 Jul 2023 16:15:59 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	sdf@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	dxu@dxuuu.xyz,
	joe@cilium.io,
	toke@kernel.org,
	davem@davemloft.net,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 0/8] BPF link support for tc BPF programs
Date: Fri, 14 Jul 2023 16:15:37 +0200
Message-Id: <20230714141545.26904-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26969/Fri Jul 14 09:28:15 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series adds BPF link support for tc BPF programs. We initially
presented the motivation, related work and design at last year's LPC
conference in the networking & BPF track [0], and a recent update on
our progress of the rework during this year's LSF/MM/BPF summit [1].
The main changes are in first two patches and the last two have an
extensive batch of test cases we developed along with it, please see
individual patches for details. We tested this series with tc-testing
selftest suite as well as BPF CI/selftests. Thanks!

v4 -> v5:
  - Updated bpftool docs and usage of bpftool net (Quentin)
  - Consistent dump "prog id"/"link id" -> "prog_id"/"link_id" (Quentin)
  - Reworked bpftool flag output handling (Quentin)
  - LIBBPF_OPTS_RESET() macro with varargs for reinit (Andrii)
  - libbpf opts/link bail out on relative_fd && relative_id (Andrii)
  - libbpf improvements for assigning attr.relative_{id,fd} (Andrii)
  - libbpf sorting in libbpf.map (Andrii)
  - libbpf move ifindex to bpf_program__attach_tcx param (Andrii)
  - libbpf move BPF_F_ID flag handling to bpf_link_create (Andrii)
  - bpf_program_attach_fd with tcx instead of tc (Andrii)
  - Reworking kernel-internal bpf_mprog API (Alexei, Andrii)
  - Change "object" notation to "id_or_fd" (Andrii)
  - Remove on stack cpp[BPF_MPROG_MAX] and switch to memmove (Andrii)
  - Simplify bpf_mprog_{insert,delete} and add comment on internals
  - Get rid of BPF_MPROG_* return codes (Alexei, Andrii)
v3 -> v4:
  - Fix bpftool output to display tcx/{ingress,egress} (Stan)
  - Documentation around API, BPF_MPROG_* return codes and locking
    expectations (Stan, Alexei)
  - Change _after and _before to have the same semantics for return
    value (Alexei)
  - Rework mprog initialization and move allocation/free one layer
    up into tcx to simplify the code (Stan)
  - Add comment on synchronize_rcu and parent->ref (Stan)
  - Add comment on bpf_mprog_pos_() helpers wrt target position (Stan)
v2 -> v3:
  - Removal of BPF_F_FIRST/BPF_F_LAST from control UAPI (Toke, Stan)
  - Along with that full rework of bpf_mprog internals to simplify
    dependency management, looks much nicer now imho
  - Just single bpf_mprog_cp instead of two (Andrii)
  - atomic64_t for revision counter (Andrii)
  - Evaluate target position and reject on conflicts (Andrii)
  - Keep track of actual count in bpf_mprob_bundle (Andrii)
  - Make combo of REPLACE and BEFORE/AFTER work (Andrii)
  - Moved miniq as first struct member (Jamal)
  - Rework tcx_link_attach with regards to rtnl (Jakub, Andrii)
  - Moved wrappers after bpf_prog_detach_ops (Andrii)
  - Removed union for relative_fd and friends for opts and link in
    libbpf (Andrii)
  - Add doc comments to attach/detach/query libbpf APIs (Andrii)
  - Dropped SEC_ATTACHABLE_OPT (Andrii)
  - Add an OPTS_ZEROED check to bpf_link_create (Andrii)
  - Keep opts as the last argument in bpf_program_attach_fd (Andrii)
  - Rework bpf_program_attach_fd (Andrii)
  - Remove OPTS_GET before we checked OPTS_VALID in
    bpf_program__attach_tcx (Andrii)
  - Add `size_t :0;` to prevent compiler from leaving garbage (Andrii)
  - Add helper macro to clear opts structs which I found useful
    when writing tests
  - Rework of both opts and link test cases to accommodate for changes
v1 -> v2:
  - Rework of almost entire series to remove prio from UAPI and switch
    to better control directives BPF_F_FIRST/BPF_F_LAST/BPF_F_BEFORE/
    BPF_F_AFTER (Alexei, Toke, Stan, Andrii)
  - Addition of big test suite to cover all corner cases

  [0] https://lpc.events/event/16/contributions/1353/
  [1] http://vger.kernel.org/bpfconf2023_material/tcx_meta_netdev_borkmann.pdf

Daniel Borkmann (8):
  bpf: Add generic attach/detach/query API for multi-progs
  bpf: Add fd-based tcx multi-prog infra with link support
  libbpf: Add opts-based attach/detach/query API for tcx
  libbpf: Add link-based API for tcx
  libbpf: Add helper macro to clear opts structs
  bpftool: Extend net dump with tcx progs
  selftests/bpf: Add mprog API tests for BPF tcx opts
  selftests/bpf: Add mprog API tests for BPF tcx links

 MAINTAINERS                                   |    5 +-
 include/linux/bpf_mprog.h                     |  327 +++
 include/linux/netdevice.h                     |   15 +-
 include/linux/skbuff.h                        |    4 +-
 include/net/sch_generic.h                     |    2 +-
 include/net/tcx.h                             |  206 ++
 include/uapi/linux/bpf.h                      |   70 +-
 kernel/bpf/Kconfig                            |    1 +
 kernel/bpf/Makefile                           |    3 +-
 kernel/bpf/mprog.c                            |  439 ++++
 kernel/bpf/syscall.c                          |   83 +-
 kernel/bpf/tcx.c                              |  348 +++
 net/Kconfig                                   |    5 +
 net/core/dev.c                                |  267 +-
 net/core/filter.c                             |    4 +-
 net/sched/Kconfig                             |    4 +-
 net/sched/sch_ingress.c                       |   61 +-
 .../bpf/bpftool/Documentation/bpftool-net.rst |   26 +-
 tools/bpf/bpftool/net.c                       |   98 +-
 tools/bpf/bpftool/netlink_dumper.h            |    8 +
 tools/include/uapi/linux/bpf.h                |   70 +-
 tools/lib/bpf/bpf.c                           |  127 +-
 tools/lib/bpf/bpf.h                           |   97 +-
 tools/lib/bpf/libbpf.c                        |   70 +-
 tools/lib/bpf/libbpf.h                        |   15 +
 tools/lib/bpf/libbpf.map                      |    2 +
 tools/lib/bpf/libbpf_common.h                 |   16 +
 .../selftests/bpf/prog_tests/tc_helpers.h     |   72 +
 .../selftests/bpf/prog_tests/tc_links.c       | 1583 ++++++++++++
 .../selftests/bpf/prog_tests/tc_opts.c        | 2239 +++++++++++++++++
 .../selftests/bpf/progs/test_tc_link.c        |   40 +
 31 files changed, 6066 insertions(+), 241 deletions(-)
 create mode 100644 include/linux/bpf_mprog.h
 create mode 100644 include/net/tcx.h
 create mode 100644 kernel/bpf/mprog.c
 create mode 100644 kernel/bpf/tcx.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_links.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_opts.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_link.c

-- 
2.34.1


