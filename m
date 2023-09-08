Return-Path: <bpf+bounces-9512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67D0798914
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F9E281E79
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC63B6D39;
	Fri,  8 Sep 2023 14:43:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA16AB0
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 14:43:26 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7A61BFF;
	Fri,  8 Sep 2023 07:43:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b962c226ceso36210671fa.3;
        Fri, 08 Sep 2023 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694184202; x=1694789002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8HwV+J/7uNnqFbijDhQaafWl9GR5aB5QOka+RcaLbE=;
        b=ifxa3gaoc5LGoesPfBm8FnhW6pxYTrgTnveivx5F67e/UOenYvgdiWGkhEIVKWtRfk
         Wu2hNZI8CHSWSf5JOIjgqo7ZRdrKWdc82UON3iqVNa4J2dxPms47k7WJCKj4zmgbHmld
         6dWCyaoKYsYmr5sO/BLI5E6hVF8lQz6LKajL/+KuENgidNxdXIP8NwjoktezlG9+7Aik
         JUgM3PajeUKFZVRwSJkhRvphyUQ+EismLzsl0itBucLTXcQRBwmAeOt+EvkAWM0MGbvG
         x7dgSyKeRRg+Mj/QM59u8+jCSv72kg7gJpQ6sUXdIxZ9cG31XXAHQa+tHD5RW9tcOEs8
         OUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694184202; x=1694789002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8HwV+J/7uNnqFbijDhQaafWl9GR5aB5QOka+RcaLbE=;
        b=oc0IRnKSK/uDMK7m5u5vGLNrXLQza/eep5G/3rJvolPU1nZlmdF8h++7/JRAopDZhm
         GcfWZnv68NN9EVCS9oQBbzLCKbHkfowiE03+Nle6fSpbj5mkpf/7JqTzmRc82cUY0e8M
         xJl7BxP9G9qNFTLpSnPvovFI6x2gK3Wid2u4Iy6Y8/CARyxy2x5VgN5wVyRm2cB6iY8m
         H0ndBZKe6J6ubET8tNlyUjivkgCH9I5nWQS0macA/nAI+LB1yK+35QXmAYc+XldoZkSJ
         p0hOxXGkU3qNLFdf3JoLKUQes0S8Z1sfKhjx6Kp4IsKraweAwJw1jHRifqjHdQSNY5YW
         cDjw==
X-Gm-Message-State: AOJu0YwHR3zT8pmtZu8/79y2bPOp0WB4/N2eq6QAKu0nBSitkIS2zAWP
	ATA5YHow09WROyTbBN2b0ww=
X-Google-Smtp-Source: AGHT+IFytL8L4GmYN1lwr1zUUD8lffspTsgM5GvKOTcdz6bFTFuST3e9LT9M6Av3AlU+swSps1K05g==
X-Received: by 2002:a2e:3c18:0:b0:2bd:1615:f9f8 with SMTP id j24-20020a2e3c18000000b002bd1615f9f8mr2033400lja.45.1694184201563;
        Fri, 08 Sep 2023 07:43:21 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-217-129-48.eu-west-1.compute.amazonaws.com. [54.217.129.48])
        by smtp.gmail.com with ESMTPSA id lz5-20020a170906fb0500b0098e78ff1a87sm1099436ejb.120.2023.09.08.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:43:21 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v5 0/3] bpf, arm64: use BPF prog pack allocator in BPF JIT
Date: Fri,  8 Sep 2023 14:43:17 +0000
Message-Id: <20230908144320.2474-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

Puranjay Mohan (3):
  arm64: patching: Add aarch64_insn_copy()
  arm64: patching: Add aarch64_insn_set()
  bpf, arm64: use bpf_jit_binary_pack_alloc

 arch/arm64/include/asm/patching.h |   2 +
 arch/arm64/kernel/patching.c      |  81 ++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c     | 136 ++++++++++++++++++++++++------
 3 files changed, 195 insertions(+), 24 deletions(-)

-- 
2.40.1


