Return-Path: <bpf+bounces-23098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D848B86D7F9
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B9C1C21B72
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868107B3E9;
	Thu, 29 Feb 2024 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2tKJqun"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539125765
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250204; cv=none; b=MvZ9slcYPt7GIVd6ABfikT6jSceaBEoZtQ3dVtOSVsvrM++bkLl8U2NkPwtbQKFi6bGs5NQFwCVPG4Dr3erwBf4hjaLkkqz+TuVmBiK4mFkL1kxhFfaCI9Q9yxXPLPd+ksDIYaVFFmY4aOJD049go6Qw43sG5awsBEmggTOGP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250204; c=relaxed/simple;
	bh=HweJw/5uclsHdfwyh7T1TUIXyB08G1YB1P9wF0mSzO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpKSJHAdeQDpepCjqH6Vuy4P6pPHHGqCk03KDlLROgHRbdk5ftbJdyc8n9qCs9sKei6jecyhvDSpR6cmJ6I5biCiqqXOQ2T5WjvwY6XlCSTBT6Jx3NjI3MZZwaafHPSdRcXjE0HmlRkiQCC3ZOX1z2qPVx/P+cbcNzv+WN70D00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2tKJqun; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc13fb0133so12803505ad.3
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 15:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709250201; x=1709855001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NzHHSXtSLrv/NknHpxtBThbqiIeWhWk4Z2HCRi70who=;
        b=X2tKJqun/xXYdeKTfdxu+mySkPbLw36Hya0tqymUeI7qpYgeCtLikpEQm5nKTE+n5Z
         Dkw1gHTOtLlWHKkLl8zh/CDZmSaSPym2QN+Pl/gnVeSVeT5ePPekc1BNNCpgWcYFlIgT
         rWqpJNjeYmuhyzd6j/htljxHvcccYJN1jXvzjzcF3DOL+kzoSl38VYbeDScvA/9m53IN
         83Fk3WvdZe2MTleM1b/+k2KW0qDpPCg3zSV94I7XZWxUe/F1LlT2pVU3JSkNbMI+PunS
         nwE+Z7gJdL8SBNCTs7owR5GJ5uPQvvuNcA7hqaFR/f4bqyEoowcNTpdkOyelpmqJcZNi
         WdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709250201; x=1709855001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzHHSXtSLrv/NknHpxtBThbqiIeWhWk4Z2HCRi70who=;
        b=TCbmhtWFX/mO3kEKwOOig/aIAFY5UHqYBuZl8JDXcWJECVaI8H/9GomrbBxgj8HU9o
         Tg3SOpqHmbcHEHCVPeH2FGIuqPeWQ0EUAlXOhTOHDhKyRVs3YT5uiqukqk/sIeEyjps5
         drAobb2UM/raUGhXkzzr/2yF1ESKhrpWeQ+Ui90mNa04S1CrawaO7S+AqZWB2TwLkIv2
         oah/FPklEgenbUlcRwwoqtdxk6reKFZhHK1MKRZ4fBHaIMzZf0lhm2eEoRPkdadNyxHa
         6tqPRFKnVsfQDX1kH3BY2DVYsPmAnzQKlSu3XZvdjHCRG0DQCqFItVUOAR2FQazDXxje
         Wp9g==
X-Gm-Message-State: AOJu0YwXqd/PvkfcJRxnK3n5Wjtlg+pVveZD2m5wzfvtPqCNLXYdFfId
	wy1DMr9yK+aUFFyRVCjdoh7cmsiITT1OR3/kkbljliZarSRmHVL9hzUiomHV
X-Google-Smtp-Source: AGHT+IGfl0YdKr5QO4H+FovdTc3eTEo8Q94QPX7tglxTnGBDlmv4twi/rgWyLSio1iEhhbNejBslzA==
X-Received: by 2002:a17:902:d511:b0:1db:be69:d037 with SMTP id b17-20020a170902d51100b001dbbe69d037mr22315plg.46.1709250201120;
        Thu, 29 Feb 2024 15:43:21 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b001dcc129cc2esm2079055plh.60.2024.02.29.15.43.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 15:43:20 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 0/3] mm: Cleanup and identify various users of kernel virtual address space
Date: Thu, 29 Feb 2024 15:43:13 -0800
Message-Id: <20240229234316.44409-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v2 -> v3
- added Christoph's reviewed-by to patch 1
- cap commit log lines to 75 chars
- factored out common checks in patch 3 into helper
- made vm_area_unmap_pages() return void

There are various users of kernel virtual address space:
vmalloc, vmap, ioremap, xen.

- vmalloc use case dominates the usage. Such vm areas have VM_ALLOC flag
and these areas are treated differently by KASAN.

- the areas created by vmap() function should be tagged with VM_MAP
(as majority of the users do).

- ioremap areas are tagged with VM_IOREMAP and vm area start is aligned
to size of the area unlike vmalloc/vmap.

- there is also xen usage that is marked as VM_IOREMAP, but it doesn't
call ioremap_page_range() unlike all other VM_IOREMAP users.

To clean this up:
1. Enforce that ioremap_page_range() checks the range and VM_IOREMAP flag
2. Introduce VM_XEN flag to separate xen us cases from ioremap

In addition BPF would like to reserve regions of kernel virtual address
space and populate it lazily, similar to xen use cases.
For that reason, introduce VM_SPARSE flag and vm_area_[un]map_pages()
helpers to populate this sparse area.

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
 include/linux/vmalloc.h            |  6 +++
 mm/vmalloc.c                       | 75 +++++++++++++++++++++++++++++-
 4 files changed, 81 insertions(+), 4 deletions(-)

-- 
2.34.1


