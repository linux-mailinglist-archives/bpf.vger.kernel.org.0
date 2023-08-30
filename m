Return-Path: <bpf+bounces-8988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0AE78D65A
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571902811B9
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539C63CE;
	Wed, 30 Aug 2023 13:54:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D095679
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 13:54:07 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3256FE8
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:54:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a9b41ffe12so3387469b6e.3
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1693403644; x=1694008444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzdL99VC81Ou2F+ipwGBRnVl4uI3qfhrxRwx9w/Xgbk=;
        b=TfGaljLUuH+otKUMWuvJHU8icpesgbE9AX8nNIt70Yoco8xBiFWEYQeJ/JNMibGj6O
         x+WLb/Q7XGfsqomsFCzORisgnNy7g6D8tJM6rypLSJdgw34Q+7KRr4+1VMOQNG3SIgAY
         oe03Gg7eYcYtMs0DNCQxwjetmv1CZ8UqeoZ47XXag/a+QoyiiSmsT+y2fOj44+2zMyRD
         VYHqU/wrb99ZXxMkq+qayFK5X8vIcKSYOt+YCQ1nOp9qNaeRXceSLYTPGF1kTdpossul
         F+vn7Se4BxHBFBvVOj8t/Qk+W2b7Rk1WWp4Dqdf+grhdhnvkABQIYSIFN+EGu+mcWSx4
         qYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403644; x=1694008444;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzdL99VC81Ou2F+ipwGBRnVl4uI3qfhrxRwx9w/Xgbk=;
        b=hOBC4vvawtrunH30I19hxI4EULEq6AJMkrimd0Pvtk6WAM3ZADtnReZJ7Vv7DBE9hj
         RFw/CiYMhSaG98dKcDRhl5qFBh3seYXkwlfh9nypFyQlhKq+rKnDL6gRfbGWgnm61/vw
         sjbdpd1P5cUibYC0Z1xJB4Wfdsf+yAum1i4XDbjkcDY38oC9tW62jkXPdTRbVChyvPUJ
         oiRB4K5q3ycT9OZsH0NgUGWiPKbtYzy76M8a4l00FniMWbnl9UEcks8xmge3NImE1tLR
         g+f079OE+vb0bdYyC2vdGBF/88HeCYDJO68PbuihMUoLV47Tdddx+czEya+srs0/dWrh
         PjVQ==
X-Gm-Message-State: AOJu0Yw+LDr4B6JPXbldBtTIXHMJEIJYcXPy4GZvE/x+kGyOu87X03iA
	c9dGTIyRQOQQibL+vav4fUGfPQ==
X-Google-Smtp-Source: AGHT+IE4tkQFsFo3Pg17fUm5h2kmeambb/plImzXvc1WYiKRFwqpDv7t527ulUERQBi8+9y9g8Lu0w==
X-Received: by 2002:a05:6808:1156:b0:3a1:dd99:8158 with SMTP id u22-20020a056808115600b003a1dd998158mr2670079oiu.6.1693403644405;
        Wed, 30 Aug 2023 06:54:04 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id p25-20020aa78619000000b00686b649cdd0sm10150171pfn.86.2023.08.30.06.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:54:03 -0700 (PDT)
Date: Wed, 30 Aug 2023 06:54:03 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Aug 2023 06:54:01 PDT (-0700)
Subject:     Re: [PATCH bpf-next v3 0/3] bpf, riscv: use BPF prog pack allocator in BPF JIT
In-Reply-To: <9ab91c63-0712-d2d8-9b2b-6f2098287baa@iogearbox.net>
CC: bjorn@kernel.org, puranjay12@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, pulehui@huawei.com, Conor Dooley <conor.dooley@microchip.com>, ast@kernel.org,
  andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
  bpf@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: daniel@iogearbox.net
