Return-Path: <bpf+bounces-71444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1FBF3766
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA9E426B95
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F052DCF5D;
	Mon, 20 Oct 2025 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuIL82Kx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C42D8767
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992605; cv=none; b=RnfD7Kb2HMlAoPxvyXcIH+oaxVPWpGwNGgLv2vg2mNfZUH44cn9QwiQu4RBpMGELs9DuEicGjm7qqvb7ZVuJmYWyKhlP4XuNZSdNxfnrQQjXUgcLhOHz3ogBbaeTUvQ0PdqBR30V2dOnh9op3I+5kySJoCUoKW/OSD9WEqiB40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992605; c=relaxed/simple;
	bh=Ej+2tSmJDubQAsT+t/IOK/xYRqi6kJM4nRu5TKKhmTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCJGttiScJXdOzT/mkb1g8xlGjafxkWnoIl89JmH6XbIKlIh/O77BuZkkN/PL5Z5oTQfXbXWJpTV9djq2zCWib1wPacG3OlTstBzmif1HHtQqMyBCkRT1PA3HoqsXNje3wRzs+rg+CTWRlZ69nrz10R1SM9JiKfEW/c1nvrw/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuIL82Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1639BC113D0;
	Mon, 20 Oct 2025 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760992605;
	bh=Ej+2tSmJDubQAsT+t/IOK/xYRqi6kJM4nRu5TKKhmTo=;
	h=From:To:Cc:Subject:Date:From;
	b=BuIL82KxIUKC+2T1aqxws5CrTgK2sfl6yvg2T6zFnDydGwZt71tT3M93+4D+xEse7
	 G4OZg2WDjegCIm8gCs2Yf8MfngN2hlfHreye2BnXPmKR9JF3DEtlxRkJ4iKhD8iJP8
	 fH/iVHmI+mNYQ2hs4x+ZwXVZnqmruEorNZb5SUZVMGxe8A6UW66GsJhsNHkdhWaSHl
	 cPFibytmm/nNx/hXjsqhx5jhLQY7nRSM251zrpHKcli0cuVhHj+Bm+HUiwDvV82EU8
	 dRROhjiiBim7Kxl3ETxhDwS/cY9MzaXpYXkwaGSDiRrOO7lSVJ86zd2SHbUYeSEYFJ
	 Af4kvSNS73/gA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Naveen N Rao <naveen@kernel.org>
Subject: [PATCH bpf-next] libbpf: fix powerpc's stack register definition in bpf_tracing.h
Date: Mon, 20 Oct 2025 13:36:43 -0700
Message-ID: <20251020203643.989467-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

retsnoop's build on powerpc (ppc64le) architecture ([0]) failed due to
wrong definition of PT_REGS_SP() macro. Looking at powerpc's
implementation of stack unwinding in perf_callchain_user_64() clearly
shows that stack pointer register is gpr[1].

Fix libbpf's definition of __PT_SP_REG for powerpc to fix all this.

  [0] https://kojipkgs.fedoraproject.org/work/tasks/1544/137921544/build.log

Fixes: 138d6153a139 ("samples/bpf: Enable powerpc support")
Cc: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index a8f6cd4841b0..dbe32a5d02cd 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -311,7 +311,7 @@ struct pt_regs___arm64 {
 #define __PT_RET_REG regs[31]
 #define __PT_FP_REG __unsupported__
 #define __PT_RC_REG gpr[3]
-#define __PT_SP_REG sp
+#define __PT_SP_REG gpr[1]
 #define __PT_IP_REG nip
 
 #elif defined(bpf_target_sparc)
-- 
2.47.3


