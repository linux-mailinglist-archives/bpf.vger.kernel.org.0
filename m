Return-Path: <bpf+bounces-71465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70386BF3E39
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050753A9ED7
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2921D2F12B1;
	Mon, 20 Oct 2025 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1wCbMUy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E02F12D9
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999150; cv=none; b=oJUbS7rtZHYiHkEqgoMU6Uhi7WIzjn0BdOQGb3cINTmockW0X8eBMjMyVn8ar9o0ezoVE90fugQyny8NJZr8FiPOku4qxzGtKuvU6rO1DPSNnX0AX20s6Vee5NRTKc7TNyWiJymeQ6q6+Vh+BMIlW7+DXlqg+nKGXgMSH3fQF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999150; c=relaxed/simple;
	bh=S7wR7aZg7Tjl3o7Oqf0exsC+eBwpfOYtGuNSbYyxGDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3zTNMfeIOI4G6KMFvrJzrTIYCpJsOSnVuMf4KWHYjHxF2JSfLuYbSWTGFa0ZAA3wQhb7jToTchRFOY5TZ9ukZ1/A6U5GFxTG2UOdbKFi3tIGJRe6k5cgorH2gLNqTtQVJXHWiXssgFCCdNm5CXkroAmHs4KRJueMYF3GjJUTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1wCbMUy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso4860571f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999146; x=1761603946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=879X/wWgmNgdWJ+TiOg8p7qqMzA9yE+P722ipbE+i44=;
        b=b1wCbMUyaABAr1jMwJ6M6XHh3hcT3eSuRUU5h1iW6k90E4dQcgV5Ywa6AUfh9geAvz
         sFyiWa3RMTsDKtxoit/HM+7dc3Sbn16l52+mR0HhCEc6qrADwAX2kZcVIaxypkM7+g2i
         SXvXgr3xEetdusJtym6tAiz+pRoLecazY8T6P5ShtjvaIym+qoSospuBhA5yGuHwai2S
         2PzowdMZzWxTlzUAKa5FJEDJJwti+zwA9zYc4IIq0BUZ1CRZf2xgPF6qf4WWC9A9i6gN
         5+ovPg91ke/oUX9JcAiyAzP7CtAgRlA4x7qhIDsuUyeBixUsXeV8XLBNnnZIWe7x8S7+
         ytDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999146; x=1761603946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=879X/wWgmNgdWJ+TiOg8p7qqMzA9yE+P722ipbE+i44=;
        b=iSVEgT9lEJrA4294NELETjL52MdrcJMvSE3cCfOmNY6QcdLcbnldVc+EHUT6vTgaYC
         5B/zufTTQD+OdAC3WT20GT9ptwMC489ddROPR8ICKWsN6FifSg7eOauhkh5SdgwmhGFt
         I4LGW5k8+ifz+QRdfYKbF4AI5i/ZSRSyTIhC8vLgde01GyNayUJz6O+eVJLqDu4xk/u+
         Yq5YEZYid9c7d4w4qq9TVI2K88zy2SpWUfCJYFWC65bDx9INCf0g/H0NiuFoTp51xkvh
         uDb4lHl2fybZoPg4d28q3eta6MO7odecR+gJEBqQdalbvNU37rPDKE1o8imIAG3BWFD3
         Mytg==
X-Gm-Message-State: AOJu0YxSrSXKddUc8jgt0M7kpU09laemofus5wkFVzH7rYX+uXii5p0j
	cnM3c3+oKtbBhZbqrYZOwdh4yl/q4bViUycFvrpOvlWoA/v1l8tI9B5EYyrQFQ==
X-Gm-Gg: ASbGncvJtlyqiW/MRjy3WrPyvuZ9Qs7B/DozoCs4SJaKruCoBKpATF5U0lzItxvFGqJ
	Bew3qMa+FRB23FO0dk/h3hM7oC0KlkCuK9n/aSGn3bcXmuuHIAonY8bfyQKCqnb8CtVnBstk3iF
	yI6f3cYofc0p+9AJD9Ltej56Y0tt5LsAeE2GvwPppRQwHaRklhATcn7GM3ywaruRixPQA3w0CmK
	HZbIizuPw4i/XrP5CK3JQPzZ6sVvR2WzsDZ5P4oSxCCnHRga3GWulhFxAMUTpaQPmPKxgNlXj2w
	jUM3lV+UeY0yqHdnFmzZNArx19iibCQNGSLklZdQkM2czG6FbfQMchiTf26eSAJ0Joub8htEfJS
	EBA0kio+3E5ErUDsN83URTnfpoIxwj2r8UVcDKYpMiuNMseYOeh5c6a+qYdeyrmYCQgF3+g==
X-Google-Smtp-Source: AGHT+IHJ3MmlmZXMkeliXcLeUYYvt3L6F/cvjrGZZLG27COI61EshayZlDj4aX+nqmc2FvnDsD3R8A==
X-Received: by 2002:a05:6000:2911:b0:425:8bc2:9c43 with SMTP id ffacd0b85a97d-42704d7e987mr9175804f8f.1.1760999146200;
        Mon, 20 Oct 2025 15:25:46 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2617])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce178sm17068024f8f.46.2025.10.20.15.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 01/10] selftests/bpf: remove unnecessary kfunc prototypes
Date: Mon, 20 Oct 2025 23:25:29 +0100
Message-ID: <20251020222538.932915-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove unnecessary kfunc prototypes from test programs, these are
provided by vmlinux.h

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/ip_check_defrag.c        | 5 -----
 tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/ip_check_defrag.c b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
index 645b2c9f7867..0e87ad1ebcfa 100644
--- a/tools/testing/selftests/bpf/progs/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
@@ -12,11 +12,6 @@
 #define IP_OFFSET		0x1FFF
 #define NEXTHDR_FRAGMENT	44
 
-extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
-			      struct bpf_dynptr *ptr__uninit) __ksym;
-extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
-			      void *buffer, uint32_t buffer__sz) __ksym;
-
 volatile int shootdowns = 0;
 
 static bool is_frag_v4(struct iphdr *iph)
diff --git a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
index ab9f9f2620ed..e2cbc5bda65e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
@@ -79,11 +79,6 @@ int with_invalid_ctx_access_test5(struct bpf_nf_ctx *ctx)
 	return NF_ACCEPT;
 }
 
-extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
-                               struct bpf_dynptr *ptr__uninit) __ksym;
-extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
-                                   void *buffer, uint32_t buffer__sz) __ksym;
-
 SEC("netfilter")
 __description("netfilter test prog with skb and state read access")
 __success __failure_unpriv
-- 
2.51.0


