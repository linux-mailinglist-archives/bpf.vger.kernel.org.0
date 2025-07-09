Return-Path: <bpf+bounces-62787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140CBAFE959
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054BC189DF50
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911CB2DC34D;
	Wed,  9 Jul 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm050hpV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7F22338;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065286; cv=none; b=AwpBCnKoFxADUdcylRxq8m+3AQn0b2VEjcPiiupAsLDUHPUsk60SEgi6PAa70S3DuHes8LvWiGSAgLhBoM2dkMfrGIsCsFqLQHjCyLBWxzIYBDsgn/NZN1KNYA64wWGiC+14rDTgLwGwNrguOwoe/fyUOK4R+DSmZml3WcyAeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065286; c=relaxed/simple;
	bh=pqv9y2+ysL7+9uOQF2f7M0nQEyHKQ5MFTUOC7/mQbII=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rvTzcF2l9/L2QBfzProFfdPi787rtwNuJ7TsfqJzfBCnyH5xyeOyL5S7X8UwdWhWgW0+vhUEdy8SLv3mxrThi++qZ3qkcZSRcP8DxGZPDsBQETILDMMhBgDTgZlOxVz5K/aawf6wu6Ow7NgUJZkxYfF8QmQLusXlD9R2NGTxdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm050hpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 994F2C4CEF4;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752065285;
	bh=pqv9y2+ysL7+9uOQF2f7M0nQEyHKQ5MFTUOC7/mQbII=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Bm050hpVYvz/KcBWbECv8jilJtAy1L/4IqHFofIl7Xvbf5B/Xi3scAl1Ge5Fz+14z
	 POvmGERXBcu9sjcF9o38sWo9wuKb9YX77gDlFxgCCNzTxfaxG0zRnHYtLaw/sASpGW
	 Wt/KtfPOjk2EBjy12sK/eVHVISOp75PxVHg84aqNA79Aiz8WJ1XSSI2z4v2r4AUg1z
	 +at7paVM1j8UPNgoeMFT2vVcbHqOQydrBuNkfX3VQknl7BQq0FiD4H23zS+COBNbW6
	 d0U9pef2qCf4cL3KprbDoTuzluSbCZEbpxFxrwTw6nfnNHbQJnpIoqNKTNFOhokmXU
	 6/B8mGFddC7jQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86122C83F0A;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Subject: [PATCH bpf-next v3 0/5] sockmap: Fix reading with splice(2)
Date: Wed, 09 Jul 2025 14:47:56 +0200
Message-Id: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxkbmgC/3XNTQ6CMBCG4auQWVtTSgFx5T2Mi+kP0Ci0tqTBE
 O5u08SNxuWXN/PMBkF7owOciw28jiYYO6dRHQqQI86DJkalDYwyThvakGDlfUJHgnsYqYmq2hI
 lbVUrOKQj53Vv1gxeQbiezHpd4JbKaMJi/St/imXu/9BYEkr4iVFkKEou6ovCBZUdxudR2ilzk
 X2IOhHdD8ES0cnUeC17rNg3se/7G4l8liz9AAAA
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752065284; l=1938;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=pqv9y2+ysL7+9uOQF2f7M0nQEyHKQ5MFTUOC7/mQbII=;
 b=yePySAAhZt7yPjoxYZV+zzSkF/Ty4wntcYWGVd67nBFIWrSC2bquTXQ6BV9Jc2dYl5X+hgyBM
 UTd61t25t9wDaP3pZcK8RkoZKirweVg4IyCCsc0ZdwN7yh/ScCd18D6
X-Developer-Key: i=vincent.whitchurch@datadoghq.com; a=ed25519;
 pk=GwUiPK96WuxbUAD4UjapyK7TOt+aX0EqABOZ/BOj+/M=
X-Endpoint-Received: by B4 Relay for
 vincent.whitchurch@datadoghq.com/20240606 with auth_id=170
X-Original-From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Reply-To: vincent.whitchurch@datadoghq.com

I noticed that if the verdict callback returns SK_PASS, using splice(2)
to read from a socket in a sockmap does not work since it never sees the
data queued on to it.  As far as I can see, this is not a regression but
just something that has never worked, but it does make sockmap unusable
if you can't guarantee that the programs using the socket will not use
splice(2).

This series attempts to fix it and add a test for it.

---
Changes in v3:
- Rebase on latest bpf-next/master
- Link to v2: https://lore.kernel.org/r/20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com

Changes in v2:
- Rebase on latest bpf-next/master
- Remove unnecessary change in inet_dgram_ops
- Remove ->splice_read NULL check in inet_splice_read()
- Use INDIRECT_CALL_1() in inet_splice_read()
- Include test case in default test suite in test_sockmap
- Link to v1: https://lore.kernel.org/r/20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com

---
Vincent Whitchurch (5):
      net: Add splice_read to prot
      tcp_bpf: Fix reading with splice(2)
      selftests/bpf: sockmap: Exit with error on failure
      selftests/bpf: sockmap: Allow SK_PASS in verdict
      selftests/bpf: sockmap: Add splice + SK_PASS regression test

 include/net/inet_common.h                  |  3 +
 include/net/sock.h                         |  3 +
 net/ipv4/af_inet.c                         | 13 ++++-
 net/ipv4/tcp_bpf.c                         |  9 +++
 net/ipv4/tcp_ipv4.c                        |  1 +
 net/ipv6/af_inet6.c                        |  2 +-
 net/ipv6/tcp_ipv6.c                        |  1 +
 tools/testing/selftests/bpf/test_sockmap.c | 90 +++++++++++++++++++++++++++++-
 8 files changed, 118 insertions(+), 4 deletions(-)
---
base-commit: ad97cb2ed06a6ba9025fd8bd14fa24369550cbb5
change-id: 20240606-sockmap-splice-d371ac07d7b4

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@datadoghq.com>



