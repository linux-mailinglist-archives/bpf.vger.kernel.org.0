Return-Path: <bpf+bounces-48845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ECDA111F2
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 21:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522B21888E6A
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 20:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95320CCC9;
	Tue, 14 Jan 2025 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Vo06L22A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="poNTgoDX"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8E20B813;
	Tue, 14 Jan 2025 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886549; cv=none; b=BjLF8M5Xw4nlVlTN3tK9hIqCPIAGonH2QoaqfQjdb14C/tw7k946dQHbWJ+k9jlM/FUovgJd/BFe5oscVFMH0GbOkmK8tVE4QuYgHlUTSWYwwxibvHS8Da5NipZdiTg8iZPMVv4/pyLcOLZfZN2joCX2IjndfOxjZJjRkaSqnm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886549; c=relaxed/simple;
	bh=jDBtIRNSvdnXQ+YX0966Cva/Jkh/s8dcFK3xVqDtZjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjIR6mT1nM5roZsD4+7kzyW/0DU6P8EBjr7d1KsSUAETR0iD54xq6VCxViddejiKpE+LpQNeXDSkBF40NFm6m7MkQ9wNEU4w4X7hCBsPH7Bd2KGD9CGK2702cWQvAztUBeQTmyJdkI9Qrz/GxJ30zjnroze7qkYGlQl6nybLnrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Vo06L22A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=poNTgoDX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 95E65254017D;
	Tue, 14 Jan 2025 15:29:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 14 Jan 2025 15:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736886546; x=
	1736972946; bh=wJLmpz1sYrFKb0wwsc0KqSEbmW5hKDi9KxZCsIoHWJY=; b=V
	o06L22AHPYMCuxR2pNOndR7r+kbRED3I+p4964S2gqSVTJOzh8klO3CnKpF/2Mlk
	HJIfnOWvIX7qk7bADoZ4MZZ2Sovq4uL2gydfBLCmkfWIEg4bVV+vlfTTgQbw926z
	GTYQTHNi8V2kHBiZyHESCRQml342WQT3JYCO+K36c++h15D+IgdRUODxAzR5HBw0
	QZKfto/vga+NA57CnMpweo3ZvW+BAYsgrHvF8AdVsIzXAZagwiG88Fh8ITUNF/KP
	1EdhihEc9jB4li1bZHfD8ZR7+q3+nqKWfVQMW0oyW7v80+T1/tSf4OI4ezPjBKcM
	MtNC3d+6wXDr5nqHzmh+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736886546; x=1736972946; bh=w
	JLmpz1sYrFKb0wwsc0KqSEbmW5hKDi9KxZCsIoHWJY=; b=poNTgoDXo5BOrd+Fm
	bP+Y1/5kyqp7AX7QPKLG/qTalo8Ned34UiGHLe4kznlk6VDvdHceNQYNO5Gwkz6c
	S7Geo0WLwoLWMlZX+FJ0fhsZ0sQUFl9fR/KHkgKXv1he7Ho/3Sm4AaYuB5Uc42wI
	u3WCpSKSypTXWl1lNGbInqCTPzWp7VLKxXgvgIfWBKZ0zdhLiTxkWZXi319YuN/O
	H0Vf54e+i7BDT+cfMJ+XQLeQwsWEX4AP3xv9QlVNcSx8N2fnFTI3ohCahCQ9dWVV
	LUkle//3b5blHm2vFWyc5K2wEfAaJQmo0u9jVJl5TbFlhpjdHgSR2dMEIPue6Hir
	1+1Ew==
X-ME-Sender: <xms:EsmGZ_wG-5DGPtP7dy6dYHiGPn_BSrS66DYyksIJyaHCdrls0aIu6Q>
    <xme:EsmGZ3R9boMLrz8Avu8394cVoDWqMoa_BkPfp-uPel5W6CJ1dnhYLKwbbj8QtaOxm
    t019ljeqO_7AKKQMA>
X-ME-Received: <xmr:EsmGZ5X6EXElmnZCPoPry6oKI8zXDgPg1bWzKiOVLtT-35EjCh3LhnqPTTlHu8be4UNxT0iReBxedQ47_4lqxyJuQH-kZ9l4DVZ6zE08NegYFUkZ1AEF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihuse
    gugihuuhhurdighiiipdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrih
    hisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsgho
    gidrnhgvthdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhig
    rdguvghvpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EsmGZ5j7CMgDDHkqnpK3I5RZwql1S4RbxRWrlVuVMq-iPTA6d2o2aA>
    <xmx:EsmGZxB0QTreJVlxP3xw-yDw5faJBoSozMvJxsrWAfYq96bW1WDuuw>
    <xmx:EsmGZyJny_vqTcX2ExB0R_Czxl-Qieogog1swjge4EXGxbPG3Hm_gA>
    <xmx:EsmGZwAHOfYLV68XNbH1Sq1LfSwvLppI_0Jbqiwv022JGgF4PSAuVQ>
    <xmx:EsmGZ5ZVE1-kH29N1FRAGPLWJfFHhalbZ0EPFA3tnUW7QveUQaUIDong>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 15:29:04 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v7 1/5] bpf: verifier: Add missing newline on verbose() call
Date: Tue, 14 Jan 2025 13:28:42 -0700
Message-ID: <59cbe18367b159cd470dc6d5c652524c1dc2b984.1736886479.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736886479.git.dxu@dxuuu.xyz>
References: <cover.1736886479.git.dxu@dxuuu.xyz>
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
index b8ca227c78af..8879977eb9eb 100644
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


