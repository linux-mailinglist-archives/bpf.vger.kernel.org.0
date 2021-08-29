Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286083FA84D
	for <lists+bpf@lfdr.de>; Sun, 29 Aug 2021 05:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhH2D0a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Aug 2021 23:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhH2D03 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Aug 2021 23:26:29 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2514BC061756
        for <bpf@vger.kernel.org>; Sat, 28 Aug 2021 20:25:37 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id q70so20778854ybg.11
        for <bpf@vger.kernel.org>; Sat, 28 Aug 2021 20:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jMsBUqahXua373+H7sBiFfZsKqIzWQZZLA6UOJi57i4=;
        b=f0Zf6JrZOW+1b2GhccDgO9AEmzHcNIEj44YLahntMSqNQ2ggWGfBHHEMPvf4XVtaWk
         ho5G+OP68Zw2adavY0SGWnodGHFeqOzhcka6Q9YbFOq5JhiuLV5hsOf055D/+dEPbq8W
         NIE5X/k7ux0TZqPuha1HYRdnkEUu9hqy1m93aFKxilUQK2PkpI9c3phyRCT/US/lQGXj
         N8Dca4Qe//qfLVn1wcirISqal1yc18f8QuoX3hPG5QawDg2puKSVCYrjN/auZaEQHSPn
         lLlNrdWEJADAkITIZE98SkxQqfvvX/9PW4j7MiqaGe1UZ7D2c6P/BNvFDjf793x03qu4
         xSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jMsBUqahXua373+H7sBiFfZsKqIzWQZZLA6UOJi57i4=;
        b=mnfaXTJqpWedWq9HYvbzyOPWAAMJfZYDn1obj1dLfwhFGsXfoM3v+eWu+x/FRcS0FJ
         /gn2QYtFSBWDEUZkvDbXYi3SnCPJKI+JkR89zL41Nbngb9gEodHNkHTBLUKZOSUE8OPw
         3ildf84ifrhOfNq4NbwJ7Bg3I91VQG4SZMp93EapFf6iY3h3J0UYjc8moioQU35QFH1J
         C3q2DRLsgI5rgqxJQnvmlqEGtrcS3h3SIeeLAVP7RgrEufCSqkTkYFSvt9ZTfupFYRvb
         Rz81FP9jw7jWRB6qjzqD6prPfChL0RPobksfhqHu6Ac6iVClPij94GgjE3KmBICIIZUc
         z3TA==
X-Gm-Message-State: AOAM531IVuL8N0/i+jLNPub9Zq40CCOtuTEWSgtMZxlW47jM7ZTGWx7u
        9zyu1FtzeinEQ+dUk1SiVnd4ko2VHD8d+r29ra40O1Pab70=
X-Google-Smtp-Source: ABdhPJyWSAmIg9rYVl7srbTwAMQpD85VNW9niDJ/wDcUhQVmPPXtZSsrEhZEfTW4trnGCCDLzfwZsipa2NiloWTzBIA=
X-Received: by 2002:a25:f50b:: with SMTP id a11mr14983910ybe.206.1630207536327;
 Sat, 28 Aug 2021 20:25:36 -0700 (PDT)
MIME-Version: 1.0
From:   rainkin <rainkin1993@gmail.com>
Date:   Sun, 29 Aug 2021 11:25:01 +0800
Message-ID: <CAHb-xaufru2zfr0hzOe-dkXDNhZXb1hpNkWK5z3uu5jYQuNeKA@mail.gmail.com>
Subject: cannot pass ebpf verify bound check due to compiler optimization
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

My kernel version is 4.19.

I have an eBPFprogram that accesses Map memory, and I check the bound
of the Map value pointer offset when I use offset to access the Map.

However, I find a very strange situation: Although I have checked the
bound in the source code, eBPF verify still reports an error saying
that the bound is not checked and cannot pass the verification. But
when I just a bpf_printk into the program, the program works well and
passes the verification...

After investigating the disassembly code for several days, I finally
figure out the root cause: eBPF verify logic is not compatible with
LLVM compiler optimization.
Specifically, there are two cases:
1. registers reloaded from the stack lose the state.
The Map value pointer offset stored in a register is checked and eBPF
verify successfully updates the bound state of the register. When
registers are not enough, LLVM stores the register value in the stack
and uses the register to perform other tasks. When the MAP needed to
be accessed, the offset value is reloaded from the stack. However, the
bound state of the offset is lost, which causing the verify error.

Intuitive solution: track the state of the stack value. In my
understanding, the stack size is limited (512 bytes), it should be
fine to track the whole stack and do not cause performance issues?

2.  LLVM uses two registers to represent the same MAP pointer offset.
When performing bound checking, register R1 is used and the bound
check state is saved in R1.
However, when accessing the MAP, register R2 is used which does not
have bound checks, which causing the verify error...

Solution: It seems this issue cannot be solved easily by eBPF verify
because the relationship between R1 and R2 is lost during LLVM
compiler optimization.

These issues make me crazy... Do you guys have any workarounds to
solve the above two issues before eBPF/LLVM is patched?

Thanks,
rainkin
