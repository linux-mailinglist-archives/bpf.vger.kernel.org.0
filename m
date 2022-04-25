Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E126D50E265
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiDYNzs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 09:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbiDYNzs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 09:55:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267DB63510
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 06:52:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bu29so26370974lfb.0
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=JYHu98gIK66RWLsyi/UBGJk+PCtKY9xPR1oZtGPvB3I=;
        b=la6KljV5Xz628ud2SyGpNqA/tclref6pzZVJuG3oCzMHQv0TIhdBN87IBqwmH0G+Es
         rq1pH250/bRk3/+628l7WXl8atwDIk0uMU0N3dLFvnN0Lwry4DnchI2StKNta8MGkIIY
         8ZsE8lr2N1WAEkaT/BD+HH3ySW5GDnUBHL8Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=JYHu98gIK66RWLsyi/UBGJk+PCtKY9xPR1oZtGPvB3I=;
        b=hQUzSMcsAspNtxWd33lKhjl3XknhHwTgIw8ImRs/4Cqfg1AJoS9sCCRYBuGEFFuZ33
         t/YdQi9xCIdgpPMgYKqYWhibWNh9gMtRdihfo/rNdDiP3pkr9q0UOmhBjTy+erx6KgOT
         N8RXg59RgRPRJa9IOgq95cYGuPvuW42ZZ5bT6CdOjklfEiZ3OBnykWcq0EBoCmIKGW70
         L3hoQRorlBxzVi12+QLiNo/5kFX0UIpZ5knNsbCjNpjkwY5arIwxMwEXwfIMfGFbZPTx
         OgHI/1tvghLqWu1TLf3oRNG2/jZSlSys0eCGHQvoVrsvU4GEaz+aME0tjqalQicxJSat
         oYjA==
X-Gm-Message-State: AOAM532wpquDhdz7rg1FWX9jEv+ApjU/y5GwrbiuCnIbATUdwuaAVG4W
        86ALj8KvL9H4m3f5Atc4KAnULgHlT2nkVg==
X-Google-Smtp-Source: ABdhPJzC86FrJ28jxENyEvz/4wap/hIglCpcOU4IUHrp+HYgN3Ek+hoE021rEKqD1DhT+9S7ymvCZQ==
X-Received: by 2002:a05:6512:114f:b0:471:b097:4a29 with SMTP id m15-20020a056512114f00b00471b0974a29mr13306761lfg.93.1650894761306;
        Mon, 25 Apr 2022 06:52:41 -0700 (PDT)
Received: from cloudflare.com (79.184.126.143.ipv4.supernova.orange.pl. [79.184.126.143])
        by smtp.gmail.com with ESMTPSA id a2-20020a19e302000000b00471988e79cdsm1419395lfh.180.2022.04.25.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:52:40 -0700 (PDT)
References: <4ed4a01e-3d1e-bf1e-803a-608df187bde5@I-love.SAKURA.ne.jp>
 <909c72b6-83f9-69a0-af80-d9cb3bc2bd0e@I-love.SAKURA.ne.jp>
 <CAEf4Bzbugg4dy_2J=cFKYYQEJx-irF-cRZvkkwCx4QQwXm5OpA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: How to disassemble a BPF program?
Date:   Mon, 25 Apr 2022 15:48:26 +0200
In-reply-to: <CAEf4Bzbugg4dy_2J=cFKYYQEJx-irF-cRZvkkwCx4QQwXm5OpA@mail.gmail.com>
Message-ID: <87tuah6ziv.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 20, 2022 at 09:48 AM -07, Andrii Nakryiko wrote:
> On Wed, Apr 20, 2022 at 4:38 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Ping?
>>
>> Since how to fix this "current top five crasher" bug depends on how a kernel
>> socket is created via BPF program, this bug wants help from BPF developers.
>
> If the BPF program is loaded/verified successfully, the easiest way to
> go about this would be to prevent repro from proceeding right after
> successful validation (e.g, do scanf()) and then use bpftool to find
> that program's ID and dump disassembly while that program is in the
> kernel.
>
> $ sudo bpftool prog show
> ...
> 654439: cgroup_skb  tag 6deef7357e7b4530  gpl
>         loaded_at 2022-04-20T06:14:08-0700  uid 0
>         xlated 64B  jited 54B  memlock 4096B
>         pids systemd(1)
>
> $ sudo bpftool prog dump xlat id 654439
>    0: (bf) r6 = r1
>    1: (69) r7 = *(u16 *)(r6 +176)
>    2: (b4) w8 = 0
>    3: (44) w8 |= 2
>    4: (b7) r0 = 1
>    5: (55) if r8 != 0x2 goto pc+1
>    6: (b7) r0 = 0
>    7: (95) exit
>
> Hope that helps. I don't know any tool that allows to disassemble raw
> bytes into BPF assembly. Normally I use llvm-objdump to disassemble
> well-formed BPF ELF files. Not sure if you can wrange llvm-objdump to
> disassemble raw bytes without ELF file itself.

You can disassemble raw BPF binaries with GNU objdump, but the assembly
mnemonics are different:

$ sudo bpftool prog dump xlated id 77
   0: (bf) r6 = r1
   1: (69) r7 = *(u16 *)(r6 +176)
   2: (b4) w8 = 0
   3: (44) w8 |= 2
   4: (b7) r0 = 1
   5: (55) if r8 != 0x2 goto pc+1
   6: (b7) r0 = 0
   7: (95) exit
$ sudo bpftool prog dump xlated id 77 file prog.bin
$ sudo objdump -D -b binary -m bpf prog.bin

prog.bin:     file format binary


Disassembly of section .data:

0000000000000000 <.data>:
   0:   bf 16 00 00 00 00 00 00         mov %r6,%r1
   8:   69 67 b0 00 00 00 00 00         ldxh %r7,[%r6+0xb0]
  10:   b4 08 00 00 00 00 00 00         mov32 %r8,0
  18:   44 08 00 00 02 00 00 00         or32 %r8,2
  20:   b7 00 00 00 01 00 00 00         mov %r0,1
  28:   55 08 01 00 02 00 00 00         jne %r8,2,1
  30:   b7 00 00 00 00 00 00 00         mov %r0,0
  38:   95 00 00 00 00 00 00 00         exit
$
