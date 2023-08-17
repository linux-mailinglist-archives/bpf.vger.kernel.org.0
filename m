Return-Path: <bpf+bounces-8009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CC677FD45
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 19:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07D6282102
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEFD171D7;
	Thu, 17 Aug 2023 17:52:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D64914AA6
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 17:52:27 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BE42713
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 10:52:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26b4c6a5e61so44431a91.1
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1692294743; x=1692899543;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zd60Bn/5JBDDf1PePrTmr3XNCyuBtOqz/7iIY4IJ/Ow=;
        b=wK3ghD89+IBr/mkkaYVoiWCNGzzzcY01ySvztEZtt5+ObZX8U4qS4cQq091AQ70y5U
         4/ueIPt6xEci+dA+eA75VNVXQq3Y9lxsVjl0epnefgyxlrcc5x9wE/Max3YKEDNNppce
         V++/xv7cnCJOXGBmfrqW+itKiQMACHOyePNVdtfdZ2gM3hnoQq2no/cExu02Bx+035FW
         Zm+b7RdwQpdJ/gxzY4kxVIj3jbldzdZH1ynKjP2beMvCmFyxo1u6wcC/bv56hrRHAxf4
         Wm4XgrgqskCP8Fg1SSMQfBW8ek66Ycn20wh3sMhZw119ihI8GxJOg4nz+SRpz4+BV3d5
         imWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294743; x=1692899543;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd60Bn/5JBDDf1PePrTmr3XNCyuBtOqz/7iIY4IJ/Ow=;
        b=f2o+HGBuXy4n2t2eCPfzOsh2AQ5I4+JPUSd2IPJTxjNvZOqKiyNDVWVt6rqruyNVrD
         zKoNPcbibPrUZ2Cg9jP9xlQmmO0gspBBIuM0YZZr8C3rLSobgQcjZJ10uqwMxr2rXLNm
         +50bLFNhq7bs1lKjOCdcY+I+Sjb0aaaPA3qKYTU42jRoVcRk6DDvWS1nL+YZDcdWluGp
         9+EENDv+M2GslocjJI+NrxT5pg7irkutsfTLmdtNx0OQOutDo8DbqHEVXLclv49EGFQ1
         /1pPIPc0JEFUHKU/umaxqhptKPI+PS3faU0lY3GsSL4CjZOa9WSjCmFvEj5MeJkXdRBf
         9NwQ==
X-Gm-Message-State: AOJu0Yy5eUaqKV1rpNBt1Qg3VvRqCKduJhM6Ey/38X3y3A/o/Z3j4g4P
	68VKX84W912bTuUo4ccjhMk4Mw==
X-Google-Smtp-Source: AGHT+IHPap/kvoZVf0w/bUJ4sSEjuyPBqEP/zyddNY09QjyyV3I66pXydHQJn4DZ/DEBwFQdByVQ3Q==
X-Received: by 2002:a17:90b:38c4:b0:26d:227c:9068 with SMTP id nn4-20020a17090b38c400b0026d227c9068mr137111pjb.16.1692294743196;
        Thu, 17 Aug 2023 10:52:23 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090a648500b0026971450601sm83767pjj.7.2023.08.17.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:52:22 -0700 (PDT)
Date: Thu, 17 Aug 2023 10:52:22 -0700 (PDT)
X-Google-Original-Date: Thu, 17 Aug 2023 10:52:21 PDT (-0700)
Subject:     Re: [PATCH 00/10] RISC-V: Refactor instructions
In-Reply-To: <ZN5OJO/xOWUjLK2w@ghost>
CC: jrtc27@jrtc27.com, ajones@ventanamicro.com, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, bpf@vger.kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, peterz@infradead.org, jpoimboe@kernel.org,
  jbaron@akamai.com, rostedt@goodmis.org, Ard Biesheuvel <ardb@kernel.org>, anup@brainfault.org,
  atishp@atishpatra.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
  song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
  haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org, luke.r.nels@gmail.com, xi.wang@gmail.com,
  namcaov@gmail.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Message-ID: <mhng-7d609dde-ad47-42ed-a47b-6206e719020a@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 17 Aug 2023 09:43:16 PDT (-0700), Charlie Jenkins wrote:
