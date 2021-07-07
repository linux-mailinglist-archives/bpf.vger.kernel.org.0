Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA633BF18F
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 23:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhGGVvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 17:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232732AbhGGVvC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 17:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625694501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aS1dgZe1Y+a0DEt2IGEpVJBZTvoEoYf9KumylbJq+vo=;
        b=iQ0k8kUPtwcBNHOIplCjfxGUSu8GEOGn+OptOnqB8Ug2GMVlD2T4X5iNHLdlcV5kCALqUZ
        zmnPp1Zb6tH/0DKivzOacwZ+tAEOxLSt1DSVE8eXG4Tmz06tjb/gkLkhlymVBHL1yj0M/3
        sRCqpmTy+Inq0h1vA4wVLD8h5cwYgio=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-X_lx-UibP9Kkk3fBDRBiJg-1; Wed, 07 Jul 2021 17:48:00 -0400
X-MC-Unique: X_lx-UibP9Kkk3fBDRBiJg-1
Received: by mail-wm1-f71.google.com with SMTP id z4-20020a1ce2040000b02901ee8d8e151eso3019722wmg.1
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 14:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aS1dgZe1Y+a0DEt2IGEpVJBZTvoEoYf9KumylbJq+vo=;
        b=OTykKPKDhshjwHmQOXAtOxw0kKKtHgfl2EBqRnbB/Vy6qvsNvR18Rml0ctUAkWr5D5
         7GsJC1X4jjCE8gzGLrPzMFm9eMyZYR9b7q1EYoKj+qZi+8zIe6NMoFrVKM/6D3FPxk4H
         6l4uBRw5g345sEcWwY8yw3Al//Ykek6XJ1niqrVhplNeZcmutYQTJDc5qxP+LuvMKHe5
         ZOrI6u71qjrHOuUjx9vRnmjuOGgPfcxaWLzcO/s3z9ScWUUVFGNudqlvOX6FtNftb3Bu
         LzpyZn6eeRjujJmwmnjXLTLPUyYdGjWxVZvuuXGJGrqjJvXIbi9eWr7FJorhTb7aGZbT
         JjkQ==
X-Gm-Message-State: AOAM533bk+3nY1tzNaXmlpaFC0kgxaSyoLiFkGIsKbn2lFWpSHm/rrMD
        y5cZc2c2uhng2U+gbgv1v5xmUDFuju+YqlcAT8YznvpmaPcFukStSRRwvblWB+rNVMXnzgIl9yV
        zdPP1Kco4EUjs
X-Received: by 2002:a05:600c:26d1:: with SMTP id 17mr29243365wmv.1.1625694478871;
        Wed, 07 Jul 2021 14:47:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHPk6iYAbt1Q8J4/o3Q4ktkuU6/y4jq8VFumBVfJBJ6xesYnLDsn6jLfhOkQ+a4dYB0rODlQ==
X-Received: by 2002:a05:600c:26d1:: with SMTP id 17mr29243333wmv.1.1625694478600;
        Wed, 07 Jul 2021 14:47:58 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id p9sm132426wmm.17.2021.07.07.14.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 14:47:58 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv3 bpf-next 0/7] bpf, x86: Add bpf_get_func_ip helper
Date:   Wed,  7 Jul 2021 23:47:44 +0200
Message-Id: <20210707214751.159713-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
adding bpf_get_func_ip helper that returns IP address of the
caller function for trampoline and krobe programs.

There're 2 specific implementation of the bpf_get_func_ip
helper, one for trampoline progs and one for kprobe/kretprobe
progs.

The trampoline helper call is replaced/inlined by verifier
with simple move instruction. The kprobe/kretprobe is actual
helper call that returns prepared caller address.

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/get_func_ip

v3 changes:
  - resend with Masami in cc and v3 in each patch subject

v2 changes:
  - use kprobe_running to get kprobe instead of cpu var [Masami]
  - added support to add kprobe on function+offset
    and test for that [Alan]

thanks,
jirka


---
Alan Maguire (1):
      libbpf: allow specification of "kprobe/function+offset"

Jiri Olsa (6):
      bpf, x86: Store caller's ip in trampoline stack
      bpf: Enable BPF_TRAMP_F_IP_ARG for trampolines with call_get_func_ip
      bpf: Add bpf_get_func_ip helper for tracing programs
      bpf: Add bpf_get_func_ip helper for kprobe programs
      selftests/bpf: Add test for bpf_get_func_ip helper
      selftests/bpf: Add test for bpf_get_func_ip in kprobe+offset probe

 arch/x86/net/bpf_jit_comp.c                               | 19 +++++++++++++++++++
 include/linux/bpf.h                                       |  5 +++++
 include/linux/filter.h                                    |  3 ++-
 include/uapi/linux/bpf.h                                  |  7 +++++++
 kernel/bpf/trampoline.c                                   | 12 +++++++++---
 kernel/bpf/verifier.c                                     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c                                  | 32 ++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h                            |  7 +++++++
 tools/lib/bpf/libbpf.c                                    | 20 +++++++++++++++++---
 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/get_func_ip_test.c      | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 270 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_test.c

