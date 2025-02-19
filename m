Return-Path: <bpf+bounces-51987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77832A3CB06
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734D91894D44
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3462566C0;
	Wed, 19 Feb 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CTk6HhQ6"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F2255E46
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999139; cv=none; b=G2j7bx8nzl1BWFlPvmfABph2fTtueEemfM3QSa6wcXs7PmZyguHav7NyTCqBAQDHQFhK8Z5CjNJbkfOKV6K8HntS2bllHd2II8Ofolo2bKcNc2ftFRUPzyTkx8xUZkSlEBItHQJc69KhCSclxkrPyHu2bsMaDrW4VuvpdIHJlEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999139; c=relaxed/simple;
	bh=vg72N/6DHfjyoSjIakVAL/xbwxGciAKI+kj6lrkH/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIsZKMMuozV7IgqjzBAdnpdtSPrk+IYmtxVkVkK6zxENmsmWZLtkv9LKmWANQ40ZWn6laj50ZBoDj+jLNmLUxgghKTHskbnaaMy8LgYTgT/L3dhSCFsfxki2bHB22ETK54mvad8LmvsbugBqCUL16GZTlat9AHDALPmoRB1JsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CTk6HhQ6; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739999136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuvyfCtG+VEG28gEE9qzAwxBAEPojdpIbDgPKLNVZaI=;
	b=CTk6HhQ6/UVPDSxCLFsFjHNkxqG9D7KVOi3yoHpFxW0Xghy4c9uZSTmu/E5YhcqVLcl8Lp
	SnJRVWzJAwB7MiasSjN6YoJr7vp27q3GD26VpteW02FQfzOqTx263je1ommfYWjAD4q+VA
	7to35ehPdmH6Mc0nwZuS67UcRIk0W2A=
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
Subject: [PATCH bpf-next v3 4/4] man-pages: describe attributes and remove reproducible_build
Date: Wed, 19 Feb 2025 13:05:20 -0800
Message-ID: <20250219210520.2245369-5-ihor.solodrai@linux.dev>
In-Reply-To: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
References: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a description of the new --btf_feature=attributes.

Also remove reproducible_build description, as it is now a moot
feature flag.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 man-pages/pahole.1 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 39e7b46..3125de3 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -327,9 +327,10 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
 Supported non-standard features (not enabled for 'default')
 
 .nf
-	reproducible_build Ensure generated BTF is consistent every time;
-	                   without this parallel BTF encoding can result in
-	                   inconsistent BTF ids.
+	attributes         Allow generation of decl_tags and type_tags with
+	                   kind_flag = 1. These tags can be used to encode
+	                   arbitrary compiler attributes in BTF, but are
+	                   backward incompatible.
 	decl_tag_kfuncs    Inject a BTF_KIND_DECL_TAG for each discovered kfunc.
 	distilled_base     For split BTF, generate a distilled version of
 	                   the associated base BTF to support later relocation
-- 
2.48.1


