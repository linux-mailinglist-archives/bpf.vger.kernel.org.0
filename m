Return-Path: <bpf+bounces-31665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE37901397
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 23:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E52EB21E57
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C255884;
	Sat,  8 Jun 2024 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="k2Mr+Pym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bOo9mEU6"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87F15EA2;
	Sat,  8 Jun 2024 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881413; cv=none; b=RXqr4e3eJYElIGopSMvSbIdj1UK9ORTqHezCnBeEukN0/drfP3CjtPHUDQHbszUb5+F4zIKHSLL6oVpdoPxSfg3pW+SKABDyN27QRhibT0E63pclBHBu0qFymtnQxz4GfIRHz8bRZda12/xYzkBRkkfAsobIEHeTIBUEQpvu0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881413; c=relaxed/simple;
	bh=oZVk7OcZLn78TEsK/Tv+mE4vVgftTWhMblLRODMmDdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzWn5xi6xmZ+bIpKLS9hOfelWVZdpPaKwkRH5bwso/FYNGkGoepuc9zRlQQkINFz/MfbUaAhgSXDdsBFbLfANgVs6doUlpdWCxzmfLJ3HeMJyzKMB2QGQENeWXMYOPK44EsQvjqFhsUmjwBAkx38fkapJNI4sGrQSS2iMehRx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=k2Mr+Pym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bOo9mEU6; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4F59C180008D;
	Sat,  8 Jun 2024 17:16:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 08 Jun 2024 17:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881409; x=
	1717967809; bh=Jpevwhj99iE9aQa9agLdQ7m/XajfHuUGhGYbM7gqMgk=; b=k
	2Mr+PymiEGt+rrLrv1TuwO+gPXjnShkOooz3dpCCf4kZLZWUz6CYQO71qJPEiXkf
	BHZo72zxleukCoqdOqKYD/NKKC9GBp9kp4WEtBsr2MqPcZcPglfYecqHoF8tMg9N
	vbi1rBmBTXBkirlw/nshEb0Z1JtlvXuxS8v2D+va4AuPlAbmr2LHMVBZgc+6KnKu
	HfNDfQf8WDNmGjjZo+itPOXkn1lPRR16D3Dp5TJxtMvE1bIvVjCUr8c8DPz0QqSD
	8tDod3a8/pTWlT23WQsTjQsFnd5DHVbNfs+ieDqL+oIK+uRjR4IQQdX3iPP86Gbc
	BibuVHvDPNg/WeHng6O1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881409; x=
	1717967809; bh=Jpevwhj99iE9aQa9agLdQ7m/XajfHuUGhGYbM7gqMgk=; b=b
	Oo9mEU6cy3tAuqJTT29ct5LDjAjHqcY1Ursoc6ujLcQW6vjUH+srowEovwbjU8if
	zb3/0zwmh7YN2HWxXrZIwqwqDt1yewqKWBi5e3EXOqmZmdUdjuvqYRUaA3b/ILi8
	cW1qqin+BITe4Tivvy5bvxcEk2RZUjCgWen0F2Mafi9rxPTQ+r3NTYzd6XWCzOQj
	HwVyibMkq+Vjt6vZssRaAzDe18PeXOM/ojSQ5zKzFIspcRRo+Z4eT2oaHrtL9886
	J5cVuEZIUCKam145ndUenALTaanGD3X43rZUC98ATFXG/wk+BRqOaPgFwKVqYrAL
	eBJLbbnfqt2BCn3FF0O7w==
X-ME-Sender: <xms:QcpkZosKOW0kpsP0b4bwubsgQlT0-3wR3T-2izb1Jr8Q1sFBe5eWrg>
    <xme:QcpkZld73EpbMD5S55aX_xj2srSnP-wOzaqgQ1euG8a5_WDj7ynWzSYlihLljusdR
    Fc09ScFbdpgRpO4tA>
X-ME-Received: <xmr:QcpkZjwGRRQdp-_Tw2ZCokhCEG1HVln-vRi0F_WBzNrfbxaO5VJuOXXAIRM5olmh9rU1j9Hol4Y69v4NS43jHnaI1hQIlLloGjVt1096>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:QcpkZrP7MLEinOE2g5nxlc8dfKfmrzMxzYvJHf5pkh4v7uHBCmhLJg>
    <xmx:QcpkZo_BRfP8i5E5RoC_uDis2ut8J8kjfjUo5KVbE9ui46nNaKGwuw>
    <xmx:QcpkZjWAVDMPFH79rBEwR4ns8aXqVlWL5jdJifkv_p1btQUMSPdIxg>
    <xmx:QcpkZhfGo18EerVxfceggFBvGUw0aEt2wCGzMiN_eVllMyqGnwaiMA>
    <xmx:QcpkZjgNSbXlg44ISPgohhRDAV2GrpdDf69h-mrseLT588Krb97Iqt9N>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:48 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 08/12] bpf: verifier: Relax caller requirements for kfunc projection type args
Date: Sat,  8 Jun 2024 15:16:04 -0600
Message-ID: <e172bf47f32c6e716322bc85bb84d78b1398bd7c.1717881178.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717881178.git.dxu@dxuuu.xyz>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if a kfunc accepts a projection type as an argument (eg
struct __sk_buff *), the caller must exactly provide exactly the same
type with provable provenance.

However in practice, kfuncs that accept projection types _must_ cast to
the underlying type before use b/c projection type layouts are
completely made up. Thus, it is ok to relax the verifier rules around
implicit conversions.

We will use this functionality in the next commit when we align kfuncs
to user-facing types.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 81a3d2ced78d..0808beca3837 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11257,6 +11257,8 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	bool strict_type_match = false;
 	const struct btf *reg_btf;
 	const char *reg_ref_tname;
+	bool taking_projection;
+	bool struct_same;
 	u32 reg_ref_id;
 
 	if (base_type(reg->type) == PTR_TO_BTF_ID) {
@@ -11300,7 +11302,13 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 
 	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
 	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
-	if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match)) {
+	struct_same = btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match);
+	/* If kfunc is accepting a projection type (ie. __sk_buff), it cannot
+	 * actually use it -- it must cast to the underlying type. So we allow
+	 * caller to pass in the underlying type.
+	 */
+	taking_projection = !strcmp(ref_tname, "__sk_buff") && !strcmp(reg_ref_tname, "sk_buff");
+	if (!taking_projection && !struct_same) {
 		verbose(env, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
 			meta->func_name, argno, btf_type_str(ref_t), ref_tname, argno + 1,
 			btf_type_str(reg_ref_t), reg_ref_tname);
-- 
2.44.0


