Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF975AED
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2019 00:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfGYWwe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jul 2019 18:52:34 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39506 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfGYWwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jul 2019 18:52:34 -0400
Received: by mail-pg1-f202.google.com with SMTP id t19so31643850pgh.6
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2019 15:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RGRTCXArW2hVY3/09YdwcpCHYV4EEC+TbEhEFhWGqDY=;
        b=qxRoM/isL5rvTIVAwYUsmGwkKqHnfDLgxNla/G8WoF5D6/qrwGouaDMpYiVOyg6tia
         PXtAKesVgGN/UfD2DnHLyymPwakHzhZ8wO0o8MevAlOB2oF+WtrCEZxLVzyHtjlfHuZ6
         Ih3KtdgGRjQoYPZmm6FI1AmoiGAZCrrmWbIyvxKzHL/gj0flJmbNwag6moe/uhyeFPUj
         e9H899uHPinNhJ/xeQtlCOAFW9z7F4YlzpIoPie9+16BPA7JQXpXTVi8BW5TNE3tY5fs
         XvDbdayVw+O4Q9qZpfh9uKn+TOF8smZ/S9uxYTPPt/gaUqAzwlAiPrMBQB2N3He2UWcD
         NZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RGRTCXArW2hVY3/09YdwcpCHYV4EEC+TbEhEFhWGqDY=;
        b=klk8Z9WKn4v8b/KPZ+h5C2pc+nNY89QmnWs2gcanLArk+x7KXJSVS29KPeE2U+SYwM
         BRj36pk0zWDQ8QgrLNxffqWeGYqCMd9sw8YRYVWW/bW7QnC0PkWNJLiyX3EHDnTHn1U8
         CAlAdZun9k66Zjm95uef/RbKbqM6qeOD5PY5k6DIDuU9VPU+34PVVWqKIUDD6jIhjCCp
         RTQkdnkpIlN5ZtKT1PAWEf+JP/QFLvMJbkRHE1OzVaalsT8iyEJeuGQM1C5V76+ye/Wc
         6g9yoKcQ3DZnyd8yJeLnjrHWNvYMq7JQVshmADUFcfADdtSBREu3AZod3P6TR3yxl89h
         xQnw==
X-Gm-Message-State: APjAAAWdo5rXZplkPujIA6DJfg0tCAYSRH5QOWkUSasYhxLM8gXE+TNK
        ++cB4h3ObsAdovdZhA+uv1hVTjs=
X-Google-Smtp-Source: APXvYqxQwwQxO3ISgdXKDCJNAmpuriAtcV6U+EL1KG3zk0i/fuY/tv3d8GPh97CMB/f7OMKc+kWsmK4=
X-Received: by 2002:a63:2b8e:: with SMTP id r136mr54790874pgr.216.1564095153316;
 Thu, 25 Jul 2019 15:52:33 -0700 (PDT)
Date:   Thu, 25 Jul 2019 15:52:24 -0700
Message-Id: <20190725225231.195090-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH bpf-next v3 0/7] bpf/flow_dissector: support input flags
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <songliubraving@fb.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

C flow dissector supports input flags that tell it to customize parsing
by either stopping early or trying to parse as deep as possible.
BPF flow dissector always parses as deep as possible which is sub-optimal.
Pass input flags to the BPF flow dissector as well so it can make the same
decisions.

Series outline:
* remove unused FLOW_DISSECTOR_F_STOP_AT_L3 flag
* export FLOW_DISSECTOR_F_XXX flags as uapi and pass them to BPF
  flow dissector
* add documentation for the export flags
* support input flags in BPF_PROG_TEST_RUN via ctx_{in,out}
* sync uapi to tools
* support FLOW_DISSECTOR_F_PARSE_1ST_FRAG in selftest
* support FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL in kernel and selftest
* support FLOW_DISSECTOR_F_STOP_AT_ENCAP in selftest

Pros:
* makes BPF flow dissector faster by avoiding burning extra cycles
* existing BPF progs continue to work by ignoring the flags and always
  parsing as deep as possible

Cons:
* new UAPI which we need to support (OTOH, if we need to deprecate some
  flags, we can just stop setting them upon calling BPF programs)

Some numbers (with .repeat = 4000000 in test_flow_dissector):
        test_flow_dissector:PASS:ipv4-frag 35 nsec
        test_flow_dissector:PASS:ipv4-frag 35 nsec
        test_flow_dissector:PASS:ipv4-no-frag 32 nsec
        test_flow_dissector:PASS:ipv4-no-frag 32 nsec

        test_flow_dissector:PASS:ipv6-frag 39 nsec
        test_flow_dissector:PASS:ipv6-frag 39 nsec
        test_flow_dissector:PASS:ipv6-no-frag 36 nsec
        test_flow_dissector:PASS:ipv6-no-frag 36 nsec

        test_flow_dissector:PASS:ipv6-flow-label 36 nsec
        test_flow_dissector:PASS:ipv6-flow-label 36 nsec
        test_flow_dissector:PASS:ipv6-no-flow-label 33 nsec
        test_flow_dissector:PASS:ipv6-no-flow-label 33 nsec

        test_flow_dissector:PASS:ipip-encap 38 nsec
        test_flow_dissector:PASS:ipip-encap 38 nsec
        test_flow_dissector:PASS:ipip-no-encap 32 nsec
        test_flow_dissector:PASS:ipip-no-encap 32 nsec

The improvement is around 10%, but it's in a tight cache-hot
BPF_PROG_TEST_RUN loop.

Cc: Song Liu <songliubraving@fb.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Petar Penkov <ppenkov@google.com>

Stanislav Fomichev (7):
  bpf/flow_dissector: pass input flags to BPF flow dissector program
  bpf/flow_dissector: document flags
  bpf/flow_dissector: support flags in BPF_PROG_TEST_RUN
  tools/bpf: sync bpf_flow_keys flags
  selftests/bpf: support BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG
  bpf/flow_dissector: support ipv6 flow_label and
    BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL
  selftests/bpf: support BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP

 Documentation/bpf/prog_flow_dissector.rst     |  18 ++
 include/linux/skbuff.h                        |   2 +-
 include/uapi/linux/bpf.h                      |   6 +
 net/bpf/test_run.c                            |  39 ++-
 net/core/flow_dissector.c                     |  21 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 .../selftests/bpf/prog_tests/flow_dissector.c | 243 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  47 +++-
 8 files changed, 368 insertions(+), 14 deletions(-)

-- 
2.22.0.709.g102302147b-goog
