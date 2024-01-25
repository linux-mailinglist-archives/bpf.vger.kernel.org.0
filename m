Return-Path: <bpf+bounces-20326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF71383C3AB
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 14:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A698A291FE9
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791955C12;
	Thu, 25 Jan 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCPS6Oqb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DE55C06;
	Thu, 25 Jan 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189546; cv=none; b=lVfikPMKH4/kJJyJoCxyaqUo/9A7mfRXOKMkxu5bq1K22PFOABHP6eyHXNXfxBz+Yi3t800GM9NPQxjAMsOIY9V9yPv71MqQP8JxiCl7U01WdC1GYgP7Pf3fNrHQraWjK1nWwOmJrrONozdYk9/ZsXL9OesqAkvKCjkKbXQAcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189546; c=relaxed/simple;
	bh=6IyOIDp66vL9I7p+Sqb+ySzF8BbJNEzUjq1hr14XfdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a3N7kTSIwuyQD/DxI40aBuayZrj4+UA6vS7+DDJfIPkBO35x2ur3fT27dUZSTDcOYcGIitcHwgnzfSPnTfT3+qaos8xM20o5nIUc1U5HSn+gjqfklu5XChDLCS7mfq0SdchMeDYZ9TigEXkvxfcJuMbQSCzxQzJJmmYOV1WR94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCPS6Oqb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3392b045e0aso4578766f8f.2;
        Thu, 25 Jan 2024 05:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706189542; x=1706794342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wPzcb68qn9M4LxlA52Yc+zsuovDKo9xC8bQLGe8EBog=;
        b=eCPS6OqbFdyk6wHZIZvzkji1SepHgha7SADkcaTHUoKVw3hB6wLuJ0k+zS/2cGTk+N
         J+XxWgAz5cSK3Rc1C4chPnNyBKvTnXVNZznBLQ9Pun5icJ7Hx3evkPphavoJni3oPGq+
         uCnnzAy5X5uZDQuESZ43l2xAKA7I4MfWXVW9F2Ra2gN4EEYbzTX6//Ij6pbM1K4j9Jrw
         dJJ/RqrTdsE4YPZew1hWwQs44hkua0uk0WOPw/jzCV6qanHn1wTFHdA4/uLmVxE7u8OW
         ODxCbHxHYXHI4KeFUr8QocjVRJAO2ty0wbiyynWZCkcK6MfkIZIc2K0Xg92o9uFo186F
         nk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706189542; x=1706794342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPzcb68qn9M4LxlA52Yc+zsuovDKo9xC8bQLGe8EBog=;
        b=FnnFZiqFBuTD7G0I0An2vaqG/hnigWmLtbBWAfMH8cu6aT9eQoiO1/nL5c1euXwAzt
         j0PBD0Vv/4wMXYEtuU0CYRpZ7Ty+4GQmfbCz/7vb0omVFVMmuLMIVjzEX/jxt9KqdVIi
         7UUl1dz7HajwOp3bkMfnTyOsQ8tftejtndKr+1W/oppooEGgUYIyPrUPOy7cIq5g3Uz/
         HcZsWtU3r+XpT6uPZuvYl0wQ81c/nBBXGMWqVwF9dra8l7TgIAsiFepsWWRxQUDwGsqS
         nteUKycSd6mkfUzob5Yb+2jDlw9Hvkge/EaQqgelZ+Cf/5sDBnsNM7qf/MxvQT2c8CCJ
         JJfQ==
X-Gm-Message-State: AOJu0YzzI6rahk3EZImlwMccIPqZwgIrWTflhsCg79HqKsTjqBXfNkRh
	9SkvB0t6x7+D1L04TCksHJH6Wvyi0kV1BGoMVqxRUJMVxZoF0ul2
X-Google-Smtp-Source: AGHT+IHvNqTjV5HIu+z1rkOL0wJ/IrC88LzVVYsKDtUNR87CrcK8QyUQHIT7nIc7xIGtoGsVe7z5LA==
X-Received: by 2002:a05:6000:70a:b0:337:c693:dc06 with SMTP id bs10-20020a056000070a00b00337c693dc06mr542980wrb.19.1706189542210;
        Thu, 25 Jan 2024 05:32:22 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id c16-20020a5d4f10000000b003393592ef8dsm10311681wru.54.2024.01.25.05.32.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2024 05:32:21 -0800 (PST)
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
Subject: [PATCH bpf-next v7 0/2] bpf, arm64: use BPF prog pack allocator in BPF JIT
Date: Thu, 25 Jan 2024 13:31:57 +0000
Message-Id: <20240125133159.85086-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 arch/arm64/kernel/patching.c      |  80 +++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c     | 139 ++++++++++++++++++++++++------
 3 files changed, 197 insertions(+), 24 deletions(-)

-- 
2.40.1


