Return-Path: <bpf+bounces-55507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC2A81B94
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2624E4A8FF1
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953CB1E32A3;
	Wed,  9 Apr 2025 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="gCtNNbOc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oy6zLfoL"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0BB1E1A31;
	Wed,  9 Apr 2025 03:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169710; cv=none; b=QTCg9vm6H85ltvKOQFXBvP4eE8RYnqXbPsuLOuPw2IgvL8Wz2x8WpkkawPAdn24yedRpNHm4He29cjSoSlKsxu0274hQJ54h1Xq6X5jZ9RCzwo33Uds9Q+6kBKjLxUJgplZmS7TGazvXPm3rrfh5VAEWATCpP1uuKVB2+xC/Vvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169710; c=relaxed/simple;
	bh=LI7NYAjX+L6pI6lrYv+zsW4Fv3P3XhRIzbOFvBz3RfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGTRKf8eDu/xIUgtpvsnMOksfvIbenQbXBQgHb+KKVcOggILJw5N0TX8CKqCCBJQV0ji+awkWBW8OfQf9nvvpKcKXBN6xfcgv0tLpNXF8IslWZJG4Nw0YFSCzlitUOYHya9+bLe4xggKvD6csnWi/DzYCBHlcBRpcYBBrjWDPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=gCtNNbOc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oy6zLfoL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 878D91140257;
	Tue,  8 Apr 2025 23:35:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 08 Apr 2025 23:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169706; x=
	1744256106; bh=kC0vrcJINgsqsxDD2H7/EW5cKA10S1wnC+ZsymZ0u5M=; b=g
	CtNNbOcFECi2zHw6l7ItGoFG3J5th6+zX93oydIf37LI3TwY6fIsaeNra7Jp9Peg
	MWQR1Pkl1C4BoSP0WsVtiwo0xQqJ/VTKJXBR7QqiIzU9SwmEtmHJa+LQf+8nfAlq
	01i1OprWCrmHXLPis/g1YHDBDP8EF3H7sYyHLjvkdf8oaFEwLeD/9Fgo5b6Fekgo
	TpU8yqwXXaGruzpfkt4ZngkxhAh99XUerAAkVQ0WIUtychbygPa4W4CeF9p8oMsX
	8s2CZVd902sXCid5YbVJ+vBsvIoRSlg6EHZUqFiEQEArSDKG2p+d22CGOZjzSjCs
	inWpMk69jyV3isGCex5bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169706; x=1744256106; bh=k
	C0vrcJINgsqsxDD2H7/EW5cKA10S1wnC+ZsymZ0u5M=; b=Oy6zLfoLBHSxYvSZq
	MDdhUDwXScvJaxgmCWuUwqAo8bj8Key87v878LCckrKvfGLi15/wpIr3oc5FwyJn
	uM8Hvf213h+EmCIU0KJyvTsbm+sOAOx/GGpjsml1YhmdM852kg2xjZVkGcd1AEe9
	K4yv4KHM80BWnSelJxkZRhWBtl+Ld4QVWEfhwVLMBwiTbnlWWXPSB2GDY8oLucVO
	19qSo6Djx7TYoRSt1pDPivaHiBHUzKOg+c7n0xUQT+bMwSvfjTu6B+MECKHJDEiZ
	sHuG0daGAbRYawOV0IJ8OxnI26q0mWGAoseaE57Sj+PRfyh+ZZX85uohUllWWhCV
	VDj7Q==
X-ME-Sender: <xms:6ur1Z29uV6ou0GkYo13zkr9t0ECaIFJKAF7HAJs9Pcdllj06Q5GpwA>
    <xme:6ur1Z2vbu2w6irf_DwND5y93wVixdyLDFNvguOHjhaas5MOXOckHrxMLfn1r-h2PS
    ttK98VP2msrO_mN1Q>
X-ME-Received: <xmr:6ur1Z8DmIhvbuWblNP4fGHHLAPyrRl36EFUcCR8jRTtVsBtd3vZL3SnuUvxh867an487sFlIhPC_zAhsk8GWFImMfh9rXN9YMj2-f-yyImRdi6k381D1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgs
    ohigrdhnvghtpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpd
    hrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhn
    gheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslh
    hinhhugidruggvvhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6ur1Z-crEGde0Eo7hj_t-uHfZ4cZfoxL8qTuuWwThJ6KbPy8BqYvxg>
    <xmx:6ur1Z7P_i3D0R5gW3iJzlIATtGPqUkw06u16ZeF6vnwzXiEUNOZu_A>
    <xmx:6ur1Z4lNQScSO1MLoZhR3O5frRyAYc0Y7akbKpEXyAq0KyOaoS8rDQ>
    <xmx:6ur1Z9uqYB2S55vIw_BbMPEoTjr7tAxkD4sj7j774qIo8b83iC1VtA>
    <xmx:6ur1Z45TuAu2_bYOHOdrHA4JPDDZ1xHc_wqVKWXTcAhkQkQo1iTteYN8>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:35:04 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC bpf-next 13/13] bpf: Supporting building verifier.ko out-of-tree
Date: Tue,  8 Apr 2025 21:34:08 -0600
Message-ID: <2e31904051277ecff988530b50373d11efdcfaee.1744169424.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1744169424.git.dxu@dxuuu.xyz>
References: <cover.1744169424.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This supports out-of-tree builds against the in-tree verifier.ko. This
is intended to be used to build newer upstream verifiers against older
kernel sources.

You can also do an "in-tree out-of-tree" build as proof of concept:

    $ make clean
    $ make modules_prepare
    $ cd kernel/bpf
    $ make -C ../.. M=$PWD

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/Kbuild | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 kernel/bpf/Kbuild

diff --git a/kernel/bpf/Kbuild b/kernel/bpf/Kbuild
new file mode 100644
index 000000000000..0b4a9ce14c6f
--- /dev/null
+++ b/kernel/bpf/Kbuild
@@ -0,0 +1,8 @@
+# Because Kbuild is preferred over Makefile for in-tree builds
+# but Kbuild is necessary for an out-of-tree module, we need an
+# explicit dispatch to Makefile if doing an in-tree build.
+ifneq ($(M),)
+	obj-m = verifier.o
+else
+	include $(src)/Makefile
+endif
-- 
2.47.1


