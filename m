Return-Path: <bpf+bounces-55526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E8BA8255F
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 14:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47514E3675
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A142641E8;
	Wed,  9 Apr 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="bO3gSMGV"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472D263C76
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203135; cv=none; b=TsJcPGAE37Snyp9vNaMl9ZDtiGreRt94Gw4J1pFTDRn++hWISlT98LfzH9AMlkOFrqw2FTkz2Zu/mXyqBosD7dk7FIHeK7iS7SPeUkY0vN5oNN4744S3zjn6ZY4wKFgOcloJkoxM7X7HghvBsA6c5hNN4lb08jEKw7MKO+beytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203135; c=relaxed/simple;
	bh=Wga7NfE5EOLKXNPpGWNCl75SXWhKLrcAiVKGdRIqwI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S6RcpO6DfBIbi7o3gJELa/Reu6f1opumva2908NxJkLMSQ7UH5OZy8oTJkr7Sjhy86l8C1ygD0h1Bkm2BYj3g2x0ZCRu59ssD0f8ZsJIO9UaRb+sHHetxuG5ITZCQXXXO6dyxCEy4uM9GZYB/emosiK4L3tqJs1/cVbLfc++Sg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=bO3gSMGV; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u2UuO-0007zR-7N; Wed, 09 Apr 2025 14:52:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=f8y5kARShR5ZLHXs9fSAYU7oghihWo6U0sGdj42AVuw=; b=bO3gSMGVQs62Kc9g60sAUfmuGj
	yV5w2IXK7bndM+9Q9OgJCsQbMWEJK55eaWfCdXoPtodwc2+Prh/ud1GqN09+2Qkamzo/h+Ej9w0zk
	Z9HfRv0DBHzzhENH64a65Ho9pkhWzhR9U4BwKBq1Ni95KLsEXHhf4ISDuLCK7dB+4tczkZ1BKcbjU
	kSFmpUXTfNqzUHSclNEbrl2dNDyRBEhm7N+pF1P9RZdx0hbi3z5nURjKRSwGC5VFlR8qlelWyni32
	bhIXGcgT4akapkAg+PubdrNyaWsMzLyyy/SI95MjvGystZpnOlVMVDB0ywiOKycPJQ8opLpFnB1H5
	k6YwmlZw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u2UuD-0003GE-PE; Wed, 09 Apr 2025 14:51:54 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u2Uts-0021Ze-Ld; Wed, 09 Apr 2025 14:51:28 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 09 Apr 2025 14:50:58 +0200
Subject: [PATCH net-next] af_unix: Remove unix_unhash()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-cleanup-drop-unix-unhash-v1-1-1659e5b8ee84@rbox.co>
X-B4-Tracking: v=1; b=H4sIADFt9mcC/x2MQQqDMBAAvyJ77kKMNtB+RXpIs1uzIGtItATEv
 xu8DMxh5oDCWbjAuzsg81+KrNqkf3QQoteZUag5WGOfZjQOw8Je94SU14S7Sm2IvkR0diAavoF
 eo4OWp8w/qfd6AuUNlesGn/O8ACHfB5J0AAAA
X-Change-ID: 20250406-cleanup-drop-unix-unhash-623dd3bcd946
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Dummy unix_unhash() was introduced for sockmap in commit 94531cfcbe79
("af_unix: Add unix_stream_proto for sockmap"), but there's no need to
implement it anymore.

->unhash() is only called conditionally: in unix_shutdown() since commit
d359902d5c35 ("af_unix: Fix NULL pointer bug in unix_shutdown"), and in BPF
proto's sock_map_unhash() since commit 5b4a79ba65a1 ("bpf, sockmap: Don't
let sock_map_{close,destroy,unhash} call itself").

Remove it.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/unix/af_unix.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f78a2492826f9cc1e302ee6f8ca93c367656670a..2ab20821d6bb244a09e0364e1c649042360e23b1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -950,13 +950,6 @@ static void unix_close(struct sock *sk, long timeout)
 	 */
 }
 
-static void unix_unhash(struct sock *sk)
-{
-	/* Nothing to do here, unix socket does not need a ->unhash().
-	 * This is merely for sockmap.
-	 */
-}
-
 static bool unix_bpf_bypass_getsockopt(int level, int optname)
 {
 	if (level == SOL_SOCKET) {
@@ -987,7 +980,6 @@ struct proto unix_stream_proto = {
 	.owner			= THIS_MODULE,
 	.obj_size		= sizeof(struct unix_sock),
 	.close			= unix_close,
-	.unhash			= unix_unhash,
 	.bpf_bypass_getsockopt	= unix_bpf_bypass_getsockopt,
 #ifdef CONFIG_BPF_SYSCALL
 	.psock_update_sk_prot	= unix_stream_bpf_update_proto,

---
base-commit: 420aabef3ab5fa743afb4d3d391f03ef0e777ca8
change-id: 20250406-cleanup-drop-unix-unhash-623dd3bcd946

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


