Return-Path: <bpf+bounces-36142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19929942D9D
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 13:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC59B24EEA
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 11:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137F31A8BF4;
	Wed, 31 Jul 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G1Lt/utK"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9B1AD9FE;
	Wed, 31 Jul 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427039; cv=none; b=CnZI7t2ECux/pdOTI2aX5MAgLHvqKB3dKQPBTniQkOHlOWv4O8wLtcM3A4S76rkyJYu5V8IT85YaEoTwYAgNCn1aZyzktKsYvEwQgfXKkVh2McvzgSWyjv6sDVzTc8ms/jIC4Sxh1BSrWsdcuRZX/7EdcqpcxJAp/jQMHO3rY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427039; c=relaxed/simple;
	bh=avyJzW8MxcO5PnzXK6Ore+dV935Uwlyob7bkoSanf2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OzrbVLbNHqZv5Ko3Q87U1GDARX9kglCjuFR0t9eGpEMfoQAKd9liVFJd8IEk8STcgI5zrJvmLzYkamDMF2qDxyJcXycrLtPWsXGvc3KkMkEruSnrIyMxYLHI5fnAgY88FHaaZFxBQSmgJsQ00mqnSr1dfLdh3xR3/dowDwK10Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G1Lt/utK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=XLQCORnhhFbuAzj/kW08+Pd+TGYLYPcaApMF1xGDZzA=; b=G1Lt/utKMvdmJJzxBVRhCyzHUu
	MTfaPdkCgH/U2AZFVFM3Vr8mHS+mSo1eGzzJi/rqnMG2sG3S9bVqQ1q1VoyNq/kvnAcEg3DLBWk35
	XJBLYmOTy6sz1P5Vg8OzQxJTfsW0rkiUU25kaJSAlwFQiTwwHAm+M8cFUKr9OpYBixIT8PjOzEDv+
	giVZS0PqhfePKQDrzBmllleJDRWB9nqry1/oGCAJPbTpTPS9D+mS4c/fi4XPap6UTY2tSRfyZNVrb
	DR5oP4ITiJ41ZAH3d+ejlcU6wsvbiEEUszB68RIEJ2Iz+iXriCzJYSwIVVfyM7tG2dILDld34dwUs
	hszDpDAA==;
Received: from 22.249.197.178.dynamic.cust.swisscom.net ([178.197.249.22] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sZ7x5-0003sj-84; Wed, 31 Jul 2024 13:57:07 +0200
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
Subject: pull-request: bpf 2024-07-31
Date: Wed, 31 Jul 2024 13:57:06 +0200
Message-Id: <20240731115706.19677-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27353/Wed Jul 31 10:27:25 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 2 non-merge commits during the last 2 day(s) which contain
a total of 2 files changed, 2 insertions(+), 2 deletions(-).

The main changes are:

1) Fix BPF selftest build after tree sync with regards to a _GNU_SOURCE
   macro redefined compilation error, from Stanislav Fomichev.

2) Fix a wrong test in the ASSERT_OK() check in uprobe_syscall BPF selftest,
   from Jiri Olsa.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Jiri Olsa, Yonghong Song

----------------------------------------------------------------

The following changes since commit 039564d2fd37b122ec0d268e2ee6334e7169e225:

  Merge branch 'mptcp-endpoint-readd-fixes' into main (2024-07-29 13:31:28 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 7764b9622db4382b2797b54a70f292c8da6ef417:

  bpf/selftests: Fix ASSERT_OK condition check in uprobe_syscall test (2024-07-30 13:42:24 -0700)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Jiri Olsa (1):
      bpf/selftests: Fix ASSERT_OK condition check in uprobe_syscall test

Stanislav Fomichev (1):
      selftests/bpf: Filter out _GNU_SOURCE when compiling test_cpp

 tools/testing/selftests/bpf/Makefile                    | 2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

