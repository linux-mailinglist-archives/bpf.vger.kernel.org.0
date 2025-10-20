Return-Path: <bpf+bounces-71451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4240BF3BC6
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FF5421C9B
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8576335083;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uikv6kM2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39C33374E;
	Mon, 20 Oct 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995600; cv=none; b=f2L5SNeYxpmxNlO0ipQA36nm7CI+z0fDueBaU5MjC0WD1VadoCG80+aklviu4/RlFdL7UWwEAmMsW3mTirfTi0uoo3lyc8iRX06qvAFDNR0vgO7k3wuNcRlSTwla64fbrqj7PoK7HuqNNCtr6vZvdotu7DtlGqkbr/bs8E62AsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995600; c=relaxed/simple;
	bh=LapY9CVctM9BRAvd8QjQH1ljjXM/ABSMR24t1Vu69IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0n7jWsR/Rw/BglNyhtRf8Xbzy2C0/wqp2JXUTIy1kRdTgfhVy+YqW5HMsKyg7EOKJPUmd/IyEgvp7p6hjKgRKc0y9tRAMKKCqOaBzwt+Z7rSQ/7k+8pXTJYIuJhqDja/UlAXrlJZOXWXxaCe+31PePKEI2et58/03OriR/QLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uikv6kM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7957C113D0;
	Mon, 20 Oct 2025 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760995599;
	bh=LapY9CVctM9BRAvd8QjQH1ljjXM/ABSMR24t1Vu69IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uikv6kM2IsCr+p0iEr1+NpMNj8Pp3z+rOnlv+JPJu+on6Doo7CDMh/+HBr+LncMIl
	 4rPJk2fv3CsNgg8V3Gl2KlM+jmr6Ptl/1s52duPHrogT2NoVJTgHVnrM7RORxSH+KS
	 emCM9DJ+2mG910zL/AjhSYtrFlhiDJHGarsu2W5YyaYDFjhndPGYL2IoAtlaQnfWvw
	 wMaZZYPlZp+3ZSnJER36OHqwJJk44lPggxSeQhQm+l2w+wXVF0+XptV4siFw7yT+l/
	 KdQNhEPzgqvQ0VQ4OF9cgva002Tqo6YjMyaWX/KBRTsLWah/J7rNiMzJxWhxJeSZzc
	 +oftgR0Gi49vA==
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
Subject: [PATCH v3 2/9] net/l2tp: Add missing sa_family validation in pppol2tp_sockaddr_get_info
Date: Mon, 20 Oct 2025 14:26:31 -0700
Message-Id: <20251020212639.1223484-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020212125.make.115-kees@kernel.org>
References: <20251020212125.make.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=kees@kernel.org; h=from:subject; bh=LapY9CVctM9BRAvd8QjQH1ljjXM/ABSMR24t1Vu69IU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfVnIfnjxLVegHi7yMHxfPDbn88oJ9nW+a1j6fssR+5 anvT65Vd5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExEdAEjw40r15N3HZzZzfa2 +ofhgQCN50/ucW+fFu/xj/Nnr/Un/kyG/ymaO07zev6utlBU1ym3zb0/XVBvgf7kvaFFt1JObEn +xAEA
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


