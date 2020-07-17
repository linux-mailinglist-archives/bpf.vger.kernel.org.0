Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57692239AB
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 12:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgGQKqt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 06:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgGQKqt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 06:46:49 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181FFC061755
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:46:49 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id e90so6562726ote.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=q1cvbAYCCFb9IPgfRcGxzM2eFkp94sW4vsQAh/FaafY=;
        b=Rh5tNuSZZaDTjv7ZQRqelWxQiLx7g2bm97LaDydGUvIsBc9oMpiLPFAEpNKHHa44/l
         jb1gzcLe4PULN1bXvs+dey2VghG2soPVPcCLAOURQWYIpQzUNCxTi0WdIPODmlUYvMzF
         oRE1GWbw5Wj1AZouYCASUXh5C/dhwCPIbMDfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=q1cvbAYCCFb9IPgfRcGxzM2eFkp94sW4vsQAh/FaafY=;
        b=E8G7oiSLSU3lSwoAA12YhDl6B7juotVLp6pSDQqH0jYrUqac+E+0KZM2yDLJaYF4Db
         I5LDopUjlgrRMvKMah63dk0jrw47WTos3/0ojTY//IASay25zm4WJz6SBiZF/a4TJ9Cu
         N1EX/J6wH+L3RpAgT0W+5u13pLQHK40Jdhw21D9xWC4JaUZzE3BuOYZ+R8iRT7hTs/75
         wSuVb19gbSmf3ZfKHLZ8ck68sGgi0yML7KdlVIjFUJV2xWs6tOkP9fLO4tcmY0xcr4eX
         XPp6LqR/I95HqiSgjUwO1qGzu07xYGMs+SWx1KVMRnRvoLi1omYeRYz1L08HO57/2Kzs
         eB/w==
X-Gm-Message-State: AOAM533RcFevxkeWX/VYgr1haHuBqh84i/EE97IXk32vUPCSaxXwFnjf
        YlcuJtqRWkzzcW8k8R7aDN4HLLEKIJbPmseGeb0lQLa1d3XUFA==
X-Google-Smtp-Source: ABdhPJzYscG9y4YnBi3/ATfu2R/qkLn5mzZi0hsxXIrsMLdoKP/SgLQI00kCClsXiTI2bblYvQpIq+1vp+SzofGRygM=
X-Received: by 2002:a9d:1c7:: with SMTP id e65mr7552574ote.147.1594982808036;
 Fri, 17 Jul 2020 03:46:48 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 17 Jul 2020 11:46:37 +0100
Message-ID: <CACAyw9_g6mgg_DoYpbMaWpE8BQAC+S5XG8U4aw1JAMoOxiDtPQ@mail.gmail.com>
Subject: Verification speed w/ KASAN builds
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi list,

I'm not sure whether this is a bug report or just the way of life.
The problem: we have a couple of machines that run KASAN
kernels to weed out bugs. On those machines, loading our
cls-redirect TC classifier takes so long that our user space
program aborts.

I've reproduced this in a VM: loading cls-redirect on a VM
with a 5.4 kernel without KASAN takes around 4 seconds.
Doing the same on recent bpf-next with KASAN and other
shenanigans enabled it takes more like a minute.

Is it expected that the overhead of KASAN is this large?
I went and collected a perf profile of loading the program
in the VM:

-   96.31%     1.00%  redirect.test  [kernel.kallsyms]  [k] do_check_common
   - 95.32% do_check_common
      - 69.24% states_equal.isra.0
         + 49.81% kmem_cache_alloc_trace
         + 16.77% kfree
         + 1.22% regsafe.part.0
      - 12.75% push_stack
         - 10.65% copy_verifier_state
            - 4.50% realloc_stack_state
               + 4.48% __kmalloc
            + 4.16% kmem_cache_alloc_trace
            + 1.82% __kmalloc
         + 2.07% kmem_cache_alloc_trace
      + 5.25% pop_stack
      + 2.84% push_jmp_history.isra.0
      + 2.46% copy_verifier_state
      + 1.00% free_verifier_state
        0.53% kmem_cache_alloc_trace
   + 1.00% runtime.goexit

Note that the version of cls-redirect in the tree and our internal version
have diverged a bit, the internal one is a bit more complicated.

Looking forward to your opinions,
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
