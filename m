Return-Path: <bpf+bounces-21736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2C285172B
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 15:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078DCB2414D
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001303B297;
	Mon, 12 Feb 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSKY7jcW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06E3A8CD
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748733; cv=none; b=ixO3zlWIQ+95EnOO8I8SO82idma3snrM0HX6nsioK7J6NiYBdC2YGhN//0LsgGbvAiwqDN7gmQgHbv9qAw4vOXLqRrlKx6dBPvTz/KMHF9aBRxdB+RtLGtnw0nHmqhckhdKrOwfQqbr5kF1YLaRc/+U6eVKShDX8kzHke4Uh6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748733; c=relaxed/simple;
	bh=4Stv+skXJRMBqwnOwq3UNqgfvOmjR93AuXQliYXIMHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqPdnptF6Wmv9CqU1zsmr4f1XLxSrcMNjy/u44yp/918aMKMsl06YEAE2ry1LVvmnCt7lgMAdojgHApXJ/zIBO1xg7ALFm/x6OJA32G1VmGciexe5EpBYqRbDmAzY7bT96WKoz+dnkmO9onrGNzfcIif9GD7zRwfEjC4Ew97K2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSKY7jcW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so4815006a12.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 06:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707748729; x=1708353529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQtV9oxkdAcFG8Er10w04nEgE9pxCO3UX0YkiUL+p/A=;
        b=jSKY7jcWieGdtnERs6oJFhjwJ3r7bd27zEk6oCzGSypndHdgXTo/AhlvrpMEHl80DU
         uA5ZvoyoAgPm4JOEKacCkbXFbHXuEnliL/fZsCbWID+1eUGoMwptknd5rb3oBdhcsdlK
         TT4BxRaT2NZRvSKILeHwMVuZo30+Scj+JUxu7HkPUF/sJ9yBi3UdsDbwTLKEWfzIvMi8
         A10NGx2200DtUjjUl8CwT3ZEr88dp4rCUO8+FDmUQA8sgRoRu9Jxy6NDHrNUFqarcZmM
         Cn3f4D8jcETGkD9NhHZUoqnvi566b3GSJUBSc2JbdcPFpaHqsRO30dZiyPLUqmnrVdIv
         Ikgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748729; x=1708353529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQtV9oxkdAcFG8Er10w04nEgE9pxCO3UX0YkiUL+p/A=;
        b=Ia66nmo0UuigHH5N9mLl1loEgZvKA75WO3BSfOEbrq1QvKl02ai/xS+NW4T2CdXgsg
         MWm8x0ZuuGxuUHyo9FFNCoHR2ATd7bBzqBGskk4pavd7XwUJdDCx0Kf69FuJZTmS2SFq
         o4SRCYaAfRPqeio9NuP2RFNUo+gi/vRH5vNmkH9M7ocRMpoe2xSCCZMn4ZtfwrOrG51p
         dFdB39xrHoUos/G2QMrnbK4LVaTmtcjFs8LjIOYDQeXJ8lgLSAYmCGaEw7Be5S/jFHcW
         32ALHJhpWmWSbzg3/w+yLNCblyDcD56pWAalOut4KU3SB1gwhNbFZY0j//C9ILuFQ7FV
         0/5A==
X-Gm-Message-State: AOJu0YxTDZIHSElVjtXSC+zoJIUfahjql+CRO1ZhyKgbVNgFFiBsmcBF
	IUbbQ7zSxQQQqwZg/C3JO3+WwKISIo9/GGZWUPUb8aYnok7OFRgupzMzmMFx
