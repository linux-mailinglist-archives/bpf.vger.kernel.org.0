Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3041FD7A
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhJBRnA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Oct 2021 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhJBRm7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Oct 2021 13:42:59 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF12C0613EC
        for <bpf@vger.kernel.org>; Sat,  2 Oct 2021 10:41:13 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g6so10597238ybb.3
        for <bpf@vger.kernel.org>; Sat, 02 Oct 2021 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7Hroc3+MqrMFWaFTtvs4lVC7qwTcLSuDkGBDKTRL4M=;
        b=qmd1BRa3xHYlbttAXTQl3xBy6oSR6ELKU6YgN3veTdQnJk0C1mDR4mKnnSEPbawD15
         PjMdRrgskRfBN9znmYvzI6PwvS6lg14+4aQOHoNKruMp6lXW32SQMWqPI6KgISX8qCTb
         uGRDP2BfatcNvc3FvRuWboiD/moItnuVkwJyh7yKqFulfPs7SUHaEZfwvChEEtz025IO
         1/4HcwZYV6XkF7jQUd2jyuNgU4Hlyyu1/dCx84ofE7kThvti4iMWu0KQZIX3xo9RWbbD
         +PkMgIxWOEN/VAo10cfC5hk6aOBdhHhSCIdk4RvBc9s+k5PDQ2u6rfJXEpd2U1oY7vuB
         hCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7Hroc3+MqrMFWaFTtvs4lVC7qwTcLSuDkGBDKTRL4M=;
        b=T4Lj6eashL5beI/RegI2/3NnJEA9o0iiYgfwcxzf9OTH4xdSSSpFZvB5sYvqK1dK0r
         PyUrUjAhnEHUSQFeBz3XUUdwXicMBlSajdV8A8o+RaEsrjPM8EAC6E8ubEiLbiPeyVuA
         LM/T2Livb4iqrkHDg059SFFKO+PwG8wt/i84UxrQMYlkB+YZAP4aAR8wTMO8HSTOGV0E
         bST8MZpKjwghx5NOc+tiQ5uNH3Nzk2KN0wOFdIRrKrPLvfvDmvdIEp75myIqDv6aOlcu
         6X4EyfiRqACzWnJgUr6BhhsXf5OIUHEdZiJFnfx3QDyzdZ4y25gvcuO7ZtKyrlgkU1M8
         nBUw==
X-Gm-Message-State: AOAM532823JM2ZsT30Bi5tvIf9SSCVqtayLea/kmmM79vGWazAUf95T6
        dq03s4s4fRuWaqU2GQtev3Xh5wEYcJKFPjTIQwfemXKHhlRjLw==
X-Google-Smtp-Source: ABdhPJyCWFlSgCPm3tiOkXw8RyMZA2XUHUQ2nuy9q7bK2YZ7il0HNSEsa1GgxTJFTHLnMFKwubuHxe0di5cKSenyiJ8=
X-Received: by 2002:a25:bb08:: with SMTP id z8mr5110823ybg.306.1633196472613;
 Sat, 02 Oct 2021 10:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Sat, 2 Oct 2021 19:41:01 +0200
Message-ID: <CAM1=_QSrOZBk+_h224cdxrZw7djqUqO9jytYNV--9V-KTJmt9Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] powerpc/bpf: Various fixes
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        bpf <bpf@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 1, 2021 at 11:15 PM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> Various fixes to the eBPF JIT for powerpc, thanks to some new tests
> added by Johan. This series fixes all failures in test_bpf on powerpc64.
> There are still some failures on powerpc32 to be looked into.

Great work! I have tested it on powerpc64 in QEMU, which is the same
setup that previously triggered an illegal instruction, and all tests
pass now. On powerpc32 there are still some issues left as you say.

Thanks!
Johan


>
> - Naveen
>
>
> Naveen N. Rao (8):
>   powerpc/lib: Add helper to check if offset is within conditional
>     branch range
>   powerpc/bpf: Validate branch ranges
>   powerpc/bpf: Handle large branch ranges with BPF_EXIT
>   powerpc/bpf: Fix BPF_MOD when imm == 1
>   powerpc/bpf: Fix BPF_SUB when imm == 0x80000000
>   powerpc/bpf: Limit 'ldbrx' to processors compliant with ISA v2.06
>   powerpc/security: Add a helper to query stf_barrier type
>   powerpc/bpf: Emit stf barrier instruction sequences for BPF_NOSPEC
>
> Ravi Bangoria (1):
>   powerpc/bpf: Remove unused SEEN_STACK
>
>  arch/powerpc/include/asm/code-patching.h     |   1 +
>  arch/powerpc/include/asm/ppc-opcode.h        |   1 +
>  arch/powerpc/include/asm/security_features.h |   5 +
>  arch/powerpc/kernel/security.c               |   5 +
>  arch/powerpc/lib/code-patching.c             |   7 +-
>  arch/powerpc/net/bpf_jit.h                   |  39 ++++---
>  arch/powerpc/net/bpf_jit64.h                 |   8 +-
>  arch/powerpc/net/bpf_jit_comp.c              |  28 ++++-
>  arch/powerpc/net/bpf_jit_comp32.c            |  10 +-
>  arch/powerpc/net/bpf_jit_comp64.c            | 113 ++++++++++++++-----
>  10 files changed, 167 insertions(+), 50 deletions(-)
>
>
> base-commit: 044c2d99d9f43c6d6fde8bed00672517dd9a5a57
> --
> 2.33.0
>
