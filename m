Return-Path: <bpf+bounces-20364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E4783D247
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 02:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939DC1F237DB
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 01:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74AE17E9;
	Fri, 26 Jan 2024 01:57:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD97465;
	Fri, 26 Jan 2024 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234263; cv=none; b=EKgxPr0udM3SKj9B2gKUPjG/5aCjM1/PFnLyLQDbkLssIostBO1Cc6VJiijLb3DIOtMO2Emhol9ndk2iAGhdRB42L75b/rz4nLwmZQxNtm6f+95gba9JVlrWSI+9SgZOR4C9rbZ5HIMk6bS99K3HPbNZ9Q6dr+nohQNxACFCfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234263; c=relaxed/simple;
	bh=Kmv8fXT+ceGw1a/teVdtWWsldtyTOBYKD9GjXax13NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFrkD2R6k60nHQmxxVeH/DOyJyuXPAyIORkdrHxi7v6Bi+XrbOOPKLKGMrz+s15MHU7WDsEDJGHs225TthuuLpWZsNW/2ZaZ2wKa+0krG6BajFPl0GpUMVCilfMpk1S4+5iYNZKCuVXLXtkp3Nkawb16IBA5Y0KEZ2zl7w7N87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxnuuSEbNloQQGAA--.21344S3;
	Fri, 26 Jan 2024 09:57:38 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPs+REbNlH+MaAA--.51310S2;
	Fri, 26 Jan 2024 09:57:37 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Add missing line break in test_verifier
Date: Fri, 26 Jan 2024 09:57:36 +0800
Message-ID: <20240126015736.655-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxPs+REbNlH+MaAA--.51310S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFyrXFykJF1kAFWfZF4rCrX_yoW8XFWUpr
	48Wr4vkF1DXa4I9FnrCw47ZFWFya1vq3y8tFyru34DAFn8Zw47Xrn7G345ZF9xtFWFv3Wf
	Z3yxKr1ru3W8XFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVWUJVW8JwAv7VC0I7IYx2IY
	67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjc
	xG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF
	0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U875r7UUUUU==

There are no break lines in the test log for test_verifier #106 ~ #111
if jit is disabled, add the missing line break at the end of printf()
to fix it.

Without this patch:

  [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
  [root@linux bpf]# ./test_verifier 106
  #106/p inline simple bpf_loop call SKIP (requires BPF JIT)Summary: 0 PASSED, 1 SKIPPED, 0 FAILED

With this patch:

  [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
  [root@linux bpf]# ./test_verifier 106
  #106/p inline simple bpf_loop call SKIP (requires BPF JIT)
  Summary: 0 PASSED, 1 SKIPPED, 0 FAILED

Fixes: 0b50478fd877 ("selftests/bpf: Skip callback tests if jit is disabled in test_verifier")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

I am not sure whether the Fixes tag is necessary, you can remove it
if it is useless, thank you.

 tools/testing/selftests/bpf/test_verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index e1a1dfe8d7fa..df04bda1c927 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1527,7 +1527,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	int i, err;
 
 	if ((test->flags & F_NEEDS_JIT_ENABLED) && jit_disabled) {
-		printf("SKIP (requires BPF JIT)");
+		printf("SKIP (requires BPF JIT)\n");
 		skips++;
 		sched_yield();
 		return;
-- 
2.42.0


