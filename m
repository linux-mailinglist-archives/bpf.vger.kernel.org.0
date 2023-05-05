Return-Path: <bpf+bounces-159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8FF6F8BBF
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 23:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136C428100F
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD7101DB;
	Fri,  5 May 2023 21:59:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF31C8C5
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 21:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F07C4339B;
	Fri,  5 May 2023 21:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683323944;
	bh=RnDpyWnzu2Qe/orQKPwB4Q9+4eJHSq05U5W4yn9e1I0=;
	h=From:To:Cc:Subject:Date:From;
	b=FgZc1KiwM8D0zsLLQYgzBwYRXkjsDMdStY25TRtU9Zb54E/uAD/bgi2XLkuOSS5Ym
	 2uWJqNl7XQLYCcnPoTl+jbKB5xGhpFPq7c+iHeO7QRk4aPUkZe/lkHgLxdg80QEr8w
	 fhtDWqOoi6viIBEOf2sZ25yDNpAUY3jyZiTtxC270ItjRBFdSwlhve4BEabFutCI/w
	 HP8ojsRywAw2jyHpL5eMAsoJIUmyJdBToZDj+z9y0Cbj4ytVHnEbiD1wcbjDSO1hWX
	 ZlDJG0Ka5cZKkTYaKAaKv/7+xRGnABF0ZDFS8UNC+WkWIG5li3GzKHO7JlF/NcUeuJ
	 xPeIioNaQAiwA==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@iogearbox.net
Cc: Jakub Kicinski <kuba@kernel.org>,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf] bpf: netdev: init the offload table earlier
Date: Fri,  5 May 2023 14:58:36 -0700
Message-Id: <20230505215836.491485-1-kuba@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some netdevices may get unregistered before late_initcall(),
we have to move the hashtable init earlier.

Fixes: f1fc43d03946 ("bpf: Move offload initialization into late_initcall")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217399
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: song@kernel.org
CC: yhs@fb.com
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@google.com
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: bpf@vger.kernel.org
---
 kernel/bpf/offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index d9c9f45e3529..8a26cd8814c1 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -859,4 +859,4 @@ static int __init bpf_offload_init(void)
 	return rhashtable_init(&offdevs, &offdevs_params);
 }
 
-late_initcall(bpf_offload_init);
+core_initcall(bpf_offload_init);
-- 
2.40.1


