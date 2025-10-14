Return-Path: <bpf+bounces-70935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91091BDBAF6
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFC964FFD95
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6367730F7F6;
	Tue, 14 Oct 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjZAsvrh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8B30DD3F;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481815; cv=none; b=tNuUkW4N8BCea/syuS/V4OVSHCJEKdnj/i8/rbjPyv2AmXc6yDAbD3SJccKSayc5kl6lm6/GSZgA/SB/8rS2mH81SX/CThn+IFd3tJcfKSPGcTFsOXGL3UzF6Rn1phD1OaAhBL8rp9GJmWcLDZ+kl+ZH6K5Pc0bUp3kxGhFjGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481815; c=relaxed/simple;
	bh=UlFmiz3ZaocOcZ90TzBsi7a0twjzEqEnfHpnPajPIAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VJ8b5Z/O+tjW5GnGEtYyAlYxbVY6/W4nNM5KnDfF8Nyb4Nxtx9fsLZnniW4Zy7hEX9hi7oJrr5WQAxobbdXwsq6IzEwe0pi0nf0ptxQNzVMbvl4QfMXqA6Ow8cSSr4klAb6DKFKx1b/9z0jVcZzYjOHsgGEh2lSKcHZFMugoaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjZAsvrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E81C2BC9E;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481814;
	bh=UlFmiz3ZaocOcZ90TzBsi7a0twjzEqEnfHpnPajPIAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjZAsvrhL49JAgjAzTTKZJM0ET9NDVFkEkfq8clxX7PulFOoOcZ8n1kBjJrysTAU3
	 Jb37zfalZ98vfLzOfrTvDTeuV3iFX4jVnZmaGVPnB5qaIi+rkrtkIPdWHZFOuHrpvE
	 lLQpdUYT/XxzyePmbqSbSoHimzJUZq4+MU6jnkQ0BSQ0TVdbT0NoOO1E5HYI+ahvgd
	 Bl1uOZpEVuUthI2XonbMX1OGfr/Yq3WsVImIj3nOVSavqhLlLNw/WmaHPh2NsWzYXB
	 YscumGaC6HrP2hB9Tut1B7J/XkyimJA5RQKx86pxSu8UpJEu411FNmT4W2MnXMCWoJ
	 vN0u3KeMZ76kQ==
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
Subject: [PATCH v2 05/10] net: Remove struct sockaddr from net.h
Date: Tue, 14 Oct 2025 15:43:27 -0700
Message-Id: <20251014224334.2344521-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014223349.it.173-kees@kernel.org>
References: <20251014223349.it.173-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=494; i=kees@kernel.org; h=from:subject; bh=UlFmiz3ZaocOcZ90TzBsi7a0twjzEqEnfHpnPajPIAo=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnvLgm2z9jub5+4Lvsry/+88IN8l08aMr+YOyM1eIvfv vXeC+8odpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzEJ5jhf+2EPzeMXrb5eG06 uH2PiqjH5BsnPj3UNup+O3NuRW065wSGv2IdgXZXjeVq9lbETpp4QUdUYm9bUfO9zUdfb5uw11D kKCcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Now that struct sockaddr is no longer used by net.h, remove it.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/net.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 44cbec673741..e94f219ea309 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -148,7 +148,6 @@ typedef struct {
 
 struct vm_area_struct;
 struct page;
-struct sockaddr;
 struct msghdr;
 struct module;
 struct sk_buff;
-- 
2.34.1


