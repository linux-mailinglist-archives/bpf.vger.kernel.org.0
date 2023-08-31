Return-Path: <bpf+bounces-9057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0F78EE3D
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D58B1C20AD3
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4E1171B;
	Thu, 31 Aug 2023 13:12:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECFC11712
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 13:12:35 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DF41A4;
	Thu, 31 Aug 2023 06:12:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so624977f8f.2;
        Thu, 31 Aug 2023 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693487551; x=1694092351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OUm7nd0FR0+Czu6QsCvXyPqGXEo/LdzJR/X7yn/oMx8=;
        b=pjGtdyHID86xCZTWTAheczTKmy1m/Cp3uxh40At0yqBVjI9wC9B7wYLaL1ZjdTaT74
         a8snD45wMwjJ4DoQDrOrR6s3Q1+iacvhZdz5TQlOQETPj4wQWbxBtAsR5Jfzvx/muC4m
         u7HrqkRytcRFTWZj8/8rYyHh/7NCyLYJtIVVLXj4GCLzuVmE747shIXRoQmWs/pwwDhJ
         AOkv/kxcnOua3zj6RB9EQvqdzj3TShNPRSHPLRmo/tnPZj7huTHvzt68e74J4iGF3zdc
         TuEVXRcPH5+OT1xPkz6wEWdQqJZHSI3wzSEC3sYPvf+FGBYMHm85doCNkFdviNN2oVGw
         h2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487551; x=1694092351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUm7nd0FR0+Czu6QsCvXyPqGXEo/LdzJR/X7yn/oMx8=;
        b=JVx19Rd4WAc+7KGIxNoutArzAbt6nK/0539dLBCYKI3SoNNVzQBL3z7dLrHc+cYXoi
         YIO/DGaFY35t1NpVJhhIIRycXMin+bJZ+ArmajPKEI0MqL1F1HhlBvYnb8VeUPuWxvYM
         c624YU2Pr0B1CYx6UWsdiHVdNxT4tPHBr5Sg2HIAbbug8e5/jnlDb41QX3vP6ntu9GQy
         gDl6jJ/DvQpMuK20Tbc9KdHW06YypiiUFfohZwhlhW17CUvork0xbLJIL9/WWW+eiAnt
         ZK4KOEI5yI7x672QvLHWULzKPPpWiHkp/Xhq+qpNFt/YSkMDG2K9N7b2o24m8BWEeof3
         N/UQ==
X-Gm-Message-State: AOJu0YxZs0BOWXO+CtFT3Z1pz3PAZqtH6pbReKcgdToHKSAoseBrew7J
	49kvIHlJ1ADDBnzFT8RF6pY=
X-Google-Smtp-Source: AGHT+IEirwtERw8Qxm5b22yH4bjiRkGte+rMbNcqSJI0Fm6LsW3laKVhOLmtQ1BrgXnnOYn/JkmkRQ==
X-Received: by 2002:a5d:40cf:0:b0:314:1b4d:bb27 with SMTP id b15-20020a5d40cf000000b003141b4dbb27mr4082781wrq.64.1693487550683;
        Thu, 31 Aug 2023 06:12:30 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id a28-20020a5d457c000000b00317f70240afsm2206607wrc.27.2023.08.31.06.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:12:30 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	pulehui@huawei.com,
	conor.dooley@microchip.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v4 0/4] bpf, riscv: use BPF prog pack allocator in BPF JIT
Date: Thu, 31 Aug 2023 13:12:25 +0000
Message-Id: <20230831131229.497941-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Changes in v3 -> v4:
1. Add Acked-by:, Tested-by:, etc.
2. Add the core BPF patch[3] which was earlier sent with ARM64 series to
   this series so it can go with this.

Changes in v2 -> v3:
1. Fix maximum width of code in patches from 80 to 100. [All patches]
2. Add checks for ctx->ro_insns == NULL. [Patch 3]
3. Fix check for edge condition where amount of text to set > 2 * pagesize
   [Patch 1 and 2]
4. Add reviewed-by in patches.
5. Adding results of selftest here:
   Using the command: ./test_progs on qemu
   Without the series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
   With this series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED

