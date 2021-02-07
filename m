Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6B3120AE
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 02:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBGBLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 20:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGBLr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 20:11:47 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3C9C06174A
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 17:11:07 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 19so11026074qkh.3
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 17:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYi7NkMMsJPHAbpJ58JCtFOmuFoPJs2yXZxDplkNxSk=;
        b=QiFWRjzNhG6c98kZ/dipM8EggnXxQA2B/GJ2rkfgLmcBpFOuuRa7yciwcoFFV6Ld9N
         btnovFZMocnRFLLjluBDii/rKhd5ymmpluS3eXmhComQSAcwtA11bh4jMYBQZXPHDpmc
         NvC8n+fctEVKoT6HJP5/2wSTWnhBQntGUaNAYqn3k2aavuyH5X5qksO/ISEMUMAUqCr/
         Y5QjccqmJOfvoGMumjcC+ecRiiDUZ8190n7dD+sBaAPaCgrLom6ALGeud/Rr67Bhrhr/
         3lpmsAoJjIeqHqbt9iRWJ1p5tuZxj7NG8ubpkRWT57JaarLRTwWxrxFgMDE57N+KaUQu
         i4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYi7NkMMsJPHAbpJ58JCtFOmuFoPJs2yXZxDplkNxSk=;
        b=ghUL3diYJrk0oTA6EkYa5JE7L2yLcPlb5/iCw+BU5x3wCXVSLces91F+aGFtT8+YSY
         sheakCPb0WqgBo1qVzyhnt/1XCv1sEMqfBPV65XfnO+KUxl4C67/+t5qUN+m7daIUw2J
         J1wPP2TqVkzAsxZXA3FZwKRrQjutGns9prWcIsV9W77gVNpAQv8RJLRfPoSEx8zGF5M5
         qgfNE3ncNSEfEqxDa4Hd3gnHeyi7R8npZqsrl6orHv3tOg5/FkiCdkWiF+p754n/EqS6
         X/jxQ8kTHyYBHneBr+e/frsmv2P+05qohKG256+cPUfryiYzYHR5+GsYodg8sntUeCMw
         K84w==
X-Gm-Message-State: AOAM531KaS5RwlXqepkGlFZH58jbQnS5n4KUHpLF6Ci2FI1at1MTGuqg
        jz8qW5HAkCYFIF9aws4aZmQfVdrkIFK97A==
X-Google-Smtp-Source: ABdhPJyoBQsuabowT5zklCQWxFJJsc2ak8lXzAwJLQ4oM9gj8zo8wAh3G68KVWT63eByEjd5ICs7rg==
X-Received: by 2002:a37:65d8:: with SMTP id z207mr1312482qkb.479.1612660265785;
        Sat, 06 Feb 2021 17:11:05 -0800 (PST)
Received: from localhost (pool-100-33-73-206.nycmny.fios.verizon.net. [100.33.73.206])
        by smtp.gmail.com with ESMTPSA id l128sm13176652qkf.68.2021.02.06.17.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 17:11:05 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v3 0/4] allow variable-offset stack acces
Date:   Sat,  6 Feb 2021 20:10:23 -0500
Message-Id: <20210207011027.676572-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before this patch, variable offset access to the stack was dissalowed
for regular instructions, but was allowed for "indirect" accesses (i.e.
helpers). This patch removes the restriction, allowing reading and
writing to the stack through stack pointers with variable offsets. This
makes stack-allocated buffers more usable in programs, and brings stack
pointers closer to other types of pointers.
    
The motivation is being able to use stack-allocated buffers for data
manipulation. When the stack size limit is sufficient, allocating
buffers on the stack is simpler than per-cpu arrays, or other
alternatives.

V2 -> V3

- var-offset writes mark all the stack slots in range as initialized, so
  that future reads are not rejected.
- rewrote the C test to not use uprobes, as per Andrii's suggestion.
- addressed other review comments from Alexei.

V1 -> V2

- add support for var-offset stack writes, in addition to reads
- add a C test
- made variable offset direct reads no longer destroy spilled registers
  in the access range
- address review nits



Andrei Matei (4):
  bpf: allow variable-offset stack access
  selftest/bpf: adjust expected verifier errors
  selftest/bpf: verifier tests for var-off access
  selftest/bpf: add test for var-offset stack access

 include/linux/bpf.h                           |   5 +
 include/linux/bpf_verifier.h                  |   3 +-
 kernel/bpf/verifier.c                         | 657 ++++++++++++++----
 .../selftests/bpf/prog_tests/stack_var_off.c  |  36 +
 .../selftests/bpf/progs/test_stack_var_off.c  |  56 ++
 .../selftests/bpf/verifier/basic_stack.c      |   2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   4 +-
 .../testing/selftests/bpf/verifier/const_or.c |   4 +-
 .../bpf/verifier/helper_access_var_len.c      |  12 +-
 .../testing/selftests/bpf/verifier/int_ptr.c  |   6 +-
 .../selftests/bpf/verifier/raw_stack.c        |  10 +-
 .../selftests/bpf/verifier/stack_ptr.c        |  22 +-
 tools/testing/selftests/bpf/verifier/unpriv.c |   2 +-
 .../testing/selftests/bpf/verifier/var_off.c  | 115 ++-
 14 files changed, 748 insertions(+), 186 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_var_off.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_stack_var_off.c

-- 
2.27.0

