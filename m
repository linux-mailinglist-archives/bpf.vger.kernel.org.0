Return-Path: <bpf+bounces-1985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD257259EE
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 11:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5362811D8
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7782F9440;
	Wed,  7 Jun 2023 09:18:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E58F6C
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 09:18:20 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D236172E;
	Wed,  7 Jun 2023 02:18:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30d5931d17aso3426168f8f.3;
        Wed, 07 Jun 2023 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686129496; x=1688721496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MtMQ/nGfSguBTH/fnJCG/BZKK2MvsVclTLF6KR44o7Q=;
        b=mKFNfeE1x5dO0MrHNtPLOQyU9VKLcb/HNfA4YnRbqeZzNQA8nsDiNEg+OY50nVZg3o
         3SvQlMxskAHYUd7FYwAH4UTN4XPB8HE24EuRKoykKJf/kB4T9o5kBbEJekJYE1khNJXn
         9bczr0iQlXAIRaW4idjei+5q7LAfmX9ptfZnH4+5Wcol33gAv00rDH8DzpMP/KXdfdxv
         A1GReP+li1Wm5hawNn6AX2qjWEd4gAeL2oMiR+lbivaDFAljjzHS+9TO7caqZjXIPtR2
         CYRPeTV8sBAbyS5KupwrTLUruKqKYJuIIRIXbEt0+tbm+2zk22aUGzi+dOzgv5iHEPiK
         atwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129496; x=1688721496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtMQ/nGfSguBTH/fnJCG/BZKK2MvsVclTLF6KR44o7Q=;
        b=DtPiyihpDlvPF6PJK5WEqzhFfo7Dj8S38ty0n/p2nH4o6vMk5bTYbfEPvNEmrLtcvx
         gtFsqaAEHWAybFbADBqCPUeL5z/RmTrE6/AKm4M8xaXpRTg+bLsxvQjecN8/6cylJK+u
         Q9Nr6yKAsI+4alQ0qykOiBZrencH8SiQOw40lypykOd6d/COdxDyZV6ljanKHymJOxpq
         s5NMZqXCav2caDjaPs73VpOS3T9mJK02OzoKHDrr7T3fZRji4Ys3lJHMeLxRxuBdeTbc
         ELk+iAvOT8MbsZurTPTliuni2x8MIZ1zauA5p5wP/6wVqOrw8+SbDp3Icl5qikupXYpq
         ArKg==
X-Gm-Message-State: AC+VfDy0a08/gw4IaMcSovxZWlBBJxmhNFUPv0erMVhMotXFEb8hgib8
	6M+OovcALRloR/iiieVtEfo=
X-Google-Smtp-Source: ACHHUZ725VID59JvCB6v3Gf7AjFernyrsIXI5AhUqGGXgo4gONN4bsPg1xdoDRz0537zlzGqZ8lHsQ==
X-Received: by 2002:a5d:5092:0:b0:30d:44a1:99a with SMTP id a18-20020a5d5092000000b0030d44a1099amr3690368wrt.54.1686129495590;
        Wed, 07 Jun 2023 02:18:15 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-54-74-169-43.eu-west-1.compute.amazonaws.com. [54.74.169.43])
        by smtp.gmail.com with ESMTPSA id cx14-20020a056000092e00b003078681a1e8sm15141958wrb.54.2023.06.07.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:18:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/3] bpf, arm64: use BPF prog pack allocator in BPF JIT
Date: Wed,  7 Jun 2023 09:18:11 +0000
Message-Id: <20230607091814.46080-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BPF programs currently consume a page each on ARM64. For systems with many BPF
programs, this adds significant pressure to instruction TLB. High iTLB pressure
usually causes slow down for the whole system.

Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
It packs multiple BPF programs into a single huge page. It is currently only
enabled for the x86_64 BPF JIT.

This patch series enables the BPF prog pack allocator for the ARM64 BPF JIT.

====================================================
Performance Analysis of prog pack allocator on ARM64
====================================================

To test the performance of the BPF prog pack allocator on ARM64, a stresser
tool[2] was built. This tool loads 8 BPF programs on the system and triggers
5 of them in an infinite loop by doing system calls.

The runner script starts 20 instances of the above which loads 8*20=160 BPF
programs on the system, 5*20=100 of which are being constantly triggered.

In the above environment we try to build Python-3.8.4 and try to find different
iTLB metrics for the compilation done by gcc-12.2.0.

The source code[3] is  configured with the following command:
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

[1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
[2] https://github.com/puranjaymohan/BPF-Allocator-Bench
[3] https://www.python.org/ftp/python/3.8.4/Python-3.8.4.tgz

Changes in v1 => v2:
1. Make the naming consistent in the 3rd patch:
   ro_image and image
   ro_header and header
   ro_image_ptr and image_ptr
2. Use names dst/src in place of addr/opcode in second patch.
3. Add Acked-by: Song Liu <song@kernel.org> in 1st and 2nd patch.

Puranjay Mohan (3):
  bpf: make bpf_prog_pack allocator portable
  arm64: patching: Add aarch64_insn_copy()
  bpf, arm64: use bpf_jit_binary_pack_alloc

 arch/arm64/include/asm/patching.h |   1 +
 arch/arm64/kernel/patching.c      |  39 +++++++++
 arch/arm64/net/bpf_jit_comp.c     | 126 ++++++++++++++++++++++++------
 kernel/bpf/core.c                 |   8 +-
 4 files changed, 147 insertions(+), 27 deletions(-)

-- 
2.39.2


