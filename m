Return-Path: <bpf+bounces-47393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36B9F8AE4
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 05:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667B7188E880
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 04:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF4B186E54;
	Fri, 20 Dec 2024 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="j/ElAzTs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eeww0wge"
X-Original-To: bpf@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C016EB42;
	Fri, 20 Dec 2024 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667810; cv=none; b=CuFssYNbaSXmfnDxvgCWClNUQpg/wDEhuA0JL298yoFKog0fkbt/Gxa/rsjKP2nUBoFQ651mcTJvfjy6TYblqPt0KWBVDveR3DYAusVHxn5z3/UVyRmX/TdNzF25wpl2/Hug2j2+65cgDOPBUiMw5lUbITAoX66tlHngX0F+1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667810; c=relaxed/simple;
	bh=M3sPUnOlMOUEjIyxNXS7N0GciZ/ZSrap+cHlJvyandE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqGHLqhNKBd8TYf0FHYoiNBFSROkQJfWYORFoYZzvcsWzGo90H7vc2uN0kiBC4xHQgFWRe1rLiBpZTqD+hw2stZVNYucPpzWrX4fYhBp2GF7PkaQceTD+7u3eyF5pY1oC2GAXzTUTyqLpxcy+qCCDRSfXGJxJ00+KOUhmCUn35g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=j/ElAzTs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eeww0wge; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 5C1E91D40601;
	Thu, 19 Dec 2024 23:10:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Dec 2024 23:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734667807; x=
	1734675007; bh=YxyPwDN5jF3WrYeLfnPg62rlODl4h0Cotdz5rtDrqTA=; b=j
	/ElAzTsR5AjBK08HUxWQDRnilSdQGhKqR9kxVt3CMEWkpKOeQHD/FLNPAq8bIq9J
	xGScCmKOqOIk5w4fCu6K6GrEmCxif6vSu9sl06h/s9OFYet8zKi1LuW7GVCe3gNG
	q2NBB1pzSYlw4HioCQjMaseeQaoSmJHlNDwR2j7b2iB4z4NpV1sFRhbHJe2el238
	dqipradcBYtnHFm8FIaWRPpCQ6sslQZ5m0O0YVSX2RCUw1REqzl3JrTeKX1hoBMC
	WUP5XDMEYEPIGbkNyOfbsb/v259NFMEUq3DjPeV2k5Jnbl365w1fPaqSqQQe6T3E
	+NoWRe26ChJT8ZyGPMytw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734667807; x=1734675007; bh=Y
	xyPwDN5jF3WrYeLfnPg62rlODl4h0Cotdz5rtDrqTA=; b=eeww0wgegHHfTrSiQ
	x5+7ykElNshtpAo5u3SpYhzrbnXw/cAjMU3iiPQ/hxmPQKB0MBiO9g1qk+8O5O+E
	bbDK1hNVQNKiBsHqAntg8M7jXoNjTNKnby7W49s166dh4EKljYCFtW0WqvRlHeV0
	RNLYrgCG1cMqz9RHm/WLzKssz73bmh9ti4luuaKfpWReBHgzlOTB8xKz0e/dUUXu
	ofzWfvK80+iN8d/FWFRJEr+xGrGpkE+IZ6xv1Xc+yeH6efSXm65HwBfZ4kCsXq0X
	x9H1nLpAyQT+YXCjs3/cirpY+KHh9v5n95CSqwwmVNZW00TlGkCwFGvhE5F4o7Ic
	HXM4A==
X-ME-Sender: <xms:Hu5kZ20JO209uO6Vj9j3U-MR8sCbmymOqQj2SRr7IDL8tkL5K_UF6A>
    <xme:Hu5kZ5ENDQsQME9es5G0jYfzb2urdzyRtX2Kw5k4Jk8RhLPEItNwaZXWW28Ktktzq
    _nX11iYRHzazVqE8g>
X-ME-Received: <xmr:Hu5kZ-5ky6XijPafz-52HIe3ddaLkmqqlZr7MlDJdbVjHjhHLgvSokAG-3lDDlk8q5ox61aLJMcjPvfd6qBH_dwGLdlak-1-eqOcWqjZdBSgM5eqFtDh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffo
    jghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeikedvueetffel
    ieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghp
    thhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtph
    htthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopehmvghm
    gihorhesghhmrghilhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrd
    gtohhm
X-ME-Proxy: <xmx:Hu5kZ305kwgwTCWzlUL8qPvYG7Rpewdiuhh-1ievnfeHEhjeZ71Ncw>
    <xmx:Hu5kZ5GM1Y2S8dNiWsXIYaabz6-r-87Q-ruKk-XbwVxjjGWZQw1Yzw>
    <xmx:Hu5kZw-8yRQWXZ2gORHKnqBmaL6RXDcsxyB1nZ0hjCjuNVJIBP7iwg>
    <xmx:Hu5kZ-kdTOvG1ZHkF-lsceT6Fv2nnU7uiqzmNlE50UtPBwwwatTnZw>
    <xmx:H-5kZ9Kk3VrdMScD7LKn0AdY9qSKGv9d3inJIJPjpH0zFQMK8UIAbdF7>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 23:10:04 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	memxor@gmail.com,
	pabeni@redhat.com,
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
	linux-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 2/5] bpf: tcp: Mark bpf_load_hdr_opt() arg2 as read-write
Date: Thu, 19 Dec 2024 21:09:44 -0700
Message-ID: <766c01238ae028c27fe0661bd29eeb8f7386cf70.1734667691.git.dxu@dxuuu.xyz>
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

MEM_WRITE attribute is defined as: "Non-presence of MEM_WRITE means that
MEM is only being read". bpf_load_hdr_opt() both reads and writes from
its arg2 - void *search_res.

This matters a lot for the next commit where we more precisely track
stack accesses. Without this annotation, the verifier will make false
assumptions about the contents of memory written to by helpers and
possibly prune valid branches.

Fixes: 6fad274f06f0 ("bpf: Add MEM_WRITE attribute")
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 21131ec25f24..713d6f454df3 100644
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
2.47.1


