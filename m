Return-Path: <bpf+bounces-68430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338FB585EF
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C643E1AA7EE8
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0226296BD1;
	Mon, 15 Sep 2025 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrxUnhFK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9928E5F3
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967512; cv=none; b=uAZGBJWBefOHmiBMlLuOego/zFIoK6V7yrJfC0D5x+rM4EhgDM8HUh5Q4kvfsLbUDuemQrwfIYuojCBY/g/BLG4SXfF5RHu5hfLYeqfn0rHZasV0S3SxEmn2imsuy7hJbhEzd84lp+mLsiPjHw/uxv/9ukQuXse6QEnR/9UITfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967512; c=relaxed/simple;
	bh=jJxfQAIAeawHrlM8HB+9w3p+FhRjrERCG8clbn962Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvcbRAL25Sc/wbddPhPkoTBic3LODPfyRA947SxukDuXPRyrx13GSOE8XjL0iya/ds9boUCh/URb+g6EjA/KBTFU3FbdscgU1Ww70jAQYVk6SNfENG0AFoG7vKN46mwm/o909BF/5Uq79m6or7ptCh0cX6/OmzUIBmopH2ENvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrxUnhFK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3eb0a50a4d6so809969f8f.2
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967509; x=1758572309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBsfCYBMxcQs0BGoUzmNavxiF2HmrEjFLzb4hhUmUOQ=;
        b=KrxUnhFKHFKeWlra98PdkdUAQkpXVqhXHwo96IjxJRGE5WQ1bsFIdUMhd6YGTWYt7u
         47+CDwiy04oP/GU7iP/gSVdIFaRluyYsWYRPUgZVJBeb8U31W2TZTj+BXspd0wuXIQKO
         5R6DkKL6DC3UFEu3NcCN+pSPiaRlUOVkUxj6OwkkLa9LuASEUFEzDLkKZkWPZtMn7e84
         rDorQga9c/Fb3sDkQy997z4l8oMJzFsHytU36As8g+bu8wAFBU8Q74uDSfFZ3tReE1dp
         GnwWekg6Ck7CZ5ewE/hI0fwnXtg5/YfndhWIRITYNXgOezv9Z8lMDFLfABwCC4JgKz4D
         0S4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967509; x=1758572309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBsfCYBMxcQs0BGoUzmNavxiF2HmrEjFLzb4hhUmUOQ=;
        b=Va2lDI5zEVrGp3DK/ETRHKF88gVI/kt+QIPwNjwnLQvzO1lfasrX0z/RfzYhj3Boo0
         ZCT4F0FALzoQ+wmpz0hfePrpz3qO4YJnmcDwvJMYCGFK86cnAgKEQuj+JeyseloIKUeP
         H7jDVBbm9SN8CQTQNFuayhZsGdlKaOpS4D8Bcg4nrX8YREGKktHhvOJRd0Qu/Bc0qyEw
         idrs8QvF5n/OiT9W9Ck9lE5Vc+cC00ZyTkcEdCqcv6MUfVb6g3qxrrwLrgVcJjXk7E20
         j2l0hsDfW8xmNhYnvivgEWjyhHMymxYv0d++QauAd4DxBfYLuGTtlRq7K/cS9QxASbqL
         Cnlg==
X-Gm-Message-State: AOJu0YwpN7mgW6McOwT4zJrRHSoDpCMkNm8Dzprxg7+mzoxnqn9+fCjV
	ChAjcVee4DIEaYvfSFv0hA/W4Ry3CfrxczDmnHsMaVR4BwJiGlLHAX1P996ulQ==
X-Gm-Gg: ASbGncuUBEJJXgnCaCbxA1kh6sUWyw3U5B/AeKxqRi+WGgVp98Qt6kT3A/7IXsNOQXj
	D7Buk8IwA5LFuVEKB4scw3fiecFRtuDeORs244685WSfFfUlbEOcAbJuB5559m5fjKZfu4MpUTP
	GrL39RJPAnFy7160/erF1Y5TrjV0XG208rk/zwByJ6IEJfueinp/eKjneEsyiJDL9QtlrZb8y8Q
	tsetEE5+fJmgHwCJUtdcy5+iGwmSDTkpFvVvNk5f2T6cV+6fs/bTxv9ywHFmxzlcSYcWQDKn0+q
	XcPUirzXzbHhNeAIhFYCjVYgWlcQ8XCdjMVRoP1NYLoWDcWKRNeKIazeV4Pfmcrctv31+9F+8mo
	5ANU=
X-Google-Smtp-Source: AGHT+IEwIaQpLmcXTqrKSajlEONVXY1XW4wRyRSKrditFPaGgw+LkZGfGX8QyXRliW7yASJnZhUpIQ==
X-Received: by 2002:a05:6000:2909:b0:3ea:f093:97d2 with SMTP id ffacd0b85a97d-3eaf093a09bmr2864036f8f.1.1757967508898;
        Mon, 15 Sep 2025 13:18:28 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:388e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7c778f764sm13866401f8f.57.2025.09.15.13.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:18:28 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 4/8] bpf: verifier: permit non-zero returns from async callbacks
Date: Mon, 15 Sep 2025 21:18:12 +0100
Message-ID: <20250915201820.248977-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

The verifier currently enforces a zero return value for all async
callbacks—a constraint originally introduced for bpf_timer. That
restriction is too narrow for other async use cases.

Relax the rule by allowing non-zero return codes from async callbacks in
general, while preserving the zero-return requirement for bpf_timer to
maintain its existing semantics.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ede511ac7908..102e72c8d070 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10863,7 +10863,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
-	callee->callback_ret_range = retval_range(0, 1);
+	callee->callback_ret_range = retval_range(0, 0);
 	return 0;
 }
 
@@ -17148,9 +17148,8 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	}
 
 	if (frame->in_async_callback_fn) {
-		/* enforce return zero from async callbacks like timer */
 		exit_ctx = "At async callback return";
-		range = retval_range(0, 0);
+		range = frame->callback_ret_range;
 		goto enforce_retval;
 	}
 
-- 
2.51.0


