Return-Path: <bpf+bounces-76223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEB0CAB004
	for <lists+bpf@lfdr.de>; Sun, 07 Dec 2025 01:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F90A3005D1A
	for <lists+bpf@lfdr.de>; Sun,  7 Dec 2025 00:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394C2223708;
	Sun,  7 Dec 2025 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaHMxPIi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D43B1B3
	for <bpf@vger.kernel.org>; Sun,  7 Dec 2025 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765069161; cv=none; b=pnkzpBruWJ4qg2oSWGL3lGkhAuaVp1JLj9GX1od8N35vsEXDz0FDjwSh3H4q5M1wrj3APgeaC8oEBKzqcIPCAZWchfdszSYo1uTDFJHk8eV/433Bxx9RJOEhsPlxEVQZRry99yqFwOenNizclRhgFrhkJoJ+hzM4zBfM0LTOoD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765069161; c=relaxed/simple;
	bh=MWDcoEaZBld9sF6nAi3ARegK8avBgoLPbI6vKwGxo+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CeT/8F1cSbyUBWetLloHtbykxGpmNXchaEpzVnV5J9Vc9Re7wK0BK3KLYY6Fs5MaeZccZnXojhAJARLK1Sma/vahT8yPsnPm9ugniGdZlTdWKKz3HsGyhwV/j65mM6VNeeaQzJNYxq7ZFPPERXDZYVb2CeIJqoEY422w1rs4iDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qaHMxPIi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3418ad76023so6185284a91.0
        for <bpf@vger.kernel.org>; Sat, 06 Dec 2025 16:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765069160; x=1765673960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kj7dkP9NNW6e9vRY2sGlLEE2gXDoRjkkjYPm9DKp0+Q=;
        b=qaHMxPIiZISxMMtv0Yo0IJnUxsr/0vZih8IzN7Fg+snx77dql5WrcaQAaGYWJgiz7e
         fWv6Xuo630axYScu9UQPFvkAfnWVRI2FZZdOUsKwC3Trl9owGi7gbCvpxkon+kchM2Qx
         83HZjLnVPOG2pfoPOCy/g0VhlimvxYChKJhGW6K3Hu0BmGoRBzUa2a52LY9Qsmz0aJWU
         hV1p202r9D9sdBH0KVuZzNofLvSdaw2TLdD5KhONv3MO2gJzNKtlN/eUzQs0fOwsRaYy
         LQx7bj64Pvx9tt/YF10lXfe8+f2pW11XcPFlvjy3GrpxTkCUtEtCVA7NnOBAYf/CEIVI
         2u/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765069160; x=1765673960;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kj7dkP9NNW6e9vRY2sGlLEE2gXDoRjkkjYPm9DKp0+Q=;
        b=J9Kco87U73zEd4C2VFLNHXVW8g+2q0uM6ivpKJm0M4PVREYphDCw8+1JUTnwFoV9ho
         /NCsg7wRRogV4jk0e4x45rIet3iEiWggg5XLZhvjDYZfUs+RD8Hio5/mxN+Zv0LF64jp
         GiyP1g/rwpPpNaN/0EKz2XgFisEXtsstJVwUAvg2rcJJlF/sj//13gKtCzkWDD4SlO4m
         TJiiwHs+WN5oD0kva0liIwR2FSRH2w8NHRDKQX7oHR16lll9hDqUKEgY4zKp73Nkfup5
         pMzGKC9AMzPOi4qphreA+dchND/udkvGD3Glq6S+iPXfnqWG7OlHd71/3JNuS1nwQ33E
         OPTg==
X-Forwarded-Encrypted: i=1; AJvYcCU7D5n1w2fcTy8NZKvC6kiMHkclqrsO1kVqXi1yuRcRcBzMF1LTe7RUnqA/BGh6ocjecrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9dKx37OiJBBYFwvb9bk1DtbgfpW8P+lcL9no/yOmlJTDzrdkM
	v2Fqk6TbE5hhJDERKwFGFdqYAge/w8V5brz1ZCf9zuESi/z1N6KNzYnX77dKPC5P4BQMXwxLqhZ
	HxKy+EEvMnVullRpo0w==
X-Google-Smtp-Source: AGHT+IG/C447rRuzlsy1KSVQvrFMYcRJl5tZgb7pSTMiC6QJ6fcFSbiwndmDV9iDEWwjc+kmF1iEB6M0OFk84zU=
X-Received: from pjis4.prod.google.com ([2002:a17:90a:5d04:b0:340:b1b5:eb5e])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17d1:b0:329:ca48:7090 with SMTP id 98e67ed59e1d1-349a2611eb4mr3106514a91.37.1765069159635;
 Sat, 06 Dec 2025 16:59:19 -0800 (PST)
Date: Sat,  6 Dec 2025 16:58:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251207005854.2708338-1-tjmercier@google.com>
Subject: [PATCH] bpf: Fix bpf_seq_read docs for increased buffer size
From: "T.J. Mercier" <tjmercier@google.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit af65320948b8 ("bpf: Bump iter seq size to support BTF
representation of large data structures") increased the fixed buffer
size from PAGE_SIZE to PAGE_SIZE << 3, but the docs for the function
didn't get updated at the same time. Update them.

Fixes: af65320948b8 ("bpf: Bump iter seq size to support BTF representation of large data structures")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/bpf/bpf_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index eec60b57bd3d..4b58d56ecab1 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -86,7 +86,7 @@ static bool bpf_iter_support_resched(struct seq_file *seq)
 
 /* bpf_seq_read, a customized and simpler version for bpf iterator.
  * The following are differences from seq_read():
- *  . fixed buffer size (PAGE_SIZE)
+ *  . fixed buffer size (PAGE_SIZE << 3)
  *  . assuming NULL ->llseek()
  *  . stop() may call bpf program, handling potential overflow there
  */
-- 
2.52.0.223.gf5cc29aaa4-goog


