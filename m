Return-Path: <bpf+bounces-44716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D339C6795
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 04:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACCC283B2E
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 03:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088B1607B2;
	Wed, 13 Nov 2024 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DICzeHVa"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE974158D93;
	Wed, 13 Nov 2024 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731467210; cv=none; b=WFf7t2jpSlmgtZvsKY/M8c9KIS0XIGM6YIWckiZ49//uaNdkbt8Z2vw0/dI3NHLvSv/GyWomOvcnCuSaHubhkuI+8yzm3z/n2ipqxqzevQqI+X3fKGo4PwW895QkH+KBCpod4crF1PHUtBsQ98SNFWwatXfHh/4adD79/gWA3r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731467210; c=relaxed/simple;
	bh=rt5c16Y06ofP5RX9B6ywfTKiVSzvW6XeEVau8r9XdX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=othT5cGqHe2pQKMZwC6E6gV8MGNZbsNqNof6eCur2SWbkDRC0whRD9zFQB+qcxc6pULcc+je7APrDloCsWc43SqPYsOMluaBXJftX1hwE1gC2rJfaKMnKV4/Wr/bUW61PjLw4pwhkaZiG1I9A28wkCacePZU1zWyhI0RNy4YFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DICzeHVa; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=2qHXXPSpQu5KTY6rB+5tEXnltmYvy32bmCRCpeBSVr4=; b=DICzeHVaYrFjxnxLv3w1iWHMVR
	1xQTBt0wXNUAtjRKheXa8QfkywZMtZ3DdCQ/9/9uc0txOl31yJsI7Inuu4JSVnsMOh5GtTqn8jVIC
	sCZyHYJzMm1dPWNLiCJ4/SR7m9XySGMmE72g3j4VoYolYsmCFdvOvMq9AZpTofYkGPtjZ48wUzi/k
	h0evE1tE1zCRABHFkiaYEqV4CKHOaG9hXccMeHrEC2QUvnxT7L7i2smGFBebJdt0SSKbJVEUmqODJ
	ybKjCja6+VYHxU0sW7MP8df6k4ySpH5kQWJovFIopDhdvGr9ZFQ9HW+J/H2LLnyRnyO9gaDY4F9WZ
	pHqTYGMA==;
Received: from mob-194-230-145-122.cgn.sunrise.net ([194.230.145.122] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tB3iO-000HVo-7N; Wed, 13 Nov 2024 04:06:44 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Subject: [GIT PULL] bpf for v6.12-rc8
Date: Wed, 13 Nov 2024 04:06:40 +0100
Message-Id: <20241113030640.24492-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27456/Tue Nov 12 10:49:43 2024)

Hi Linus,

The following changes since commit 2e1b3cc9d7f790145a80cb705b168f05dab65df2:

  Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2024-11-04 15:23:26 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to fb86c42a2a5d44e849ddfbc98b8d2f4f40d36ee3:

  bpf: Fix mismatched RCU unlock flavour in bpf_out_neigh_v6 (2024-11-08 12:41:43 -0800)

----------------------------------------------------------------
BPF fixes:

- Fix a mismatching RCU unlock flavor in bpf_out_neigh_v6
  (Jiawei Ye)

- Fix BPF sockmap with kTLS to reject vsock and unix sockets
  upon kTLS context retrieval (Zijian Zhang)

- Fix BPF bits iterator selftest for s390x (Hou Tao)

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

----------------------------------------------------------------
Hou Tao (1):
      selftests/bpf: Use -4095 as the bad address for bits iterator

Jiawei Ye (1):
      bpf: Fix mismatched RCU unlock flavour in bpf_out_neigh_v6

Zijian Zhang (1):
      bpf: Add sk_is_inet and IS_ICSK check in tls_sw_has_ctx_tx/rx

 include/net/tls.h                                  | 12 ++++++--
 net/core/filter.c                                  |  2 +-
 .../selftests/bpf/progs/verifier_bits_iter.c       | 32 +++++++++++++++++++---
 3 files changed, 39 insertions(+), 7 deletions(-)

