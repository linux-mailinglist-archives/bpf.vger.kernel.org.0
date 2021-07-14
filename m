Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5182B3C81E9
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbhGNJq5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 05:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238337AbhGNJq5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 05:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626255845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0D9ukt7qB56uK/hBk92lnpU4cS9y6bOApajJoXJPabo=;
        b=JJ/Mg8Ma+G5VYrAEbG6a2DMNHRWPgd2nZWzQTZLyfHHRpgjo+fxEWDylZ+Ltozj84eNqEU
        3GVlnHzc3NskoifxGBfwAj7DTMnxBsts83h2w1JZZ1zl2722FNh7wiZwbsJIdJkOoYFr9m
        OeWRpuPGBU9XdS+JBxV45y1dRRr06Vo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-1TAzEvjgNd6N0SN2FppDRA-1; Wed, 14 Jul 2021 05:44:04 -0400
X-MC-Unique: 1TAzEvjgNd6N0SN2FppDRA-1
Received: by mail-wr1-f70.google.com with SMTP id u13-20020a5d6dad0000b029012e76845945so1204279wrs.11
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 02:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0D9ukt7qB56uK/hBk92lnpU4cS9y6bOApajJoXJPabo=;
        b=lgLG1PqPM1YXuaHEYODooQ108SWeeeL/UIpibr5Bgh3CDzSZNiF40kN88wTZxwFQbx
         repQv+RbGYxR2SmFqSR/dmQR4M7dZJSI8OkxnqwnJCwR21AYinn3d9kAJlgs8CPN+CrO
         uFOzCb1UWUEnyF/alKqmh8ZpYFrNzMILM4CZg5rRPBOUTZg68kRVCt+58kHaidoMxF7l
         bTyJSBIyhR3vhg4nG0vI+0rU8ZhtkspiFdk7ZwQttvvFNn0z9LKzxOYwC3k8RucXyOlv
         2Ku5iVa8TDfzKkN9zTolJU/VfukpSr6ROvMidSfZn6TQ0omJaENAszT/gXH9fxqPaOia
         9VAQ==
X-Gm-Message-State: AOAM5327DokSqByfJp0ZsKZ0bnnW+w2ihQCy73N68ukXFM/IUTo4H8c/
        kv5cXiORFSP4DDB2PhrC3e40x0E+mUCJvCFipuyrdjmDygmzxFG6+sDunv9U721Dyz+co0Z7Mqi
        KJkBNTc6f/ue8
X-Received: by 2002:a7b:c1cd:: with SMTP id a13mr2967291wmj.75.1626255843418;
        Wed, 14 Jul 2021 02:44:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZBfbmvy8UQ9tfa+4EkO3eaENU8IunXkfstU3E9v7lbvEVtMfpeYqOrmDbs/AaTyVEsg7GKw==
X-Received: by 2002:a7b:c1cd:: with SMTP id a13mr2967275wmj.75.1626255843260;
        Wed, 14 Jul 2021 02:44:03 -0700 (PDT)
Received: from krava.redhat.com ([5.171.203.6])
        by smtp.gmail.com with ESMTPSA id s24sm2181441wra.33.2021.07.14.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:44:02 -0700 (PDT)
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
Subject: [PATCHv4 bpf-next 0/8] bpf, x86: Add bpf_get_func_ip helper
Date:   Wed, 14 Jul 2021 11:43:52 +0200
Message-Id: <20210714094400.396467-1-jolsa@kernel.org>
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

v4 changes:
  - dropped jit/x86 check for get_func_ip tracing check [Alexei]
  - added code to bpf_get_func_ip_tracing [Alexei]
    and tested that it works without inlining [Alexei]
  - changed has_get_func_ip to check_get_func_ip [Andrii]
  - replaced test assert loop with explicit asserts [Andrii]
  - adde bpf_program__attach_kprobe_opts function
    and use it for offset setup [Andrii]
  - used bpf_program__set_autoload(false) for test6 [Andrii]
  - added Masami's ack

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
      libbpf: Allow specification of "kprobe/function+offset"

Jiri Olsa (7):
      bpf, x86: Store caller's ip in trampoline stack
      bpf: Enable BPF_TRAMP_F_IP_ARG for trampolines with call_get_func_ip
      bpf: Add bpf_get_func_ip helper for tracing programs
      bpf: Add bpf_get_func_ip helper for kprobe programs
      selftests/bpf: Add test for bpf_get_func_ip helper
      libbpf: Add bpf_program__attach_kprobe_opts function
      selftests/bpf: Add test for bpf_get_func_ip in kprobe+offset probe

 arch/x86/net/bpf_jit_comp.c                               | 19 +++++++++++++++++++
 include/linux/bpf.h                                       |  5 +++++
 include/linux/filter.h                                    |  3 ++-
 include/uapi/linux/bpf.h                                  |  7 +++++++
 kernel/bpf/trampoline.c                                   | 12 +++++++++---
 kernel/bpf/verifier.c                                     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c                                  | 31 +++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h                            |  7 +++++++
 tools/lib/bpf/libbpf.c                                    | 56 ++++++++++++++++++++++++++++++++++++++++++++++----------
 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/get_func_ip_test.c      | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 297 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_test.c

