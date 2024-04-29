Return-Path: <bpf+bounces-28200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4958B65E4
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995F1283331
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE69A2E3E8;
	Mon, 29 Apr 2024 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="H9DbyykL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iyHCJ8XP"
X-Original-To: bpf@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5818028
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430784; cv=none; b=qBMy+v7PzTq3zkf7NyC9tJjP9mn7ApP6zhkMKbUi03SlAToe/+hA7e1RY7SBFua5NKwd/OlG8Coqp+Iw96d+0FSPaMGZt/c/GHAyUTN5vF/5OQiwHv9UGD8uTW2ywk1EAH9ryqXqH5CIHzVOr7l6qm4ae4nK4HUUJEssvmFphIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430784; c=relaxed/simple;
	bh=YfE1nuWixn7IuvdoEPPm5kDU5Wjy2Y6UUXifL6WaGXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phnTsBVjxpDrkfHJ4+PeVkCra+d9v7ZNGsIit5y6oyR9egINUH3Q1ut9x02mUsfSR7W9WPsGnnrlSHVUpxU0OiTUEpG6ETlteVFYgxLOkX/DoS1Bew3lz5cQe6civPxTjoucc2R+aiPU3u0+JCqXPt42BOkyH6qQ+OeU7QXBKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=H9DbyykL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iyHCJ8XP; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 8908D1C0016B;
	Mon, 29 Apr 2024 18:46:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 29 Apr 2024 18:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714430781; x=
	1714517181; bh=euHHNw1HiVnE36g36ggJPa3VXrD//XqZAWsQ6yPcvuU=; b=H
	9DbyykL+EQlH5240EhksIfA4GHdRujM0wTTfg8q8DrDwd86IYu6wYSvrctGXGU6y
	0FR0P2VZUx6NC9FTlHAW5VA7E8IwfZ0/s8VmG/ibPKSO5CidO3nuczirxDQBBq/l
	/lIAm8S8GFMUHNFFvla5ujn3DLIIgS92jhhZ0/rNnsZNIiI3DFYxOGtkHeNnM0oe
	sYRCvVZhfoerPmP4gAqyFJmL2bT75ZReuHbF8L8iU1VL84MrSPjtZPASYATBsEAs
	MHAk+Kt2prybksIFaGB0pMh8wUg/p9h8z3BGsiQdcH1GnAN4ABhiwtZ3ZHa1V59z
	ILa/og/WFK8qQLrqK7s3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714430781; x=
	1714517181; bh=euHHNw1HiVnE36g36ggJPa3VXrD//XqZAWsQ6yPcvuU=; b=i
	yHCJ8XPsKm9uU6KJM6/Jcu6wfKvPpOBYSk89CCfo4kGLlKo28f9ugpMTvNGLYq4e
	iRBCzJy2DffAFFo5VDAHDJdJvOm2xKI++VHTn26PgmsUyPfFeHgG2FyoloSw6+Dm
	GgZ4PHG3DFsXLpSZL+riVRG9J7Nf+Pw3G/5RwAWqZOkE5LN8b/Zia8c+vqhafsU6
	zyqh0f5GR/eHmaVj+k9CxKZ8Sh7YU0r+30qVMQnQ20TH+ZDaRWUl8b+hdGoVuhfW
	eyTWxYlUfTDWF7eaYnXBsnBeXaQNjxCG+aM3h1PxEbhPx+HaOKvFPg8Amc/s3F4U
	uQCu6ATPvlxp/YebJ83fQ==
X-ME-Sender: <xms:PCMwZltjYc1-VOn7EjLlS8CPbbX4PybnuRXFXKkRmw-i8eEI8bamyw>
    <xme:PCMwZucrlbstn4ZhtwCbPiTe2mHUsy5zV1IshzMVgxR4gEJnajb1ph78gAH4sEP0h
    A1Pcxoj2Xl-D_KSYw>
X-ME-Received: <xmr:PCMwZoyTSaZcmJg6JOEBPgQZI7iwTeEs8m--DeGdySBllnGcPWTrj24vcM1tCkRQpsr2ofpHAPLCXBshDRtiMDmiBdlmJa64SvSim7i8lk8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:PCMwZsMG15lFWGMoR19WsTasYkl0jZs-tMeQ2q-3z_L4uldA4E9zmw>
    <xmx:PCMwZl_XqEKqiMNqitaq88h-HRVcVkHdHR3CnFmwJiXfZLws-rvx4w>
    <xmx:PCMwZsWp3YENqP4a9HDFjjz0Ignbj2BmF1nF3pL5CXZkryR_0A0KZg>
    <xmx:PCMwZmfYITzwHCHVs2XG6ovzCJfQHaVRKcjD60nU3KNqYHJJKyAaAQ>
    <xmx:PSMwZkZeFwsrjCQk3_9ouW4k16aR4GiMov7lE3HBXXaxVPebMgd-BaDJ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 18:46:20 -0400 (EDT)
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
Subject: [PATCH dwarves v9 1/3] pahole: Save input filename separate from output
Date: Mon, 29 Apr 2024 16:45:58 -0600
Message-ID: <1728b8d941d2658b310457b6c59d97f102aaf66d.1714430735.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714430735.git.dxu@dxuuu.xyz>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
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


