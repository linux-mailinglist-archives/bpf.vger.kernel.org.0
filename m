Return-Path: <bpf+bounces-52215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3939DA401AF
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 22:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08963BAAB3
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 21:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EF9254B10;
	Fri, 21 Feb 2025 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="A2GM2zy/"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5C21E091
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171805; cv=none; b=jfa11j25VC8vO9AtbrLOl1P4p9DyPg76b9jI7WYxFQ4BWqhzbeeqVfBkYRRmAxJeajXOTv4jNOuScaq+Y7iMMTjIKHOf0/73VOOdUU4IMAKmyMt6GHoSMbHLDWEIV2eldwZQp0Sjce0WXdlfwSIyCvP/pzLPlIJilwg+rscM6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171805; c=relaxed/simple;
	bh=A4Ar4NX19mloO9Z+cA1JFUiskoNE6AXuSWAKOlHb4IM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0x4XJpjzIWCmQislxh4SDmxa/z9SMj0Rf9DGIBtSi+9a59lknst+9TARmBsfhH1DIZvoPUU2F0Aa8VK36ktLqxxSL/D1pfrafFrJwdr+1nJzSG7qhCuBBWhIIDcNGFteOtyGiglbQ5M4+sNEGLco+JAnA296GAncBkzbGOclkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=A2GM2zy/; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from localhost.localdomain (unknown [49.47.194.30])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 018A843581;
	Fri, 21 Feb 2025 21:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1740171798;
	bh=A4Ar4NX19mloO9Z+cA1JFUiskoNE6AXuSWAKOlHb4IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2GM2zy/M2x8YpeLmMdqmyCPQXPaMA7LmttV4TajoR5bTjehUx/uXVaIrvlOtdwR0
	 fNbMulDBZEtnbRxSduvvQkGtk9XrvDFo0kPHSztAIsQwDmKg9b0rC9KW2qIVsJHj8A
	 vFqd5++M2oLQyp8VfiUJGXtn/gIzwZ1hzoFAeyIUAR98JK/Qz1mkhsmp1tFJjyPOZe
	 H6nSq1Kv7rhsWi694jiCkJF2aTpciViI8yYFqYlKeu5ZZNwiqi6tbC0isC4SKfqu1x
	 UJWIrdWsbQSA03lN8n7Jpfh2RcocPPpY6zn/Z1PyO9elQPQswEBfmC6pbSe2FKAr1C
	 yOy5Nb5kaoZdQ==
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>
Subject: [PATCH bpf-next] libbpf: Fix out-of-bound read
Date: Sat, 22 Feb 2025 02:31:11 +0530
Message-Id: <20250221210110.3182084-1-nandakumar@nandakumar.co.in>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAEf4BzYQ0m0cxFJnJp4MWbv2CjDZvEr8zMvEQN304-68+msA5w@mail.gmail.com>
References: <CAEf4BzYQ0m0cxFJnJp4MWbv2CjDZvEr8zMvEQN304-68+msA5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

In `set_kcfg_value_str`, an untrusted string is accessed with the assumption
that it will be at least two characters long due to the presence of checks for
opening and closing quotes. But the check for the closing quote
(value[len - 1] != '"') misses the fact that it could be checking the opening
quote itself in case of an invalid input that consists of just the opening
quote.

This commit adds an explicit check to make sure the string is at least two
characters long.

Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..1cc87dbd015d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2106,7 +2106,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
-- 
2.30.2


