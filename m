Return-Path: <bpf+bounces-22501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F20C85FBC9
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96091F249DE
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B21474C0;
	Thu, 22 Feb 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4kZHotb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B4817BAA
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614213; cv=none; b=i3Lld2+LPqQXHKgiX3rIwk/NflVW1M0kd0Jk4euahjTBOCDmld35fX68A9//iIwGnJ7y/duv/KwIDBZrEeN8VbuPIBdOzINAzLtHR+6zWYOavNB7aUJR+cqjg8TG+i7Y2mdZLhhXMlp9LbeccspBO6JV0KDs6PLrShxsWsP0RIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614213; c=relaxed/simple;
	bh=FXdudErA9+k4WhFsbuRwIwwMwx5B92GAvjHDBFEyc1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTIoFQCkpBvqvQUQidpqUHy5bMoAaXtSAOxXyLLdrRi9WimZn7ywMfBGbXf+Ilh4FNtBiErTVLkpBUYcSpl8yOPcj75shYodHY/Gb8UOfInedfP2YWqpJn4qpoioMvnO/WGH0FKjvglEhAfQUtNWZ0/7JeahL9LsWoV+3qKUcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4kZHotb; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3d01a9a9a2so190673166b.1
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 07:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708614209; x=1709219009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD6Pw1dgfhytIBK/8qpxoh4c3se7C46DISEmPuOt7/M=;
        b=j4kZHotbn079uVrQ8HALqp7I79AFQuIS9rDYg9hC8K3zxKi1ZhHA7P7F+FzMFdpCg0
         9shmVyhtpPdSxQfOiU1HTOLPM7JORln/KASukCf2BVfK0heUQRP8s6b6i7MRhNsss+zZ
         uK8gudJdlBvrAMlSaA1EuNVRuuLOLS3se5I0FDqhzGsEYdCRCoiUvzYphvva+HupH0cn
         gVJxS8XCfZzMsmshSccGY67Ynh0bVFbbb3UWVjTmTod3Ht7vWKKn9nuzwlzkZzXGghf5
         lE+9UsOLOOJA+2Fa9sDb5bvJHO3+lnI6dxe693SDjP2G2JQwI0bhIoxuOY0wqzm6RWDH
         VMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614209; x=1709219009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uD6Pw1dgfhytIBK/8qpxoh4c3se7C46DISEmPuOt7/M=;
        b=T2npa4cRs3QsV8e1Qz2v6NHuDQm1MJ2m5z55nyUf2PJRd6Zu+2rf7GmRuiBKA8LeN/
         25hzCQBf9PTSdkfXJPXSeQVz7+fPv387Ml30C0QmWoXfgKvqyrtnzEBKYFpPPnqXVviO
         rEsBPBv7zRpXHZwqP6TuJUxdxl5Wi3JXj8kKfm4qijvUihUF6DLnQO98V4pQoZpLqaxP
         Q44C6SN8Q9cA4Gt7B4mrIbQuAJJyHxIDmAIJpcuBK+U5tvp9m5i5Gh01hSYF9DjUmSDu
         cKZc89bZd6T1Y/4dkzXtlwfTEREBJGepegLGZ9KMAX8GzxHwI2S5hCi/0tLFzKsy/g1D
         mfpQ==
X-Gm-Message-State: AOJu0YwWkuUrkDwLAPnP0/pGNftotpM0Fm0wdXqa9YyASllOlHawSrR6
	2ZmDOOooaXDAGF9pit4k1dc+gT4Woh89AGYadpFO+ROne5iK6mXd7CzlHs+i
X-Google-Smtp-Source: AGHT+IFAoH/pnuvY+7tFH1xIJJs+/RDqr1DHsgEPTGIq2S+/eUuumieEKoBaRpY3QEgzsAFto4zULA==
X-Received: by 2002:a17:906:b150:b0:a3e:c8ca:7fc6 with SMTP id bt16-20020a170906b15000b00a3ec8ca7fc6mr7332574ejb.25.1708614208864;
        Thu, 22 Feb 2024 07:03:28 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a3f2bf468b9sm1869059ejc.173.2024.02.22.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:03:28 -0800 (PST)
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
Subject: [PATCH bpf-next 1/1] selftests/bpf: update tcp_custom_syncookie to use scalar packet offset
Date: Thu, 22 Feb 2024 17:03:00 +0200
Message-ID: <20240222150300.14909-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222150300.14909-1-eddyz87@gmail.com>
References: <20240222150300.14909-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Comparing before and after with veristat yields following results:

File                             Insns (A)  Insns (B)  Insns      (DIFF)
-------------------------------  ---------  ---------  -----------------
test_tcp_custom_syncookie.bpf.o     466657      12423  -454234 (-97.34%)

[0] commit 977bc146d4eb ("selftests/bpf: track tcp payload offset as scalar in xdp_synproxy")

Acked-by: Yonghong Song <yonghong.song@linux.dev>
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


