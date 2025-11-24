Return-Path: <bpf+bounces-75362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEC5C81936
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C003AD93C
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C0C31A7F5;
	Mon, 24 Nov 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AQQslhdQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDBB31A05E
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001768; cv=none; b=pd61b6LGRClkbp9w1yO/ct3CyZ+unslLbgowahrvsaxCIphZwfP3V0E06VNwETzwWWNtdTjRe6NhXOSMPwszadHBce6mOIb80I6C324sZEJ+VfmDJWVLKDsy5jXSMC1cX+kK8YPq3tbTFqJIiAuX1FFocsVxSAJSYNYk8+qrGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001768; c=relaxed/simple;
	bh=MU/ruSwdgu7ZTe+KLZ7rC3jj5LdE4ydA2vZkFq3JTy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0D8+QA7eYhUDqyiIBBKBgf2uyG87u+I/41ok/O5MmE6g+t9t/ZmIzOFcnK++2uMRTTq5mlprPYgWJjIdj/jJ5xAZumNFQ+pQjrEuXtRSiN/1I0OHZXKD++tgl9QiuHppYWaiflIH/pY5zrbyp1far7o/ZXIi82KLuKK2KEGgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AQQslhdQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b762de65c07so213309766b.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001765; x=1764606565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENkvBstyOEdyNpek06avXaGXZm24i5NlmDUrQly8KrM=;
        b=AQQslhdQtawxAhleI2i8Ub8kw+lc+qh8PBCHQs3FgNIebI7Uk5H8vYn9DmmQGTtN6n
         QUFjPOVU9MWLRAWMdghvLOKahopZKU4pt7JGN6UT18MC/vmbHzZyW1CSijirF83mG0BS
         l7JzSkT3Qqiafnt5hPhTu0D1W09aoxFTPU7M3JmT838Qs2xwBtyVEpIJPcj76BM+b93w
         5PxN/CawakYfn/fJQa6EEKcn2rFVYf8xCUv8jtGcWgmPmfcj8wyVLBjXui8mEWgbOpae
         D3t4BktI0ocjp7TJzUau8oZCna1qMnPW7yjB3FUBRsbxXuqhCwBmnK0MFanv+bIXeqv+
         NeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001765; x=1764606565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ENkvBstyOEdyNpek06avXaGXZm24i5NlmDUrQly8KrM=;
        b=I/IsmoG+2GC87qMRm2Jq8JalpFKhIPztHLLIQ4nxqfmeE0RUWfFGjCJLCMdzb4MN/F
         KiO8BXhHDtJz7NspK6yFXFKrTTMoTlu0wB6ywa+/axRE9LUGrLU/1ZIhoxdWkQM5/cOP
         iFYup8BYB3CX46/vU/ZvDMozmiXyQYCJmJeb8qmLtuithy0Om7HipQ3XF6/8+gRLk1V7
         wt4wz/6mKfsXtNcgSSlg9cDodjslTDnWX4IFMOgucWcSb9CK8+jWwSYjdVY3tBAUf1yd
         73e5UHIXJeaZcb0MwqNVZrWk4WrcugFtMmZnK94TfyKr0tiu4H9h1nYuZZeU+WrIjR2e
         cH6A==
X-Gm-Message-State: AOJu0Yzrk0fIzGPyee53AuAK172k1V2kDA4FXD7akRWmM5r5Xhz3AE2L
	CpxemlBwFrOn4NCrjM/BgwK2hpBxwO8DPSDE4EG5F5z8JGd+0jbYS1LZvK/KvI4OiOcGV8R6YdZ
	vTSeV
