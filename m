Return-Path: <bpf+bounces-76735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462DCC4BA8
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FE313095E6B
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC6327C14;
	Tue, 16 Dec 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="KHfvUQAg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE83375DC
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906514; cv=none; b=mYv4IljqGWd6XQ1pPdLEW2u0II4qwwgMbafxyHE/6EbJZhdcYz0y3LjmsBNld4V9RW1CJFQPgvU7XRJ3ouFMckGKMQ24silyVbEG1EzJANWooIQ6bHfXsNWZF732a0RHHMxdB3eH3Knmz92ClBJQjhOWNfQwaWS3as79b43H2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906514; c=relaxed/simple;
	bh=2RXuEa5am+FFyIud2GJwTyr5WW56doIqLLNJP70Pmek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bARiqhGXTmGE9y3MpFlxa0jVVZt+jZM75ykR1O34OLRoqEYFctTx1Fms0DzUvMfghsyUNuIhvYNWuaA9GbwsiILklUYsIxa60qccR4stxCQrl9pbI5anWpTGbhNEezbkKAE8zObEZaKds75wxJF/t5W18whp0Y4jtfU/2IQHAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=KHfvUQAg; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b31a665ba5so609644785a.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765906504; x=1766511304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TNhiDPJP+7Z5E6ak1pG5pCZL0iqasaqxwDSHMHV9zY=;
        b=KHfvUQAgwN1XeJLiKKJ58Kid7klPNZUSKvxzGJWtKKRfJFvfVJYz9Vsr4NOs0JGhqB
         p7sCwv+ShIcqEo2tIVqOe5NR8BgCQJCL5sa06IVk8tMMHg+ICTNK4BYj5yr2Dao+ZPun
         xxT89e31Ihvi5eNSRgtR6BrB5fdtxzaBknc5tGQIo23CKaMFkM0eMc49axe8xk8sL8Jc
         pHvAs54lfOLeEJrbkAEoUWHdBNgSxHiSiJo3++UXuOGLDI15t9XvOQVYza2BIrqm4M6Z
         2M6N0nsJsYLQdEizQM0vJjcdR7SKszMqNee2OxxQYdSYG3vBhNN5FsTbQQuoTY4oPN/4
         kB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906504; x=1766511304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2TNhiDPJP+7Z5E6ak1pG5pCZL0iqasaqxwDSHMHV9zY=;
        b=np4mCXEJ8fpNr6WPEhaZKLB56A+LCDKSGD2bnU77r19L/NQrjtk94impHtvJypYjdM
         jWxBIHktDYFPSau4/8R5Us1DAkg6o6h0MC6rQxNgK2xUxKiOKQTXFCyCt6awh2T279pP
         U8tn5+a7NYeO+ZNFVPTOvDhMDIUf7/QgjwGtgCGLeiuJQVGWkC9tF9KA2ZwJiElY7W3A
         gx2WSLPPaZGPD/UxkBrxBYe9qYuTZU8BRHU/n4USb9/xwWZPlpT7ajitET5guYVpgGaW
         TEL5qMQHTBw10asxTFvATR1C6NMJKNmFNEsVA0vo1tRjgojQbIn4c6esbn9XR0f9kkvV
         32qg==
X-Gm-Message-State: AOJu0YzoHxnAvEEOmv7AwZTaoQ5mZG7Kq+dRFrY5w4rMsh9iiWpyldKP
	EU4kxmP7Xug4GB/4eQ0YCjWdPe1un/dO/wBQk+vVscUoLaiGnXKQ0nCxyFejJYO4oNx7Slgxus3
	iHXS/XsA=
