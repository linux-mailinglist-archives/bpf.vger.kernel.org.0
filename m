Return-Path: <bpf+bounces-22406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7615A85E044
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 15:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB622B239EF
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 14:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE167FBBC;
	Wed, 21 Feb 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWGq15+f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156917FBA9;
	Wed, 21 Feb 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527089; cv=none; b=eDiRsr/obVOnIqVOB3bKdty/n7JsieEdAKy9PDOn5JDm+QmkZzVF1vO8SpiurBl64VjSegjYdcjSnOwEf7BtIrstOO9gtBbZ11O14XoVA3hr/cGDkOZpNxfmmDZg1QEKYTO1Lad9bG+dBTJuT11U9AVIvJSBDHex5Kn4IBrfm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527089; c=relaxed/simple;
	bh=s2T7R4N1p3lnMwGvtR4zo0PLgd2eVzvYetbPnMYISZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ipFRfF/PHspUG3Z9GrpxNR0+YrTQOEhqdC7O7iYuk16IHq3BPdO0w+dxlFmb+HrXpaayvStWIadndoE1uCpMGh9Ps6MY5Y76KwY/UfTM5/8wWB+dkp7/OEgbFivCvJb7LQJlxkYzP7DvU1/XvZU2VIqOPoGGISTNUf1ce7EKxog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWGq15+f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41275971886so5258575e9.3;
        Wed, 21 Feb 2024 06:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708527086; x=1709131886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZg1sv8+ovEl7fsqj4X1zEjMkSsF35TkvVOPYv4FlCY=;
        b=aWGq15+fiMSa6+lwv3HYXujXZL1jBnqqyTbK7IBJ+yIGMUniGkvSRe2BnSxuFlrEVe
         3GtUCcuysGlOgH5jJJeLC0sPE/wVQItphM0wjwV66Yb2+4TrB7zsHbPJm4gHXMxzQ7wE
         0AXOnW8e/dHugcjUxQdJVh3kKiW0UKfH3I5zNzSMpMBGGaUydozoX9MdRC3T3fEHClD9
         Hmra1jS/s+r46C/4CKrTFWgkjPudWL7y9tGbgVZibhwKuooC5EMNjUzZh0DkXJEBgHNY
         sxTzct0olAbFy/krOOkiKaiBJoHTKt8vC+TnUjGqrwZnVfLO4vGnZfygrNZtq9Zm4oPK
         GkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527086; x=1709131886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZg1sv8+ovEl7fsqj4X1zEjMkSsF35TkvVOPYv4FlCY=;
        b=GB3lE+gkAjl4uLC4gLwKE+Nj5cl/ziNNVWY9i50PnJJs7kxs3bejxe7RgSTcBzgWIO
         cvAINIy0ndx96IqW6szyCn+Jr/xBIcL5A+N0GeARtWVreQ7wGUwdV4RPUmgtthomox/I
         eiE3jylME5LIxIDydJFa0PXylQEkl8wHQtS/VkAB3CWTlNEAQ86VLDMTjA8Dw5VQJfM9
         rLMbIvwHUKc57GExX+Nv6dHbMRhI9VyuCHGaki/E9MLfTlL/9oOM5XpyuIWtsJ1yqCzZ
         39dAYoHVWqr1aH6JSl7q0s/wYc/rtwGtVlPtyKVu2siYEjKDTTrI2iZaIIYDY2wk95OX
         TXJw==
X-Forwarded-Encrypted: i=1; AJvYcCX9jwowl6CNXavI2Zu1kFSVDHaUwE9St829RxIC+GjkCecpKZNzukuqE8Zycz/ELsZW4uctEBkjGTcpfPkhoulR6Jn+Gg8cKFsN5LGa0wH/myDzcrHmot7eW57rSRSC9TwA
X-Gm-Message-State: AOJu0YxcfvmgEPIeSa/uJX4JJcqNWlGjrlhZq5lxfyiaw6HPADbag6d5
	2Wwby5oK0ci4oSgDPZBa/E4t2CiGUIfRWDrI+phOqbJwtfThcJ/QVssZd1eIDwrvHA==
X-Google-Smtp-Source: AGHT+IFkapUJ45YcchhcfJZimsRNd//nNdGZzZXboG8jOlZGf8yL/sbdyFoTkGzLRTgHwNvsg3Dmpg==
X-Received: by 2002:a5d:6652:0:b0:33d:15c1:cfcb with SMTP id f18-20020a5d6652000000b0033d15c1cfcbmr12051412wrw.40.1708527086026;
        Wed, 21 Feb 2024 06:51:26 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bk26-20020a0560001d9a00b0033d568f8310sm9256360wrb.89.2024.02.21.06.51.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:51:25 -0800 (PST)
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
Subject: [PATCH bpf-next v8 0/2] bpf, arm64: use BPF prog pack allocator in BPF JIT
Date: Wed, 21 Feb 2024 14:51:04 +0000
Message-Id: <20240221145106.105995-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.40.1


