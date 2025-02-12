Return-Path: <bpf+bounces-51307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FB9A33098
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 21:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4823A67CC
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 20:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57BE20103D;
	Wed, 12 Feb 2025 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZnABwTop"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9887E200B99
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391372; cv=none; b=piAo0+sCOIu3fmzBjyFS50UR8bWemELFSe1TdUaOaOFhYrMcFDmfXH3Tw3PS2ha0YECE+uzhg9CSw2u0DY1D+C5+ZemaEkUilIhcOdyTa/b4g2QI+MmIlZYGuQslaCU2xBqaME+CBaMVPxWRna2vysjjclXrJ+AIv+qCbk1t4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391372; c=relaxed/simple;
	bh=GFyble7KuoWR/jBfqDDUBdFOzcNGu3Z0y3DubKzEwnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh0HTREfR5jrUiLMgtmrzMcpIP+VQS48dTPV1hfieczGlW/l3fAiroJGywr/r1IuYcApuBuLpaBVq9yzF2RNfmwy0GuKb+Wl/AtzwgpbRf4/G3CyBnMK6d5UP8QC1DwxXU4BS+nsRvc2IaPp9diic1vUxNhsHiUnPQdXvtjlIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZnABwTop; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739391366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwQAEFegtRF3r37vnzwyzjrcZBx48QWnNDQGd6H58hc=;
	b=ZnABwTopJ7G2oAuQaic4rTlahMf3meU+08I6qGVFozFoCdUxD/4osfYVKxo0PFbp2tzX0l
	1zkW0hLHKbzh5xDITtBRv7uclhTkn91ccfJCrpskt8JRU2SUSQP8M7DQ38iGJiFA7W4M8x
	DC3oGmuTVIhGZ78Ne7BENXWNbpnxO7U=
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
Subject: [PATCH v2 dwarves 4/4] man-pages: describe attributes and remove reproducible_build
Date: Wed, 12 Feb 2025 12:15:52 -0800
Message-ID: <20250212201552.1431219-5-ihor.solodrai@linux.dev>
In-Reply-To: <20250212201552.1431219-1-ihor.solodrai@linux.dev>
References: <20250212201552.1431219-1-ihor.solodrai@linux.dev>
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


