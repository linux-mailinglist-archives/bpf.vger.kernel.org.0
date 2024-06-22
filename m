Return-Path: <bpf+bounces-32792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E420913192
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 04:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9C1B24215
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 02:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8479F9;
	Sat, 22 Jun 2024 02:20:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA104C91;
	Sat, 22 Jun 2024 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719022808; cv=none; b=Wr4/RztzS+ChhbiTJZWmTCEDVUjEwk3XLp7FZ8X2vZuYfpYwq8X7dxv3apeBpGbc6K5Grun+CSVemg8JxHv4fNNzfbM+tkKQFoGp3DCD1CrJYYgweEG6RWaXNGBYQ206CViD/7ezqAWjrTL29uVBRGpuqlw0UEw9tHKm3LeKzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719022808; c=relaxed/simple;
	bh=+484rwkgkibp3amq9EaWF2Dl1xufpJkPAnhO+3WaieA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KGYyeCIimmV0hXePnsc/GIe/LctHKqWha3YP8+77OCDJLiyXApplma6Rva3gCC2hjwlBsSpjI7vACTqXBR7KE4TFp85aYeHzJcvipWcCagtP9azKVko/9yPG7fOF6b9Dg3s8joMfanEzh+w/5HCd23y1xPkxLnPq2zOLLcFfb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W5dGS41Z6z4f3kw3;
	Sat, 22 Jun 2024 10:19:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7DB2B1A0189;
	Sat, 22 Jun 2024 10:19:56 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgCnPK7INHZmmlBiAg--.22370S2;
	Sat, 22 Jun 2024 10:19:53 +0800 (CST)
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
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH RESEND bpf-next v4 0/3] Add 12-argument support for RV64 bpf trampoline
Date: Sat, 22 Jun 2024 02:21:26 +0000
Message-Id: <20240622022129.3844473-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnPK7INHZmmlBiAg--.22370S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF45WF13tr4kGFW5tF13Jwb_yoW8KrW3pa
	1Ig3Wa93WFgF42q34xJa1Uuryrtr4rXw15Cr4xJ34F9ayDtry5tr1I9w4Yy345Wr93u3yS
	y34a9Fy5W3WDZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

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


