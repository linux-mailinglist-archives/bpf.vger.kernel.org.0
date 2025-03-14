Return-Path: <bpf+bounces-54022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D7EA60941
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 07:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E183BD5BE
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 06:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA7156C71;
	Fri, 14 Mar 2025 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="wD+6YXX7"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A6146013;
	Fri, 14 Mar 2025 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741934491; cv=none; b=T4dIRQt5q3qJw4+7kaeq67VVgwvsRobZ7twzgczTQYD8ngDg4wa/x98E5rI6q5Ra2vUTczBrdnTeOlDzt4/Wv2vfsumQhCoinEWcoEDPqAFaT1NzHEyDqVuBBcJ686MQ/qPXnaY8iKfatREkvFth6xfx2XzqbPbvN/VVXcMXp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741934491; c=relaxed/simple;
	bh=1/P245BJsOOizxZd8xVholcTcwS3i4f6zEkYxyH+TzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbROh+vPD2FfQ3+uJoXwITu53XK6OktkHbpLZpYNvQBrfNJcW33IMorw/oowEakxCRXlj+voVFxVm8GnePOQq2a41IdsOFz/RszH7YbUZ/P8x6bnsV5VHz0vInkSG+Jp51fne6JEATmlAC65eeuxshWCUtxawHIAfbcw9hRQRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=wD+6YXX7; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741934465;
	bh=CwPqh3dkCrhZ/eHvLeAux7HyOEkcWfxttE3ma/av6pE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=wD+6YXX7YdG+fvv/KGoBB6YzZD6YFxXfwFfUmJ2tdDZUo93aDPk/BX2i69UUa1YL3
	 GFgq4Lyvq4kyqQ/AgqG8kEoJ8cay1KI8sdTW2h0kK/lYw3QcjiBqthVUw4yR5yuPGE
	 l3Ed/u84DZt0qKIrtnnGDQ+l6SzL/f2pP47g07uo=
X-QQ-mid: bizesmtpsz8t1741934459tbxpkb7
X-QQ-Originating-IP: UOH9Xc39gfe0mWHbIm7GwmW4y+2iq8iLjz9sepqAV3o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Mar 2025 14:40:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14611272108540318868
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jann Horn <jannh@google.com>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Yi Lai <yi1.lai@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.6] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Fri, 14 Mar 2025 14:40:39 +0800
Message-ID: <6F04B7A95D1A4D64+20250314064039.21110-2-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: MuqR/Ma/tDRlUbbSIQI2U6KgUnFY+5v+uELPQoIE622gmDZ9SLqJOeYN
	M3YxXwMh4uSszRuQ7W6PRA1pQmRhuCxHQNsMrXnW8l9zhI0IDrGsM6jTjdGLMmRky0BbWlO
	uOvttIScfURId1RDAhjbTySX9Rj9d286Djb85ckl5D99jHp+9NLmy3IzwfPR2eZmnq/LVT0
	bi4MhJ8k19G1/Momb3thXW7gu1iG0hLRgKO+xv8U5rJ/XF4yl+YvKCxgKozW3tpSEopvR2U
	hvSvSyMwS4YdPsqMW8pGqehFBpBAosNovWyd4c9JeB2A5PZX78gYg4NQs4JwgVZefR+fv0P
	b5bVxx4Gd1RF8OZfIbgQYvkwuGVSzHMRKRdJnWTjbRb7xVoOqgNBPngv1DHpL0nAkspMuIE
	bkCTpZEC36+GyXONgTHpFJNDUUkATsYWWYPgDxBP9PeTMhESFGcH+atmB7RnImqgPgD/Ggy
	/noL9pSdsUAG4Uj2kbXFGOgAc65TD6ZkRal3gmm3HJjLRyGpevI+ZebiUMoD9Ww+FZBci0S
	vBRGKO6Al3I21lwwDx24xeSVQfBkqMxEvJjAWwdJNONrlULlY20NiQJE2uU2pO/dLys5X6y
	U05MHzMq+HW52/ptOyOqV/IGkLaGq/Kz+m7f/ULFDKfZzg6AAgYBtq7F8ttGs5IYZ2k4YnB
	lxj6TDCADYW15vHK6Ld6Tzoe7bWstB/OvdjWoLrmii75tCjz4dleSDxajWN7zt2sNx0yh6b
	yfbRf/eDT6eP7iTieU7SL9v9u/9bHk6UoEu/pApzmN6U4Z2qm9duVrQrDu1C1+NZrOqrc3t
	delCmdFtcfNZYSM/KbYnSZiE2waMlbJtXqDA76qz9kWICFVDd/JZMr9RACtChdB7E8hzjNd
	MOJmJAUPj99TZM4f3LDm6qqAqKBGnURNC7Ux9Dq13Ur+i0XXqHvc/JPmHV7YH6o/eo2m6LQ
	sy0FAsKtBdBZW5ZQ2jLaAfVUZNV7K6kldH0KIZQYGq+La/kxfEjhh+7g8dh6XIcHYLFh199
	iZXTQVo7lVcOyLv2w6DMwjBZ42Q/7OQqgNXByIYNpG74tKuEVpZmNGr9YWmdsjRDCnbzOJ4
	V57V0ga1DwX
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


