Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91694269196
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 18:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgINQcr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 12:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbgINQNd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 14 Sep 2020 12:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600100010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qpPg1xVOXHWnVHti3MDOUm/aAiuUDunM/P97eXHwRvw=;
        b=N2i8mK5uXRChRwGEz/QecEO7xxObsTKaKmJOCXZMS+/VXqxykamD9D2G2vmEqCEPVNxYis
        uL9LUkN4aiqluGMFFhAR5BLkxvxf+CTP1X/frEBge/WwQpZX9IaKTboProcvgos1CMlzNQ
        Y35tGy8vmiQC7SnkE0gzCsrcTtXZ+5s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-32gpjxbfP2WtXDH0wbmHBA-1; Mon, 14 Sep 2020 12:13:25 -0400
X-MC-Unique: 32gpjxbfP2WtXDH0wbmHBA-1
Received: by mail-wm1-f72.google.com with SMTP id w3so164209wmg.4
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 09:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=qpPg1xVOXHWnVHti3MDOUm/aAiuUDunM/P97eXHwRvw=;
        b=SAA4Wpu4NmrhUvDeXmExhck2bSBHhjsHOP+GLtUb+gPSl98d+4Z1VaU9HvgWj00deu
         W6fGKm7gaKhkrAyyNAlOZeCbzwELMLYTu44cfqAFi2PN+CPmFV0MaexvxnXcsVBdh1v2
         JJrzYW6ry+IxB++bbuMHOxbk8hHKOtAm0BRXNVDYVnedhOKNsM40aVlOP/Jt79hLAE8N
         MwY/yE2tPlqbOTIwkmdk5YrVnd0p5SD3HAINqaU+bLOCYWW9izfcI9UKYKQt7E6bo/NW
         z8g8PTcOxJdyXvfOSI+K6pzArp+JXxYfafrnPl4QyMfdeKVxjVQPz29pAKlImvGLPf2r
         P2hg==
X-Gm-Message-State: AOAM532a7i8fkXmnmNvIfkdDMvd35qLn+6wzBEDOz8MTIk+G0xUEvTPO
        Xgzsxpqe1SY3Q6buYUGYiqczBRJJa+OrdaXfkbqFsqXRKddVm4cEoAEkGRcI30qUKPjaoQsqeaA
        Pq2JEATcj2Gr+
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr12177483wrv.195.1600100004215;
        Mon, 14 Sep 2020 09:13:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJmBmIjwYDRCh/DbOpR+fv04VpFDCpQEO4EsK2z1vyNTRdbaKsp5E0WYO1nBQtZ34mrbIqZw==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr12177456wrv.195.1600100003949;
        Mon, 14 Sep 2020 09:13:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v17sm21382364wrr.60.2020.09.14.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 09:13:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D43AA1829CB; Mon, 14 Sep 2020 18:13:22 +0200 (CEST)
Subject: [PATCH bpf-next v4 0/8] bpf: Support multi-attach for freplace
 programs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Mon, 14 Sep 2020 18:13:22 +0200
Message-ID: <160010000272.80898.13117015273092905112.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support attaching freplace BPF programs to multiple targets.
This is needed to support incremental attachment of multiple XDP programs using
the libxdp dispatcher model.

The first three patches are refactoring patches: The first one is a trivial
change to the logging in the verifier, split out to make the subsequent refactor
easier to read. Patch 2 refactors check_attach_btf_id() so that the checks on
program and target compatibility can be reused when attaching to a secondary
location.

Patch 3 changes prog_aux->linked_prog to be an embedded bpf_tracing_link that is
initialised at program load time. This nicely encapsulates both the trampoline
and the prog reference, and moves the release of these references into bpf_link
teardown. At attach time, it will be removed from the extension prog, and primed
as a regular bpf_link.

Based on these refactorings, it becomes pretty straight-forward to support
multiple-attach for freplace programs (patch 4). This is simply a matter of
creating a second bpf_tracing_link if a target is supplied. However, for API
consistency with other types of link attach, this option is added to the
BPF_LINK_CREATE API instead of extending bpf_raw_tracepoint_open().

Patch 5 is a port of Jiri Olsa's patch to support fentry/fexit on freplace
programs. His approach of getting the target type from the target program
reference no longer works after we've gotten rid of linked_prog (because the
bpf_tracing_link reference disappears on attach). Instead, we used the saved
reference to the target prog type that is also used to verify compatibility on
secondary freplace attachment.

Patches 6 is the accompanying libbpf update, and patches 7-8 are selftests, the
first one for the multi-freplace functionality itself, and the second one is
Jiri's previous selftest for the fentry-to-freplace fix.

With this series, libxdp and xdp-tools can successfully attach multiple programs
one at a time. To play with this, use the 'freplace-multi-attach' branch of
xdp-tools:

$ git clone --recurse-submodules --branch freplace-multi-attach https://github.com/xdp-project/xdp-tools
$ cd xdp-tools
$ make
$ sudo ./xdp-loader/xdp-loader load veth0 lib/testing/xdp_drop.o
$ sudo ./xdp-loader/xdp-loader load veth0 lib/testing/xdp_pass.o
$ sudo ./xdp-loader/xdp-loader status

The series is also available here:
https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/log/?h=bpf-freplace-multi-attach-alt-04

Changelog:

v4:
  - Cleanup the refactored check_attach_btf_id() to make the logic easier to follow
  - Fix cleanup paths for bpf_tracing_link
  - Use xchg() for removing the bpf_tracing_link from prog->aux and restore on (some) failures
  - Use BPF_LINK_CREATE operation to create link with target instead of extending raw_tracepoint_open
  - Fold update of tools/ UAPI header into main patch
  - Update arg dereference patch to use skeletons and set_attach_target()

v3:
  - Get rid of prog_aux->linked_prog entirely in favour of a bpf_tracing_link
  - Incorporate Jiri's fix for attaching fentry to freplace programs

v2:
  - Drop the log arguments from bpf_raw_tracepoint_open
  - Fix kbot errors
  - Rebase to latest bpf-next

---

Toke Høiland-Jørgensen (8):
      bpf: change logging calls from verbose() to bpf_log() and use log pointer
      bpf: verifier: refactor check_attach_btf_id()
      bpf: wrap prog->aux->linked_prog in a bpf_tracing_link
      bpf: support attaching freplace programs to multiple attach points
      bpf: Fix context type resolving for extension programs
      libbpf: add support for freplace attachment in bpf_link_create
      selftests: add test for multiple attachments of freplace program
      selftests/bpf: Adding test for arg dereference in extension trace


 include/linux/bpf.h                           |  33 ++-
 include/linux/bpf_verifier.h                  |   9 +
 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/btf.c                              |  22 +-
 kernel/bpf/core.c                             |   4 +-
 kernel/bpf/syscall.c                          | 180 +++++++++++++--
 kernel/bpf/trampoline.c                       |  32 ++-
 kernel/bpf/verifier.c                         | 215 +++++++++++-------
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/bpf.h                           |   3 +-
 tools/lib/bpf/libbpf.c                        |  24 +-
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 171 +++++++++++---
 .../selftests/bpf/prog_tests/trace_ext.c      | 113 +++++++++
 .../bpf/progs/freplace_get_constant.c         |  15 ++
 .../selftests/bpf/progs/test_trace_ext.c      |  18 ++
 .../bpf/progs/test_trace_ext_tracing.c        |  25 ++
 19 files changed, 701 insertions(+), 172 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/trace_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_get_constant.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_trace_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_trace_ext_tracing.c

