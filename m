Return-Path: <bpf+bounces-35630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B293C10F
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 13:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505371F210E2
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C58199256;
	Thu, 25 Jul 2024 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lU3s9wyM"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684A199243;
	Thu, 25 Jul 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907799; cv=none; b=SavhqWczUwj93XjlXknLVDopZvf3rcIqYlSiYfJULB5SQCaVR05JIPse/ZgK0bQ/ahr24ZGOC1eeZoVjZECVkZRWGfBwmnq+LiydSWYFPxI0oFDq1sxDsSuqcuLt++D87s+g3g1DIVN+6FQYLGHlFFFgliTXR52m8yifvlkguhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907799; c=relaxed/simple;
	bh=Kgftz5XpNQsDjiKjCsqRQjUeT/hJPLW43GoaIfJtv84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ukz7PToR8iuhptNjwVvD3l4Xt8ZqOaqhHmbSZbmCPivBHKRv1ldxjwRCD9jYA07VKBwplFeGI17mprH8/b3MhHoea8WfcorfrNBThrjF2P7n6SYqPWhQ1EotrOOZOVNRWi5+Dt6AXJfWIbwqHi8fNUaiBVnuv/o5Y6bLJdtKAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lU3s9wyM; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Fs4/iFnoNy7EGfwjse9jOHX7ViUsTi4kKdoAfEBvjfE=; b=lU3s9wyMat9DcdU1ROdtnMN5oT
	gUw6gTslW/LtvnGH7XR+4qfTfJan/f4/5AN5E0GDxgQZJgUw5qAAjhUvbYQz3XY4qxFvnKi5eOB3+
	IPEd2h7z7PJ8cyjXr7oonsmymS6mC4loCSJPRLLgAB7hFFgB7WEoAds5Iogi5R7P+/U0v94OXVfsm
	Ybo1DeyUQ3G62kk/w9EVcKTlnXHCv3AKJ43XRNXWZsU982vfO9Zy2N/I5d4SFdevnP0ZVUPaY4920
	2q6WKKRFbBqSHcLKA28oCJ+jR6KYOEtdby/NZI9Iuh+2ttaPdO2mXRfx65xYmmNrpZD3fHba4YOcP
	Io4+NHOA==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sWwsL-000B6r-6H; Thu, 25 Jul 2024 13:43:13 +0200
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
Subject: pull-request: bpf 2024-07-25
Date: Thu, 25 Jul 2024 13:43:12 +0200
Message-Id: <20240725114312.32197-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27347/Thu Jul 25 10:27:42 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 14 non-merge commits during the last 8 day(s) which contain
a total of 19 files changed, 177 insertions(+), 70 deletions(-).

The main changes are:

1) Fix af_unix to disable MSG_OOB handling for sockets in BPF sockmap and
   BPF sockhash. Also add test coverage for this case, from Michal Luczaj.

2) Fix a segmentation issue when downgrading gso_size in the BPF helper
   bpf_skb_adjust_room(), from Fred Li.

3) Fix a compiler warning in resolve_btfids due to a missing type cast,
   from Liwei Song.

4) Fix stack allocation for arm64 to align the stack pointer at a 16 byte
   boundary in the fexit_sleep BPF selftest, from Puranjay Mohan.

5) Fix a xsk regression to require a flag when actuating tx_metadata_len,
   from Stanislav Fomichev.

6) Fix function prototype BTF dumping in libbpf for prototypes that have
   no input arguments, from Andrii Nakryiko.

7) Fix stacktrace symbol resolution in perf script for BPF programs
   containing subprograms, from Hou Tao.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Christophe Leroy, Daniel Borkmann, Hari Bathini, Jakub Sitnicki, Jiri 
Olsa, Julian Schindel, Krister Johansen, Kuniyuki Iwashima, Maciej 
Fijalkowski, Masami Hiramatsu (Google), Quentin Monnet, Stanislav 
Fomichev, Tejun Heo, Willem de Bruijn, Yonghong Song

----------------------------------------------------------------

The following changes since commit 0e03c643dc9389e61fa484562dae58c8d6e96d63:

  eth: fbnic: fix s390 build. (2024-07-17 06:25:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 9b9969c40b0d63a8fca434d4ea01c60a39699aa3:

  selftests/bpf: Add XDP_UMEM_TX_METADATA_LEN to XSK TX metadata test (2024-07-25 11:57:33 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Andrii Nakryiko (1):
      libbpf: Fix no-args func prototype BTF dumping syntax

Donald Hunter (1):
      bpftool: Fix typo in usage help

Fred Li (1):
      bpf: Fix a segment issue when downgrading gso_size

Hou Tao (1):
      bpf, events: Use prog to emit ksymbol event for main program

Liwei Song (1):
      tools/resolve_btfids: Fix comparison of distinct pointer types warning in resolve_btfids

Michal Luczaj (4):
      af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
      selftests/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()
      selftests/bpf: Parametrize AF_UNIX redir functions to accept send() flags
      selftests/bpf: Test sockmap redirect for AF_UNIX MSG_OOB

Naveen N Rao (2):
      MAINTAINERS: Update email address of Naveen
      MAINTAINERS: Update powerpc BPF JIT maintainers

Puranjay Mohan (1):
      selftests/bpf: fexit_sleep: Fix stack allocation for arm64

Stanislav Fomichev (2):
      xsk: Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len
      selftests/bpf: Add XDP_UMEM_TX_METADATA_LEN to XSK TX metadata test

 .mailmap                                           |  2 +
 Documentation/networking/xsk-tx-metadata.rst       | 16 ++--
 MAINTAINERS                                        |  8 +-
 include/uapi/linux/if_xdp.h                        |  4 +
 kernel/events/core.c                               | 28 ++++---
 net/core/filter.c                                  | 15 +++-
 net/unix/af_unix.c                                 | 41 ++++++++++-
 net/unix/unix_bpf.c                                |  3 +
 net/xdp/xdp_umem.c                                 |  9 ++-
 tools/bpf/bpftool/prog.c                           |  2 +-
 tools/bpf/resolve_btfids/main.c                    |  2 +-
 tools/include/uapi/linux/if_xdp.h                  |  4 +
 tools/lib/bpf/btf_dump.c                           |  8 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |  1 -
 .../testing/selftests/bpf/prog_tests/fexit_sleep.c |  8 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 85 +++++++++++++++-------
 .../selftests/bpf/prog_tests/xdp_metadata.c        |  3 +-
 .../bpf/progs/btf_dump_test_case_multidim.c        |  4 +-
 .../bpf/progs/btf_dump_test_case_syntax.c          |  4 +-
 19 files changed, 177 insertions(+), 70 deletions(-)

