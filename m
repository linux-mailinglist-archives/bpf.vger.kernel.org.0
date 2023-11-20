Return-Path: <bpf+bounces-15442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EF27F2112
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA292827FE
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2AD3AC1E;
	Mon, 20 Nov 2023 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii4pqUrQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CEFA2
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:06 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9d10972e63eso672702166b.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700521203; x=1701126003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXs9SZetwBAtJcELqqofxsxVUvMrgChkQa0eXc4UYYw=;
        b=Ii4pqUrQ6cuRdNAqMnv3MSVtyRrstssIDxziNOtKbkXeDL8iMgc5iDKhqf5PgpKu9n
         LyUrMpTPNlW/B6qTtf7m7XCvTeDj6QDMtnfRRY3k76vcuyUukcvIxpM5WeRFYUApZQji
         tFj1Vypejcx29MlorvsJ2EviQE8Hokj9R+LBmDvFHuOSZiY+NxuzK8XoVpvniiBkFt46
         MDliQXu0ZRlysxgOXT44WQnGy+VNp3e44HNHQV5zptJubAsIbdMmMU44eRkSl+oz1QJ9
         dkcZeibe6WlERaPLewontArPjaJ8ALd4AMigN86bNAd0yYlaaZU3H1i6cleP9EmVVrM1
         hzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521203; x=1701126003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXs9SZetwBAtJcELqqofxsxVUvMrgChkQa0eXc4UYYw=;
        b=g6nzV495ifshdLvMVkaYQ7F6BzIcUruYOrufl1IoBr2B3enFpuZadvgZTLkKsBhPCq
         W76jWVGF70sn39rCuRgluv2aa65vXh6s9yVCjavKiC/jvZZZzW2Myeof/QwqrfD94kwO
         M65iuk0k/NTV1KcfaXrZhTIj+9R8qzt0ZW/B6GOBghmROFWSTwcg/LH3c4OKJg3W48Op
         LzMpaqCerxTPkLV61jDfx5fhdmzLm3Q10aWOx6RWY0qdH+HGuMw/zCS6kp3uF7eAmrVO
         l9/88T1CYPMqP7aPF9hqTrn8PxWbfVlr73U3MkVbRqy6uK9zBcXaRRL9Z9hMeYni/+SX
         JpRA==
X-Gm-Message-State: AOJu0YyUnmX+ffCByickLZh8g5F2Qppq/LZb2eR3sSdNQ6PgTIWXb+TJ
	7oG2tCMC+mSUQj8Nz99Y2M2uft6JpNCMoQ==
X-Google-Smtp-Source: AGHT+IHu+gLUJWMHBFdgtZA9WvXX1C3YaOEOiTsJaP1nX9OVY6HFxSM9eAcl/hf4V2WFiZ1XgZg8ZA==
X-Received: by 2002:a17:906:2b49:b0:9fe:615e:3342 with SMTP id b9-20020a1709062b4900b009fe615e3342mr3241703ejg.24.1700521202941;
        Mon, 20 Nov 2023 15:00:02 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906468900b009fd6a22c2e9sm1968039ejr.138.2023.11.20.15.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:00:01 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v3 02/11] selftests/bpf: track string payload offset as scalar in strobemeta
Date: Tue, 21 Nov 2023 00:59:36 +0200
Message-ID: <20231120225945.11741-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120225945.11741-1-eddyz87@gmail.com>
References: <20231120225945.11741-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change prepares strobemeta for update in callbacks verification
logic. To allow bpf_loop() verification converge when multiple
callback iterations are considered:
- track offset inside strobemeta_payload->payload directly as scalar
  value;
- at each iteration make sure that remaining
  strobemeta_payload->payload capacity is sufficient for execution of
  read_{map,str}_var functions;
- make sure that offset is tracked as unbound scalar between
  iterations, otherwise verifier won't be able infer that bpf_loop
  callback reaches identical states.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/progs/strobemeta.h  | 78 ++++++++++++-------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index e02cfd380746..40df2cc26eaf 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -24,9 +24,11 @@ struct task_struct {};
 #define STACK_TABLE_EPOCH_SHIFT 20
 #define STROBE_MAX_STR_LEN 1
 #define STROBE_MAX_CFGS 32
