Return-Path: <bpf+bounces-46892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E579F16A9
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 20:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812281887FAE
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478721F03DE;
	Fri, 13 Dec 2024 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fdZYdO4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QHm4y3rC"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD61EF08E;
	Fri, 13 Dec 2024 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119070; cv=none; b=faS5S0bdVZaFUvsa3Rak06YABXL4jH2K2MovbkpI/wOPEXuWHn6tNcWMa7nOF8BzXiRP83PjmmRqAhqGI/DjrR/MFCAlqsAvWuXxZbyaKigST7tzkmkzjkEWU0RZUdm7FofrqGn5tmY70wkTab4uySFEdoyNijmQ6UAXaQk4jPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119070; c=relaxed/simple;
	bh=aV1LU33mjPimJ3grymbwCJbkQ1UMQZmHjtKrS7aYHTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acg+TevtbVhCxdDNUOpGbiv4r89OOqYCijRDI0YeJLzX//K25b5BeELkVgQnwP6UBTiA/paOrlmw82xrV04yMi4ILwqazxR66enLYNWuo65fzXHYlocbQ7T3BTAANGLmu4Tb6Z/ANNKhO6vIqEqE1WOzUkcNCvyiXt9HefWGJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=fdZYdO4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QHm4y3rC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EBEDF114018F;
	Fri, 13 Dec 2024 14:44:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 13 Dec 2024 14:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734119067; x=
	1734205467; bh=YinbvjKzdE2chJYUSe+K0GkdcFRtXOMJspcMdt83bi8=; b=f
	dZYdO4Lq+5ZCyO3lH4rGo8M9mSTEdPpgDkvDKN1hyOZVlZgMwpBz7gnM5UfQiCW7
	gxcZig9bVwsyzCTY71xLXMJ4EMkzGeN+k9iDBZYRqXUWSDHD1P6+b5yNWeP4GU6p
	WsbZHZXBtgUY9SQFQzJHfA4KWX6KyoMQboyMDir7hkpWLl0iSKH7rN89O2Eng5vK
	TQ4fYHHoZxhO4aUunA9aDBIp0kbF/nIg/rdTnGieAZ+6PWBlSyBXINhc/pqsCNV1
	ULJ/3JP/2FeQ25r3k8JWxrO7mjY7FoMlrngvSADf1voR8S1yY9uPPMgvyqMp/DWt
	pr/PeCOUbWMsY1gUfr+1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734119067; x=1734205467; bh=Y
	inbvjKzdE2chJYUSe+K0GkdcFRtXOMJspcMdt83bi8=; b=QHm4y3rC3ECiXk6WP
	J+46ue/KX0X9KoWdpp1qK7z1cMXRJTMZlPeYSt1aTHzoT1WpLj+iI9v128/iukSq
	WNQQ4eV55YPVdrZTF+PEDLZ5bgG/ceCWfGJrgOXJ+gJjvsNpUuNJKwEjfpsECCRb
	NSt3O6/TxfJNdagXG4YKipwX9hWHroD+AxF+Ulf21AELoE8bNGyPEnnXewh4l+Pz
	gyhJsI3N/uaOzS4CjMf+nJ3PFGL22fBcaeo6ukj5qdJz0rtsy1TIbyNHyCA3/raU
	Oy6LoqLm7aVe/b+prARGTEK8Q4JW4GOT4zvYWnAv1yoofslQrp4uiXXDelvpu/ky
	b9xPA==
X-ME-Sender: <xms:m45cZ0vzcZxDnRcTZuFKJ_XY-CPAhqr8l5XYIkKzVIUYyTjEG2-ymQ>
    <xme:m45cZxcVNJgfWIMV3qrLVZWedTvkQv4j9jym9xjDlgw1HBspVj0ILz1ZONgFXzPe5
    Dt4PDPMssG-oyOxxw>
X-ME-Received: <xmr:m45cZ_z8s_NTs_lN3zyk_J1uB_8JITstXexKDe5Q8sjubebMONMmoBj5tO9KhWI0e7pI2fUpIpzXhY3nhceW1y3b24wr7Ab23CYH6omPWxuMWtvnndZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhope
    hqmhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    grrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjees
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthho
    pehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:m45cZ3OLIH4Yvwjj4709HkIi8foiidukI46ID1LAjEei44AapVnaqA>
    <xmx:m45cZ092bHWZDXy2ZXq0QGuUJvHc5nGCRVspJhDPmNv6-xD-P59dRg>
    <xmx:m45cZ_X1M4Wsc8v8XDGfujjLUoLSXC_VPy5t5Np34RKMYKgxmzkd9A>
    <xmx:m45cZ9dokwz_hnoO49VWq0XkrR7kpDCT5V16ZO1n3GbFXojqczU5yw>
    <xmx:m45cZ306RtmEo9jt9A8DMol07Dinl3tKRTkoUcrrGayHwDyv903FsQXY>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 14:44:25 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	qmo@kernel.org,
	andrii@kernel.org,
	ast@kernel.org
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
	andrii.nakryiko@gmail.com,
	antony@phenome.org,
	toke@kernel.org
Subject: [PATCH bpf-next v5 2/4] bpftool: btf: Validate root_type_ids early
Date: Fri, 13 Dec 2024 12:44:10 -0700
Message-ID: <33e09a08a6072f8381cb976218a009709309b7e1.1734119028.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1734119028.git.dxu@dxuuu.xyz>
References: <cover.1734119028.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle invalid root_type_ids early, as an invalid ID will cause dumpers
to half-emit valid boilerplate and then bail with an unclean exit. This
is ugly and possibly confusing for users, so preemptively handle the
common error case before any dumping begins.

Reviewed-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/btf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index d005e4fd6128..3e995faf9efa 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -886,6 +886,7 @@ static int do_dump(int argc, char **argv)
 	const char *src;
 	int fd = -1;
 	int err = 0;
+	int i;
 
 	if (!REQ_ARGS(2)) {
 		usage();
@@ -1017,6 +1018,17 @@ static int do_dump(int argc, char **argv)
 		}
 	}
 
+	/* Invalid root IDs causes half emitted boilerplate and then unclean
+	 * exit. It's an ugly user experience, so handle common error here.
+	 */
+	for (i = 0; i < root_type_cnt; i++) {
+		if (root_type_ids[i] >= btf__type_cnt(btf)) {
+			err = -EINVAL;
+			p_err("invalid root ID: %u", root_type_ids[i]);
+			goto done;
+		}
+	}
+
 	if (dump_c) {
 		if (json_output) {
 			p_err("JSON output for C-syntax dump is not supported");
-- 
2.46.0


