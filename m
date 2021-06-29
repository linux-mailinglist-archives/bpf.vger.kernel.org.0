Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1963B78A3
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 21:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhF2TcX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 15:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234180AbhF2TcV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 15:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624994993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EXphjE5iDPBSdRkWFkye1lTrfv8N97NQ//BDC7tfWi4=;
        b=Yj4lXm1eEk5nS/2Cjrf+GciW8byTyO21EdTmMKmqUYBCOmMTvTqmOVpqcgnPbe2m712lNN
        rUdoc367z1Tc7WI/Bx+5ybY2T+x5ZtUrjns7DY/QIQZQPjOqqkC2FMkLGEonXFp/iYhOIu
        +6ReQ5b3MZWXsN50bUe9eiJLhLtExhg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-1lCOL0eQMViVMcAuST7_3g-1; Tue, 29 Jun 2021 15:29:52 -0400
X-MC-Unique: 1lCOL0eQMViVMcAuST7_3g-1
Received: by mail-ej1-f69.google.com with SMTP id j26-20020a170906411ab02904774cb499f8so6086896ejk.6
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 12:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EXphjE5iDPBSdRkWFkye1lTrfv8N97NQ//BDC7tfWi4=;
        b=D2STNVqQGaj15Qd0d1J2wvX07pidHD4/xXlYZKVHUVpc3Wes5cIkCBO5/gaPgr8VGy
         cQmV/HnWYG2YqEKTRrQDzpAfaKNTt/AawsMXX1O7l+mx4PJHOsvosQh4dss5KzNKa87p
         kXdlZoLneQGa42lfJxDoIx+30kQuHURLjRuvFY939s3jB8YeXwRH560Lw0M/eSAwwbK9
         bLfUOTH7ft1qlTougopySaYloBame/8yEad3n7vpOhXul2fI6+yWlY7nUA3oukvi8qwZ
         uOKPaVakKCaFHNnsW1RcFErpdkmkHn6xXrIj3kbud7+XpnU5eyiff3IiTCZH1X7HfbBI
         nFQw==
X-Gm-Message-State: AOAM530MZmoDpw4YLSd+EdeJqQIfHt7IhK0xTZK8I61ADhjIvBREf8Zs
        KwHBe51xV8gWRVfnYzfbWwODTJxE5fFWpJQZkwc4tg5QjAsNWf3nvpITMzuOjR6b7jDTV+g+gsh
        /VgzneP6kUUua
X-Received: by 2002:a17:906:cb81:: with SMTP id mf1mr32378928ejb.199.1624994988569;
        Tue, 29 Jun 2021 12:29:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+JyIotMLeITE1z4hHGqD9QoJk9a6CpkIRr0d92trk3HAASPjHtbjZIssFROgiR8XvaLgiKg==
X-Received: by 2002:a17:906:cb81:: with SMTP id mf1mr32378911ejb.199.1624994988335;
        Tue, 29 Jun 2021 12:29:48 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id n22sm472559eje.3.2021.06.29.12.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:29:47 -0700 (PDT)
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
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC bpf-next 0/5] bpf, x86: Add bpf_get_func_ip helper
Date:   Tue, 29 Jun 2021 21:29:40 +0200
Message-Id: <20210629192945.1071862-1-jolsa@kernel.org>
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

The trampoline extra 3 instructions for storing IP address
is now optional, which I'm not completely sure is necessary,
so I plan to do some benchmarks, if it's noticeable, hence
the RFC. I'm also not completely sure about the kprobe/kretprobe
implementation.

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/get_func_ip

thanks,
jirka


---
Jiri Olsa (5):
      bpf, x86: Store caller's ip in trampoline stack
      bpf: Enable BPF_TRAMP_F_IP_ARG for trampolines with call_get_func_ip
      bpf: Add bpf_get_func_ip helper for tracing programs
      bpf: Add bpf_get_func_ip helper for kprobe programs
      selftests/bpf: Add test for bpf_get_func_ip helper

 arch/x86/net/bpf_jit_comp.c                               | 19 +++++++++++++++++++
 include/linux/bpf.h                                       |  5 +++++
 include/linux/filter.h                                    |  3 ++-
 include/uapi/linux/bpf.h                                  |  7 +++++++
 kernel/bpf/trampoline.c                                   | 12 +++++++++---
 kernel/bpf/verifier.c                                     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c                                  | 29 +++++++++++++++++++++++++++++
 kernel/trace/trace_kprobe.c                               | 20 ++++++++++++++++++--
 kernel/trace/trace_probe.h                                |  5 +++++
 tools/include/uapi/linux/bpf.h                            |  7 +++++++
 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/get_func_ip_test.c      | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 260 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_test.c