+#define READ_MAP_VAR_PAYLOAD_CAP					\
+	((1 + STROBE_MAX_MAP_ENTRIES * 2) * STROBE_MAX_STR_LEN)
 #define STROBE_MAX_PAYLOAD						\
 	(STROBE_MAX_STRS * STROBE_MAX_STR_LEN +				\
-	STROBE_MAX_MAPS * (1 + STROBE_MAX_MAP_ENTRIES * 2) * STROBE_MAX_STR_LEN)
+	 STROBE_MAX_MAPS * READ_MAP_VAR_PAYLOAD_CAP)
 
 struct strobe_value_header {
 	/*
@@ -355,7 +357,7 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 					     size_t idx, void *tls_base,
 					     struct strobe_value_generic *value,
 					     struct strobemeta_payload *data,
-					     void *payload)
+					     size_t off)
 {
 	void *location;
 	uint64_t len;
@@ -366,7 +368,7 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 		return 0;
 
 	bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
-	len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN, value->ptr);
+	len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN, value->ptr);
 	/*
 	 * if bpf_probe_read_user_str returns error (<0), due to casting to
 	 * unsinged int, it will become big number, so next check is
@@ -378,14 +380,14 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 		return 0;
 
 	data->str_lens[idx] = len;
-	return len;
+	return off + len;
 }
 
-static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
-					  size_t idx, void *tls_base,
-					  struct strobe_value_generic *value,
-					  struct strobemeta_payload *data,
-					  void *payload)
+static __always_inline uint64_t read_map_var(struct strobemeta_cfg *cfg,
+					     size_t idx, void *tls_base,
+					     struct strobe_value_generic *value,
+					     struct strobemeta_payload *data,
+					     size_t off)
 {
 	struct strobe_map_descr* descr = &data->map_descrs[idx];
 	struct strobe_map_raw map;
@@ -397,11 +399,11 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 
 	location = calc_location(&cfg->map_locs[idx], tls_base);
 	if (!location)
-		return payload;
+		return off;
 
 	bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
 	if (bpf_probe_read_user(&map, sizeof(struct strobe_map_raw), value->ptr))
-		return payload;
+		return off;
 
 	descr->id = map.id;
 	descr->cnt = map.cnt;
@@ -410,10 +412,10 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 		data->req_meta_valid = 1;
 	}
 
-	len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN, map.tag);
+	len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN, map.tag);
 	if (len <= STROBE_MAX_STR_LEN) {
 		descr->tag_len = len;
-		payload += len;
+		off += len;
 	}
 
 #ifdef NO_UNROLL
@@ -426,22 +428,22 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 			break;
 
 		descr->key_lens[i] = 0;
-		len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN,
+		len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN,
 					      map.entries[i].key);
 		if (len <= STROBE_MAX_STR_LEN) {
 			descr->key_lens[i] = len;
-			payload += len;
+			off += len;
 		}
 		descr->val_lens[i] = 0;
-		len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN,
+		len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN,
 					      map.entries[i].val);
 		if (len <= STROBE_MAX_STR_LEN) {
 			descr->val_lens[i] = len;
-			payload += len;
+			off += len;
 		}
 	}
 
-	return payload;
+	return off;
 }
 
 #ifdef USE_BPF_LOOP
@@ -455,14 +457,20 @@ struct read_var_ctx {
 	struct strobemeta_payload *data;
 	void *tls_base;
 	struct strobemeta_cfg *cfg;
-	void *payload;
+	size_t payload_off;
 	/* value gets mutated */
 	struct strobe_value_generic *value;
 	enum read_type type;
 };
 
