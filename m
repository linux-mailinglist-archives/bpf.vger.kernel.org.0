Return-Path: <bpf+bounces-76658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F69ACC07CE
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B979301AB14
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C81C8E6;
	Tue, 16 Dec 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g3dqHXx6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86D27A10F
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849673; cv=none; b=VHt41vaOqj2klR34njb9FHsxUozw2cHgxb7MKYPQnIHwXPOaHOP1ItCMe9Egp/LnaQDmFXGstYxY6tjMSb8Oa87+kWvRMvYmSLPecMvDku1GluezRrEACYMbWUoRwV1MMbIkWpYI+h2XeDmsiw8O6scFPW1PJjNHXBZlE4GI1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849673; c=relaxed/simple;
	bh=dxxUXPsKpc+ktrYr3NX238Ynrv7KxxIKYL2RCz+WmHQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SY5gC9/d34/pPw5VFvLUIeeMy4D6yE7DXhRWUp9Yu/oX0fNYNJ5Osrd6ulhv8l/WeMm20hR1EbMZQUoM7uvxPPhJTls1v4Q5SWMuN2EqX9glCwJYJeW9kvuwZ6bylJqlnJ75EI2rGYGJXJiqP2QHRIYzAlqrA2qBzWw9p2h2auA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g3dqHXx6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7f1243792f2so2658387b3a.1
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 17:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765849671; x=1766454471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQt8uoJWMBYj/YlVtM/kz+RuiqvE92xrlYMKIfu5C3o=;
        b=g3dqHXx64g4NxoJBvMgwNKHuEl+d8v6k0mc/NRPR0IXilgmIzg3TeN0wHeXBXxUXal
         ck399q1FcUVy54ylRlE+aISXUZ/d3h+RiIBKa1I+QwIGfhz1RSNwGRng139WauQ4alTp
         hBCB0Tgqh7YPFaQJmmdL7w4yrauY2XK7ABtN7pioIRsUawiMn1G/dh3+UAiPkVTkyqtG
         YXeuXyQD8i4ieyVWK0Eki4+GaJYuV+LO1i7hNla94ycsRZv62L2t5Qal/+M6cE3H34/H
         h0QfuTfEv7cZts+ElUVUQtVhaDORhoCgF2Ib/5o1qcr+lC8YS2KABuh+1HYsWYTjLODH
         KpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765849671; x=1766454471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HQt8uoJWMBYj/YlVtM/kz+RuiqvE92xrlYMKIfu5C3o=;
        b=X5kmyuknCRwQ61X3BncUWHE/Vdd7U4bgsf2mFeOlInbGk670Uxa9+Fs1YkHUkovmIN
         HEuynQ8ekUIkN66fPjrxydH971Ph2y9Y1Q3Pby0QlYJxz08ZDVFGPqRJFzt4eBQ9N2Bc
         W+kr6kU6UQP2GXByHaDNx/w/URYKWUsyntIjv8srPRYfKFb4PTVm22F/+VXqZDlvOrkP
         6WU1+mSC5v6YdakNHw7Vb3Ja7Y5zTsqWoJL2016dfKLffYsKw2FxdU7dhSv97p78j5+l
         YWWRLcyid56CQb57aZVla14u/9aK6K0OvZKwiO0Exl16/znyp69ZnHzLo/eGPuWQCyvK
         tWZw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Gz7aF+54+efqBGbe8YeTK9mDmzmGHXSPsKUehdoAYo3h2PP0LajBZ/LDoj+OA02MXYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQB0HOBogFC0nMJ1+hDC+sF82vOJQfO/FpDlDj+7l1fROntYKO
	xLtOKygFiyXJwBJKvY4qdLmknRJjDTyDqRWUreFt5OIbsChxeBzQPjFW+a5GJiRExVc=
X-Gm-Gg: AY/fxX7z9vsz6E0+SZzu992lmO5VRZkv6NrQjuA9YkPH6qfn0KiakxCyjc7FGAJpHCO
	Jd05Qyu9SN/062CRhMIspemgr8Oqb/relAs2lzyUyWXZcIJdXfd1qdTZxtTF2u9d09qeasvY5/7
	Vi1NjRpO/fuxele9PtFQW/q5YoydO0/GNdYod5wWln6DpMRQpr/ET95UGLkcmkNRi5pQB7hU7xl
	6cibJuSqrebYM6CcKVN99YfsvzzEfC4VhZJrfEGXg2xPmnnWv7UitsxLOdCHHaUZWOqeYyZmFRx
	XOr2R1wAMk1n8SmNzOZqUx7o3wyx8bgu2lcHCduElr4HJ+iw20jGg0u6my9c0XzsaixT1RsbaFT
	Bulyng6QhEsZHoz5V1+pDh+LXxd1qyQJPmRxPiacG/W01sbocIp+GxRSpe31oek+tjRu7XzIN0e
	XSy+XUU1nnOaneCqHlNc0P1qrVDYeWlNrX6W7G4HMDHkve
X-Google-Smtp-Source: AGHT+IE5/ROoI003OCaxm/0k3SuDfxUIEDBUTPu0GmjjWMBKr4s+4vh/dmnl09LKvowuDGy06jqmLQ==
X-Received: by 2002:a05:6a20:4320:b0:366:14af:9bcc with SMTP id adf61e73a8af0-369afdf778bmr12452247637.66.1765849671148;
        Mon, 15 Dec 2025 17:47:51 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2c963b53sm13632790a12.36.2025.12.15.17.47.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Dec 2025 17:47:50 -0800 (PST)
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
Subject: [PATCH v3 1/3] riscv: remove irqflags.h inclusion in asm/bitops.h
Date: Tue, 16 Dec 2025 09:47:19 +0800
Message-Id: <20251216014721.42262-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251216014721.42262-1-cuiyunhui@bytedance.com>
References: <20251216014721.42262-1-cuiyunhui@bytedance.com>
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