Message-ID: <mhng-ac1c6e6a-8f27-4539-83bb-6c10ff4d264e@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 30 Aug 2023 01:18:46 PDT (-0700), daniel@iogearbox.net wrote:
> On 8/29/23 12:06 PM, Björn Töpel wrote:
>> Puranjay Mohan <puranjay12@gmail.com> writes:
>>
>>> Changes in v2 -> v3:
>>> 1. Fix maximum width of code in patches from 80 to 100. [All patches]
>>> 2. Add checks for ctx->ro_insns == NULL. [Patch 3]
>>> 3. Fix check for edge condition where amount of text to set > 2 * pagesize
>>>     [Patch 1 and 2]
>>> 4. Add reviewed-by in patches.
>>> 5. Adding results of selftest here:
>>>     Using the command: ./test_progs on qemu
>>>     Without the series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>>     With this series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>>
>>> Changes in v1 -> v2:
>>> 1. Implement a new function patch_text_set_nosync() to be used in bpf_arch_text_invalidate().
>>>     The implementation in v1 called patch_text_nosync() in a loop and it was bad as it would
>>>     call flush_icache_range() for every word making it really slow. This was found by running
>>>     the test_tag selftest which would take forever to complete.
>>>
>>> Here is some data to prove the V2 fixes the problem:
>>>
>>> Without this series:
>>> root@rv-selftester:~/src/kselftest/bpf# time ./test_tag
>>> test_tag: OK (40945 tests)
>>>
>>> real    7m47.562s
>>> user    0m24.145s
>>> sys     6m37.064s
>>>
>>> With this series applied:
>>> root@rv-selftester:~/src/selftest/bpf# time ./test_tag
>>> test_tag: OK (40945 tests)
>>>
>>> real    7m29.472s
>>> user    0m25.865s
>>> sys     6m18.401s
>>>
>>> BPF programs currently consume a page each on RISCV. For systems with many BPF
>>> programs, this adds significant pressure to instruction TLB. High iTLB pressure
>>> usually causes slow down for the whole system.
>>>
>>> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
>>> It packs multiple BPF programs into a single huge page. It is currently only
>>> enabled for the x86_64 BPF JIT.
>>>
>>> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed now.
>>>
>>> This patch series enables the BPF prog pack allocator for the RISCV BPF JIT.
>>> This series needs a patch[3] from the ARM64 series to work.
>>>
>>> ======================================================
>>> Performance Analysis of prog pack allocator on RISCV64
>>> ======================================================
>>>
>>> Test setup:
>>> ===========
>>>
>>> Host machine: Debian GNU/Linux 11 (bullseye)
>>> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
>>> u-boot-qemu Version: 2023.07+dfsg-1
>>> opensbi Version: 1.3-1
>>>
>>> To test the performance of the BPF prog pack allocator on RV, a stresser
>>> tool[4] linked below was built. This tool loads 8 BPF programs on the system and
>>> triggers 5 of them in an infinite loop by doing system calls.
>>>
>>> The runner script starts 20 instances of the above which loads 8*20=160 BPF
>>> programs on the system, 5*20=100 of which are being constantly triggered.
>>> The script is passed a command which would be run in the above environment.
>>>
>>> The script was run with following perf command:
>>> ./run.sh "perf stat -a \
>>>          -e iTLB-load-misses \
>>>          -e dTLB-load-misses  \
>>>          -e dTLB-store-misses \
>>>          -e instructions \
>>>          --timeout 60000"
>>>
>>> The output of the above command is discussed below before and after enabling the
>>> BPF prog pack allocator.
>>>
>>> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The rootfs
>>> was created using Bjorn's riscv-cross-builder[5] docker container linked below.
>>>
>>> Results
>>> =======
>>>
>>> Before enabling prog pack allocator:
>>> ------------------------------------
>>>
>>> Performance counter stats for 'system wide':
>>>
>>>             4939048      iTLB-load-misses
>>>             5468689      dTLB-load-misses
>>>              465234      dTLB-store-misses
>>>       1441082097998      instructions
>>>
>>>        60.045791200 seconds time elapsed
>>>
>>> After enabling prog pack allocator:
>>> -----------------------------------
>>>
>>> Performance counter stats for 'system wide':
>>>
>>>             3430035      iTLB-load-misses
>>>             5008745      dTLB-load-misses
>>>              409944      dTLB-store-misses
>>>       1441535637988      instructions
>>>
>>>        60.046296600 seconds time elapsed
>>>
>>> Improvements in metrics
>>> =======================
>>>
>>> It was expected that the iTLB-load-misses would decrease as now a single huge
>>> page is used to keep all the BPF programs compared to a single page for each
>>> program earlier.
>>>
>>> --------------------------------------------
>>> The improvement in iTLB-load-misses: -30.5 %
>>> --------------------------------------------
>>>
>>> I repeated this expriment more than 100 times in different setups and the
>>> improvement was always greater than 30%.
>>>
>>> This patch series is boot tested on the Starfive VisionFive 2 board[6].
>>> The performance analysis was not done on the board because it doesn't
>>> expose iTLB-load-misses, etc. The stresser program was run on the board to test
>>> the loading and unloading of BPF programs
>>>
>>> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
>>> [2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12@gmail.com/
>>> [3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gmail.com/
>>> [4] https://github.com/puranjaymohan/BPF-Allocator-Bench
>>> [5] https://github.com/bjoto/riscv-cross-builder
>>> [6] https://www.starfivetech.com/en/site/boards
>>>
>>> Puranjay Mohan (3):
>>>    riscv: extend patch_text_nosync() for multiple pages
>>>    riscv: implement a memset like function for text
>>>    bpf, riscv: use prog pack allocator in the BPF JIT
>>
>> Thank you! For the series:
>>
>> Acked-by: Björn Töpel <bjorn@kernel.org>
>> Tested-by: Björn Töpel <bjorn@rivosinc.com>
>>
>> @Alexei @Daniel This series depends on a core BPF patch from the Arm
>>                  series [3].
>>
>> @Palmer LMK if you have any concerns taking the RISC-V text patching
>>          stuff via the BPF tree.
>
> Palmer, did the riscv PR already go to Linus?

Not yet, I usually send on Friday mornings -- and I also generally send 
two, as there's some stragglers/fixes for the second week.  I'm fine 
taking it (Bjorn just poked me), can someone provide a base commit?  
Bjorn says it depends on something in Linus' tree, so I'll just pick it 
up as a straggler for next week.

Also, do you mind sending an Ack?

> If not yet, perhaps you could ship this series along with your PR to Linus
> during this merge window given the big net PR (incl. bpf) was already merged
> yesterday. So from our side only fixes ship to Linus.
>
> Otherwise we could take it into bpf-next for the next dev cycle if there are
> no objections, let us know.
>
> Thanks,
> Daniel

