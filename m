Return-Path: <bpf+bounces-73667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF6CC36906
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 17:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF99A4FEAB7
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A5332917;
	Wed,  5 Nov 2025 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmu9ptmB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5BE32E149
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358357; cv=none; b=JgWK2PUMSzbMRaWe2wvZehlv/00lnmY6PePb1ffWQiY3NPjsniplJJeABg6Wg4UQxP7Y+Jf5rFdU8MU32xV/cLDO7FwmpQKj0xl+5lvbueior5vVEpWejgKEhAQA6NlTSzlDBtv9tqW7tMRMJRc0mYqn+7MuwZAEIKoYpC6xO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358357; c=relaxed/simple;
	bh=pDXnYVmHBa5Z2Isp+YRp9mf+W5VVJj6Ulfc4ST1eLMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JxJHiXIPH95sX7k0s6ZKs24Zhf97qxKilE9XXUhdnghz1BarD+CjqefCsa2nEyj/JPMDwvRU0ok4Sksh5WJ4b/BTQkLIU2RjOmOHPrIxc/lQA+QOU5NYpADLVqh2tjIyijMMOvR7RYj1zQ1scz+6vC9Epg2Zi+9nCdU9tCO2CIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmu9ptmB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47758595eecso10662105e9.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358353; x=1762963153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uusRmAWABIVFHBKta5nBiy/wMPQc/t6zl1WTZbUWGEM=;
        b=Nmu9ptmB8bvlQ2dMYeG4l4oIyHXOhKgXygVhf1aLHnk7dbc9NjHI4ZaD01v5zJW9Ec
         ipZFu2tx8Z/iFvBhkVDiv16rJC07xBCpJHN7Es5+EnKPNNFO8ESqvMdKfg6Ht+FSbrPz
         VRJHcE1BvdxL52IeMcRq3N1UXfQahQyQuaLsjvLjef46zxZplh5nlywnTh5JfuFokcfg
         4McScP+fZgDdyEJyPyGbGZSYx67TtNxKTBNJTJONS41fb71RAdNT/XQwhlVjHaHuO5hE
         M+/N0Ladw4enQMGJY0czhhr5B3iywBZvNTXhGLB6Euc/zLuJydLoKkpcIPrVpA/ZplfT
         PGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358353; x=1762963153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uusRmAWABIVFHBKta5nBiy/wMPQc/t6zl1WTZbUWGEM=;
        b=jaBHufCYjmvKQLWwfI9Q38CQSD5+bAE4m+G8Jt1VRVcW991IRIT7Ry1RZ8hEFS2KHX
         s0rcoGmdXhWOrlf5rNvGi+t9EB2GvxDmN2aJ09vvAcNPjhT6I+xtvqeGE3aeiry2yhxs
         +pjwCKhGXvHrwJh2jGmVslt+FrSMOBdSlACvmmCGP/lkL0Z9Y19lIfzdEqtKiWCrhhgy
         P/XLlkZWIj7v2atBldgkYIO2ehdzABMJ1JnEAVer9i1YmtbW6/TVIpR+LT+jgm2W3GkS
         Pohu4q+v/cxuPxRNq7KoTn0OKpTOS/n8FVd8nzoMypUyxOMNBnA+GNSUGKFOZr8t/12f
         fvvw==
X-Gm-Message-State: AOJu0YxlFpCiZKJh0A7GNJXuWM5fIVWNlBTDRag+E1NEwbHeQYgBCnyc
	RKPDHU7/9NDPJLf0ApsiJXGtsmAjPZ1OegntiAfK3QUW/N9CCyP1c5TI
