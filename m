Return-Path: <bpf+bounces-55503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD79FA81B8E
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE7D1B80B00
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1270A1DF271;
	Wed,  9 Apr 2025 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="GpLeRVpd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+c8bGrp"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E11DED47;
	Wed,  9 Apr 2025 03:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169698; cv=none; b=G8gZxKPr7GcK/9qj+TpH6PGk5FAjjD1dBQi3h5vA4j2hnDPfxeK/cCnQbXET8bq88f0c2jjaqHCoDRz1jlTgwXji+/T1rkOFJzZNLtP06jfr4x7qQrLJZ6jVPT5aQ1TZ/KwS2XNCcx2mFQpll9riR8TpbPS14w2ciHhVM4DM9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169698; c=relaxed/simple;
	bh=tTIDYioC2CywEcIZVxd/AbIARbalJ+SKwmjlNlAbe6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oN6IxSR/8iOxYrzzqQ+ZkI2v1oSix/ygojXmBkXmUNxbMMIHNSpJTNdf13AJCRTaUePctwoYzvXsHYtC658KKwjodgy+ctvIenG9gVScPGYKAdLz/FxiIpmLydyYUQQ2M7RUrjbzPmwyXwPlX8jv88tlDFgB5FlrXfpVd8iCmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=GpLeRVpd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+c8bGrp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CA201140254;
	Tue,  8 Apr 2025 23:34:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 23:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169696; x=
	1744256096; bh=HXCkRXU/HBifccFnVoM0wsJm6xU/SN248lJiwoqsy/U=; b=G
	pLeRVpdwR4iY3jXyYMaAqQ/RCdDIIh1HuuWKhu3CsTAW53DRqup7hUHaftJjaJI4
	iuQVP926MULZ31tR3q52dq7dteSZkBWmROo3kxrtg4LJ/8gSAt65ZfWBNBXOiXti
	zp31fHV6gwZUNlOs/Q8thO+st6KQ7NVPqsqvcZpmll7WNHvac/UxX7Pw4h5gbeEd
	IAgs9joiMThlJjER3jYqccCkUETh3rH53+V0P00+pZcRkYltNBZcqzgDCOMiDbWL
	/wQeCVeqxD8oTQLjpInQCi93apHWooakq0ViFPtdyaDOqNM02mhLf7V930ycfxFE
	nogeFV8RLf+xd6zEHWr1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169696; x=1744256096; bh=H
	XCkRXU/HBifccFnVoM0wsJm6xU/SN248lJiwoqsy/U=; b=a+c8bGrpoHPn6Xelj
	CYJ2yoRsbu/6kBuQAAsQ+8/U3TzDOeShqQIR8W9Md8OpbJMBlrcB3yOqmf9k3yeF
	47dn8QEz94QInzLgX8VYy9xRy247qgHaVTc3gEFVWguumUR8O5uSBVwg93yLGJlR
	4vFmJ++0lrqgZI03cQpq58oiRe92LvIk5VvGUEK5ktdRs24fw8TYWIFiE0D+H9Qp
	lSqIqFo4tR+FB61vsoxKrrQV6PpS4Xzg0PTMsV7HUgNrCpP5ZUDSE3RdyuUtj19H
	hQVrSrObXNn9hg7RBZLt9amTRF0Z+AR4GaeHD602spXPit7hFozWMXo2ItqA7jnv
	YdD6w==
X-ME-Sender: <xms:4Or1Z4RWuxgfr_mreEwNcIPfJwkyyosH2TDZhXB90-4jQIKB8omPRA>
    <xme:4Or1Z1yKJFkvqWfrLdtsXkaDifiQHz5hjXfg2Zs7r4MA5tgOSJN-JrwshhVCRL4qJ
    ojWoSXN037yE4SRRg>
X-ME-Received: <xmr:4Or1Z13pDRX3qntWcQXKPqzJn8KZf10tmCFQY5eGo0RjAe6z_YBkfqyFt3sG1aHDy-L7bPHQJ-HrrltDDov-sSMV7eGOF3TNeHQMwjWQZHqFWNB07Lc1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgs
    ohigrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghp
    thhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhu
    gidruggvvhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4Or1Z8BWNYO70FTtCoW5NQxFbVxo7NtnxeGn9NTXK2uj_ZcdqBisoA>
    <xmx:4Or1Zxg06n5omQ4kGI8PVPnMKYmfEOzLr13RiW1wnpnBrihEw9VMsw>
    <xmx:4Or1Z4pajMusTAiV3VxnkJmbsUHu9BN23Wt9cbllKuVb-U3Nag148w>
    <xmx:4Or1Z0ga8FkCjlimD2Wl9lPuKNnHg4JSQfnOY0pSeCm2gkkyJoBDng>
    <xmx:4Or1Z_ssOLqBaRq3JrVmAtqVwSz8rapICwXj85o1g6zxqcKDdFr5GsSU>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:54 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
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
Subject: [RFC bpf-next 10/13] bpf: verifier: Add indirection to kallsyms_lookup_name()
Date: Tue,  8 Apr 2025 21:34:05 -0600
Message-ID: <7540678e9a46c13f680f2aacab28bb88446583f5.1744169424.git.dxu@dxuuu.xyz>
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

kallsyms_lookup_name() cannot be exported from the kernel for policy
reasons, so add this layer of indirection to allow the verifier to still
do kfunc and global variable relocations.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/core.c     | 14 ++++++++++++++
 kernel/bpf/verifier.c | 13 +++++--------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 44133727820d..a5806a7b31d3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2797,6 +2797,8 @@ static inline int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 }
 const struct bpf_kfunc_desc *
 find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset);
+unsigned long bpf_lookup_type_addr(struct btf *btf, const struct btf_type *func,
+				   const char **name);
 int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
 		       u16 btf_fd_idx, u8 **func_addr);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e892e469061e..13301a668fe0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1639,6 +1639,20 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 }
 EXPORT_SYMBOL_GPL(find_kfunc_desc);
 
+unsigned long bpf_lookup_type_addr(struct btf *btf, const struct btf_type *t,
+				   const char **name)
+{
+	unsigned long addr;
+
+	*name = btf_name_by_offset(btf, t->name_off);
+	addr = kallsyms_lookup_name(*name);
+	if (!addr)
+		return -ENOENT;
+
+	return addr;
+}
+EXPORT_SYMBOL_GPL(bpf_lookup_type_addr);
+
 int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
 		       u16 btf_fd_idx, u8 **func_addr)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7e84df2abe41..080cc380e806 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3131,11 +3131,9 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		return -EINVAL;
 	}
 
-	func_name = btf_name_by_offset(desc_btf, func->name_off);
-	addr = kallsyms_lookup_name(func_name);
-	if (!addr) {
-		verbose(env, "cannot find address for kernel function %s\n",
-			func_name);
+	addr = bpf_lookup_type_addr(desc_btf, func, &func_name);
+	if (addr < 0) {
+		verbose(env, "cannot find address for kernel function %s\n", func_name);
 		return -EINVAL;
 	}
 	specialize_kfunc(env, func_id, offset, &addr);
@@ -19707,9 +19705,8 @@ static int __check_pseudo_btf_id(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	sym_name = btf_name_by_offset(btf, t->name_off);
-	addr = kallsyms_lookup_name(sym_name);
-	if (!addr) {
+	addr = bpf_lookup_type_addr(btf, t, &sym_name);
+	if (addr < 0) {
 		verbose(env, "ldimm64 failed to find the address for kernel symbol '%s'.\n",
 			sym_name);
 		return -ENOENT;
-- 
2.47.1