> On Thu, Aug 17, 2023 at 05:05:45AM +0100, Jessica Clarke wrote:
>> On 17 Aug 2023, at 04:57, Jessica Clarke <jrtc27@jrtc27.com> wrote:
>> >
>> > On 17 Aug 2023, at 01:31, Charlie Jenkins <charlie@rivosinc.com> wrote:
>> >>
>> >> On Fri, Aug 04, 2023 at 10:24:33AM -0700, Charlie Jenkins wrote:
>> >>> On Fri, Aug 04, 2023 at 12:28:28PM +0300, Andrew Jones wrote:
>> >>>> On Thu, Aug 03, 2023 at 07:10:25PM -0700, Charlie Jenkins wrote:
>> >>>>> There are numerous systems in the kernel that rely on directly
>> >>>>> modifying, creating, and reading instructions. Many of these systems
>> >>>>> have rewritten code to do this. This patch will delegate all instruction
>> >>>>> handling into insn.h and reg.h. All of the compressed instructions, RVI,
>> >>>>> Zicsr, M, A instructions are included, as well as a subset of the F,D,Q
>> >>>>> extensions.
>> >>>>>
>> >>>>> ---
>> >>>>> This is modifying code that https://lore.kernel.org/lkml/20230731183925.152145-1-namcaov@gmail.com/
>> >>>>> is also touching.
>> >>>>>
>> >>>>> ---
>> >>>>> Testing:
>> >>>>>
>> >>>>> There are a lot of subsystems touched and I have not tested every
>> >>>>> individual instruction. I did a lot of copy-pasting from the RISC-V spec
>> >>>>> so opcodes and such should be correct
>> >>>>
>> >>>> How about we create macros which generate each of the functions an
>> >>>> instruction needs, e.g. riscv_insn_is_*(), etc. based on the output of
>> >>>> [1]. I know basically nothing about that project, but it looks like it
>> >>>> creates most the defines this series is creating from what we [hope] to
>> >>>> be an authoritative source. I also assume that if we don't like the
>> >>>> current output format, then we could probably post patches to the project
>> >>>> to get the format we want. For example, we could maybe propose an "lc"
>> >>>> format for "Linux C".
>> >>> That's a great idea, I didn't realize that existed!
>> >> I have discovered that the riscv-opcodes repository is not in a state
>> >> that makes it helpful. If it were workable, it would make it easy to
>> >> include a "Linux C" format. I have had a pull request open on the repo
>> >> for two weeks now and the person who maintains the repo has not
>> >> interacted.
>> >
>> > Huh? Andrew has replied to you twice on your PR, and was the last one to
>> > comment. That’s hardly “has not interacted”.
>> >
> I should have been more clear because Andrew was very responsive.
> However, Neel Gala appears to be the "maintainer" in the sense that
> Andrew defers what gets merged into the repo to him. Neel has not
> provided any feedback, and he needs to comment before Andrew will merge
> anything in.
>> >> At minimum, in order for it to be useful it would need an ability to
>> >> describe the bit order of immediates in an instruction and include script
>> >> arguments to select which instructions should be included. There is a
>> >> "C" format, but it is actually just a Spike format.
>> >
>> > So extend it? Or do something with QEMU’s equivalent that expresses it.
> Yes, that is a possibility. To my knowledge GCC and the spec generator
> have moved away from using this repo. Is it still used by QEMU?
>>
>> Note that every field already identifies the bit order (or, for the
>> case of compressed instructions, register restrictions) since that’s
>> needed to produce the old LaTeX instruction set listings; that’s why
>> there’s jimm20 vs imm20, for example. One could surely encode that in
>> Python and generate the LaTeX strings from the Python, making the
>> details of the encodings available elsewhere. Or just have your own
>> mapping from name to whatever you need. But, either way, the
>> information should all be there today in the input files, it’s just a
>> matter of extending the script to produce whatever you want from them.
> All of the LaTeX bit orders were hardcoded in strings. As such, the bit
> order is described for the LaTeX format but not in general. It would not
> make sense to hardcode them a second time for the output of the Linux
> generation. You can see the strings by searching for 'latex_mapping' in
> the constants.py file.
>
> It seems to me that it will be significantly more challenging to use
> riscv-opcodes than it would for people to just hand create the macros
> that they need.

Ya, riscv-opcodes is pretty custy.  We stopped using it elsewhere ages 
ago.

