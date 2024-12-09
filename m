Return-Path: <bpf+bounces-46434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE09EA313
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38BC41886F20
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AE9227571;
	Mon,  9 Dec 2024 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fiv5TQjn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RFNJDvI+"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BB226190;
	Mon,  9 Dec 2024 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787911; cv=none; b=C0AyIzakc5mfRlSOFGWdgCOl8ZTDFwFf1O41ogSQvpaRrlEmjVfV1cf1eNVnndwSVd96Bn2zZtlAkNm6mWaAWDfMS6LtdCSJa0PqLMe9GzSzCZfcRCyS5KOAGqQptgkpTesRMFJWDP1SsA4C32oE4ELFlN4FVKkvriLJV9fF31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787911; c=relaxed/simple;
	bh=xOJhmhJiPT7XucS+JvvOAwbDKJCLQ0uJS5LKiah0erk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMzox+MflvpY8PBnZhde/XufOdZGv+OPAYllW7wDqCrqkpoa3AnLFsk/Cc/hpxrrFB3t/38IYCzvTNGIEh8p4zHIzUj7NkqGf18ONl8uRven3vB3HLIcEzYZXvhLg8bghcuw7IybeenGe5wavavDMWT+abTisY7xzTt1s+8Trhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=fiv5TQjn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RFNJDvI+; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 52EBB11401AF;
	Mon,  9 Dec 2024 18:45:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 09 Dec 2024 18:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1733787908; x=
	1733874308; bh=1nIfMacAqxf+3GQ6nJo3PSByZmybpP146S5tZBDJZ8g=; b=f
	iv5TQjnKw3PX3l5C53Jb9Jzg34slzjktY2rT0TOev9Jb2MD74paQhwbobuLbVYZ5
	N8XNcgWI2+zQjb71fS1d4dVnfj2u0EHKgUA9YkfTKRbBlTtNcHVhvHpsZKgrYxyN
	Jjz3c1/k6POKtTl6TqK8BHRE3UmxZxqb3at4HJuxTZsLHUxuudcNhwi7/phd8Q36
	ouZbI/igErUZLEZe8AJpEfkFCuxLRNN3ivz1UyX8ag87tdTXUOucj0GFldi7gvXV
	PcrO5749l3CGMahNfdwJp5vasMICYMFk5KcVroiuMENl4gU2qBBCTayhiXWoQU6P
	QUc79Pq9f0Ou8Z+EbEpSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733787908; x=1733874308; bh=1
	nIfMacAqxf+3GQ6nJo3PSByZmybpP146S5tZBDJZ8g=; b=RFNJDvI+hnHbGnGCq
	3rQTAQwpHdHGTVUyeyuqtQOW1ArlqTbI3/dr8nuhn10asb/w1AYgQwfpdSBmdzhq
	lB8GSAjL0/0VTHdz/ndXR3uShBM0FK43rJOnz9g+V4aR85cIG/dw+uays7FjWZ+t
	tiznb1+fOGtAfrXGyVvGSoGiUOuxTcguWZgtKVY6Gjv2iaQHKpc3qtDDHizWhV54
	suv/CfsaAmTjBMy+W20Sk9WDkWez8jYoVnqsNCV+8TZJ8if5Z0yu63Zd0v91GrUD
	4ahIpd+q0eGTp6H9PRm2h54rCeV9QM6l0KzyyDwr14cu1p01aVlnQMG1JnsCnn69
	ogISA==
X-ME-Sender: <xms:A4FXZ9Hk846IrYaOdldxT97MMdglnn-772Tlbmv32-b8YpzXKrrA9g>
    <xme:A4FXZyVPDnSFtkN-i4Fohv666BxgHjCcXnbRGAyxcRdi76kWMaR9ucewhXvn0mxXo
    nkK9JVkG_nU6HtRYg>
X-ME-Received: <xmr:A4FXZ_JIr0gH3ha9t_yEnYW6ohTEO7wWRhJjX5QFXvk_Yh9BO8WzkK4l_n-J6C4eHjoUcOqChbxDveXKSWoVNePRDv9tqpuxWFjmpgSW6oouKCHTWoho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvght
    pdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrg
    hrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtohep
    jhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:A4FXZzHnJs66QrG3w-_kArTcrZmKNQDiBT8WE100s15p1w2_EdqNpg>
    <xmx:A4FXZzU6tpXngKaQLgc1OipUgjt8j4e3LNo565JdPJRF4a2Z2fjTyQ>
    <xmx:A4FXZ-MCpZap8wiKBi6L6x8MwTTaxk46P6Xo-3aYZHHi7sOfWOWzTQ>
    <xmx:A4FXZy2-u1qzU6bZq-lFC5o4RUx9CLLagLdJ31XlWW-ehjMf3dMxtg>
    <xmx:BIFXZ1akP-sLTSuAOejBzzMfPewvThEYpO-1cNtCMt6nkR6qOM5UYURU>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 18:45:05 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	antony@phenome.org,
	toke@kernel.org
Subject: [PATCH bpf-next v3 1/4] bpftool: man: Add missing format argument to command description
Date: Mon,  9 Dec 2024 16:44:32 -0700
Message-ID: <0eef137aa015b192ea8bd8a94f98ce8c84e8b56c.1733787798.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1733787798.git.dxu@dxuuu.xyz>
References: <cover.1733787798.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command description was missing the optional argument. Add it there
for consistency with the rest of the commands.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 3f6bca03ad2e..245569f43035 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -43,7 +43,7 @@ bpftool btf { show | list } [id *BTF_ID*]
     that hold open file descriptors (FDs) against BTF objects. On such kernels
     bpftool will automatically emit this information as well.
 
-bpftool btf dump *BTF_SRC*
+bpftool btf dump *BTF_SRC* [format *FORMAT*]
     Dump BTF entries from a given *BTF_SRC*.
 
     When **id** is specified, BTF object with that ID will be loaded and all
-- 
2.46.0


