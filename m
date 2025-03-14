Return-Path: <bpf+bounces-54027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A47A60CA5
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2847E170DCF
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B941DE8A5;
	Fri, 14 Mar 2025 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="jXa4I/G3"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852081DE2C1;
	Fri, 14 Mar 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943032; cv=none; b=I75emS5PAopMq3t3RECdbvNcivNAa7VGV5ALFE1sMEkzunIyQpPFsouehwibqhNKFFFRkHU8tD6ry24RLGbJ0NkFscxr90d2mS+Sie5xuMHWV7Q/l+US6GKYW03yyxlfdYDqr4RKz6Mb2+TLFuAhtq/f7i7GmnDWa37zhoi+FgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943032; c=relaxed/simple;
	bh=ZErZMC+QOWToIegQ2iKmCvjBmUNPIrj83qIYnRryRRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnT6hK09j2f3H+fVn7df2FNJvsRViQhCNdrnKZAPqX7xKXyR4ZTUCkxayIBVyjOqyeWlQi9JfDr9kFKD/G49v+V/wzZ+baacydUVWh69JsvPK5wV0ZEn0oxWgGulwbfgkS/+DGUdjflhE9qcTEmo/21ptEir+ngcu6eCN5Pnlbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=jXa4I/G3; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741943015;
	bh=F3Mr2gHjrrQbbfObvuHIpoye6jVxjDNGFB92bMbmjnM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jXa4I/G3uyCQg1WD0syZm8bEx4u8LV2xsCI9VQgC9WQoQDLXp+t7lMNZG3sHxwV+J
	 3LmW5qqn/zc6zbIAphiW27/D8bXgkoMkmRLwN/PwiR9UhtAVotwmjHHicvnMonA6Fg
	 hqwLVLhX58srmwO6KfZReoYIPEXbOEXQuVJGkolM=
X-QQ-mid: bizesmtpsz6t1741943012t48o76y
X-QQ-Originating-IP: yWt2CxAOtvx3l3yIbs0QqGFaTolnx3VFoOEH3BYpPD8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Mar 2025 17:03:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4056344661151254047
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.1] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Fri, 14 Mar 2025 17:02:47 +0800
Message-ID: <5602B4F2D8F73293+20250314090247.31170-2-chenlinxuan@deepin.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: N2uXtyrSU4Fu3wpACaovTJUP+GajuhxUR6pKBTRzKenMG8bkFVtrUdaj
	9VnFEzRe2Jt6/MXQKV8lL0pBqDz0Bqlti5oI1KxwfRNShTixDnkT1CZ90u1uktmxkRd6WSS
	j4natsBdxEjDIWDyeVb3HV4LjRl50Q3hpiErT1gJ2bDBFxc7C+ubitiJWcpfFc1dNYUAt65
	QK2QIYmN5ETM3pe5mwlu+3AwzZ7mp8gonYreBmCoRf7HRnktpniGTLbhD41yk2rFrBE5RL2
	Iol3qTwdyk03GE0Rz7iNn+1It46+j27m/4b8IJacOemhyFaQmyvNm/553jnbWfo5aensg41
	fDrfYAFPGMaRd2+GwIZ01V7sgFd6ScOXGVcfda5n6Mxo5rwYMdolzyyU8XgHTh5SgA56MCz
	jHfCHJx8kCbGUrV6IlHKnj77rCBxVeQIQxBVUlEwQKbo5/hT5IuNvWGE+kU5utjKv8l+dnj
	xVVay8U2OoBidcowcZlBv0aVI3Br87EojcPYemUy0iZiAzbqI69xA+3xYx1jEjDb0SVo/Jj
	VzVSbn1imw5YupfqkenibARcEWV7BQvtrFWtPAoZXJygPiloiwiYLHnAFe6fGTaBqrsVo+N
	IGCA5d6FFC5DSjRnCIJgmIiv6zHfoPIpUhv8zBbW4hOO7nEj2NuNGbw6CBDOcR0mnPyqj/y
	K2dMOk/Me3evuLKxYyj4CSjhQkAQhNI0YZrxKsJ6uJCaj2gHA8Qv50P1hJvRtnopHOGcrsI
	Vp0dwU9CPAG0qrSXYI0mAEtRdGOs90toD0ZY+GqYG7mnxMMR/XYIHrR/mEgVui2kw8D8jHi
	AF8aRuREqbsiMJb+zAk+1gU78NSrBAY4RtvnLvUIp1b48Co+6kcEvc8CeU5VT5G+QByyjEh
	X46gKDrOqd7rUjzNC2PYUwljm1NbbCmnM8PzKg1RkWiG8a6ieJkPcSV0FdGPhfIvK/r0N6F
	E4YYj9FrTBKy1L4Nw/zye35xUwcXrJn/mUbbDZLZvSn3Ke8jAONqiVD+hZo5Y/SPJkbNYpa
	o/3xs0dkXc0n6GTVNF6orP2ppZRoyu1PxXtSxTNv+zuySJ8L3WyfdtU7WPuuJ7bSbWUPaMx
	w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
[ Linxuan: perform an equivalent direct check without folio-based changes ]
Cc: stable@vger.kernel.org
Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
---

Some previous discussions can be found in the following links:
https://lore.kernel.org/stable/05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org/

---
 lib/buildid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 9fc46366597e..6249bd47fb0b 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/secretmem.h>
 
 #define BUILD_ID 3
 
@@ -157,6 +158,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
+#ifdef CONFIG_SECRETMEM
+       /* reject secretmem folios created with memfd_secret() */
+       if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
+               return -EFAULT;
+#endif
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
-- 
2.48.1


