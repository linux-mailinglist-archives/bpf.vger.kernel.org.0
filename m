Return-Path: <bpf+bounces-7418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75454776FD9
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 07:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE28281EF6
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 05:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BAD1875;
	Thu, 10 Aug 2023 05:53:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAA1856
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 05:53:13 +0000 (UTC)
Received: from out-79.mta1.migadu.com (out-79.mta1.migadu.com [95.215.58.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0CF12D
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 22:53:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691646790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8sBl71Z2naXRgX/LkmQ9mhqkSd/iuIkagqXC/+9kH0A=;
	b=cjfWge0CZDTD+UegAAnewaPtatNQ+xuE1uvd2SXYDfrQ2t3zPEGKeZHZ8huRvby4gfL9p4
	DkHeiJA0NCE/kU8ni7znIOLAtPM7Xj8Os+nyd+toxUPt2XkmXW7yEuzveYulvKWbMx2U4D
	gdc4hZvcumDZTUOfWZBwC8zluqQKSic=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2023-08-09
Date: Wed,  9 Aug 2023 22:53:03 -0700
Message-Id: <20230810055303.120917-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 5 non-merge commits during the last 7 day(s) which contain
a total of 6 files changed, 102 insertions(+), 8 deletions(-).

The main changes are:

1) A bpf sockmap memleak fix and a fix in accessing the programs of
   a sockmap under the incorrect map type from Xu Kuohai.

2) A refcount underflow fix in xsk from Magnus Karlsson.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

John Fastabend

----------------------------------------------------------------

The following changes since commit 999f6631866e9ea81add935b9c6ebaab0579d259:

  Merge tag 'net-6.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-08-03 14:00:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to b734f02c887d9a02cd777ee3a74be38df341fabb:

  Merge branch 'bug fixes for sockmap' (2023-08-09 20:29:10 -0700)

----------------------------------------------------------------
bpf pull-request 2023-08-09

----------------------------------------------------------------
Magnus Karlsson (1):
      xsk: fix refcount underflow in error path

Martin KaFai Lau (1):
      Merge branch 'bug fixes for sockmap'

Xu Kuohai (4):
      bpf, sockmap: Fix map type error in sock_map_del_link
      bpf, sockmap: Fix bug that strp_done cannot be called
      selftests/bpf: fix a CI failure caused by vsock sockmap test
      selftests/bpf: Add sockmap test for redirecting partial skb data

 include/linux/skmsg.h                              |  1 +
 net/core/skmsg.c                                   | 10 ++-
 net/core/sock_map.c                                | 10 +--
 net/xdp/xsk.c                                      |  1 +
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 74 +++++++++++++++++++++-
 .../selftests/bpf/progs/test_sockmap_listen.c      | 14 ++++
 6 files changed, 102 insertions(+), 8 deletions(-)

