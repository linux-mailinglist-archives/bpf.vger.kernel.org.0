Return-Path: <bpf+bounces-70305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F03BB7706
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98AEB4EA7E0
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502BD2BD00C;
	Fri,  3 Oct 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYi4DZQA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDC29D26D
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507477; cv=none; b=nZtauGwXMrryi1+fm96Bi4iPD8qdUW/NImLXtmKpHxdAG3kVKsph75x3DtpGTkj7Mp9r3lAQ6ynYTWWMdCFH6+qPDUq4+MXBdTWRmwjoxDh7S7ulcsFSUz9Yasx9BNesGbYwe9uMmICNxDDekMg1JGbqI4B3qIeKwbe8i3j93Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507477; c=relaxed/simple;
	bh=4odPFvCdR9H1QjSHbTIRzI3NqpdykuV/8xjZse/zDy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARrcpZhd82G8xQBDn+EH89cJkrW5KxX8pqddiSbv0LVaERsYB1L7qHZ4ovMvuj2EHkfUZhOipJhoaTKPrR7g7kXFeT8/hv18A3xuHYsaPl3QW/8Rdk6lFqTMt3o6JGyeOclAENOVmkxsBq3aEigP1NqcBIPNyshy1bBfbrstKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYi4DZQA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so26441105e9.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507474; x=1760112274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd4SSNiDvG3lpDOlsDhUVpHoBkIwIZqrQWDyES5b1rQ=;
        b=HYi4DZQAhx7b07JAHkIit9xA5tiaMbvCs58pffGRNJy7PkNZ/k9IchOB5PpzouWyrG
         m0WQrdvandm6PjEsKUdHqfyuB0xcpRO3gShg9GNbcrc/sYqBqNIegQ2Wpupun9fdRuYZ
         9wWQ1VKR5HcCE27WX4g/JEmpVxx7p4oX+egQOte/P2wfXKvY9Dri9G5UC6cabcF02L1p
         4ClNqnVcpgVkJhbd8oW/MzcGbSu2q6XTbY1TkGrx/AcdelfsJwvHL2tdtvccnexGFJCQ
         5dM/j+jAkQC2X33AnRwwnuSVOS7F92dtIc65OKzxCgKUO9IVsqchjk4X0SHiK2A0lKDD
         6O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507474; x=1760112274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cd4SSNiDvG3lpDOlsDhUVpHoBkIwIZqrQWDyES5b1rQ=;
        b=nAjs/kRnz9YT6djauawsO3VrjmR356iuS11NoNyucSzXikVT1pdAARB42geyVRwN+T
         6wgKmo1WPjalhI4gCZFFrPvtOR9hLjSmud3PerViYdnOriKrWxbzHQSTqdYtnQ+SsTj1
         DF/vQvzrJ6U2KeHKdffkVX57PXMo+7kwuZvFlt82fYuRjuKFcBsmU42Dy8UyGKHrRNWJ
         Gm8m9fcaTL++k839JGj6g3GUFhlvg9OgToGfqIfn81PyLbsK/ZQc5F7EcSUlbNHOI9c+
         e8drsvolmmiEORQTk4nnBHGqcxR6ZYVZE7m1FPfGf3h0QfHeg6b5f8tu3FUhAHJhzuGI
         aP7Q==
X-Gm-Message-State: AOJu0Yy57lcqCykuOJnL27bbfd4IOnHxwPOY8fo91IWMN1o0Hq6NaC+a
	LxoNcBMJ2IUP+tI7cLHF/8Kmm6JjmTFyzYj+XgfmUAO42VqVU0azA1flBgIugw==
X-Gm-Gg: ASbGncsSpY4mT+b4cTSD3jJpoPQi3lcosaIFBl7FDga8FH2MMpu4I+jjvsaPyvH2O7v
	hwyjrGzmVRM1wQUUJD31qRNgKjeRZBifU83rVqA93QMauY6cpdXY0cFWEmUinYfd3zzHhh2eKIi
	C4UdQOI4Ejk0+7Bx2LEZcZ9B4Ky8dj8COMwLJqFMcIDrzzYHg9SuSmcaIS1L9ysGxVPOECU1vlk
	seYATZk+ixoBK2Jg63c1I+YSil8d/cKoSvQGkv5OYZPLCXQtDdRoYYUdTsVz7wJyI5FjrHJkw28
	/RM9Sf4RxLGIei3w1Ua6TG7Masapk8YYVY7JY497i1pMyBrA7vR2nvoS09no3pZ5E5kvrJk5y0P
	Lfwp4tCdwmaLlNIXISHXIH4wM9A==
X-Google-Smtp-Source: AGHT+IF/wjtM2kl5SBpRYHQMH6EFs0LpUcKIwobTkKgmQ9nRAH6GGeVDXM9ACqto4VQFwZSgzJ998g==
X-Received: by 2002:a05:600c:3547:b0:46e:652e:16a1 with SMTP id 5b1f17b1804b1-46e711019e2mr24023595e9.7.1759507474074;
        Fri, 03 Oct 2025 09:04:34 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c3eca22sm84428135e9.4.2025.10.03.09.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:32 -0700 (PDT)
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
Subject: [RFC PATCH v1 01/10] selftests/bpf: remove unnecessary kfunc prototypes
Date: Fri,  3 Oct 2025 17:04:07 +0100
Message-ID: <20251003160416.585080-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
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