X-Gm-Gg: ASbGnctKNwqsgkxlbKuoaStc1Aan3k2zOILcnok5fr66xEgZR+sX673QC39qrs6DWVx
	YBwWdwdcq12xLhrEPfnbD7IhwDaFEPHV0GUmhW89dh8khIcMPZRQyO7am/U/l7UJWUx+pY/A+3D
	wx5tUaa919BeqWdrKNQyrHOsoiULefevuWwjJMYrN/QuaH5TFICnK1Hftw/YxB4/FQZ4If2IVYl
	WRdOf+ejcJyFNdUDYqm1eqzysc+DCbvSy2urHuRjIaJvXuCk780usHXdLeHZHm/y9YNM2OF6+VH
	dVNoezNbPMNdFeA6P0sMtFdwmrSXDpzbQMKj2pHrC5oPn8R/vwV1I6TIfmyc7F/TrIs2cQEjkTP
	Nq1UyTopAw9eRJrJjof3GvewMsarCBvgXIOBKBKS5uUfX4DXLzLCjCluuwLvqrwJqNWZlZ3HC+L
	QbgeIQgUZkB4VSI+N9nERTYZdGfUKBPb7ynx0j6S3gNlq+DBk7Eb9MuKllP/CfOsA8mHo=
X-Google-Smtp-Source: AGHT+IF5xyurXXP0BA3FnD2djf88fsra58fuq/X7FDvmpHwNNCtycxL4hKHkxP7dPH1k5xAtqUafwg==
X-Received: by 2002:a17:906:fd8a:b0:b72:af1f:af7d with SMTP id a640c23a62f3a-b76716d9f65mr1434344366b.29.1764001764907;
        Mon, 24 Nov 2025 08:29:24 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7655050d05sm1311431566b.70.2025.11.24.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:24 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:48 +0100
Subject: [PATCH RFC bpf-next 12/15] bpf, verifier: Turn seen_direct_write
 flag into a bitmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-12-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Convert seen_direct_write from a boolean to a bitmap (seen_packet_access)
in preparation for tracking additional packet access patterns.

No functional change.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h |  6 +++++-
 kernel/bpf/verifier.c        | 11 ++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4c497e839526..42ce94ce96ba 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -637,6 +637,10 @@ enum priv_stack_mode {
 	PRIV_STACK_ADAPTIVE,
 };
 
+enum packet_access_flags {
+	PA_F_DIRECT_WRITE = BIT(0),
+};
+
 struct bpf_subprog_info {
 	/* 'start' has to be the first field otherwise find_subprog() won't work */
 	u32 start; /* insn idx of function entry point */
@@ -760,7 +764,7 @@ struct bpf_verifier_env {
 	bool bpf_capable;
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
-	bool seen_direct_write;
+	u8 seen_packet_access;	/* combination of enum packet_access_flags */
 	bool seen_exception;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64a04b7dd500..4c84b0cd399e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7625,7 +7625,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 					value_regno);
 				return -EACCES;
 			}
-			env->seen_direct_write = true;
+			env->seen_packet_access |= PA_F_DIRECT_WRITE;
 		}
 		err = check_packet_access(env, regno, off, size, false);
 		if (!err && t == BPF_READ && value_regno >= 0)
@@ -13768,7 +13768,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 				verbose(env, "the prog does not allow writes to packet data\n");
 				return -EINVAL;
 			}
-			env->seen_direct_write = true;
+			env->seen_packet_access |= PA_F_DIRECT_WRITE;
 		}
 
 		if (!meta->initialized_dynptr.id) {
@@ -21200,6 +21200,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
+	bool seen_direct_write;
 	int epilogue_idx = 0;
 
 	if (ops->gen_epilogue) {
@@ -21227,13 +21228,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
-	if (ops->gen_prologue || env->seen_direct_write) {
+	seen_direct_write = env->seen_packet_access & PA_F_DIRECT_WRITE;
+	if (ops->gen_prologue || seen_direct_write) {
 		if (!ops->gen_prologue) {
 			verifier_bug(env, "gen_prologue is null");
 			return -EFAULT;
 		}
-		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
-					env->prog);
+		cnt = ops->gen_prologue(insn_buf, seen_direct_write, env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;

-- 
2.43.0


