Return-Path: <bpf+bounces-69282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB357B9392E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F0164F6F
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D285314B66;
	Mon, 22 Sep 2025 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+YPj7yD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1B830DEA6
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583586; cv=none; b=lTt7ENeaq+OAHd2Xf7JtEpD7Cb2quMwapBf/mB5JiGW3gYtjv1pwZQH6wiY9/d618klpGePSx2GmtJa/rPxW1Kjm6ixpqHTZuwZrQB9MiL8VO50Iq8D2F0TYMtYbgkzeK82fDhCWg0WMdZn0eKGHdGA2ni/pOEOYwoOla2exIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583586; c=relaxed/simple;
	bh=euNRR7wbhAiuC18PF0ukCwK5eyZUvqLOkaetm17Q9P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+3KCDzuIRckGp4DXig2laEydumY5MfpkG0tQL14aUMpGj7Dfh7YCQUOcV2NZKLn1F2WH9W5QNCra/Hlp5O15TRWl/7O/LV6DbpYA5whqy8sy6rs6SUfrSYlXbzzmIq6KLhzO95B4Hdv5iljJPxkUM4RDEo6ZruiBQEdQkN84Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+YPj7yD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b2bddecc51aso255264266b.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583583; x=1759188383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmKVr/w0x3pxJDEoXBazT76mX7dk2HdObRjMF6wmewI=;
        b=c+YPj7yDdngjRW3whh8EuY5pS3WVgzjzt62/LVWfzjE0bpx4HDS/6GlDyIae7DvWvk
         WAW7hcSeDhlrEhv6ElTuBBe/M/9xfsl/zcNv/zI32rtXXklzGi8WxrHSY6pw0Wo1tplV
         JXcN1md8e86t5M/6eDxnyCQ/IGWvCZx4z4ciuO0OYyHEmYtITlesTfiBGYT8gRqHsY+y
         hWWIrVDogmxT5UukYU17F5LMNEqZhHmJIL3bgqXGSHHD5Ie0LjqPLQwLR4nOqm/zJzgz
         FOsYF9mBWLcWD/4NO/gT9OzBczGBKdU7ddYIoAqbJhgaCHxZywf7LOEnIyvQ3kO461zO
         /ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583583; x=1759188383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmKVr/w0x3pxJDEoXBazT76mX7dk2HdObRjMF6wmewI=;
        b=XeA1RUKrLbPJ9mCOnUhFha/OUBU4dUrSI18TpDMI9GrGjXda7mJRsAy4Ou1g8rdOhN
         rapOJzfwfCkOco+TWFZSrWT+twHDOSV1+crmqdWb7R9MkMkwJ4Miv7wxIobyT4GSLsIj
         w371MSqEcxJI5WS/b3gJTW3I3qFQBni0PLOElDw6ZNGAGRZCx+dutnSn4Gkkhd5CzZ82
         Bo7yMSIVI+HAZLxUX8WMv7MuOjLVU/69704y0kc5GFSaUy1VzGTdeEipkWnrOLlZoFF9
         IM/BOFYYQ7aQGn9geH0we/LCDW92TFJOQUpyqrlJEihl1sY8WIQd1xo11SrUgzyE3SnX
         tECw==
X-Gm-Message-State: AOJu0Yz5KrqLYCvF8M4Q1OsDcSSD4A4iYw5waDJ/LmsD6YSmDeO6UDmP
	88je96bRxZhUH9m8OG2eg/TYyjjRw67TpjdGAYkhufsvoT0sJRe6UYkG9iX0og==
X-Gm-Gg: ASbGncuI0mNriMnghjKPcznSN/jR6d0JJyChpztGNTOPcrvrloiF6AhwpwwWvK6X8QW
	Z68EvtwWQ4qK0JLa4jVZMM8XQjCpDMO8kgLbG6LTcU4oRvagjoAOC825S79eO2c5zM8phcNs06T
	/A2p7ITUDW0BpfUmNZw1Gb9ypywA77pyENAiPfv4g749s3Rmhm0E7lvCaxgtUHq7qmh9cBy7ZOb
	FU0yitTrY2FLi9VxU/E6OEv/jauvgekR8N7PsWUtx2r+CuhSZg5xCHxR9lDUug7v/9r7auCSI6R
	8Cbj2RKRWxZTcnjN3fplcw75gi/rQ6N8BaTORR2WG+1poqtHk7dy6BuW5YOHAS10eS7tvhEJNVZ
	z6AzH2up823d+QBQUSsW5H3M1m8zetg4=
X-Google-Smtp-Source: AGHT+IGsmK6mTi7dg76GChu0KmM9awyWqvinjbi6FTeRLC0h75+U6UM99BzSyjfGHoqlJLRDcbESOg==
X-Received: by 2002:a17:907:7284:b0:b0f:1455:d682 with SMTP id a640c23a62f3a-b302a36d20bmr37671466b.33.1758583583244;
        Mon, 22 Sep 2025 16:26:23 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b27217f616esm796598066b.72.2025.09.22.16.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:26:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 4/9] bpf: verifier: permit non-zero returns from async callbacks
Date: Tue, 23 Sep 2025 00:26:05 +0100
Message-ID: <20250922232611.614512-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
References: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
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


