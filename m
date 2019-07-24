Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0967346F
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfGXRAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 13:00:21 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41690 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXRAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 13:00:21 -0400
Received: by mail-pf1-f201.google.com with SMTP id q14so28965584pff.8
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 10:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1xPEXMDkLELWIGaSMmOMYvDd/EFGlRxWlFEHpHsk6fU=;
        b=FJi7WmtRWpa7GH2wOtF5ooh9n7vlVNN4fQuQW/pFfXdiBHnSemRqWPTKh34Anr/acL
         /iq8uchMtVdEG/AYNTC6Eb9+Qc1cuSbAA1HA0WhPLe5KgqdWtwps6pg5BNMvmfmhFheh
         bioYzPTRreDyfTXhA43yHdRY4hg5JggQYoH2O0cRyiNcqD5zY1iVxfoXeaV4FcKgVrAQ
         RKJAI5uvfJaP9ZdbLAivvHPu1iEipzD4O6kiJx4XqUcuAWdLxUURzEcfg8CWSnnmyFgl
         Pc3NZhv4/j03R564hNG99bs2d+Hd9MaQwfwCZ4h7/piuflNfRhfofV78+iAVMXDsERgC
         slIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1xPEXMDkLELWIGaSMmOMYvDd/EFGlRxWlFEHpHsk6fU=;
        b=j+GOznEWarFmF0susK1FAJoa+WM/8tmujcmcDFj6LLOakqAnprp4yejeFPxKoKf6VX
         rfRi4fzmk9Jk0G6bHZOJle7RQ2r6PcSBE11r84tfVwzewc/+RZp4Qq2yjYBpl1C+lyV8
         YuxX4K6h7HFI5wzZy9JYB8H/N19Im+WgnedXWYeYbtlfH5jnbwBrTr6fBQ2jBh0ndslr
         Klvtj/zZtxJKvFO3lTpfQ3BOp1NtPA4f38+JZ3dgKbn9ZJr5iIOjwCcXT3LRY9V2glDy
         9Py9kCtzKNGWXXQvoOhES9bBzHAEn0AsZISd6gngrRalgnkHrXdQw/lrHmXo/2zgsMs/
         oFqA==
X-Gm-Message-State: APjAAAWLq6ioW6N8jp69sjOTcMofu7ygcfwMVpK9jRrp2oXXl7HnFR/g
        FWWUnr42ZgGTYXz307ABR+k8tU4=
X-Google-Smtp-Source: APXvYqwpMLZ86VgJOfJVCkwACEnTjwzBt2hOKmktyaDaBVZ7+/iIvzFxcqrCupyT84JxvNgl+8TthxM=
X-Received: by 2002:a65:55c7:: with SMTP id k7mr51084981pgs.305.1563987620511;
 Wed, 24 Jul 2019 10:00:20 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:00:11 -0700
Message-Id: <20190724170018.96659-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next 0/7] bpf/flow_dissector: support input flags
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
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

Cc: Willem de Bruijn <willemb@google.com>
Cc: Petar Penkov <ppenkov@google.com>

Stanislav Fomichev (7):
  bpf/flow_dissector: pass input flags to BPF flow dissector program
  bpf/flow_dissector: document flags
  bpf/flow_dissector: support flags in BPF_PROG_TEST_RUN
  tools/bpf: sync bpf_flow_keys flags
  sefltests/bpf: support FLOW_DISSECTOR_F_PARSE_1ST_FRAG
  bpf/flow_dissector: support ipv6 flow_label and
    FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL
  selftests/bpf: support FLOW_DISSECTOR_F_STOP_AT_ENCAP

 Documentation/bpf/prog_flow_dissector.rst     |  18 ++
 include/linux/skbuff.h                        |   2 +-
 include/net/flow_dissector.h                  |   4 -
 include/uapi/linux/bpf.h                      |   6 +
 net/bpf/test_run.c                            |  39 ++-
 net/core/flow_dissector.c                     |  14 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 .../selftests/bpf/prog_tests/flow_dissector.c | 235 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  46 +++-
 9 files changed, 353 insertions(+), 17 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog
