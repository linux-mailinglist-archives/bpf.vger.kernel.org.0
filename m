Return-Path: <bpf+bounces-48095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2076A0405E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D753A1915
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EC01E25E9;
	Tue,  7 Jan 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Bmx9tR6x"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3CE6136;
	Tue,  7 Jan 2025 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255357; cv=none; b=kePQFbvTo7kGZ9q7LJiryCjuEsWqaRkEX88073rbVCkSBKRet2D3hJnXZaiKYXQxO+5ZiMyc1f2+V5D6rMjUxfKfxKKJJ3DsmtvnY3Ns5MnpcmXeOSG8HA27k8qoguJHJD0j8PfelcBGItGyBXDIVOed4o3CdhvF9hJaQdY9EBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255357; c=relaxed/simple;
	bh=5JVkdQ90/LdvM+sUTUPCLUJfvgJXCbsa8JCfEBsQUYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqH71dmqdVxcH4gsQjQEStNu6vPD3k/essQcLXBbuY6lMhkA7uL6xuHbJCJp2DZBqlr/28t9rZewBqyNK0V9D7UCu7feZQ/EP+VwOcgtZ7r6Zi65ZOKUtnp9gxVWbczGOetXsbDUOmbVAy7xHcaGTQkuYBJggXyDzlpmRHbMxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Bmx9tR6x; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=34jc6LVJaO6qgGhVwGMFJBZaDirf2T9MVRkHS7GSrgE=; b=Bmx9tR6x3eT6NjpXd6O2Plc73d
	qp1Cko0Glw4DGumhHOOBDoCJF0KuN4/3mkfe6ZoA2N15ku9zKSZ7a67DvIktGTXQQYvqqFDXaJWSe
	CLr2U3B257rgp87GsaqNCEZPiMMooaPZ5mDrGJ8EpWqaAXqCNo99Um6/Zw0MD5ZtvtIejDBXGILqd
	V0Jjyke1PsPQihcMM5OwGZodQY78gdRR0pwJFrrg9bkc3oOROtVVjAvoYMnQeYMh3FOI/0SfObA4N
	b//UCQx01aS08NUqfUeLeKI2XT++bhudhk3dZgEIXokV2iySxFyaGZgIBunaE9Ddg0oP2sbyh265G
	wHvgKlPQ==;
Received: from 26.248.197.178.dynamic.cust.swisscom.net ([178.197.248.26] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tV9KX-000EDj-Ad; Tue, 07 Jan 2025 14:09:09 +0100
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
Subject: pull-request: bpf-next 2025-01-07
Date: Tue,  7 Jan 2025 14:09:08 +0100
Message-ID: <20250107130908.143644-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27511/Tue Jan  7 10:37:11 2025)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 7 non-merge commits during the last 32 day(s) which contain
a total of 11 files changed, 190 insertions(+), 103 deletions(-).

The main changes are:

1) Migrate the test_xdp_meta.sh BPF selftest into test_progs
   framework, from Bastien Curutchet.

2) Add ability to configure head/tailroom for netkit devices,
   from Daniel Borkmann.

3) Fixes and improvements to the xdp_hw_metadata selftest,
   from Song Yoong Siang.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Jakub Kicinski, Nikolay Aleksandrov, Stanislav Fomichev

----------------------------------------------------------------

The following changes since commit f930594981cd9db15315c0ca03292a91828e39f0:

  Merge branch 'ethtool-generate-uapi-header-from-the-spec' (2024-12-05 12:03:10 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 058268e23fcadc2bdb9297c6dff3a010c70f9762:

  selftests/bpf: Extend netkit tests to validate set {head,tail}room (2025-01-06 09:48:58 +0100)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Bastien Curutchet (2):
      selftests/bpf: test_xdp_meta: Rename BPF sections
      selftests/bpf: Migrate test_xdp_meta.sh into xdp_context_test_run.c

Daniel Borkmann (3):
      netkit: Allow for configuring needed_{head,tail}room
      netkit: Add add netkit {head,tail}room to rt_link.yaml
      selftests/bpf: Extend netkit tests to validate set {head,tail}room

Martin KaFai Lau (1):
      Merge branch 'selftests-bpf-migrate-test_xdp_meta-sh-to-test_progs'

Song Yoong Siang (2):
      selftests/bpf: Actuate tx_metadata_len in xdp_hw_metadata
      selftests/bpf: Enable Tx hwtstamp in xdp_hw_metadata

 Documentation/netlink/specs/rt_link.yaml           |  6 ++
 drivers/net/netkit.c                               | 66 ++++++++++------
 include/uapi/linux/if_link.h                       |  2 +
 tools/include/uapi/linux/if_link.h                 |  2 +
 tools/testing/selftests/bpf/Makefile               |  1 -
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c | 49 +++++++-----
 .../bpf/prog_tests/xdp_context_test_run.c          | 87 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_tc_link.c   | 15 ++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  4 +-
 tools/testing/selftests/bpf/test_xdp_meta.sh       | 58 ---------------
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  3 +-
 11 files changed, 190 insertions(+), 103 deletions(-)
 delete mode 100755 tools/testing/selftests/bpf/test_xdp_meta.sh

