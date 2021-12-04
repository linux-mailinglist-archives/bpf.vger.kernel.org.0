Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC246853A
	for <lists+bpf@lfdr.de>; Sat,  4 Dec 2021 15:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385144AbhLDOKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Dec 2021 09:10:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1385141AbhLDOKa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 4 Dec 2021 09:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638626824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cOdYTEZmaIlv5IppN0FZFDrUkHw6ggGqnaTF4PDq7Qg=;
        b=IuzbuEdxlu74r4SLiOYknxYUjEg3f7jZuXSPutFiIJRHr3eEO0yzePoZktJQjsxv1/Kymi
        XTJK0I5ky4gKwu2kXUoSx62+ZUX/vlCSArr3GsVNiRFdPVmKNla9q9IBtabYv1WU1TWEEk
        BKPGsZlkTk63HIu7Tb67W1Vb7SwuMKU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-P7Dpl5TkPCm3h7qYKusmmg-1; Sat, 04 Dec 2021 09:07:03 -0500
X-MC-Unique: P7Dpl5TkPCm3h7qYKusmmg-1
Received: by mail-wm1-f71.google.com with SMTP id ay17-20020a05600c1e1100b0033f27b76819so3194609wmb.4
        for <bpf@vger.kernel.org>; Sat, 04 Dec 2021 06:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cOdYTEZmaIlv5IppN0FZFDrUkHw6ggGqnaTF4PDq7Qg=;
        b=C5n6114vFGqeJdNlfsgE0E0Woa7gOW2klVMh63NLHDL7KGng7j1SXZ+H1ov3ELcGtb
         2r8gzhdLN3SkB7WYQImvS7d9vJ0t3p+1d/fNXX3rKYl6GvYQcbyJisLpQRdntPUD8IrU
         68t95LwzwhAqesbVMei2YpVRiVBlIYE+zV3ie6rDYEEJIXXE7cxbffD3xLncG+6TyJDG
         uAw13CLq/BBuG/pE+J4OtzViawCWfcOkkpcVtj6M37lqVq1JcpRBuAENxDT0Ro4GBaaF
         I2GIPMl8C04GM4E5M1Wo5UJ3i/Q5rGCsxKlYF2oJwytMBsJ8fj6Nb4FlRlDB/GhW3AUm
         J+EQ==
X-Gm-Message-State: AOAM531M9nNNckp2RH55VqbFfhAx/RBRMFK1tHcrlmgUdIJUCBLS8d/E
        mKdLBZH5+LSvQwOrakACnQwcTEr2Y1Ey2dRJaq9vt68Z0EnP519KyRxsMbEiB230jLZKsyZf5e0
        saRNcai4rQ2BI
X-Received: by 2002:a5d:4989:: with SMTP id r9mr28514326wrq.14.1638626822106;
        Sat, 04 Dec 2021 06:07:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNKAK0HUtMITjRd+ZyXSm1XTXxwpkjejiQgvuHlN7hMdvUounBStqVDU/jkHmmtEsT4FnjJQ==
X-Received: by 2002:a5d:4989:: with SMTP id r9mr28514305wrq.14.1638626821958;
        Sat, 04 Dec 2021 06:07:01 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id i17sm6359714wmq.48.2021.12.04.06.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:07:01 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 0/3] bpf: Add helpers to access traced function arguments
Date:   Sat,  4 Dec 2021 15:06:57 +0100
Message-Id: <20211204140700.396138-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
adding new helpers to access traced function arguments that
came out of the trampoline batch changes [1].

  Get n-th argument of the traced function:
    long bpf_get_func_arg(void *ctx, u32 n, u64 *value)
  
  Get return value of the traced function:
    long bpf_get_func_ret(void *ctx, u64 *value)
  
  Get arguments count of the traced funtion:
    long bpf_get_func_arg_cnt(void *ctx)

changes from original post [1]:
  - change helpers names to get_func_*
  - change helpers to return error values instead of
    direct values
  - replaced stack_size usage with specific offset
    variables in arch_prepare_bpf_trampoline
  - add comment on stack layout
  - add more tests
  - allow bpf_get_func_ret in FENTRY programs
  - use BPF_LSH instead of BPF_MUL

thanks,
jirka


[1] https://lore.kernel.org/bpf/20211118112455.475349-1-jolsa@kernel.org/
---
Jiri Olsa (3):
      bpf, x64: Replace some stack_size usage with offset variables
      bpf: Add get_func_[arg|ret|arg_cnt] helpers
      selftests/bpf: Add tests for get_func_[arg|ret|arg_cnt] helpers

 arch/x86/net/bpf_jit_comp.c                                 |  55 +++++++++++++++++++++++++++++++++------------
 include/uapi/linux/bpf.h                                    |  28 +++++++++++++++++++++++
 kernel/bpf/verifier.c                                       |  73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/bpf_trace.c                                    |  58 ++++++++++++++++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h                              |  28 +++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/get_func_args_test.c |  38 +++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/get_func_args_test.c      | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 375 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_args_test.c

