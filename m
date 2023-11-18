Return-Path: <bpf+bounces-15282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2A77EFCF4
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C6DB20B9E
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1580111A;
	Sat, 18 Nov 2023 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/gP6WG+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B7D6C
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:09 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so26038466b.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271247; x=1700876047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q54AApPDQlPpB/oCFac6IGlMYTF/fqY4mhrc95TTVjo=;
        b=P/gP6WG+f15X4cF6B/+ugfPAfqO2A0eq7Svnjn7DCoz6R74z+sBg6c86BKxzqj0zq8
         tLPV22VoSkh7smx/NtzbBtFhku7S3Peo7dFbvqi+F0EDZFdlR9Gz1u0A4dK0qAxqvV+F
         LGVMMn5sEjs5nXQvs8BHOfn1NzjYYjNgDB5lOWM2iL+QyQmRGj0XbVtQF2JPmMsbHzFw
         6H26VxGSURmRv57jusW1FW9+maQrPSNWULvkaSOFB/RRfgBY2yy0GCVuXj0uYHAlz/Z3
         3CWtP1tkYa2mOjPYH+KaTsttX2aY66st+3RTWXPFcPFyg1qyV2eDnH8AeoJaJnNNuvjB
         BZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271247; x=1700876047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q54AApPDQlPpB/oCFac6IGlMYTF/fqY4mhrc95TTVjo=;
        b=fR4aXnyyOXruE4jFdOpCsy58EWZQUCkw7pawGMJxugOpZP9aLo93EAc9AAl+OAkTnT
         hN8bPztcENwUhqw/3UZxplQSU2gqCLwnqYEAF3k2u+A0gChqCOJeuJONM8K3hWSP/3Bw
         DCyFTouVKauToeV2sK09mdKdCdBgYmXN5qwXXIvbVWSKvqXCZzT8zsTIkrfan13dhinM
         WsAFg4hxkx6ccsFJurHlvuavg10aVvRgi5CmEoJbaKccEEzOeHVvMEYx4L7XpG8NTh4h
         av7hshvrF86TbxAxvh05Spe3vvcVjt5gfhpUbDB9392kdktIwf84izEfZx/vtPJt8wM6
         gNRg==
X-Gm-Message-State: AOJu0YzwUsVkF8HV76C7Tpo6AqZqxxIHjPYlnWyhVQ17lnl1kmTVzrbs
	qscYxH2bmbYXAfj2h9cuNU+g0SME9RQ=
X-Google-Smtp-Source: AGHT+IHIlrthGyaSDVk6bNwUSfrL7uBtgFXPXvCTR+X+NJ14ByNFOe3WmB9xYDvo5k1eHf7+LSSg4g==
X-Received: by 2002:a17:906:2496:b0:9b2:b786:5e9c with SMTP id e22-20020a170906249600b009b2b7865e9cmr700157ejb.28.1700271247108;
        Fri, 17 Nov 2023 17:34:07 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:06 -0800 (PST)
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
Subject: [PATCH bpf v2 01/11] selftests/bpf: track tcp payload offset as scalar in xdp_synproxy
Date: Sat, 18 Nov 2023 03:33:45 +0200
Message-ID: <20231118013355.7943-2-eddyz87@gmail.com>
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


