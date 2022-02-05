Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9E4AAC8E
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 21:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbiBEUqw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Feb 2022 15:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiBEUqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Feb 2022 15:46:52 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12715C061348
        for <bpf@vger.kernel.org>; Sat,  5 Feb 2022 12:46:51 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id w7so11874102ioj.5
        for <bpf@vger.kernel.org>; Sat, 05 Feb 2022 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9N2jXLn+S5MkUBFgcBd2oA+wekY4hWmrLo2DP2fH+c=;
        b=GeMbgvrKgWeabysnDujwtnCIADOwlMbusYGIU4uhqyuy1Ua+r7Jp1iS815ClC3D/MD
         RZVoEmUvQhOLDv6qvrpZv8leCXYz/cFKuiUsqMB3zQ5H9aLOHjvAeXkSQvwtMWTCqhbz
         48igrE2psVBNlR7kOww29Tt4w1yVi1D3UkFi389K6urnD3cHp1/HCnESRjXs+i7YaoP3
         BdWZUaR4upRmLKpxMlqFk3tl82qAPvErB28tpGvmVP2kGpy+0E0esKkl/QXaaJK/Hcmw
         FcOL1PK0XCff1mpZ16eJ/CVQ2PIC/kZTSILet2QF3o3KBJaAF/o9jm7TEHCSX158f+a3
         w/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9N2jXLn+S5MkUBFgcBd2oA+wekY4hWmrLo2DP2fH+c=;
        b=nLiT55Kuu2vB/Cegj4Eczj6OkqDPXjEm+g7yr1uu70CroMALbbpv5yEMki42+EgfuY
         y7YtO89Bx9Gs2eq4xRNQmlXsUPE5e56jzwu+kJC+dEPrTPTmmIwTan7CiXt6YMTeBb3O
         LZsbyrZf0A8pgz6LEF8YRmOIpPENC3hUvWLEu2XtnsfK9ZahCUoqObwtTgWPPOrEhRgY
         rg3FowDd0OIjExLKXdjYzVeGoQi9PAJ92Iu5j68DvuYYEZAHxBNXkDOpdS3t4hhDsjKY
         DdFmf6pTIMvvxvWJ1hDLbyUHGQcUmwC2a9326CygWt98a0w3D1Ic4eiuzpy2FgFaJERj
         T4BQ==
X-Gm-Message-State: AOAM531yDMjTqg9X5lzIKwHjJTYNNGJdbSrKHRZ2m+xa9Rw6hHosH0/k
        nyNnNDD+I8itzXU6UzGUdsgrfkg5EAXjGTfslvc=
X-Google-Smtp-Source: ABdhPJyQxhkC3kf0c3W+tGFvv/4T0Zth4VpBL0JMstHwyYs94Sm2V8VtO0vFGZdR7TGgqRmAaL0//kITPPeGun4beYU=
X-Received: by 2002:a5e:a806:: with SMTP id c6mr2304130ioa.112.1644094010311;
 Sat, 05 Feb 2022 12:46:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 5 Feb 2022 12:46:39 -0800
Message-ID: <CAEf4BzYAK3g1ELm7UeTDMJWquX2CUS3PJnzRx4i-LLBTVKH2mA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] selftests/bpf: Fix tests on non-x86 architectures
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>
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

On Fri, Feb 4, 2022 at 3:36 AM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> The first patch fixes an issue with bpf_syscall_macro test to work
> properly on architectures that don't have a syscall wrapper. The second
> patch updates SYS_PREFIX for architectures without a syscall wrapper.
> The final patch fixes some of the tests to use correct syscall entry
> names on non-x86 architectures.
>
> - Naveen
>
>
> Naveen N. Rao (3):
>   selftests/bpf: Use correct pt_regs on architectures without syscall
>     wrapper
>   selftests/bpf: Use "__se_" prefix on architectures without syscall
>     wrapper
>   selftests/bpf: Fix tests to use arch-dependent syscall entry points
>

Ilya's patch set made the first patch unnecessary, but I've applied
2nd and 3rd to bpf-next, thanks!


>  tools/testing/selftests/bpf/progs/bloom_filter_bench.c | 7 ++++---
>  tools/testing/selftests/bpf/progs/bloom_filter_map.c   | 5 +++--
>  tools/testing/selftests/bpf/progs/bpf_loop.c           | 9 +++++----
>  tools/testing/selftests/bpf/progs/bpf_loop_bench.c     | 3 ++-
>  tools/testing/selftests/bpf/progs/bpf_misc.h           | 2 +-
>  tools/testing/selftests/bpf/progs/bpf_syscall_macro.c  | 4 ++++
>  tools/testing/selftests/bpf/progs/fexit_sleep.c        | 9 +++++----
>  tools/testing/selftests/bpf/progs/perfbuf_bench.c      | 3 ++-
>  tools/testing/selftests/bpf/progs/ringbuf_bench.c      | 3 ++-
>  tools/testing/selftests/bpf/progs/test_ringbuf.c       | 3 ++-
>  tools/testing/selftests/bpf/progs/trace_printk.c       | 3 ++-
>  tools/testing/selftests/bpf/progs/trace_vprintk.c      | 3 ++-
>  tools/testing/selftests/bpf/progs/trigger_bench.c      | 9 +++++----
>  13 files changed, 39 insertions(+), 24 deletions(-)
>
>
> base-commit: 227a0713b319e7a8605312dee1c97c97a719a9fc
> --
> 2.34.1
>
