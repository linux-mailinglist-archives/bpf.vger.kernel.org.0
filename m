Return-Path: <bpf+bounces-50277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C38A24BB6
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 20:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E2D7A246B
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15761D618C;
	Sat,  1 Feb 2025 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="u+wD2Hfp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FbQ+XNgB"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B71CCEE9;
	Sat,  1 Feb 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738439910; cv=none; b=LV3pmrWzkBBKOi8131r/cVu21bh6vTmJRU9iXaEkHV1RHvCz8KZEjXRZFE/WNTIIJCU6x99PV6QClTAnV5t12btMexI8sUxgkNZBo4P+cbqOt/6JSNCnF8itBnLLgyQlZhZz7cVSNFlxPrW2jkAzc4YNfF3nq5RuKMebblSl09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738439910; c=relaxed/simple;
	bh=iOpBPMg0Y80kUJFtVAQ41yIvl4tFe+qff8uOgiyoK2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoFDO4Hvk5yd+GOzaXn60vtzcl2jb+ShP65gC84uzNo6LV7okl5tad3QT+MESHqZZejbry1obp+aKNgBvQseLpQpXUxFcyUtiYHaigQ0OIc5zqMpfpexmP1KnAe58fBgP/5l0WCjjMfBTm/Fh83K6d6K7ORKvLHGizwHUzIaKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=u+wD2Hfp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FbQ+XNgB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FB4925400E7;
	Sat,  1 Feb 2025 14:58:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 01 Feb 2025 14:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1738439906; x=
	1738526306; bh=yiGGo8fB3LwFwVag32axPX1KZztzdGS8G2RAFe7mLJ0=; b=u
	+wD2Hfp6eDfzb0rt19QIaqrIn2B9qOu8E5Z1QycpMNpE9KJ1sGT8sgR+Aaq8zmE5
	AgqrKtRDdi+Z5qvPwtpVBHn9a1p/hzRHkrGHEd/enq/KUPLpCtts7KwVHCHECxRg
	IOYO88qPW3IzzcCC5PNZlx2guIX0KyuuTaGBosYb6Cp/zJMEEGGp+QO/doXEKnBm
	LnmiFDsQCX7M+VkdZTz10sFp1XxPckJjvGiICMwfLQORnmLNSW5yJ/BQ4q7bahwh
	rTRNJYUTkA3E+8dzKN3OH0VRpgV/ZT6eFBqNAflCtG1utCEQUxDFFgW+kgV4P7qD
	c0V368fOKecFUJYMHEbWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1738439906; x=1738526306; bh=y
	iGGo8fB3LwFwVag32axPX1KZztzdGS8G2RAFe7mLJ0=; b=FbQ+XNgBxQYTiDDha
	fUOCQSm99d1ghx6l28cRHNjDzCXRDeE6HysE0t5KMChXxqFwEpHHU6fzM8s2UhXB
	t3t/rDqrNVrLzEPrydlZxx3fr6Kbd9qnB01Ub2+tgkmGNXxJYyXxG083wdnAeI8z
	ZuhZHxbq10+wILCQF+bXUYf86iOlOd3EG9ZqZR/6Ljdd4vt+11AeD5BtglnezeRd
	IQI7ANLU/HomTeJDs8VUgHviw7iizGotGvJ4KTBLWoZJ38eoaQeaERjzKPVUumOU
	Vr9mA2ZSOCH0enccApHS7p251S1YyDn0uClUqzzWlLE4FAuzKAPk446QhIo4IO7g
	GOoAw==
X-ME-Sender: <xms:4nyeZ82pBMA49rO1qwpjgLZdnpUlj9Ls-aXOJjebHsSQiMH0kbDr8g>
    <xme:4nyeZ3GWfIlEki4t1WY0Z6do5qHZjsf3IA0n7LmkZ88vomtwLOAs7kSbrISBeFlUJ
    -pE-2UhEqOwcXwuNQ>
