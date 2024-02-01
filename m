Return-Path: <bpf+bounces-20930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE538452C8
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 09:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C0128AEB5
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E60515B0E3;
	Thu,  1 Feb 2024 08:33:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2195FEE0;
	Thu,  1 Feb 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776387; cv=none; b=Q9NMeae+nOFUtVGEWjAkLOfPnTrQCD21kvWipRww/pGVxF/U5fgv0PcL/YW6YNpSmQ3xCM045FcFNpJ3zNfGxQ5e7rBWgjrhudyR+u85CPuJ/8M9tQ21m2B0GiUbjSs3cFhdfJGgx/Ts60lDWVEcrekLLKOvQQP5w0P1OFwUfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776387; c=relaxed/simple;
	bh=oqIuwDqNdMvwX1a3rGy4OU174/ZwuKHgR2gSBHuWnCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NPtAk7tKAb8c1AEimt05zu56x1AvJJKkMuhVAoIkWeOCNuFFYGS/mZ1qjN48sFcgrOggnw/vkgSkw9vxa9YmLlnutDTTKMHfoGv0o+D2bP53uX36qHSf7WBG3xMTBRixRhr5lRqn+aoBgWB+VfW4cQBe/Lwm33gwA6FU4/83KSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TQXGd6yQ7z4f3jZ0;
	Thu,  1 Feb 2024 16:32:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8B1781A027B;
	Thu,  1 Feb 2024 16:33:00 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgA3PnA8V7tlRXylCg--.9426S2;
	Thu, 01 Feb 2024 16:33:00 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v3 0/4] Mixing bpf2bpf and tailcalls for RV64
Date: Thu,  1 Feb 2024 08:33:47 +0000
Message-Id: <20240201083351.943121-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3PnA8V7tlRXylCg--.9426S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr48AFWUJrWkGw4xXw47urg_yoW8AryDpa
	y3ur13Gr4vqryxCw42ya18Ja4rGF4fZ3W3Cr13tw1Fya1UCFyqgF1xGFWFqFyUZFZa934j
	vr4YqFs8CayUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1
	22NtUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

In the current RV64 JIT, if we just don't initialize the TCC in subprog,
the TCC can be propagated from the parent process to the subprocess, but
the TCC of the parent process cannot be restored when the subprocess
exits. Since the RV64 TCC is initialized before saving the callee saved
registers into the stack, we cannot use the callee saved register to
pass the TCC, otherwise the original value of the callee saved register
will be destroyed. So we implemented mixing bpf2bpf and tailcalls
similar to x86_64, i.e. using a non-callee saved register to transfer
the TCC between functions, and saving that register to the stack to
protect the TCC value. At the same time, we also consider the scenario
of mixing trampoline.

In addition, some code cleans are also attached to this patchset.

Tests test_bpf.ko and test_verifier have passed, as well as the relative
testcases of test_progs*.

v3:
- Remove duplicate RV_REG_TCC load in epiloguei. (Björn Töpel)

v2: https://lore.kernel.org/bpf/20240130040958.230673-1-pulehui@huaweicloud.com
- Fix emit restore RV_REG_TCC double times when `flags & BPF_TRAMP_F_CALL_ORIG`
- Use bpf_is_subprog helper

v1: https://lore.kernel.org/bpf/20230919035711.3297256-1-pulehui@huaweicloud.com

Pu Lehui (4):
  riscv, bpf: Remove redundant ctx->offset initialization
  riscv, bpf: Using kvcalloc to allocate cache buffer
  riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset
  riscv, bpf: Mixing bpf2bpf and tailcalls

 arch/riscv/net/bpf_jit.h        |   1 +
 arch/riscv/net/bpf_jit_comp64.c | 101 +++++++++++++-------------------
 arch/riscv/net/bpf_jit_core.c   |   9 +--
 3 files changed, 45 insertions(+), 66 deletions(-)

-- 
2.34.1


