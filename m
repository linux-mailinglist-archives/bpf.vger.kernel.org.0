Return-Path: <bpf+bounces-31029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5625B8D644C
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BD91F276FA
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF9C1C680;
	Fri, 31 May 2024 14:19:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBC7FF;
	Fri, 31 May 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165142; cv=none; b=goRBYDHWb6TAVRwO6cxfZl0HOnv6QHKewkmg/hb+NWd0n4rtLWUscYVCO7zRvuE69zkn8Xj9YEcndYZfPzwQQ5y+lTFtlDnS+ro1+0aFPUc/yWi2iJQBZTFqBmVhtfzDTFh3n8dp/YrKm/igjT1HBnLB2s2DQpTRWj8o2Hauldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165142; c=relaxed/simple;
	bh=aF3eWbuN1JPyvYrTyC0cWHxZwRQ8WNZPKTCkF693fJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP95j1SgTF4d4qmiCPCFOjIR60XyMQ7c2ktFblrVYlRq17Vnaf1Z81yQX47CcLbnnW5dNi2zDfbevwvdZaWIHHmXTdklS4jBYA/Bu6D+MhlqRozRG1sk36mGlxTHa4nA487F1xaNwnugcIlUR6CTIrFn6oibTMqkmQmdaYSneAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 996692F2023F; Fri, 31 May 2024 14:18:52 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 37CFF2F20241;
	Fri, 31 May 2024 14:18:52 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kovalev@altlinux.org,
	dutyrok@altlinux.org,
	oficerovas@altlinux.org
Subject: [PATCH v2 5.15.y 2/2] bpf: Add explicit cast to 'void *' for __BPF_DISPATCHER_UPDATE()
Date: Fri, 31 May 2024 17:18:46 +0300
Message-Id: <20240531141846.50821-3-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240531141846.50821-1-kovalev@altlinux.org>
References: <20240531141846.50821-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit a679120edfcf3d63f066f53afd425d51b480e533 ]

When building with clang:

  kernel/bpf/dispatcher.c:126:33: error: pointer type mismatch ('void *' and 'unsigned int (*)(const void *, const struct bpf_insn *, bpf_func_t)' (aka 'unsigned int (*)(const void *, const struct bpf_insn *, unsigned int (*)(const void *, const struct bpf_insn *))')) [-Werror,-Wpointer-type-mismatch]
          __BPF_DISPATCHER_UPDATE(d, new ?: &bpf_dispatcher_nop_func);
                                     ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/bpf.h:1045:54: note: expanded from macro '__BPF_DISPATCHER_UPDATE'
          __static_call_update((_d)->sc_key, (_d)->sc_tramp, (_new))
                                                              ^~~~
  1 error generated.

The warning is pointing out that the type of new ('void *') and
&bpf_dispatcher_nop_func are not compatible, which could have side
effects coming out of a conditional operator due to promotion rules.

Add the explicit cast to 'void *' to make it clear that this is
expected, as __BPF_DISPATCHER_UPDATE() expands to a call to
__static_call_update(), which expects a 'void *' as its final argument.

Fixes: c86df29d11df ("bpf: Convert BPF_DISPATCHER to use static_call() (not ftrace)")
Link: https://github.com/ClangBuiltLinux/linux/issues/1755
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/r/20221107170711.42409-1-nathan@kernel.org
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 kernel/bpf/dispatcher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index 23042cfb5e809..9959201efc316 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -117,7 +117,7 @@ static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
 			return;
 	}
 
-	__BPF_DISPATCHER_UPDATE(d, new ?: &bpf_dispatcher_nop_func);
+	__BPF_DISPATCHER_UPDATE(d, new ?: (void *)&bpf_dispatcher_nop_func);
 
 	if (new)
 		d->image_off = noff;
-- 
2.33.8


