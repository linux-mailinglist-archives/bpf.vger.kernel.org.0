Return-Path: <bpf+bounces-22871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8833B86B17C
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022F61F24F8F
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 14:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15E71586CF;
	Wed, 28 Feb 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiXdj1lP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BCB14F998;
	Wed, 28 Feb 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129925; cv=none; b=nWJ6Lsc2LOsHAopGr3aFF1z0Pk6vdb588rAo9UzNVe663EQ4jqZ0dmdIRqPHtz6C6ub5VikBmFVBmxtjczU/nN6ZBegJhTx4o97gF2e1B+yaBj6+7PeHWuw4GZh8zyj+yALLgEj+UOW/3yUaj8QFjKQvZua7EM/cE2UeLuQDXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129925; c=relaxed/simple;
	bh=lHbE9CNSkMTisacwR8gmtL+5gp2cS17p9riJalD1z7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ea56r/g8rgb4bF2j8ca2+pYqKFVQurVumPSk+A7hZdVWSz9R4Q7sH/gyxK4B1285IH/qtAeNlSdpCLQvGTAuPzO48JtYMpiR9p+HCSVN5yn9PAheqOcQKT9rBk6kvb+6tGFmc34J3YPGmJkCDq3y6zIKPEegkrCA9hPdbWlwq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiXdj1lP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412b88e2f07so216355e9.3;
        Wed, 28 Feb 2024 06:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709129922; x=1709734722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PMX+ThpO6mgVFASiMk5Ewm/ciwzj+pfXAE1dKwvq0g=;
        b=eiXdj1lPmqpLKQbpyHKnAES0E5aeYbtKavGX0MsZ5bQwTSHs/QdTONrkFO6uD5AlZ3
         kdnn4qHIzxBCD0pNXW2hrQPpFzPzlGi5uoss6BzUH3joc7koGtOtAogco6WtzK0v/lmB
         hiUA8XetAgWI2N+BhAJqYjTx2JmDoNSNaV1nNkRABydlrVBZC7LLwp0KztTj7rOvjUHW
         4Q72NsUowKIp64qhhZJ5VYKybk0P1PYEPTKuIdbY5UziO5eZe1PTSkmG83aMgshJH3oa
         LMc8Kjo9JunjjJDiWvSihQop4t1Vz90rQNSatrlYXL8lCaFpsEOXeoJPs2dZz9c+qoBI
         1tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709129922; x=1709734722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PMX+ThpO6mgVFASiMk5Ewm/ciwzj+pfXAE1dKwvq0g=;
        b=M+yC1PE9q1vU8Poo0cl4xQY2HJq9/GXgYOjPdS33wd+4iDmHywWA40ImUu2ZDWjclL
         DeJ70EO+LaAB2QxZLoOKhFjE+0MhifITbvZg/96KdXS6wYhLFSh4Efp8ELNWgnUX2TEh
         HQ80URenwf7GcD78zVIBDUg/QCZJnkmwsOiuBygD5+omJHcjbKOHxaTvm3jocgSdVmgn
         byNHC40RdMbZafcNji9POPVY++CQWntcKBCPPN6NhhS9xHIsn7yIoh9EQiHDQi9lWFG2
         ErBCGYWazNSr2Lu9VLhyEXzmrgr0P1S1Y3T5qR+DykdtIGt4Mv2Anl3K7VVTi716V0HP
         Sr9A==
X-Forwarded-Encrypted: i=1; AJvYcCXZNijAElMHMOHBFisWtGkLsJnYxQPNs/3aNk9uCVc6B8uAZE7VEBPAoP4YXtE/w60j0Oq60aTu8rg4sGuJYO5bE8KAXZUhfVMYFWwXMBNoilR7DuTakfSyF8tSH18mc5Lo
X-Gm-Message-State: AOJu0YwXtt7QuWSOZeVDkEhN2flN/77kB7jpjt/JxVTrPBq5wxgIFhmT
	Z1IqAtvw1qh6X4791Pbto4Ow2fqIrxjzsyE4KqjCWKkibkYPCPeH
X-Google-Smtp-Source: AGHT+IEHjfVaHuEbgnHU7QkhA712qSAqgZ5DPG4JC8/dqFlbjMvB3GmyWUM2Q21L9Yzh7L6K3+w+zg==
X-Received: by 2002:a7b:c459:0:b0:412:817c:364e with SMTP id l25-20020a7bc459000000b00412817c364emr9244945wmi.36.1709129921466;
        Wed, 28 Feb 2024 06:18:41 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c0ac900b00412a2060d5esm2221635wmr.23.2024.02.28.06.18.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:18:41 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	bpf@vger.kernel.org,
	kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xukuohai@huaweicloud.com
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v9 0/2] bpf, arm64: use BPF prog pack allocator in BPF JIT
Date: Wed, 28 Feb 2024 14:18:22 +0000
Message-ID: <20240228141824.119877-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in V8 => V9:
V8: https://lore.kernel.org/bpf/20240221145106.105995-1-puranjay12@gmail.com/
1. Rebased on bpf-next/master
2. Added Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Changes in V7 => V8:
V7: https://lore.kernel.org/bpf/20240125133159.85086-1-puranjay12@gmail.com/
1. Rebase on bpf-next/master
2. Fix __text_poke() by removing usage of 'ret' that was never set.

Changes in V6 => V7:
V6: https://lore.kernel.org/all/20240124164917.119997-1-puranjay12@gmail.com/
1. Rebase on bpf-next/master.

