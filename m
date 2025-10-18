Return-Path: <bpf+bounces-71275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC43BEC9E9
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 10:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E295619A5369
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899B228A72B;
	Sat, 18 Oct 2025 08:28:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDD91F418D;
	Sat, 18 Oct 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760776107; cv=none; b=LRW4V5d35ggG67Mzy3zuNYb6ban8INM7kN11hO+PEbnm1CYyRLJDrc5QqYf4X2ITKQMbK+7K3IsSk1EPGMh6C75Rah/xSFlr52xr06fmk2xqZT1oWkns5VOIwsQv0l6snnR0cq4/mHVmZU9/EBKdeQWocq87dXoqyG9tQJgZlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760776107; c=relaxed/simple;
	bh=G+w33CURobdsrVCx32sB35QIpXZKy5qGGsojw7FPWiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QWlstqDxf2fyY/7kibQnWU4U4SRBbYeRrCud+Coo2kFWjy752WLLUzsW/mZJHz0aVypfGm1AmU/PDLM5LBK6esqmcHMBgjQAdnsbFnJUpxz84YLwycccQB3fkaL8J2+K1ua3fUJLXSbbt/dIKkVLiww8l4hIjSn+46v9sGB8Eus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxfb+hT_NokaMXAA--.49100S3;
	Sat, 18 Oct 2025 16:28:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxfcGgT_NorKPxAA--.18841S2;
	Sat, 18 Oct 2025 16:28:16 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] selftests/bpf: Fix set but not used build errors
Date: Sat, 18 Oct 2025 16:28:15 +0800
Message-ID: <20251018082815.20622-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxfcGgT_NorKPxAA--.18841S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur15KF1DKF1xGw4kKr1ruFX_yoW8uFyfp3
	48J3Z5t3yIqF4UJ3WkGrZFqF1rC3ykZ3yFg3W8J3ZxWw1DJ3Z3ur1IgFW5WF9rurWYvan3
	A3yxWr95Ww18ArgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jjwZcUUUUU=

There are some set but not used build errors when compiling bpf selftests
with the latest upstream mainline GCC, at the beginning add the attribute
__maybe_unused for the variables, but it is better to just add the option
-Wno-unused-but-set-variable to CFLAGS in Makefile to disable the errors
instead of hacking the tests.

  tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c:229:36:
  error: variable ‘n_matches_after_delete’ set but not used [-Werror=unused-but-set-variable=]

  tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c:229:25:
  error: variable ‘n_matches’ set but not used [-Werror=unused-but-set-variable=]

  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c:426:22:
  error: variable ‘j’ set but not used [-Werror=unused-but-set-variable=]

  tools/testing/selftests/bpf/prog_tests/find_vma.c:52:22:
  error: variable ‘j’ set but not used [-Werror=unused-but-set-variable=]

  tools/testing/selftests/bpf/prog_tests/perf_branches.c:67:22:
  error: variable ‘j’ set but not used [-Werror=unused-but-set-variable=]

  tools/testing/selftests/bpf/prog_tests/perf_link.c:15:22:
  error: variable ‘j’ set but not used [-Werror=unused-but-set-variable=]

Cc: stable@vger.kernel.org
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f00587d4ede6..7437c325179e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -46,6 +46,7 @@ endif
 
 CFLAGS += -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
 	  -Wall -Werror -fno-omit-frame-pointer				\
+	  -Wno-unused-but-set-variable					\
 	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)
-- 
2.42.0


