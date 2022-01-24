Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F884981E5
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 15:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiAXOSu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 09:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiAXOSt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 09:18:49 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A64C06173B
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 06:18:49 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c9so15587859plg.11
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 06:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=liX8dWHJKqYTA4NWzAbLBYm7AlB+BC3Ow++VS5rrXVw=;
        b=MWGEAfHC9bchkrHFrI4IBVcgeJ6mzlulMToMgjk/zoZfwX7qOH/7rd8839yjE/xtFn
         m8c/hx6mrijajSNh6U6cZ7/7TrxVLG69pSNgzmVrmuf1TUExvcCihD5cAC6uFl4yEJCD
         J1DhthTHbN1WwmDKqCqGAcfuOavWez0/LYlxdcwdKGT35zrEvtBr7oIEiaWOwvtGRm8Q
         aGUeASzz6d9T+/oOELIqsexps5rZH1xCCEowVWpMQyBdVSe9euorzO3zYBI6MSzp7uHw
         EeCEhSfkIoFSLzZK37PfLqV54Vc81YFL+TeamGflG5w7jrFiC38pNIR/tzFgObljUXN6
         g7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=liX8dWHJKqYTA4NWzAbLBYm7AlB+BC3Ow++VS5rrXVw=;
        b=4+zIz2JCGRgCVr/jTkDRBaENx6xEjhwpWqMp6Lkf58/lkYOr4M9QVGcILvR6uaSYft
         oMoKN1SMQ0qlNeFno8IrPN/+1lTEWueHYzjqgsGS1K1PVNSirz4KhRCpVMg7TKQJIjdh
         3hcJ1uucI7pd+vBWMHGHPGWjlaVAO25s5E2qizVgxPQg9D0FlstGbSgZcWjfsiMLQPxK
         B3XPeFnkgJNZXRqVElLxNGghhf312wXBKoWpHh7bLjPjhCwNiG5FT+pV+/HoMDcS9Fyk
         1xqql5BwL3C8AS3x5KzwHluNETnI74S6UUQG7UvfuOGO7YSIZFGViaLv4qnfzHq7KwhG
         KIQQ==
X-Gm-Message-State: AOAM533MuwnMC6AhvQkD+myfRnC5J5mh34YMffJejLQqEKCToC0/uwsl
        T4d+NoRzwYBpCYelqDpuTB6CgbQh/E0=
X-Google-Smtp-Source: ABdhPJxwcX8zyai8W3qjgEHSBPHPLXwwEgO+u3OL2BbmPJyOHH9VMaUzwEVn6rItIJBfaZxjP+vMzg==
X-Received: by 2002:a17:90a:470a:: with SMTP id h10mr2103822pjg.25.1643033929110;
        Mon, 24 Jan 2022 06:18:49 -0800 (PST)
Received: from ktada-Stealth-15M-A11UEK.. ([240d:1a:2e0:8a00:d1c2:4b2a:8ba8:7b43])
        by smtp.gmail.com with ESMTPSA id 13sm15629855pfm.161.2022.01.24.06.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 06:18:48 -0800 (PST)
Sender: KENTA TADA <kenta.tada.s@gmail.com>
From:   Kenta Tada <Kenta.Tada@sony.com>
To:     andrii@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH v5 0/3] Fix the incorrect register read for syscalls on x86_64
Date:   Mon, 24 Jan 2022 23:16:19 +0900
Message-Id: <20220124141622.4378-1-Kenta.Tada@sony.com>
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

v4 -> v5:
- Modify the CORE variant macro not to read memory directly.
- Remove the unnecessary comment.
- Add a selftest for the CORE variant.

Kenta Tada (3):
  libbpf: Extract syscall wrapper
  libbpf: Fix the incorrect register read for syscalls on x86_64
  libbpf: Add a test to confirm PT_REGS_PARM4_SYSCALL

 tools/lib/bpf/bpf_tracing.h                   | 34 ++++++++++
 .../bpf/prog_tests/test_bpf_syscall_macro.c   | 63 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 19 ++++++
 .../selftests/bpf/progs/bpf_syscall_macro.c   | 64 +++++++++++++++++++
 .../selftests/bpf/progs/test_probe_user.c     | 15 +----
 5 files changed, 181 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_misc.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c

-- 
2.32.0