-static int read_var_callback(__u32 index, struct read_var_ctx *ctx)
+static int read_var_callback(__u64 index, struct read_var_ctx *ctx)
 {
+	/* lose precision info for ctx->payload_off, verifier won't track
+	 * double xor, barrier_var() is needed to force clang keep both xors.
+	 */
+	ctx->payload_off ^= index;
+	barrier_var(ctx->payload_off);
+	ctx->payload_off ^= index;
 	switch (ctx->type) {
 	case READ_INT_VAR:
 		if (index >= STROBE_MAX_INTS)
@@ -472,14 +480,18 @@ static int read_var_callback(__u32 index, struct read_var_ctx *ctx)
 	case READ_MAP_VAR:
 		if (index >= STROBE_MAX_MAPS)
 			return 1;
-		ctx->payload = read_map_var(ctx->cfg, index, ctx->tls_base,
-					    ctx->value, ctx->data, ctx->payload);
+		if (ctx->payload_off > sizeof(ctx->data->payload) - READ_MAP_VAR_PAYLOAD_CAP)
+			return 1;
+		ctx->payload_off = read_map_var(ctx->cfg, index, ctx->tls_base,
+						ctx->value, ctx->data, ctx->payload_off);
 		break;
 	case READ_STR_VAR:
 		if (index >= STROBE_MAX_STRS)
 			return 1;
-		ctx->payload += read_str_var(ctx->cfg, index, ctx->tls_base,
-					     ctx->value, ctx->data, ctx->payload);
+		if (ctx->payload_off > sizeof(ctx->data->payload) - STROBE_MAX_STR_LEN)
+			return 1;
+		ctx->payload_off = read_str_var(ctx->cfg, index, ctx->tls_base,
+						ctx->value, ctx->data, ctx->payload_off);
 		break;
 	}
 	return 0;
@@ -501,7 +513,8 @@ static void *read_strobe_meta(struct task_struct *task,
 	pid_t pid = bpf_get_current_pid_tgid() >> 32;
 	struct strobe_value_generic value = {0};
 	struct strobemeta_cfg *cfg;
-	void *tls_base, *payload;
+	size_t payload_off;
+	void *tls_base;
 
 	cfg = bpf_map_lookup_elem(&strobemeta_cfgs, &pid);
 	if (!cfg)
@@ -509,7 +522,7 @@ static void *read_strobe_meta(struct task_struct *task,
 
 	data->int_vals_set_mask = 0;
 	data->req_meta_valid = 0;
-	payload = data->payload;
+	payload_off = 0;
 	/*
 	 * we don't have struct task_struct definition, it should be:
 	 * tls_base = (void *)task->thread.fsbase;
@@ -522,7 +535,7 @@ static void *read_strobe_meta(struct task_struct *task,
 		.tls_base = tls_base,
 		.value = &value,
 		.data = data,
-		.payload = payload,
+		.payload_off = 0,
 	};
 	int err;
 
@@ -540,6 +553,11 @@ static void *read_strobe_meta(struct task_struct *task,
 	err = bpf_loop(STROBE_MAX_MAPS, read_var_callback, &ctx, 0);
 	if (err != STROBE_MAX_MAPS)
 		return NULL;
+
+	payload_off = ctx.payload_off;
+	/* this should not really happen, here only to satisfy verifer */
+	if (payload_off > sizeof(data->payload))
+		payload_off = sizeof(data->payload);
 #else
 #ifdef NO_UNROLL
 #pragma clang loop unroll(disable)
@@ -555,7 +573,7 @@ static void *read_strobe_meta(struct task_struct *task,
 #pragma unroll
 #endif /* NO_UNROLL */
 	for (int i = 0; i < STROBE_MAX_STRS; ++i) {
-		payload += read_str_var(cfg, i, tls_base, &value, data, payload);
+		payload_off = read_str_var(cfg, i, tls_base, &value, data, payload_off);
 	}
 #ifdef NO_UNROLL
 #pragma clang loop unroll(disable)
@@ -563,7 +581,7 @@ static void *read_strobe_meta(struct task_struct *task,
 #pragma unroll
 #endif /* NO_UNROLL */
 	for (int i = 0; i < STROBE_MAX_MAPS; ++i) {
-		payload = read_map_var(cfg, i, tls_base, &value, data, payload);
+		payload_off = read_map_var(cfg, i, tls_base, &value, data, payload_off);
 	}
 #endif /* USE_BPF_LOOP */
 
@@ -571,7 +589,7 @@ static void *read_strobe_meta(struct task_struct *task,
 	 * return pointer right after end of payload, so it's possible to
 	 * calculate exact amount of useful data that needs to be sent
 	 */
-	return payload;
+	return &data->payload[payload_off];
 }
 
 SEC("raw_tracepoint/kfree_skb")
-- 
2.42.1


