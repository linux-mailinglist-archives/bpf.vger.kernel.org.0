Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48370F5C17
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 01:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfKIAA6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 19:00:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfKIAA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 19:00:58 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A7EC4627A
        for <bpf@vger.kernel.org>; Sat,  9 Nov 2019 00:00:58 +0000 (UTC)
Received: by mail-lf1-f69.google.com with SMTP id h3so1608624lfp.17
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 16:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=oC9fxQXcckrNwWlO31QKx050h9F1I09RUxh44TxTdAE=;
        b=ogzW4gpPyY0ccX0t5eNjgajwcBi85y8lQ3ExWLntYGvjy+yI3OH9+xT/I13Q3pj4Nd
         zF4f807diN5NzDyj2JRUthbBJptXkzzO7JP065QhUc4g+jZjwHUZ9sh5+dafDt1PJb3L
         VTEVEAKg58mYYvXUdtZiancrH+1PQ0xRZkrBWNoilHkfrYr2P3M2o13Flodj+JX6kW0l
         48IZkIgBEtGD0q06eKnMnXJNzmcST2iZUaohomK7O8qLSGMcnmVHa66jliMJ9Y2UejLp
         tPmStavttEYw9PfrUC25I3558tX3ItUnUQ3y1qJzL4VHb4julAuhy7tkwDMpdSeE3qY3
         KESg==
X-Gm-Message-State: APjAAAUsKHSpHPoJTUOxLPeQg6njm40WmjlGvTy46ZXFiZyk3KTy6Whr
        CXOomStQm1ndaCA1Yx12DKUXzwdUIxFQQLde+GqwREenhvjpWd/ArMOtnfmfRnFxVti1JQ5L6hN
        m7A611Q1+UryZ
X-Received: by 2002:a2e:9194:: with SMTP id f20mr8616616ljg.154.1573257656541;
        Fri, 08 Nov 2019 16:00:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYblTLHiKoEhtbtsFhpcNvHUiyRxWy4AdJFakbbqn6UzppThI0E6PXVK+edRpzOGLuUUSuhg==
X-Received: by 2002:a2e:9194:: with SMTP id f20mr8616593ljg.154.1573257656288;
        Fri, 08 Nov 2019 16:00:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id n25sm3600991lfg.42.2019.11.08.16.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 16:00:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C34131800CC; Sat,  9 Nov 2019 01:00:54 +0100 (CET)
Subject: [PATCH bpf-next v3 0/6] libbpf: Fix pinning and error message bugs
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
Date:   Sat, 09 Nov 2019 01:00:54 +0100
Message-ID: <157325765467.27401.1930972466188738545.stgit@toke.dk>
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

v3:
  - Pass through all kernel error codes on program load (instead of just EPERM).
  - No new bpf_object__unload() variant, just do the loop at the caller
  - Don't reject struct xdp_info sizes that are bigger than what we expect.
  - Add a comment noting that bpf_program__size() returns the size in bytes

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


 tools/lib/bpf/libbpf.c                           |   41 ++++++-----
 tools/lib/bpf/libbpf.h                           |   13 +++
 tools/lib/bpf/libbpf.map                         |    2 +
 tools/lib/bpf/netlink.c                          |   85 ++++++++++++++--------
 tools/lib/bpf/nlattr.c                           |   10 +--
 tools/testing/selftests/bpf/prog_tests/pinning.c |   20 ++++-
 tools/testing/selftests/bpf/progs/test_pinning.c |    2 -
 7 files changed, 118 insertions(+), 55 deletions(-)

