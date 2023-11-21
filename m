Return-Path: <bpf+bounces-15484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DBD7F2398
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DDE1C218D5
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F2214286;
	Tue, 21 Nov 2023 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHf6Y+xo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C54C3
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so5312572a12.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532443; x=1701137243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXs9SZetwBAtJcELqqofxsxVUvMrgChkQa0eXc4UYYw=;
        b=eHf6Y+xoEmeM404AHuwkG3sjuV5ML+cUnaoX8s2GnrbC2oca+mQYUcUAxndVD+W4pp
         SljI2EHRaadkgEZ7KlYYnvCIAZ9odps5DWYk/qhvk6spa8BRdofg7VQTX8/PkPeYSBip
         Jq9nAcE3xkNRU261l609oInw0IHKmk866MEQLdaRimKsWYp3xeL6UGNEHO/DxZq8QOfK
         fdASsm6kZDuQBmDZTk70hE+KaLVcI8fVT28FT+cf47mootpdDDh5RbWvjZ4+ocTv7zBn
         TiaKexojR17XwoOO/CTXZo1OrSlziJ1AhuwPr08uE6iXQTuK3QBCipFMVZp5qMO0zeLi
         M70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532443; x=1701137243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXs9SZetwBAtJcELqqofxsxVUvMrgChkQa0eXc4UYYw=;
        b=VT2ZgrNo52GlPruLdyCHY88hsD7G8vQLD28JKhaz4Puaast8O1pPMhVoB/e9tXBTgP
         YC3ldWOtHbeqQdjOETN77xdB+PPTnZ0K634G4MH2To24Efv8OCaRpMliXxXhxdxfGGqZ
         1pTKDO/adLUeAtfWHYBepa3KZ1zf5Ko1YxlGFuwsgwm32ZjkWMoKUuTS9utoP4aR2vYa
         9M4HGx6cQG6K70OxMT5s93fLLDPwBYB4n4IlmHk0jXBEarPvkz/B4w2NyUc1qR0JQvug
         n9wkX4cPWhZpuemhAV3Jmu1dzVE4uqe+SxGNdBizP8xdBsxSfB4ItslG3L3Fxw2H7I+c
         wzuQ==
X-Gm-Message-State: AOJu0YzmQm2ySGUd3lGSbEkz9E9k6G7dwkFEBDuilrzW8CGyaRYpB500
	X3CGMdyCNIS2tRAMcPmUpRTNrHKtH9rWxA==
X-Google-Smtp-Source: AGHT+IG7VA3PMl/ETUkdbKwO48B77EC1zpT+IEaaMQ30L1Lml0KIGcKTT5CpE3YooUZ2w0e52PQtCA==
X-Received: by 2002:a17:906:35d6:b0:a00:acb:e789 with SMTP id p22-20020a17090635d600b00a000acbe789mr1980469ejb.48.1700532443124;
        Mon, 20 Nov 2023 18:07:23 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b009fc990d9edbsm2426668ejb.192.2023.11.20.18.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:07:21 -0800 (PST)
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
Subject: [PATCH bpf v4 02/11] selftests/bpf: track string payload offset as scalar in strobemeta
Date: Tue, 21 Nov 2023 04:06:52 +0200
Message-ID: <20231121020701.26440-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121020701.26440-1-eddyz87@gmail.com>
References: <20231121020701.26440-1-eddyz87@gmail.com>
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


