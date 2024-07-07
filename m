Return-Path: <bpf+bounces-34019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E730929A17
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 00:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024C0B20E0F
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE66F30E;
	Sun,  7 Jul 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="xgaWsu1Y"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E130C79D2
	for <bpf@vger.kernel.org>; Sun,  7 Jul 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720392377; cv=none; b=dwst3iIa8kpZhX/Ggy+kDoMFPeksmJeZSOOwXXxA0l3D2z5mI79E537yZBKPADbitxFEOPOxIRKq5NonZSCXqyRDqYwnOxLxOw6l9J/GiyWwaWwSI70oQFyikJX9fnf4ZccRtWJHtd2+pagHusg/79TuRfYk5WPsrt9Oate/cQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720392377; c=relaxed/simple;
	bh=5WXa7TXUt0pTujieU/s8THkO0eiSAbtWwQVfoul+XZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyfRR5YR+Vazn2MpIstFvCeg+/cH/n7dE1yEmkCe1LSQiQTAY9dysVrR9fG6j58JkhCjt2kuL3NmToRgc1Gd7Pk/qNfJKWzWIPFQlCyrBeCSsmo7RvhTz3Wi0JYopPrRgrcOTA2TDvYtmuZuEtvvvS8JtNdghikuU7/eecrP2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=xgaWsu1Y; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sQaNs-00Ept5-70; Mon, 08 Jul 2024 00:29:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From; bh=3uQCmZos7NiStkurhNQ3kVX1Rs80FogJIMD1ibPixD8=; b=xgaWsu1YWjlA9
	9hsWZaQs8T6gVoZd8fXWyK/mhJU4SBEdV+7kbrBWRvsThK/Y6Z2eR2I7Y43WYH7Vd7v2o2/yC0lH8
	UFx/NeeH8XPcKfdocqiIOp/ShBx/YRjVPlJH50Ob7JbztNC9WFp7Y0AMQ+e2cExXfLKWEIK7KEXTw
	ECUSnlJafkwIRjVds1eo3wrsGFmaqjLdGdsN2R68lVWAFgnsa0A5Dik0yPRpgyggvUO3mFZ7V+l3C
	zbsFNwumc1//IisU9+94ZUjD02lV4OSOl73VTQaKSmWJ1MIOqY3n5wpBqicw20dvYhKp5oK3TRX84
	Yw2S8mH8QkeGGGZ+cYoKA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sQaNr-0005zf-5J; Mon, 08 Jul 2024 00:29:27 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sQaNZ-009IHx-Mb; Mon, 08 Jul 2024 00:29:09 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	kuniyu@amazon.com,
	Rao.Shoaib@oracle.com,
	cong.wang@bytedance.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v3 0/4] af_unix: MSG_OOB handling fix & selftest
Date: Sun,  7 Jul 2024 23:28:21 +0200
Message-ID: <20240707222842.4119416-1-mhal@rbox.co>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PATCH 1/4 tells BPF redirect how to deal with AF_UNIX's MSG_OOB
(silent drop). The rest is selftest-related.

v3:
  - Add selftest

v2: https://lore.kernel.org/netdev/20240622223324.3337956-1-mhal@rbox.co/
  - Reduce time under mutex, restructure (Kuniyuki)
  - Handle unix_release_sock() race

v1: https://lore.kernel.org/netdev/20240620203009.2610301-1-mhal@rbox.co/

Michal Luczaj (4):
  af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
  selftest/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()
  selftest/bpf: Parametrize AF_UNIX redir functions to accept send()
    flags
  selftest/bpf: Test sockmap redirect for AF_UNIX MSG_OOB

 net/unix/af_unix.c                            | 41 +++++++++++-
 net/unix/unix_bpf.c                           |  3 +
 .../selftests/bpf/prog_tests/sockmap_listen.c | 65 ++++++++++++++-----
 3 files changed, 92 insertions(+), 17 deletions(-)

-- 
2.45.2

