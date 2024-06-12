Return-Path: <bpf+bounces-31949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AEA9057F0
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 18:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5821BB260B1
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADEB16D4F6;
	Wed, 12 Jun 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Mei5pO4S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lsTkyBaE"
X-Original-To: bpf@vger.kernel.org
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81F184100;
	Wed, 12 Jun 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207958; cv=none; b=EbfH2lVTfLq0lLBKEJeMW+LX62rvtHdASZ/Hhey8vlj5ESdIt7PqXaeqv7963mNqvzzGShTNK+kXLqvss1813ojUMq/HShCx+i9QLwNX0RJm+WydoY4/PljZR4ut54czgOJ1ovZjnV/Q9V82kyNbQWjv5dVSrbvB5A+xt9V+aNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207958; c=relaxed/simple;
	bh=IfFlcVkbzIPvggXb24hyNdkZRJ2Jg5qhR39WWU95QM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy4LvgcYKDkklCrtK0G0NmiVsC+L7rImTj8VxUqOditIFKa4oP9/sxNwR86o27shxqlMEW8UpXHKL4WYr0X5oWdMVyAXZG+0Udavf3HS463e8mfG7tKj//DcOPE1SCXNy47lYfCcVQbvCiU+l4WIBqXlOsuV51kvw8tBXAT1gsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Mei5pO4S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lsTkyBaE; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 6C30E1C0017B;
	Wed, 12 Jun 2024 11:59:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 12 Jun 2024 11:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207954; x=
	1718294354; bh=C3eATvZn8DMrz6feHue+B4ljsm6ZCJgGAZ3zJ6p4BTU=; b=M
	ei5pO4SA/Fa04V1ZBXmPuIkc+6wQHy3B1QRrT/frA+/dRxxskUrxjZgA/8fouqBB
	Xz4g14WX4EBMZu6goUN6+5eIo4gfmHs0MPjNgAaiLkavsi34dJcqCNXBk+5kfcrZ
	k3tqqycqsfDIXJa/Bw0vqrDXtzHN1mdqivxC63g8+il5Jfk4goObpItEv/cLOzlM
	MUFIEnPQbkvb+W/QKnMQQ805oZSU4RrGaFG2AKDzzKgjNoX5EdVAnQLvvCRpaPPa
	jlYLs/7b1wusJJ+N8gdHdqfHX73ymco267HthP6srjE35yEjOtvobhgJEsZYkbkA
	u+t/6h0hGTjCe+Qz9Ea7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207954; x=
	1718294354; bh=C3eATvZn8DMrz6feHue+B4ljsm6ZCJgGAZ3zJ6p4BTU=; b=l
	sTkyBaEHGMI5yqCbXYNXcWrtE70HR2LuI7o9X8QAbtXugD6Q2IEs0HxZk16Rl1D/
	f7SOrxaaZeXGEgk1AOjLYRlX4MkM7jBnxByMyMcSROFj4Q0DSThiIwDptbZwIyBj
	g8L/TZ1gRTFYu9Gdh8OTalAMtzvwwlxlGQlNhRCKFW9icgiFDD0cNsdHhSPGSpN+
	fVQWLbZFotdBZ2ddayVJESNo8MP7UH4uShak1msrhrym0R0dLHTen2PqdF6jJsx5
	E//lJp4p2qmNnVWgHb96K4VCEjDc3yzpxW3efiToacxVHUcA5wP9ocDHWVmjhqtV
	3fde5Vi1oD7F+tRNa3O6A==
X-ME-Sender: <xms:0cVpZnJQEw1RYFZyf7_NY0j_FqwGMpti6uFbhROWxJU5hQRTrMuTbw>
    <xme:0cVpZrLIjTh5m3yiAbVLDznUUt7ZRabIwZS8natAHrNY11DUbdcRxzuVrmrusCBn4
    xKzO8rOtUdNUpASNw>
X-ME-Received: <xmr:0cVpZvu3Js6tvpssg3zT1yZzdyDXspZGXxTf1FSxwcq2fLuARHAYS65PxmFkJ4yNQ8LyFwvFTkBeysao0J5_8FVI0CoTguNCTU366gMb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:0cVpZgZEDxp1d-z6FWL_npnm85AB2EixzOr2NV9AP2vCCTDZ29YiFQ>
    <xmx:0cVpZuYeafVs-IJyM7CA-VJDDVFzK0t4tBjkXuzDofTOWjvaFgvj9w>
    <xmx:0cVpZkBoc2CuliF8Du76OO9LDbPdOJzblUOLsm78p_NsczuruY5HzQ>
    <xmx:0cVpZsZ0as4GMH_AV7CwEPNfevHNxdIaPH5o6-WqYq5hI3WWuyoP0Q>
    <xmx:0sVpZqr5rtjsSatkLVnSJPE6I55ivCGcUacpTa-uu3DTqlS_qOCGw73x>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:59:12 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	mhiramat@kernel.org,
	song@kernel.org,
	rostedt@goodmis.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: martin.lau@linux.dev,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 06/12] bpf: Make bpf_session_cookie() kfunc return long *
Date: Wed, 12 Jun 2024 09:58:30 -0600
Message-ID: <7043e1c251ab33151d6e3830f8ea1902ed2604ac.1718207789.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718207789.git.dxu@dxuuu.xyz>
References: <cover.1718207789.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will soon be generating kfunc prototypes from BTF. As part of that,
we need to align the manual signatures in bpf_kfuncs.h with the actual
kfunc definitions. There is currently a conflicting signature for
bpf_session_cookie() w.r.t. return type.

The original intent was to return long * and not __u64 *. You can see
evidence of that intent in a3a5113393cc ("selftests/bpf: Add kprobe
session cookie test").

Fix conflict by changing kfunc definition.

Fixes: 5c919acef851 ("bpf: Add support for kprobe session cookie")
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d1daeab1bbc1..bc16e21a2a44 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3527,7 +3527,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
 	return session_ctx->is_return;
 }
 
-__bpf_kfunc __u64 *bpf_session_cookie(void)
+__bpf_kfunc long *bpf_session_cookie(void)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
-- 
2.44.0


