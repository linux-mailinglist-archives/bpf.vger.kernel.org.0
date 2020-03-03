Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0625717785B
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 15:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgCCOKC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 09:10:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34103 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgCCOKC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 09:10:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id z15so4548171wrl.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JL2Fpw/lCnaQ/XUN6zAHALWLaBMkxZHS+mEJ+EF0ZVY=;
        b=laBzjI5h6krI1uPEgUkHv/ZKSQ+Z8ids/RVkJijNF9hmmkdASTBoYnB/7xl7Hgb1Mg
         BubzGGprkGLSjK6uC17l7JKFmAuNKQAe7mebom121Rb1ZX7t8afUG1d1oG5ksP4iW46a
         WR8Rvo74RTKxnPZPwBPH3sMykyYqZfLGRC0mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JL2Fpw/lCnaQ/XUN6zAHALWLaBMkxZHS+mEJ+EF0ZVY=;
        b=KnV4dR0Uie/DGadFuyxZNwbvJg+qwa0ogArZ3q1piY0V6P5dwOSHeu7x//HZtkBUtB
         E0asFscsLAi2P6ZdZ1gE9EaM5Q3/PAvxOFWrOGZD6Hr9VRu0tld061M8yUXBRdAtdlSX
         eO//1nrFt8ZaLO0BfKQD803SH8xogU1zJAfXaamgZX6L6DSCOtts5SHAHchHrh9wI1yZ
         M4abed/dlbPjzB2HAjyGrn4rSiKW7ZICeSHBaFDOEZZB2vzIOFLz/Dv/S2URyy3VByfz
         sNTgZVW41J5a1tcvFgZbzHyM5mosenVzjp6sPAZxcH0VHmRBlO072eHskPBNqKLhJxQt
         0WBA==
X-Gm-Message-State: ANhLgQ3goVh4nC2ZZWK7TmwXBKCSQ9X4U7y757G3Xgcy1PU/LLti6HGe
        pSjOKjfVmLWLCxz+qMZnnoPJyg==
X-Google-Smtp-Source: ADFU+vuL6Zt9apvq5/5BIeAmC8CeHZPk64Alb7HZEf7e0A/TFMw48bXS8bAGo5m+C3cCwKs6DCLf0Q==
X-Received: by 2002:a05:6000:10c8:: with SMTP id b8mr5438416wrx.287.1583244600891;
        Tue, 03 Mar 2020 06:10:00 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:2811:c80d:9375:bf8a])
        by smtp.gmail.com with ESMTPSA id h20sm11746823wrc.47.2020.03.03.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:10:00 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next 0/7] Introduce BPF_MODIFY_RET tracing progs.
Date:   Tue,  3 Mar 2020 15:09:43 +0100
Message-Id: <20200303140950.6355-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

This was brought up in the KRSI v4 discussion and found to be useful
both for security and tracing programs.

  https://lore.kernel.org/bpf/20200225193108.GB22391@chromium.org/

The modify_return programs are allowed for security hooks (with an
extra CAP_MAC_ADMIN check) and functions whitelisted for error
injection (ALLOW_ERROR_INJECTION).

The "security_" check is expected to be cleaned up with the KRSI patch
series.

Here is an example of how a fmod_ret program behaves:

int func_to_be_attached(int a, int b)
{  <--- do_fentry

do_fmod_ret:
   <update ret by calling fmod_ret>
   if (ret != 0)
        goto do_fexit;

original_function:

    <side_effects_happen_here>

}  <--- do_fexit

ALLOW_ERROR_INJECTION(func_to_be_attached, ERRNO)

The fmod_ret program attached to this function can be defined as:

SEC("fmod_ret/func_to_be_attached")
BPF_PROG(func_name, int a, int b, int ret)
{
        // This will skip the original function logic.
        return -1;
}

KP Singh (7):
  bpf: Refactor trampoline update code
  bpf: JIT helpers for fmod_ret progs
  bpf: Introduce BPF_MODIFY_RETURN
  bpf: Attachment verification for BPF_MODIFY_RETURN
  tools/libbpf: Add support for BPF_MODIFY_RETURN
  bpf: Add test ops for BPF_PROG_TYPE_TRACING
  bpf: Add selftests for BPF_MODIFY_RETURN

 arch/x86/net/bpf_jit_comp.c                   | 261 +++++++++++++-----
 include/linux/bpf.h                           |  24 +-
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/bpf_struct_ops.c                   |  13 +-
 kernel/bpf/btf.c                              |  27 +-
 kernel/bpf/syscall.c                          |   1 +
 kernel/bpf/trampoline.c                       |  66 +++--
 kernel/bpf/verifier.c                         |  32 +++
 kernel/trace/bpf_trace.c                      |   1 +
 net/bpf/test_run.c                            |  57 +++-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/libbpf.c                        |   4 +
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  12 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |  14 +-
 .../selftests/bpf/prog_tests/fexit_test.c     |  69 ++---
 .../selftests/bpf/prog_tests/modify_return.c  |  65 +++++
 .../selftests/bpf/progs/modify_return.c       |  49 ++++
 17 files changed, 509 insertions(+), 188 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/modify_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return.c

-- 
2.20.1

