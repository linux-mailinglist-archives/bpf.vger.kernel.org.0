Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446AF6914C7
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 00:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBIXlL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 18:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBIXku (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 18:40:50 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499076F229
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 15:40:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v13so3464261eda.11
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 15:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0rtpopZ5BUM5l+eEwG7RpPWvG8/E9dJxdLW6NIsomwk=;
        b=kpC7iZSehZRaZFdsaIx+09g19LqZrutUl+7JSlHVW78bTCJFlSxL3m1ANItQ7HFJ4U
         7DdcTuDlPgJAk6P3CPqijADJXv5/LtLIezFNMIQyIFOVRDQSZijIhDuQ7ZQjOruU+deK
         IwfMuOupFsajECyAxfjCts5z82yoPB6+3SiEuUucNRH77Ikkt5gnDvv28es4VLYYYhDt
         ZAhUsy/H3KoSYvR/PGHJnPhFvIuuYEw24ZZO/j9T5MdgcXWrT/rLng/YUkbQg01Rqfip
         xdIoK0e29O9a9OwV8wd5AM0kRCf4OXNKqVgjUQ75vMRJGrWyBjJAcPcUKidargA+P5RZ
         s+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rtpopZ5BUM5l+eEwG7RpPWvG8/E9dJxdLW6NIsomwk=;
        b=yV70ArihciMQ9bgeI/Ie7lYUvMV6alEbZEflAW3t8d+PyluPcsF20Vc2NDPQGaiBTS
         lHc+DDFvsVqL1TwXeI6MdcwzgzBq/F6WR1JYnbTBgh0FYYpWA5WQg8TysrqLC8nLiupP
         z51DWxo6aAKqJox59odyINLpcvnGl5VlK6f4d8Ea5IYHADnIoOa8wfK5f07th90REoMQ
         90txX2dKy37rJmOYSCHC4nYx7KNUKSovw/uAX0J+Si7VNE/fg9/T7YS4gzTUB23U6Vyv
         7m14T7z/g4AJNdgiBcqxTW7htU08YkoM84SR42b7zeDdNlF96fi2TrHpDtjFLEwQqnna
         Xs+A==
X-Gm-Message-State: AO0yUKUb3ov07xZiPm8CylM7qTdppojmp0InjzyCjNuWIiEP9yt59Y01
        MMjWsp9xBuHJkivjqwJLiQ5t8koKZ3LmM9MobbM=
X-Google-Smtp-Source: AK7set+/63UBrsAjG/3UEnKhzk0UQ5P0YXPb2JAr69H2MVWXWhNdxxIPyvEctZBcG3v06mGpapTdNkDX/yvJhpuWhHc=
X-Received: by 2002:a50:f61e:0:b0:4ab:168c:dbd7 with SMTP id
 c30-20020a50f61e000000b004ab168cdbd7mr1254790edn.5.1675985995339; Thu, 09 Feb
 2023 15:39:55 -0800 (PST)
MIME-Version: 1.0
References: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
In-Reply-To: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Feb 2023 15:39:43 -0800
Message-ID: <CAEf4BzZwTGWWvhMgNvNqrA0MurMeczok4Jz5dMWrvfKT2avPrw@mail.gmail.com>
Subject: Re: bpf: Propose some new instructions for -mcpu=v4
To:     Yonghong Song <yhs@meta.com>
Cc:     alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 9, 2023 at 2:55 PM Yonghong Song <yhs@meta.com> wrote:
>
> Over the past, there are some discussions to extend bpf
> instruction ISA to accommodate some new use cases or
> fix some potential issues. These new instructions will
> be included in new cpu flavor -mcpu=v4.
>
> The following are the proposal
> to add new instructions in 6 different categories.
> The proposal is a little bit rough. You can find bpf insn
> background information in Documentation/bpf/instruction-set.rst.
> You comments or suggestions are welcome!
>

Great that we are trying to fix and complete the instruction set! Just
one comment/question below for condition jumps.

[...]

>
> 32-bit JA
> =========
>
> Currently, the whole range of operations with BPF_JMP32/BPF_JMP insn are
> implemented like below
>
>    ========  =====  =========================  ============
>    code      value  description                notes
>    ========  =====  =========================  ============
>    BPF_JA    0x00   PC += off                  BPF_JMP only
>    BPF_JEQ   0x10   PC += off if dst == src
>    BPF_JGT   0x20   PC += off if dst > src     unsigned
>    BPF_JGE   0x30   PC += off if dst >= src    unsigned
>    BPF_JSET  0x40   PC += off if dst & src
>    BPF_JNE   0x50   PC += off if dst != src
>    BPF_JSGT  0x60   PC += off if dst > src     signed
>    BPF_JSGE  0x70   PC += off if dst >= src    signed
>    BPF_CALL  0x80   function call
>    BPF_EXIT  0x90   function / program return  BPF_JMP only
>    BPF_JLT   0xa0   PC += off if dst < src     unsigned
>    BPF_JLE   0xb0   PC += off if dst <= src    unsigned
>    BPF_JSLT  0xc0   PC += off if dst < src     signed
>    BPF_JSLE  0xd0   PC += off if dst <= src    signed
>    ========  =====  =========================  ============
>
> Here the 'off' is 16 bit so the range of jump is [-32768, 32767].
> In rare cases, people may have large programs or have loops fully unrolled.
> This may cause some jump offset beyond the above range. In current
> llvm implementation, wrong code (after truncation) will be generated.
>
> To fix this issue, the following new insn is proposed
>
>    ========  =====  =========================  ============
>    code      value  description                notes
>    ========  =====  =========================  ============
>    BPF_JA    0x00   PC += imm                  BPF_JMP32 only, src = 1
>
> The way, the jump offset range become [-2^31, 2^31 - 1].
>
> For other jump instructions, e.g., BPF_JEQ, with a jmp offset
> beyond [-32768, 32767]. It can be simulated with a
> 'BPF_JA (PC += imm)' followed by the original
> BPF_JEQ with the range 'off', or BPF_JEQ with a short range followed
> by a BPF_JA.

Why not implement the same approach (using imm if src = 1) for all the
conditional jumps? Just too much JIT work or some other reasons?

[...]
