Return-Path: <bpf+bounces-77343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 693EFCD811A
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 05:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62911309050A
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 04:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C320C2E6CA8;
	Tue, 23 Dec 2025 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AGeI+Jsg"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BFD2E54BB
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766464945; cv=none; b=NyQ4QDDavrvBnGIs4kHoUUXIBDe78TgBM+hxzHwc5IpROTGdKneEBAPJBYcwz0tfvycQxJdz/uBkU0Lp3TFNaxt5KEBR3i0X65mJM2WD5TErXv3lk7YEUN/U4eYLsC2l3I+SfHP/0EZgwj3tGnev5hKD51z4XuxY+Ej0kQOUy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766464945; c=relaxed/simple;
	bh=6/GoK0N3AZjSbAIi6svNG7gSA7BMHYFQu4YWO8oCEiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAMQgl41kXTeO/2YPP9k8PsGZ4yjfBHWIO+++RYdXwowa5XxU+vEEQPn+TyqwccgGG5Yjhv+L2H2gfx+gEfutroanWdhAbJrvhU6XRo50MZuuWpRotuoWQwecr63QRFuS3UtVah/UkbQDPzNFlrfCp4hoyfX+M48pueWg32fH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AGeI+Jsg; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766464941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdqb/JrWPy4gNeCuNrTpT2xWXxvnkmMMxVP8Vk0ZQYs=;
	b=AGeI+JsgNMI5ozsGPbHsoSoJHX2jIdnieBl0qxej2677xZBJX/skO2HnWMpbECOefcgf26
	L9PgVQYaPSt9MWdzb7T2a2q4eoYezn6jRU7PxO65zSmNNEizYQj8+N4PdHMn3DvjNu50KA
	Tnyw0NH4hZrfpIQejw5A+VNEk8vH/rE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: JP Kobryn <inwardvessel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v4 6/6] MAINTAINERS: add an entry for MM BPF extensions
Date: Mon, 22 Dec 2025 20:41:56 -0800
Message-ID: <20251223044156.208250-7-roman.gushchin@linux.dev>
In-Reply-To: <20251223044156.208250-1-roman.gushchin@linux.dev>
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Let's create a separate entry for MM BPF extensions: these patches
often require an attention from both bpf and mm communities.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7027fba97db..70c2b73b3941 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4799,6 +4799,15 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	tools/lib/bpf/
 
+BPF [MEMORY MANAGEMENT EXTENSIONS]
+M:	Roman Gushchin <roman.gushchin@linux.dev>
+M:	JP Kobryn <inwardvessel@gmail.com>
+M:	Shakeel Butt <shakeel.butt@linux.dev>
+L:	bpf@vger.kernel.org
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	mm/bpf_memcontrol.c
+
 BPF [MISC]
 L:	bpf@vger.kernel.org
 S:	Odd Fixes
-- 
2.52.0