X-ME-Received: <xmr:4nyeZ07swR5z1v2DrP5CoDJE04t3qyf7jV6We20KfbSs9ow4y16Hoh56vZ5BRJIfvpjeUww9x5SbAhoF47HOFyJ0TwBAsgzRDkGQX1vagEjTteiN87EW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihuse
    gugihuuhhurdighiiipdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoh
    eprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtg
    homhdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphht
    thhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhig
    rdguvghvpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4nyeZ10dqxMMAb_EvvHdBDGuIE5iXpMDJZUdygTdcZODVq6cg4du5Q>
    <xmx:4nyeZ_HSPBCmtte-DWU2nczVg9ovbFecLhlber7YY1B9Iqp12uPb1A>
    <xmx:4nyeZ-_yfIQpoU0bq8XlFtc29Oj8ePY5FgOV-0l25i9RfqYxHEvZ2Q>
    <xmx:4nyeZ0m7Z1Sog8mS0DDS4WyS9s35H85zuARRDiZqocd2lHImj4V0xw>
    <xmx:4nyeZ1Xj8kMD54v-YI5pNI42QSPNAxsPM5PdZUuGROuMzDo8Lvc1lESQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Feb 2025 14:58:24 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org
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
	mhartmay@linux.ibm.com,
	iii@linux.ibm.com
Subject: [PATCH bpf-next 3/3] bpf: verifier: Disambiguate get_constant_map_key() errors
Date: Sat,  1 Feb 2025 12:58:03 -0700
Message-ID: <91d84512b4082e5eb095b31e5536944a3d53f0eb.1738439839.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738439839.git.dxu@dxuuu.xyz>
References: <cover.1738439839.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor get_constant_map_key() to disambiguate the constant key
value from potential error values. In the case that the key is
negative, it could be confused for an error.

It's not currently an issue, as the verifier seems to track s32 spills
as u32. So even if the program wrongly uses a negative value for an
arraymap key, the verifier just thinks it's an impossibly high value
which gets correctly discarded.

Refactor anyways to make things cleaner and prevent potential future
issues.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e9176a5ce215..98354d781678 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9149,10 +9149,11 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* Returns constant key value if possible, else negative error */
-static s64 get_constant_map_key(struct bpf_verifier_env *env,
+/* Returns constant key value in `value` if possible, else negative error */
+static int get_constant_map_key(struct bpf_verifier_env *env,
 				struct bpf_reg_state *key,
-				u32 key_size)
+				u32 key_size,
+				s64 *value)
 {
 	struct bpf_func_state *state = func(env, key);
 	struct bpf_reg_state *reg;
@@ -9179,8 +9180,10 @@ static s64 get_constant_map_key(struct bpf_verifier_env *env,
 	/* First handle precisely tracked STACK_ZERO */
 	for (i = off; i >= 0 && stype[i] == STACK_ZERO; i--)
 		zero_size++;
-	if (zero_size >= key_size)
+	if (zero_size >= key_size) {
+		*value = 0;
 		return 0;
+	}
 
 	/* Check that stack contains a scalar spill of expected size */
 	if (!is_spilled_scalar_reg(&state->stack[spi]))
@@ -9203,7 +9206,8 @@ static s64 get_constant_map_key(struct bpf_verifier_env *env,
 	if (err < 0)
 		return err;
 
-	return reg->var_off.value;
+	*value = reg->var_off.value;
+	return 0;
 }
 
 static bool can_elide_value_nullness(enum bpf_map_type type);
@@ -9357,9 +9361,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (err)
 			return err;
 		if (can_elide_value_nullness(meta->map_ptr->map_type)) {
-			meta->const_map_key = get_constant_map_key(env, reg, key_size);
-			if (meta->const_map_key < 0 && meta->const_map_key != -EOPNOTSUPP)
-				return meta->const_map_key;
+			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
+			if (err < 0) {
+				meta->const_map_key = -1;
+				if (err == -EOPNOTSUPP)
+					err = 0;
+				else
+					return err;
+			}
 		}
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
-- 
2.47.1


