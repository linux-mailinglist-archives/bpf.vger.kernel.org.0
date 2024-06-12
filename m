Return-Path: <bpf+bounces-31951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7029057ED
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C5A1F21DD1
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995418508D;
	Wed, 12 Jun 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="a7c31p/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fzZNQ4gu"
X-Original-To: bpf@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611018131C;
	Wed, 12 Jun 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207965; cv=none; b=VbwQ2pUzDRsE88eQLnaRiBYsqbBax6bm7ebIDvrPD8PcTwAKJWm0KgvgN7QEVY5cN+mWisCbTubsc92EBDhKZzG7C1QxjiwYlvuE70rsGjCMdgLEK3GTUTtSnnzT+TdqH+SUhyX9qbFcETSAz2PHArAUAxX41txdQk4E7fFqZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207965; c=relaxed/simple;
	bh=2PxUYPACBB3j7rUnIdYxnpc1oF1HWIXOaQvOgVlJgPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUD89blvN3sp4TsGEezrDXWmebIeuJKs+BnQWSFHrQ/0WYP75fvdRcFfos9iaZr6989XmNhhaJMOG177+wSJJXMXpQ9/9p6z8lVbj1t6f4z4RhTdh1BgGSS7zDfj2RNSuuUex0bLyXjcKAgXt/ZWqZA2l7j/gUs5oQQj+IJDhcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=a7c31p/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fzZNQ4gu; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.west.internal (Postfix) with ESMTP id 3B5552CC017B;
	Wed, 12 Jun 2024 11:59:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 Jun 2024 11:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207961; x=
	1718215161; bh=Br3zSa1+u6JEEPxtcWDYsyp97xOiL5TCThHanNtpu1A=; b=a
	7c31p/lpqkbEFr+tz3/+JKaLQ9UHP5w4Lyy7xGcUIPWza9SeUG2klmcCaby38eh9
	QETVpsPkI6PHABLLnkm6mf9Ee9ZdYMJF/DDU1WeuejDc0HQ8R3oj3GfcDXG8QL9M
	SVchaE1OSVpgBZaOZm3pVo+xTaiYaVwc3IHxfAnaA8lGAU7hJC5sQNL7Wz3dBNue
	RLk4l9c9eykygcy/hiPXhy2zk8xJwYkpyjkkCaqX0znQUfcz0iYaD7o4GDBHjL4S
	93m2zD83wAObhzSwVhvPjDnDF5OMcqwrHm2SIPoVo0PKuNAYdEbwOSS1t/WGshWm
	6CHSYKn/l2/Jfw9Y/nQPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207961; x=
	1718215161; bh=Br3zSa1+u6JEEPxtcWDYsyp97xOiL5TCThHanNtpu1A=; b=f
	zZNQ4gu3cWPgtOFmt716xUnq0qgePSi3LI6nw2kH+eZm+MR3fEZa7Zrh1lQrR3ea
	DoyZQ+e3MRnOhbs1JF0/KwiJU43l8Y9QClVQ0pSyEDTgTp8gae5TXCdd+7XPD8lA
	LK5Ii7anmr7XfftOpi2988MgLFmEXpxrEGDHRgvZzrpmkDJ+AkGnc2u/wa1fApKV
	2/01Z4VHeuyFn7wW1bYLOgcNJEFVcyalb8X5PqYvHlBgowiUcNkjm4e2SrQWperD
	YtrjZrM5kW+4VCUf1raQ1DK6tRWlTPXZFKliy3AIUFaYMr3F3BI29l5NO7AamrSK
	q9lQA+JOPSKk+daP5zR9Q==
X-ME-Sender: <xms:2cVpZq1k7WEkydj9SgoqJ1X_VOwmN801K00kVSTLb39t3ZZQlQOqSQ>
    <xme:2cVpZtFn-RdcibB5sf-JRVZJ7aEQw0BY87H2gFoOH7b3NDkzZayl3q31aKuSN9Io1
    Jy8wVCvqciBk5sZ3w>
