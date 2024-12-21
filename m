Return-Path: <bpf+bounces-47491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE5C9F9D64
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 01:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 668907A30A3
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 00:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AF7748A;
	Sat, 21 Dec 2024 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pnPXMmg6"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9033410E4;
	Sat, 21 Dec 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734740488; cv=none; b=Hoshe3Gp3KKh7ut3aIR4yua7xuGWtD6uzi+YSPBoMgcvKjdGUoo2eqDooGgYDBhbAmpC6E+NspVQfxlEIcYmOi5gNhGTlSa1pRx3zz+zQPgageaf/EN1s99dmOstZec7dbWYo7VeWmcDua1kIEODvJqiXOWt/+vBuNRmWbGe29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734740488; c=relaxed/simple;
	bh=GGwqDms+SNf8TURcyOUaVLJc0I7ECAh1Y8shF1/ZEg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMI37UZqSIR8T6r2vKZfL507rdt3brU0AISQtxCsaiUNGk/8c1gGuLBwiBxcpvHlI2EiW1K2u+x5I9CEniU8LH5JqBeQvJFjKwB+YrgfhQubvYCAfNaYYLItmQ16ZB8P2vSNyXirjZVHRfD0Xx45bB+5ghAANxWTR8dElz0uJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pnPXMmg6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=K+nZfIkh+d773jKzbf4rPBeKd/KzrkARB65rKU6DBvc=; b=pnPXMmg678Cm+S1Kq8JCKdxTqm
	MFqVw8+JfZ0vq8SYMgmLUDeeYlzgA7VsN4pazU9tXhg4rK3y203OeDTOYl4cE+XgDYBxvl7g645RZ
	2aZzk8c7CO8ErZZM0BU5bTomr7NncsVFz6x2rT94FYLi3/h5jNF8Tcm476mYMn8UQl+bjmC9iYx80
	8pVy9C8U2n1ql4Yu+4tDY8B5WgkPIeXEWs+C7fIjrKlblFgKHnFN2f+nntz7nhFeqyvfiv3nn5liI
	+Zi/dKYLE5c7QZ17kcMKYd0Kpy8I174HbFAJFcBBp0IxkQCLf1/i9jT1frP/G6fsdttsigbU0wELK
	EY4OYtZw==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tOnFE-000MCq-7P; Sat, 21 Dec 2024 01:21:24 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Subject: [GIT PULL] bpf for v6.13-rc4
Date: Sat, 21 Dec 2024 01:21:23 +0100
Message-ID: <20241221002123.491623-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27493/Fri Dec 20 10:46:49 2024)

Hi Linus,

The following changes since commit 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8:

  Linux 6.13-rc3 (2024-12-15 15:58:23 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 4a58963d10fa3cb654b859e3f9a8aecbcf9f4982:

  selftests/bpf: Test bpf_skb_change_tail() in TC ingress (2024-12-20 23:13:31 +0100)

----------------------------------------------------------------
BPF fixes:

- Fix inlining of bpf_get_smp_processor_id helper for !CONFIG_SMP
  systems (Andrea Righi)

- Fix BPF USDT selftests helper code to use asm constraint "m"
  for LoongArch (Tiezhu Yang)

- Fix BPF selftest compilation error in get_uprobe_offset when
  PROCMAP_QUERY is not defined (Jerome Marchand)

- Fix BPF bpf_skb_change_tail helper when used in context of
  BPF sockmap to handle negative skb header offsets (Cong Wang)

- Several fixes to BPF sockmap code, among others, in the area
  of socket buffer accounting (Levi Zim, Zijian Zhang, Cong Wang)

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

----------------------------------------------------------------
Andrea Righi (1):
      bpf: Fix bpf_get_smp_processor_id() on !CONFIG_SMP

Cong Wang (5):
      tcp_bpf: Charge receive socket buffer in bpf_tcp_ingress()
      bpf: Check negative offsets in __bpf_skb_min_len()
      selftests/bpf: Add a BPF selftest for bpf_skb_change_tail()
      selftests/bpf: Introduce socket_helpers.h for TC tests
      selftests/bpf: Test bpf_skb_change_tail() in TC ingress

Jerome Marchand (1):
      selftests/bpf: Fix compilation error in get_uprobe_offset()

Levi Zim (2):
      skmsg: Return copied bytes in sk_msg_memcopy_from_iter
      tcp_bpf: Fix copied value in tcp_bpf_sendmsg

Tiezhu Yang (1):
      selftests/bpf: Use asm constraint "m" for LoongArch

Zijian Zhang (1):
      tcp_bpf: Add sk_rmem_alloc related logic for tcp_bpf ingress redirection

 include/linux/skmsg.h                              |  11 +-
 include/net/sock.h                                 |  10 +-
 kernel/bpf/verifier.c                              |   6 +-
 net/core/filter.c                                  |  21 +-
 net/core/skmsg.c                                   |  11 +-
 net/ipv4/tcp_bpf.c                                 |  14 +-
 .../selftests/bpf/prog_tests/socket_helpers.h      | 394 +++++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  51 +++
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 385 +-------------------
 .../selftests/bpf/prog_tests/tc_change_tail.c      |  62 ++++
 .../selftests/bpf/progs/test_sockmap_change_tail.c |  40 +++
 .../selftests/bpf/progs/test_tc_change_tail.c      | 106 ++++++
 tools/testing/selftests/bpf/sdt.h                  |   2 +
 tools/testing/selftests/bpf/trace_helpers.c        |   4 +
 14 files changed, 712 insertions(+), 405 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_change_tail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_change_tail.c

