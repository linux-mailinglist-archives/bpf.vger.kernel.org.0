Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285C3368AB5
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 04:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbhDWBtm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 21:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbhDWBtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 21:49:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D9C061344
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 18:48:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h20so24476419plr.4
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 18:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XajKNy6aoIfR9fbxhkyLjiEoAllUlrFjsDiP5vSV8KI=;
        b=16Qh8D3ZW09f+o41dGeMuO8jYxQStQWUf8WQAcJBxyGephSQEm1pixjYLvHT7hx7uG
         B5IH70i7Vf5dN6C+dPps5sR73nPC7Z0WiasfMoumBSvW9Zpxv1+t+4w6Uo+P5AgwvX3v
         aevwalaXJpmnDNJTZv/QFm88qjzZW+cy+mmV6iU/ZU4LCJYg/nlKj3zvLUmL1X9NOcyA
         6KtO60xIcclIYBfhI4w/sN0j0fSsysXPJ5AB4PujGRXM2AObwsQudjLbhC0adIsHd5wO
         UnRvSk8Ii4bDHs/uYn5p9VHH94bGc5KWzLlhtlf9JptbVH/tc0vo/wFJnK/YyA/UOXwv
         HOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XajKNy6aoIfR9fbxhkyLjiEoAllUlrFjsDiP5vSV8KI=;
        b=jFbLGYIvh/rkFUCD06bCbRD4nmQ0w5WstR6FvnWQ9y42gRJL3aGCwYgxY6RQB+fntB
         MQQLDwH5Lj8MmAWsV5/OUyo34iTS+7krMz55c2A3cKgpuSDJ0USagwQEviT3vCcTCTcA
         O+Yo5sEBcYmVVwUT3IpygMUbQ7rBDap65ziNHgS64ObTjgDcUkC9e2d47rlNwbmFnGEH
         STmO3c5Nk3uKqZrNq7siXjrvZKXZUzEVsNAApW3ThPvgP7oRW3xP/47I85B8mspxlIsb
         ctxsYRvCm05O6Wq5tdC++Gy0Zg0QF9WVkSziCzRotaGY/+A1Js9/bJvduU75kZR649vM
         br9Q==
X-Gm-Message-State: AOAM53116W9rXZaD7iGMbmhQ1DkdZ3mWFg8ADh+07ojmMD0E5Lyz1/H+
        I24oMSylPTRJdHDSa9/j4vKbZQ==
X-Google-Smtp-Source: ABdhPJwe7Y0d6/UnJxQlMZahTCa3FPgMdPek0KQGrK4wDzL21FZNrfZYihgBPY83nUxvyLVUn921Iw==
X-Received: by 2002:a17:90a:c3:: with SMTP id v3mr3158756pjd.55.1619142511541;
        Thu, 22 Apr 2021 18:48:31 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w123sm3004405pfb.109.2021.04.22.18.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:48:30 -0700 (PDT)
Date:   Thu, 22 Apr 2021 18:48:30 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 18:48:29 PDT (-0700)
Subject:     Re: [PATCH 0/9] riscv: improve self-protection
In-Reply-To: <20210330022144.150edc6e@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, bjorn@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-c1b60b87-7dd7-43e7-91eb-1f54528384f8@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 29 Mar 2021 11:21:44 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> patch1 is a trivial improvement patch to move some functions to .init
> section
>
> Then following patches improve self-protection by:
>
> Marking some variables __ro_after_init
> Constifing some variables
> Enabling ARCH_HAS_STRICT_MODULE_RWX
>
> Jisheng Zhang (9):
>   riscv: add __init section marker to some functions
>   riscv: Mark some global variables __ro_after_init
>   riscv: Constify sys_call_table
>   riscv: Constify sbi_ipi_ops
>   riscv: kprobes: Implement alloc_insn_page()
>   riscv: bpf: Move bpf_jit_alloc_exec() and bpf_jit_free_exec() to core
>   riscv: bpf: Avoid breaking W^X
>   riscv: module: Create module allocations without exec permissions
>   riscv: Set ARCH_HAS_STRICT_MODULE_RWX if MMU
>
>  arch/riscv/Kconfig                 |  1 +
>  arch/riscv/include/asm/smp.h       |  4 ++--
>  arch/riscv/include/asm/syscall.h   |  2 +-
>  arch/riscv/kernel/module.c         |  2 +-
>  arch/riscv/kernel/probes/kprobes.c |  8 ++++++++
>  arch/riscv/kernel/sbi.c            | 10 +++++-----
>  arch/riscv/kernel/smp.c            |  6 +++---
>  arch/riscv/kernel/syscall_table.c  |  2 +-
>  arch/riscv/kernel/time.c           |  2 +-
>  arch/riscv/kernel/traps.c          |  2 +-
>  arch/riscv/kernel/vdso.c           |  4 ++--
>  arch/riscv/mm/init.c               | 12 ++++++------
>  arch/riscv/mm/kasan_init.c         |  6 +++---
>  arch/riscv/mm/ptdump.c             |  2 +-
>  arch/riscv/net/bpf_jit_comp64.c    | 13 -------------
>  arch/riscv/net/bpf_jit_core.c      | 14 ++++++++++++++
>  16 files changed, 50 insertions(+), 40 deletions(-)

Thanks.  These are on for-next.  I had to fix up a handful of merge 
conflicts, so LMK if I made any mistakes.
