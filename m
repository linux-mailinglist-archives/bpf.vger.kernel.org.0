Return-Path: <bpf+bounces-47392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB779F8AE1
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 05:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F09188D8FB
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 04:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BFF15ADA6;
	Fri, 20 Dec 2024 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="NjWWMGF2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r4mPumX3"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3549813C8E8;
	Fri, 20 Dec 2024 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667807; cv=none; b=NzqP8rxvCwBqF69WIqTcZLUAbiZT60C8FNJhC7zJzF3lv0jOIZy+Xcj/SYmvy5kQO2HSDrBm3VRJ0/tJhScgIHKP9qKSFX4jBFS5DUdeMMc2YRd2uShkK/h42mLcRBXHE93ykL3kvX9Qyxskq2APdBwfbjwweKqbNSLbswxNtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667807; c=relaxed/simple;
	bh=i/WFYcyw8bKaFwYR289SWLCraGpkA721LEQkMAEXxcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHrv/bwjpQCc/f67SyuxxopKZuIqprDYREu7d58aepCF/3i9onk4t12lcFZeT9XGjRc56yIDloV05dX+eYvQR87I6hJvMkC+ycwWnzPdk3VH5YjlAhiem59kDU0Uq8BEXpufhuLv9vsgqOmvC3JQJJQ56cl5pfFMUvnh9275Zmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=NjWWMGF2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r4mPumX3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECFC1254015D;
	Thu, 19 Dec 2024 23:10:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Dec 2024 23:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734667803; x=
	1734754203; bh=dX2LDURcWUjkbE3j8vdY2N7db67PorPWhmDWzCc1jcs=; b=N
	jWWMGF2QzfuR/QhixL4RnxlYUXobdXhbEw0jvDiNbA9i92y5UefHrEEs/ugGKGKs
	NPPaIM295XkKpc2w85DmmCoVtzk2cma1ODtjGcMHn7xH+ZeEshuNbsubG+4Sc6tr
	IQ9bdZIkB7RGRwSPdHwdlyyyOW2OqDXFcj4KF7qrKXMsrgYNDsPXKHBgmjd8NRXr
	ArUE8yQ1abr0ovVGB7jbMc6Tb7k9tl0U8aB0Ti3URXckURmxrJY1GmxeF0VqTBE0
	p2chmxQrICn8EZjZOxlb28Pod2dYeq+rClbzA1AtDhJe0Ej/YDy/cHjNGcG3/EHV
	KBYgH9mclqF3kS3EonRXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734667803; x=1734754203; bh=d
	X2LDURcWUjkbE3j8vdY2N7db67PorPWhmDWzCc1jcs=; b=r4mPumX3UkTYpxI27
	Gke7pPCTYrMJ8xxLUgLGrzNitDm8c+gvVPsOpxBbPOXthGyd46SdUASpCUrCR7lo
	LSXcDK0nfrV3DrXx7HO0cViGD4Mnm3BSd836nxDiEblWbuospFSLNREw1gJkE1ri
	L2DqAnxgADE5ZcFOmmdZO3gGVq7uc1PLGOVt+rmmW0aT8Cy8oXyd1VY/K4/ASWor
	0VGxIrPZXnR1mAdGsjRkao1YkwHTAPCT3aeiO3og3Xxpqd+z2nMkFnDe5ByM862K
	WxMUzse5mDvYa7E7za3moIBywbsR/llcJo3BRglbZ0UgbDE00xWtsvDjzQhipV2N
	B5qdw==
X-ME-Sender: <xms:G-5kZ-RV8m9lh8vtkybw1i6cARASPiD63cGcPkaMfC3YyhxltBsIIg>
    <xme:G-5kZzyGf5GdJd0Yn7Rp7ZA3M0UGphrzltM8jxi9GNXYd7_Lf5M46PZw16LyZI376
    Qkh1XyzbuEW1Q5n3g>
X-ME-Received: <xmr:G-5kZ71nlkQL6gq5-_M-eT4psLUBWnrPoZebFcEed8UbrDf9DSwDnhoKioErYVbsHUT0uJovY1zlI8J1Vv8W_RjTx-xP7p0tqchXMkZtllA8Hr9PDErA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprghstheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtth
    hopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehm
    rghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidr
    uggvvhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G-5kZ6BlXSJGZFzQi8yI_qYdyEB5xZw0YXknDNsbKdxNlB9QqUVFOg>
    <xmx:G-5kZ3jJ1TbXc6tz9R0dAoPmGdJ1f0dDMlF3otJaulfQoFkRuaS6-Q>
    <xmx:G-5kZ2o0j7f4Fs5dr7Cy205zz3cXJ6ItCRW9xuDSAQ-gqgKBKM8OEQ>
    <xmx:G-5kZ6geZoEa_eDzuwG91gpTzI4FPgzDOlW45oLNullTUxkfXs6LCQ>
    <xmx:G-5kZ35j96w1HgHGKVCElYgE8pY6KITI8VcFPG4J3s_c9DTnLFUuDJy2>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 23:10:01 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	eddyz87@gmail.com
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6 1/5] bpf: verifier: Add missing newline on verbose() call
Date: Thu, 19 Dec 2024 21:09:43 -0700
Message-ID: <17ecda4dcfc07c14bad0b2ed867ef8efbee8e1fb.1734667691.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734667691.git.dxu@dxuuu.xyz>
References: <cover.1734667691.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The print was missing a newline.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f27274e933e5..4383653764e8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7739,7 +7739,7 @@ static int check_stack_range_initialized(
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
 		if (state->allocated_stack <= slot) {
-			verbose(env, "verifier bug: allocated_stack too small");
+			verbose(env, "verifier bug: allocated_stack too small\n");
 			return -EFAULT;
 		}
 
-- 
2.47.1


