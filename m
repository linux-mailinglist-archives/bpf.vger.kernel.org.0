Return-Path: <bpf+bounces-54163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4218EA63F92
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 06:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4377A6CAB
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 05:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60403218ACC;
	Mon, 17 Mar 2025 05:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="oWKgYCLB"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361B921504D;
	Mon, 17 Mar 2025 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742189022; cv=none; b=kwvUp0zZe+eZOLh5ooJzhxS61mQigLhkR4o1u8qItjLDUBY5Zbb2VHfIuJeHNy5wm8n27MRTtAs9qL0xTRtHqnOZIwR3oaY9rlZzBnlMtif3WRP1gmkkXV8Nn+GaUcfR8BLU9st+PyaUSvR5dxK0Y5sjn1xp6HF98hi6m0Q7dTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742189022; c=relaxed/simple;
	bh=UW2ueA2Qb2x942vo6/I7KZcgWikDZcH9qzJDqMyqTXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfLEzK7nm2UxD4CKrTvthlTE8HYuJDgjsj/gsQrP97CYhH4M3CROG1n2y0rzTgoprcz+BK4pXVEtL4zvGAdHd0AjyCu0QYADF+HkACzuJxSLUz4RmFXx1MC4ist+Y5AU/oDPZVC8AViR8tD1HoG3bLQsoEDiIAXPNGfboWsj+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=oWKgYCLB; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1742189002;
	bh=5VoWo9+kTVRGehYZZb0Zl0JIHZwjW6msh7h7oa+43/k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oWKgYCLBRd5WPlmrn6lzmhALHBd0rrKeez8wsZRdZAXeyK8E6tG0Pm4ty/IlFUdm+
	 ej2zXNX90F/F5MGDoG3DQ2K6jWtF1l1NMcINRQ13yHllCiUPowmCFb3tD+2Bqsdcrc
	 Z2c4pwl6wp+SrZcP038wMGQPeOk7rrT5m3AghEzo=
X-QQ-mid: bizesmtp82t1742188997teamk9yo
X-QQ-Originating-IP: NboFYFbRDyGoS/2KsXU2lOc66XQ/Sjax/bUSvxoq3ek=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 13:23:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11030206044243856192
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.1 v3] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 13:23:00 +0800
Message-ID: <84211070D1A421C2+20250317052300.24146-2-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: NxBUFebUJrFW3DKDQyEASEWIBYFvybHfwpdxwDeE4D1hHdzDVaJAZcjP
	gsqbQ02sn+DZ3rvThgXUcwwbfup6rbXgP8QqSa1l9Vvqeu6s8xm6vJ7HYFWjogkWZjguq14
	TtA0ShMqhuFZ2rIM30FQzET67yh4pYyMv0s9w4srz2MET1Tx7F4CLDN7GNxuAIM76BMK/CA
	hQmpEllaA+epbuXUdMiMuYS4QpsrkC1R3hf4qz1qXtJnW63Vc+COGaAmBqVeGDzIYYu3T+U
	ApNBtbah6eUIJZHP/FfuX07tLsMPva/Ad1/Hs/3fxbR9ya/jk+lE9wxOTkF4OQzq4HxKy64
	pkm8mSI+7K+q0Xjz+jdoXrLjnoYmyIGjaRgKx+1Z69UH0bnK0978tUEqA1CqO/d3DOdAgPU
	X6ixZTGTOZqwWUUvqGsVlnys94/pUviqN8U94t02ZKczlGP/k6dgdZsCXeyltXZiJKZFLi+
	uu1HgDchSNnZMfO2nR84BSZzIs7Ybm3KmnGz9NdesKI972k5dgAqAefmjUGIDp+R2SNWVSW
	a5eJRONpKv6GGkiGqAwXU8YFbWmg5bSCBiDWNvQ+eWXVhctrqlcbZ8kb03iuELAExB/EGz2
	WKvONaLyoxkRQcAXTU0l7YQsIo7yh0/QQ9CjJb1gp8n1IptjYZijqWcV4ADM8JQ78u0VlT0
	tbDyknHk0/kQ4EcwfKoNGtNkFtt1+wYjrVPO+nz5GatsOZErUp0HpJGZJAvhE3kemxDnOKz
	kF0L3W1lA6MDW/MF7Zlh+kOIKSQ3YHkoJGIL2QbfZaTMWhU2utNligIx0Kzx/gCD6eNs6pS
	cYigRXN8wABaDVMBBV4DjaDOJcIe8dYMyEbWXAOcNUAB/ptHm8Mt2sveDrziazE0gS+S3AE
	NN9yADC4uQIuJbuQ3TCX2dhjQMTIeKKPYyUFDaCb8HCB6Dl6jFsIoKGzVKbSyxQdRBK+e1m
	ofROyF2tkaA9vZVwibr6gsy/RHSsbIf/G4HEvIsOSBijfsKt+CSvN68XhuLuAwfSA+9XaVE
	HEGEUCXxG321Pg5rCoGyC/CxGEZ0qq9mp+1XL7N6p2Nz0eLDkcBsE6/7QxRxZ9KTXsCBeFr
	A2rt1xtl7zesoKjsCPEpwk=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
v2 -> v3: keep original comment
---
 lib/buildid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 9fc46366597e..8d839ff5548e 100644
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
 
+	/* reject secretmem folios created with memfd_secret() */
+	if (vma_is_secretmem(vma))
+		return -EFAULT;
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
-- 
2.48.1


