Return-Path: <bpf+bounces-15283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6597EFCF5
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C525B20B91
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D24A139F;
	Sat, 18 Nov 2023 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB3l+FPl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57422D75
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso365797366b.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271248; x=1700876048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXs9SZetwBAtJcELqqofxsxVUvMrgChkQa0eXc4UYYw=;
        b=QB3l+FPlsI8CGozLrT0hO0KdrlEQ+h9qhc46QLCagpZIambsX/fZCofDuzNgW++JNW
         qemqsuFDYvsjs8uVa3fLFjB8fmUgv3GhJSaNyKsfM2X2PG3/YDMbEjuBza9dlqeKlCmK
         X7ziZvgMTyz3zaMzjH+F4xKbTEVsf2EU4EWxhO4alf+45Fv/Zb9eGjpIW7JHcyIWEian
         7bVRIWOZBY82aXjrrDq6XZ85qBt6JUkRIJ02MrS+6HRgFKyqpBNzu4vypdAQjFSZD5Z9
         sYqklmqCA5RQqBbE3mbIfpC4/qMou8vm8W1ruPr6imbUmUS2P8wgyP8RPZIhJSSkXcMj
         +thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271248; x=1700876048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXs9SZetwBAtJcELqqofxsxVUvMrgChkQa0eXc4UYYw=;
        b=JuISQFHVV1D54sAcR1go7Av2r9W16DGisxx1s1bS7nkIlW6/eSYullIJiIJ3BtOBRi
         iftax2fU7B3HXaD72D5jeycutbIhhwOIx70ddPsbp18Stgz5ufe3Q9BA1j3EEUYJj+6t
         tL771jbrA3hgbnP+g0E1aAaiIW67IKzbWoGqqXjDqm7eM7KfnNB21XdoRnpsUhiPi1N6
         cE62AGWaAl0uj5rvCrKI8kLDmG4exFYp14vijWORw/O2OtVjlKGOX9Xhr2kpjk96e52J
         br1BmVpu+FrEFYbiR3KVz2DvBiGuoupz/de76u8LzdKvzLJOdTpG5nyjDPCxiksjtcCb
         oXmQ==
X-Gm-Message-State: AOJu0YykyaSRZ0YDFFNzjCczML+lHIqH/T9ybemqQAKpVM1gyV+D3asc
	ANFcL545XQoGLxorCbQo5gBlUAJXtHY=
X-Google-Smtp-Source: AGHT+IHS3eom4o6QA4c/pzKvkrJDYIqBkssvm0JeVpQvyghupZtLHfTxWeUfJYe4v8f4C5J85wC7CQ==
X-Received: by 2002:a17:906:f193:b0:9bf:5771:a8cf with SMTP id gs19-20020a170906f19300b009bf5771a8cfmr617950ejb.70.1700271248394;
        Fri, 17 Nov 2023 17:34:08 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:07 -0800 (PST)
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
Subject: [PATCH bpf v2 02/11] selftests/bpf: track string payload offset as scalar in strobemeta
Date: Sat, 18 Nov 2023 03:33:46 +0200
Message-ID: <20231118013355.7943-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118013355.7943-1-eddyz87@gmail.com>
References: <20231118013355.7943-1-eddyz87@gmail.com>
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