X-Gm-Gg: AY/fxX6En0uDLtvYF6nJfXicIOrJ5okZv6sGHvxqEjjWf8FFdNClY31rfhpXBanF0CJ
	aohhlHKcKBBHTiDB12W6JNHj/i67M81KOMAI4kZeiMzev7xFGOWwvis8ThmkK5yfEElr0sef2fG
	4dqMhmN6yEUVAPJMOSj/PRShGJqpe/Sl3D7NqJgbk42ahDj+TqRBw8Goz+Yyk//aqv1mKUM7lK0
	cxOcFT4IAMk/ZQ3SiZkdGPkHjdY8+ZBBkZqaXAl1DP20Thr6Q7ZjISXLVym6N/pli9cSeeg1CJR
	KK9CuVwJ3YaIBF36fQmgiexinlUGTaPowmJZtRO8hLGaz/9USKUsVYfSRi1oN/CDHT/Vpf6px7S
	twJqsl0cxye/RZPcsbYELx50d67bqJMQ+QAIl1ceSDX+yMK/3Pe+BMKGIh+BLbiP2DeHI6TY5jH
	pqmGdqGk41jA==
X-Google-Smtp-Source: AGHT+IHG6qcmZwioPntBm2M+MFfNAf6M6ZQYu9MPdrQWCRwhuZZpXtSf/63gym2qVefYd2Vl7pYH/w==
X-Received: by 2002:a05:620a:404b:b0:8a4:e7f6:bf57 with SMTP id af79cd13be357-8bb397db7c8mr2403362985a.5.1765906504032;
        Tue, 16 Dec 2025 09:35:04 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a860f8basm79310456d6.56.2025.12.16.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:35:03 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v4 2/5] bpf/verifier: do not limit maximum direct offset into arena map
Date: Tue, 16 Dec 2025 12:33:22 -0500
Message-ID: <20251216173325.98465-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251216173325.98465-1-emil@etsalapatis.com>
References: <20251216173325.98465-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier currently limits direct offsets into a map to 512MiB
to avoid overflow during pointer arithmetic. However, this prevents
arena maps from using direct addressing instructions to access data
at the end of > 512MiB arena maps. This is necessary when moving
arena globals to the end of the arena instead of the front.

Refactor the verifier code to remove the offset calculation during
direct value access calculations. This is possible because the only
two map types that implement .map_direct_value_addr() are arrays and
arenas, and they both do their own internal checks to ensure the
offset is within bounds.

Adjust selftests that expect the old error. These tests still fail
because the verifier identifies the access as out of bounds for the
map, so change them to expect an "invalid access to map value pointer"
error instead.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c                                      | 5 -----
 tools/testing/selftests/bpf/verifier/direct_value_access.c | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb7eca1025c3..dbb60d6bb73c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21136,11 +21136,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			} else {
 				u32 off = insn[1].imm;
 
-				if (off >= BPF_MAX_VAR_OFF) {
-					verbose(env, "direct value offset of %u is not allowed\n", off);
-					return -EINVAL;
-				}
-
 				if (!map->ops->map_direct_value_addr) {
 					verbose(env, "no direct value access support for this map type\n");
 					return -EINVAL;
diff --git a/tools/testing/selftests/bpf/verifier/direct_value_access.c b/tools/testing/selftests/bpf/verifier/direct_value_access.c
index c0648dc009b5..e569d119fb60 100644
--- a/tools/testing/selftests/bpf/verifier/direct_value_access.c
+++ b/tools/testing/selftests/bpf/verifier/direct_value_access.c
@@ -81,7 +81,7 @@
 	},
 	.fixup_map_array_48b = { 1 },
 	.result = REJECT,
-	.errstr = "direct value offset of 4294967295 is not allowed",
+	.errstr = "invalid access to map value pointer, value_size=48 off=4294967295",
 },
 {
 	"direct map access, write test 8",
@@ -141,7 +141,7 @@
 	},
 	.fixup_map_array_48b = { 1 },
 	.result = REJECT,
-	.errstr = "direct value offset of 536870912 is not allowed",
+	.errstr = "invalid access to map value pointer, value_size=48 off=536870912",
 },
 {
 	"direct map access, write test 13",
-- 
2.49.0


