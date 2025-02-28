Return-Path: <bpf+bounces-52902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF07A4A2EE
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BDA7A1D04
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9FD1C54BF;
	Fri, 28 Feb 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cKaPWpxT"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D271C5D6F
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772033; cv=none; b=q+gWFd054M7LSZcgQj2z5r2Mx8155Ybh9rui5epR/w3yIi4Zdtovo0BBpAlg7TwpA8bptngKBiheQATzc/lXXPzsYObY8C3w1JSgPQG8JkEkv30cZ/TuOu5o54zEAEmqSO5Yh2wds6yuv+DdzPfdzo8iy3J6PejlR8jSC067KeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772033; c=relaxed/simple;
	bh=Guo10HdlaAGZHMFUVxR5YuXor45bibwU7M52IKr49FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCJvGCY4aqStCnWHvb77W7h+B14gUaOS2f7RR0Qapows3tLeNtBQH3Ta6Pdl2Un4XFXUmFOOJseVAUs/8A+95Rg1tjfOkfU0TBEIvO4lcs2q36aBbrlDrGh9b7mLY4ixTVSoUvU5yK8tlqERJy0/2YKJ3Wtk+2VbNUp/A9n0EwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cKaPWpxT; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740772028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxSX4iYXoDwa3gjEWnNt/KC9Rahol/AIrnhMlp5C9yU=;
	b=cKaPWpxT6CMyjFH1vEQyzVA+n9iuVAWqRxfgp7KZKKF02QR2nUbGuh3gJjDOr0goUkQtoM
	l4B9tNItScXiRbbfsQbg3J79zMFj2UDsWNVKMMqlBILlEhrDNatQ3iyd5BVpEQBnK30/Tp
	dLYkTwDIvUFGIAFfuvh6DoOcLmZLtTY=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: acme@kernel.org,
	alan.maguire@oracle.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH dwarves v4 3/6] pahole: sync with libbpf mainline
Date: Fri, 28 Feb 2025 11:46:51 -0800
Message-ID: <20250228194654.1022535-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Pull recently added libbpf API functions:
  * btf__add_decl_attr()
  * btf__add_type_attr()

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 09b9e83..42a6ef6 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 09b9e83102eb8ab9e540d36b4559c55f3bcdb95d
+Subproject commit 42a6ef63161a8dc4288172b27f3870e50b3606f7
-- 
2.48.1


