Return-Path: <bpf+bounces-77226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC9CD26BC
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A66DE30019F2
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD58276050;
	Sat, 20 Dec 2025 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P6tiDflu"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043782E0926
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 04:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766204032; cv=none; b=ko7tT2o8F/Mk+W2DKo0cuJ3waYmdy7gjTC8SYEH8K1Mj1ss0+y1UolVR+8bvsWLe5IuMiDpndF6jLuZKyPZPn10ks9rc8Ns5r3nFyQ/iakDVRHIRUi//lWU1/8u+sw1A3smMmoTgK/SPmZjos2iwh4Y5mLdmIdcMPhcCjiigws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766204032; c=relaxed/simple;
	bh=LN+F4ksa7xPqEsyIJXw8bbZekjc5XgKxSqItE+sQ0aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B93vn4aUbiiT8KT7xvobny19jzyuQ1vN9J76QHySn5Td/s1XZHSJPfbFu/TxUMlUkR06FB0DjBWJ2RDimUs1uRRcEWkGiCONj4/VNMXf2lmHg08f15av3U5GNZ/IUwKEva+82tZGrXT1E9wia0yrlldV6XyjdH50Xhi/vBXlSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P6tiDflu; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766204024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J25dvtxGtZzzFvAfUXeEFYiBBGrfnhtqGw9nh11r9u0=;
	b=P6tiDfluQlmW/6/a6KD97hG0+XGOO2Mie8XtSgTQqFKw1271aIHMxpDKUAKKK3oCV+rzty
	ZNYSMOR3QGB4nmGgzdJGuOg/aADPC1xEq2pJeu1fL/rp+/iv4zzdTEZ6wDDO8gaoTFDWWF
	+BYUvv+r5Lya74vxd9zrfhEHDBytNwI=
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
Subject: [PATCH bpf-next v2 7/7] MAINTAINERS: add an entry for MM BPF extensions
Date: Fri, 19 Dec 2025 20:12:50 -0800
Message-ID: <20251220041250.372179-8-roman.gushchin@linux.dev>
In-Reply-To: <20251220041250.372179-1-roman.gushchin@linux.dev>
References: <20251220041250.372179-1-roman.gushchin@linux.dev>
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
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0030e126fc8..59e3053e1122 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4798,6 +4798,13 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	tools/lib/bpf/
 
+BPF [MEMORY MANAGEMENT EXTENSIONS]
+M:	Roman Gushchin <roman.gushchin@linux.dev>
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


