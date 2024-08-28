Return-Path: <bpf+bounces-38289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D352962C48
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 17:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDE61C23318
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562C1A257C;
	Wed, 28 Aug 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2UjRwHG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B7188CAF;
	Wed, 28 Aug 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858803; cv=none; b=IfRXL3M8j5mYqlBfj9ULPcuriQSfxFsYZ09BOUPm89ii3X97oV/YPO+dZqk08IPWSOyKVs1XUuX7arR4hh7oe8evTW53zAn+fSjEFTaqP2WqmR1PrM9pvbgEDQlyIVRVMCJRNFFYX+01Npj/4KHoZCdn1jCaYRi2kpG4MJRgS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858803; c=relaxed/simple;
	bh=DmkYH5XnAysMrBRQ+salZ18EYIwg9MP+HJDtm95iync=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHCEWQL6A647dDRiIGDlqZ6PAqHJXO6yuQ6j4uPVQUHjKbmLu8elvoZCDGk6MBjlCSnaJUGrj8uDkIsnfwoRtU7+7xEOesKTLG0bHAKAXGIF6AZgHYmaS/EV3BRfXMNHkMvLiKL+qR//UGxGLDLQas284NxZMWxM/PMnUIPfjWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2UjRwHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD005C4FF7D;
	Wed, 28 Aug 2024 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724858802;
	bh=DmkYH5XnAysMrBRQ+salZ18EYIwg9MP+HJDtm95iync=;
	h=From:To:Cc:Subject:Date:From;
	b=Q2UjRwHGJp3wMLjAwgbX3VVDYv5v6shV3g/2uieDebrsZ5l7d1/HckoInEICHgOgZ
	 QrXGBnUBgU9wDf1bfp0c8HgzGF+JnWTO4CgdUfXvfASNXmDfIa+zSrL4257Tl8wd6v
	 uuQOYKylqaGcrDERFCNa6UuraJbBfy7NF0G758+d0C/FuRLRqvRQSU0PT9lYCOBCBM
	 lwprNm0gTvQzCRTPFgtZFd/lpVh3jNnIuKCVl+uZVCnBMYVq0CQgDtMYPXEGbzkdJU
	 zG/Y5LVpUjcKybHQfSjlYirni5QstH6sHlRSnDH4P4ECHSijgWPFtDcIfc3Dqnwoxg
	 z0gzbBYmj91FQ==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v1] bpf: Add missing force_checksrc macro
Date: Wed, 28 Aug 2024 17:25:59 +0200
Message-ID: <20240828152559.4101550-1-legion@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the documentation, when building a kernel with the C=2
parameter, all source files should be checked. But this does not happen
for the kernel/bpf/ directory.

$ touch kernel/bpf/core.o
$ make C=2 CHECK=true kernel/bpf/core.o

Outputs:

  CHECK   scripts/mod/empty.c
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC      kernel/bpf/core.o

As can be seen the compilation is done, but CHECK is not executed. This
happens because kernel/bpf/Makefile has defined its own rule for
compilation and forgotten the macro that does the check.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 kernel/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 0291eef9ce92..f0ba6bf73bb6 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -58,3 +58,4 @@ vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
 
 $(obj)/%.o: %.c FORCE
 	$(call if_changed_rule,cc_o_c)
+	$(call cmd,force_checksrc)
-- 
2.46.0


