Return-Path: <bpf+bounces-54021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8BDA6093F
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 07:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AD61897316
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB360156C79;
	Fri, 14 Mar 2025 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="ygBjTxqh"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637E78F4E;
	Fri, 14 Mar 2025 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741934452; cv=none; b=eWif0nqnUlW5/LJwkhYix3+Ppa/WWwhliDrpzcNUD8mn+2BETJpaoBVzL9JekgyGUHFId7Mw9pz+Qy0qpmi/8oJgxBAH7k1gxt6JI7dY8nOMj3Hb/wP3IJYHkA5+SIahnd6xz+PaBTO+/5qV6PHnDDsOsJwkct+KbA+ZWgyrPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741934452; c=relaxed/simple;
	bh=1/P245BJsOOizxZd8xVholcTcwS3i4f6zEkYxyH+TzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1XmEBGxfzJ8SrvlQkqaGEKyR7yaTFbGMly/FYi5UuEomhoPxruXALToS7psdp0l+IwHInXoTqty5+dAPXxy8exQxrdWLdOG/SKmq/oLYmLhNeABOLq09soLwffJxe4MUmLx1GbejlYxqIiZnH6OsSKUfWivKQv/yPQnM4igLEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=ygBjTxqh; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741934435;
	bh=CwPqh3dkCrhZ/eHvLeAux7HyOEkcWfxttE3ma/av6pE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ygBjTxqhV7SSUDru9u1MzyXpFmH35dvBh19biWjd5i5JOJrw3xO6nVDHiAoYuOT/E
	 oCxLNyLlrEooEP37HTeg8+vcU2D6JfaxFla5nixCy8p7/+a0gbIppFgE6bJ2aCzoH2
	 SDhQlWJb9+239BpBREL1SWCpbiQqe1Gm3bvG16g8=
X-QQ-mid: bizesmtpsz4t1741934433t0mk8d1
X-QQ-Originating-IP: JFoJuAy/Sh8Xwtg3iarI2liwPQ2wX2lew8yCiTQnoKc=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Mar 2025 14:40:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18429496349673007941
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.1] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Fri, 14 Mar 2025 14:40:12 +0800
Message-ID: <07E50D508253C123+20250314064012.20951-2-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: MrCQuGXFssgk07nHilX1OC02btZqIuKjUIXiPumvMT6wQpnvVnh670ic
	UAF+dzvzXpg3toeHyKUaErrY+kBsnbXzDmXgRmOye/VAeerK1dyOiHAY+vGoaPj/K6hLn2z
	vnT3HWysjg5eUlALaEe5UZXpTGu6SOsRJBC/VI9Fs3MY4JAJwbUd5bw0tGIGg+mhaFm9LX2
	MX2DYN0BK+yzpzQhL7yKGNEIREBbe7AcIfIr57hOjNAEh8trdBhcOj78SiLUnue5blnMZa2
	JNyRm9yzEpNssmCNJHCQaTZ4+LTY3+pzFgVr9n0yOtkz5Qb+qBT1+LXV5Q/3BcoPiA48rlL
	0XkaYligwz5MF/10jRrQLQCGLOad/5SKSDoum/6Q9/6DisaLovE2jJLJl7hqW6I4nabWpZQ
	JWPHosY67ryNtgTH4cFJU3KeEmwKYhlUH8K8lBMTDyZtwa5HeOABCV2mWQs1/Vd9kPy13Cu
	nASyjKFp94DSOg7UsZz1d6MmCGyRRmlYrqe3U2nrrun46tnak7OCcg8qR1ZjellvECXcheP
	fbbu6KqM0h2ICWDP+ToHHZsINOoYhwv33vIesduoxcwgNfEL1DSqVFdpptElAJh4bDI5vwg
	M2zVh44lnEisyQZz+3bxp0RB6XkMDsN0D94pwMlCRkBmPL/BydIJH+bs9/tC1nZc7HxOeqS
	MnZt3TU6xzSVpGfvOsJkLjJ/ZThAH7zYf2akSmwjcKNKS+LHupRrnmKeRYsGdFv7GypJ5Kq
	v8hX4ypTIaURCay7YXIds0fIMS2CZQgCU4EuZe+23JKf+v8mNyUJeCjaixTDh5sq99sdaYm
	6+/7AdXTTwdXpmlkrhFNKx2ezBbgCdYY7Jb9Y2nHXKGqaMoroG2Ozqnm0ca+eBdJQO5P39y
	NYmcH+q1hjG4V+tJzHY80PA1HYCwe+WAdZZkewybwmPllAzRzgYZs50mI8q2XpRMLIchMgz
	j9q5hgd/lhPysZTvIXtyi3PDsFNwJvGnVwoDx2AQz6KmA7VfP8IKqM+IIzOBuPDqDY5w=
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


