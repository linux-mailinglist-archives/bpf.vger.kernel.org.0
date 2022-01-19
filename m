Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F31493ADF
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 14:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354664AbiASNMo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 08:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354498AbiASNMo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 08:12:44 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025EBC061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 05:12:44 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q75so2577219pgq.5
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 05:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wq4ZPTeRMdXbVzGOWrhmREoieqegm0DsXPzXmnOvJY=;
        b=pP5s4TT12LRLPibqa6VaiTXrIKZbV9ljhfL5XFBRtbF/1x133ut4mb//C7KdU1ETBR
         +pcI6XEIvjcDu1gjCazO3sLwWuxuEzLK8XqxWatb97b1nWwz9B5f9TSe4RZRJ9iEPerm
         1RSJdM9tmy84ZQEqfyHto+oAiaxh/3tCXR1dq6FfHwQeKIirU1TciNvDzPVZWzIMaywo
         NHejxlldfqRU6gBst9MXSDXjwIYDlCFhzMIa1REEB8oVWO4XuE/gucAiVRfOVZcRofWJ
         E9dcBos6ggUBloDuCoktowjW2pvBPDe+VKkz8Qoe/Wu5ryuQsy9dmvhqbBskKR3+GzpW
         Cx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3wq4ZPTeRMdXbVzGOWrhmREoieqegm0DsXPzXmnOvJY=;
        b=GvBg7eCXFar6xdKzQO+l/QCP31MnXxelWwuFQbBQA570KqViiVGaGAfzRUM83oN0hu
         n0l1UJMN8BgiiC2PhCCHBRSjiV+O36byq8xk5mIz6xlkAWHlztJXZpksgyZ0UoosAqh2
         5iAIVYP0RiI8b9NQL2U2Y/yUeZar+ImCxYWVAHOfyTkqKfYFkjfQ/5Kar1nGTmSGu6pY
         Sk1sBhb0DCXE2wV+HsCKAxbmC6vTN6N+Ac012nSwk8nCQS/wYYRYIQ1HSa2mmZ7qHJnJ
         sDqprNTKkjoXzfSe8tuDRcJlzggzfyF00kt1X5cZvGCbagLPGFB4msu2ngAFFVOiUqJL
         8ZkQ==
X-Gm-Message-State: AOAM531wzh/jddYJOMHHU3UgS4OBgIYV8/ZC3o3uJdk3xJIb/dARHuvu
        LkSQF5UaCXZx26bCH2dj2lI=
X-Google-Smtp-Source: ABdhPJyVrzH3RDvRLmVFjc2J3ICi3as6BPB78Mm0nlFHGGBd2xR/x1Xlq6HaNcr9GbDFudALYgfrzQ==
X-Received: by 2002:a62:1c12:0:b0:4bc:6d81:b402 with SMTP id c18-20020a621c12000000b004bc6d81b402mr30552716pfc.40.1642597963518;
        Wed, 19 Jan 2022 05:12:43 -0800 (PST)
Received: from ktada-Stealth-15M-A11UEK.. (fpa446d38e.knge002.ap.nuro.jp. [164.70.211.142])
        by smtp.gmail.com with ESMTPSA id v13sm3603208pjd.13.2022.01.19.05.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 05:12:42 -0800 (PST)
Sender: KENTA TADA <kenta.tada.s@gmail.com>
From:   Kenta Tada <Kenta.Tada@sony.com>
To:     andrii@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH v4 0/3] Fix the incorrect register read for syscalls on x86_64
Date:   Wed, 19 Jan 2022 22:12:06 +0900
Message-Id: <20220119131209.36092-1-Kenta.Tada@sony.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, rcx is read as the fourth parameter of syscall on x86_64.
But x86_64 Linux System Call convention uses r10 actually.
This commit adds the wrapper for users who want to access to
syscall params to analyze the user space.

Changelog:
----------
v1 -> v2:
- Rebase to current bpf-next
https://lore.kernel.org/bpf/20211222213924.1869758-1-andrii@kernel.org/

v2 -> v3:
- Modify the definition of SYSCALL macros for only targeted archs.
- Define __BPF_TARGET_MISSING variants for completeness.
- Remove CORE variants. These macros will not be used.
- Add a selftest.

v3 -> v4:
- Modify a selftest not to use serial tests.
- Modify a selftest to use ASSERT_EQ().
- Extract syscall wrapper for all the other tests.
- Add CORE variants.

Kenta Tada (3):
  libbpf: Extract syscall wrapper
  libbpf: Fix the incorrect register read for syscalls on x86_64
  libbpf: Add a test to confirm PT_REGS_PARM4_SYSCALL

 tools/lib/bpf/bpf_tracing.h                   | 34 +++++++++++++
 .../bpf/prog_tests/test_bpf_syscall_macro.c   | 49 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 19 +++++++
 .../selftests/bpf/progs/bpf_syscall_macro.c   | 51 +++++++++++++++++++
 .../selftests/bpf/progs/test_probe_user.c     | 15 +-----
 5 files changed, 154 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_misc.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c

-- 
2.32.0

