Return-Path: <bpf+bounces-11188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891697B5174
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 13:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0AF2F283BF0
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B780F13ACC;
	Mon,  2 Oct 2023 11:34:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108B10A36;
	Mon,  2 Oct 2023 11:34:24 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EE8D3;
	Mon,  2 Oct 2023 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=ehK+lbV6ZoXq1OUCCd+2dyRa9oXz6+uKhr8+Vbae/CY=; b=UAeIfCtH9TQOJSrDalRfCtdK28
	6pYV1R8j3Ht6PS76jiE22dfhaz8r66g06AJEB4IZVclxsrcxG9ASIl9Gio6/Pb78K/74hkYuDPK+y
	KQNf24zsBIJQYbFLQMrj3GIOVGJg7ZiDP2hM4IVhART+x/iMi9dltGcfZmi0zA+WCjnrlQjt8PDNz
	Z157rj/l1NPUpWDe38d2HWiABmh0yRO0ccorMOpZfIwWe0f7gyfTnRhPvD83yaa6YtICqRH+hidqB
	ZWWbxvMjKr73MkDdlXiP4bTpZKIY2/7rKm3JFCnph7ADw5X5vxJT7cknSSBvFZ+e3CJBBkyXa2Mpr
	vXq++9bg==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qnHBq-0009FV-6X; Mon, 02 Oct 2023 13:34:18 +0200
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
Subject: pull-request: bpf 2023-10-02
Date: Mon,  2 Oct 2023 13:34:17 +0200
Message-Id: <20231002113417.2309-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27049/Mon Oct  2 09:37:00 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 11 non-merge commits during the last 12 day(s) which contain
a total of 12 files changed, 176 insertions(+), 41 deletions(-).

The main changes are:

1) Fix BPF verifier to reset backtrack_state masks on global function exit as
   otherwise subsequent precision tracking would reuse them, from Andrii Nakryiko.

2) Several sockmap fixes for available bytes accounting, from John Fastabend.

3) Reject sk_msg egress redirects to non-TCP sockets given this is only
   supported for TCP sockets today, from Jakub Sitnicki.

4) Fix a syzkaller splat in bpf_mprog when hitting maximum program limits with
   BPF_F_BEFORE directive, from Daniel Borkmann and Nikolay Aleksandrov.

5) Fix BPF memory allocator to use kmalloc_size_roundup() to adjust
   size_index for selecting a bpf_mem_cache, from Hou Tao.

6) Fix arch_prepare_bpf_trampoline return code for s390 JIT, from Song Liu.

7) Fix bpf_trampoline_get when CONFIG_BPF_JIT is turned off, from Leon Hwang.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Chris Mason, Dan Carpenter, Emil Renner Berthing, Ilya Leoshkevich, 
Jakub Sitnicki, John Fastabend, kernel test robot, Nathan Chancellor

----------------------------------------------------------------

The following changes since commit 8070274b472e2e9f5f67a990f5e697634c415708:

  net: stmmac: fix incorrect rxq|txq_stats reference (2023-09-19 10:21:15 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 9077fc228f09c9f975c498c55f5d2e882cd0da59:

  bpf: Use kmalloc_size_roundup() to adjust size_index (2023-09-30 09:39:28 -0700)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 's390-bpf-fix-arch_prepare_bpf_trampoline'

Andrii Nakryiko (1):
      bpf: unconditionally reset backtrack_state masks on global func exit

Daniel Borkmann (2):
      bpf, mprog: Fix maximum program check on mprog attachment
      selftest/bpf: Add various selftests for program limits

Hou Tao (1):
      bpf: Use kmalloc_size_roundup() to adjust size_index

Jakub Sitnicki (1):
      bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets

John Fastabend (3):
      bpf: tcp_read_skb needs to pop skb regardless of seq
      bpf, sockmap: Do not inc copied_seq when PEEK flag set
      bpf, sockmap: Add tests for MSG_F_PEEK

Leon Hwang (1):
      bpf: Fix tr dereferencing

Song Liu (2):
      s390/bpf: Let arch_prepare_bpf_trampoline return program size
      selftests/bpf: Check bpf_cubic_acked() is called via struct_ops

 arch/s390/net/bpf_jit_comp.c                       |  2 +-
 include/linux/bpf.h                                |  2 +-
 kernel/bpf/memalloc.c                              | 44 +++++-------
 kernel/bpf/mprog.c                                 |  3 +
 kernel/bpf/verifier.c                              |  8 +--
 net/core/sock_map.c                                |  4 ++
 net/ipv4/tcp.c                                     | 10 +--
 net/ipv4/tcp_bpf.c                                 |  4 +-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |  2 +
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 51 +++++++++++++
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   | 84 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_cubic.c      |  3 +
 12 files changed, 176 insertions(+), 41 deletions(-)

