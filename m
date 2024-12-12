Return-Path: <bpf+bounces-46755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8539F000C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A2C16B73F
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47471DF279;
	Thu, 12 Dec 2024 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="TQYgSohT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h145eF41"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355001DE8AA;
	Thu, 12 Dec 2024 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045810; cv=none; b=ZtS4bU0PgKZLrDA3KCkeGRbtbdlnFDZ0Fz2kWF4bsVV0qco39facThTiNGHt+PU8k3eizW3dKMF/zywirlC6fi1RuatAmHJo9nj6VTkT6cV90tE8JNX6i9vYZ9QiYTKh/+P/xL6rlifhAtMYmGp1XHenbDxJUecw9oN6UpvCe18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045810; c=relaxed/simple;
	bh=UZb4qQVObeUXaweZPJHCZurOV8vvgnaQ/3HEd2ktWso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqftaBXhNWwCPA1/92OHwakH2KGkM1rLtYADsA7hh3FuqZxihtMuxIN/CYEcFOaV/m1j7iKSWm0qWC/80JeblnLvstteN4qfnV36gND9FXs9rc8Z93SJAZ4AIOqkfzrZ7E2aAowGrQGkNu7Nsjjw05Gpwl7LIROsSsKf7tZUVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=TQYgSohT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h145eF41; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 2F5C1200856;
	Thu, 12 Dec 2024 18:23:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Dec 2024 18:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734045807; x=
	1734053007; bh=AMjfrS1djNh2JgZVK+F9ZbVc7D+HGHIS6qCqwaPmw2w=; b=T
	QYgSohTKdtqeub8afZyAVoYiecO9AyNCCeH94vGEsK/KYuMWPlNXpWRIrD5Z/RXZ
	oJveZDEEqCzQZu1G6ek+mYSEI6oa98iGRg3wFeOYbGYyrpcNptB9cLjSlsvv5h6B
	b9wLcgROFnP3V+DfL12N7YFt44pvvpgv6KaiqBVuN9xaX0jI7Yc8vk/pP8qbfd1+
	K5PZirXDpreAT2UR1kI+OnZMRiyyTt/5UVWbSwPAT5DVuW8gfSd2qoo5LN16aIkA
	UKa3cwmN7u60EasvbakdkXjNtf78hPIRCNez0JnR80/sBU6U8z1aKV7GOkU3/Tw4
	XKgvL8999n56QM3Re6v3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734045807; x=1734053007; bh=A
	MjfrS1djNh2JgZVK+F9ZbVc7D+HGHIS6qCqwaPmw2w=; b=h145eF41kohYZtgw0
	jNpU+qAOwdf7WVzRP87BD/ue7bxyfpJ2myt7mEqjDxwhQRZBYCIMeJuYlkhJizgZ
	xg+CCq8pNNsqN/yaQF1xeucdiJuHBBBNSUdkYt/5a/dQhKb9UZvohKms536Dgrj9
	UZuaP6WySqYB1/r7q/k14iVsFeXD5n8VG1+j5lfzWa6/Qtlo8TTJT5oHP+H9jVvS
	JpjeCSYhu1Rmq7dMskIRu615ynUOpddf+atb6y+ouHR3tbcFzXloyqQTEffnzh60
	++q7xy0v442cWkC0DasZL3awziyj3B+5MBkN4GK/fUa8ShrkyD4WYIyorcuZOvqr
	X3yAQ==
X-ME-Sender: <xms:bnBbZyd9FQsPZB_HchkaMgv_dWCk4Bf0JDh7ZcGffCFjBMIPRrZdTw>
    <xme:bnBbZ8NvgYDHqyfr9SQcLvrYpX5S-j_ICYv-dflVZdcYfki10f2Mll8nmnVL3VmvX
    eFZtJX3sCRDDuP2Kg>
X-ME-Received: <xmr:bnBbZzggqhq1A9VFVTC9LTgBeQXQeLmQlhTwIAQq6Eny9GO1ccFdS0KuxQffERK3Daj8sv7jEbCwPQAw_BGFCbZSz0cSyeZgbq2gBrpQ0rPr_eT2dVt9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgvmhigohhrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtg
    hpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegurghn
    ihgvlhesihhoghgvrghrsghogidrnhgvth
X-ME-Proxy: <xmx:bnBbZ_9z5btFT4y43QzX4fNE2F86YYkzuukeHcxpJtItvq67M-IkMg>
    <xmx:bnBbZ-tBQXSWNz9yznbScZndblulVQ6Lf6zfXg4cBeN5am-d609IOA>
    <xmx:bnBbZ2HPjDDK82r8_CkgSPHNr56x69w5Q99sEV43WAmwiFmV8WjOQA>
    <xmx:bnBbZ9MDT-yEY4aRE3XS0D6JE0i2ZNGL8oNUsdvW5C3yH1_jNDPNiw>
    <xmx:b3BbZ5lctdPMjTa25YDii9VMx1xhkYm5ayQQ3NiBQUqsoyWqe-wdMHwP>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 18:23:24 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: pabeni@redhat.com,
	kuba@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	edumazet@google.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	davem@davemloft.net,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 2/5] bpf: tcp: Mark bpf_load_hdr_opt() arg2 as read-write
Date: Thu, 12 Dec 2024 16:22:06 -0700
Message-ID: <3de5c7e513e3161e040ee0ad6eb8cc4b7d71aa4c.1734045451.git.dxu@dxuuu.xyz>
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

MEM_WRITE attribute is defined as: "Non-presence of MEM_WRITE means that
MEM is only being read". bpf_load_hdr_opt() both reads and writes from
its arg2 - void *search_res.

This matters a lot for the next commit where we more precisely track
stack accesses. Without this annotation, the verifier will make false
assumptions about the contents of memory written to by helpers and
possibly prune valid branches.

Fixes: 6fad274f06f0 ("bpf: Add MEM_WRITE attribute")
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6625b3f563a4..09b5cd88e60d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7643,7 +7643,7 @@ static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
-- 
2.46.0


