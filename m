Return-Path: <bpf+bounces-43676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EB69B86FB
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 00:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64FE282404
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A51E2829;
	Thu, 31 Oct 2024 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VK+zG2Aq"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC001CC8B7;
	Thu, 31 Oct 2024 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416763; cv=none; b=FvhySmAh0IdLzdvohVwUsnEnS2u9OwhalGW/5btrXLYJnXKb0niUoobNLvohJ+RdDH3ygT++6QqX6K3SKXIhVpIXAtakNlWV0B3AezPC+wJIzI8Th2JKanTNKjEKnn2/dfUoEfEL+KdDzPErerTIgIcH8+fECQrnZysy3vACOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416763; c=relaxed/simple;
	bh=6KIDZb+5oaGX4mUbgwRnthLHO4MVo1NCOHZJmN8ZyNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mtDc1njCVQ2fFYDGGd9i8vBETKfuiasK8NUBy4GYnRE9ccWXsE6AD0GazJfQ3e/LPDtekZA+VSPiVxfbLkKQ7suDczrz0iQxR4b201ie7oUc1wC0s81vpTZrg1dX2ErG+nT+TtWpXXN4dMrNzeYbbLDj6HS3lj3ysc/qNFEQjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VK+zG2Aq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=nnUspxdcJ+wye5pTkOAdTuW2AnGlQJx5dahyJ4Afb80=; b=VK+zG2Aqtt6pWna22UOV7lmdbK
	dekcUmZ6Rp+UHH0JBucV9Y6sc9QP1UgSyMmEvFpHx/QGfJKilrlWqDbo5lZ5aPp4blfxVc9qeQrIv
	MhtmFtN8YPC5JTsqLNDNTxu7lsi/ZTD1gjtY56p9HH9dfm410tQcaAXyFKkX+Myho+JyJrcgrZLA4
	l/0jWw4sL2bv0MxfGjmfQ8shaD5a1E27RupkkRxesUPV1cs80wApbjHHznX/dxqOicOwsRAKaIw3O
	yDkz4L1UPgm/v0Rq4tJZokY9RuYvXPU3/DTSbeIg8pZ82QdpgnMFZuvu//zOPR5n3zdcQTSDClcd8
	HGNwUcdw==;
Received: from 47.248.197.178.dynamic.cust.swisscom.net ([178.197.248.47] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t6eRd-000ISO-Iw; Fri, 01 Nov 2024 00:19:13 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] bpf for v6.12-rc6
Date: Fri,  1 Nov 2024 00:19:12 +0100
Message-Id: <20241031231912.109589-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27444/Thu Oct 31 09:34:36 2024)

Hi Linus,

The following changes since commit ae90f6a6170d7a7a1aa4fddf664fbd093e3023bc:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2024-10-24 16:53:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to c40dd8c4732551605712985bc5b7045094c6458d:

  bpf, test_run: Fix LIVE_FRAME frame update after a page has been recycled (2024-10-31 16:15:21 +0100)

----------------------------------------------------------------
BPF fixes:

- Fix BPF verifier to force a checkpoint when the program's jump
  history becomes too long (Eduard Zingerman)

- Add several fixes to the BPF bits iterator addressing issues
  like memory leaks and overflow problems (Hou Tao)

- Fix an out-of-bounds write in trie_get_next_key (Byeonguk Jeong)

- Fix BPF test infra's LIVE_FRAME frame update after a page has
  been recycled (Toke Høiland-Jørgensen)

- Fix BPF verifier and undo the 40-bytes extra stack space for
  bpf_fastcall patterns due to various bugs (Eduard Zingerman)

- Fix a BPF sockmap race condition which could trigger a NULL
  pointer dereference in sock_map_link_update_prog (Cong Wang)

- Fix tcp_bpf_recvmsg_parser to retrieve seq_copied from tcp_sk
  under the socket lock (Jiayuan Chen)

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'fixes-for-bits-iterator'

Byeonguk Jeong (2):
      bpf: Fix out-of-bounds write in trie_get_next_key()
      selftests/bpf: Add test for trie_get_next_key()

Cong Wang (1):
      sock_map: fix a NULL pointer dereference in sock_map_link_update_prog()

Eduard Zingerman (3):
      bpf: Force checkpoint when jmp history is too long
      selftests/bpf: Test with a very short loop
      bpf: disallow 40-bytes extra stack for bpf_fastcall patterns

Hou Tao (5):
      bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
      bpf: Add bpf_mem_alloc_check_size() helper
      bpf: Check the validity of nr_words in bpf_iter_bits_new()
      bpf: Use __u64 to save the bits in bits iterator
      selftests/bpf: Add three test cases for bits_iter

Jiayuan Chen (1):
      bpf: fix filed access without lock

Toke Høiland-Jørgensen (1):
      bpf, test_run: Fix LIVE_FRAME frame update after a page has been recycled

 include/linux/bpf_mem_alloc.h                      |   3 +
 kernel/bpf/helpers.c                               |  54 ++++++++--
 kernel/bpf/lpm_trie.c                              |   2 +-
 kernel/bpf/memalloc.c                              |  14 ++-
 kernel/bpf/verifier.c                              |  23 ++---
 net/bpf/test_run.c                                 |   1 +
 net/core/sock_map.c                                |   4 +
 net/ipv4/tcp_bpf.c                                 |   7 +-
 .../bpf/map_tests/lpm_trie_map_get_next_key.c      | 109 +++++++++++++++++++++
 .../selftests/bpf/progs/verifier_bits_iter.c       |  61 +++++++++++-
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |  55 -----------
 .../selftests/bpf/progs/verifier_search_pruning.c  |  23 +++++
 tools/testing/selftests/bpf/veristat.cfg           |   1 +
 13 files changed, 269 insertions(+), 88 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c

