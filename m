Return-Path: <bpf+bounces-32104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC024907820
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5241F22900
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA51482F0;
	Thu, 13 Jun 2024 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="DIIV2bJi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPzk3gg7"
X-Original-To: bpf@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C281448E6;
	Thu, 13 Jun 2024 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295593; cv=none; b=cFq3QRyjL9aaW9ftLW8qmgg0+VeyJuJSAPPCPMHzEkNwhojCX7Uhj6USDW5NS7qqEk7JotOJC+xP/6RncPc+JpqXDQ/qxfD7Gy4sPpJEFHrwu6lAGWrfV6gI+wtCxyK9VGnRpaDXrGeEds6LVT0x9JmL4qk+Kst3uSmWu8e/PO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295593; c=relaxed/simple;
	bh=upXHV4oSRlEoQNOh73uNw2LAWv/ZoKJCVki8oZkxnq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZXxnsWs3XaPPE3XkZHCFgIP1YlnFzMuWR46HwcXmHltCcll/PJDXJJjDIDYGG/Qdqm0+Eq8gAeV4eU2lnVr/UK7sNin1Prb16zdEb/7TPtYCoIv2J0HboT3J0ZcqCPoSG/jETAi5kCFTsH7+MjPVL/DnrrCZXL/9eZPyh+Iya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=DIIV2bJi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPzk3gg7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6E47113800D9;
	Thu, 13 Jun 2024 12:19:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Jun 2024 12:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718295590; x=
	1718381990; bh=dev3LyBB1QLwwxaaVCINRbSVtifMTpHyZ9F3Ei0utb0=; b=D
	IIV2bJitxaqPwH6xuUz4N5LcPUvuj8NqCKNs4ADz78kGkdeNEAYy2Nq3AsP3yGI0
	LaVjPT1ayctsWf+Vmpo9tb3ysG8TrcXIcl4GfJC2vJ0BCAdgqDC1jnpjkmZ6x+cv
	mHTWEqczgoQ9gldT6z+HUkYbsnqEpNXk8DG1RHs5AHOQywxIuYHcwb6qw3Zp00FJ
	9jdZR7vy4e0OVPsibY8upUcmB8TKYyHZCBUlxgmkvcmnwhJgFlX+CSglTmhlm/LK
	vfRY74q05/+hqYZg4FIpu1uf43NYFZMO7UdhDTXlY5PQKBYRROkG9ytUBa/0Z4Vr
	fKAUD1zUeqjeA7GsBMBIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718295590; x=
	1718381990; bh=dev3LyBB1QLwwxaaVCINRbSVtifMTpHyZ9F3Ei0utb0=; b=g
	Pzk3gg7SHlNUkiookjqzQ/FhT3wETd5+tBjhnITvSWJOTRg7slZQ/0vXYQpd9jry
	Ut2+l3amJruEGC96GeJXRIwzt8owdUwkOMWtMIznxtmKOQQvl0HncnYu9eTsy2e0
	pJkXFjt10POk4hrb+7DYJIHnFM19BbSxUPLi/w5phQhaI6drNa0YE6DITPLaWd1C
	3Ig00yPPaaRHiSUUBqxCOyeyqF/jFYA0Jgk9xgn9Z34tDGNHOY8iz6Hz5NRryZu1
	gAnWV/rXqrrmPEybTlTQLCisPdsWhbJ0T/dXE+iXcLQBkhorSLSMp6ykmZrWbRVs
	gIAGRzT2Sd00wxVOqqdxw==
X-ME-Sender: <xms:JhxrZrUM62_QJn68t9jRFPQwch8LQ5FeR1fAm1Tl_WS6Z2bgIJ-P6g>
    <xme:JhxrZjkjUcnziHkAy1Dj42da9W-PUVBsrVbiFsXPpJNdxjNvjPuZDnx0tiBCvaw9R
    Lrz2YaKlBnVolAcNw>
X-ME-Received: <xmr:JhxrZnaNHXspDBTiTXS6YtY6ZWw7hEyqIGNSs0u7a5-xmyDcSA-8-71VzJabeUIwQrwIh6BYhhmdBXsZnn2qJW8iT1jazA2nCjzFEZfx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:JhxrZmWrWPrxbIXkP2Kl-g_kVOvSXfqcHIy8GGtDlp8fqUuwYTVfcQ>
    <xmx:JhxrZll8HRURNYRM9Aiu2If8VfMBFpoHHi97g72uN440sLpI4QtXaw>
    <xmx:JhxrZjeEOMyUaoBR49n9OWbDqR_63nv2kagAGXw3dHGppV4U6zp5vA>
    <xmx:JhxrZvFGK8IIm-WMsZhFrL4r3hWNQoRFVtQcvKnapAIiv2X_PDWudw>
    <xmx:JhxrZn1b5iyitpWCRKfjXkOeY9IS02WmTDbiaFUZrlCO2Dsib9GjZPkR>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 12:19:49 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	dxu@dxuuu.xyz,
	ast@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	"sfr@canb.auug.org.aukernel-team"@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Fix bpf_dynptr documentation comments
Date: Thu, 13 Jun 2024 10:19:25 -0600
Message-ID: <d0b0eb05f91e12e5795966153b11998d3fc1d433.1718295425.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718295425.git.dxu@dxuuu.xyz>
References: <cover.1718295425.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function argument names were changed but the doc comment was not.
Fix htmldocs build warning by updating doc comments.

Fixes: cce4c40b9606 ("bpf: treewide: Align kfunc signatures to prog point-of-view")
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3ac521c48bba..229396172026 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2433,7 +2433,7 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
 
 /**
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
- * @ptr: The dynptr whose data slice to retrieve
+ * @p: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
  * @buffer__opt: User-provided buffer to copy contents into.  May be NULL
  * @buffer__szk: Size (in bytes) of the buffer if present. This is the
@@ -2504,7 +2504,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 
 /**
  * bpf_dynptr_slice_rdwr() - Obtain a writable pointer to the dynptr data.
- * @ptr: The dynptr whose data slice to retrieve
+ * @p: The dynptr whose data slice to retrieve
  * @offset: Offset into the dynptr
  * @buffer__opt: User-provided buffer to copy contents into. May be NULL
  * @buffer__szk: Size (in bytes) of the buffer if present. This is the
-- 
2.44.0


