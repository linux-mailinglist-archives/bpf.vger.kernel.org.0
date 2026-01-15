Return-Path: <bpf+bounces-79110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6845BD27AAE
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A22663174B07
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E093C1FE3;
	Thu, 15 Jan 2026 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAT7lYvM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16663C199B
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501750; cv=none; b=S3mhlYkgTFjv1o7PlUAAJOGpiL+RDEF8fYvlplFcjwHdW9eabgf3WLDixY6DQ4iggBpQsqoMMj87U0z5dHjQO1Lzg0rxM+99fCdfFGtg7F8JG7OPnnJySY/7hxi0fk4wqBAHLladUAk6ObjzoxGO/cPM/hqlqyhesZWxAorP43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501750; c=relaxed/simple;
	bh=WFyfCdFZSc39/k5H49myNCriXwVVsZ3R/PPu+Rg7vaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfuwMqdwzHiTO/6rOEwuajZCk/EPacy7mkBDfNi/SO0AsXe0WpGLRx6+SZX/+NNzEnrWkNmEswIF7AQD2OhsOoiyKAWDjGAxkowNP+Rw2d1tIhsObXOtAw7o5+REenCiy8IZF+tYsOOXaJTG3AubnncjwQTjZHe73T9Kq5RHs/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAT7lYvM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso8513405e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501747; x=1769106547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JbmK/RJvEWmpHkRk+ZhC+1Oyd2c57i0SiusSqSY7AQ=;
        b=TAT7lYvM0zUUJWTt2RSXyF8QVdr2MxR03w0Y3zAi1h1rabnBPsZd+XSn89kZZng2yj
         ZNilZaPJ5mtKI1j0o+O8qCqyW6wx9kMJXvMa/S1oZ8MYivi3DLeI0S5f34Bj6+/WhLUZ
         oxNukflATZCsU2So6yEoLeks1a0YzM/aHewCkYkrXYHMxxJ+hHEvMZpmQud2HGn/iFn8
         mfyi3dL07iPAj6ZIbMOzFuxnF+47ANWaANt8AO3Xt6iBkIzF+uOSEGwnjtb5QXCH6lyz
         XCE7jMcY3wDTx/EboG+xU/rXX7P4MmR+dI0PUBX7VlACbtS2O23TTr8PRWgttBrnQDHw
         ftmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501747; x=1769106547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4JbmK/RJvEWmpHkRk+ZhC+1Oyd2c57i0SiusSqSY7AQ=;
        b=mFU0V7TxNjQY8FcTovoq/+19zw4KYY0BwV+4YpLo6Lz524mM1XN+ukqCe+AZV/YsZp
         oUZ9cJxIyTQU+PydtHqrKvwH4yhaOxgtYbM5iAdf2h/FoYTucdgt4jr3D/KGWvkT5V4r
         y8WZCBbmqJlubNMgEov1EB1r7l39b3aKuVKUMT+7g/XgV5m6ft1wbm6CGRjvwDvmGd3X
         eyIPPyo7l4qpUFJKie9JZTOctNvc9g+B95UHL9m29o7415qGYA49DmUvuOHGPNSwzAQr
         DTCRoJtJYIqBkYl/xW4m1bHtEU/f7LmTz+qwux7bOvmOEkpd6pdXLr4Pabt4ZIfKQOKI
         ZaxA==
X-Gm-Message-State: AOJu0YxGXfuo4IC4l5F97NMeOwCTyfGXooUEnwzCs+3nE8zt7IDtHtOT
	i101vOhpOGOUGHqWZVOLui/Z5++4I9M+onkATGCZkVF/d+j7p8ZJrh7DfgaXpg==
X-Gm-Gg: AY/fxX69uMfEZP2C6clZRO42va3mu71MDggMypuq4C41cgVPgQ7/X8cfLSezOPLYxAj
	EmqpLoFaJrqCTlsS6dpJ5/V28tgJLfoPokMOvSJoz2Ur3iumJqNqqd6VHXVuwYq+NDojKqDjCk2
	VoK6+a05A2g4N466cgAL7Fn6uo+xPfBH/DEkwKk4sgi6g+KPQ1sKJEcFWcjyZiopO1n4tBtwge5
	mW+Se77FzWJNH6PTAiVDZAPfr5tqvgGm4tP2vkHl+1mYfRAiN39wXt0zyqdPR3HA+sHygY1Y5wr
	7WhP408cHVOAmnGjPwmLUQvPV7AiIcsGX5b/TlEhQCQUtrkj+CoXqcg1ex/LK9CfnApuXw4wB8+
	dH12PpcWU5mFcUfaDnk5dXuh9x5LOR9kwc24TO6SvqzVCqcmfwXTKGjT1Npuoe6UVwg==
X-Received: by 2002:a05:600c:4ed3:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-4801e4db3bemr6662185e9.0.1768501747043;
        Thu, 15 Jan 2026 10:29:07 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9fb193sm811275e9.6.2026.01.15.10.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:29:06 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 15 Jan 2026 18:27:49 +0000
Subject: [PATCH RFC v5 02/10] bpf: Remove unnecessary arguments from
 bpf_async_set_callback()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-timer_nolock-v5-2-15e3aef2703d@meta.com>
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768501743; l=1646;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=r2UITbW0avcD8EPt5OHr+nR3+S9ZgpWwFjHyPTa5Mq4=;
 b=iVjXiXDQUkOEGY0qjP4+2apmASPIf+Jmv5UKrq2kEn+2wePswnCSFk8oEUqhyxUQknrtouXmQ
 H+6nATB7p45AF8vB49af8pVusYtycRKScw2XrdCGiNpKFThb0XJEbBB
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove unused arguments from __bpf_async_set_callback().

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cbacddc7101a82b2f72278034bba4188829fecd6..962b7f1b81b05d663b79218d9d7eaa73679ce94f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1355,10 +1355,9 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 };
 
 static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
-				    struct bpf_prog_aux *aux, unsigned int flags,
-				    enum bpf_async_type type)
+				    struct bpf_prog *prog)
 {
-	struct bpf_prog *prev, *prog = aux->prog;
+	struct bpf_prog *prev;
 	struct bpf_async_cb *cb;
 	int ret = 0;
 
@@ -1403,7 +1402,7 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
 	   struct bpf_prog_aux *, aux)
 {
-	return __bpf_async_set_callback(timer, callback_fn, aux, 0, BPF_ASYNC_TYPE_TIMER);
+	return __bpf_async_set_callback(timer, callback_fn, aux->prog);
 }
 
 static const struct bpf_func_proto bpf_timer_set_callback_proto = {
@@ -3138,7 +3137,7 @@ __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 	if (flags)
 		return -EINVAL;
 
-	return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
+	return __bpf_async_set_callback(async, callback_fn, aux->prog);
 }
 
 __bpf_kfunc void bpf_preempt_disable(void)

-- 
2.52.0


