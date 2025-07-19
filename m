Return-Path: <bpf+bounces-63794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4CDB0AEFA
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 11:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D50189E001
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 09:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333EB239E9F;
	Sat, 19 Jul 2025 09:14:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C5238166;
	Sat, 19 Jul 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916468; cv=none; b=kfriQMzB9aHcDDhuEqATjKlzyPivo6F903nwIq8y3y2VvFgvfrAu29B4StbXhzDYOBuOiQTvmT2W+MFm6bJdFvasc/cDAMKoJ2iNqbyxSAxUr8s1jYQJYw921O695BFqm27tdSUNKSmQmKpupFyoVCheQFWtPutFCrFL3jTSHxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916468; c=relaxed/simple;
	bh=aMHhOoynbPDET+/Dpg649q+vDc0nYBSz40pFbmgcYaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IiwlSH591ZIf6c/t2g0FJEcXIZ6y04Bw0bpqIxd1wxMx1PlVeLuxrraVDpkWdEN1BFBsoP7mwdS4xEoedew1cGTWCmTDz6JZS1RBjnWRS0F9vGIhXUr0p8DTYAyvq5yBnufxA10u4iKVu7OKLFVgtYj8XAxFU3eGra1aCfQLcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bkgw06XK6zKHMq3;
	Sat, 19 Jul 2025 17:14:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 839EB1A109E;
	Sat, 19 Jul 2025 17:14:23 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHURLuYXtopCAYAw--.54295S2;
	Sat, 19 Jul 2025 17:14:23 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 00/10] Add support arena atomics for RV64
Date: Sat, 19 Jul 2025 09:17:20 +0000
Message-Id: <20250719091730.2660197-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHURLuYXtopCAYAw--.54295S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1DAryftr4fCFW3Kw4DArb_yoW5AFW3pr
	43Gr9rGa15Ww1UCa9I9a4xC345Ca1Yvw15Jw4kAw1xAF1Ygr15JFZ2k3W3Ar15Krs3Xa1Y
	kryjqa4jyw4UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

patch 1-3 refactor redundant load and store operations.
patch 4-7 add Zacas instructions for cmpxchg.
patch 8 optimizes exception table handling.
patch 9-10 add support arena atomics for RV64.

Tests `test_progs -t atomic,arena` have passed as shown bellow,
as well as `test_verifier` and `test_bpf.ko` have passed.

$ ./test_progs -t arena,atomic
#3/1     arena_atomics/add:OK
#3/2     arena_atomics/sub:OK
#3/3     arena_atomics/and:OK
#3/4     arena_atomics/or:OK
#3/5     arena_atomics/xor:OK
#3/6     arena_atomics/cmpxchg:OK
#3/7     arena_atomics/xchg:OK
#3/8     arena_atomics/uaf:OK
#3/9     arena_atomics/load_acquire:OK
#3/10    arena_atomics/store_release:OK
#3       arena_atomics:OK
#4/1     arena_htab/arena_htab_llvm:OK
#4/2     arena_htab/arena_htab_asm:OK
#4       arena_htab:OK
#5/1     arena_list/arena_list_1:OK
#5/2     arena_list/arena_list_1000:OK
#5       arena_list:OK
#6/1     arena_spin_lock/arena_spin_lock_1:OK
#6/2     arena_spin_lock/arena_spin_lock_1000:OK
#6/3     arena_spin_lock/arena_spin_lock_50000:OK
#6       arena_spin_lock:OK
#10      atomic_bounds:OK
#11/1    atomics/add:OK
#11/2    atomics/sub:OK
#11/3    atomics/and:OK
#11/4    atomics/or:OK
#11/5    atomics/xor:OK
#11/6    atomics/cmpxchg:OK
#11/7    atomics/xchg:OK
#11      atomics:OK
#513/1   verifier_arena/basic_alloc1:OK
#513/2   verifier_arena/basic_alloc2:OK
#513/3   verifier_arena/basic_alloc3:OK
#513/4   verifier_arena/basic_reserve1:OK
#513/5   verifier_arena/basic_reserve2:OK
#513/6   verifier_arena/reserve_twice:OK
#513/7   verifier_arena/reserve_invalid_region:OK
#513/8   verifier_arena/iter_maps1:OK
#513/9   verifier_arena/iter_maps2:OK
#513/10  verifier_arena/iter_maps3:OK
#513     verifier_arena:OK
#514/1   verifier_arena_large/big_alloc1:OK
#514/2   verifier_arena_large/access_reserved:OK
#514/3   verifier_arena_large/request_partially_reserved:OK
#514/4   verifier_arena_large/free_reserved:OK
#514/5   verifier_arena_large/big_alloc2:OK
#514     verifier_arena_large:OK
Summary: 8/39 PASSED, 0 SKIPPED, 0 FAILED

Pu Lehui (10):
  riscv, bpf: Extract emit_stx() helper
  riscv, bpf: Extract emit_st() helper
  riscv, bpf: Extract emit_ldx() helper
  riscv: Separate toolchain support dependency from RISCV_ISA_ZACAS
  riscv, bpf: Add rv_ext_enabled macro for runtime detection extentsion
  riscv, bpf: Add Zacas instructions
  riscv, bpf: Optimize cmpxchg insn with Zacas support
  riscv, bpf: Add ex_insn_off and ex_jmp_off for exception table
    handling
  riscv, bpf: Add support arena atomics for RV64
  selftests/bpf: Enable arena atomics tests for RV64

 arch/riscv/Kconfig                            |   1 -
 arch/riscv/include/asm/cmpxchg.h              |   6 +-
 arch/riscv/kernel/setup.c                     |   1 +
 arch/riscv/net/bpf_jit.h                      |  70 ++-
 arch/riscv/net/bpf_jit_comp64.c               | 516 +++++-------------
 .../selftests/bpf/progs/arena_atomics.c       |   9 +-
 6 files changed, 214 insertions(+), 389 deletions(-)

-- 
2.34.1


