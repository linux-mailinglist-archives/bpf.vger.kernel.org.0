Return-Path: <bpf+bounces-30269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EFA8CBCAD
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E71C20D65
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7517F470;
	Wed, 22 May 2024 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VLIYO4Y4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE44770FB
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365381; cv=none; b=otmliBfRgRjYiY2O7yRkMGJJebQMvMHqObOUu5v0Sg4mKXfGoqPTC5e/dS73H8mtOl166LStlQ3TkTRD7K3TBgPdap5uXYFgEr5prY/bMjqqDuDhi2WYxmR+2x/hHlHyJkJC/C5g4qj7pEsJgBBGUplCxb+v8oTUi7e7HBdSmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365381; c=relaxed/simple;
	bh=HTSAkOfvYuC9hUkLVTxjoov6viq5nfiMgRTmN1j9YxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ctxINa0S6WhExti6Uejxxx7mbki5mCzW5d0HiM3l9aPehy6xixue6NLlToVqG37ZjgSKMIDmgyLqc7B9bf4kqOQlNBRH9i1GblRjbii6ELaqGh+n83G1M79Z/3oDavHVkh1pAqjxAXYQk9Ah7d0g2JcvfOlAgQt+IiPresi0LaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VLIYO4Y4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5a7d28555bso1004638766b.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716365377; x=1716970177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq9ju8yuRG9zlq1ssdeG2Wi6UKR7EhZ3LYktIzrnaHw=;
        b=VLIYO4Y4pOfw/LsXaZoNTlfDuhqJh5ZD6FGYyxtK0Bi0Zt68JDbiH1zciTC/Rg5I73
         cmHv0OfLrEZ31EEZ6qk0/SGiNjm9Oul4Qgve3POm2DwqdbacohQmCLKA1grnVeYOrgZq
         2gg5BchGSQysOelk6IFEpGm06vsgRKYlmgYIW38dsqsZYQkALC2DKruQvreFzKYlCWAD
         nLbOWbkY/KwFiLfYih0w9hpraH7D0g0SPdS6HaQg0Q6IdWKcg2fiVhWIv6OsMpd93XQw
         TMYFf7a7uZqgBhBaPMv8UFMpdEoNMiCASPz7iXGSqFXCKLYDLdGsXg/FIpYz2LYn/KQz
         d84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365377; x=1716970177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xq9ju8yuRG9zlq1ssdeG2Wi6UKR7EhZ3LYktIzrnaHw=;
        b=jtflsvPP8V6h6XHhFeOQA9gZyEQPt4+h2yfOfOomhNfowoww0Atvag70BbxdAGWras
         uUQucWqHCVvukD1LhO9vPzwgNcqGeszkwQFUhMNfADmLUw/ICRVSkd3aOJ2ZN9ShlADs
         JX4VzKKTtKv25YR+16OVLDOmMdFsXCQskj7A34Q7Iu8O7rMRd4OE4yi1aoBkWcCLyitl
         qfRD163sYCURmegpPl3SZnfgJFCai4h+3rYaNKAnNUogFu9dlz2Y90HZDT2doQhoQ5vF
         xDXxs9mei5scmwUIaRFgBgqIM+MymZyZr8t/JO0NZOX8X8Xyxaai1myWTuh12IbwlUGE
         jIjw==
X-Gm-Message-State: AOJu0YwLK2a/adSd+hesf6N6l26V1Afb/+t4OGzbS239w9ormr3dU8cA
	GaaIjqt8348ybYOlnthUZ0mOQOlzDZBboHE2VhzW+cTeflx3jH4XhqOjepm0cd/DMIuTSjxyhya
	N
X-Google-Smtp-Source: AGHT+IGstuf+E6eoUXnXG3g0majoDgIfzyLmMnkjz+pFVkzINmxxHBKor7gJYutVvHOmkXgyMqtPhw==
X-Received: by 2002:a17:906:259a:b0:a59:a0b6:638 with SMTP id a640c23a62f3a-a622819aea3mr68572366b.61.1716365377206;
        Wed, 22 May 2024 01:09:37 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm1728517866b.111.2024.05.22.01.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:09:36 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: test_sockmap, use section names understood by libbpf
Date: Wed, 22 May 2024 10:09:36 +0200
Message-Id: <20240522080936.2475833-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libbpf can deduce program type and attach type from the ELF section name.
We don't need to pass it out-of-band if we switch to libbpf convention [1].

[1] https://docs.kernel.org/bpf/libbpf/program_types.html

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/progs/test_sockmap_kern.h   | 17 +++++-----
 tools/testing/selftests/bpf/test_sockmap.c    | 31 -------------------
 2 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
