Return-Path: <bpf+bounces-66983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3CAB3BDFC
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7409E1C27030
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F06215075;
	Fri, 29 Aug 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="KhUcP6NK"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F61213E74
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478224; cv=none; b=n7ZNorGXP/KzYuBr/Nr8VM40k+pO9RAiC5jwem0vYrz4IQgS9zZOOfn8PISXf+0m9GDumZQW1WZEqSYQIgbk+HveZvqKiGGOUJAHOkNdB+sX1CE7UJlIh8aAQAdniM/axa+ZKgu7dZI2fnRqET41uIR2H/Hj9UN2fCSyzOoq0pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478224; c=relaxed/simple;
	bh=gdVzSL+28ULc4LxMcHaD8+63d4oDW1Snwzc30QOO86o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kw1odoPga6A8gRL3I8Ba6e4tUHJA2SGyvl8ZVbnAwx3U6LGCtvNlIMnvQK1UzZlUUUZIZEArqHQ+fGuyxotH5j3J7xXVT06rSsaIMRu2tNyy/WQ+jcLhpVRfz5FFLgHknNdArNgtLDXG1P721urthWJheSuX0iRsEvh8j7P/Enc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=KhUcP6NK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=NARGFFJA8QPI4hrpDATKnOIWyz07qooJhA7vx/7nkQQ=; b=KhUcP6NK/5ZAgipFdnsXDg0YPr
	Fi2b7DMXkmLVPNFfE/JOseWvhh0uwq7Eju6Nma5l+ruduoca0Ygq68pyYCN+YuI7GZeYS4Yxwkfer
	LwhL8HyuXMhhsYAAzx4yM+62ceEVNXFg+2wb5z0HtkrjfOzpUaO9swzyLEIcqQ2WXdqyyK64fztnb
	6gSluHGWyefTenWM8U7s9kEDmeQybbWGIPgAj2X1ayHvMaKrOqEn0s38coRvVZX/n+a+oyTVf6Q4V
	ecC59nUDtnbjf3Rzpi9RC3wRS6KeMzKq8oCIPTtTAI5jJrxL1DUQcbZI7fal3wRACT4mTOJCm/RMl
	ioCmCckQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1us0Dq-000CFq-1t;
	Fri, 29 Aug 2025 16:36:58 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	bpf@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH bpf 1/2] bpf: Fix out-of-bounds dynptr write in bpf_crypto_crypt
Date: Fri, 29 Aug 2025 16:36:56 +0200
Message-ID: <20250829143657.318524-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27747/Fri Aug 29 10:27:03 2025)

Stanislav reported that in bpf_crypto_crypt() the destination dynptr's
size is not validated to be at least as large as the source dynptr's
size before calling into the crypto backend with 'len = src_len'. This
can result in an OOB write when the destination is smaller than the
source.

Concretely, in mentioned function, psrc and pdst are both linear
buffers fetched from each dynptr:

  psrc = __bpf_dynptr_data(src, src_len);
  [...]
  pdst = __bpf_dynptr_data_rw(dst, dst_len);
  [...]
  err = decrypt ?
        ctx->type->decrypt(ctx->tfm, psrc, pdst, src_len, piv) :
        ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, piv);

The crypto backend expects pdst to be large enough with a src_len length
that can be written. Add an additional src_len > dst_len check and bail
out if it's the case. Note that these kfuncs are accessible under root
privileges only.

Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 kernel/bpf/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 94854cd9c4cc..83c4d9943084 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -278,7 +278,7 @@ static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
 	siv_len = siv ? __bpf_dynptr_size(siv) : 0;
 	src_len = __bpf_dynptr_size(src);
 	dst_len = __bpf_dynptr_size(dst);
-	if (!src_len || !dst_len)
+	if (!src_len || !dst_len || src_len > dst_len)
 		return -EINVAL;
 
 	if (siv_len != ctx->siv_len)
-- 
2.43.0