Changes in v1 -> v2:
1. Implement a new function patch_text_set_nosync() to be used in bpf_arch_text_invalidate().
   The implementation in v1 called patch_text_nosync() in a loop and it was bad as it would
   call flush_icache_range() for every word making it really slow. This was found by running
   the test_tag selftest which would take forever to complete.

Here is some data to prove the V2 fixes the problem:

Without this series:
root@rv-selftester:~/src/kselftest/bpf# time ./test_tag
test_tag: OK (40945 tests)

real    7m47.562s
user    0m24.145s
sys     6m37.064s

With this series applied:
root@rv-selftester:~/src/selftest/bpf# time ./test_tag
test_tag: OK (40945 tests)

real    7m29.472s
user    0m25.865s
sys     6m18.401s

BPF programs currently consume a page each on RISCV. For systems with many BPF
programs, this adds significant pressure to instruction TLB. High iTLB pressure
usually causes slow down for the whole system.

Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
It packs multiple BPF programs into a single huge page. It is currently only
enabled for the x86_64 BPF JIT.

I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed now.

This patch series enables the BPF prog pack allocator for the RISCV BPF JIT.

======================================================
Performance Analysis of prog pack allocator on RISCV64
======================================================

Test setup:
===========

Host machine: Debian GNU/Linux 11 (bullseye)
Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
u-boot-qemu Version: 2023.07+dfsg-1
opensbi Version: 1.3-1

To test the performance of the BPF prog pack allocator on RV, a stresser
tool[4] linked below was built. This tool loads 8 BPF programs on the system and
triggers 5 of them in an infinite loop by doing system calls.

The runner script starts 20 instances of the above which loads 8*20=160 BPF
programs on the system, 5*20=100 of which are being constantly triggered.
The script is passed a command which would be run in the above environment.

The script was run with following perf command:
./run.sh "perf stat -a \
        -e iTLB-load-misses \
        -e dTLB-load-misses  \
        -e dTLB-store-misses \
        -e instructions \
        --timeout 60000"

The output of the above command is discussed below before and after enabling the
BPF prog pack allocator.

The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The rootfs
was created using Bjorn's riscv-cross-builder[5] docker container linked below.

Results
=======

Before enabling prog pack allocator:
------------------------------------

Performance counter stats for 'system wide':

           4939048      iTLB-load-misses
           5468689      dTLB-load-misses
            465234      dTLB-store-misses
     1441082097998      instructions

      60.045791200 seconds time elapsed

After enabling prog pack allocator:
-----------------------------------

Performance counter stats for 'system wide':

           3430035      iTLB-load-misses
           5008745      dTLB-load-misses
            409944      dTLB-store-misses
     1441535637988      instructions

      60.046296600 seconds time elapsed

Improvements in metrics
=======================

It was expected that the iTLB-load-misses would decrease as now a single huge
page is used to keep all the BPF programs compared to a single page for each
program earlier.

--------------------------------------------
The improvement in iTLB-load-misses: -30.5 %
--------------------------------------------

I repeated this expriment more than 100 times in different setups and the
improvement was always greater than 30%.

This patch series is boot tested on the Starfive VisionFive 2 board[6].
The performance analysis was not done on the board because it doesn't
expose iTLB-load-misses, etc. The stresser program was run on the board to test
the loading and unloading of BPF programs

[1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
[2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12@gmail.com/
[3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gmail.com/
[4] https://github.com/puranjaymohan/BPF-Allocator-Bench
[5] https://github.com/bjoto/riscv-cross-builder
[6] https://www.starfivetech.com/en/site/boards

Puranjay Mohan (4):
  bpf: make bpf_prog_pack allocator portable
  riscv: extend patch_text_nosync() for multiple pages
  riscv: implement a memset like function for text
  bpf, riscv: use prog pack allocator in the BPF JIT

 arch/riscv/include/asm/patch.h  |   1 +
 arch/riscv/kernel/patch.c       | 114 ++++++++++++++++++++++++++++++--
 arch/riscv/net/bpf_jit.h        |   3 +
 arch/riscv/net/bpf_jit_comp64.c |  60 +++++++++++++----
 arch/riscv/net/bpf_jit_core.c   | 106 ++++++++++++++++++++++++-----
 kernel/bpf/core.c               |   8 +--
 6 files changed, 255 insertions(+), 37 deletions(-)

-- 
2.39.2


