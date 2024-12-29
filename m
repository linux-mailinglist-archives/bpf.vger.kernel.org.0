Return-Path: <bpf+bounces-47688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C9D9FE097
	for <lists+bpf@lfdr.de>; Sun, 29 Dec 2024 22:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C443A18FB
	for <lists+bpf@lfdr.de>; Sun, 29 Dec 2024 21:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E7619922F;
	Sun, 29 Dec 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="DObPJWeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="reoz4otw"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313225948E;
	Sun, 29 Dec 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735508694; cv=none; b=IRlAs4rDaDJAYleTEQPm1BETM7v5ME7lCu1knxFBpun5zBub9XGWN9GOc24K3B1iFoISrgcCmUGyyg9xsPUkYUww+ax4BiZWqdzuy4gErdDIzOa+JKMdpoomqxceoGxNyqBj8JaZhH9EsC2VHsnsBGRxoITUZiLzAvJ8Di4C/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735508694; c=relaxed/simple;
	bh=IvPoNbC0ZAF+dDJuvjxaTty6bdisC9IJSSJkMAZ8mjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X45vUB30fJS9JVeZlPmz6lhYBCx5L0TT6Bpj5UTBOCsMSyMxirvNL2gUUc+8Rbm1qzp/6ZifSLHPiY3071jretOMa4gz2eAgM7SsCSfZyyxcKzqoH/fATsyMnrjdLNcjDXnZ1LUNitKtJHm3ydqcnCmxfIdg5DslBgFbgMf6sDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=DObPJWeH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=reoz4otw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 017871140102;
	Sun, 29 Dec 2024 16:44:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 29 Dec 2024 16:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1735508690; x=1735595090; bh=LIcfLh1A/dRKdmqnT+Syp
	DFuj/WqXpB7n8a4rXugnk8=; b=DObPJWeHCvoVmZ4qr0Lf/ts1ggi/bE49D8aCu
	eq/Ce5fhRxieAEhYy+/QPId9ef4EDZ2hhfAy5vaNty7dYztD6kHUwg7ydoMR0lTH
	or9Lmo/fQKK8aNLL7bte51lajcbrkLjYRwDHNCAWvRjUU2ryBZiZRO3uYQcDQjAe
	nqfYP0wJhwcgmT95txrHda6Zht1Yh1td+9gs5UQ8Gz8TGrn2eJkk8jTOjmo5zxfy
	IpeN6mTSh53UcMxlF3ZV2qriARiNFuYD4cDm24ilfi6P1XlehhP2jdu87SxRGkXy
	LmRi5maiaAPArhCPBr4CVsX2jBK6T04IgLT6bSTFowu5b4Y7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735508690; x=1735595090; bh=LIcfLh1A/dRKdmqnT+SypDFuj/WqXpB7n8a
	4rXugnk8=; b=reoz4otwPKaIW822sSNdnUrjXeiI1sS1SygBQtg6eKbLI3QQKUJ
	vyLhKBvzdX71TGyAyiOmR++PJCDowg4xWv6S4fpkhNprkY47P28AYMTr8L2ONVjC
	isn2oIxm0rIOUnUrA5Lb+6uJOz74jwjbHYK++HifQpMxI8dWmbg07VjRBWFB3lB4
	cfRzbtWe+edECwvdX/0aZ5MNXqCjlZMIQfh5PDtYjofwtdjAXWEym5joUvBfKVYm
	eSLbELbxP156g40FOPzRjl5kjVBJmzosfzGSgyZ1DCPmY3fIXEeqOKXxKK9rmE5O
	iC2Q9LxGZMOsZwpI/XXb4zj4eSLgkf5R6eQ==
X-ME-Sender: <xms:0sJxZ7igMAR4i_DJixOsnrEHPgfUriGMWu58Cuk_BWsIucIXl8mnVg>
    <xme:0sJxZ4Dar3pBCE8eBL_sMyWM6IfcP5dijBCzgzyW8wYJ518Uznm1APNKHDMX3ZOVy
    8lmFJqzyeNdoOAGEw>
X-ME-Received: <xmr:0sJxZ7Fgj6DcCsb8U9BgrqhcpzheA44xyMUurB3XGcdyW61IpR8I7BFGhdPQYDs_0yect5PmObXwCr2KZPOcKAjykU3eS5MuhTMtnQ5xcXR9KpYXXAAJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    dvgefgtefgleehhfeufeekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhise
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidr
    nhgvthdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuh
    igrdguvghvpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0sJxZ4Sd-hMIoNpCK-OLZbiIKj60cpTfhKRh1JDJOcnEGgOKliaDMg>
    <xmx:0sJxZ4xtLZVUUbD_iuxKsO-PxZXt8rVVSxgbGzR4CjvZRyAvXbK6aQ>
    <xmx:0sJxZ-4IujogR1AAhvF9ST0LhvyPSMGOdSiuR5JzRsXJYFpyywBniw>
    <xmx:0sJxZ9wyQTdkhpTfUjx9Ua8MeRr8eXgwXdm5zrqbvB2TZMjtBDsO7g>
    <xmx:0sJxZ9KxI-SOJiIYfz4a3al_5NWo64vFv4r2j57V1AZGonHkZN_1n9la>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Dec 2024 16:44:48 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Set MFD_NOEXEC_SEAL when creating memfd
Date: Sun, 29 Dec 2024 14:44:33 -0700
Message-ID: <6bf30e1a22d867af9145aa5e94c3fd9281a1c98d.1735508627.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC"), the
kernel has started printing a warning if neither MFD_NOEXEC_SEAL nor
MFD_EXEC is set in memfd_create().

To avoid this warning (and also be more secure), set MFD_NOEXEC_SEAL by
default. But since libbpf can be running on potentially very old
kernels, leave a fallback for kernels without MFD_NOEXEC_SEAL support.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/libbpf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 66173ddb5a2d..46492cc0927d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1731,12 +1731,24 @@ static int sys_memfd_create(const char *name, unsigned flags)
 #ifndef MFD_CLOEXEC
 #define MFD_CLOEXEC 0x0001U
 #endif
+#ifndef MFD_NOEXEC_SEAL
+#define MFD_NOEXEC_SEAL 0x0008U
+#endif
 
 static int create_placeholder_fd(void)
 {
+	unsigned int flags = MFD_CLOEXEC | MFD_NOEXEC_SEAL;
+	const char *name = "libbpf-placeholder-fd";
 	int fd;
 
-	fd = ensure_good_fd(sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC));
+	fd = ensure_good_fd(sys_memfd_create(name, flags));
+	if (fd >= 0)
+		return fd;
+	else if (errno != EINVAL)
+		return -errno;
+
+	/* Possibly running on kernel without MFD_NOEXEC_SEAL */
+	fd = ensure_good_fd(sys_memfd_create(name, flags & ~MFD_NOEXEC_SEAL));
 	if (fd < 0)
 		return -errno;
 	return fd;
-- 
2.47.1


