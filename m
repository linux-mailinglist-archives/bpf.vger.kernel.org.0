Return-Path: <bpf+bounces-50275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72181A24BAF
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 20:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06523A60E8
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55141CF5EC;
	Sat,  1 Feb 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="dTzQ546X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbPLc05B"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857F1CD210;
	Sat,  1 Feb 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738439904; cv=none; b=fOGmpnaawZGjQt0dT0/kyjFZWly501JbYH8xC+pwxvw88Fnm3LDUDq8LI0rE56MCnMaHOFthRmo5cXDzyU2dYALCOoJGAJpMXfeQ17+c4bUEe2w/ApounqlVUPv2lGmbncitxyUZBkQIwvdwbp61CB/PtIL9U/7CNZGeUynd3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738439904; c=relaxed/simple;
	bh=Ru084ahIaNSkF4Yc8zupbLN1zIjFPNjkflNArQe5JtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1cmGPXBC0H0gl3CDyPv7Sk9LncolM6d72+RDeHIJRE3kiggOEVRvsxHOLiBgDt/u0ttlECVfRnyepqVwIIc4sj9VcT3pFVMwVycfgVVd6sImk1s8Hzc5U9uUAKR0F4gbaiPNFmwadFS6EE//UlUAIfLPZFxViaTcSXz2kAnf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=dTzQ546X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbPLc05B; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E9D7511400F6;
	Sat,  1 Feb 2025 14:58:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 01 Feb 2025 14:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1738439900; x=
	1738526300; bh=7ztCozY8zANJNRpgiRLy/ahPatcB+YeK74Y2OUwmP5Y=; b=d
	TzQ546XFGA3Z+kS2lxL1GgTA6MTrtnV+vXeTDmpPFYDp9LTXz1qfS7DyIJppvTkM
	fE/3/7AWGBO/MxIcYvFTmRMLFmfYLiFDh+e/uVfKWyMf/Hem+PbhEtgQ1hV2hSOe
	re2SG9XBifJ9s2jdRFwT0dWmal8/M8Z1rmdX6JSCGtfmUjSlZ9CqCHwnvY5+JK5U
	KGMQ06n1Pg+LxfsqxGgCWkFaCKSZ+RG0omQz64Avm+9HsfGnS3wQRkKdxgcODUqE
	gOiIDLnWHnJSajd6BxZfMcoHbAh3TUYhB86DLTalPQQZQN5Ouz+7KSi95RsuHXAX
	QNQ2MaW6jm+D/+GGervdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1738439900; x=1738526300; bh=7
	ztCozY8zANJNRpgiRLy/ahPatcB+YeK74Y2OUwmP5Y=; b=bbPLc05B/WI/7T75p
	xZ9fOKgM0y9XO/8+8HDkUb7M7N9OGMSpExKeKHJMEVYeVq9MsSb4owIGUGYGqMjR
	d0wxkLbheN8FCFZ8sN988FwpOapt3SEMwbYbGjN/tZAjPPszbfYzwk8hAj5Z6LSQ
	hhzUtKjTdsp8sgPTsT7tD5tebAy0a+rukMFBWkJjuZ9z0/TPXmkv8hO4wOo9RA32
	l4QKvlOYAHI/3DSJjDisVtB+koFsssIxE/dSc6Ed+LlWwiPRPZp/Hgxos5L9d8Vo
	htvVjmkmvjZIwNXjPMXOD0Zr6tNDU/R22ZJtIr0x7CfBIb2jMuXc0sMjS4pZ3YN3
	zd0dw==
X-ME-Sender: <xms:3HyeZ6ifG2XpbTRWK7jxoDCXW8fx9F2hcs_siTfta70SwZ0mla5hhw>
    <xme:3HyeZ7AGCgWliXEPBCzR88sB8ye04oq_-Zm6QiObGMSPhaExb7iUiuPW1KHYzme1p
    xHO1OovpQinDWN_XA>
X-ME-Received: <xmr:3HyeZyFR5-iU923DOwSOdL5nliNXY2Af5NqHI3V3Ib65lMUEYjANj7_kfcpGiO0DaqJ0qSRcTIP9lE14QzTpH_H_nGUpiBDXRAYrlZ6VqL4P4D2s5Ue6>
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
X-ME-Proxy: <xmx:3HyeZzSdsKrYr2yhjrwqaKC-iY6SXD2EWGvNOFJ4ieKHwKjRosv0ng>
    <xmx:3HyeZ3xro5oo99UcrsDjQhyCefp9AxwDjADWNjJDGY9_5c75PVU-xQ>
    <xmx:3HyeZx7IXMllcjqsQxnWwAaiFL05hCNe1hjARlm4kJsrjEpjCTIcfA>
    <xmx:3HyeZ0y6kQr1sVhgYO1wdEhNFF5fctYt6jZ4kUHCGhFViB5eQznEtg>
    <xmx:3HyeZ0hiGq9lN7rj3AyhVJ7ZOAoSqREiM5ZZWRGXRmFemoEoDZy6tkpy>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Feb 2025 14:58:18 -0500 (EST)
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
Subject: [PATCH bpf-next 1/3] bpf: verifier: Do not extract constant map keys for irrelevant maps
Date: Sat,  1 Feb 2025 12:58:01 -0700
Message-ID: <ebbf8edf871a6543425b75bb659400221bd28275.1738439839.git.dxu@dxuuu.xyz>
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

Previously, we were trying to extract constant map keys for all
bpf_map_lookup_elem(), regardless of map type. This is an issue if the
map has a u64 key and the value is very high, as it can be interpreted
as a negative signed value. This in turn is treated as an error value by
check_func_arg() which causes a valid program to be incorrectly
rejected.

Fix by only extracting constant map keys for relevant maps. See next
commit for an example via selftest.

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


