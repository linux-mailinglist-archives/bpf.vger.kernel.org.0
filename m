Return-Path: <bpf+bounces-73400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BC5C2E96C
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 01:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF723AB788
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 00:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645202153D3;
	Tue,  4 Nov 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWMCPT1G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD431AE844;
	Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215978; cv=none; b=DbbmGHiotp0JSPPr93bv0Q899FjeqkLuE/kyYTChOyvxLTuepvyGuSFPeN/C9nga0kyiEsLQqKW4IZgnBMKk7+rZRBFTU4NoleVwCPjZdk/iIeEpFTZCxzexx6iSpiFBOBKeH7ULnWXcLFYHqJisU6Bx/Czq32gDL230ODxKKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215978; c=relaxed/simple;
	bh=df1PiIrJZqCah2hLW/KzqMjbXuVjxXuE5Xm3CRH5CeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k7wZwCkaXqeFT2/sBkczT3M53nyoZX0n0H1UcaJk0jGazWuCx9YLcAx1/+BbG5x8J5hsGVMzI0NXzb+0w5k7LcJQ1Lgzl5iD6iUWRIJXAjUwJX2OYAB1TojgT6Teh+746lyWNlfkONDajiu8gPgS/WPu7fVp9DXc0R3EScMuY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWMCPT1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2F8C2BC86;
	Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215978;
	bh=df1PiIrJZqCah2hLW/KzqMjbXuVjxXuE5Xm3CRH5CeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWMCPT1GlLwIOPhnPiuVpNSuuyLPNkNoTdrvTrSVcAJ4uyC0UNhQmUh9U/G3hi9X4
	 VKuQQY2uCX0iHqKNiIwGyWrDHXrP8Aqu4gCVmzSeoz+pJl7N9J/G3K88/XTq6X889+
	 GutAcwBMviQaLXp+sG2rPfY6vHJcbLE7pPI3FRcFB6/tLxMXKZANQyovZbYH/JQsHg
	 RZPyY5dDF+m0Iaya/+nx7WqhYgl3Tu6b0Czc4Ypt8/2sK+gwxt3ZEWN7vPzOg237Cc
	 dRjCrZUpbnhlUoCNFd0URfVI2yRe1Ku/e5XYfC2uEfb0l0aJAxPwpE0hd5SRJAZQa4
	 5Cgk4ZAhRxptw==
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v5 4/8] net: Remove struct sockaddr from net.h
Date: Mon,  3 Nov 2025 16:26:12 -0800
Message-Id: <20251104002617.2752303-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104002608.do.383-kees@kernel.org>
References: <20251104002608.do.383-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=494; i=kees@kernel.org; h=from:subject; bh=df1PiIrJZqCah2hLW/KzqMjbXuVjxXuE5Xm3CRH5CeU=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmcHmrlW6+wn3R53LLrzvr/FgcfGvV+3vPfYVJvdf3yf e+nbu/u7ihlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZhIbSUjwzuxrBkrVdb2zitV fyPw7OaL3Pd/fldeW7I4/7rWhvevOX8yMhy7ynIr79/JFYsDjhbJOUZ83bvMs1apdM7foJ/mBV4 uGbwA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Now that struct sockaddr is no longer used by net.h, remove it.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/net.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index db6bc997ca5b..f58b38ab37f8 100644
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


