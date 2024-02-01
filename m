Return-Path: <bpf+bounces-20973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE24845E64
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EBA2843D5
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702945B052;
	Thu,  1 Feb 2024 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2qzAs0F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA525B046
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808079; cv=none; b=nVm1/59YDmY/r9ibgPQThYyLqu1cLqzxHHl38JPVyBs2ZH764e9YAtClziNk6S87bqMCMh0RsDNDsYrRawcQHFuomt0PF1F1q6M5H+sdCZs8Wfo7NROdcDywdUsGLfPt6lRvskx8VOXoPdBmI15eDL26d+KYIz93LYpq1LSPdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808079; c=relaxed/simple;
	bh=rftYcHmlmMv34x7ss8O92q4W1IC5dTwHXDosWC6JSvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcAd3yezljEaUxIHEN5IP0yCmpl4SatwazDCeX8ClKzKRSYDfvz3b+Mp7ZtqGJntJFvBv20eSxgl2Qy8jvs/0ATsDlcJbeGBMmPax358u6dkf2LVyZ6/dWVNtYLjeVgASZYT4Sxa789vNWb79zC3je8Iui4uTGNwkbZTD5+jbz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2qzAs0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94A0C433C7;
	Thu,  1 Feb 2024 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808078;
	bh=rftYcHmlmMv34x7ss8O92q4W1IC5dTwHXDosWC6JSvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2qzAs0FNNY5Us1BHvBh4AXl/EZXVuVGtwKGy5Q77dMWWu0JcK8sA1DNJ+OFD+f/E
	 yplcnUtl7X04Ju1dg0a0A4lyVoqLoNZtbTsgEC5OLcfDGdo8A2dHoEx9n7LR7QAvAj
	 v+oSUz6gDQg2qHzvAvPg+cSYVjQCmWZP+8JxPjmfd2T4kH4Du6i8kj0hcGfjFSiOZ/
	 /PI5QogGlJG9Dp4Jk01SdukgxxLhWjuzCNGpymlveijYAug1cOxiaUymUy8XEzMfq0
	 9ePJ7h9n+r3q6/wYlmaVlisZ5ldHjhSJN/kgIaOE85qqJSruNjhbawv3xdehUCFob0
	 8XPWrAYnLuk/g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 3/5] libbpf: add btf__new_split() API that was declared but not implemented
Date: Thu,  1 Feb 2024 09:20:25 -0800
Message-Id: <20240201172027.604869-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201172027.604869-1-andrii@kernel.org>
References: <20240201172027.604869-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seems like original commit adding split BTF support intended to add
btf__new_split() API, and even declared it in libbpf.map, but never
added (trivial) implementation. Fix this.

Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c      | 5 +++++
 tools/lib/bpf/libbpf.map | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 95db88b36cf3..845034d15420 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1079,6 +1079,11 @@ struct btf *btf__new(const void *data, __u32 size)
 	return libbpf_ptr(btf_new(data, size, NULL));
 }
 
+struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
+{
+	return libbpf_ptr(btf_new(data, size, base_btf));
+}
+
 static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 				 struct btf_ext **btf_ext)
 {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d9e1f57534fa..386964f572a8 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -245,7 +245,6 @@ LIBBPF_0.3.0 {
 		btf__parse_raw_split;
 		btf__parse_split;
 		btf__new_empty_split;
-		btf__new_split;
 		ring_buffer__epoll_fd;
 } LIBBPF_0.2.0;
 
@@ -411,5 +410,7 @@ LIBBPF_1.3.0 {
 } LIBBPF_1.2.0;
 
 LIBBPF_1.4.0 {
+	global:
 		bpf_token_create;
+		btf__new_split;
 } LIBBPF_1.3.0;
-- 
2.34.1


