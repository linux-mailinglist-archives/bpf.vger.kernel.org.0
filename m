Return-Path: <bpf+bounces-15139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5D07ED933
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108A7B20AA3
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424097E;
	Thu, 16 Nov 2023 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH0rj1Zy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D0A1B8
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9f27af23443so46507466b.0
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101112; x=1700705912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rd1Qi9s7fIbOeqOMYpjX24nYgPt/7YhtzMxg3LbYOc=;
        b=hH0rj1Zy0eBKa08PPYp1bPEFPzRfvS07ubVRwCqAeH9TXEouNMocDqaLT/51C5O9/1
         F4p+FcHOILWzLoGrLRwrPrQ9uRUz8zWI340LM8wqOFpg2zYiGB7vT3KOsxPAbxz6x8Z8
         PKivo2XYTe3o2eaR3n2tRgmTQ4K/cw4cHptiLtOIbSNpDGihWY4P56zwTBzIy4hET1fk
         emW0GhdDYuFPLWwTtxcoqzFzCTJVSUx0GZQ6bBcEDAAL2YV1YOvC+jwwe+zhMIsQy/L0
         Nq1ny6iulWH28TDvYJE5luQ5rPAQGqKLAeKur7a1DlCmt3K4HFGvAoY367q8vPBi8mAk
         TXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101112; x=1700705912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rd1Qi9s7fIbOeqOMYpjX24nYgPt/7YhtzMxg3LbYOc=;
        b=nMJN0+9pikyg5iHxezyt7oQrjHbFcuC3ksn2xMG5Z6xHaWbKwmYxdAN7LaetbYihhe
         FtBwLOBYH+f0YzQNakjr1rKn+f9SIuyoaXYvag3NC5qj3qmvFVESgasLbAt3Qktu0lkN
         xElrcxXb538OXoS9i/9rLy5xYgDpwP4FizSr7ZzUdpc4xWH7pXMlEWzkO6vco32Kkdxe
         etbDqUaTh1j01YYD0az5G4o9Jvlgm0bzK2txbenJCuI91wk0h7VPdTTYjttXMXjmQUg8
         PJyu7EnhMaPkgrznZZ7RCuXhJfWbrb1iLF4p9aZHZDRonIKIzNfYXqc5pTjLscDalLG8
         nOwQ==
X-Gm-Message-State: AOJu0YxjvcGk448JvhQiaVajn9iOgH9mvf9yg2vz+2W9CTiQuauVAnQD
	H8zJwzcmeAcrD7mgkhr1CTevAJe3BC3YcQ==
X-Google-Smtp-Source: AGHT+IGxqo0yMkNcPW1f8UEnShd+taDiV4rCPsj3poD7ZAcZw/D82WEgRVuxcE+tmrVDlOnXZGXHrg==
X-Received: by 2002:a17:906:27d9:b0:9e1:46a2:b827 with SMTP id k25-20020a17090627d900b009e146a2b827mr10623186ejc.29.1700101111383;
        Wed, 15 Nov 2023 18:18:31 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:30 -0800 (PST)
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
Subject: [PATCH bpf 01/12] selftests/bpf: track tcp payload offset as scalar in xdp_synproxy
Date: Thu, 16 Nov 2023 04:17:52 +0200
Message-ID: <20231116021803.9982-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116021803.9982-1-eddyz87@gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change prepares syncookie_{tc,xdp} for update in callbakcs
verification logic. To allow bpf_loop() verification converge when
multiple callback itreations are considered:
- track offset inside TCP payload explicitly, not as a part of the
  pointer;
- make sure that offset does not exceed MAX_PACKET_OFF enforced by
  verifier;
- make sure that offset is tracked as unbound scalar between
  iterations, otherwise verifier won't be able infer that bpf_loop
  callback reaches identical states.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/xdp_synproxy_kern.c   | 84 ++++++++++++-------
 1 file changed, 52 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
index e959336c7a73..80f620602d50 100644
--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -53,6 +53,8 @@
 #define DEFAULT_TTL 64
 #define MAX_ALLOWED_PORTS 8
 
+#define MAX_PACKET_OFF 0xffff
+
 #define swap(a, b) \
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
@@ -183,63 +185,76 @@ static __always_inline __u32 tcp_clock_ms(void)
 }
 
 struct tcpopt_context {
-	__u8 *ptr;
-	__u8 *end;
+	void *data;
 	void *data_end;
 	__be32 *tsecr;
 	__u8 wscale;
 	bool option_timestamp;
 	bool option_sack;
+	__u32 off;
 };
 
