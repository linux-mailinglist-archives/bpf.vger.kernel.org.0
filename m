Return-Path: <bpf+bounces-71460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90003BF3BD2
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E161918C1323
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69B337BAE;
	Mon, 20 Oct 2025 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRLhm3fB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF263370F1;
	Mon, 20 Oct 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995601; cv=none; b=WjYMUuUdEi3yJ+cR/7GP8N/yuoB8gLvZNQX2Xi2lC+oJPMkb+c0omb87gdvJqBiMe1WUi2lFPh8qyprom/80ossLyYBEx45l1IpgBsnYw/dtpQgd4i648GxbDPi4M97qQoAmat3IEqj+/vclf3BSFrau2jdLZ/8L3hKPNYIWcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995601; c=relaxed/simple;
	bh=UlFmiz3ZaocOcZ90TzBsi7a0twjzEqEnfHpnPajPIAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXz4kLX2NpY2NsajaLhRHuw5XQyoL6vCDmoCN6VHYWVcpcYxlAtk9HZ0FD/Q6a1NpUYmfKsQhGPsEIENcLIlf4BsvUN5XEFpkgdXewv58YO1Qek7Y2plthNzy7zAlS5nu7qhBH+ryVOm3zRrtVNq5/sYuByIpHCfM9D1gqiGU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRLhm3fB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0394DC16AAE;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760995601;
	bh=UlFmiz3ZaocOcZ90TzBsi7a0twjzEqEnfHpnPajPIAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRLhm3fByi1+c2B63WfTkr6Ks4AS7LV0zCJfbCzvb2w1lvvq/deyAJvHgVGD8X+UD
	 P0KkQ8sTuww0RgLGbMnWimohTKEGIXwCXkKi7L7s5jQCdhXSFra/fBWJ1NBB7T9MYA
	 BWyyz+sMoX9bPE8y6pjKrUrdqRrjXvgqqW6ongctcmcT2grL1myGvHjpfxag+QH5IL
	 xZD9eDtcEekN0nWJcI1Ff/IJjR1wqhgY4kWM9PHJxPrPmXorI2YW9/oMakMpwvY3rm
	 HiJFG8oY1OeJqjg1EAoZxurP4pXRJaQoB1vHiWcPB5FjolpXnbHTD9criXpHxJilvv
	 SQl/4bVb1LDZg==
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
Subject: [PATCH v3 5/9] net: Remove struct sockaddr from net.h
Date: Mon, 20 Oct 2025 14:26:34 -0700
Message-Id: <20251020212639.1223484-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020212125.make.115-kees@kernel.org>
References: <20251020212125.make.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=494; i=kees@kernel.org; h=from:subject; bh=UlFmiz3ZaocOcZ90TzBsi7a0twjzEqEnfHpnPajPIAo=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfVvK0z9jub5+4Lvsry/+88IN8l08aMr+YOyM1eIvfv vXeC+8odpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExEx5Dhf/D2o70TVaZwXT2s a8HQ/cz6n8jBrEePSo64GOWcNVQ5tYaRYXP06qakZOFY1gjVl6rNT9Q/Zc09UXH3C0/RlPk9k18 cYAMA
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


