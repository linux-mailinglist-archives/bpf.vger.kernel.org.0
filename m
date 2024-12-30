Return-Path: <bpf+bounces-47710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C19FEB0A
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 22:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690213A2504
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 21:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F0719ABBB;
	Mon, 30 Dec 2024 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="sDJLfBco";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q7SS9tw4"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03C381C4;
	Mon, 30 Dec 2024 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735594312; cv=none; b=OrGr7ZOC7ZICXyjC4ppp6sULH4FqUnp8TdV4cV7rMLNdEQn0AVPKy8I0Aoff6LcjSVS5nYK+2AAVgd1GDccFbJkg9FbINRDyj09dr8Do4ziraQaVOarbVH0FQ2RWVzNf8xefh2+L1em2//QucABMFqPXZCTfTXaMXcJciLVVEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735594312; c=relaxed/simple;
	bh=jSuBOMSE96WviEVAIvXjchFZc2EPOZrwKKqY1mc02ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neahf84oKh0sVl9CrlMKc19A8cFMdBLOfUn27JzFwBxkGd+C8fjKSwKfUguaEM0oM7V7o0ioIB9biBURPWNbrJ7ajljg6rzCzCfeN0zY4nTiNAIW3YwYcruUJgjMegpUfuVIC9CvyVIxxkHB6QRM3KNCVyYwR885Sv66CWzow5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=sDJLfBco; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q7SS9tw4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B03E411401AD;
	Mon, 30 Dec 2024 16:31:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 30 Dec 2024 16:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1735594309; x=1735680709; bh=4ucC0cPTmw/ddhRJP3akL
	VbIrcXB7AXP4E9BT22TGhs=; b=sDJLfBcowcQ4Q0h+knEW7KRtFrVRlPS/Nx3A2
	zZT3J80+cryb9djRa6vKNstgewl1IfD+kLm/yJHoCkl4XXKG66cH6pL4qYRmkp19
	Z0zYXqLu0pzZgN/PDg45IBMC2GQ8Ntfn9YNVvFVuwwxZbVg0/MrMvsq67M0LomqB
	OxdwVRPW6qXnClHVdJaMc6HNZh1GJI3x8bJ3zMiWQbCCZMUJZm67XIDd0gLXM7LL
	PvPNjc+mzJh768E+f4K/gbs/fYiU6Vs/DBmO1xHTM4ogFgBB5GHPdn1y+FoPM9K8
	n+b220IX0rBSMptBX/Ni62m4FejppI1ozC4bYslIzfdUPeN6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735594309; x=1735680709; bh=4ucC0cPTmw/ddhRJP3akLVbIrcXB7AXP4E9
	BT22TGhs=; b=q7SS9tw4/VBR4N0EoQIsGtPPXgVWQRZfvGvRVzLyS1TxIH7i7NJ
	u8M1hT5R4E2mQs5JjabQMAQEJo2pTG3j2Ah/Gci7q1lkHyHkcnmBRvdwSl0/V7qW
	26EBR7ANGE6TQvHqf7C+d1sI5/IutzF3SH9hXj53TDV9VOBkgS0JhFjbYAciw9CM
	MrjVVEfOvfM+mAegOdTKHIaTW4ik/BEhLhOU7frszieCs5oBDLZuYLtErqY65Yhy
	d4xkKlFE9zEmVgptEl5pZzDIXz4XbGczcMwEvQkOL3hZlC8GezCYCpUs7TXJl/bG
	U4YK0C4kw5eLapj8E1354fL8S3eyjWqX+Vg==
X-ME-Sender: <xms:RBFzZ4l1XTQ3Q7Nw-kppYp3qSG7l7v2PDgIfVMwvLemOv02Hfh9Szg>
    <xme:RBFzZ309prMdOYKXYDvuTUeQmHHwKwWhNHj-6OKXOIFbE8JdQ6CkskLWcDUxRX2Me
    4uI_vuzr-bMAvaDyQ>
X-ME-Received: <xmr:RBFzZ2rUouV_NJ-KetJB3FrL-4rQFAeObdrqHxloux622IH4NWpAIX4Bu_vS1xtaG88UhReWlh3ChTqGlh9K99dfqPBeeEr4mjX_Bnrl8tFhnKclHM66>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    dvgefgtefgleehhfeufeekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlse
    hiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdr
    tghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuh
    igrdguvghvpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RBFzZ0kZxxOEAy4vnM4FjPF_aGm-AWnGXeur2k7B6esffI8xPrmbXw>
    <xmx:RBFzZ20eDSYILV-RKWAaruvXKpQHh3yDiOPf589Jb1t8Y9iMNtaPdA>
    <xmx:RBFzZ7t-ThBvTfjJp7zSmke40OzUUog8m9-_AfizN4UIO7Bso_jOkw>
    <xmx:RBFzZyWJSehX8XW5KynSOx5AYN8kmAvqAuN5qinLabXuDwBLwQs6Iw>
    <xmx:RRFzZwNOjRMlZiUVhOl-IB72isIZ65KS3LexWcAFGTOTkETxLc_4lCxy>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 16:31:47 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	andrii@kernel.org
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
Subject: [PATCH bpf-next v2] libbpf: Set MFD_NOEXEC_SEAL when creating memfd
Date: Mon, 30 Dec 2024 14:31:22 -0700
Message-ID: <6e62c2421ad7eb1da49cbf16da95aaaa7f94d394.1735594195.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting from 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and
MFD_EXEC") and until 1717449b4417 ("memfd: drop warning for missing
exec-related flags"), the kernel would print a warning if neither
MFD_NOEXEC_SEAL nor MFD_EXEC is set in memfd_create().

If libbpf runs on on a kernel between these two commits (eg. on an
improperly backported system), it'll trigger this warning.

To avoid this warning (and also be more secure), explicitly set
MFD_NOEXEC_SEAL. But since libbpf can be run on potentially very old
kernels, leave a fallback for kernels without MFD_NOEXEC_SEAL support.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
Changes since v1:
* Update commit message with pointers to recent memfd warning changes

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


