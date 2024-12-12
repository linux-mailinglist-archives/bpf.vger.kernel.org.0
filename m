Return-Path: <bpf+bounces-46754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F19F9F0006
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A476C188CD61
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52E41DED6F;
	Thu, 12 Dec 2024 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="XU++j8bV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qj2QsJKd"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016971AF4C1;
	Thu, 12 Dec 2024 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045807; cv=none; b=aVtjF+PZWfA7kYDPqsus+Ex55p523+pQU0uXJp4+U3GKBXoWLx0BAK0lcvXT6g6Lq8Pv9qXQiyL+2nOtjgLf6Uh/Txkq2UW/wIoWNItl5VJhCd4f+AskORSQCmo7pPHcwN2SIHYDl8vpPI+tjcETYjwu1+rLxpREluc/fJkUnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045807; c=relaxed/simple;
	bh=/hcLupx3MIPc66z/aEXUV9K5uMshR4o2Iu9AOKUAqOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDLcfzvCsqUCHHIrempFwuTK+5/inwPGAGYh0b4UcADgrJ7aOUpTSvnb5rmbsNQrfowx3muFllqL6f/Xki1SWz4nyCH3JJcpfwEV8UXYYxzrkhq9oAGAjvPLGRCd8qHkttbfiP8xSZy4OyAcwq4A1uKC1NMGPvfNhTuY4CmqhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=XU++j8bV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qj2QsJKd; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 06A591383AC3;
	Thu, 12 Dec 2024 18:23:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Dec 2024 18:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734045804; x=
	1734132204; bh=hYB/V7jtK6fbwqwJizegjeBNS7Sue20ys08R/cMFV+A=; b=X
	U++j8bVOeO9WlptieZ+BTvT1GZsjpQ9CuSlG40goLyrWvbzdEYUCChXwxgWZkMWu
	Buo0Dtx3/sC4FcbhB+e34WQl55CTBNifzv11kOj6h3YDB18/IaPhOZakcbyPYWyH
	EPwKHs500Rg+hIG+Fyz7EXRzhmodyZ3CDRxpU2f0MiG8G1htR5FoVZSZxJjHGyKu
	FAcri88vKSAOY9Cuuur5l94ntaXy9XnEg/pBKbxALi4yY4Y+6C4P6qyK/J9PO5Bw
	ERShW71EzTqrM3+UX0hW+orBt+Hsx4w/l9dbHpn50O6tlwc0nkY8GmGWITkAnfg5
	2EvhFmurIY4YBauMz505g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734045804; x=1734132204; bh=h
	YB/V7jtK6fbwqwJizegjeBNS7Sue20ys08R/cMFV+A=; b=Qj2QsJKd+9am2+LOK
	cgQSYfwlnVtXVASXIAoaWQcuKritmW9vUljk/cMGqs7tThADduo333bARDcLhmKw
	X5ZI9KMRTCgjVVw1m6b7xILRiAZNyE1wOIpoe1SMDccKYF8w1g8gQ0VqERLIuloW
	s/4RgdP5q1bqfGTLK8dYoSSWhQaD7DU0EgA7mt6crEXVKlFm7Gu7LFQQGfroEHs/
	Rc8jmqPMgTrYLIQAZggCE/u2iuIT+/33WQIatYm5TqWfpCfrQzHNf0HV+rIRllZN
	RO5eh1ZtZsaBvuuBbXs4bzxrEg5dIL4EIpLBJXODMllRyLgSc3HahR3FalwmY6EU
	5AMDw==
X-ME-Sender: <xms:a3BbZ8RtWUbkXUfRN1zBwrKM1-_eFDI3uun-NoNopc1aWAfADLUtuQ>
    <xme:a3BbZ5zwV717Exxe8cbxGIbk6VNyhWTOc26VxObDia0Zsr0wHf1W2ztPxPfICrdZA
    4o29eNscBMUz4Ds-g>
X-ME-Received: <xmr:a3BbZ53yza_DckQ2NaK90pl1RRKcO02Z0pwmQ5NLNX1LjKt8GJLJMD9QDliUCpgPrheFpMV5apYnExDvu4m-P7fFeYM2d-bl4YrnYVY6y-P3e1Tqvvjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprg
    hnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgr
    rhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdgu
    vghvpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a3BbZwDHSPbtB1ZvLUGqlenoLxiocbu9KpL94-3m7rvrZf9y3T9PRQ>
    <xmx:a3BbZ1h_CvCEKGhqr3jIWM5AI_8KLuwNK6LN301nrquHaCIi1TjR8g>
    <xmx:a3BbZ8rk59hQMlEMSlDWi3GbiAXylM-YBDPcAacMVYLNlXVk3eCFXw>
    <xmx:a3BbZ4h3HzuC_Lj0Da2YNnipuTUcmDlhD5880KLoqp4HycK2gANgXA>
    <xmx:a3BbZ9xIjWuroBR-1IAJAJ96pMhwRNhPsFxXvK9bOQ69bvB8JIhsEhVH>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 18:23:21 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	andrii@kernel.org,
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
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 1/5] bpf: verifier: Add missing newline on verbose() call
Date: Thu, 12 Dec 2024 16:22:05 -0700
Message-ID: <eeb526436f889f3513f6c58c5bcc0a270d6b3e48.1734045451.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1734045451.git.dxu@dxuuu.xyz>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
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
index c855e7905c35..630150013479 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7754,7 +7754,7 @@ static int check_stack_range_initialized(
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
 		if (state->allocated_stack <= slot) {
-			verbose(env, "verifier bug: allocated_stack too small");
+			verbose(env, "verifier bug: allocated_stack too small\n");
 			return -EFAULT;
 		}
 
-- 
2.46.0


