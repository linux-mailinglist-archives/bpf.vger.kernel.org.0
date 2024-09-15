Return-Path: <bpf+bounces-39914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C6F979458
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 04:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EF4281CA7
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2024 02:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AD2D2FF;
	Sun, 15 Sep 2024 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="M6zI7PDB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjF2QSM3"
X-Original-To: bpf@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F438F49;
	Sun, 15 Sep 2024 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726366291; cv=none; b=YAkB3Xi8H1vFRkREYOPJ4j0CgV4srYslNkDCl+mlhvDHwoeGrQYO3wPh7gWD7y5T08MreC05cw8mhsacH78mOpmqYyqj6Ud5idgfZo3eX23cVLp95x8iigQsbbDv2uCKS3PCJTkrJm+1zTlRJb9TTmJTU3KJ57vxZffLVVQb6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726366291; c=relaxed/simple;
	bh=2I9Pk3oKd1JIpM2WDUNQbhw5iX+9J9DK6KWOPDVqBlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqUWOmgifO7quL0oHij5rJjIMocU55HLrUoVE/KVqqeFufZhQZTsWaVGtODbrYxXl9HCdUFQ9+mIST3soeNuERfonDyWr77k6tjiaI65YzJXnheDO9mUNjK2IgR8i6b1BVkj06v4JEcmTbqrclWGJyZUjyyeV3zSIEnEksy0lj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=M6zI7PDB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjF2QSM3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AAD4E1380261;
	Sat, 14 Sep 2024 22:11:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 14 Sep 2024 22:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1726366288; x=
	1726452688; bh=0JULU38YKiGhwgv9FdaunOkEi9F+OYarXOVhKIE8ef8=; b=M
	6zI7PDBy3/XwCv0RmmsVuC+eL8u3RkohWrHb1OLy8GbcQVInrwcUQn8whMkwKKab
	DIlLh6uQPUzrHhfBa1fENXdL+LDChCCstCJ2VDIYhOliPulVYj/z32/ugnUBRJ2F
	ZbaEJ3SXiG77d5SxP9rUpwXES53r0ipB5nf8MFzGoSZ+Rbr8+TSmi9qoQ0nGjdle
	tKG98p2lbz/Ga8s42tTihxB55oCllMkwUPnjc6flEtVutiUl75QHn/YUi8aruxRS
	V2K7LyOi1bGoCFLz9DXtwMUtDxtNzowwcQ5RXqh3T3qCqMxrCEHecUY4EWIGwdIu
	DTRR99zbgzMN5rcuAHfQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726366288; x=
	1726452688; bh=0JULU38YKiGhwgv9FdaunOkEi9F+OYarXOVhKIE8ef8=; b=h
	jF2QSM3wRAZNdE+kwsuTm53Sdb9gJpzGVS7OuUVCqlwvTC7BpfLBKQUGjaAQJd75
	PlAIexi36G/gIfaoPLej9WTrN9W8jcp+5z5o7F9kReflkKgmRSHLeG3oI5WffbhY
	J631QJrcDE+IIF0AMC1aXpTBW+B3YbZhbGqi2AzBf9TG3PWzEL+tZFUbIxauUl6H
	DcrDq3N5AS9AXewt+06Fl/+NjA7qbc1x5IEGUddtHv0Cxzo4slbacKWgp0zYul4/
	s8E7pQRu73yAiBtbxMismh6xM/JIlLKhXedSACKiChcq8WhJbGsziEbLYPr5L7FG
	3FAFjkOOJbu7FOa1iyvyg==
X-ME-Sender: <xms:UELmZm2WfdwGQFP3SGVN0v4L5MYAetX09OGY1kGyUNTEuBTpgrETlw>
    <xme:UELmZpEWETGzyQmxjcYaR--1ywwNGpxQ9B1YZOIv9Tz6u1frg_yjCLvqSE_qufw8o
    R6j0srx3MK8SuD2Tw>
