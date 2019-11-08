Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E1FF59EC
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 22:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfKHVdI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 16:33:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730009AbfKHVdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 16:33:08 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A5E7821D9
        for <bpf@vger.kernel.org>; Fri,  8 Nov 2019 21:33:08 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id o20so1547924ljg.0
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 13:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=f9G7ifn6IeScMKogPmkF62Xe41eRO8dRYDdQ01G+h9Y=;
        b=JHOJ65MBdje5Ax8Z/K3xtSAQ34u9oVPg1ytmi7PGs+hIWpzwjnZDYrjg+e5r+I7P1P
         Oe9hsDniHsVMhOqdfxq0LtgKCsRhBtPKAwvy0xnsF2Qmm8uJxOM7aJzNqrwCTltn931v
         EvBIacpSQ4WGEH1dgpN6SUU4j4YzgrQ+zflhMO/7pLnF1jmht4VuEcfnJQLzughtYmq7
         2VWUGxsROxBRcvZC3g+yL1ZzWNG3pGzUh5JvBg51hq0exI+8GYT9B1pM2ApmciBrFpf9
         CUltRdRYQBHJ8rR+YTutR66+4nZ8HS//Ii74HAPcZ7Ct2NVBP+dXK+yugOsjINX+1Ets
         M6/w==
X-Gm-Message-State: APjAAAX84Pq4KZuY1i14dZPvj5SV/9/6s5Co0lM3Spfm+4nQF9mnyfbf
        cTziPuzZfLS1rwVgtsheJ2repV28Mz1W+jjNJjZ6YfL4s7jTSjuPkdhFcKmB0z9U4je674jr7pZ
        BgkXoTAKftFk/
X-Received: by 2002:a05:651c:1059:: with SMTP id x25mr3891823ljm.255.1573248786667;
        Fri, 08 Nov 2019 13:33:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxH5IsNOnALiXwaJmnRtU+9Blz9TfCCMAbWhWiRYR8R/9dp8YTIX1Qic5MPcVqDSyqwCULPKw==
X-Received: by 2002:a05:651c:1059:: with SMTP id x25mr3891810ljm.255.1573248786489;
        Fri, 08 Nov 2019 13:33:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id y6sm3504046lfj.75.2019.11.08.13.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:33:05 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3A4901800BD; Fri,  8 Nov 2019 22:33:05 +0100 (CET)
Subject: [PATCH bpf-next v2 0/6] libbpf: Fix pinning and error message bugs
 and add new getters
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 08 Nov 2019 22:33:05 +0100
Message-ID: <157324878503.910124.12936814523952521484.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series fixes a few bugs in libbpf that I discovered while playing around
with the new auto-pinning code, and writing the first utility in xdp-tools[0]:

- If object loading fails, libbpf does not clean up the pinnings created by the
  auto-pinning mechanism.
- EPERM is not propagated to the caller on program load
- Netlink functions write error messages directly to stderr

In addition, libbpf currently only has a somewhat limited getter function for
XDP link info, which makes it impossible to discover whether an attached program
is in SKB mode or not. So the last patch in the series adds a new getter for XDP
link info which returns all the information returned via netlink (and which can
be extended later).

Finally, add a getter for BPF program size, which can be used by the caller to
estimate the amount of locked memory needed to load a program.

A selftest is added for the pinning change, while the other features were tested
in the xdp-filter tool from the xdp-tools repo. The 'new-libbpf-features' branch
contains the commits that make use of the new XDP getter and the corrected EPERM
error code.

[0] https://github.com/xdp-project/xdp-tools

Changelog:

v2:
  - Keep function names in libbpf.map sorted properly

---

Toke Høiland-Jørgensen (6):
      libbpf: Unpin auto-pinned maps if loading fails
      selftests/bpf: Add tests for automatic map unpinning on load failure
      libbpf: Propagate EPERM to caller on program load
      libbpf: Use pr_warn() when printing netlink errors
      libbpf: Add bpf_get_link_xdp_info() function to get more XDP information
      libbpf: Add getter for program size


 tools/lib/bpf/libbpf.c                           |   25 +++++--
 tools/lib/bpf/libbpf.h                           |   11 +++
 tools/lib/bpf/libbpf.map                         |    2 +
 tools/lib/bpf/netlink.c                          |   81 ++++++++++++++--------
 tools/lib/bpf/nlattr.c                           |   10 +--
 tools/testing/selftests/bpf/prog_tests/pinning.c |   20 +++++
 tools/testing/selftests/bpf/progs/test_pinning.c |    2 -
 7 files changed, 109 insertions(+), 42 deletions(-)

