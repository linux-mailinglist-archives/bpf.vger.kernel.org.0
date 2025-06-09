Return-Path: <bpf+bounces-60045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CCFAD1ECA
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F6C16BF8B
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F46259CAB;
	Mon,  9 Jun 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQWgLbia"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075F2571A9;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475633; cv=none; b=Fumt732UKXftqriHZp4cT/4s8LH1Zc0SsoIyaEqoT1O9VFzC44AemOhb5ozPsGKoZmfiEhuwk6WV1uqERwEjGDpuhut67R30j7P9K750xmV6oOZ27w8xWB1Pe+oeO8l69wW7dYwkoGH7rhLYqI3bpsz0psquB0AiQFhLoppHD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475633; c=relaxed/simple;
	bh=XGEWAwE33wL/9vohSj+5FqkrczlWwGAL/bYW7vM/ZPA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O+mkcsyRl04fLnyXfhTloREV0XOy+vhIU6w9q8orXptqvI+Sq/KwBMb73gWOashd7AUokrRJq2mtQF/4MlyefeIYJOv4gKhwDMk9DGETvDNRIslNL4PDMxor2ly++YOi82pAkNQ/Fn9Ee3denKdAXW59pNkzLu6PwaA8Mut5oA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQWgLbia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69FC4C4CEF0;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749475633;
	bh=XGEWAwE33wL/9vohSj+5FqkrczlWwGAL/bYW7vM/ZPA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DQWgLbiaPw9QyeTx/pAl+vyG/ThDGRFajvYGAECS6OioXlml9/4Yl5lLmWiZ0fu+0
	 Lek36Cbr1Mwv01pbCVUCPza5cagiNQU9XBxMjWwM/pmshhFt7K+jphheRXaHxrNAlP
	 RYTOhF9CgiasAQVKzZQD4L5agX42udHpPnIdo9Lo97uWlwUZdzsEvxvBWuwPUGq517
	 ijsH3mEELB9pfNkrIVULE0QGpdjEJWAyhpMRBUcisdZT4xoxKvEN5+8KTHTw4hRO0c
	 m6BrWfbTk3qi2lKKc2n47f+Js81Y/xSUCKGHVpyQfF5uGJ11C8Q6Z4WkHFe1H5IhWo
	 +vOrYzuBDLiAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2B2C61CE8;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Subject: [PATCH bpf-next v2 0/5] sockmap: Fix reading with splice(2)
Date: Mon, 09 Jun 2025 15:26:57 +0200
Message-Id: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACHhRmgC/3WNyw6CMBBFf4XM2jFtrWBc+R+GRR8DTBRaW0Iwh
 H+3Ye/y5OSeu0GmxJThXm2QaOHMYSqgThW4wUw9IfvCoITSohY15uBeo4mY45sdob800jjR+MZ
 qKKOYqOP1CD7Bxg4nWmdoixk4zyF9j6dFHv5fdJEoUN+UMMpYqe314c1sfOiHz9mFEdp933/T9
 CxaugAAAA==
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749475632; l=1657;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=XGEWAwE33wL/9vohSj+5FqkrczlWwGAL/bYW7vM/ZPA=;
 b=SczZKmrp+zK4X6raqu8rOTd0Pq0ybIE4stOf67y5EaqbMwDrcbYips0hY2slbQcbVYkNtGggr
 BRYiYezLd/+CJitEpb/xFkTTTgF7duZ6yGNzVCJQhf+N0tepUtYyjRl
X-Developer-Key: i=vincent.whitchurch@datadoghq.com; a=ed25519;
 pk=GwUiPK96WuxbUAD4UjapyK7TOt+aX0EqABOZ/BOj+/M=
X-Endpoint-Received: by B4 Relay for
 vincent.whitchurch@datadoghq.com/20240606 with auth_id=170
X-Original-From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Reply-To: vincent.whitchurch@datadoghq.com

I noticed that if the verdict callback returns SK_PASS, using splice(2)
to read from the socket doesn't work since it never sees the data queued
on to it.  As far as I can see, this is not a regression but just
something that has never worked.

This series attempts to fix it and add a test for it.

---
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
base-commit: e41079f53e8792c99cc8888f545c31bc341ea9ac
change-id: 20240606-sockmap-splice-d371ac07d7b4

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@datadoghq.com>



