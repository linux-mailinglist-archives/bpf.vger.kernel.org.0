Return-Path: <bpf+bounces-50429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4707CA27846
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D218B164B50
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C592163A9;
	Tue,  4 Feb 2025 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="h9TOdYaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MSpIgVNa"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C4216388;
	Tue,  4 Feb 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689937; cv=none; b=HcaSoBwNo/0K6L9UO54TPHFIrINkaIFJjrw3Fi41rZ7NxPnp2+NUAceamJd2Rh2H96LFg0vu+UQNcwNHPiQ6AimO+i2fYAFAO7XUuilVhYLpbeQKKp8opbzqiWRhsQRpU/nHJkhBnQRw9YIr8vVM3RCLkQPHk9hiUFE0MqGkeio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689937; c=relaxed/simple;
	bh=fkorpfq7ogkH+USPPjZwehE3z1eFl8rgMYo3zRE4iPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fB5Yv93wyXOTXpMQe3Eo0aGMuROnxeQYle7lKgpJ6d2HX5DrOpkHG8OMhe5EDZoGE5GIjJgmqZoMJh8ca9cWWhsXGiUTr+uohTUzVe2DO7Hm8hyu5TWY/VMv9+T47DbJ2TYKas/Kt+MVcgSObilK6TxQ7AutuksrhoqqCDS8wtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=h9TOdYaT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MSpIgVNa; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B4CAA1140155;
	Tue,  4 Feb 2025 12:25:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 04 Feb 2025 12:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1738689934; x=
	1738776334; bh=SnkG2cleegJaAFaNJQr1m4VJsyoefsv0oxQcSMvwE90=; b=h
	9TOdYaTeYxw+UGiKZL4WGNFg338kZWhvtVmU+dxOw9LaH7/Nv+8pvuh9T+Fllrau
	yiLJ8dyvz9G8XSZGM2f/j5Am1NzHovKjZn06ZsY9ypzniFohKjCfhpdl0Wwx/qr3
	lZPjBvem4S0DWS3sbI84noduwwaWrzLe0M5NWDRa94PD7L0Hihd2ipbtCvuYQ9m9
	NpKWI1M4yCcCW88FnZhtr4Wl8LT8vdeS9HPUZTGWLjnzHh8tv5jnYWm17/CKgka9
	D7vgAmZWbRNiR9P+A9RJoDY4yxLlCwMSrVzpbWZSVAM88hx2vlOJVieK86dyLEab
	U8CtQ7WdSiLmHJt/0bLJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1738689934; x=1738776334; bh=S
	nkG2cleegJaAFaNJQr1m4VJsyoefsv0oxQcSMvwE90=; b=MSpIgVNagVnqLL0G/
	s5xTi5/0civ8tU+th07DNKZXjv3vwmaYt2GPaX0lLvjP0p7GoCbeIQevXyQUfrnT
	ZLKey+O7pQuat4GcFFHLo9SJmGqJqt73JBRvSKqi0l/EjECxKY6etrI7Noc5vUKc
	Bpvq3c49EMBuzUyj2txJhyxKxjM2l08WQD7e1Pc14uIbnJ8/0AGd5wGvHQtjn4BL
	9z3ehwWTsV/Dh+LAM4Fm56O/fBgK5ZrpGSs6qqchwGv4iGN9viYv1kaNIwEzq/yJ
	Osj6+75q4Osq3p0Htu8NGhCzCTbVmD0g7WC9omSe3gbiifp8c8gmAXfZENUfKjcT
	aFEcA==
X-ME-Sender: <xms:jU2iZ8KeqnQKsTZHGq85GHVNGmcLvnlL0LyHv-QeWcRI3J0opb2e3w>
    <xme:jU2iZ8IAFtZXTJvPKRbcDjL4GniwlPdyiEYVPbzwu8-nI2J_O6x3ycaxowc5MdQVm
    99Q5TJKvPd6-b9DBg>
X-ME-Received: <xmr:jU2iZ8v2RNJwvmFvg6plKy99Nwrg_FRB5NSQ8trVQw_qpkZgcwCZAibdZRvDjLsbf63uGwhjTq8Wkpn_jp_EvFqnZe1nTUlUfVgNN1RVNNf8F-AC1Pr2>
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
X-ME-Proxy: <xmx:jU2iZ5biHk-AxJR8kDx5hOpoZg7SrsDoHMxRSQeZdHCSnk1_xx6DEg>
    <xmx:jU2iZzYCRaLjWjU03Hjres1we72ZIbRlHDqE0DuJD1Mu-xZYhzJj4w>
    <xmx:jU2iZ1ARDXYJKf7qV640APTNBGnucQecuDL6Sd9LaF5x930pEEQfXw>
    <xmx:jU2iZ5bQe8nNRDsHTCn0QJdNaJXsG_Uft2vwYHG8EduRZPqwc8SeQw>
    <xmx:jk2iZ7JhyRPk9vwjAAh5mrdJ4GVz5guE4Ix7D5DbjGUiuQF9lFEAHYOP>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 12:25:31 -0500 (EST)
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
Subject: [PATCH bpf-next v2 1/3] bpf: verifier: Do not extract constant map keys for irrelevant maps
Date: Tue,  4 Feb 2025 10:25:16 -0700
Message-ID: <aa868b642b026ff87ba6105ea151bc8693b35932.1738689872.git.dxu@dxuuu.xyz>
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

Previously, we were trying to extract constant map keys for all
bpf_map_lookup_elem(), regardless of map type. This is an issue if the
map has a u64 key and the value is very high, as it can be interpreted
as a negative signed value. This in turn is treated as an error value by
check_func_arg() which causes a valid program to be incorrectly
rejected.

Fix by only extracting constant map keys for relevant maps. This fix
works because nullness elision is only allowed for {PERCPU_}ARRAY maps,
and keys for these are within u32 range. See next commit for an example
via selftest.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..e9176a5ce215 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9206,6 +9206,8 @@ static s64 get_constant_map_key(struct bpf_verifier_env *env,
 	return reg->var_off.value;
 }
 
+static bool can_elide_value_nullness(enum bpf_map_type type);
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn,
@@ -9354,9 +9356,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
 		if (err)
 			return err;
-		meta->const_map_key = get_constant_map_key(env, reg, key_size);
-		if (meta->const_map_key < 0 && meta->const_map_key != -EOPNOTSUPP)
-			return meta->const_map_key;
+		if (can_elide_value_nullness(meta->map_ptr->map_type)) {
+			meta->const_map_key = get_constant_map_key(env, reg, key_size);
+			if (meta->const_map_key < 0 && meta->const_map_key != -EOPNOTSUPP)
+				return meta->const_map_key;
+		}
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
-- 
2.47.1


