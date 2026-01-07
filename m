Return-Path: <bpf+bounces-78144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4CCCFF8E6
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 491D13394EF0
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E95395D80;
	Wed,  7 Jan 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWdfJEK/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF2387560
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808192; cv=none; b=niTG7prmgQ4OlP59NK/9FEZyVl6QZsZzKUX7S7Up/IkVLgEY/JtUXVUQVsaXSwXrJxChvxY3oIgzwMK0+fzKRKdq9HtKDELQLYc5IKRRnW90Xaq1qq3N8bg89aX1E9XIA/sdnb8dvgaqqcGcLRtH6RkymFhK4wyjw7InaMFAtjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808192; c=relaxed/simple;
	bh=AEcTR+nY6qSU2TaOIdNV0XrgxGl8MLFbh1nkZk6Bv+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jgVoHcCsaJ3pIE95AvuJqT+/CJ6FMMUB91E67j9obBdVPuBGgcoPjzhLrugDj0ljvVdxZoIKFxt4uTqsSapaS+Onh0S8jhN6Sf53kcM+xRitjJahpsNZK4jU+gQOo8rh7NoUFMVzug+Rxa8qKMbUp+MNljblOJpK6usZTK9U3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWdfJEK/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc3056afso1260697f8f.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 09:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808181; x=1768412981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/Li3ak2nH82Kr13A+iObhEa6WI6nNurqJFAGqngfSg=;
        b=KWdfJEK/dz23SVuG0Fq+zdeQhu8e3hV07EeISBSepdIYw2+9lL68RTO0ybsDhq3rjy
         pYYXNPPU3BsF5vsAOnc0R2hdePk3I+cArp7XABKTi7LhKnTshYEYSYIjT987eZwsH8UZ
         uBBjFzbm4g1J3NGRDmCnnjT3vt6YCDNeZbK3UaGg3rBOdZ4GDXTexg1fAZpcdJamt0yL
         N9CW6brFiuCaRWiMGy0y3fS7adCvBU/yx1uaz5JdY6jeGRpK0thE/HfvYQTvltsRp+6P
         Y5bLvyoD/oh5to3DmMdgw/dUakjACFOek4AMPxV+P++uBwcsDSA1zjmC1zIdKmr1akLu
         Ym6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808181; x=1768412981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x/Li3ak2nH82Kr13A+iObhEa6WI6nNurqJFAGqngfSg=;
        b=dEmbknu8IQvfwxIyacbQa7svNz//hmETI/J0ajzB0XJSWpkGKUOmYRzx/l+nTHmYDn
         dKbzLl2azs8QL3/NqHoQZv3HdPQqH5A48wggP1P4E5KzSugXx8aoL5d6CDrG6+bIuaxW
         X+1AgT4b1TMvhZclpbDWfE2vegDebh+bEBSjyK7kqeTx74LlMeFDG7jZJN44Id7hNKS5
         64Xi3o+xyBP7uX42xWaPF50VRUcEuLeVwdJ09ImHBMj9AvJe89McBQRrMgtR9cPsyzdS
         XH5yuVBd4HKPPTBv/qcfKA/b9J75Tq4yAK5gTlIpxcZaBQvHzVjP6EBiWH+p2xjdU/9w
         Xjtg==
X-Gm-Message-State: AOJu0YyUDSTnHYqHE9RLsJBUOGLYdTE0RgO/LEXDidx7IghEKzmFC/91
	p10LrYWk3o5Lg/K+lqqkF5HBtWmYtlOz3O5MvVNr4A/p8g58ZfEKIB7B
X-Gm-Gg: AY/fxX7GvyeVXqRuVP7f5xcOa8T1F+X/nH+G5hBNrr6C4JVFl9WN/YkqpZ8plXVA/0G
	DtnMWVE4tWib9pj69gaLacTjuPG0X702rW9D+fAg4NOTC4axZhahmN3s6d0kQDBHR4UCL9bZVDI
	qXHDs6ZkQsQNtx+6Qscvd31lEbBpnL5fFHiFaYy2rHGJ64EOSgBIqdrEZNSg66wyAtlSzSkU5CR
	0OTqSej/36gZH2WYmvaGpXLSmaIdcIqYvkE9NPSbImbuFOBiWK2ZFf6n7FXRaHj8cEDQ5eKz1Mx
	KwWxbNkivvXgFf+dIlzaTBe6nvpkYMIPmwkZ2g7a/bqTnw6jy3U2UAnhSJtoiyVjWznoRTzklCj
	zZS+unZuflHwoSvdArYo61PbkSleGqxjHKZvk56ppZJUI7ohmyG072WB4hf4Fu+iWrB0=
X-Google-Smtp-Source: AGHT+IHoniSXDuVmR8Etv37NqVv0x7oTvvYNuRvbo02dt6dCTOIwaH2kKQ4rLIgbOxI5gDaO5DGvYg==
X-Received: by 2002:a05:6000:1844:b0:431:b6e:8be3 with SMTP id ffacd0b85a97d-432c375b04amr4667164f8f.38.1767808181364;
        Wed, 07 Jan 2026 09:49:41 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee893sm11306066f8f.37.2026.01.07.09.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:49:41 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 07 Jan 2026 17:49:09 +0000
Subject: [PATCH RFC v3 07/10] bpf: Introduce bpf_timer_cancel_async() kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-timer_nolock-v3-7-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767808173; l=1354;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=Tdgbt4GZ0T7vO7YspQ75Jfs7RWvQuCd5QKb4zItKBzE=;
 b=//FfxQqXDk7O3R9byJjxGjCB6RNdrzBoXonKEnUQzZrh3VnSZhahbAulAdTzbklGnKygHc6UZ
 3JMsMSsthnSCPVv2okTiHYCYCM5jks9A7zALaxJlPZNS04a7YnOAc5R
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

introducing bpf timer cancel kfunc that attempts canceling timer
asynchronously, hence, supports working in NMI context.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b90b005a17e1de9c0c62056a665d124b883c6320..1f593df04f326c509398f501907265ec6dae60e9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4439,6 +4439,19 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 	return 0;
 }
 
+__bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
+{
+	struct bpf_async_cb *cb;
+	struct bpf_async_kern *async = (void *)timer;
+
+	guard(rcu)();
+	cb = async->cb;
+	if (!cb)
+		return -EINVAL;
+
+	return bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4620,6 +4633,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
+BTF_ID_FLAGS(func, bpf_timer_cancel_async)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {

-- 
2.52.0


