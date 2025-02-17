Return-Path: <bpf+bounces-51737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208ECA38387
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 13:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF16B172D66
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3B521B907;
	Mon, 17 Feb 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzgUpre6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1302F5B;
	Mon, 17 Feb 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796965; cv=none; b=j6fuLIszq8eBsULJ3zzkHC7i20K9dIKzEqZ2Q/QgjoiuqrajLWolDCdZi28icahHcHrJlWY/oundc3lKZKNB4gZNVDVJH1Odc3zScfS7hlM/wqYW1KDsDvWvk1AmqCsghUzeWSxauIR/7PZRkpEgpv3Z/qjvuJjOVvua2epdWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796965; c=relaxed/simple;
	bh=UtcPCfLeZS5GfGD58kyBDLA+3TYY+n8i7oQj1TJuqBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uaZHvCQXpvyxLddECzKqfuHWZcVVKCj/jXsLJU5e9b1lPugLFX9EW/Jf4wFUD65vvSR3DzKboBOOsSfIv1uylbSs7beIvLuqWuD3IuDkA0hqKtwofKlGGELVJZwUM0kl+EJa5uPJU3ekG0Nipfpylcs+syr4pEuguJ7sQxUyXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzgUpre6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F52C4CEE4;
	Mon, 17 Feb 2025 12:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739796965;
	bh=UtcPCfLeZS5GfGD58kyBDLA+3TYY+n8i7oQj1TJuqBo=;
	h=From:To:Cc:Subject:Date:From;
	b=tzgUpre6GSbt82LcdJMAoz+ElzdZhUaNDers9AUplHZ7lpw1Urj2GozrxeFzSyfVD
	 2ckMnZ0VisAjUbZlvJOHJ2CkRI6SJdhrDTzG+aOH2OOH3x5T0IYZBbpfelK2fyk3//
	 +ftWeIGQ0h5RDAPWb6bChyy0icHUq3WQNiKC1Ooy9Ibv5YGKOtAvg++EekXtm4bUZE
	 qjyZfArqYCoJUKPwE2eHBKUI4wa+oOzNqEDcVNqA8D1zyBeReUDgHapDslMN7OV6PE
	 yFtFpxNRF2Zk0pc/kH5UinbQBhnRBgAPTZPWWGjJy0Rf4kSpFrNC34XrAOT7WJPF9X
	 Yeet6LQ2/tuSQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	bpf@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: bpf - Add MODULE_DESCRIPTION for skcipher
Date: Mon, 17 Feb 2025 13:55:55 +0100
Message-Id: <20250217125601.3408746-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All modules should have a description, building with extra warnings
enabled prints this outfor the for bpf_crypto_skcipher module:

WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/bpf_crypto_skcipher.o

Add a description line.

Fixes: fda4f71282b2 ("bpf: crypto: add skcipher to bpf crypto")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/bpf_crypto_skcipher.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/bpf_crypto_skcipher.c b/crypto/bpf_crypto_skcipher.c
index b5e657415770..a88798d3e8c8 100644
--- a/crypto/bpf_crypto_skcipher.c
+++ b/crypto/bpf_crypto_skcipher.c
@@ -80,3 +80,4 @@ static void __exit bpf_crypto_skcipher_exit(void)
 module_init(bpf_crypto_skcipher_init);
 module_exit(bpf_crypto_skcipher_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Symmetric key cipher support for BPF");
-- 
2.39.5