X-ME-Received: <xmr:UELmZu45mcGgQMiA8IR9nf5BeS20izaOyZS6y3glZVCwd4U9igMhzOAX49AWtGs_AyEZDpK682j2rC5kMuYClz6AyTEPerjSyR1UUAHAbu3OtdxbW2xf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekuddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhope
    grshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthht
    ohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidr
    uggvvhdprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UELmZn3qlCjNh30pPkki5XFsdGZVV1Q2pzkwejD9chZWqfyjtxCwpg>
    <xmx:UELmZpHpk98xTTMIKKrwN8uxvHUYo4hXA-q-yPyOOKumL2y2QoOFSA>
    <xmx:UELmZg9VZaZYBBKEjNpVZDvDZtHbrmsKbfrDokZE7iRv-NL5J4jAGA>
    <xmx:UELmZulCAsKhvugSGmTpIsmyzB6P4Y1ccRXKAO7n4s4W-Lv1YVLSLg>
    <xmx:UELmZrFnjtZpGijtn1l63Lkm1j6Qf100A6tTrKbxkM6OEl3jYjnB3Fd8>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 22:11:25 -0400 (EDT)
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
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: verifier: Support eliding map lookup nullness
Date: Sat, 14 Sep 2024 20:11:11 -0600
Message-ID: <25457cde1da9a4d387fdb3ee4628cd5a4ca97590.1726366145.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726366145.git.dxu@dxuuu.xyz>
References: <cover.1726366145.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit allows progs to elide a null check on statically known map
lookup keys. In other words, if the verifier can statically prove that
the lookup will be in-bounds, allow the prog to drop the null check.

This is useful for two reasons:

1. Large numbers of nullness checks (especially when they cannot fail)
   unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
2. It forms a tighter contract between programmer and verifier.

For (1), bpftrace is starting to make heavier use of percpu scratch
maps. As a result, for user scripts with large number of unrolled loops,
we are starting to hit jump complexity verification errors.  These
percpu lookups cannot fail anyways, as we only use static key values.
Eliding nullness probably results in less work for verifier as well.

For (2), percpu scratch maps are often used as a larger stack, as the
currrent stack is limited to 512 bytes. In these situations, it is
desirable for the programmer to express: "this lookup should never fail,
and if it does, it means I messed up the code". By omitting the null
check, the programmer can "ask" the verifier to double check the logic.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7df5c29293a4..5b5ae3c1a456 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -282,6 +282,7 @@ struct bpf_call_arg_meta {
 	u32 ret_btf_id;
 	u32 subprogno;
 	struct btf_field *kptr_field;
+	long const_map_key;
 };
 
 struct bpf_kfunc_call_arg_meta {
@@ -10414,6 +10415,45 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 				 state->callback_subprogno == subprogno);
 }
 
+/* Returns whether or not the given map type can potentially elide
+ * lookup return value nullness check. This is possible if the key
+ * is statically known.
+ */
+static bool can_elide_value_nullness(enum bpf_map_type type)
+{
+	switch (type) {
+	case BPF_MAP_TYPE_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* Returns constant key value if possible, else -1 */
+static long get_constant_map_key(struct bpf_verifier_env *env,
+				 struct bpf_reg_state *key)
+{
+	struct bpf_func_state *state = func(env, key);
+	struct bpf_reg_state *reg;
+	int stack_off;
+	int slot;
+	int spi;
+
+	if (!tnum_is_const(key->var_off))
+		return -1;
+
+	stack_off = key->off + key->var_off.value;
+	slot = -stack_off - 1;
+	spi = slot / BPF_REG_SIZE;
+	reg = &state->stack[spi].spilled_ptr;
+
+	if (!tnum_is_const(reg->var_off))
+		return -1;
+
+	return reg->var_off.value;
+}
+
 static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 			    const struct bpf_func_proto **ptr)
 {
@@ -10511,6 +10551,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
+	/* Logically we are trying to check on key register state before
+	 * the helper is called, so process here. Otherwise argument processing
+	 * may clobber the spilled key values.
+	 */
+	regs = cur_regs(env);
+	if (func_id == BPF_FUNC_map_lookup_elem)
+		meta.const_map_key = get_constant_map_key(env, &regs[BPF_REG_2]);
+
+
 	meta.func_id = func_id;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
@@ -10771,6 +10820,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				"kernel subsystem misconfigured verifier\n");
 			return -EINVAL;
 		}
+
+		if (func_id == BPF_FUNC_map_lookup_elem &&
+		    can_elide_value_nullness(meta.map_ptr->map_type) &&
+		    meta.const_map_key >= 0 &&
+		    meta.const_map_key < meta.map_ptr->max_entries)
+			ret_flag &= ~PTR_MAYBE_NULL;
+
 		regs[BPF_REG_0].map_ptr = meta.map_ptr;
 		regs[BPF_REG_0].map_uid = meta.map_uid;
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
-- 
2.46.0


