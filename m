Return-Path: <bpf+bounces-49332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD58A1768B
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 05:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E31169CC2
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 04:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED41419F13F;
	Tue, 21 Jan 2025 04:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Vwq7Usiz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sb+iRa5s"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7A183CBB;
	Tue, 21 Jan 2025 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434132; cv=none; b=sY/4v81Sn+R80ifbQ6/2Fr6a+U6WfGAj2QmogNWr/LmVoZUF507n9SkEznckNw0wsSEa0aI0bPjlS20f3WVB0QphxKSBx1obp7Rlqeaqlokb48x2OAkTII0oCZ+eO/43UuSEnhX+fd7etJeE+xybs3fyrnLnBK04R3nhRCc0OoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434132; c=relaxed/simple;
	bh=QkLoGrfKx1lD/I4UPNL0Gan5ka9GlqN3cHU5jJH96T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otjnaKZoLsbS0/zyk6H6AuMRM6E6fBFkuu10L0qumjXRylJg4oQ5i7sWxOvW+ZNeghWp44sGq4wvqI+nUfXTHFUi06NeeJ34jJIyvmYlhZjP2bPRiw75dZPyGxHJiBTrb+H3oDOlIf9beMqaFJyaMTRZm+4r22h1j+lhKcSc62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Vwq7Usiz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sb+iRa5s; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87D021140214;
	Mon, 20 Jan 2025 23:35:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 20 Jan 2025 23:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737434129; x=
	1737520529; bh=SZAXs5yTdoBGR6ZQCG+nPO0VZEYRp0DNDrMb+3A1LUA=; b=V
	wq7UsizgmRSAtAhP6fsx+fRn9f4QQtEpJUJrl0kjhRuonIfXn76GUx2AAW6ICs7X
	T3pNHjebJM1c7z6Qkb4cFQ45OsQ3SevP4l91jPaXLdrgYSvkUwDMzSUkPkSajv+0
	/kMDXolyXK/dwF3noYOtvkT9DNAgK2ToChQqAOFspg/i91J1N+cW9kBamIMHGUkF
	iNlEEjLPJ11TH8h3fM2IKFVoPHYlkGQmK8vdjm4Hao/CRRJ4FKFeGtI552gPVi5V
	KPd/Svu6S04dfPgwHO9mUkqTxZk4yGLpEKBoVzTv6sbM98SJZ5j0qnjMgV0L3CfV
	w6+GVc8FwddXfK6MI5UJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737434129; x=1737520529; bh=S
	ZAXs5yTdoBGR6ZQCG+nPO0VZEYRp0DNDrMb+3A1LUA=; b=sb+iRa5s4Qvuz6BoR
	5aQkypxCsK2zSg/9tipHtE6yLMraYZPaeSuBn2c0u9Wecn9i1EPiEYXnRuNztUeZ
	4cIvxdbnPpjUQwZwsjIXm7Jenid8CGLmCkjCuaEnzoqSB0OyKlCiUQQpRxXLqEhF
	p/NTa1fKxpnSa0UwyHQ00DKtnGJfk1gD2ZJ3+DTA7H9TLM3Rzv+PWWOPjo9/d+mt
	kNKLUQcb+BB9zC5ikKY3iQ/fzxK513fR/ZVD6jeY/nWkAUqvE0ln9Njxnm4w2iyj
	CYis8o9B9B0BWxTydpoRLW0D5sbfJTWNWCrbDp9hUoF1Fyo3E61rRI8pHFSvKgaK
	g6Czw==
X-ME-Sender: <xms:ECSPZ6wWKDlKSGSbxMVAkNsp3I8g8GrkeFWCxjk0Bn7tC0Yj9hf_qQ>
    <xme:ECSPZ2RL9rAtaar30JCfF2wu7lf0dmJShbFF4koFO5lD43r6w-Nui3U-4gt2T94xf
    63k6MhR13rcHqPN0w>
X-ME-Received: <xmr:ECSPZ8VJKtBkZkJFmRzjtsr-60TSOPNLE0__vJjlL8BM9ZavDr4UrFX5EmHH7ZBGzNjJKV-dnZ_Y5IIy1wWeVTqGBoeFh-Lw7083FbCPlZpmi42upJtK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejtddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhope
    grshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthht
    ohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidr
    uggvvhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ECSPZwjTx7wDDz0HpeiXNtNqs-aKkqOWSUtW4f78Waw74WddBtRN0g>
    <xmx:ECSPZ8DOUaCJZAz4VyIeskl5lz7DxnZe6Y27as6IyTOzY2vGqHWFEQ>
    <xmx:ECSPZxIkfFw4vSwM4x_XhgnpYmOLAv9b_-O2XBxHF5cG5VEONmHtbQ>
    <xmx:ECSPZzAZeTjB1EODm_FJTKq719H19jwYZxgqGue-OzTmW6mNQvGedQ>
    <xmx:ESSPZ0Z30SvZr5NMegwPltjaMSHb8zmKW1kFZEnhECRpAf26A9lT7LyY>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 23:35:27 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/3] bpf: verifier: Store null elision decision in insn_aux_data
Date: Mon, 20 Jan 2025 21:35:10 -0700
Message-ID: <222efbc63de2519fd345e558cf27649220ccffa2.1737433945.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737433945.git.dxu@dxuuu.xyz>
References: <cover.1737433945.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save the null elision decision from verification so that it can be
reused later during bpf_map_lookup_elem inlining. There's a generated
jump that can be omitted if the null was elided.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf_verifier.h | 4 ++++
 kernel/bpf/verifier.c        | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 32c23f2a3086..1bcd6d66e546 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -515,6 +515,10 @@ struct bpf_map_ptr_state {
 	struct bpf_map *map_ptr;
 	bool poison;
 	bool unpriv;
+	/* true if instruction is a bpf_map_lookup_elem() with statically
+	 * known in-bounds key.
+	 */
+	bool inbounds;
 };
 
 /* Possible states for alu_state member. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 74525392714e..e83145c2260d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11265,8 +11265,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (func_id == BPF_FUNC_map_lookup_elem &&
 		    can_elide_value_nullness(meta.map_ptr->map_type) &&
 		    meta.const_map_key >= 0 &&
-		    meta.const_map_key < meta.map_ptr->max_entries)
+		    meta.const_map_key < meta.map_ptr->max_entries) {
 			ret_flag &= ~PTR_MAYBE_NULL;
+			env->insn_aux_data[insn_idx].map_ptr_state.inbounds = true;
+		}
 
 		regs[BPF_REG_0].map_ptr = meta.map_ptr;
 		regs[BPF_REG_0].map_uid = meta.map_uid;
-- 
2.47.1


