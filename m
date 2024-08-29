Return-Path: <bpf+bounces-38414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49AE964A6F
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FCF1F23FB6
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0661B375F;
	Thu, 29 Aug 2024 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaFvFpIo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F033998;
	Thu, 29 Aug 2024 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946360; cv=none; b=t7crnOSANUN9t1mFLUItQWwhFqmBZg+wm8JgMV5gD/uyyEAhZc8a52kDaLacd03xXlQJcWNasO//wgu6XMzcwlf7SUasU4TeWSL6h/iFNoOJy8WyfAfCiJkPVyTij3gDOObqQ5uCrJyT9n7F/+Ka+I21EJMqF4UOtDihFJ4fAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946360; c=relaxed/simple;
	bh=svcZSWyEi0/8fIQjANUGpubrQbN+mVCU2zWBTvN1va8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jKVgDanmueRadp22CyYhLs4Dp8q/T7qpK9T2ZN0WekiX06HhWzOm4I7CqLlkmvXY8Nu/5Zhj2Xe/ZXJCLpez5ZoZt8jK6NoEkbpdMrxkbTz2c1jEMvZ+S5W4GwRf3cdgcvRVjkx49uX4NLC1lhCQuWts5fXDllV2EuGfu6Vx/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaFvFpIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B509FC4CEC1;
	Thu, 29 Aug 2024 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724946360;
	bh=svcZSWyEi0/8fIQjANUGpubrQbN+mVCU2zWBTvN1va8=;
	h=From:Date:Subject:To:Cc:From;
	b=ZaFvFpIoO3242v8nPJ40vqFVzbWYqP8Kai8XposeOmDDUvYkNvnU6N5cRt5TiAQFE
	 JSNK0JYZIrcPmttSCh1k+BwoA9UEp1/EQO/k5JJKM8hy16jZ9SlVX9wDckt/F5w7sT
	 haXHvrTYShAA6odnEIcYcW+cmK5rdvF6gMOKJ2t+zl9+/CM/UAdaAQ3ZXCBR9IkuHO
	 6S5+0CLC0hdlfM0Q94TKlmGJdU3IfJ1SBL6p9/Wuvl/zFHIgXNfDul8fYEOWFBizlG
	 RF1Y82CokSFS9f0vhtewLSj8j/nZMh0iBlIOiduBNsniPDNMTP6UlyhkQWZRrBigDd
	 XUUpCoVEfPuOQ==
From: Simon Horman <horms@kernel.org>
Date: Thu, 29 Aug 2024 16:45:51 +0100
Subject: [PATCH bpf-next] bpf, sockmap: Correct spelling skmsg.c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sockmap-spell-v1-1-a614d76564cc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK6X0GYC/x3MQQqDMBBG4avIrB2wQcV6leIiTf60QzWGjBRBv
 LvB5bd47yBFFiiN1UEZf1FZY8Gjrsh9bfyAxReTaUzbDObJurrfYhNrwjwzbG9C5+EH11NpUka
 Q/f696J0CR+wbTed5AalKauxpAAAA
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in skmsg.c.
As reported by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/core/skmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index bbf40b999713..b1dcbd3be89e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -293,7 +293,7 @@ void sk_msg_trim(struct sock *sk, struct sk_msg *msg, int len)
 	/* If we trim data a full sg elem before curr pointer update
 	 * copybreak and current so that any future copy operations
 	 * start at new copy location.
-	 * However trimed data that has not yet been used in a copy op
+	 * However trimmed data that has not yet been used in a copy op
 	 * does not require an update.
 	 */
 	if (!msg->sg.size) {