X-Google-Smtp-Source: AGHT+IHqYBjb9gZTCjAehoFR5Pq7dYgqo1/xb8vXsBByAmJelABlfJU0Rdz336+EK7GBBRph/6OI6w==
X-Received: by 2002:a17:906:e208:b0:a3c:e2a9:d8ac with SMTP id gf8-20020a170906e20800b00a3ce2a9d8acmr283381ejb.6.1707748729461;
        Mon, 12 Feb 2024 06:38:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyCJA9UUDxPHtGcNoW581BO1PAR2LUVks56dBami80C7jmglc0JBOKjaFoZ24GdBLJKnGc07B1LNVVyO1j3e0Bt62GLfiboeC6Xo1YZ0tOLiOYj3Nmx9P23Ll0QyJ5Kj43ACE2y0xMdVCmM/ucTRj7sqHrNeUwC9kRzYKrka1p/pgw04NK2iH649a93ab9sf+iyaeSmc0RdHpJ2/9gNBuM8szzg3XNJ4z/4SIaLFC1OP1FiIgcwgRuLCjNdYE=
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a1709061c0300b00a360ba43173sm266918ejg.99.2024.02.12.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:38:49 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuniyu@amazon.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: update tcp_custom_syncookie to use scalar packet offset
Date: Mon, 12 Feb 2024 16:38:30 +0200
Message-ID: <20240212143832.28838-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212143832.28838-1-eddyz87@gmail.com>
References: <20240212143832.28838-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit in a series fixes bug in bpf_loop() handling.
That change makes tcp_custom_syncookie test too complex to verify.

This commit updates tcp_custom_syncookie.c:tcp_parse_option() to use
explicit packet offset (ctx->off) for packet access instead of ever
moving pointer (ctx->ptr), this reduces verification complexity:
- the tcp_parse_option() is passed as a callback to bpf_loop();
- suppose a checkpoint is created each time at function entry;
- the ctx->ptr is tracked by verifier as PTR_TO_PACKET;
- the ctx->ptr is incremented in tcp_parse_option(),
  thus umax_value field tracked for it is incremented as well;
- on each next iteration of tcp_parse_option()
  checkpoint from a previous iteration can't be reused
  for state pruning, because PTR_TO_PACKET registers are
  considered equivalent only if old->umax_value >= cur->umax_value;
- on the other hand, the ctx->off is a SCALAR,
  subject to widen_imprecise_scalars();
- it's exact bounds are eventually forgotten and it is tracked as
  unknown scalar at entry to tcp_parse_option();
- hence checkpoints created at the start of the function eventually
  converge.

The change is similar to one applied in [0] to xdp_synproxy_kern.c.

[0] commit 977bc146d4eb ("selftests/bpf: track tcp payload offset as scalar in xdp_synproxy")

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/test_tcp_custom_syncookie.c     | 83 ++++++++++++-------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
index a5501b29979a..c8e4553648bf 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
@@ -10,6 +10,8 @@
 #include "test_siphash.h"
 #include "test_tcp_custom_syncookie.h"
 
+#define MAX_PACKET_OFF 0xffff
+
 /* Hash is calculated for each client and split into ISN and TS.
  *
  *       MSB                                   LSB
@@ -52,16 +54,15 @@ static siphash_key_t test_key_siphash = {
 
 struct tcp_syncookie {
 	struct __sk_buff *skb;
+	void *data;
 	void *data_end;
 	struct ethhdr *eth;
 	struct iphdr *ipv4;
 	struct ipv6hdr *ipv6;
 	struct tcphdr *tcp;
-	union {
-		char *ptr;
-		__be32 *ptr32;
-	};
+	__be32 *ptr32;
 	struct bpf_tcp_req_attrs attrs;
+	u32 off;
 	u32 cookie;
 	u64 first;
 };
@@ -70,6 +71,7 @@ bool handled_syn, handled_ack;
 
 static int tcp_load_headers(struct tcp_syncookie *ctx)
 {
+	ctx->data = (void *)(long)ctx->skb->data;
 	ctx->data_end = (void *)(long)ctx->skb->data_end;
 	ctx->eth = (struct ethhdr *)(long)ctx->skb->data;
 
@@ -134,6 +136,7 @@ static int tcp_reload_headers(struct tcp_syncookie *ctx)
 	if (bpf_skb_change_tail(ctx->skb, data_len + 60 - ctx->tcp->doff * 4, 0))
 		goto err;
 
+	ctx->data = (void *)(long)ctx->skb->data;
 	ctx->data_end = (void *)(long)ctx->skb->data_end;
 	ctx->eth = (struct ethhdr *)(long)ctx->skb->data;
 	if (ctx->ipv4) {
@@ -195,47 +198,68 @@ static int tcp_validate_header(struct tcp_syncookie *ctx)
 	return -1;
 }
 
-static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
+static __always_inline void *next(struct tcp_syncookie *ctx, __u32 sz)
 {
-	char opcode, opsize;
+	__u64 off = ctx->off;
+	__u8 *data;
 
-	if (ctx->ptr + 1 > ctx->data_end)
-		goto stop;
+	/* Verifier forbids access to packet when offset exceeds MAX_PACKET_OFF */
+	if (off > MAX_PACKET_OFF - sz)
+		return NULL;
+
+	data = ctx->data + off;
+	barrier_var(data);
+	if (data + sz >= ctx->data_end)
+		return NULL;
 
