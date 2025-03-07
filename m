Return-Path: <bpf+bounces-53554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BF2A564EB
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 11:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C3F189092F
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E920E024;
	Fri,  7 Mar 2025 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="U+xxG5pC"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1A1E1DFB
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342634; cv=none; b=d30Rw9dSRL4YGSZfMs/shjqUYwn96aOxezT/+NVwkoCLMAt+B7QfiRSziZI4Wsnj3elCPRqXQhaZQ5i1hbCmhZcxjzMn+oXe87QqG4B8nD8hSrUw1HRTWtjjkecp/nVpLCq2d7Zbk0D5IpoAUUHXEoTsXBQImffgNHwOJbshGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342634; c=relaxed/simple;
	bh=5g52VZC2m4qb28zWWYMlDqhl4Hs4GAq3VIvQXFr03Ok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tGgoJ20M4kxzcGqmeLzVvV5TDlQBtNrH9UucuN7cgDL43ZSj3lHQL1Ah8M/kxcLF/dXL4DUUMdt9T3wljE70OsGAm92o4GSiSVdBr3xmzIMUM894OvF5ILD9RejunHilqNYuELq2qU8XanawHmwR++DBL3z8R6RijbqoRWbh3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=U+xxG5pC; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tqUlM-0038J2-Cj; Fri, 07 Mar 2025 11:17:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=C2yS6873fCjR3b/tIJyZ+cWJ/Ee384yxEN8ZvezaCnw=; b=U+xxG5pCU20mAUxaT+aEljtBTy
	+iXAJKuojD4XwYDk2GVbPBFzu0fbVFVBLT0VvyG4Xi52KalxaNl/glfzBUvA/vRJ8UDSiJRWRhCpy
	SpGq7X4rv49SRFXHpuIsFLGXPD+bc95cSzzAe/l+rQRe3fBdWz86iDNquGEKh8Aw0b0t/3mBU6WIC
	m9PzXl4ilhCTguRNGuTjLLDMHnw1S8m2RSOT/RcB1TfQV8yqorkwff2yEh2g6RAJ7doSrlltSjUzC
	/Trd9+2Y810tIWD6kRUWdM3mqU8rWjn3YZPOmPl6G5EXrbC2+PnQ5shvvGJV/L6kebTo5YR5P2TxK
	NsjBac4g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tqUlG-0001hI-LA; Fri, 07 Mar 2025 11:16:58 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tqUl7-006nFb-Mj; Fri, 07 Mar 2025 11:16:49 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 07 Mar 2025 11:16:12 +0100
Subject: [PATCH bpf-next] bpf, sockmap: Simplify iteration on link removal
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-sockmap-del-link-cleanup-v1-1-a042364bbeb1@rbox.co>
X-B4-Tracking: v=1; b=H4sIAGzHymcC/x3MwQqDMAyA4VeRnBdoA7Lhq4wdYk23YI2lnSKI7
 76y43f4/xOqFJUKQ3dCkV2rrtbgbx2ED9tbUKdmIEe9I09Y1zAvnHGShEltxpCEbctI7hHY+ZE
 p3qHluUjU479+wpgjmhxfeF3XDyIR7t90AAAA
X-Change-ID: 20250212-sockmap-del-link-cleanup-208ca01ba2f7
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Since commit 75e072a390da ("bpf, sockmap: Fix update element with same"),
using the _safe variant of list_for_each_entry() is unnecessary.

Simplify the loop.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 82a14f131d00c604f1dfa51e51563aeacda44198..b89d42f7ba702badd5b00c6329e3c9eea8ed4fd3 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -143,10 +143,10 @@ static void sock_map_del_link(struct sock *sk,
 			      struct sk_psock *psock, void *link_raw)
 {
 	bool strp_stop = false, verdict_stop = false;
-	struct sk_psock_link *link, *tmp;
+	struct sk_psock_link *link;
 
 	spin_lock_bh(&psock->link_lock);
-	list_for_each_entry_safe(link, tmp, &psock->link, list) {
+	list_for_each_entry(link, &psock->link, list) {
 		if (link->link_raw == link_raw) {
 			struct bpf_map *map = link->map;
 			struct sk_psock_progs *progs = sock_map_progs(map);

---
base-commit: 433873f9e6dad71f1d9a0d4966bfe92d26809dbd
change-id: 20250212-sockmap-del-link-cleanup-208ca01ba2f7

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


