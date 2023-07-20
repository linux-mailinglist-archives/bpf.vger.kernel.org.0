Return-Path: <bpf+bounces-5491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3C875B36D
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5676C281E6C
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7109118C27;
	Thu, 20 Jul 2023 15:49:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AA918B15
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:49:46 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634DC134;
	Thu, 20 Jul 2023 08:49:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fd0f000f1cso6500985e9.1;
        Thu, 20 Jul 2023 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689868183; x=1690472983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzMa4g2hoWRnrtKiEBOwGs4jBTqhlAFiRuirBCpPB08=;
        b=Jd6GQ803X2qJY8axDRFBnNQApeLwHULaUnzznruB4ISc7Fu0Rc28DXZX7pfTWRBV9v
         BHP4I8llCRIOLAPbaK5lJe7tOkGUr6pGXgkmxdHVy79dwtdv97xuMNkaFAMQDFjC13ja
         A95+7C2qvajV++G0dvGk3dJptW9Tt/QLrh8dTRdGXlPwcTzUyOmTEsz0sQ02CLdprFrr
         nhOPxCtJ9qvrEz2Duwl3v4hihMVc64FG7mogJWqG5mNxljYradPkpUqUbyswtdNFwPv+
         sYK5hlIjrUgIAInka6tK1kb3UaX5QaJj264CMF2qMxTiQBrl62HUWKwAMl5AYGOh8f2d
         sFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868183; x=1690472983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzMa4g2hoWRnrtKiEBOwGs4jBTqhlAFiRuirBCpPB08=;
        b=QJi9M0gW6qLoa+mBkMKTtJYOZ02DyrT/yFcsUQnHlskO4TGNrfGfsZL0TUuOaqro5T
         HJoKM+9topWHdUEy/NQq8OkHj6FopopVPmB4bUTJNg8lz1OcQ69DWeCMPI8Y4iU/LBYJ
         razprM4JH60su12rQLMHJcwXvm3uQXIVdnEddQY6vKhHKkY5csXXu2E4jTX+7AkPI3H0
         Hm8bzXC1kiniO56LjNfXHce5wh1gjxRu6BPixeSIPsvZ8FcLyRP2ABTx6yUwmbKFLIBZ
         pdKNjlZhk/llQJkC34KcsG7Jrwa8f63BxZcEBmbrkAw4jtwxVLESprtweMIIlAPQ0ZwV
         JJSg==
X-Gm-Message-State: ABy/qLa3jCipkPcu+lI7oQkUgpHUIWhsGwDMqh46+YiWHfcAIED6V4BQ
	Ba6Ypac8uZJIXFBlTcVCDv8=
X-Google-Smtp-Source: APBJJlEXFXP6wrCikC4tAfcmBjYqQ5J/lPdj73vtjUWmypWzwMsjtoD8LH8ctgHtCZ9xlQfKtlW2vw==
X-Received: by 2002:a05:600c:2290:b0:3f6:d90:3db with SMTP id 16-20020a05600c229000b003f60d9003dbmr4850758wmf.3.1689868182527;
        Thu, 20 Jul 2023 08:49:42 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-34-244-51-157.eu-west-1.compute.amazonaws.com. [34.244.51.157])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b003fbdd9c72aasm1471021wmm.21.2023.07.20.08.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:49:42 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/2] bpf, riscv: use BPF prog pack allocator in BPF JIT
Date: Thu, 20 Jul 2023 15:49:39 +0000
Message-Id: <20230720154941.1504-1-puranjay12@gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BPF programs currently consume a page each on RISCV. For systems with many BPF
programs, this adds significant pressure to instruction TLB. High iTLB pressure
usually causes slow down for the whole system.

Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
It packs multiple BPF programs into a single huge page. It is currently only
enabled for the x86_64 BPF JIT.

I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed now.

This patch series enables the BPF prog pack allocator for the RISCV BPF JIT.
This series needs a patch[3] from the ARM64 series to work.

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

Puranjay Mohan (2):
  riscv: Extend patch_text_nosync() for multiple pages
  bpf, riscv: use prog pack allocator in the BPF JIT

 arch/riscv/kernel/patch.c       |  29 ++++++--
 arch/riscv/net/bpf_jit.h        |   3 +
 arch/riscv/net/bpf_jit_comp64.c |  56 ++++++++++++---
 arch/riscv/net/bpf_jit_core.c   | 117 +++++++++++++++++++++++++++-----
 4 files changed, 174 insertions(+), 31 deletions(-)

-- 
2.40.1


