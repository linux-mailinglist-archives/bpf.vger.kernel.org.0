Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E270C3C85D4
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhGNOSh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 10:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhGNOSh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 10:18:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC0C06175F
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g16so3427716wrw.5
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bssLhd+cIkqfSP8mNS+8ismfmZwsw8lHPp/rvv+CTv4=;
        b=EtRASLPkAeR6dH2UYXZSgxcxigMyc/+gm5+v/K9pxAcMX7vGkuFF3baWxaMA5hYOsw
         AUFAlAxFzWQJL/TvgbHALtEZ/jG6uzHmDGLHv8JhhVYiv02avDkuH3vLt2JxvfrHHO/A
         4g/XdKfLczf3n3u33BM9CkzCxIpigQK1ygOT7F0Pe+1w5yDcgLaeQX2VMRdR0MHzxtEo
         znLhlT3wY+ty2utOWbzRQRCvteQV2tQDk8uMeNk9mHWXvXxYbYmjs3jp2TLsmZkjDQqi
         FZQoJAfg8d5TK5oailG50+u39gUCJMYuugMr5tP3kqrUmAerj9m0oNffcJdQDmW40Bkx
         WtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bssLhd+cIkqfSP8mNS+8ismfmZwsw8lHPp/rvv+CTv4=;
        b=MXSDbQB8rjIkIgY/ODdXKh+wX6oOUXEv8d5beh3xY85FApAewq4FkOs6CGjVoRtgc8
         4Ep7XuC60aO1aKuXiz2kAK8o4Amr7UvHgb9l8qBmzNXpn+iZNAC/pnGWKPiEZjPlEG2y
         tpGfHjMYSUF0GB0Td3Idkvmx/9pfQm5PEv8fpCC100tkgZSRJZv3FCVnYXKGz++qKn8Z
         VQ1JbRhrBjLWJniHOuISF7CeXWWfYVKk+/ViI/MxRwa0msuhjsf5AoLp3365/Np94gQp
         lcbMp98yq1EjOxvTHHZDpPtFPGo/iZHPezVYdl7mjX73dGKGH6RVUkcvtKL3FIFJXXzT
         4faQ==
X-Gm-Message-State: AOAM531ZfOWBsF0vExhXjh5fY86xNYlg3FC0YVhGn+7QDmm6KAWyLgxO
        QL93hb2cQV4QbQgcRydBkf5X7w==
X-Google-Smtp-Source: ABdhPJz86KQ54tcqToKphde+byAsiTUDFfaOyK0ei3oG4UeLnz7XkfrX6OJfcOv51OEApwVHOTCZ2A==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr13393239wrt.333.1626272144490;
        Wed, 14 Jul 2021 07:15:44 -0700 (PDT)
Received: from localhost.localdomain ([149.86.90.174])
        by smtp.gmail.com with ESMTPSA id a207sm6380037wme.27.2021.07.14.07.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 07:15:43 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/6] libbpf: rename btf__get_from_id() and btf__load() APIs, support split BTF
Date:   Wed, 14 Jul 2021 15:15:26 +0100
Message-Id: <20210714141532.28526-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As part of the effort to move towards a v1.0 for libbpf [0], this set
improves some confusing function names related to BTF loading from and to
the kernel:

- btf__load() becomes btf__load_into_kernel().
- btf__get_from_id becomes btf__load_from_kernel_by_id().
- A new version btf__load_from_kernel_by_id_split() extends the former to
  add support for split BTF.

The old functions are not removed yet, but marked as deprecated.

The last patch is a trivial change to bpftool to add support for dumping
split BTF objects by referencing them by their id (and not only by their
BTF path).

[0] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#btfh-apis

Quentin Monnet (6):
  libbpf: rename btf__load() as btf__load_into_kernel()
  libbpf: rename btf__get_from_id() as btf__load_from_kernel_by_id()
  tools: replace btf__get_from_id() with btf__load_from_kernel_by_id()
  libbpf: explicitly mark btf__load() and btf__get_from_id() as
    deprecated
  libbpf: add split BTF support for btf__load_from_kernel_by_id()
  tools: bpftool: support dumping split BTF by id

 tools/bpf/bpftool/btf.c                      |  2 +-
 tools/bpf/bpftool/btf_dumper.c               |  2 +-
 tools/bpf/bpftool/map.c                      |  4 ++--
 tools/bpf/bpftool/prog.c                     |  6 +++---
 tools/lib/bpf/btf.c                          | 15 ++++++++++++---
 tools/lib/bpf/btf.h                          | 10 ++++++++--
 tools/lib/bpf/libbpf.c                       |  4 ++--
 tools/lib/bpf/libbpf.map                     |  7 +++++++
 tools/perf/util/bpf-event.c                  |  4 ++--
 tools/perf/util/bpf_counter.c                |  2 +-
 tools/testing/selftests/bpf/prog_tests/btf.c |  2 +-
 11 files changed, 40 insertions(+), 18 deletions(-)

-- 
2.30.2

