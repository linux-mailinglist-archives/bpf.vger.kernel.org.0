Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2954F4AE976
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiBIFqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:46:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiBIFjt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:39:49 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDA3E00FA5E
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:39:46 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id w7so1848704ioj.5
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7W0cQt9HThUE3jY5ROt7eiAKSbhsflMtY8KfKFWyMQ8=;
        b=D1msjIagX0n9ZVWAwPR8pK5GL32HIZ8EaHifOKrrF56Oz3Uo4saAEIEe4Xmtzjpf6J
         U74AFpkihQ6BtqUSqpEJ7x+0105k/iKetYzjCAalzM55mSkwxPvlvkc1bBcaO/HpG1kI
         QeLM4HjVrCsRoWF+7fLgThh9pUszYjLZffHfSv1CBBhkz4UstoSdNaFhkx9dckSq1OYa
         emMGSbHfQfGbO/qpqpnyfxAaCxSQ/eq2hxHfNKQ6i+C7rd3QshDmMe1tG1UKbCz6DKY7
         XSi44DSsJkJtY1NQuEGD9DsMWA1BctwFvrky54aKov6AJyUAwp6AvVlWnRJYKO7Fqtk3
         CKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7W0cQt9HThUE3jY5ROt7eiAKSbhsflMtY8KfKFWyMQ8=;
        b=gN/jagvypgg4jwsOxQ4ZhnTAHZDNN9llFoV+UXp2FFNhiXm8Donaqwz5M/4Nc8NOo4
         vqWw/1FhN96Qntve3Ksbq3A5y1/KHqjIXPSBAH2RNL+YSoGDN3fwt7JGtXrRlS8juO/U
         dmMs4AqXHeuilWFZX699yGoQI+7srb8Mr1eD+1TgqBKZ/KVQq6aX3ibWu0FrwLEK+4TJ
         muDM5AHpyBtRHg68EUtNvLCd9YZcvP65FUVvZanuX9V4APjAWw13PsPuVa2PqxNaXg9f
         Q+clZd54cqDerK6bA7oiet84IU7+kn0l4I7P3PGZKPhDmtwh7zbDucLsHK5Lcmh93QvB
         eR3g==
X-Gm-Message-State: AOAM533mfQGY8+UjO7y9G1DJG0CIRalJ9EdpFyScK7eWNdKKZy/qIqul
        8lS735YAPxEc75K0iYZZXbIxt/Vmvbh1JJN++zMMtUEu
X-Google-Smtp-Source: ABdhPJyyobuUorlnGoC5J1HtxpZBKpYNIOAZUcWQRLcocXAf/cmFE3i19ztmqFGmF9nt8tsPy4PqiVFR4XM37eiZuhk=
X-Received: by 2002:a05:6602:2d86:: with SMTP id k6mr354760iow.79.1644385175247;
 Tue, 08 Feb 2022 21:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20220209021745.2215452-1-iii@linux.ibm.com>
In-Reply-To: <20220209021745.2215452-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 21:39:23 -0800
Message-ID: <CAEf4Bzaa9NZfQ_rbaineqvHd-9+So2gU2ckH4p7ojruCbrdM6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/10] Fix accessing syscall arguments
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 8, 2022 at 6:17 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> libbpf now has macros to access syscall arguments in an
> architecture-agnostic manner, but unfortunately they have a number of
> issues on non-Intel arches, which this series aims to fix.
>
> v1: https://lore.kernel.org/bpf/20220201234200.1836443-1-iii@linux.ibm.com/
> v1 -> v2:
> * Put orig_gpr2 in place of args[1] on s390 (Vasily).
> * Fix arm64, powerpc and riscv (Heiko).
>
> v2: https://lore.kernel.org/bpf/20220204041955.1958263-1-iii@linux.ibm.com/
> v2 -> v3:
> * Undo args[1] change (Andrii).
> * Rename PT_REGS_SYSCALL to PT_REGS_SYSCALL_REGS (Andrii).
> * Split the riscv patch (Andrii).
>
> v3: https://lore.kernel.org/bpf/20220204145018.1983773-1-iii@linux.ibm.com/
> v3 -> v4:
> * Undo arm64's and s390's user_pt_regs changes.
> * Use struct pt_regs when vmlinux.h is available (Andrii).
> * Use offsetofend for accessing orig_gpr2 and orig_x0 (Andrii).
> * Move libbpf's copy of offsetofend to a new header.
> * Fix riscv's __PT_FP_REG.
> * Use PT_REGS_SYSCALL_REGS in test_probe_user.c.
> * Test bpf_syscall_macro with userspace headers.
> * Use Naveen's suggestions and code in patches 5 and 6.
> * Add warnings to arm64's and s390's ptrace.h (Andrii).
>
> v4: https://lore.kernel.org/bpf/20220208051635.2160304-1-iii@linux.ibm.com/
> v4 -> v5:
> * Go back to v3.
> * Do not touch arch headers.
> * Use CO-RE struct flavors to access orig_x0 and orig_gpr2.
> * Fail compilation if non-CO-RE macros are used to access the first
>   syscall parameter on arm64 and s390.
> * Fix accessing frame pointer on riscv.
>
> Ilya Leoshkevich (10):
>   selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
>   libbpf: Add PT_REGS_SYSCALL_REGS macro
>   selftests/bpf: Use PT_REGS_SYSCALL_REGS in bpf_syscall_macro
>   libbpf: Fix accessing syscall arguments on powerpc
>   libbpf: Fix riscv register names
>   libbpf: Fix accessing syscall arguments on riscv
>   selftests/bpf: Skip test_bpf_syscall_macro:syscall_arg1 on arm64 and
>     s390
>   libbpf: Allow overriding PT_REGS_PARM1{_CORE}_SYSCALL
>   libbpf: Fix accessing the first syscall argument on arm64
>   libbpf: Fix accessing the first syscall argument on s390
>

Applied to bpf-next with few adjustments in patches 8-10, thanks. I'll
sync all this to Github shortly to run it through s390x CI tests as
well.

>  tools/lib/bpf/bpf_tracing.h                   | 42 ++++++++++++++++++-
>  .../bpf/prog_tests/test_bpf_syscall_macro.c   |  4 ++
>  .../selftests/bpf/progs/bpf_syscall_macro.c   |  9 +++-
>  3 files changed, 51 insertions(+), 4 deletions(-)
>
> --
> 2.34.1
>
