Return-Path: <bpf+bounces-48733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD80A0FEA3
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 03:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DD63A0FDD
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 02:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD01C23027B;
	Tue, 14 Jan 2025 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkYXsUPO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8FD224B0D
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821202; cv=none; b=mOlsYSgOj2xjorztESEnSdp9AFSV0h4p+XkB+9FebbVf2WMwSybl/+CtoMLzvkf6djl5fW331X+LGDfkU/5SiRcNkPq9t1c0uVbGVa53obZmm/Tr2KuYodftU6Q4CLoTpgfjciOt5pGCfG8xZExcTtWLAHwus26AtzkyKqbQ6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821202; c=relaxed/simple;
	bh=qpD82EOTiD0WuUW0ru5J3NdtZhJ8QpRSIPbqAuteWAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Al1rebunF6dsE2K3BmS1nzJihqNMungQa+dsvc+9NIEDcnFiikpd+cMuVdtt2v2b0gYqt9RVQBN2Lr8BEtnt+K5tu9HY6Xk7tGdDGLPlztW4eQvknMV+VlsuntmzQXdacCP4QG7k/OJeE0VMPp+9VMldObihlnAFVbOv3wXKToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkYXsUPO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-218c8aca5f1so107113585ad.0
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 18:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736821200; x=1737426000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YPnFtJFai+0xFpNHgKwg1vEFPjmUMGue3EQsxvwhos=;
        b=gkYXsUPO0Po0Pay1CkB+BlKF7qffTsv8KxaJoKh3obQmg8qbldnKs9ALZ+WAFqUz9A
         6ORHonYWsjTXV1i8HmCm7Weq5Xm226RaZoUlJ8xxXkNiQ93FVH/AkMK9gVU+MsNxV2sK
         d6YpHDjoayNJJroYBucX7yB4mQRwm2yzdfL0+OrOuUdoCs/xr+IWiz4fdPfYvqjXoiWO
         UGuQAmwq8WUbHkoH5UCTH92RN09wtCrCQQyM0NJOOCgErbccA1Mx/E6gqynlkqxhw3mB
         ukJu5CCwoqXPlqMvc97JIJTRJnO+ulw9TydHCH1/RIBKadnMD7QprI/MplfswffT7t39
         akzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821200; x=1737426000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YPnFtJFai+0xFpNHgKwg1vEFPjmUMGue3EQsxvwhos=;
        b=DWhvgblHdOpQDCUaqtHLbtwJL7nV3CKaCSK1zdKQBIsSCsGohZ8k4vjEMt3M4FwbRt
         7WkQ+Uj2uaewIxI8aQgDql58sExXQpR2Lng8Lca3JWpwZ7f7FgcAp9YPCGvkU2wjyAs9
         ZFhg2ScfFPrMGn8mFGnn5EXM6nbbDiGUCLJxMrowqUEp3/Fcp0HG3fzh8QcJCJAsR0jO
         nne2XqFg6sh6do1mYSj3O78Gtc6WuNh9K8jDsVr/wZxJRdmtXGVZXoo0Ir/d/R9ZOIoP
         iWAX5C87IXH0vVJmprx/6LYqR2IvaqV3WL8xFijQESURqJLr0MJhjqXhpAtaENRUGuEs
         6GoQ==
X-Gm-Message-State: AOJu0Yz3KYbGBxpvB2UoReItEnchdVFaMGWHDAIxFLrDSERPYtoodrf6
	9I31Ue694XoGoPhK62fijsS94AK7++ClhOb1vqvOhWnO+Zr52ZzYP71Miw==
X-Gm-Gg: ASbGncuv8o5pXjtItP+5+F9lYpYj+tHihn4Z/X5UDdZhCXHDwlGhItpZDOCP86njuuk
	TsYgM6/sruDtw/e30gJckWZ0L0wd4XtH82eBQN8czvkySHYs2g+V3MTpaf2caI0bjegoJXJcwb4
	Lsh4qAvNZDd/lAO3+MjeJtDlV/WDnebukeWNUuSjCHxFoXTOhAqC3+NcFf5OS3Fl211x03ATsrB
	+o4VxDv89y4NqFAGufsdcD7kIbwaHowyHsGSFKVW74NFCvyBFZURHPhAduPnAMUATgI+ewsHklS
	JN3esIcg
X-Google-Smtp-Source: AGHT+IFK2Q/NzWEMQDd1zkERrN23lZllcwNoRX4XpjEtT4xySg8TTJ5FTM1kqalpNAWOVle2SSYeWQ==
X-Received: by 2002:a05:6a20:4394:b0:1e3:e836:8aea with SMTP id adf61e73a8af0-1e88d18eab5mr40855550637.14.1736821199823;
        Mon, 13 Jan 2025 18:19:59 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a5fesm6475293b3a.48.2025.01.13.18.19.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:19:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 6/6] bpf: Use try_alloc_pages() to allocate pages for bpf needs.
Date: Mon, 13 Jan 2025 18:19:22 -0800
Message-Id: <20250114021922.92609-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Use try_alloc_pages() and free_pages_nolock()

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0daf098e3207..8bcf48e31a5a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -582,14 +582,14 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
 	old_memcg = set_active_memcg(memcg);
 #endif
 	for (i = 0; i < nr_pages; i++) {
-		pg = alloc_pages_node(nid, gfp | __GFP_ACCOUNT, 0);
+		pg = try_alloc_pages(nid, 0);
 
 		if (pg) {
 			pages[i] = pg;
 			continue;
 		}
 		for (j = 0; j < i; j++)
-			__free_page(pages[j]);
+			free_pages_nolock(pages[j], 0);
 		ret = -ENOMEM;
 		break;
 	}
-- 
2.43.5


