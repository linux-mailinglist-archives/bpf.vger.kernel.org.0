Return-Path: <bpf+bounces-7937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8BD77EBC5
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 23:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F18A1C2119C
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4411AA6B;
	Wed, 16 Aug 2023 21:28:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294EF3D60;
	Wed, 16 Aug 2023 21:28:45 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A3FD;
	Wed, 16 Aug 2023 14:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=CGp9AV7ujs/IoVU/Eido5PfA+z2p264rMusAdYNwIDY=; b=d0oEUxNZIpEouQFRTROVMTPf0y
	hM1S3YxdiAGVzIzOVTUlFKJ89b4JRgr/t98OBNS8wqwYDlp7xomNroLLkBC3m51V74q9fKMrHhg0A
	gbIOVsWa4YJXP6hQbwZ7x55x7a2DwtdvKWK2Uc/s6BT5tjlZ+FRVBkJ6m5EC1D7fzLmu3eIbci1h2
	NG0zzlQZBR/zIh4nVci8divvipOUL+rMGkWVEFPJ4n/NBSvqyrTaBgDC3HieOfaEM+gWdb7+S63ax
	14Cm+HIC9pyV61qGXuXjOspEBCHSHMdDpmnGAhUGykalC5xfUdrOpys3qVjK8yQRbmjZlBrY8QghY
	addGc54Q==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWO4H-000Cch-TH; Wed, 16 Aug 2023 23:28:41 +0200
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
Subject: pull-request: bpf-next 2023-08-16
Date: Wed, 16 Aug 2023 23:28:40 +0200
Message-Id: <20230816212840.1539-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27002/Wed Aug 16 09:38:26 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 17 non-merge commits during the last 6 day(s) which contain
a total of 20 files changed, 1179 insertions(+), 37 deletions(-).

The main changes are:

1) Add a BPF hook in sys_socket() to change the protocol ID from IPPROTO_TCP to
   IPPROTO_MPTCP to cover migration for legacy applications, from Geliang Tang.

2) Follow-up/fallout fix from the SO_REUSEPORT + bpf_sk_assign work to fix a splat
   on non-fullsock sks in inet[6]_steal_sock, from Lorenz Bauer.

3) Improvements to struct_ops links to avoid forcing presence of update/validate
   callbacks. Also add bpf_struct_ops fields documentation, from David Vernet.

4) Ensure libbpf sets close-on-exec flag on gzopen, from Marco Vedovati.

5) Several new tcx selftest additions and bpftool link show support for
   tcx and xdp links, from Daniel Borkmann.

6) Fix a smatch warning on uninitialized symbol in bpf_perf_link_fill_kprobe,
   from Yafang Shao.

7) BPF selftest fixes e.g. misplaced break in kfunc_call test, from Yipeng Zou.

8) Small cleanup to remove unused declaration bpf_link_new_file, from Yue Haibing.

9) Small typo fix to bpftool's perf help message, from Daniel T. Lee.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Dan Carpenter, Jiri Olsa, Kui-Feng Lee, Kumar Kartikeya Dwivedi, Li 
Zetao, Matthieu Baerts, Quentin Monnet, Yafang Shao, Yonghong Song

----------------------------------------------------------------

The following changes since commit 6231e47b6fadf42da2e7a45b8272e80aed53c444:

  tun: avoid high-order page allocation for packet header (2023-08-10 19:33:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to de40537364c34fd665a0f00d156d24c6c0e89a66:

  Merge branch 'bpf: Force to MPTCP' (2023-08-16 11:42:35 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Daniel Borkmann (3):
      selftests/bpf: Add various more tcx test cases
      bpftool: Implement link show support for tcx
      bpftool: Implement link show support for xdp

Daniel T. Lee (1):
      bpftool: fix perf help message

David Vernet (2):
      bpf: Support default .validate() and .update() behavior for struct_ops links
      bpf: Document struct bpf_struct_ops fields

Geliang Tang (4):
      bpf: Add update_socket_protocol hook
      selftests/bpf: Add two mptcp netns helpers
      selftests/bpf: Fix error checks of mptcp open_and_load
      selftests/bpf: Add mptcpify test

Lorenz Bauer (1):
      net: Fix slab-out-of-bounds in inet[6]_steal_sock

Marco Vedovati (1):
      libbpf: Set close-on-exec flag on gzopen

Martin KaFai Lau (2):
      Merge branch 'Update and document struct_ops'
      Merge branch 'bpf: Force to MPTCP'

Yafang Shao (2):
      bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
      selftests/bpf: Add selftest for fill_link_info

Yipeng Zou (2):
      selftests/bpf: Fix repeat option when kfunc_call verification fails
      selftests/bpf: Clean up fmod_ret in bench_rename test script

Yue Haibing (1):
      bpf: Remove unused declaration bpf_link_new_file()

 include/linux/bpf.h                                |  48 ++-
 include/net/inet6_hashtables.h                     |   2 +-
 include/net/inet_hashtables.h                      |   2 +-
 kernel/bpf/bpf_struct_ops.c                        |  15 +-
 kernel/bpf/syscall.c                               |   5 +-
 net/mptcp/bpf.c                                    |  15 +
 net/socket.c                                       |  26 +-
 tools/bpf/bpftool/link.c                           |  44 +++
 tools/bpf/bpftool/perf.c                           |   2 +-
 tools/lib/bpf/libbpf.c                             |   4 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |   3 +
 .../selftests/bpf/benchs/run_bench_rename.sh       |   2 +-
 .../selftests/bpf/prog_tests/fill_link_info.c      | 342 +++++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |   2 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 180 +++++++++--
 tools/testing/selftests/bpf/prog_tests/tc_links.c  | 336 ++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   | 110 +++++++
 tools/testing/selftests/bpf/progs/mptcpify.c       |  20 ++
 .../selftests/bpf/progs/test_fill_link_info.c      |  42 +++
 tools/testing/selftests/bpf/progs/test_tc_link.c   |  16 +
 20 files changed, 1179 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fill_link_info.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fill_link_info.c

