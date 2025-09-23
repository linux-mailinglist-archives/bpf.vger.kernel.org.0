Return-Path: <bpf+bounces-69390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A134B959FD
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD3C175AFE
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A530321F35;
	Tue, 23 Sep 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXzu9wGg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DAC2798FE
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626658; cv=none; b=E6wUFFiigvydKHPpI573uVXYWKip3s7HFa5DhqEr4q3EnSUt1DC9pPHtnNWLQy2x7d95M6YbZFhxtO23JOP0xQgzA/9arPW7Ajwpj8Lny1uD7AjKPm+yEnLBHVndJtGhfmgMQ1AYd5eL5EMrq7y3AlbdvD9mD/sXdTIzWPE31N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626658; c=relaxed/simple;
	bh=euNRR7wbhAiuC18PF0ukCwK5eyZUvqLOkaetm17Q9P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCJvjPaGNyuYVznRJX+WFOnT7uduqSKaAXkep7XQXaTp/1QOJYj6aO0rJsTZBbrrCkWwuqHYi2J4sIujBSaXnGBlnfw43kdBW7J6qRDRTVfeZJhZBPhDOolIULlgPfnR+WnXOogKORD69lhmziBgb7UVRqswZJfoEkzp+dvvQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXzu9wGg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b2ac72dbf48so386041166b.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758626655; x=1759231455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmKVr/w0x3pxJDEoXBazT76mX7dk2HdObRjMF6wmewI=;
        b=kXzu9wGgRN5DFlN2NSrDX6+Jd8iuMiMaMoZ+PQODz/bxJpkKCXkvhY0HArvEKPUMDX
         nLCIKmO0wXxQmd8QZKQ7InjY5MJNNv+SZpsW/BcBL0kd3oZYnyU74HdyGuumg3Ehi110
         f9REWDUJ8aECD7VQwE69dOmrMY7QHHlvB6JqsqYPv33Gkk7rutAx6PtTtTYmxnWnUraM
         ERcDeQbNRlRlZPoDTcK3MNoeDtAeZ1AQ/VNNMj7cFrdNZQk5ZIEGpKL0xGfTZSpdxJsH
         rVd6d/JbfdYNU8uV4B6t+hopsOKv6BHYGbcheRhIen5YMagO7I9CRSJnJCxgnxAW9xWc
         ecHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626655; x=1759231455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmKVr/w0x3pxJDEoXBazT76mX7dk2HdObRjMF6wmewI=;
        b=ODOOEOEuCn5dqyrAlxsaQ1qVf5mKM2gk+jPdHdd3GwwFLKUl7V9KDhnpUEKXV2YhfO
         6cYqnM8E9n39tIO2S8f9kmXH4hQK//+rGiC1WDYQjqEFBlAna4ZoRFev9lqaEcsMoxK/
         AtVc/fyTcS5nu40VxKbiiuEh+bVH9MQ1gsAYfnfoTsv5i0LLDEuWLNost0xUwIPOVb9M
         SLIQORX8/ZiHG33L+M8hUN4AYdad1S+8UDqxZX6rHdSWl1xOOneVTxelEJec4br1vDr7
         c//cnlQzfpc/ICo82gghnrdWDUaoR7M7BoKKIOGxVy9kJ3YhKCrly1Kr/e72vRbwIO82
         1f3g==
X-Gm-Message-State: AOJu0YyQ43I8UTtgtlANspeLRV3YO2PoAoKNbW+lHyrEQMBlNY5Ul9sX
	OBeDVn6CLVSAVoDvJypfOkcB3+Wp9VdbrYL4O2zj1mq6aynANUs3+TdJ9+++EQ==
X-Gm-Gg: ASbGncvZyIIvzAGnY4ZIJG8OhC0dUZ3TzBVpJQIOsXf+R2geYYJBEO3mG3BVDh4WY8s
	7gQ6MLbHx/PFdyNwQUJamXmuJ7a3A3ZeFBOJhZAXLyAl7xCqNUzhCtVeendzLXicETJJupKPqp9
	oa3GUliTVunup8849ggDY7BDWMUkH3OEd00VMiNwa4q0zPn+nCTxVoGEjUzxauq8XVMzStv4DmY
	rKbEIUVaNi6tEoKUGXBf88Br4XRaJdNdlHoNtym9yR/vRNO24fprzmVu3x7nWZK47SKOEEUlLcS
	UiBP7bPqvfJXrDa5V6Qblboe+xbgfGBFtXt3i+O8Mf8TOVJtyOP2iCoh6o1jI/KhqAkm/jwxZz+
	a5Ab1RLX0D9n/y2v3ISKh
X-Google-Smtp-Source: AGHT+IG6xBb0lPHig3qbMCJe0TmdKVlMMfh/dscMArEju6Y8k3JuJPHLCS3/breRVSNh5lgQklYCFg==
X-Received: by 2002:a17:907:d2a:b0:b23:f884:fe72 with SMTP id a640c23a62f3a-b302a36d221mr228116266b.41.1758626655342;
        Tue, 23 Sep 2025 04:24:15 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2890e04727sm778994766b.4.2025.09.23.04.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:24:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 4/9] bpf: verifier: permit non-zero returns from async callbacks
Date: Tue, 23 Sep 2025 12:23:59 +0100
Message-ID: <20250923112404.668720-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c1b726fb22c8..02b93a54a446 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10789,7 +10789,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
-	callee->callback_ret_range = retval_range(0, 1);
+	callee->callback_ret_range = retval_range(0, 0);
 	return 0;
 }
 
@@ -17073,9 +17073,8 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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