index 99d2ea9fb658..3dff0813730b 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
@@ -92,7 +92,7 @@ struct {
 	__uint(value_size, sizeof(int));
 } tls_sock_map SEC(".maps");
 
-SEC("sk_skb1")
+SEC("sk_skb/stream_parser")
 int bpf_prog1(struct __sk_buff *skb)
 {
 	int *f, two = 2;
@@ -104,7 +104,7 @@ int bpf_prog1(struct __sk_buff *skb)
 	return skb->len;
 }
 
-SEC("sk_skb2")
+SEC("sk_skb/stream_verdict")
 int bpf_prog2(struct __sk_buff *skb)
 {
 	__u32 lport = skb->local_port;
@@ -151,7 +151,7 @@ static inline void bpf_write_pass(struct __sk_buff *skb, int offset)
 		memcpy(c + offset, "PASS", 4);
 }
 
-SEC("sk_skb3")
+SEC("sk_skb/stream_verdict")
 int bpf_prog3(struct __sk_buff *skb)
 {
 	int err, *f, ret = SK_PASS;
@@ -233,7 +233,7 @@ int bpf_sockmap(struct bpf_sock_ops *skops)
 	return 0;
 }
 
-SEC("sk_msg1")
+SEC("sk_msg")
 int bpf_prog4(struct sk_msg_md *msg)
 {
 	int *bytes, zero = 0, one = 1, two = 2, three = 3, four = 4, five = 5;
@@ -263,7 +263,7 @@ int bpf_prog4(struct sk_msg_md *msg)
 	return SK_PASS;
 }
 
-SEC("sk_msg2")
+SEC("sk_msg")
 int bpf_prog6(struct sk_msg_md *msg)
 {
 	int zero = 0, one = 1, two = 2, three = 3, four = 4, five = 5, key = 0;
@@ -308,7 +308,7 @@ int bpf_prog6(struct sk_msg_md *msg)
 #endif
 }
 
-SEC("sk_msg3")
+SEC("sk_msg")
 int bpf_prog8(struct sk_msg_md *msg)
 {
 	void *data_end = (void *)(long) msg->data_end;
@@ -329,7 +329,8 @@ int bpf_prog8(struct sk_msg_md *msg)
 
 	return SK_PASS;
 }
-SEC("sk_msg4")
+
+SEC("sk_msg")
 int bpf_prog9(struct sk_msg_md *msg)
 {
 	void *data_end = (void *)(long) msg->data_end;
@@ -347,7 +348,7 @@ int bpf_prog9(struct sk_msg_md *msg)
 	return SK_PASS;
 }
 
-SEC("sk_msg5")
+SEC("sk_msg")
 int bpf_prog10(struct sk_msg_md *msg)
 {
 	int *bytes, *start, *end, *start_push, *end_push, *start_pop, *pop;
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 4499b3cfc3a6..ddc6a9cef36f 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1783,30 +1783,6 @@ char *map_names[] = {
 	"tls_sock_map",
 };
 
-int prog_attach_type[] = {
-	BPF_SK_SKB_STREAM_PARSER,
-	BPF_SK_SKB_STREAM_VERDICT,
-	BPF_SK_SKB_STREAM_VERDICT,
-	BPF_CGROUP_SOCK_OPS,
-	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
-};
-
-int prog_type[] = {
-	BPF_PROG_TYPE_SK_SKB,
-	BPF_PROG_TYPE_SK_SKB,
-	BPF_PROG_TYPE_SK_SKB,
-	BPF_PROG_TYPE_SOCK_OPS,
-	BPF_PROG_TYPE_SK_MSG,
-	BPF_PROG_TYPE_SK_MSG,
-	BPF_PROG_TYPE_SK_MSG,
-	BPF_PROG_TYPE_SK_MSG,
-	BPF_PROG_TYPE_SK_MSG,
-};
-
 static int populate_progs(char *bpf_file)
 {
 	struct bpf_program *prog;
@@ -1825,13 +1801,6 @@ static int populate_progs(char *bpf_file)
 		return -1;
 	}
 
-	bpf_object__for_each_program(prog, obj) {
-		bpf_program__set_type(prog, prog_type[i]);
-		bpf_program__set_expected_attach_type(prog,
-						      prog_attach_type[i]);
-		i++;
-	}
-
 	i = bpf_object__load(obj);
 	i = 0;
 	bpf_object__for_each_program(prog, obj) {
-- 
2.40.1


