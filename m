Return-Path: <bpf+bounces-60802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7395ADC265
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 08:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443001895B52
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 06:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525A5273D8A;
	Tue, 17 Jun 2025 06:32:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CBC27461;
	Tue, 17 Jun 2025 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141951; cv=none; b=qz2+61QcTYeVmJFUVcNwz9X84qfZNGDFN9FvexQJoMP40oNNuHbS6mHxrIyrjdBFnA6IRxAi3n6wNLfQ4BHjuQip+fE4SSjnCT0W6kA5ZDFLcNS3g0zd7DCCReFek8cjIP7OuOEcxvzChmIgU3g6YuBZcyxuK7C2mJVC+DBGHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141951; c=relaxed/simple;
	bh=MQwvrsyatOU2v9XdcxbXbe/0dPzrutKdVRXMXMclAwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVCfmvLiYbBTYSbqzOrvmCma39xKfshj2CYK+zOrYSeHR+3pDOXKvoBvja4zdGTSynkp7tibyj32PjD0bB9i+TqZLi2N6qCPy48qxOUZSW4inP+yLyf2dCMo8BBoTIGIHpCk8cTfBLHjNbJn6Nm9JUvmHEub0QqplUlIp0Dctcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axz3PyC1FoljUYAQ--.55626S3;
	Tue, 17 Jun 2025 14:32:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDx_MTnC1FoNwIeAQ--.23222S2;
	Tue, 17 Jun 2025 14:32:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] LoongArch, bpf: Set bpf_jit_bypass_spec_v1/v4()
Date: Tue, 17 Jun 2025 14:32:06 +0800
Message-ID: <20250617063206.24733-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_MTnC1FoNwIeAQ--.23222S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrKF4kCrW8ury7AF1DtFWkGrX_yoW8JF17pr
	W2kFnxArs8Xwn7JF43tayrZFW5JF1kGFy7WF129a4Fk3ZxX3WxXr1xK3s8GF4Yyr15XFy8
	Wr95C34a9FykAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

JITs can set bpf_jit_bypass_spec_v1/v4() if they want the verifier
to skip analysis/patching for the respective vulnerability, it is
safe to set both bpf_jit_bypass_spec_v1/v4(), because there is no
speculation barrier instruction for LoongArch.

Suggested-by: Luis Gerhorst <luis.gerhorst@fau.de>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

This is based on the latest bpf-next tree which contains the
prototype and caller for bpf_jit_bypass_spec_v1/v4().

By the way, it needs to update bpf-next tree before building
on LoongArch:

[Build Error Report] Implicit Function declaration for bpf-next tree
https://lore.kernel.org/bpf/d602ae87-8bed-1633-d5b6-41c5bd8bbcdc@loongson.cn/

 arch/loongarch/net/bpf_jit.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index fa1500d4aa3e..5de8f4c44700 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1359,3 +1359,13 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return true;
 }
+
+bool bpf_jit_bypass_spec_v1(void)
+{
+	return true;
+}
+
+bool bpf_jit_bypass_spec_v4(void)
+{
+	return true;
+}
-- 
2.42.0


