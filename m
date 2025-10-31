Return-Path: <bpf+bounces-73209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F853C27180
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 23:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D983B54A0
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E0C32B989;
	Fri, 31 Oct 2025 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYTznKP/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB432AADE
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947944; cv=none; b=WmV+8elCYxwb6qjClNeIFP3XF7pnLn3oyWIPrrBWu2nRfHCOMs4jsFMONoFaqMszy/zQggTgC8049bS9EPMoPnvrxvxwFtPysk2EHgDaAztRbeUAwJdVdE3nh+6TDnyrQrzd+T5MsoCMyVNxp0LjfC5ywvdZb2sqYopbqbIRUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947944; c=relaxed/simple;
	bh=CFWAzc5qQ19HTtW94Aaw5Bouse6zebdVCnsCLEdef4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSA2eLCyFPE0ipIARqIYl72oYA6J1jKxlqCh2/e9WektXWg7RQwGWS7XjRwXAgPn3LU/yEDNm6rrk6qtMOBJk4bQecjO0z52EZvkZRv80V3r6ky88uAWc7ol8Y0f3mwbHRANdTvojZGLzI7B/ioK76XGIC+hPhqaSDoKyT2b+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYTznKP/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ece1102998so1902165f8f.2
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761947941; x=1762552741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0EoXEVdURXnjc+KjXTK69837rLjjn5GMAml/9U0DOo=;
        b=XYTznKP/AkCBo7faunK4iU54oJRCeJmCwc7m1W+SH9GO1amUL8LZ2w04gPKdUv3g0t
         a30PlNpJ0kRCTg3S+TNnnztsK7ekFc1q+RSMsUDUFn1DpzaacRVH62pPEPRkdlg0MJUl
         6IUJVRcb4gtc3JW2+s87gbkAivDCiwG1sgSqU/mt3MjlwV3pNEeWJ8ciAkSZjTVzEl26
         7ooykgSo8RG5qtKLoylRMohQKYxz9x0U4UmbwqLtJcI2Hw9P2LUaFA5KVWnkftIUGEIW
         Z2f8k9X6XhNmPpLWN6CK+AmsFX0CYZWnKJ1xJq7o1/fy6RYxywavmamIApjbDkrwkore
         3vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761947941; x=1762552741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0EoXEVdURXnjc+KjXTK69837rLjjn5GMAml/9U0DOo=;
        b=LYbNRVfIhsEC+1FEnUZCx46iRAJFVHktDZgdQds4nz594x9Cl/LNtb2qfEfwRY8CuT
         dNLj15sRoGYLszFFrGHUigpLtMSeG8HZufiQCcUO7N+j51CoEu2NiB7KvxWqDWYsZGjO
         7GuoQdnwPw//9dIBj4muLoKztl4ybSkjzhgxyBHlSlWHjl+Za7YcXdeHq9Ls3afNoSAx
         Ok5r8Q5yVV8gcwik+eFRk7IyMQfVc2MWFGboRy7zIVb5BJvhSVB1R2D5xCqxrWSEBjpN
         Pex4kHLKvYaWjx9jThySK0KQ6QbYKf9SJRFEKxEr2sGPXceNes8KlpHjpXM0lAJuKQY6
         IgpQ==
X-Gm-Message-State: AOJu0YzA/Bas7lyjnG99B6sQcuQEajEX/Xc7qsfrn9Gl4DHWkon1kdpH
	67UydwdY9JN/48zvkf4PQtKkMWLOLOhHgok9YZ/HiYwUIK8tnyGddZt73IJ2/A==
X-Gm-Gg: ASbGncunD/GHTMJgCIsgnbTdwOa0deAXFau7dkoEsea936KQ/GH1Q82+sTYDg2353Ty
	M4B3mfxfaKyMuDCLQm7R+8+7h4xDZUejklpU/ERSkCK/JU0KMVC9pA6JjWopiujaCdX5j+g8ib2
	COLuR9aEkhSQbQItQVTh6o9X6FSZ0E27KUvzjmGUgB2qLiITUVzpLLJs6clekhUAfnmkr7W7LNC
	AS2GScjMBCCf1dZFglwOnNz0osPAC/zNemBwDODPwQmA+KSamUVKJvZQczDPEr+MKlgdZWlmgmz
	epvcgaUB3qloDl8XqORsXu6mQAk9gLVIvr6oSDtoVoZmrwlqTyfZL6Wjj4+ywIe1QXZE01ldE+G
	Q0hEB9YVRPObXyZ/2GzU5kZ3gitMkB7c55yaIe5AOdbQq8oJ+q/HeUVw1jJefrw/BYHDpboIA+m
	xvO8OJEJwdJvDABA==
X-Google-Smtp-Source: AGHT+IE5qPGQ8k3m5msSfJNjUhvCzoA5pDwRbAvZnSYG6wZR1Z1zRrYIZC0m1EDr3BrRdx0MCQTcxA==
X-Received: by 2002:a05:6000:2883:b0:3e8:f67:894a with SMTP id ffacd0b85a97d-429bd671ceemr5117541f8f.5.1761947940908;
        Fri, 31 Oct 2025 14:59:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13ec105sm5531215f8f.36.2025.10.31.14.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 14:59:00 -0700 (PDT)
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
Subject: [PATCH RFC v1 4/5] bpf: add refcnt into struct bpf_async_cb
Date: Fri, 31 Oct 2025 21:58:34 +0000
Message-ID: <20251031-timer_nolock-v1-4-bf8266d2fb20@meta.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

To manage lifetime guarantees of the struct bpf_async_cb, when
no lock serializes mutations, introduce refcnt field into the struct.
Implement bpf_async_tryget() and bpf_async_put() to handle the refcnt.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2eb2369cae3ad34fd218387aa237140003cc1853..3d9b370e47a1528e75cade3fe4a43c946200e63a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1102,6 +1102,7 @@ struct bpf_async_cb {
 		struct work_struct delete_work;
 	};
 	u64 flags;
+	refcount_t refcnt;
 };
 
 /* BPF map elements can contain 'struct bpf_timer'.
@@ -1155,6 +1156,33 @@ static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
 
 static void bpf_timer_delete(struct bpf_hrtimer *t);
 
+static bool bpf_async_tryget(struct bpf_async_cb *cb)
+{
+	return refcount_inc_not_zero(&cb->refcnt);
+}
+
+static void bpf_async_put(struct bpf_async_cb *cb, enum bpf_async_type type)
+{
+	if (!refcount_dec_and_test(&cb->refcnt))
+		return;
+
+	switch (type) {
+	case BPF_ASYNC_TYPE_TIMER:
+		bpf_timer_delete((struct bpf_hrtimer *)cb);
+		break;
+	case BPF_ASYNC_TYPE_WQ: {
+		struct bpf_work *work = (void *)cb;
+		/* Trigger cancel of the sleepable work, but *do not* wait for
+		 * it to finish if it was running as we might not be in a
+		 * sleepable context.
+		 * kfree will be called once the work has finished.
+		 */
+		schedule_work(&work->delete_work);
+		break;
+	}
+	}
+}
+
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);

-- 
2.51.1

