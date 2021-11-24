Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113A545B6B9
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 09:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhKXIpz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 03:45:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241500AbhKXIod (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 03:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637743283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u/va+vlehAJlaxnJ1ZxySwl63uZqtCxIq5+CeD0JTug=;
        b=B3zkKhcWjDONF5v00LAQ8W9Z7LGb4kkIXRnHXfthsLJzDwZR9qTScc9XKvJI5BZg6jZnIR
        Vu43Olx/sJXtsz4xd/UtBNnNcwZHfhroFm652OhDflTEq0G2u65en7yKzFyfnEvDGpSivC
        ETMHeG5wXpG5ZM0G713xn3VgkBp7QRc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-OdrQBsk6OFi89pC2r9xtqQ-1; Wed, 24 Nov 2021 03:41:22 -0500
X-MC-Unique: OdrQBsk6OFi89pC2r9xtqQ-1
Received: by mail-wm1-f70.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so1008929wmq.9
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 00:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/va+vlehAJlaxnJ1ZxySwl63uZqtCxIq5+CeD0JTug=;
        b=4KhfBvca6tcdIvDmErp4TZsv05yc5MIXYBPYTjpSSdY1JMK4RNNfU0tk2GnRG0CmLL
         +lwVYVa26XWmN39vHT6BrPulOy8svs5aFImXHZSe9emY1XXRSOkwohuxuQ6gmiZmGbOJ
         C9ukNTFzwn9s42Zjik9Jr1pSPlYHJ1shqf7tFqtmwd3PV106QOsO9b2dT+ixps2BuCrH
         3cvhMf6cUII3+lha7VIgiSdohGBIClq0WogijB2PqX7Nd1oGY4udVJmVbRd/k7g8THIu
         fkZyhlhGeGzaukVOPR7fwBfwnGss052RLW8NTp5mALiaqPWrK76U8s8MP5qNbdaVlHGp
         DSpw==
X-Gm-Message-State: AOAM531v1cLJddSrRuqGzHsJdxci0mCRQsU4f/XvLj3ZbLpmwbSVHx9v
        u4lT/yno8KjHwSG4XevKPYrlrlpA0xifyoRvWB2/1NligqcC5OTSbldqY4j++rrSx8LLrQmrmXJ
        4fsWiPcalq1py
X-Received: by 2002:a5d:47a1:: with SMTP id 1mr15880043wrb.436.1637743280717;
        Wed, 24 Nov 2021 00:41:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWGTplK/9gxTkHrPX7ToYBzdn9CjvD6F3A+rSgEpL5LIhBlGtlV2H4nGfmNsCx7aWrxZljvg==
X-Received: by 2002:a5d:47a1:: with SMTP id 1mr15880016wrb.436.1637743280545;
        Wed, 24 Nov 2021 00:41:20 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id bg12sm5272528wmb.5.2021.11.24.00.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 00:41:20 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [RFC 0/8] perf/bpf: Add batch support for [ku]probes attach
Date:   Wed, 24 Nov 2021 09:41:11 +0100
Message-Id: <20211124084119.260239-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
adding support to create multiple kprobes/uprobes within single
perf event. This way we can associate single bpf program with
multiple kprobes.

Sending this as RFC because I'm not completely sure I haven't
missed anything in the trace/events area.

Also it needs following uprobe fix to work properly:
  https://lore.kernel.org/lkml/20211123142801.182530-1-jolsa@kernel.org/

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/kuprobe_batch

thanks,
jirka


---
Jiri Olsa (8):
      perf/kprobe: Add support to create multiple probes
      perf/uprobe: Add support to create multiple probes
      libbpf: Add libbpf__kallsyms_parse function
      libbpf: Add struct perf_event_open_args
      libbpf: Add support to attach multiple [ku]probes
      libbpf: Add support for k[ret]probe.multi program section
      selftest/bpf: Add kprobe multi attach test
      selftest/bpf: Add uprobe multi attach test

 include/uapi/linux/perf_event.h                            |   1 +
 kernel/trace/trace_event_perf.c                            | 214 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 kernel/trace/trace_kprobe.c                                |  47 ++++++++++++++++---
 kernel/trace/trace_probe.c                                 |   2 +-
 kernel/trace/trace_probe.h                                 |   6 ++-
 kernel/trace/trace_uprobe.c                                |  43 +++++++++++++++--
 tools/include/uapi/linux/perf_event.h                      |   1 +
 tools/lib/bpf/libbpf.c                                     | 235 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 tools/lib/bpf/libbpf.h                                     |  25 +++++++++-
 tools/lib/bpf/libbpf_internal.h                            |   5 ++
 tools/testing/selftests/bpf/prog_tests/multi_kprobe_test.c |  83 +++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/multi_uprobe_test.c |  97 ++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/multi_kprobe.c           |  58 +++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/multi_uprobe.c           |  26 +++++++++++
 14 files changed, 765 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/multi_kprobe_test.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/multi_uprobe_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/multi_kprobe.c
 create mode 100644 tools/testing/selftests/bpf/progs/multi_uprobe.c

