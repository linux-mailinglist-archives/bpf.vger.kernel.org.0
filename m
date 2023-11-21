Return-Path: <bpf+bounces-15483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122C67F2397
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DC21C218A4
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA3813AF9;
	Tue, 21 Nov 2023 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQY2lQLF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096492
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548c548c40aso2706328a12.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532441; x=1701137241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q54AApPDQlPpB/oCFac6IGlMYTF/fqY4mhrc95TTVjo=;
        b=KQY2lQLF8u3DBTRIcv9u/xwP3L9nufJJuI3q22ur2KMrNZA8MNOGYLuFfBJnzvNQwa
         IraeoUFKrB9lavLpMfUxs3So+cIoM3ZNb4oGWT47keNY0RWL4C5RH3U4jBPDT6Id2SlA
         28U6aB9KVwDwYYNLdxaolLWKrk3kzUJkteaqn99m0/ujxKGP/znbcvorfId1SND+xfOC
         e+eX+xuygSmOzQTJdzZ4j564rmAF0o2dkBp68FHK8D96yPE0CpeyPkzgoSrLFBPQxbGf
         e48NJ1tQEXsoHCn4EheuJtrrORbCpyR0U6AIcIcyjPl3qiOAvDHgMWkA5ti0T6FzpYZ+
         rvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532441; x=1701137241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q54AApPDQlPpB/oCFac6IGlMYTF/fqY4mhrc95TTVjo=;
        b=dFI+46sJLyPSoppytzwwLop3/+OJch5TBvsyNP7oXcxz4d27lzw2xVY/1pNx5NXlE2
         KaeTHj7R/S7PyzISRqxMg59iOOxGjCOH4/uec0gpT5Bd7MgtxxJ+THr8LKrnnPp6jKZC
         gWztGDkK8R/ckd4iUqWKGixZSOw5GOiZ50deIVH6UImAZnxO0+pcFoFl0slzVtnbWblP
         zDN3h391nJk2rrBR+AxOaLncXASn9tgGmoPxDiRAOQ2LXb1O6yq0VP6EQjr1dTAeFfYH
         sw40zqPiBNVGU3v1znoqxjva2lu2LGHitUnRzRU6AK+SrseJ6dDrynzPvfrcSZLxgYn8
         3RTA==
X-Gm-Message-State: AOJu0YyhBYeLH2wiMprPa4kasM76KQV/WuH7H6ICm1aFAm3JZf8wt/Y7
	yFKbPRs+zUSnFcrWoqBLMil4goMzPFe5Gg==
X-Google-Smtp-Source: AGHT+IE7j/3kM5t98ioNhoQxR1S/gXyTsbeVo3aIsqo8A/+YNGK9cEbGOfCZFFMcfwwZjvs0Xfe9Gw==
X-Received: by 2002:a17:906:5a52:b0:9fb:ddb4:1285 with SMTP id my18-20020a1709065a5200b009fbddb41285mr1153041ejc.31.1700532441073;
        Mon, 20 Nov 2023 18:07:21 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b009fc990d9edbsm2426668ejb.192.2023.11.20.18.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:07:19 -0800 (PST)
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
Subject: [PATCH bpf v4 01/11] selftests/bpf: track tcp payload offset as scalar in xdp_synproxy
Date: Tue, 21 Nov 2023 04:06:51 +0200
Message-ID: <20231121020701.26440-2-eddyz87@gmail.com>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
2.42.1


