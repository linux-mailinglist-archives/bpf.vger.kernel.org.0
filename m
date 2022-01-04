Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3095A483DAF
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 09:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiADIJs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 03:09:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232556AbiADIJr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jan 2022 03:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641283787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=r+pJGFCaBi00UwfNIQiKj+H5FCtGgxgoDD8u3lefA54=;
        b=ABXoDyLUOi142VOtMDGVh5sOdhpXyYAe9ugtx+VwE4Zqs2c2iq9wIV1LUoh2ExssvRidle
        etEA5Fqnm3PEdKnOTDSg+0Sr33XXGDQCT5Azp/5+aTo/4PqAG23UHlX95pud2EP6MeU0ti
        01ImIyJK9tzJz98Ir2RV4C80i2BmMlo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-L_wAOJqvP2SFjxdQ1x8yfA-1; Tue, 04 Jan 2022 03:09:46 -0500
X-MC-Unique: L_wAOJqvP2SFjxdQ1x8yfA-1
Received: by mail-wm1-f70.google.com with SMTP id o18-20020a05600c511200b00345c1603997so7801621wms.1
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 00:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+pJGFCaBi00UwfNIQiKj+H5FCtGgxgoDD8u3lefA54=;
        b=jzz86mBtf6laZE6aSqVQ/vqOCPO7SfQVWHrIbQjesyR8XKU2j9VbmST43wcg04Y5JM
         JukJTpaBWnctfr8TcY5QuWQWzm/kPBcJt5NL3ovHMQ0Yff2+VhHxGuasP4/WpMvzqmE2
         YimJk8acOmXlY5I2tfKk8y2yge+uDyoeThL9OmUfXd4zS4YLyX1yObp4mx0FzoF1AP+2
         Crs0MweGwtw5bmCRwXzCWfE0BsOtPhD16JZFIQ9sElVynocgE67Qe+jXmT+vpNcI5rl/
         hyqftP/exEDp4FfmI0K3UpQBPeWsPYiWefNMxYj+e/aXn5vK+PiHdTwEEbLwbBXmxh7l
         NUzA==
X-Gm-Message-State: AOAM532S4C7nShfYTdVyqdHwekQG+Gfjjs6Ka7AIabBo8cc7DC2brzsC
        wCpJ9LEDJqdhOR4fs4Kqp7C4I13KyyAYoNDITPEPUhn9hVdwLaoeuSjXmuFw7xStHDU0pvJGZCI
        R3Rar6M6vWRZj
X-Received: by 2002:a1c:4641:: with SMTP id t62mr41502888wma.100.1641283784911;
        Tue, 04 Jan 2022 00:09:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRAl10hto62ikaFvjmh+RWxhdWA+ui1s2lKp3RllvobTON1Us//OixMaQvQYZghnkwzi/66Q==
X-Received: by 2002:a1c:4641:: with SMTP id t62mr41502858wma.100.1641283784619;
        Tue, 04 Jan 2022 00:09:44 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id p13sm31211324wrs.54.2022.01.04.00.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 00:09:44 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC 00/13] kprobe/bpf: Add support to attach multiple kprobes
Date:   Tue,  4 Jan 2022 09:09:30 +0100
Message-Id: <20220104080943.113249-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
adding support to attach multiple kprobes within single syscall
and speed up attachment of many kprobes.

The previous attempt [1] wasn't fast enough, so coming with new
approach that adds new kprobe interface.

The attachment speed of of this approach (tested in bpftrace)
is now comparable to ftrace tracer attachment speed.. fast ;-)

The limit of this approach is forced by using ftrace as attach
layer, so it allows only kprobes on function's entry (plus
return probes).

This patchset contains:
  - kprobes support to register multiple kprobes with current
    kprobe API (patches 1 - 8)
  - bpf support ot create new kprobe link allowing to attach
    multiple addresses (patches 9 - 14)

We don't need to care about multiple probes on same functions
because it's taken care on the ftrace_ops layer.

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  kprobe/multi

thanks,
jirka

[1] https://lore.kernel.org/bpf/20211124084119.260239-1-jolsa@kernel.org/


---
Jiri Olsa (13):
      ftrace: Add ftrace_set_filter_ips function
      kprobe: Keep traced function address
      kprobe: Add support to register multiple ftrace kprobes
      kprobe: Add support to register multiple ftrace kretprobes
      kprobe: Allow to get traced function address for multi ftrace kprobes
      samples/kprobes: Add support for multi kprobe interface
      samples/kprobes: Add support for multi kretprobe interface
      bpf: Add kprobe link for attaching raw kprobes
      libbpf: Add libbpf__kallsyms_parse function
      libbpf: Add bpf_link_create support for multi kprobes
      libbpf: Add bpf_program__attach_kprobe_opts for multi kprobes
      selftest/bpf: Add raw kprobe attach test
      selftest/bpf: Add bpf_cookie test for raw_k[ret]probe

 arch/Kconfig                                             |   3 ++
 arch/x86/Kconfig                                         |   1 +
 arch/x86/kernel/kprobes/ftrace.c                         |  51 +++++++++++++-----
 include/linux/bpf_types.h                                |   1 +
 include/linux/ftrace.h                                   |   3 ++
 include/linux/kprobes.h                                  |  55 ++++++++++++++++++++
 include/uapi/linux/bpf.h                                 |  12 +++++
 kernel/bpf/syscall.c                                     | 191 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/kprobes.c                                         | 264 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 kernel/trace/bpf_trace.c                                 |   7 ++-
 kernel/trace/ftrace.c                                    |  53 +++++++++++++++----
 samples/kprobes/kprobe_example.c                         |  47 +++++++++++++++--
 samples/kprobes/kretprobe_example.c                      |  43 +++++++++++++++-
 tools/include/uapi/linux/bpf.h                           |  12 +++++
 tools/lib/bpf/bpf.c                                      |   5 ++
 tools/lib/bpf/bpf.h                                      |   7 ++-
 tools/lib/bpf/libbpf.c                                   | 186 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 tools/lib/bpf/libbpf_internal.h                          |   5 ++
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c      |  42 +++++++++++++++
 tools/testing/selftests/bpf/prog_tests/raw_kprobe_test.c |  92 +++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/get_func_ip_test.c     |   4 +-
 tools/testing/selftests/bpf/progs/raw_kprobe.c           |  58 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_bpf_cookie.c      |  24 ++++++++-
 23 files changed, 1062 insertions(+), 104 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_kprobe_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/raw_kprobe.c

