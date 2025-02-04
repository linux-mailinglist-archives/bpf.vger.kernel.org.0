Return-Path: <bpf+bounces-50431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAFEA2784B
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9B63A35D3
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F3A21661C;
	Tue,  4 Feb 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="UVL76gCq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STgqa6v8"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A47215F78;
	Tue,  4 Feb 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689943; cv=none; b=P+ZvivVO8MK9FYwpn83AVRzRiMstmMzcMB9ch+eWBQxJUbM0xYCZbewKlFBzSBgNG/eE/Sz3djrxSrwYk3jn7uoh2INT08ukTuYDpX6Xsinypam3UK11g5hUobzvIFzoSnsU7P3S4xhEHQpezDIm1W8TMqUbT8eGK/8l+C9R+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689943; c=relaxed/simple;
	bh=X2iZc74g9FmBqjjBOp1gwKw93ZIjLPNar98x36QmGbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/uewrD/wnNZNssivJQFgUzrqZeYcpAg4g+NlIZiHgLGe8K3HHZVaF8kShgzfvlhLs7lCdfA59I2HQzlPVRXRdyxGm08Fb1t+xWdHrPrpmnHQKwSEpE29U7ZP4lFUcqR1kA16jgJ2op2MUL5ZMM900jhwB5lMcgX5AG1ufjsSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=UVL76gCq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STgqa6v8; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A1CD81140114;
	Tue,  4 Feb 2025 12:25:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 04 Feb 2025 12:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1738689940; x=
	1738776340; bh=n1ahgXxw2VuMgbeYCU9uLtfD9o0+1n2rzoTvatTJ2gE=; b=U
	VL76gCqzL8Vic2HIpvRZHy8efN2Hmuck/PCUw6kECmaR7FF/kVN9yH2mXW4F3maZ
	JMXiAt+u2Sxq1shzTAAHzbzPQqElOSxBgYLh3bRIpf8q+XrDgzE6meRcJlvCrAwk
	oMA1va9leKJWkTqQvf1oJhJLwKEumejx07XH8jqwt/tbqlO8mavxiUrwqRos0OzE
	t4Cwjwqd19ibdy0/O5f/Hh6hX4a5msQ6X1mzXPrX4J+nB0s3kGjgl3YhfAftrZP6
	mtSbYGTK7fdd1f8eqdwYB4jkKAQ7vjPSLkFJWRpL1X1jw94ks07h2ORJQYqKR63O
	EPMecpRgau41h3Otf4sXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1738689940; x=1738776340; bh=n
	1ahgXxw2VuMgbeYCU9uLtfD9o0+1n2rzoTvatTJ2gE=; b=STgqa6v8okm11kn5H
	CzKKsuTx9llnMJRrMCTwt3P0BDt4K+gN4DS/qL9w3bc91xRokKwBq+TRroas/G3o
	IpmJkvoYlU96IKbUDaSgyaUVYaXrJ9JM0pOxP9jGj25GupQXvXJtrZqLcGeXOFf7
	i1uucpzB+9WSPdbVJT2Lg3eIkh5OQ1toAOv14hbAvRuP303ehG32DBLWpl6aN5Vb
	z9pWi81mkTbMOytT123unbgSurfuq0M9RaUCaue6A+WrWi6s3qa+bvQxvOAEJcv/
	asDzF9KctEoj4tENnysuDYYnkN39Y/aFdbaHZUUjmV8Y2MgB11MGolJl5Nw9Ui8j
	7wGiA==
X-ME-Sender: <xms:lE2iZ3M9cVVc3aQC5DaeWCTPYSfXpk05nbY_E71yOi17BSRgW6tX0g>
    <xme:lE2iZx-YZsbahfzpw4aUrM__bskh4EztdZdgRdgl13VaK-c_hSBJVMZcQLX13yVt2
    rFazb7yJOpeG0Ekew>
X-ME-Received: <xmr:lE2iZ2T3Trx7nMGCj1L8Q3b4rM9rBmXF9MFv3XhykriwIK_-AUX4WyDSn-jCgDApdXcoUlXPWHSapODuXQFTrd9jhHyLGrgHrzslOry6jSpTtPPIKvUh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihuse
    gugihuuhhurdighiiipdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivg
    hlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprghnughrihhisehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtg
    homhdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphht
    thhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhig
    rdguvghvpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lE2iZ7uZ9iwHPUquixpl3JSgp7ey0Ia0mKggSu2DKyLaEM8pUDkk_Q>
    <xmx:lE2iZ_c6xdH1UAk_GNcf9awx0jicEqVYvfAhSFQBZGP19-6JK0mMCg>
    <xmx:lE2iZ32hjpI_7aqUPk6pVOSRqhhASHxVWw42jdy596ZsgCbHKZaosA>
    <xmx:lE2iZ7-hqkMWCUwnDULo5C8aFPzVW9jIU_PDOEoHWPZ70jqeSWGu-w>
    <xmx:lE2iZ6ucH0y8goHBBj8nxr_8DbbNaD6F1-3110DLin2FFLRTTvK0m2Lx>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 12:25:38 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
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
	mhartmay@linux.ibm.com,
	iii@linux.ibm.com
Subject: [PATCH bpf-next v2 3/3] bpf: verifier: Disambiguate get_constant_map_key() errors
Date: Tue,  4 Feb 2025 10:25:18 -0700
Message-ID: <dfe144259ae7cfc98aa63e1b388a14869a10632a.1738689872.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738689872.git.dxu@dxuuu.xyz>
References: <cover.1738689872.git.dxu@dxuuu.xyz>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