X-Gm-Gg: ASbGncs2nbUxdgwnG+NnedTkRrGyJKeh8N/F7po3mj0AgTc9wNG2kwEhn8imLIL0TIv
	Ryhn0mNBdvaZ/afCQ8eNOfb1NIZxiySQic0pejtidjrWX3ZCpaW6sZ4pAp8Lxzo9PdYXU9nxYnU
	6eBuYL7YDMCt76G0sSZgS30b6C89zE+Z7yyABidPF//GTQIaH2FUrxADGq5CRWQZ+mOQ5EzmYMB
	NYf0LgFcvRFJcOA5sz1yVjjYm3molf7qw/i1I3UrJUo+l4Zxe0crwH90jFrFqSQaixBBgWXNqvN
	xyPk+nv5oLwcMOF6tL7nKfEKHvvzKIdwOeVwm9/G0UjLXy8OUIS4YS5bLSpIR2SH8kl9h9JsIHB
	dLTC2xTNihHU1I31W/i/W9YN23xffvayY2bs8HCikLbn1ReetjVsDAQERSq2z
X-Google-Smtp-Source: AGHT+IHMZl+hMYc0ZcmS+eTkAEJHuMEimSvt/AFRZJaulThmLblhqk+MWpCt3pLT0sBwhiKnjJ1RsQ==
X-Received: by 2002:a05:600c:524d:b0:475:de12:d3b2 with SMTP id 5b1f17b1804b1-4775ce13405mr39250555e9.36.1762358352491;
        Wed, 05 Nov 2025 07:59:12 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:64d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc2cfasm55984715e9.2.2025.11.05.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:59:12 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 05 Nov 2025 15:59:05 +0000
Subject: [PATCH RFC v2 3/5] bpf: factor out timer deletion helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-timer_nolock-v2-3-32698db08bfa@meta.com>
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762358348; l=2394;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=AQsCk/NCuYhN7oTGlwS0Ob092K+UchDDMjDhAz6F33g=;
 b=iAG83BwJvPlf4pBdm9CEc+YnWFrO6GQUlUU8W5+dVHjlAu2/Y4PpTFXjRt3gWifU2KtBYGhik
 My7TKoBYF1zCMrf8ANlHMirurieCyrLdqmH7q4JE7gGEt9uZLO0ZnMk
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Move the timer deletion logic into a dedicated bpf_timer_delete()
helper so it can be reused by later patches.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d09c2b8989a123d6fd5a3b59efd40018c81d0149..2eb2369cae3ad34fd218387aa237140003cc1853 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1153,6 +1153,8 @@ enum bpf_async_type {
 
 static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
+static void bpf_timer_delete(struct bpf_hrtimer *t);
+
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
@@ -1576,18 +1578,10 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
 	return cb;
 }
 
-/* This function is called by map_delete/update_elem for individual element and
- * by ops->map_release_uref when the user space reference to a map reaches zero.
- */
-void bpf_timer_cancel_and_free(void *val)
+static void bpf_timer_delete(struct bpf_hrtimer *t)
 {
-	struct bpf_hrtimer *t;
-
-	t = (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
-
-	if (!t)
-		return;
-	/* We check that bpf_map_delete/update_elem() was called from timer
+	/*
+	 * We check that bpf_map_delete/update_elem() was called from timer
 	 * callback_fn. In such case we don't call hrtimer_cancel() (since it
 	 * will deadlock) and don't call hrtimer_try_to_cancel() (since it will
 	 * just return -1). Though callback_fn is still running on this cpu it's
@@ -1636,6 +1630,21 @@ void bpf_timer_cancel_and_free(void *val)
 	}
 }
 
+/*
+ * This function is called by map_delete/update_elem for individual element and
+ * by ops->map_release_uref when the user space reference to a map reaches zero.
+ */
+void bpf_timer_cancel_and_free(void *val)
+{
+	struct bpf_hrtimer *t;
+
+	t = (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
+	if (!t)
+		return;
+
+	bpf_timer_delete(t);
+}
+
 /* This function is called by map_delete/update_elem for individual element and
  * by ops->map_release_uref when the user space reference to a map reaches zero.
  */

-- 
2.51.1