X-ME-Received: <xmr:2cVpZi5SgzJ3dWy1MllKuTG-fcTAtyG1s2F24fXsVBWfqSHc471YJFrLr9YxYTB_t-nbJxEB_5qWaS3ShYbz5TbGyvV7S7SCG1ylIxK9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:2cVpZr29Cmn_IruHF7Doi3Ot93o43pzHDMERPny1BGlBC0UhT_stkQ>
    <xmx:2cVpZtFbimwijgBYNz5XOyQq-L1K2_JObnthremH5Enlhw0b4y6b5w>
    <xmx:2cVpZk96-ej0d-eFFy9W4ABrV0CvB4aAgkAAfkLpMuVVAqEBk9pt5Q>
    <xmx:2cVpZimfjQu3ZI-frYpCsFas_d7_WcuURSRtRBQmQcBkFW8gjGjrBA>
    <xmx:2cVpZolgh5RMGbKPRUE0fd-sooWjxrEEg-CdVS5j3abz0t2EdG1EgBEB>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:59:19 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kuba@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	hawk@kernel.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 08/12] bpf: verifier: Relax caller requirements for kfunc projection type args
Date: Wed, 12 Jun 2024 09:58:32 -0600
Message-ID: <e2c025cb09ccfd4af1ec9e18284dc3cecff7514d.1718207789.git.dxu@dxuuu.xyz>
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
 include/linux/btf.h   |  1 +
 kernel/bpf/btf.c      | 13 ++++++++++---
 kernel/bpf/verifier.c | 10 +++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9e56fd12a9f..56d91daacdba 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -531,6 +531,7 @@ s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
 struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
+bool btf_is_projection_of(const char *pname, const char *tname);
 bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 			   const struct btf_type *t, enum bpf_prog_type prog_type,
 			   int arg);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7928d920056f..ce4707968217 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5820,6 +5820,15 @@ static int find_kern_ctx_type_id(enum bpf_prog_type prog_type)
 	return ctx_type->type;
 }
 
+bool btf_is_projection_of(const char *pname, const char *tname)
+{
+	if (strcmp(pname, "__sk_buff") == 0 && strcmp(tname, "sk_buff") == 0)
+		return true;
+	if (strcmp(pname, "xdp_md") == 0 && strcmp(tname, "xdp_buff") == 0)
+		return true;
+	return false;
+}
+
 bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 			  const struct btf_type *t, enum bpf_prog_type prog_type,
 			  int arg)
@@ -5882,9 +5891,7 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 	 * int socket_filter_bpf_prog(struct __sk_buff *skb)
 	 * { // no fields of skb are ever used }
 	 */
-	if (strcmp(ctx_tname, "__sk_buff") == 0 && strcmp(tname, "sk_buff") == 0)
-		return true;
-	if (strcmp(ctx_tname, "xdp_md") == 0 && strcmp(tname, "xdp_buff") == 0)
+	if (btf_is_projection_of(ctx_tname, tname))
 		return true;
 	if (strcmp(ctx_tname, tname)) {
 		/* bpf_user_pt_regs_t is a typedef, so resolve it to
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20ac9cfd54dd..dcac6119d810 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11265,6 +11265,8 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	bool strict_type_match = false;
 	const struct btf *reg_btf;
 	const char *reg_ref_tname;
+	bool taking_projection;
+	bool struct_same;
 	u32 reg_ref_id;
 
 	if (base_type(reg->type) == PTR_TO_BTF_ID) {
@@ -11308,7 +11310,13 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 
 	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
 	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
-	if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match)) {
+	struct_same = btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match);
+	/* If kfunc is accepting a projection type (ie. __sk_buff), it cannot
+	 * actually use it -- it must cast to the underlying type. So we allow
+	 * caller to pass in the underlying type.
+	 */
+	taking_projection = btf_is_projection_of(ref_tname, reg_ref_tname);
+	if (!taking_projection && !struct_same) {
 		verbose(env, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
 			meta->func_name, argno, btf_type_str(ref_t), ref_tname, argno + 1,
 			btf_type_str(reg_ref_t), reg_ref_tname);
-- 
2.44.0


