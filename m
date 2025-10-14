Return-Path: <bpf+bounces-70932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3CBDBACF
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C9919A2180
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBED30E0F4;
	Tue, 14 Oct 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+nA8INO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78082EBDC8;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481815; cv=none; b=rQR6yQ5TuZF22PEeMCd2pUB9sGLu3SfjuQV3iq1X8Vb3XQeYsEwyq+Pn5c4rfojaLjFljmeTDbCy2Kq3wuY8rsw9fkmyunH1M9QWwReUzpaotGMtfmTajPPLjktxJ6ts7dQe/I3J9KRPE9TFahyO64SBh7riXcZAYCM5R07UIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481815; c=relaxed/simple;
	bh=LapY9CVctM9BRAvd8QjQH1ljjXM/ABSMR24t1Vu69IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdRsCE/XSRUQjzaPlNT8xa4CBgrrXJVoWpQRvCbPPXfcOpK9J1i87GwMoFi/8OTnzmNzeMV1AJwBZyUAY2hs7jhAt2mjMHHgqQXMk+iT7RTVTSUaNGfDtDGMmnzUbAA6FvbRL7XC60wey119eYMWXuFwhco+fPJwn9eb72Pz4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+nA8INO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829A9C116C6;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481814;
	bh=LapY9CVctM9BRAvd8QjQH1ljjXM/ABSMR24t1Vu69IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+nA8INOOFtKaselH9bW9rVoET4KBnt4R6tCyOz46D5R0/0pfY1e2TDv7hG73QI6l
	 Tif0zqJyVorZzTeT3F1fJJfnQmMRQ/b1UWtUgfQRFMCg+zRFbqhiGF3hMbHZ7lcsGC
	 02GGP1Pa5Y6/l/y8BJokDTk7RdyA1mjxzQAUDCy9btZAHaH4MgpvfrgUD57lhqNVb7
	 M1dbg+geSb7m50KYtQugeUNzcwqP+Hfsj5maggoqUyVDS02z0r8DDeG9NSLqmcTsEi
	 pCW0aPND3LNRRmVxG4AeFiF9uaIIVzTa8kfCkwXpKMp91u1ENORPncu3VSnmMrOup3
	 ZaX4e/+z3ENqg==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 02/10] net/l2tp: Add missing sa_family validation in pppol2tp_sockaddr_get_info
Date: Tue, 14 Oct 2025 15:43:24 -0700
Message-Id: <20251014224334.2344521-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014223349.it.173-kees@kernel.org>
References: <20251014223349.it.173-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=kees@kernel.org; h=from:subject; bh=LapY9CVctM9BRAvd8QjQH1ljjXM/ABSMR24t1Vu69IU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnvLgkcnjxLVegHi7yMHxfPDbn88oJ9nW+a1j6fssR+5 anvT65Vd5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzEJ4HhvyOvEZu/8MXTmz1f q21+Y+52w+z5mXV/ju7ocpEXNd7FF8zwz/D1UsWjzZmGe/jcHmxL+nB083r588l/50sYS2g+bxZ azgwA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While reviewing the struct proto_ops connect() and bind() callback
implementations, I noticed that there doesn't appear to be any
validation that AF_PPPOX sockaddr structures actually have sa_family set
to AF_PPPOX. The pppol2tp_sockaddr_get_info() checks only look at the
sizes.

I don't see any way that this might actually cause problems as specific
info fields are being populated, for which the existing size checks are
correct, but it stood out as a missing address family check.

Add the check and return -EAFNOSUPPORT on mismatch.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 net/l2tp/l2tp_ppp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 5e12e7ce17d8..b7a9c224520f 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -535,6 +535,13 @@ struct l2tp_connect_info {
 static int pppol2tp_sockaddr_get_info(const void *sa, int sa_len,
 				      struct l2tp_connect_info *info)
 {
+	const struct sockaddr_unspec *sockaddr = sa;
+
+	if (sa_len < offsetofend(struct sockaddr, sa_family))
+		return -EINVAL;
+	if (sockaddr->sa_family != AF_PPPOX)
+		return -EAFNOSUPPORT;
+
 	switch (sa_len) {
 	case sizeof(struct sockaddr_pppol2tp):
 	{
-- 
2.34.1


