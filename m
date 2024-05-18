Return-Path: <bpf+bounces-29991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC148C8F6E
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 05:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E76A282C31
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 03:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40046FCB;
	Sat, 18 May 2024 03:28:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F2523A;
	Sat, 18 May 2024 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716002881; cv=none; b=XAqL26dQ2mw3R3oLgO/acpFDNkbhChgCMSpFDVcJcnOgow3ipmEmkMgSSruUOdpVvqX7mamsvHgLjDaGLqfbPftbvUKyeOTI6hGww1oCW5QO703OiAbw80GwAbo09DcqtjMbyMxxkn2cwx3bLg/8TBUDPcHZ+eGospY2rFb9irM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716002881; c=relaxed/simple;
	bh=HhXC567gm27enXF8Mkpeq7Mb78wrx5ujlnTsvAyjJsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FYhWISlxpgKITCRY9cfv56hiBOCmEQjQHudFsnYXTy4KdkXfyML3gqsDk9VGHbCNGoo16H+aADRE9u7HcuQHuDSQztBsHERm1abxpfPDxc1ZucrzQpK0TwHZcaMAJKAB8LWlXBj1V5I/+afBhLEkMWM12teWlzktIpazRO52cGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vh8R675XWz4f3jrh;
	Sat, 18 May 2024 11:27:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C13F41A016E;
	Sat, 18 May 2024 11:27:55 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgC3Gf05IEhmkYcnNQ--.13474S2;
	Sat, 18 May 2024 11:27:53 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Menglong Dong <imagedong@tencent.com>,
	Pu Lehui <pulehui@gmail.com>
Subject: [PATCH bpf-next v4 0/3] Add 12-argument support for RV64 bpf trampoline
Date: Sat, 18 May 2024 03:28:53 +0000
Message-Id: <20240518032856.2721688-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3Gf05IEhmkYcnNQ--.13474S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF45KF1xuF4fXryktF4fXwb_yoW8Kr17pa
	1Ig3Wa9F1rKF42q34xJa1Uuryrtr4rZw15Cr4xJ34F9ayDtry5Jr1I9w4Yy345Wr93u3yS
	y3sI9Fy5WF1DZ3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbG2NtUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

This patch adds 12 function arguments support for riscv64 bpf
trampoline. The current bpf trampoline supports <= sizeof(u64) bytes
scalar arguments [0] and <= 16 bytes struct arguments [1]. Therefore, we
focus on the situation where scalars are at most XLEN bits and
aggregates whose total size does not exceed 2×XLEN bits in the riscv
calling convention [2].

Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184 [0]
Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769 [1]
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [2]

v4:
- Separate many args test logic from tracing_struct. (Daniel)

v3: https://lore.kernel.org/all/20240403072818.1462811-1-pulehui@huaweicloud.com/
- Variable and macro name alignment:
  nr_reg_args: number of args in reg
  nr_stack_args: number of args on stack
  RV_MAX_REG_ARGS: macro for riscv max args in reg

v2: https://lore.kernel.org/all/20240403041710.1416369-1-pulehui@huaweicloud.com/
- Add tracing_struct to DENYLIST.aarch64 while aarch64 does not yet support
  bpf trampoline with more than 8 args.
- Change the macro RV_MAX_ARG_REGS to RV_MAX_ARGS_REG to synchronize with
  the variable definition below.
- Add some comments for stk_arg_off and magic number of skip slots for loading
  args on stack.

v1: https://lore.kernel.org/all/20240331092405.822571-1-pulehui@huaweicloud.com/

Pu Lehui (3):
  riscv, bpf: Add 12-argument support for RV64 bpf trampoline
  selftests/bpf: Factor out many args tests from tracing_struct
  selftests/bpf: Add testcase where 7th argment is struct

 arch/riscv/net/bpf_jit_comp64.c               | 66 +++++++++----
 tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++
 .../selftests/bpf/prog_tests/tracing_struct.c | 46 ++++++++-
 .../selftests/bpf/progs/tracing_struct.c      | 54 -----------
 .../bpf/progs/tracing_struct_many_args.c      | 97 +++++++++++++++++++
 6 files changed, 206 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_many_args.c

-- 
2.34.1


