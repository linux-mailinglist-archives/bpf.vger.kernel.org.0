Return-Path: <bpf+bounces-76537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C0ECB93FC
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 17:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1519B30577D6
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCF8252917;
	Fri, 12 Dec 2025 16:18:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0779B665;
	Fri, 12 Dec 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765556322; cv=none; b=g9kts3ZHCtpaPuOE5wXMmzNZejBK5iIoG9LgP2j8+WwtN2GSF827zn7WDIapKxS48yy7TEyMZRxIAm01y1Vb8ljC3ogqHZpcuktRFMlPiraZWOmucsUQ3XIMgdfCcwujIeQp158+qiP4SW2QQ5eRf5R7t5z/F2vONSRPeDGC0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765556322; c=relaxed/simple;
	bh=PvZUUv3hTC62+IbO1R8DkTxB4VU97n1yoZSO3javBG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=A2vS8mH7BRPiSyFPHTvc2Pp0vYoCxHlzUbHeTPxRtL8fqIHtcNaENre9geEZMorwh/6BVlMN56jUYz1gIczS5AqJsyY3+OhwrnHlkJjXeWW0h7SO6jr2kSuBU2QWBgR5XjsC1EU+cliJKfOiYLWAwaKvb6MI/l79pYkOdxx6IJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D589B1063;
	Fri, 12 Dec 2025 08:18:32 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC0EB3F762;
	Fri, 12 Dec 2025 08:18:34 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com,
	kevin.brodsky@arm.com,
	dev.jain@arm.com,
	yang@os.amperecomputing.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 0/2] introduce pagetable_alloc_nolock()
Date: Fri, 12 Dec 2025 16:18:30 +0000
Message-Id: <20251212161832.2067134-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some architectures invoke pagetable_alloc() or __get_free_pages()
with preemption disabled.
For example, in arm64, linear_map_split_to_ptes() calls pagetable_alloc()
while spliting block entry to ptes and __kpti_install_ng_mappings()
calls __get_free_pages() to create kpti pagetable.

Under PREEMPT_RT, calling pagetable_alloc() with
preemption disabled is not allowed, because it may acquire
a spin lock that becomes sleepable on RT, potentially
causing a sleep during page allocation.

Since above two functions is called as callback of stop_machine()
where its callback is called in preemption disabled,
They could make a potential problem. (sleeping in preemption disabled).

To address this, introduce pagetable_alloc_nolock() API.

Yeoreum Yun (2):
  mm: introduce pagetable_alloc_nolock()
  arm64: mmu: use pagetable_alloc_nolock() while stop_machine()

 arch/arm64/mm/mmu.c  | 23 ++++++++++++++++++-----
 include/linux/mm.h   | 18 ++++++++++++++++++
 kernel/bpf/stream.c  |  2 +-
 kernel/bpf/syscall.c |  2 +-
 mm/page_alloc.c      | 10 +++-------
 5 files changed, 41 insertions(+), 14 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


