Return-Path: <bpf+bounces-54020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F180A6093D
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 07:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B563517E296
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE3155743;
	Fri, 14 Mar 2025 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="BveosaYA"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C378F4E;
	Fri, 14 Mar 2025 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741934442; cv=none; b=GnCreiPvJ6r9W5msrwbb7DjZZClRLXvDJJtAG5g/gL1GC2gVmRXF6sWuR1osclXfJa/QOvPUSRXw/IU5oolKr0o4e0We/eKabu2h70gFgZeni64ig41x8ymzHXrJSr8WMtpv+wTImcf3AS8WzmYKojQgxBLQ86IvDWkMIhXNEbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741934442; c=relaxed/simple;
	bh=1/P245BJsOOizxZd8xVholcTcwS3i4f6zEkYxyH+TzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aI4IXl6wIlZJCQEQlXlJVuMq2bZxFDSBTu2t9tptBeWgSrZuUHGr2Z8lKNCYJQO/ivrGqxY5Y5Fq+og109IgCHAYLA1TGGwWrx7rycEagAaKDQyDDO8lP4+iOyuqVaQFDWpXNvYRUbIUQiH6cXuN/Swb2fs1AnRKRvU/ShvY4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=BveosaYA; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741934406;
	bh=CwPqh3dkCrhZ/eHvLeAux7HyOEkcWfxttE3ma/av6pE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=BveosaYANXwcwLdtoWX9NBvCpprYGtn8Vfs20Rxpjd+FOMKkH168Z6VlcV8id1kzb
	 28YXhg83J13YwMLZanSEUqM0HwOUYYflbQMeTXxEINzhDhlKWktBJ+tOZCvgHkQC0E
	 Ixc0rmBLfkmOSBSiPgdyKhwIGCzO5D4YBaSXJb+o=
X-QQ-mid: bizesmtpsz10t1741934404t26o9y
X-QQ-Originating-IP: 6Fr0MgwcHkdky+mdy7jdVuBXvxbbn5kRhnpDYS15j4Y=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Mar 2025 14:40:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17251125290504518748
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 5.15] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Fri, 14 Mar 2025 14:37:20 +0800
Message-ID: <2BB12F289DA93614+20250314063720.20463-2-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: NulC8gp9xT8siKGavyBmRLtpa2lNONBL4Z2xMreGsZPpuoHR7OqVDLgA
	+ABrcnLe7POSeHiOE/obf3HTXfMz24Z7z7F2l0VAbtLfZoA4q2lO/abMbzucwxHCchTPTLa
	NNXGo9LeMVNL2eiu16xgqVL9bpfUIcSerg7kYz4yAJiHpUeiedRQBtfFyBsH4GmEAxQE0+z
	uC7LwIIJ3oEDDZw8A+HtiEec3SPyzod4yN5uLWuwuprR5aCPCki9eZkefigTrJhKbqX1TRe
	LH5+xRXzd+h65fTeW7RfT5FzUPkDymz39YaRlwwOcKcx8Z6M+FtLO+yZ9hKKDLH/dC3tZ3M
	Ow13A8ZeccnAt5nt/QdcOhCETz+R+uwbFsaFn5fKGOiAi+1w9VVZd+hCzmPhF99le8oefq5
	8rNabpfAA0ry0Z0qiUCgRXnQyPwT38E+zv6S0o4E83ojSnAMgq1CYWjAl1Jzd3WrPCXNqw2
	FHcMNO0rcrLRZOFU0RixkEZ2ybACTOkpZmfDU0cMhiK6uanWlAZ3OfE9jpwVVxbVf0/tENZ
	NJv//quDd6+elbf25/rwJZIWBg2WsRXiCUf3EtrVUKUQPgqDvcucQKMrMQWejdvXgqyv8L3
	Ei7bsmY9h5IlL+EgU747rx7AE8SPlWiWeTE8/UxWwwOIonNurwbCtdzFnXfKf4LIEA970Ws
	fS2/qXpVyNGRHpHyeYNkMdNTcDcf8Oaz3IPuEAVHuI9pLacJU7Mfr4iyalIDI3u6K5HT86w
	qL9yC1pGV2wLWB6p1kCVLyfPIhaMl8V8CCzQHNiNhveymdqA95BAQMDanMHMOg17PXPj3OY
	p6qMCRMuHWbeboLKS13zfsnejYUTY6MF4AXhhzDophbBbvu/kE/u6Zx5Tpmg8rjjtfpk11R
	JrE2bkDRJy2j+aMseFeToi/YrGWhzXiOl/8tvnN3pm7ytmqUQMlrQVs+MT4eARS/9xqK7Tu
	9I/fugj8sBg04mjK4S4AZXXN5zfmuYWv4xjtkyR4N3FmLCQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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


