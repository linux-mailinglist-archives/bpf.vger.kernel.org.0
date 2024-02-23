Return-Path: <bpf+bounces-22624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC088620D8
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 00:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C385F1F25DB6
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 23:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58114EFDF;
	Fri, 23 Feb 2024 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeSKyQWe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648814EFCB
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732655; cv=none; b=Gdl7CW+Q/IpQ5/JsfqxVQjJk7xjqfx1Sa0Kh9TGepPgUXmvRwz0YBNBKdFVA+wYtvfK4dpc0XqDtDSxps9z37W2MI5lgueVJt+nzCttWBpqK4oCI0nVEjZrSF3XRPorHFj27cIDNyFH7nPGfRpyB8s9HsEy0Lb2xR/RugSlxbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732655; c=relaxed/simple;
	bh=YApudGTiTefm/+WRFKGhnMeO/FKl6RNLveWzUuO3P9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=irEVho2EJ8VId5YTY9RC3fgiivnFFXrY73KIozUAVEs2Qac22LwLM8KS1JypLVi9U+yWX1W1LLEzGLKtQmj1Lnfry70/AeB7d8kCyMBb17da4s0xKCCMVj3TrluXFf/5iXbCasGk6R+eOIKd0qcCggl8ZbkUmxkpC3sQASRWvlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeSKyQWe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dc949f998fso657014a12.3
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 15:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708732653; x=1709337453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSYW/f6ddyBB9WtPg1xLnsJlpquY1/ikpKTyYScqzh0=;
        b=IeSKyQWeyyknmGbT2w7or6YTi6i4mSpYM4BPmt/hAB86C1cBfXIgwDb8eZ8sYl4aBo
         o66GsehWrpeTyNM3XufB+SrwLZVH/+t+YMHITopJuov1DxE3p2bF+sdjNxrbKfcBxs17
         OdNvNP3fWIYkR4W7N9hkKbzRBpIxVRSfSXyL/WQ90qF6IXW2iing48Ngsqq0JmksSR16
         hCO8rePF6MOPQRDj/lsErctlntfmkUYZdGax0UwRPM6EH/yc1Hh/RFI1YnTLeFocsfq0
         FgoyhnS4S/jr94wtu7mmIbffznkI3C7QBwbFavQaByPNybyU9hgsqLMqBJzvs0w4V6nM
         YjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732653; x=1709337453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSYW/f6ddyBB9WtPg1xLnsJlpquY1/ikpKTyYScqzh0=;
        b=NomQFsM2gro/65+msOTxp/W35q8TBVMzflJyBibMBjbVpaGyWpZHr0jtY1SgDK5Wit
         hXhoiKRNiETwGwD2KXxg6yqNMYmqd1jxSG7agjUb4Ymh3e6SSI4R+qPVF2QZ1+33kXKI
         sgcynYxE/WqtodXjMWCGlhsOcqzkDVBu3b/KxnpZv8aJUwX6JHA+e+/c6KmrqDDj00Zb
         GQd5J6L/MpX8lflz/QgU1/f1uLLiwrgqv/IGpERM478ak7rkfwHc8aZ4utNCMH/ycfiO
         bXiilPoawBeN254GLJ5qIo2irUe0aFzT1OaZ1IiRwnd0gbayLV0HV4ozryfVEQwBw1/U
         qnGw==
X-Gm-Message-State: AOJu0YzunCer4+D/eGJ9NhzAzWArTuAz0YLpVWIohlg9rRSSzcTbOoJ/
	5SmY6XwSrb/Gvesqp2RbhhtJrHG7s+QmM4YEDIaO4JDi6bhPfnXkzOR2vBG9
X-Google-Smtp-Source: AGHT+IF03Ip9HN7hOBgclqSMTFdHG7TNdTZF9AvtgtNN5+5+EnBr4r8zdxXO0SElDm498lBK65E9Ag==
X-Received: by 2002:a17:902:d2c4:b0:1db:5213:222 with SMTP id n4-20020a170902d2c400b001db52130222mr1899819plc.5.1708732652680;
        Fri, 23 Feb 2024 15:57:32 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:45de])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090323d000b001d9edac54b1sm12313162plh.171.2024.02.23.15.57.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 15:57:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	boris.ostrovsky@oracle.com,
	sstabellini@kernel.org,
	jgross@suse.com,
	linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 0/3] mm: Cleanup and identify various users of kernel virtual address space
Date: Fri, 23 Feb 2024 15:57:25 -0800
Message-Id: <20240223235728.13981-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

There are various users of kernel virtual address space: vmalloc, vmap, ioremap, xen.

- vmalloc use case dominates the usage. Such vm areas have VM_ALLOC flag
and these areas are treated differently by KASAN.

- the areas created by vmap() function should be tagged with VM_MAP
(as majority of the users do).

- ioremap areas are tagged with VM_IOREMAP and vm area start is aligned to size
of the area unlike vmalloc/vmap.

- there is also xen usage that is marked as VM_IOREMAP, but it doesn't
call ioremap_page_range() unlike all other VM_IOREMAP users.

To clean this up:
1. Enforce that ioremap_page_range() checks the range and VM_IOREMAP flag.
2. Introduce VM_XEN flag to separate xen us cases from ioremap.

In addition BPF would like to reserve regions of kernel virtual address
space and populate it lazily, similar to xen use cases.
For that reason, introduce VM_SPARSE flag and vm_area_[un]map_pages() helpers
to populate this sparse area.

In the end the /proc/vmallocinfo will show
"vmalloc"
"vmap"
"ioremap"
"xen"
"sparse"
categories for different kinds of address regions.

ioremap, xen, sparse will return zero when dumped through /proc/kcore

Alexei Starovoitov (3):
  mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
  mm, xen: Separate xen use cases from ioremap.
  mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().

 arch/x86/xen/grant-table.c         |  2 +-
 drivers/xen/xenbus/xenbus_client.c |  2 +-
 include/linux/vmalloc.h            |  5 +++
 mm/vmalloc.c                       | 71 +++++++++++++++++++++++++++++-
 4 files changed, 76 insertions(+), 4 deletions(-)

-- 
2.34.1


