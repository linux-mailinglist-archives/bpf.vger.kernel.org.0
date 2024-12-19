Return-Path: <bpf+bounces-47314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABAA9F7A1F
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 12:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A181893F1C
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 11:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3421223C73;
	Thu, 19 Dec 2024 11:15:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006C9222D68;
	Thu, 19 Dec 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734606922; cv=none; b=PW6Bt8q+0Ad8eL5R7CfgvhRWeGBj1iRExtakV9wNelD+ij/NJYXJwabOYzYsH30mV6lA0s/QGPMwajtIjtGG93DdAH9Ssyre7lvqNtg8MLSswouMvazKDSIkVIymf6jPXD7TRGltBNXuVUtdAhOGRpdqsZNJr4Ab0Bv6udKiSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734606922; c=relaxed/simple;
	bh=asSLnhYiYuZZ58CWQC4gADux1+mDbx7KlVHObe9F1K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eyPsLg+9EagWhstNlfCut9eSIz5bYemdzYVEhM/5lzoM/vXb/yR/28/JPK8oGNYytYlqj3djco0Q0UTSUT74VrvJyqFDVyvIqItr4vWfYRP6Z5l0cXRgTyGcoXNiA1hMVOYw1WWT+bcpJoCxRiUNBDMLm6WLDQN7c32vMXuLfOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxEK89AGRn+YdYAA--.3447S3;
	Thu, 19 Dec 2024 19:15:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxbcc7AGRndVQCAA--.14445S2;
	Thu, 19 Dec 2024 19:15:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] selftests/bpf: Use asm constraint "m" for LoongArch
Date: Thu, 19 Dec 2024 19:15:06 +0800
Message-ID: <20241219111506.20643-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxbcc7AGRndVQCAA--.14445S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr13urWxXw43tFW8GF13Jrc_yoW8Gr4kpw
	18C3s5tFW5KFWav3WxKFW3Wa1fJrs3WrWIyayvvry3CF4DJw18JrWxKF45Wasxu3yftrWr
	Aasaga4fua18JacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

Currently, LoongArch LLVM does not support the constraint "o" and no plan
to support it, it only supports the similar constraint "m", so change the
constraints from "nor" in the "else" case to arch-specific "nmr" to avoid
the build error such as "unexpected asm memory constraint" for LoongArch.

Cc: stable@vger.kernel.org
Fixes: 630301b0d59d ("selftests/bpf: Add basic USDT selftests")
Link: https://llvm.org/docs/LangRef.html#supported-constraint-code-list
Link: https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/LoongArch/LoongArchISelDAGToDAG.cpp#L172
Suggested-by: Weining Lu <luweining@loongson.cn>
Suggested-by: Li Chen <chenli@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/sdt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/bpf/sdt.h
index ca0162b4dc57..1fcfa5160231 100644
--- a/tools/testing/selftests/bpf/sdt.h
+++ b/tools/testing/selftests/bpf/sdt.h
@@ -102,6 +102,8 @@
 # define STAP_SDT_ARG_CONSTRAINT        nZr
 # elif defined __arm__
 # define STAP_SDT_ARG_CONSTRAINT        g
+# elif defined __loongarch__
+# define STAP_SDT_ARG_CONSTRAINT        nmr
 # else
 # define STAP_SDT_ARG_CONSTRAINT        nor
 # endif
-- 
2.42.0