Changes in V5 => V6:
V5: https://lore.kernel.org/all/20230908144320.2474-1-puranjay12@gmail.com/
1. Implement a text poke api to reduce code repeatition.
2. Use flush_icache_range() in place of caches_clean_inval_pou() in the
   functions that modify code.
3. Optimize the bpf_jit_free() by not copying the all instructions on
   the rw image to the ro_image

Changes in V4 => v5:
1. Remove the patch for making prog pack allocator portable as it will come
   through the RISCV tree[1].

2. Add a new function aarch64_insn_set() to be used in
   bpf_arch_text_invalidate() for putting illegal instructions after a
   program is removed. The earlier implementation of bpf_arch_text_invalidate()
   was calling aarch64_insn_patch_text_nosync() in a loop and making it slow
   because each call invalidated the cache.

   Here is test_tag now:
   [root@ip-172-31-6-176 bpf]# time ./test_tag
   test_tag: OK (40945 tests)

   real    0m19.695s
   user    0m1.514s
   sys     0m17.841s

   test_tag without these patches:
   [root@ip-172-31-6-176 bpf]# time ./test_tag
   test_tag: OK (40945 tests)

   real    0m21.487s
   user    0m1.647s
   sys     0m19.106s

   test_tag in the previous version was really slow > 2 minutes. see [2]

3. Add cache invalidation in aarch64_insn_copy() so other users can call the
   function without worrying about the cache. Currently only bpf_arch_text_copy()
   is using it, but there might be more users in the future.

Chanes in V3 => V4: Changes only in 3rd patch
1. Fix the I-cache maintenance: Clean the data cache and invalidate the i-Cache
   only *after* the instructions have been copied to the ROX region.

Chanes in V2 => V3: Changes only in 3rd patch
1. Set prog = orig_prog; in the failure path of bpf_jit_binary_pack_finalize()
call.
2. Add comments explaining the usage of the offsets in the exception table.

Changes in v1 => v2:
1. Make the naming consistent in the 3rd patch:
   ro_image and image
   ro_header and header
   ro_image_ptr and image_ptr
2. Use names dst/src in place of addr/opcode in second patch.
3. Add Acked-by: Song Liu <song@kernel.org> in 1st and 2nd patch.

BPF programs currently consume a page each on ARM64. For systems with many BPF
programs, this adds significant pressure to instruction TLB. High iTLB pressure
usually causes slow down for the whole system.

Song Liu introduced the BPF prog pack allocator[3] to mitigate the above issue.
It packs multiple BPF programs into a single huge page. It is currently only
enabled for the x86_64 BPF JIT.

This patch series enables the BPF prog pack allocator for the ARM64 BPF JIT.

====================================================
Performance Analysis of prog pack allocator on ARM64
====================================================

To test the performance of the BPF prog pack allocator on ARM64, a stresser
tool[4] was built. This tool loads 8 BPF programs on the system and triggers
5 of them in an infinite loop by doing system calls.

The runner script starts 20 instances of the above which loads 8*20=160 BPF
programs on the system, 5*20=100 of which are being constantly triggered.

In the above environment we try to build Python-3.8.4 and try to find different
iTLB metrics for the compilation done by gcc-12.2.0.

The source code[5] is  configured with the following command:
./configure --enable-optimizations --with-ensurepip=install

Then the runner script is executed with the following command:
./run.sh "perf stat -e ITLB_WALK,L1I_TLB,INST_RETIRED,iTLB-load-misses -a make -j32"

This builds Python while 160 BPF programs are loaded and 100 are being constantly
triggered and measures iTLB related metrics.

The output of the above command is discussed below before and after enabling the
BPF prog pack allocator.

The tests were run on qemu-system-aarch64 with 32 cpus, 4G memory, -machine virt,
-cpu host, and -enable-kvm.

Results
-------

Before enabling prog pack allocator:
------------------------------------

Performance counter stats for 'system wide':

         333278635      ITLB_WALK
     6762692976558      L1I_TLB
    25359571423901      INST_RETIRED
       15824054789      iTLB-load-misses

     189.029769053 seconds time elapsed

After enabling prog pack allocator:
-----------------------------------

Performance counter stats for 'system wide':

         190333544      ITLB_WALK
     6712712386528      L1I_TLB
    25278233304411      INST_RETIRED
        5716757866      iTLB-load-misses

     185.392650561 seconds time elapsed

Improvements in metrics
-----------------------

Compilation time                             ---> 1.92% faster
iTLB-load-misses/Sec (Less is better)        ---> 63.16% decrease
ITLB_WALK/1000 INST_RETIRED (Less is better) ---> 42.71% decrease
ITLB_Walk/L1I_TLB (Less is better)           ---> 42.47% decrease

[1] https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=20e490adea279d49d57b800475938f5b67926d98
[2] https://lore.kernel.org/all/CANk7y0gcP3dF2mESLp5JN1+9iDfgtiWRFGqLkCgZD6wby1kQOw@mail.gmail.com/
[3] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
[4] https://github.com/puranjaymohan/BPF-Allocator-Bench
[5] https://www.python.org/ftp/python/3.8.4/Python-3.8.4.tgz

Puranjay Mohan (2):
  arm64: patching: implement text_poke API
  bpf, arm64: use bpf_prog_pack for memory management

 arch/arm64/include/asm/patching.h |   2 +
 arch/arm64/kernel/patching.c      |  75 ++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c     | 139 ++++++++++++++++++++++++------
 3 files changed, 192 insertions(+), 24 deletions(-)

-- 
2.42.0


