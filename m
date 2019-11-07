Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0AF3508
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 17:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfKGQwV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 11:52:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbfKGQwV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 11:52:21 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F26D882FF
        for <bpf@vger.kernel.org>; Thu,  7 Nov 2019 16:52:21 +0000 (UTC)
Received: by mail-lf1-f72.google.com with SMTP id m2so608186lfo.20
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 08:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=0BBAmTpKYKtRa4E0s0gZNYrlDfe81XFkwTQZ3QzuVV4=;
        b=qpfZ3g1712MoYq+nLlMlgrqXYVahphBc7xBmnKD3DoE+OfxHD+VAkYn8m6MTHGeuIE
         ytpfHOhkHJ4RXqCcrxAS3EgNmEWYLMjRynEbXW+NpVOvuyOeEG4kYM2+/Jl+6zDNEnS8
         YIQ9ZnQY1L7Ag/LvwcNUfcudzLXe3dsIOt+HBeDcCO5rwat3rOZku06IYq+dVmdnFbfI
         OFUPBVyrpLb22ExoEyzfGI1wcV3zTRQu6AzSOBnmp/wLaeTGNYEV8YfrEeq53SPP9k+c
         5gtV7196ckRpbwPAWjRnuQ10YztFQWmcy/ZWXFu+AWrt/CHxABN7EMeo8476clrmo1Ic
         9A7A==
X-Gm-Message-State: APjAAAX36bHDW4lFAoCYswYwJauy1EebG32nW6iYLxQ61Gc5uXhWECph
        aDMbJfqT64cLME+D+vayYfpLTVFLi4kKdMQ939SlThxwDvXmOhvYOgmwZvEx8iGnLEAGFK60k3e
        se3FOJaASi/gX
X-Received: by 2002:a05:651c:119b:: with SMTP id w27mr2911703ljo.221.1573145539757;
        Thu, 07 Nov 2019 08:52:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvh6SnIcvtmdcSrZ44czQIeqN1mbj8fe/RtNaif4GTsvB+66jflHvNikk8DxnRiiDWnRBQ2Q==
X-Received: by 2002:a05:651c:119b:: with SMTP id w27mr2911691ljo.221.1573145539595;
        Thu, 07 Nov 2019 08:52:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id a11sm1342086ljp.97.2019.11.07.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 08:52:19 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2714D1818B5; Thu,  7 Nov 2019 17:52:18 +0100 (CET)
Subject: [PATCH bpf-next 0/6] libbpf: Fix pinning and error message bugs and
 add new getters
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Thu, 07 Nov 2019 17:52:18 +0100
Message-ID: <157314553801.693412.15522462897300280861.stgit@toke.dk>
User-Agent: StGit/0.20
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

