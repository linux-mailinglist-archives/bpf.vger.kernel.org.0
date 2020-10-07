Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B829D2860CD
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 16:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgJGOBq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 10:01:46 -0400
Received: from mail-vk1-f169.google.com ([209.85.221.169]:32894 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGOBq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 10:01:46 -0400
Received: by mail-vk1-f169.google.com with SMTP id z10so568762vkn.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2020 07:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i1OSl1+bXTCQMQimWHB+vdFpYEY6XsM+40xZOb9zAtg=;
        b=HwwpegZJha702JETsLFH3pvFGJxG3YSUWb7+Q6Sz4wBQtHgrmpMo6L4zr7ngaoVUfZ
         sMf3KyZcLbpBUdExO+O5EHuHxhER0WrU2jllsN7E2RNRE/bHifA55r3ZmlvlZ8QNndw0
         x84L1hMBrIaTElh5y7fC9TnmJpgzCDsSHEkYhWj3oXluwDRgEubBLlXI39JDwBgpOP09
         d35nq54KWdUsN2X8oj56saJWHNgAYQVstefE3r1ZUG8DrMyMVaacGxULxhaj2fWJdw08
         dn6k7X1vtL+wKPWsSzQ0wfx4Xg5ce6ebiDHcbU9KYl1kqOUYIkM8ERSi/sl3LZG4SXXu
         N6IQ==
X-Gm-Message-State: AOAM531BpYYpCmtRXSeaaw3vKtBH2TOZUkAuS3T5XDWL2/HEvAxQQYaU
        80n6lpeoWlRA8FTE5l95mg8ThfXeDQXzSKC+3ART1OXWgh8kZlkU
X-Google-Smtp-Source: ABdhPJzhg/ggMGBFAnNZCeLkeBMVjhXQyNhGVysRAj1fz1VTNaWUJUaR5UNuv+wwUo0G7oa29RYTu41lFiRnpuIrT04=
X-Received: by 2002:a1f:ac0e:: with SMTP id v14mr1721299vke.21.1602079305187;
 Wed, 07 Oct 2020 07:01:45 -0700 (PDT)
MIME-Version: 1.0
From:   Luigi Rizzo <rizzo@iet.unipi.it>
Date:   Wed, 7 Oct 2020 16:01:34 +0200
Message-ID: <CA+hQ2+gb_y7TViv13K_JpJTP=yHFqORmY+=6PrO4eAjgrBSitw@mail.gmail.com>
Subject: libbpf/bpftool inconsistent handling og .data and .bss ?
To:     bpf@vger.kernel.org, ppenkov@google.com,
        Luigi Rizzo <lrizzo@google.com>, andriin@fb.com, sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am experiencing some weirdness in global variables handling
in bpftool and libbpf, as described below.

This happens happen with code in foo_bpf.c compiled with
   clang-10 -O2 -Wall -Werror -target bpf ...
and subsequently exported with
   bpftool gen skeleton ...
(i have tried bpftool 5.8.7 and 5.9.0-rc6)

1. uninitialized globals are not recognised
   The following code in the bpf program

     int x;
     SEC("fentry/bar")
     int BPF_PROG(bar) { return 0;}

   compiles ok but bpftool then complains

      libbpf: prog 'bar': invalid relo against 'x' in special section
0xfff2; forgot to initialize global var?..

   The error disappears if I initialize x=0 or x=1
   (in the skeleton, x=0 ends up in .bss, x=1 ends up in .data)

2. .bss overrides from userspace are not seen in bpf at runtime

    In foo_bpf.c I have "int x = 0;"
    In the userspace program, before foo_bpf__load(), I do
       obj->bss->x = 1
    but after attach, the bpf code does not see the change, ie
        "if (x == 0) { .. } else { .. }"
    always takes the first branch.

    If I initialize "int x = 2" and then do
       obj->data->x = 1
    the update is seen correctly ie
          "if (x == 2) { .. } else { .. }"
     takes one or the other depending on whether userspace overrides
     the value before foo_bpf__load()

3. .data overrides do not seem to work for non-scalar types
    In foo_bpf.c I have
          struct one { int a; }; // type also visible to userspace
          struct one x { .a = 2 }; // avoid bugs #1 and #2
    If in userspace I do
          obj->data->x.a = 1
    the update is not seen in the kernel, ie
            "if (x.a == 2) { .. } else { .. }"
     always takes the first branch

Are these known issues ?

thanks
luigi
