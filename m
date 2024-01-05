Return-Path: <bpf+bounces-19084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6C5824C09
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05BB1F22EBA
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64EA39D;
	Fri,  5 Jan 2024 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLzXObnQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C150A32
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D97C433C7;
	Fri,  5 Jan 2024 00:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704413354;
	bh=EwK2vJ3wAp0JeuOgxyGrvsr3ghYJKONQ2n7ZoHaBND8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLzXObnQg7r+Ix2FGiNCCEjt98E2IAcGwIecXuELNWM2af3+/20pM5N6BsGGMZvXW
	 8dpZ59DmeUPAqLST+6Rec0lnarJoDE1GYwR2hCyV9D4UDDX9KQtRDE4QTVihes33lL
	 zLj8g/7A2KlquD3dwECE/dSj7vfHlJgE1LemJWCLuDVVOKWgoEXF3ByTdAPOdytnzw
	 Ykrhj6nQgxnBs5vyqm1IpH4nI2W9qFdrT3hLuM5rRrVhpt0ToO022VrVRYuWdDEUQc
	 IlF4YDs7WYM0kbULM1RuJQQrLYBPaON3npviNSW+ZTwI+buiiIgyKZtCjlXuzhdkPI
	 ZHcAqyFrrT61Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next 1/8] selftests/bpf: fix test_loader check message
Date: Thu,  4 Jan 2024 16:09:02 -0800
Message-Id: <20240105000909.2818934-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105000909.2818934-1-andrii@kernel.org>
References: <20240105000909.2818934-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seeing:

  process_subtest:PASS:Can't alloc specs array 0 nsec

... in verbose successful test log is very confusing. Use smaller
identifier-like test tag to denote that we are asserting specs array
allocation success.

Now it's much less distracting:

  process_subtest:PASS:specs_alloc 0 nsec

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/test_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index f01391021218..72906d27babf 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -688,7 +688,7 @@ static void process_subtest(struct test_loader *tester,
 		++nr_progs;
 
 	specs = calloc(nr_progs, sizeof(struct test_spec));
-	if (!ASSERT_OK_PTR(specs, "Can't alloc specs array"))
+	if (!ASSERT_OK_PTR(specs, "specs_alloc"))
 		return;
 
 	i = 0;
-- 
2.34.1