-static int tscookie_tcpopt_parse(struct tcpopt_context *ctx)
+static __always_inline u8 *next(struct tcpopt_context *ctx, __u32 sz)
 {
-	__u8 opcode, opsize;
+	__u64 off = ctx->off;
+	__u8 *data;
 
-	if (ctx->ptr >= ctx->end)
-		return 1;
-	if (ctx->ptr >= ctx->data_end)
-		return 1;
+	/* Verifier forbids access to packet when offset exceeds MAX_PACKET_OFF */
+	if (off > MAX_PACKET_OFF - sz)
+		return NULL;
 
-	opcode = ctx->ptr[0];
+	data = ctx->data + off;
+	barrier_var(data);
+	if (data + sz >= ctx->data_end)
+		return NULL;
 
-	if (opcode == TCPOPT_EOL)
-		return 1;
-	if (opcode == TCPOPT_NOP) {
-		++ctx->ptr;
-		return 0;
-	}
+	ctx->off += sz;
+	return data;
+}
 
-	if (ctx->ptr + 1 >= ctx->end)
-		return 1;
-	if (ctx->ptr + 1 >= ctx->data_end)
+static int tscookie_tcpopt_parse(struct tcpopt_context *ctx)
+{
+	__u8 *opcode, *opsize, *wscale, *tsecr;
+	__u32 off = ctx->off;
+
+	opcode = next(ctx, 1);
+	if (!opcode)
 		return 1;
-	opsize = ctx->ptr[1];
-	if (opsize < 2)
+
+	if (*opcode == TCPOPT_EOL)
 		return 1;
+	if (*opcode == TCPOPT_NOP)
+		return 0;
 
-	if (ctx->ptr + opsize > ctx->end)
+	opsize = next(ctx, 1);
+	if (!opsize || *opsize < 2)
 		return 1;
 
-	switch (opcode) {
+	switch (*opcode) {
 	case TCPOPT_WINDOW:
-		if (opsize == TCPOLEN_WINDOW && ctx->ptr + TCPOLEN_WINDOW <= ctx->data_end)
-			ctx->wscale = ctx->ptr[2] < TCP_MAX_WSCALE ? ctx->ptr[2] : TCP_MAX_WSCALE;
+		wscale = next(ctx, 1);
+		if (!wscale)
+			return 1;
+		if (*opsize == TCPOLEN_WINDOW)
+			ctx->wscale = *wscale < TCP_MAX_WSCALE ? *wscale : TCP_MAX_WSCALE;
 		break;
 	case TCPOPT_TIMESTAMP:
-		if (opsize == TCPOLEN_TIMESTAMP && ctx->ptr + TCPOLEN_TIMESTAMP <= ctx->data_end) {
+		tsecr = next(ctx, 4);
+		if (!tsecr)
+			return 1;
+		if (*opsize == TCPOLEN_TIMESTAMP) {
 			ctx->option_timestamp = true;
 			/* Client's tsval becomes our tsecr. */
-			*ctx->tsecr = get_unaligned((__be32 *)(ctx->ptr + 2));
+			*ctx->tsecr = get_unaligned((__be32 *)tsecr);
 		}
 		break;
 	case TCPOPT_SACK_PERM:
-		if (opsize == TCPOLEN_SACK_PERM)
+		if (*opsize == TCPOLEN_SACK_PERM)
 			ctx->option_sack = true;
 		break;
 	}
 
-	ctx->ptr += opsize;
+	ctx->off = off + *opsize;
 
 	return 0;
 }
@@ -256,16 +271,21 @@ static int tscookie_tcpopt_parse_batch(__u32 index, void *context)
 
 static __always_inline bool tscookie_init(struct tcphdr *tcp_header,
 					  __u16 tcp_len, __be32 *tsval,
-					  __be32 *tsecr, void *data_end)
+					  __be32 *tsecr, void *data, void *data_end)
 {
 	struct tcpopt_context loop_ctx = {
-		.ptr = (__u8 *)(tcp_header + 1),
-		.end = (__u8 *)tcp_header + tcp_len,
+		.data = data,
 		.data_end = data_end,
 		.tsecr = tsecr,
 		.wscale = TS_OPT_WSCALE_MASK,
 		.option_timestamp = false,
 		.option_sack = false,
+		/* Note: currently verifier would track .off as unbound scalar.
+		 *       In case if verifier would at some point get smarter and
+		 *       compute bounded value for this var, beware that it might
+		 *       hinder bpf_loop() convergence validation.
+		 */
+		.off = (__u8 *)(tcp_header + 1) - (__u8 *)data,
 	};
 	u32 cookie;
 
@@ -635,7 +655,7 @@ static __always_inline int syncookie_handle_syn(struct header_pointers *hdr,
 	cookie = (__u32)value;
 
 	if (tscookie_init((void *)hdr->tcp, hdr->tcp_len,
-			  &tsopt_buf[0], &tsopt_buf[1], data_end))
+			  &tsopt_buf[0], &tsopt_buf[1], data, data_end))
 		tsopt = tsopt_buf;
 
 	/* Check that there is enough space for a SYNACK. It also covers
-- 
2.42.0


