Return-Path: <bpf+bounces-27875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66698B2E09
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 02:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97711C21FFB
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079D47EC;
	Fri, 26 Apr 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="mmdkNSbx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQSxkrta"
X-Original-To: bpf@vger.kernel.org
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5F652
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091355; cv=none; b=QAeaipAKoc4IGxWE0O8NS6DmPh7ZYoE8CkDC4dPCfeZTt7ZC9jWMFhM2OgoCWRh1Pb1Ztv9XnQtYEyec4dSu8TLQPfANV9t9jANPABAcXk+HDtl6R+EeBd8e9UIecLk1FtcdgHKbeNRW/bYz3wAf9pBwd/YljwXiRr61eP0fGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091355; c=relaxed/simple;
	bh=YfE1nuWixn7IuvdoEPPm5kDU5Wjy2Y6UUXifL6WaGXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B02UcW3h4obzGm0JSVehwYSQjcdlCbXj6HyiVX7aY1bpKx8AFmW7DqxsR5P1m28Zv+Pa937FOjJoKEGUj3nNdPOQZ79SQzWe7i6r4JuZs/qjV9ouIHr4mQnE9tjagVPGP1TT4JBPzcQwZTo87BjL627x8JXk86I/DMG1WkQ5Okk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=mmdkNSbx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQSxkrta; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 8CC421C0011A;
	Thu, 25 Apr 2024 20:29:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 25 Apr 2024 20:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714091352; x=
	1714177752; bh=euHHNw1HiVnE36g36ggJPa3VXrD//XqZAWsQ6yPcvuU=; b=m
	mdkNSbxcy390dzFTfILY+Qo7XgZKKzfTnYYnTZuQwhGR5jrpp7mMkxIrEv9SrSwe
	96Y5jgWNWjef9a3XWSHssTz7dAhKl2lQ4U52dhzsoc0ZFmxbQEjnL4xYXZXWo6c+
	oj1XnBE4nbraw8mfsFbXTKBqYKXE68ULQ3Ys4gnEojhdDy654VHPoqPTzWd4J0Es
	/GedJlEg6/WNP1zvjDHax+zFxtyPvlDG8bX+c9Ye/2aC6fCifIDVsRoU77zMEV7G
	eXHrt6DrDIblPn6+goxWErEeQVlQqZRrEHfBR6groS+fpEuvscfNS0f94Q+OMEmT
	npoUwIrxmhyXYar2cD26g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714091352; x=
	1714177752; bh=euHHNw1HiVnE36g36ggJPa3VXrD//XqZAWsQ6yPcvuU=; b=f
	QSxkrta8t2l72U0Th5NNss0BGhTm5beLchzD1C+jTy2aAlUVqQigTxLvapgE/XvO
	gxK6epCYtCaO0hJQTVdzgtwZfkyCIPdihxt5IFVgV4OjGZPXh3BpAdpagcTejxjk
	crwfH+CR+TWm/6rvR0iJmpMW4KsB0c7Hw0t8DU+HDsyd0RodUilx33rlnfxXfvEH
	i135CjQImyQSRVkRNPKg/qvLJXGDS7ynmQyFnZRXNlIhRAkDj6aM1PN785eFVMFG
	JN98Ouq9fd07fRL61cqFTm6BXFgyDTVXRP+KOKAwfFbVOYLMNeCcf8dVeHxDDsAB
	Y5dbtQQtCgrvCiM/Zh4ww==
X-ME-Sender: <xms:V_UqZlfhoj5y6TvHaDMCSDrNiXLavYekZcIP3g-NHNlT8E8B9YaaPw>
    <xme:V_UqZjM4-HdU1wr-4K9AS8oXS4cnSME_el6nPMkKKN6xDhNQ2z2_B_VYgPi6_MQ33
    lw6OzqoBVNCHbUhRw>
X-ME-Received: <xmr:V_UqZugXkhdlj-BmTilKeQEGtiYkuDsbaaiarXOKddVXLl_Bc2WIla0_hxsBlgziz4l-XfiL7syBZ6aESOwyJovHyUUOCTcYuR-jmvqY2y8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelkedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:V_UqZu8JcslADbv1cJGtDFFyk2x1ehbVIz7znifNQBe6VmpvpSNuog>
    <xmx:V_UqZhu5EuH1Umf_oPV2fbiFCuAwGKQZqVUK5M6tPOUkq5pZPX_MnQ>
    <xmx:V_UqZtGuETcAFknzKmHjt6eBRRBLnjy9Wfed5DaEDGkqJ7_4BWA1oQ>
    <xmx:V_UqZoPG4C68XtcqpGBFP78g0g-HbNJbV9khGeAQYVn9YAtgr7ht_Q>
    <xmx:WPUqZnKEaUfFHWcsGrwxajIxwSDE3sycy3kzN56WvPMJyXUPEBrqyGGj>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 20:29:11 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves v8 1/3] pahole: Save input filename separate from output
Date: Thu, 25 Apr 2024 18:28:39 -0600
Message-ID: <1728b8d941d2658b310457b6c59d97f102aaf66d.1714091281.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714091281.git.dxu@dxuuu.xyz>
References: <cover.1714091281.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During detached BTF encoding, the input file is not necessarily the same
as the output file. So save them separately. This matters when we need
to look at the input file again, such as for kfunc tagging.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 btf_encoder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 19e9d90..5ffaf5d 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -64,6 +64,7 @@ struct btf_encoder {
 	struct btf        *btf;
 	struct cu         *cu;
 	struct gobuffer   percpu_secinfo;
+	const char	  *source_filename;
 	const char	  *filename;
 	struct elf_symtab *symtab;
 	uint32_t	  type_id_off;
@@ -1648,6 +1649,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 
 	if (encoder) {
 		encoder->raw_output = detached_filename != NULL;
+		encoder->source_filename = strdup(cu->filename);
 		encoder->filename = strdup(encoder->raw_output ? detached_filename : cu->filename);
 		if (encoder->filename == NULL)
 			goto out_delete;
@@ -1730,6 +1732,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	btf_encoders__delete(encoder);
 	__gobuffer__delete(&encoder->percpu_secinfo);
 	zfree(&encoder->filename);
+	zfree(&encoder->source_filename);
 	btf__free(encoder->btf);
 	encoder->btf = NULL;
 	elf_symtab__delete(encoder->symtab);
-- 
2.44.0


