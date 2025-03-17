Return-Path: <bpf+bounces-54151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC5A639ED
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 02:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0597A4944
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 01:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C65674E;
	Mon, 17 Mar 2025 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="y1U9WPbR"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512B9475;
	Mon, 17 Mar 2025 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174200; cv=none; b=eDiBg2TV//0wrS8fws9KvX/MT/f5GjNu9JJRs349HT6YXaGtzIo0RhPnZqP6AHUjIpGGc9wzJ5mbHbuE+eqAi02ujhKZ9rsrGTwgQp9Ahq549rIPlbcf/jpufM39Rc3vy2E/2XNfMJZ5qPCQzbE87pYj5qHvFik+QniqXT8oklQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174200; c=relaxed/simple;
	bh=f8ylXnYjAovcWV1hNoHapa560iwl0vQ8IUpRdomoX/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6mfIluO8uMFpsmlXqDZj33F/0hYptzX+axFTBQGnDmwoa4aNwHMBQE6DkmhrdHgoQg+CRsq7DdNcn61FvFlfR+glovTqJXAp3gNxdh9/CBc5GvMyeD5RoNBlEBIPBsNp10CwNFs2VbjWWUo//V5/ZPdA2glRfrjfWCMRkLcFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=y1U9WPbR; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1742174161;
	bh=hq7yTqJjEJZI2dh88leRFyAcAEXTLAjjYen6xx/Xhl4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=y1U9WPbR30yRbugm8d46HlUYmub5A5K+pOp+unT95xiA/XxyTg5lUJzd12juRG8sT
	 EbkatqxwCMsNcq8+W8RMgr5Tt454eUNc2IDsbOoyGE0kSbT3joM+b74DYnSrJS5D1Y
	 guMqrGl9Dd4G0TzpP4V+JP3VYOvJhmLEaYtmXYJ4=
X-QQ-mid: bizesmtp81t1742174160tir17omk
X-QQ-Originating-IP: SGvaLoQUkpd+nVwTtSlgYtBTkVDZgUgEQc+P/mDtWLw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 09:15:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1266053070833588393
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jann Horn <jannh@google.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.1 v2] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 09:15:39 +0800
Message-ID: <16124577164D1373+20250317011540.119614-2-chenlinxuan@deepin.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: MvUCj+jJbjsS6KzfbsRO/OwRuTm6e0saO/H6K90gZXwHCSybgzPv3uvi
	ffPLapyFVhfEdO7jGO43ijCq6OGYN108rxXjocqnkgibMqySAmrKaqI8EHaPkU/CpMLLxPb
	Im8ap+7Wa/Ezazk2gMObwPS+dp6MF8HjtL2N2pSAYUB0gdEaIG7ITCQ4yXeF1rs3dFGN2or
	sR68Og8Q5dX3ZLfk9LcfQN0YPhanZHJ3FdBYiE/2bhzmpfSj2mz0q0xMggaJOY9pX74f945
	erFZDTCtLydZ4T3KRjMgERsuMH2Qgam/E4cwMgEC3mftX5Mn+NJdeG0FRDVs2vZ0k9LOrkP
	u7EFY9HEnygIQ07vTh6i75Bo0ot0c80s07Mn6fMCC2a2WC6iwUtLkMbh1iMi3d8AERKZjPu
	ce8vB1bFg9LVwOdMXLWf0hl6+SN4EOOIubmGwfDEiw7f+BfR1WfCM8M+3cavHWlx7KKLp6o
	r6KdZcv+Zw21sY2lTePOI52qXyBU6wbd+VBNhrl/EcCFRHtpJCAYnOAAQal8KFlnMRPKjEg
	9VDNGVR4Cy5aZzLOIRfIsb7qjOXEUGCP28gJ7Mw/fbnRLOyA3wpF2OIM/AMQchBha0Q5An9
	KlhOhl7Zv5e5Xjtaf69OSm/op7qTOr3fOqbg2nQrMIgLTuv3mhAZQ9vCTTfE6zIUH5WCggU
	mBHgCyi1M+Z7EjNtf6XBoSki0mgA97WDZdPAd6c4+/W2bc2UPOaJYhZlTumnch0BzyfAM/v
	0ASH/8n5y2OCFyKml1PyZyiGuvo59bwuUIbkWM3Q5ILotpcCd6tiOqPQyNDYmsN4rVBAETc
	lqP42SydbuEgzziIV+I9yhFengPgtJGjnfRY57Avyh4VqFghe4tz+658lfdlk/cUfFNPcRQ
	Zdwm0WFp6hLc7YJQSXW3XU6RVvSab7eYGJ4zvdvkfUqzGlYd/lz6YZTKCgkOEKycLlGbUqz
	70aGYJKLRYfjNkB30TgSIEO7X97YCQy8CpoV0MEsS/xw0o3NelWZBw6CG9E3kIemf9dMdL2
	NOVsTWQV+TOB2MSauEwB4WvGRFJDwCZNpfuRWn23fRJpWjBtQF
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

[ Upstream commit 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f ]

>From memfd_secret(2) manpage:

  The memory areas backing the file created with memfd_secret(2) are
  visible only to the processes that have access to the file descriptor.
  The memory region is removed from the kernel page tables and only the
  page tables of the processes holding the file descriptor map the
  corresponding physical memory. (Thus, the pages in the region can't be
  accessed by the kernel itself, so that, for example, pointers to the
  region can't be passed to system calls.)

We need to handle this special case gracefully in build ID fetching
code. Return -EFAULT whenever secretmem file is passed to build_id_parse()
family of APIs. Original report and repro can be found in [0].

  [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/

Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
Reported-by: Yi Lai <yi1.lai@intel.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Link: https://lore.kernel.org/bpf/20241017175431.6183-A-hca@linux.ibm.com
Link: https://lore.kernel.org/bpf/20241017174713.2157873-1-andrii@kernel.org
[ Chen Linxuan: backport same logic without folio-based changes ]
Cc: stable@vger.kernel.org
Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
---
v1 -> v2: use vma_is_secretmem() instead of directly checking
          vma->vm_file->f_op == &secretmem_fops
---
 lib/buildid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 9fc46366597e..34315d09b544 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/secretmem.h>
 
 #define BUILD_ID 3
 
@@ -157,6 +158,10 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
+	/* reject secretmem */
+	if (vma_is_secretmem(vma))
+		return -EFAULT;
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
-- 
2.48.1


