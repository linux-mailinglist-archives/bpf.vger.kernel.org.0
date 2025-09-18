Return-Path: <bpf+bounces-68787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21344B84CB5
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAECE1B2819C
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7530BBBC;
	Thu, 18 Sep 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neVfh7W/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A030BB9B
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202000; cv=none; b=SPLW4zyUUIQokYbz63wErq6zsygFw3A+YFcraN0Thz1qMAYCibckg0g8T49T7wKtD7ERPNySkp6Y6GF7xrs/xkcqpLXguWrn8x/vy0yP0kSDCKrUtIF9s5JsUGh1pcSiQ9GtEPH/K2wmijkvuG/OfG/bXFan7hR6WCPoUJ4w2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202000; c=relaxed/simple;
	bh=WLQhKDREo2RAENJYYs8VDrXuG5NYYNtWRbQazKEka6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmRFjPhRMdQMpKL26B0Li9h0zv9/pqa4AocSK4szZH8gIHlD4Md0kyVQTTWPDg9ZF5u6V/FG5Ys23djEM3J1Dk79GgtCZB+nO0eZ6+QvkMerDjXR9PFprr+Avmq9NDaaXJ98Nvov8nT9aCPADZBI2JxPQFzQ6zseAwj9kQq+ug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neVfh7W/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso1096753f8f.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201997; x=1758806797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEas5YMy4Nr2kGQlDLcxSP6baVxKjiGSHJ+wDahafz0=;
        b=neVfh7W/PCjT0CY5UfTX1hNY89myoK4ysEXjaKNHSnHW6EuNrnQ96FqMmHn0awvy+K
         bmGXRl9ycLjKxhbed1JT9nuPOP3HWRYfytPF01+USsmj/JAFk9yS4WgjIhTjEC1BNE9c
         Ud2qHL27gnBMSURPbZP2XVnE7kDkcnUYS2rSWZrTJQxJjYV7O8nPM18TXOk8FS09VSmV
         /Li2s5jx08TbeUKdEUwQHBeKbbAcf9+rSj3iHABItaFLBISOQ8LuoqFN32Ulyd8zzsfq
         pM0jTdPmuxXFkx0oxsodVHNeWgsmszAAJWdg70vNA0jnLQig9X8NXaA2otrMaeT+fNee
         yF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201997; x=1758806797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEas5YMy4Nr2kGQlDLcxSP6baVxKjiGSHJ+wDahafz0=;
        b=jtMXGGouwg6Jp/UD4XfhLK82HFt7Oh9aP2frf/sIPK8XucDAtCvUr1KUPuSoHzTlfZ
         HdUXDuAR6llOnCqyn+hphlEsGMswP/ecpK9jJqTdrG/VGQAXCSKtH9vrvzLAn0m60P7e
         WVDpfrS7WcHgnzXAAb/cFKRc5ra3Zgk3L71GXOK4UFIxAtDUg51A7MQCrdduaAX2tBMu
         c+OlS+RTaasCXB3LGW71JcbVRIsexyyEQnlTCc/0yeZW7P9pjAGaoJHdVvRnmfP/KA2v
         tACTqLV/ogUhrNX9NAw9Xc6La2teRAQ4eXV+FsjLfhHb8N9NapchFsq7SL5pLed5z7FC
         MB5Q==
X-Gm-Message-State: AOJu0YzHy4SEdChm4bZK8dVqr+pWvwxYNEjMv6aO64yDvAKP6Yh+q3Fa
	tgOHYjnugG6qYYrhtUJ0kyfQ8hAyTLk6oGNN9y5mH/+uWMwHPFbDTeJNSG7tOdzV
X-Gm-Gg: ASbGnctu05/aDpHuLvpvqHmKM8Eg+Uw6GVp6o2VD13Ta+8biOpeGEpJ3SPyJB2BTyBs
	cfP4QWaf5x9IGn9JzhVpwc6M2rjS4SjiY2q7N/nmYj4Ha/+hdKxWxlCmcU0piAqQgS4Y4ZsuXcx
	VnOgFTc0bIK0JXHT7+Kp5b+kVPjzuAKmmnNN4xTFOtw6MzKmRR7pHExZJ+9mKL4bveB68YkEfZN
	XshPPXHIGZ2AtlXFjRBEpbKw0vG/wpiUKzUx/nDMTyTGmfQUqzjZn8qoDxJpCCPFnIkDU9zRNSg
	63KeWnFrvZf92D2DuXuIu/k4t4FvHA3kxCwcphLe81sX9AfMXij/N8dgq+ViPJkuXMrc6Vjl9NQ
	LIC5o4rGTZOy/L5TZCkml
X-Google-Smtp-Source: AGHT+IFZHgzrPKvjIb9Zo9kWrkYppG8RKy1e19Sh0Y5CG+Pd4087lZEbJjMwa5llXHl/14bWV9ETrw==
X-Received: by 2002:a5d:5f89:0:b0:3cd:590c:61e0 with SMTP id ffacd0b85a97d-3ecdfa3517amr5504049f8f.54.1758201996774;
        Thu, 18 Sep 2025 06:26:36 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:ce66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f190721esm40679305e9.10.2025.09.18.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:26:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 4/8] bpf: verifier: permit non-zero returns from async callbacks
Date: Thu, 18 Sep 2025 14:26:11 +0100
Message-ID: <20250918132615.193388-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
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
index c5a341ecbbaf..f760b16b9b3f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10871,7 +10871,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
-	callee->callback_ret_range = retval_range(0, 1);
+	callee->callback_ret_range = retval_range(0, 0);
 	return 0;
 }
 
@@ -17156,9 +17156,8 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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