> - Charlie
>>
>> > Jess
>> >
>> >> Nonetheless, it
>> >> seems like it is prohibitive to use it.
>> >>>>
>> >>>> I'd also recommend only importing the generated defines and generating
>> >>>> the functions that will actually have immediate consumers or are part of
>> >>>> a set of defines that have immediate consumers. Each consumer of new
>> >>>> instructions will be responsible for generating and importing the defines
>> >>>> and adding the respective macro invocations to generate the functions.
>> >>>> This series can also take that approach, i.e. convert one set of
>> >>>> instructions at a time, each in a separate patch.
>> >>> Since I was hand-writing everything and copying it wasn't too much
>> >>> effort to just copy all of the instructions from a group. However, from
>> >>> a testing standpoint it makes sense to exclude instructions not yet in
>> >>> use.
>> >>>>
>> >>>> [1] https://github.com/riscv/riscv-opcodes
>> >>>>
>> >>>> Thanks,
>> >>>> drew
>> >>>>
>> >>>>
>> >>>>> , but the construction of every
>> >>>>> instruction is not fully tested.
>> >>>>>
>> >>>>> vector: Compiled and booted
>> >>>>>
>> >>>>> jump_label: Ensured static keys function as expected.
>> >>>>>
>> >>>>> kgdb: Attempted to run the provided tests but they failed even without
>> >>>>> my changes
>> >>>>>
>> >>>>> module: Loaded and unloaded modules
>> >>>>>
>> >>>>> patch.c: Ensured kernel booted
>> >>>>>
>> >>>>> kprobes: Used a kprobing module to probe jalr, auipc, and branch
>> >>>>> instructions
>> >>>>>
>> >>>>> nommu misaligned addresses: Kernel boots
>> >>>>>
>> >>>>> kvm: Ran KVM selftests
>> >>>>>
>> >>>>> bpf: Kernel boots. Most of the instructions are exclusively used by BPF
>> >>>>> but I am unsure of the best way of testing BPF.
>> >>>>>
>> >>>>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> >>>>>
>> >>>>> ---
>> >>>>> Charlie Jenkins (10):
>> >>>>>     RISC-V: Expand instruction definitions
>> >>>>>     RISC-V: vector: Refactor instructions
>> >>>>>     RISC-V: Refactor jump label instructions
>> >>>>>     RISC-V: KGDB: Refactor instructions
>> >>>>>     RISC-V: module: Refactor instructions
>> >>>>>     RISC-V: Refactor patch instructions
>> >>>>>     RISC-V: nommu: Refactor instructions
>> >>>>>     RISC-V: kvm: Refactor instructions
>> >>>>>     RISC-V: bpf: Refactor instructions
>> >>>>>     RISC-V: Refactor bug and traps instructions
>> >>>>>
>> >>>>> arch/riscv/include/asm/bug.h             |   18 +-
>> >>>>> arch/riscv/include/asm/insn.h            | 2744 +++++++++++++++++++++++++++---
>> >>>>> arch/riscv/include/asm/reg.h             |   88 +
>> >>>>> arch/riscv/kernel/jump_label.c           |   13 +-
>> >>>>> arch/riscv/kernel/kgdb.c                 |   13 +-
>> >>>>> arch/riscv/kernel/module.c               |   80 +-
>> >>>>> arch/riscv/kernel/patch.c                |    3 +-
>> >>>>> arch/riscv/kernel/probes/kprobes.c       |   13 +-
>> >>>>> arch/riscv/kernel/probes/simulate-insn.c |  100 +-
>> >>>>> arch/riscv/kernel/probes/uprobes.c       |    5 +-
>> >>>>> arch/riscv/kernel/traps.c                |    9 +-
>> >>>>> arch/riscv/kernel/traps_misaligned.c     |  218 +--
>> >>>>> arch/riscv/kernel/vector.c               |    5 +-
>> >>>>> arch/riscv/kvm/vcpu_insn.c               |  281 +--
>> >>>>> arch/riscv/net/bpf_jit.h                 |  707 +-------
>> >>>>> 15 files changed, 2825 insertions(+), 1472 deletions(-)
>> >>>>> ---
>> >>>>> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
>> >>>>> change-id: 20230801-master-refactor-instructions-v4-433aa040da03
>> >>>>> --
>> >>>>> - Charlie
>> >>>>>
>> >>>>>
>> >>>>> --
>> >>>>> kvm-riscv mailing list
>> >>>>> kvm-riscv@lists.infradead.org
>> >>>>> http://lists.infradead.org/mailman/listinfo/kvm-riscv
>> >>
>> >> _______________________________________________
>> >> linux-riscv mailing list
>> >> linux-riscv@lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>>

