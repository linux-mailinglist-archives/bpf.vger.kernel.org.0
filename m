Return-Path: <bpf+bounces-64738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE0B16695
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 20:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FD43B349D
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125322E1744;
	Wed, 30 Jul 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utah.edu header.i=@utah.edu header.b="rSh14cxX"
X-Original-To: bpf@vger.kernel.org
Received: from ipo3.cc.utah.edu (ipo3.cc.utah.edu [155.97.144.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0272DCC11;
	Wed, 30 Jul 2025 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.97.144.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901631; cv=none; b=PleSf5xPat7M85878Jrf0mvAHA5GsOpJc1blRKjNjUa1op/8OaBE6mefxZqXUcCU6wGT38FnriyP0MkhTbJPr+vYZfhrQnp1oxL+t5IDdNTAjQADZUwv+S9l8l+PsWZljRuNu5RNvNcY9riavdJuYrdp5cMYRnzqgEMlJQDuaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901631; c=relaxed/simple;
	bh=B4xizvzPJaAJqXSKIX5zRqAjYcZE4smDh4EfpK/snDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TYPqyGN8zgRRVmLSH3FBn2xGv9WoBlSuIb27AeLGLvcEA54W8fkGxa0U6d87wTYutrtfPgWqpvkda+VE8YaqBXL3YoQ4KtcNAy3Fg/IfgV6hj8RZrb+bzTM5R59Mvhu5S/cSL4ZgNo5Z0wbw+YHFQhkR3ydL3ny1ckWm5WbralY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utah.edu; spf=pass smtp.mailfrom=cs.utah.edu; dkim=pass (2048-bit key) header.d=utah.edu header.i=@utah.edu header.b=rSh14cxX; arc=none smtp.client-ip=155.97.144.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utah.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.utah.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=utah.edu; i=@utah.edu; q=dns/txt; s=UniversityOfUtah;
  t=1753901629; x=1785437629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B4xizvzPJaAJqXSKIX5zRqAjYcZE4smDh4EfpK/snDg=;
  b=rSh14cxXkS1d3zQm/kyKr2OGxRqh4txtHZZTm9J9aX0T4glOPRxE4JNQ
   +oSn3oXLxp3M1p2JJ3QOYSf5NsrfU90fDzCfFX5va5lNpgHLySfuv1WID
   KB8sgZfXE8qMuDtMoNPte3EeEwrxG9jbVpaGYaQ3BMag2e7rNsiaEb/zv
   8xT8D83e9srcWC+as7mKGrxB2rWSppDPhWUPkRRBW6PneAcumeEp5PrwH
   Yq0moV6txnma0pDK71O+3R47Kyrwl5Ts4/HvIb4mJq6EmA8r6GEkOHlcA
   +XmFjODG6kwqSeiT6fphNWSbQJK5aDnYF/f9mSpD9100d6qf5YphPLku/
   A==;
X-CSE-ConnectionGUID: 7hv1Hl48Stu1Txd6ZxVB+Q==
X-CSE-MsgGUID: kDn9kg/LR4m0thqRNmPAfg==
X-IronPort-AV: E=Sophos;i="6.16,350,1744092000"; 
   d="scan'208";a="377604722"
Received: from mail-svr1.cs.utah.edu ([155.98.64.241])
  by ipo3smtp.cc.utah.edu with ESMTP; 30 Jul 2025 12:52:36 -0600
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 65BB7302143;
	Wed, 30 Jul 2025 12:50:23 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at cs.utah.edu
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
	by localhost (rio.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y0u2oJ0KryyS; Wed, 30 Jul 2025 12:50:23 -0600 (MDT)
Received: from thebes.cs.utah.edu (thebes.cs.utah.edu [155.98.65.57])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 1D165301D50;
	Wed, 30 Jul 2025 12:50:23 -0600 (MDT)
Received: by thebes.cs.utah.edu (Postfix, from userid 1628)
	id F301315C2742; Wed, 30 Jul 2025 12:52:35 -0600 (MDT)
From: Soham Bagchi <soham.bagchi@utah.edu>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sohambagchi@outlook.com
Cc: Soham Bagchi <soham.bagchi@utah.edu>
Subject: [PATCH] bpf: relax acquire for consumer_pos in ringbuf_process_ring()
Date: Wed, 30 Jul 2025 12:52:18 -0600
Message-Id: <20250730185218.2343700-1-soham.bagchi@utah.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since r->consumer_pos is modified only by the user thread
in the given ringbuf context (and as such, it is thread-local)
it does not require a load-acquire.

Signed-off-by: Soham Bagchi <soham.bagchi@utah.edu>
---
 tools/lib/bpf/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 9702b70da44..7753a6570cf 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -241,7 +241,7 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	bool got_new_data;
 	void *sample;
 
-	cons_pos = smp_load_acquire(r->consumer_pos);
+	cons_pos = *r->consumer_pos;
 	do {
 		got_new_data = false;
 		prod_pos = smp_load_acquire(r->producer_pos);
-- 
2.34.1


