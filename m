Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8304301E88
	for <lists+bpf@lfdr.de>; Sun, 24 Jan 2021 20:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbhAXTvI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jan 2021 14:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbhAXTvI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jan 2021 14:51:08 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD855C061573
        for <bpf@vger.kernel.org>; Sun, 24 Jan 2021 11:50:27 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id e15so8200275qte.9
        for <bpf@vger.kernel.org>; Sun, 24 Jan 2021 11:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMlLe8udNKEwbXa9eeX+caYL9FV8HiWSbMlKsKErBSI=;
        b=aRm+YJHy/TLRF2sPTKI8R25hecZ0VoUWiKhPYBqPbIxkdkjzwNfefnoIjQseaJ3JGh
         UdEs/ZrhbWR4VDYQjet7yI1cc2O47my/MV2fLuomPwU9JWvV8s+WRPjGex8WnCFWSu3c
         ayf00Q0TLvSkueR8QmylHL6jaDCqh2Sre7yj2Rgxhf/+HmVUQaAU/bmUDSMRf/Zr42qg
         6W29OtUOgE3AEJohCiOIN4mlNkE/HkY0CIDzm1mbwJ7zxg+ammut0KI8174LNJR6C6/5
         orsPovSgXvo9A1OYt+kY3AGLpvoydohwNWY9fr2NdYGu8ex5YWM02K7ktmJD3EBre2R+
         ZXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMlLe8udNKEwbXa9eeX+caYL9FV8HiWSbMlKsKErBSI=;
        b=oFsR76c0trd+oiWau/RHzfZxeSc7KimK0soh75z/XZIEmTjdIdHVsHMosDD2xHAiJ1
         t3HjjA2jyGEHUoKUsDB+Ifj1GRTTbb6iDZFvN6VoUX4Aqlqv4iNSAt1/uBHR8VV0E0Ll
         Bt3JgotACsvuOXy+qrdmwtXSqIQSUzrTBAKDKMGDXdP77gTTqAgvbZynBpvrz+g+4SPw
         CUhB/XGITz/FheGmgDaBViZWhMluV4g9NZzrp9q6UkrniH1gNvw2PoMiEgGtfHf0zavS
         r9lzoPG5rJ7wLFi9kNkpp7MCDuQ4AJ/XK5JPdxSyIGmzl0Jal3qyjJPSFbNMTaATrRBC
         IZew==
X-Gm-Message-State: AOAM5316ASQg2cd48RM+7lDHWtht3qyg41B5yJ4avN1gt38pw4fAogTv
        hPQTiRCcr6yeXtMtlSCU1ezMKFbjSKbPWw==
X-Google-Smtp-Source: ABdhPJwzOOQ1a6i2Zoy4ckdo1as9aKFmArpXFrozOS+sI5ib9IO47vICt1CUbGoiBWHsTuwn1G4yOQ==
X-Received: by 2002:ac8:4e51:: with SMTP id e17mr2152508qtw.121.1611517826314;
        Sun, 24 Jan 2021 11:50:26 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id x185sm10676822qkb.87.2021.01.24.11.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 11:50:25 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v2 0/5] bpf: allow variable-offset stack access
Date:   Sun, 24 Jan 2021 14:49:04 -0500
Message-Id: <20210124194909.453844-1-andreimatei1@gmail.com>
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

V1 -> V2

- add support for var-offset stack writes, in addition to reads
- add a C test
- made variable offset direct reads no longer destroy spilled registers
  in the access range
- address review nits

Alexei had asked to split the work into refactoring and new
functionality. I have tried to do so, but the result seemed worse.
Particularly with the addition of write support in this V2, the lines
between refactoring and new functionality are mostly gone; the structure
changes too much. Alexei, if you disagree, I will try harder.


Andrei Matei (5):
  bpf: allow variable-offset stack access
  selftest/bpf: adjust expected verifier errors
  selftest/bpf: verifier tests for var-off access
  selftest/bpf: move utility function to tests header
  selftest/bpf: add test for var-offset stack access

 include/linux/bpf_verifier.h                  |   2 +-
 kernel/bpf/verifier.c                         | 657 ++++++++++++++----
 .../selftests/bpf/prog_tests/attach_probe.c   |  21 -
 .../selftests/bpf/prog_tests/stack_var_off.c  |  56 ++
 .../selftests/bpf/progs/test_stack_var_off.c  |  43 ++
 tools/testing/selftests/bpf/test_progs.c      |  25 +
 tools/testing/selftests/bpf/test_progs.h      |   1 +
 .../selftests/bpf/verifier/basic_stack.c      |   2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   4 +-
 .../testing/selftests/bpf/verifier/const_or.c |   4 +-
 .../bpf/verifier/helper_access_var_len.c      |  12 +-
 .../testing/selftests/bpf/verifier/int_ptr.c  |   6 +-
 .../selftests/bpf/verifier/raw_stack.c        |  10 +-
 .../selftests/bpf/verifier/stack_ptr.c        |  22 +-
 tools/testing/selftests/bpf/verifier/unpriv.c |   2 +-
 .../testing/selftests/bpf/verifier/var_off.c  | 108 ++-
 16 files changed, 768 insertions(+), 207 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_var_off.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_stack_var_off.c

-- 
2.27.0

