Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB71787CA
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 02:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbgCDBzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 20:55:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36438 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbgCDBzh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 20:55:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id g83so157384wme.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 17:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ULM9+8eqPT9CsVtMTvsIR7p53e8plFynKvOU9FgO6s=;
        b=EcGjoIb6GySi296NeymUIZeDg4qK2dUIITK6rKY1iPmg9S3lywvp8xL6Lw18YVkuZb
         8dk+cQKL3lYuPTryI6D21RFHF6c806hlp5XtmG/mzG7wUJFHzAPCtt7h8B/EmoMUH2Qu
         dZiBQtkK6PIlbmRgxPL+3ug4U3nTZtNeg0Fkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ULM9+8eqPT9CsVtMTvsIR7p53e8plFynKvOU9FgO6s=;
        b=mrg9MjeC7DcJOUhRTgprd7TyMbQVoZL5dONPj9JGCYXgTw3nWHMKLiww+/7SgPSZ0r
         hY+fPsuF1vt3iOG0/EAtwZvA8Qyc8ei54TXv6DtsZacvtEOli9o2wZTdk9dsQSpkkmmq
         sNLllPOtBq+Lvjd2er6+2RJcshtVXwvs13BwKCBmWOaSS3XQSqyQE5TrnUTImtEDO37E
         xE7eSLB0r36x8Gp2HOynYjK92bBn9+LoMdL+82/gHU7i55Bm7Ao7OyCo0j3mCTLm5fre
         HxaXWVRVQSqma2EyUtfQEEoAia9w0R61P3/jRZ4hJ/+/PgcnNyefMFtg41o86WHKdy3s
         9/bw==
X-Gm-Message-State: ANhLgQ1UKormInks4aA6F4vPkVBwr6WM4Z2EC4nWgbJIwyO7bf3j2RLD
        qI8NVptKtSjZnAD9D0in4WMDcA==
X-Google-Smtp-Source: ADFU+vs/DttNPA1ej1oCMfwJsHfsV7V/d2SAFp2Fohk2+Jq7MI54p0V100pBLoGa53y2dK3+svb/pg==
X-Received: by 2002:a05:600c:146:: with SMTP id w6mr619008wmm.180.1583286934589;
        Tue, 03 Mar 2020 17:55:34 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a184sm1475444wmf.29.2020.03.03.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:55:33 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 0/7] Introduce BPF_MODIFY_RET tracing progs
Date:   Wed,  4 Mar 2020 02:55:21 +0100
Message-Id: <20200304015528.29661-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

v1 -> v2:

* Adressed Andrii's feedback.
* Fixed a bug that Alexei noticed about nop generation.
* Rebase.

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
int BPF_PROG(func_name, int a, int b, int ret)
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

 arch/x86/net/bpf_jit_comp.c                   | 279 +++++++++++++-----
 include/linux/bpf.h                           |  24 +-
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/bpf_struct_ops.c                   |  12 +-
 kernel/bpf/btf.c                              |  27 +-
 kernel/bpf/syscall.c                          |   1 +
 kernel/bpf/trampoline.c                       |  65 ++--
 kernel/bpf/verifier.c                         |  32 ++
 kernel/trace/bpf_trace.c                      |   1 +
 net/bpf/test_run.c                            |  57 +++-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/libbpf.c                        |   4 +
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  12 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |  14 +-
 .../selftests/bpf/prog_tests/fexit_test.c     |  69 ++---
 .../selftests/bpf/prog_tests/modify_return.c  |  65 ++++
 .../selftests/bpf/progs/modify_return.c       |  49 +++
 17 files changed, 526 insertions(+), 187 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/modify_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/modify_return.c

-- 
2.20.1

