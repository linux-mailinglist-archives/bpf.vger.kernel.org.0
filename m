Return-Path: <bpf+bounces-57106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A9AA59F2
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 05:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0ED54E38DF
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 03:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA3E1FCFE9;
	Thu,  1 May 2025 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCyMDuDS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA41EA7EB
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746070046; cv=none; b=phEVxnQ8RF2D7l1FY4V03ClWxBP2iuEPNJ7ueCQJ53ZxZ/ESZG4Ng3zycYARqhrcDuK0SVM8t43NQ1scaGcSQtHf/Q2++cn1AuFsZ+Fh6L/mDVWrkegCJOvf7hhRwiG+VoeNOJJzlPjMeLW56rJJnia/QSM5WXleihuV3iq2Zjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746070046; c=relaxed/simple;
	bh=mCvK2Bn96tNAtEjhhXJNblseUatV4tgB2rlOIpPbsXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O+IyaJsb2n3z3eR590IvH41QGIrbivSBT/d20AKke0w5JVAmLDaS/rR1kr62v1VHJUw144ln1LhLjYBRde4gdmJon4V9hgjjv+UIatfjvHrAcatieA8Zv6ulpYi53DXNfIDXYOsCVKbeSn+QbebYHN+S/WduyqPMI4vJwbXN+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCyMDuDS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so589220b3a.0
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 20:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746070043; x=1746674843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aw+Ro05sikLFI0WGXQ5OBB3RUGJYZUWL9yUFgZQkPbE=;
        b=TCyMDuDS+hptgwo2+K0B898DCKgVWCaFM8RX4CZfNvz/ZK5mjRiWKRyb+VBV2wX/TP
         iLch/XoofaIxR0qBAQm8LnFXdDvW0/GbLBYdIGmxBxnfOgDdIDrIpcD4GBIw4sE1IhPl
         s3YHJp1Cd7XLhpSo+03GN7A7mTjPxQrRHzk4+ZSs+OQI7rOiNYelO50YKdb2K5+0TKDe
         rSn04h3qOnbWeyabj/qk2q552+hOoKiNBuh1SJ2/8cc7ML/hw10zjEqyoP2HUm8ppwK5
         hXFWKbiwUwnplijFBKgzZtR41D+aZfaXogq9ACMVf08fWTmY6/SVjlBYT0p8MWt7Jb9b
         AWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746070043; x=1746674843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aw+Ro05sikLFI0WGXQ5OBB3RUGJYZUWL9yUFgZQkPbE=;
        b=VOaNmrGWKHzHAIkdjcUfQ2oKiQHVB4UMS3ySqTRMGh7n2X2cn05XXh0/S7Yon6Qx1I
         fKGemembZ9P6i7GlYUPJ9o9w6VESBHYLB2H2ym/lnvM74Mht3+1R+w/2zeS8dDdMl5Im
         tz6uWljIPoKUzYgAobWsDvJCtprNuZl5jRMf+u3BMvXQ+5I8BkBfmsa7ylFjz378922C
         DNeX+G5RMiJsl9UejZE8CLvnUb/YpWvpLlG2PHVqZqnHuWRSAfD6RC82BmSHsC3wLv8i
         eu4af14lTgku4o+9iAES/UYvvFadmW6pSHC7Gcr/GtRmZFlfse9LXhvz07xz0qkP4Ja8
         DNZQ==
X-Gm-Message-State: AOJu0YwvUjmjJ8QLChmjuulUFIX1xOqdUwt6hitbizeC6PjVBPICQp8Y
	jqLqLo3Zuv5NooYarZS4OhNzKXX3nmSRodTp0LbJ5KO2TxDSF+9M9ojhWw==
X-Gm-Gg: ASbGncvJvLrXGmSuX8UTGX8aYvClX8OZ1KhuPrX1qeDldhSLWADY222+J9mbS7bciIS
	95aPR1SXRxFhVi/Di28XW9QMk32XWfVec0Bf1XT94FPd0spj4u7SQfr8P37drIQtqimEZx9UMr5
	yZYbDHoJMglFR24lOpoTrOWD4zWikZhiK8hMooJA67tM8uskNDiZPSHgRDrPYUznpykQAVhf5yw
	t9xth8SOQ9woCwtwjX5G9DbJhUa4CbCpXjeH0h+2ujVkEnslfbVbqQE8axHjz51sO+1q9pG7wBO
	7a4lfn/gPZqnRA0iWHX2VyFEZlFZpwgxyinEKG22YHELzTLjog2lhvu5q91vsHbdVLy6
X-Google-Smtp-Source: AGHT+IFX4ndpnowLzcHiwow2PuoezZZzTSn4BGhnzyQUjSnQBLptkaQCVUY7qSA6UYf1gI5AOUyjIw==
X-Received: by 2002:a05:6a20:d706:b0:1f5:5ca4:2744 with SMTP id adf61e73a8af0-20a87c54283mr7013669637.17.1746070042944;
        Wed, 30 Apr 2025 20:27:22 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:13f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a310f6sm2519013b3a.114.2025.04.30.20.27.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 20:27:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	hannes@cmpxchg.org,
	willy@infradead.org
Subject: [PATCH 0/6] mm: Reentrant kmalloc
Date: Wed, 30 Apr 2025 20:27:12 -0700
Message-Id: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

As promised during LSFMM here is a reentrant kmalloc.
See patches for details.

Alexei Starovoitov (6):
  mm: Rename try_alloc_pages() to alloc_pages_nolock()
  locking/local_lock: Expose dep_map in local_trylock_t.
  locking/local_lock: Introduce local_lock_is_locked().
  locking/local_lock: Introduce local_lock_irqsave_check()
  mm: Allow GFP_ACCOUNT and GFP_COMP to be used in alloc_pages_nolock().
  slab: Introduce kmalloc_nolock() and kfree_nolock().

 include/linux/gfp.h                 |   8 +-
 include/linux/kasan.h               |  13 +-
 include/linux/local_lock.h          |  15 ++
 include/linux/local_lock_internal.h |  36 +++-
 include/linux/slab.h                |   4 +
 kernel/bpf/syscall.c                |   2 +-
 mm/kasan/common.c                   |   5 +-
 mm/memcontrol.c                     |  60 +++++-
 mm/page_alloc.c                     |  21 ++-
 mm/page_owner.c                     |   2 +-
 mm/slab.h                           |   1 +
 mm/slub.c                           | 280 +++++++++++++++++++++++++---
 12 files changed, 396 insertions(+), 51 deletions(-)

-- 
2.47.1


