Return-Path: <bpf+bounces-77325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D94CACD7455
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 23:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26567308592A
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 22:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57BD32E124;
	Mon, 22 Dec 2025 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VakcHsBK"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477332D0D0
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441905; cv=none; b=tFU0fmRpbFQte4c/t0mcpvWtgCxDScAXHIvXhiz5tzJ+KSGhCX9GRwsnVCF0TF+/vWRtaUeVdGeK6XcDpAMfm8LRYyIIW6SVbfxjNVsFQKLmaEUglt/yTxOFqVRSULatpRfzWDypngq36qYafEj/V+gwHVBtcwcv6TjNHcVkDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441905; c=relaxed/simple;
	bh=6/GoK0N3AZjSbAIi6svNG7gSA7BMHYFQu4YWO8oCEiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLLKzUyc75yW1AxzOcR7zDEWBHO3aVhWBNyWKUMIZVR42GMWYWa7pLQSKVmHK2ZYpK3daP8h2awjIBYfDK8AlF1vIUgTDawJwmdWneW6x3yoBRYdzKy5TH6uSWigYNb0rS2oJG42X0zBJ+daRHlIX3fSEYwfLauj/GgfeK3mZ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VakcHsBK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766441902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdqb/JrWPy4gNeCuNrTpT2xWXxvnkmMMxVP8Vk0ZQYs=;
	b=VakcHsBKcYRmNqnVH3KJ1pOq7DuE9CHVpf4ylwyvS0U+2MwCFrJqNoSEYASXIbu/6aZmwu
	2fm80umV+WHHyj2J1NBAw3E6586sEVv9T1ANQfodPg3/6UPY0R8ne8gxwTsJPhdDNwJ3HB
	yV5rmEV7WfIrt2IMbnKyPuAHvoIA7FE=
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
Subject: [PATCH bpf-next v3 6/6] MAINTAINERS: add an entry for MM BPF extensions
Date: Mon, 22 Dec 2025 14:17:54 -0800
Message-ID: <20251222221754.186191-7-roman.gushchin@linux.dev>
In-Reply-To: <20251222221754.186191-1-roman.gushchin@linux.dev>
References: <20251222221754.186191-1-roman.gushchin@linux.dev>
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


