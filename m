Return-Path: <bpf+bounces-76253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1FFCABFBA
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 04:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F90303C985
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 03:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725C248886;
	Mon,  8 Dec 2025 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZHthHD4D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814F4502F
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165824; cv=none; b=OkI/flBgDHUoHWjLlPqvMcd3+7RnEytjX0Z68tpXDULACcgr/98Lm7EHLyH2a1PxktHJ4Ay90/m4ATEaSfJBU3Jvm3isy7REVwOyAFFnXt73kcNQ21+gcNrHfBzTfWCMB/uTinqTE6eMtPGrbSN049y/Sj4CHKYvgRtC5VjgS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165824; c=relaxed/simple;
	bh=dxxUXPsKpc+ktrYr3NX238Ynrv7KxxIKYL2RCz+WmHQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxplL9kjuQ+iGOlx1T1dt9Mq9QLG6YKNNrtGIlLsLlu7jpI/ZKWbWWBCXfovzEP8sp/hbg674RWO7fLXpEjt2fWy35TG+y5RDrbuslD//ubRgfEw7hR5T60KSeQUmwlvyGD3J2PrHY8iQkNq83fxv0yAHg093LEKeQdrMtalYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZHthHD4D; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297dc3e299bso33571875ad.1
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 19:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765165822; x=1765770622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQt8uoJWMBYj/YlVtM/kz+RuiqvE92xrlYMKIfu5C3o=;
        b=ZHthHD4DE1td+M3Tx7PdLn+/MTLFkJYU/CPsFFQSvVe2lCKCIR/biM9xk68XvVvBcZ
         3B7O7qAlq2fGDnD6c9lwtI7DQgmLC4HDtvI1GVSE0EeTrVaROpCHgJmR1PcS9E/tXMqH
         vDCZV6g4G+8sHFGP+yFtkqSsa4mDmcsf41/YXwwEXI2K6J+ItAzhV+gi/b659YUqilTT
         mw+kY5RJQn0M5WQ5BwG3S1+btDnMoRssdbEVT1LfDXp3lEzuJwrQeLU/9Wdx6ho0fpS+
         DM6aEcX6TfYpZO1qA4lHl7M1MHf/iod++B/Qcaq+eDCKQVS7kngUFiK90s1sIOr98uUR
         MiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765165822; x=1765770622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HQt8uoJWMBYj/YlVtM/kz+RuiqvE92xrlYMKIfu5C3o=;
        b=R96S7B9kKjkHSTeZi8mrt2Ku4BX1kvHFwgLJcCcmUkiK7Q5IxbrEm17vggV7I9BlGa
         uEygnM1sEeZ1jJ9evogPjWm5O9XfGlERrbxqALM89Ryzh5pupaDSRdsNbH21JiMZpB95
         9jMxoT22VVAdg1xd0s77f1vhReouyJi7oSziQvLAuo3AcXpNCaB11KKqEcge6zy6Gyvl
         /gCSJViUElolD5TI92IsNg2H4sKfkUGTsIgqsLiCD/LwLCqGbgj99HmfdXfaJRgkep31
         LSVJBhxMYgg+EiTYxKJ0XrRefwoTXEdqCccQyuZLzUUFdfwOWR33+XHa5BherEh7sB//
         h5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu+g20f3IUVMWcVBqyo6+BNtly5Zq8f6SWCZ68qu+ZOpqpZC14XCf12pjayeLV3R+jmsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytjuEmzwjjEqgB+W2UWvRZ3mQAwqoy959+Jtjc+iQw/gifHYPM
	DfMmLSZF7O6CKvuQpc5hvg3IkAAUvRG3Pm1ctvi7nCXWJnJ+H9j/pQ1NRVL4ql+JdE4=
