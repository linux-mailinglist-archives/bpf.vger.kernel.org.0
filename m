Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF09594EAB
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 04:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiHPC3N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 22:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiHPC27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 22:28:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F480275D29
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 15:44:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y3so11306605eda.6
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rE5TlL3kRdCsdXmb2ZTPuJSYCWTpaiWP/K767qlrkBE=;
        b=qlAo+c7prfUjQ1i7z+T4oLchZZFSbJ51b9r9NIlIcgbIolarTotlYr5TwQ8muUWhSs
         buMEVSRH1LiegvwnU9SFpVJYwcLDCMbMJWu65wYgGCHTVhPINmGNimkqJ/yvXAiiYd8E
         ynnaVsX9oHWWMIvLDCrBuqu02zXxDGk2q/2h8gRc50x1syLzAGIIgRu9kl74SM0H/Rch
         sCWSYVbnrVuVPUCvyhbptL4nkMgQgxR9suQ5czY90HaFOnxXvuJ+4qVkPXrWP1X9dySU
         XZqnEQQ+cGesCbr6LX88/++2zI9aRpbWG2CEd0h+rRHDEcPYNxyPlejG5lJTbNfobq7n
         8XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rE5TlL3kRdCsdXmb2ZTPuJSYCWTpaiWP/K767qlrkBE=;
        b=uhDAI6UF433CMXMokac3xLuPXm4iPv5OqYKm05Gugq4/qCaq/8a3icGoYsPTxhydSz
         XTdvwcGn/mMQ4ooLRdfsMUzP/f0o7VNRXYobYAvfhxshhPPxt7ru7gqMTQYIePlX90Ea
         oLgVRxTJ+e2+63tHfuliNlld3SUnqfS9gfzoqDLuY8HnDPeL+7o3MozDqqIH7ApZXmb4
         9TlCtNsCPV+QnSDnnM7BmBueD6OmzLdiP8CpJ1RyCMhajjdS1IQeeeFrrvGZsk4Z0jgz
         GU4kMdKbjMNfHf061GV3gmUVyvft7CiY0U+lVq3TsAMmW8nqjpz019b8jEnNvZdQy+ZM
         9jHg==
X-Gm-Message-State: ACgBeo1kyvR0wrKF7o9OOSoWyGW/jk1U6wrtVmRtkbsWeIi5EtmPe+qB
        7Clh+Z2p+TB8+TpbbYFPZiPTSw4noOOce+W5MIo=
X-Google-Smtp-Source: AA6agR6T/XZFxPLW1Q5xpVt3crdOc+jogI0hNmmTg4P2VpW3kTg44Bl0h9OUPw7g6v5haCTY3Usw1UuaxmQ8LS5421M=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr16653885edb.333.1660603454567; Mon, 15
 Aug 2022 15:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220812052419.520522-1-yhs@fb.com> <20220812052435.523068-1-yhs@fb.com>
In-Reply-To: <20220812052435.523068-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 15 Aug 2022 15:44:02 -0700
Message-ID: <CAADnVQKvtxdSo3chBeGtv8KsoQ8drrpa7x=1sOem1kwYKr5iRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct arguments
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Thu, Aug 11, 2022 at 10:24 PM Yonghong Song <yhs@fb.com> wrote:
>
> In C, struct value can be passed as a function argument.
> For small structs, struct value may be passed in
> one or more registers. For trampoline based bpf programs,
> This would cause complication since one-to-one mapping between
> function argument and arch argument register is not valid
> any more.
>
> To support struct value argument and make bpf programs
> easy to write, the bpf program function parameter is
> changed from struct type to a pointer to struct type.
> The following is a simplified example.
>
> In one of later selftests, we have a bpf_testmod function:
>     struct bpf_testmod_struct_arg_2 {
>         long a;
>         long b;
>     };
>     noinline int
>     bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 b, int c) {
>         bpf_testmod_test_struct_arg_result = a + b.a + b.b + c;
>         return bpf_testmod_test_struct_arg_result;
>     }
>
> When a bpf program is attached to the bpf_testmod function
> bpf_testmod_test_struct_arg_2(), the bpf program may look like
>     SEC("fentry/bpf_testmod_test_struct_arg_2")
>     int BPF_PROG(test_struct_arg_3, int a, struct bpf_testmod_struct_arg_2 *b, int c)
>     {
>         t2_a = a;
>         t2_b_a = b->a;
>         t2_b_b = b->b;
>         t2_c = c;
>         return 0;
>     }
>
> Basically struct value becomes a pointer to the struct.
> The trampoline stack will be increased to store the stack values and
> the pointer to these values will be saved in the stack slot corresponding
> to that argument. For x86_64, the struct size is limited up to 16 bytes
> so the struct can fit in one or two registers. The struct size of more
> than 16 bytes is not supported now as our current use case is
> for sockptr_t in the argument. We could handle such large struct's
> in the future if we have concrete use cases.
>
> The main changes are in save_regs() and restore_regs(). The following
> illustrated the trampoline asm codes for save_regs() and restore_regs().
> save_regs():
>     /* first argument */
>     mov    DWORD PTR [rbp-0x18],edi
>     /* second argument: struct, save actual values and put the pointer to the slot */
>     lea    rax,[rbp-0x40]
>     mov    QWORD PTR [rbp-0x10],rax
>     mov    QWORD PTR [rbp-0x40],rsi
>     mov    QWORD PTR [rbp-0x38],rdx
>     /* third argument */
>     mov    DWORD PTR [rbp-0x8],esi
> restore_regs():
>     mov    edi,DWORD PTR [rbp-0x18]
>     mov    rsi,QWORD PTR [rbp-0x40]
>     mov    rdx,QWORD PTR [rbp-0x38]
>     mov    esi,DWORD PTR [rbp-0x8]

Not sure whether it was discussed before, but
why cannot we adjust the bpf side instead?
Technically struct passing between bpf progs was never
officially supported. llvm generates something.
Probably always passes by reference, but we can adjust
that behavior without breaking any programs because
we don't have bpf libraries. Programs are fully contained
in one or few files. libbpf can do static linking, but
without any actual libraries the chance of breaking
backward compat is close to zero.
Can we teach llvm to pass sizeof(struct) <= 16 in
two bpf registers?
Then we wouldn't need to have a discrepancy between
kernel function prototype and bpf fentry prog proto.
Both will have struct by value in the same spot.
The trampoline generation will be simpler for x86 and
its runtime faster too.
The other architectures that pass small structs by reference
can do a bit more work in the trampoline: copy up to 16 byte
and bpf prog side will see it as they were passed in 'registers'.
wdyt?
