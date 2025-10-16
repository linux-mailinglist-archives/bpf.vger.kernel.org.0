Return-Path: <bpf+bounces-71108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEF9BE2CD8
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 12:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06891588283
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75372303CBB;
	Thu, 16 Oct 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuklueQF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3A63176EF
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609666; cv=none; b=m2Cz5scip2u2U6a1qtF0PTG3C7MZuScexIBfy427KNC6ACrxWQhbjgdduJs3ca24CoCMECbRbbFtGi6RiFKb6U2c9y/iBb6EqzUwiGuV/9CPLE4RNFeWq5gxQz8DQ+/am3TqPIHvca3dZzmdPNqFKV0SoToq1rV+TLquw4oqFQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609666; c=relaxed/simple;
	bh=XZKUAjyZgpvAwblfyeQgsopbnMMEUhfjgY6Tm3Oz3L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZ+yvR0zfEOl6YBYd6pfgR/+knYKegtFFcDrYE79kUnKhrNe/zFOTdHe5QoDfVur/fy5VKKrUZPovVUMXAOG9+gv6f1oTUJGVGzzn2E6SLVNehFUeZWmTLOcVrmVZ4/ksm7h0Ryn05Lw9jp/wL2U6plBRNTo6w2IxIUmHw4zKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuklueQF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78af743c232so536739b3a.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760609663; x=1761214463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9sq1sHLY+EjUWXH8CqIvCdYzysiw4Kh2V1/GcaOrnU=;
        b=TuklueQFbB9ktvs+CKwyEFk4I8KKCHOjrGSuOm4eby7zZ4VOpR5je9TfgPpHy4Q5A8
         OpALjg7i67fxFxkGRX1bPm0PoNsXGu8DnInYlChxSeF/8LbnA4TcCrW1fTBWC7O0gWFo
         2h4ZMSBgDwpJneHHgqpjjiKw1pVBP6xWWIHmvELopXJGlz2ooMr1dD9fGGCtTPBFtu4J
         79AEDEEM81CEhMFmXwr6hvB53EU4YrY5Oo0h95Bj6dgJtc9xDkZ4rsRf4wnQ1y8EjyE1
         xMRak37wjJqpW+5ZIiPSWUhCE6Z+7fVOM6z4quwPgC53zKaSSlRHC8tMdihUb00wr3bV
         DAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760609663; x=1761214463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9sq1sHLY+EjUWXH8CqIvCdYzysiw4Kh2V1/GcaOrnU=;
        b=YlGX1qeE7wKe/jM0nq9czm3FLpQ68ZxwXXRQznoo90snkWfSQ5reEjp35oN621ZzeD
         3KWXu3YYDPoDAYp463qBUetL4ryyuBbSs0Gpb3S7axPhOcvZIrOPCXT1hoGeBx6Y9Vtk
         /jONRNKVLZcB7VqGgb8gDlgX6U8+gkz6e31CW9ZjyjKAhcfkXd55QRV81BzGjvEeApfA
         qqf/VE+Q2nWLAkXqITc7QKGITfxTaBtW9kzw4vZrAIzfMtmeTfMD3PfhWILYD593B5C7
         F8VTcnJQKXBpOTRdUMW8c3V9cNkM1W1zqedQt19IEFi/FoIbRu4A7iSdDYyCiQPjboaL
         3BgQ==
X-Gm-Message-State: AOJu0YzCp1UM35gUGlArh6c0WAlysqW3utTnijkv49cBCJTUotsW16iV
	2xP9b+z6Op3tW+/qHvG7Tm21F2DSoqoSsl3ZGP+9Bzq1M78y2AlewxQn8wMzG7Wu
X-Gm-Gg: ASbGncsAyxRzuuX+UbIWfpunyuXn8WZ0CPBw9+mdGMEhGxF0Xpc34zCXXRwPUgVHJxX
	WtutpELgJV9gyHWZdsTpmQHU/V0IjAvRWBFVkmToNPejKAWQbg30p9El+VQaqMaWDiV+7ZMU34R
	01ysrH6DtoMJykRIUMOpwREMh+kcEVztMgkdarPyoi13Ac+W4v0T0ul7t9xVrKHjFndHsKVrqnG
	8K4Ujx0n7eLAjke3PBprJ6OlnoPP05110C2LZtJCZBbq1903oak4J8S2BHLekRXiT+iv60t7W1J
	LxzxEVlq4xUk9U4WojIeqw7ht8eSQ/bKrMRVq/AGA9kNXxxThG7k1r1v1DpGYHjh6vsSJ3Y9Cqe
	rxEvzo2GwMvws0Iaa2jRlbpjLrcNbWMlI7MgYQ8WA1M4/Lzb1hKbmxm/ODRQZGVg1I2YnjenlfE
	YrlILjgpmf
X-Google-Smtp-Source: AGHT+IGLE/qfueQx2g3nGpqw2YlqTxW+JhbVxunJJ+/Wqm2YsG92PSaHEbFuJXHHMe7R0GXRUUe5bg==
X-Received: by 2002:a05:6a20:4311:b0:334:a198:e5e5 with SMTP id adf61e73a8af0-334a198e8abmr1388680637.20.1760609663534;
        Thu, 16 Oct 2025 03:14:23 -0700 (PDT)
Received: from Shardul.. ([223.185.43.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2288bd55sm2354263a12.9.2025.10.16.03.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:14:22 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: bpf@vger.kernel.org
Cc: shardulsb08@gmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf 1/1] bpf: liveness: Handle ERR_PTR from get_outer_instance() in propagate_to_outer_instance()
Date: Thu, 16 Oct 2025 15:43:42 +0530
Message-Id: <20251016101343.325924-2-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016101343.325924-1-shardulsb08@gmail.com>
References: <20251016101343.325924-1-shardulsb08@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

propagate_to_outer_instance() calls get_outer_instance() and then uses the
returned pointer to reset/commit stack write marks. When get_outer_instance()
fails (e.g., __lookup_instance() returns -ENOMEM), it may return an ERR_PTR.
Without a check, the code dereferences this error pointer.

Protect the call with IS_ERR() and propagate the error.

Fixes: b3698c356ad9 ("bpf: callchain sensitive stack liveness tracking
using CFG")
Reported-by: kernel-patches-review-bot (https://github.com/kernel-patches/bpf/pull/10006#issuecomment-3409419240)
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---
 kernel/bpf/liveness.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 3c611aba7f52..ae31f9ee4994 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -522,6 +522,8 @@ static int propagate_to_outer_instance(struct bpf_verifier_env *env,
 
 	this_subprog_start = callchain_subprog_start(callchain);
 	outer_instance = get_outer_instance(env, instance);
+	if (IS_ERR(outer_instance))
+		return PTR_ERR(outer_instance);
 	callsite = callchain->callsites[callchain->curframe - 1];
 
 	reset_stack_write_marks(env, outer_instance, callsite);
-- 
2.34.1