X-Gm-Gg: ASbGncv/bYTNqQ5o6nuQmjWA5bf7anUDHBReneNKqCX0FaSvo2bW/3BY5ZocBzCFHZO
	UszL0D3oRtOJW7/AOBScpv9kK5uaK7Q9HcnpJ4dLnOcwGLACUyJA/M84bIwc4lg6WJ2NKsl+EUG
	4qpxwAjXUm+cgYD21aJmbpCQSgTa2m+GWEVSAQ3KjEUi5W7W8e4hZZcxwZ6ZfiejSi3BVoOQBXF
	p4o+nT2JtpLi5kIBo/+DR9II6hs++OeJJekPflx1vjSS2Y1R/IbwNvu2U4ct+jh/Cfyvu4pncEO
	Tlv1VJTmH1RAyI9uUimNQcwqFH/4Z8Ync4BctGpv+1zCwfBi+Lc4FeeOU0KvvDcTMW7UfMCeQ5j
	Y0Q/PawfSF+mX41jKKZ01M0c7nEx2vrrdhwUL6p/ilXdRyuQ38S6GwNA3b+A6wkb3qKdrXjVAG3
	jvn8xhVGh2v8u9orYxxWtNSn/2mvnyz3dT8pP2bITu+HrJ
X-Google-Smtp-Source: AGHT+IG6fRjq+lmQBsuqNIpVk2L76QYaDW/Ee1RxLF8vMbBYaZ5Umod8j+UA/guL3/HnA5D4KRUWHA==
X-Received: by 2002:a17:903:2cb:b0:296:3f23:b910 with SMTP id d9443c01a7336-29df579eb0cmr58912355ad.9.1765165821912;
        Sun, 07 Dec 2025 19:50:21 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6d96sm108871275ad.102.2025.12.07.19.50.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Dec 2025 19:50:21 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andii@kernel.org,
	andybnac@gmail.com,
	apatel@ventanamicro.com,
	ast@kernel.org,
	ben.dooks@codethink.co.uk,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	charlie@rivosinc.com,
	cl@gentwo.org,
	conor.dooley@microchip.com,
	cuiyunhui@bytedance.com,
	cyrilbur@tenstorrent.com,
	daniel@iogearbox.net,
	debug@rivosinc.com,
	dennis@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk,
	martin.lau@linux.dev,
	palmer@dabbelt.com,
	pjw@kernel.org,
	puranjay@kernel.org,
	pulehui@huawei.com,
	ruanjinjie@huawei.com,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	sdf@fomichev.me,
	song@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	thuth@redhat.com,
	yonghong.song@linux.dev,
	yury.norov@gmail.com,
	zong.li@sifive.com
Subject: [PATCH v2 1/3] riscv: remove irqflags.h inclusion in asm/bitops.h
Date: Mon,  8 Dec 2025 11:49:42 +0800
Message-Id: <20251208034944.73113-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251208034944.73113-1-cuiyunhui@bytedance.com>
References: <20251208034944.73113-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arch/riscv/include/asm/bitops.h does not functionally require
including /linux/irqflags.h. Additionally, adding
arch/riscv/include/asm/percpu.h causes a circular inclusion:
kernel/bounds.c
->include/linux/log2.h
->include/linux/bitops.h
->arch/riscv/include/asm/bitops.h
->include/linux/irqflags.h
->include/linux/find.h
->return val ? __ffs(val) : size;
->arch/riscv/include/asm/bitops.h

The compilation log is as follows:
CC      kernel/bounds.s
In file included from ./include/linux/bitmap.h:11,
               from ./include/linux/cpumask.h:12,
               from ./arch/riscv/include/asm/processor.h:55,
               from ./arch/riscv/include/asm/thread_info.h:42,
               from ./include/linux/thread_info.h:60,
               from ./include/asm-generic/preempt.h:5,
               from ./arch/riscv/include/generated/asm/preempt.h:1,
               from ./include/linux/preempt.h:79,
               from ./arch/riscv/include/asm/percpu.h:8,
               from ./include/linux/irqflags.h:19,
               from ./arch/riscv/include/asm/bitops.h:14,
               from ./include/linux/bitops.h:68,
               from ./include/linux/log2.h:12,
               from kernel/bounds.c:13:
./include/linux/find.h: In function 'find_next_bit':
./include/linux/find.h:66:30: error: implicit declaration of function '__ffs' [-Wimplicit-function-declaration]
   66 |                 return val ? __ffs(val) : size;
      |                              ^~~~~

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/bitops.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 238092125c118..3c1a15be54d80 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -11,7 +11,6 @@
 #endif /* _LINUX_BITOPS_H */
 
 #include <linux/compiler.h>
-#include <linux/irqflags.h>
 #include <asm/barrier.h>
 #include <asm/bitsperlong.h>
 
-- 
2.39.5