-	opcode = *ctx->ptr++;
+	ctx->off += sz;
+	return data;
+}
 
-	if (opcode == TCPOPT_EOL)
+static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
+{
+	__u8 *opcode, *opsize, *wscale;
+	__u32 *tsval, *tsecr;
+	__u16 *mss;
+	__u32 off;
+
+	off = ctx->off;
+	opcode = next(ctx, 1);
+	if (!opcode)
 		goto stop;
 
-	if (opcode == TCPOPT_NOP)
+	if (*opcode == TCPOPT_EOL)
+		goto stop;
+
+	if (*opcode == TCPOPT_NOP)
 		goto next;
 
-	if (ctx->ptr + 1 > ctx->data_end)
+	opsize = next(ctx, 1);
+	if (!opsize)
 		goto stop;
 
-	opsize = *ctx->ptr++;
-
-	if (opsize < 2)
+	if (*opsize < 2)
 		goto stop;
 
-	switch (opcode) {
+	switch (*opcode) {
 	case TCPOPT_MSS:
-		if (opsize == TCPOLEN_MSS && ctx->tcp->syn &&
-		    ctx->ptr + (TCPOLEN_MSS - 2) < ctx->data_end)
-			ctx->attrs.mss = get_unaligned_be16(ctx->ptr);
+		mss = next(ctx, 2);
+		if (*opsize == TCPOLEN_MSS && ctx->tcp->syn && mss)
+			ctx->attrs.mss = get_unaligned_be16(mss);
 		break;
 	case TCPOPT_WINDOW:
-		if (opsize == TCPOLEN_WINDOW && ctx->tcp->syn &&
-		    ctx->ptr + (TCPOLEN_WINDOW - 2) < ctx->data_end) {
+		wscale = next(ctx, 1);
+		if (*opsize == TCPOLEN_WINDOW && ctx->tcp->syn && wscale) {
 			ctx->attrs.wscale_ok = 1;
-			ctx->attrs.snd_wscale = *ctx->ptr;
+			ctx->attrs.snd_wscale = *wscale;
 		}
 		break;
 	case TCPOPT_TIMESTAMP:
-		if (opsize == TCPOLEN_TIMESTAMP &&
-		    ctx->ptr + (TCPOLEN_TIMESTAMP - 2) < ctx->data_end) {
-			ctx->attrs.rcv_tsval = get_unaligned_be32(ctx->ptr);
-			ctx->attrs.rcv_tsecr = get_unaligned_be32(ctx->ptr + 4);
+		tsval = next(ctx, 4);
+		tsecr = next(ctx, 4);
+		if (*opsize == TCPOLEN_TIMESTAMP && tsval && tsecr) {
+			ctx->attrs.rcv_tsval = get_unaligned_be32(tsval);
+			ctx->attrs.rcv_tsecr = get_unaligned_be32(tsecr);
 
 			if (ctx->tcp->syn && ctx->attrs.rcv_tsecr)
 				ctx->attrs.tstamp_ok = 0;
@@ -244,13 +268,12 @@ static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
 		}
 		break;
 	case TCPOPT_SACK_PERM:
-		if (opsize == TCPOLEN_SACK_PERM && ctx->tcp->syn &&
-		    ctx->ptr + (TCPOLEN_SACK_PERM - 2) < ctx->data_end)
+		if (*opsize == TCPOLEN_SACK_PERM && ctx->tcp->syn)
 			ctx->attrs.sack_ok = 1;
 		break;
 	}
 
-	ctx->ptr += opsize - 2;
+	ctx->off = off + *opsize;
 next:
 	return 0;
 stop:
@@ -259,7 +282,7 @@ static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
 
 static void tcp_parse_options(struct tcp_syncookie *ctx)
 {
-	ctx->ptr = (char *)(ctx->tcp + 1);
+	ctx->off = (__u8 *)(ctx->tcp + 1) - (__u8 *)ctx->data,
 
 	bpf_loop(40, tcp_parse_option, ctx, 0);
 }
-- 
2.43.0


