Return-Path: <bpf+bounces-2831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E688B73515A
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 12:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9818C28109F
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0AC2F1;
	Mon, 19 Jun 2023 10:01:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4320DC14A
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 10:01:50 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA281A4;
	Mon, 19 Jun 2023 03:01:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3112902f785so1568263f8f.0;
        Mon, 19 Jun 2023 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687168883; x=1689760883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5JCEFkwThlYY8Fjj11zfxl1bhhJup7NfesMfshfPMI=;
        b=KPPyqEWsDQlkY8r1nmviT6ME7Abt0tSf8Y3xmcatbn7x8Y+IIB1dJIuZzDrpbKbaG7
         Ne6fg/WKpQ7fVQmaQ0Wyer0G3WMxHEws6mE9SkeI0YAahMwBiBIRxw2Vd1IOp3+Q8mqS
         ShZJtCqcWjJOlO5g0E5KS9U0facr1PE7tlR6sjFxaCFHJU7K4moGjIZ+fphBTsxBtZvW
         vWz5Q6jnkn/zDNtPg+Rjeyk+2O7e7RXDhqA9yyK5+Qp2lIR8dVopDXYVqkaHEUwznXpy
         80mZ+/fN14dgoqq6dSMwinl4RjRSwSim0IrsmpIX0MJt+VN62OnZj7KkHGR0gt7he9/3
         K7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687168883; x=1689760883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5JCEFkwThlYY8Fjj11zfxl1bhhJup7NfesMfshfPMI=;
        b=GPpnV19Kp1fa8RIUa8gzHDde/jM9rym3w65BN4fMSNkzhSZJZ+gRuZ6CVS7Jom91BA
         /+rBr0Aw+GjPvsVplxkQZIcUkevx7CnFbTW3wb6BXp1QBNCLAT4H/vN6OnXIXAFtfSnc
         IMTZaH+nRMFn5h3nXPAOJR+JupD+/LmK/2rvm4jtMQmVjzNV3aRblgInKISVPt0GFtGA
         34yaund9fXr1bLQTTreveOUfky+LFmOqyvgYlYL/aT0oNIvfK/7jsf2k3vglUXKa54xc
         m8niUhHyaQYSS8Sj9CG7NhENGs9EVvsaMXHo0lB43mS7Agn2mQLuPWVPEa5PWrUMGw3I
         sXCw==
X-Gm-Message-State: AC+VfDzr1c+DvyEsAO2NBwtAOyG2Sbqr5ncY8jIj1LNZXXV+qvRWQGi3
	NtGKo7Eh4Xb/3rPytx/Od/Y=
X-Google-Smtp-Source: ACHHUZ5dNrl9XdIGtk/5v3EmAMV20NgM70Ba102dBQK3jrK+escJKKaGrPvDXu6fLQYZ5i1EGBBtbg==
X-Received: by 2002:adf:e4cb:0:b0:311:f11:4c55 with SMTP id v11-20020adfe4cb000000b003110f114c55mr7844262wrm.13.1687168882355;
        Mon, 19 Jun 2023 03:01:22 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-54-154-23-32.eu-west-1.compute.amazonaws.com. [54.154.23.32])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b0030ae3a6be4asm31352451wrf.72.2023.06.19.03.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:01:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/3] bpf, arm64: use BPF prog pack allocator in BPF JIT
Date: Mon, 19 Jun 2023 10:01:18 +0000
Message-Id: <20230619100121.27534-1-puranjay12@gmail.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Puranjay Mohan (3):
  bpf: make bpf_prog_pack allocator portable
  arm64: patching: Add aarch64_insn_copy()
  bpf, arm64: use bpf_jit_binary_pack_alloc

 arch/arm64/include/asm/patching.h |   1 +
 arch/arm64/kernel/patching.c      |  39 +++++++++
 arch/arm64/net/bpf_jit_comp.c     | 138 +++++++++++++++++++++++++-----
 kernel/bpf/core.c                 |   8 +-
 4 files changed, 159 insertions(+), 27 deletions(-)

-- 
2.40.1


