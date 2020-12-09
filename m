Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A462D40DE
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 12:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgLILUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 06:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729807AbgLILUJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 06:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607512723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xSOTlsGZZ/ADfKcdaJ8Ay5xDLSKq4CczFccCePJHcIk=;
        b=IT7tOjNU/v/A2MwUc+8BWQBfrwgDfAHQrhYC1xLjhp46/eIDZwiyfTixumlD7ymS/9u2Mi
        0JfrZpfIs1tsFNwGn/QfEK7QM2B0e4X+i0dJe5IKmrOjIxU3WhvpL6ihLtylMTsFBJPPvO
        fE/y52MCUp+NlvBQ3/cKrbGFLhFiomw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-1rISRFDDN_SetCjFx3vAaw-1; Wed, 09 Dec 2020 06:18:41 -0500
X-MC-Unique: 1rISRFDDN_SetCjFx3vAaw-1
Received: by mail-wm1-f70.google.com with SMTP id h68so431908wme.5
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 03:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=xSOTlsGZZ/ADfKcdaJ8Ay5xDLSKq4CczFccCePJHcIk=;
        b=IK1tiV1LhVXXvn7i2dIYc+Pb1l9gqC1M6c5s4HGrl3gJ7Jkunhgaa5dcCWyNFvavW2
         QbYQrocaC9rlWdUzkIeMedz3HLHgJnp+qVJ3wknwCEo15zfqwqfyNwm3ZKoJUSuaR2B4
         hYrnapHW+cDWQt5gLeaALGQCQcbe5jaPNvzGPA/x8J9heZAYBHpfTinwItWJYlsPCQn2
         +dSL+LZ3min3nPBUN/XaapaMhuzJJCj5XEz8KRXANUrv1waY94isqLNDE57sPZn+gDbk
         wXzyUOy0CwDT5XM7IqG13ORoVIir5cuelO9TogYkSUfD11fybheh1wJCxEeAD3Z3Qs/0
         H6AA==
X-Gm-Message-State: AOAM531eQCGaHbSk6m/XGHpQWWphQYYXcOpF0mg2BTwuOnmLLosGqFfx
        bwpqO+UO7t79VmBHez4ewIgdeY9eip8wQ21hdLGcQrW1MlkSnd/TJfwu+6zM+/2U8VDKodQ8+/T
        Pa5ggJEYsghl6
X-Received: by 2002:a5d:4209:: with SMTP id n9mr2104994wrq.128.1607512720464;
        Wed, 09 Dec 2020 03:18:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm5RxsK1e736lOeUy/K4LoocHFwg4m6StAtUALim1kfo/PoU+Wv+tRPAcTaMmDK/AR8J9m6Q==
X-Received: by 2002:a5d:4209:: with SMTP id n9mr2104984wrq.128.1607512720296;
        Wed, 09 Dec 2020 03:18:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m81sm2860764wmf.29.2020.12.09.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:18:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1576A180003; Wed,  9 Dec 2020 12:18:38 +0100 (CET)
Subject: [PATCH bpf v3 0/7] selftests/bpf: Restore test_offload.py to working
 order
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jiri Benc <jbenc@redhat.com>, oss-drivers@netronome.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Wed, 09 Dec 2020 12:18:38 +0100
Message-ID: <160751271801.104774.5575431902172553440.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series restores the test_offload.py selftest to working order. It seems a
number of subtle behavioural changes have crept into various subsystems which
broke test_offload.py in a number of ways. Most of these are fairly benign
changes where small adjustments to the test script seems to be the best fix, but
one is an actual kernel bug that I've observed in the wild caused by a bad
interaction between xdp_attachment_flags_ok() and the rework of XDP program
handling in the core netdev code.

Patch 1 fixes the bug by removing xdp_attachment_flags_ok(), and the reminder of
the patches are adjustments to test_offload.py, including a new feature for
netdevsim to force a BPF verification fail. Please see the individual patches
for details.

Changelog:

v3:
- Add Fixes: tags

v2:
- Replace xdp_attachment_flags_ok() with a check in dev_xdp_attach()
- Better packing of struct nsim_dev

---

Toke Høiland-Jørgensen (7):
      xdp: remove the xdp_attachment_flags_ok() callback
      selftests/bpf/test_offload.py: Remove check for program load flags match
      netdevsim: Add debugfs toggle to reject BPF programs in verifier
      selftests/bpf/test_offload.py: only check verifier log on verification fails
      selftests/bpf/test_offload.py: fix expected case of extack messages
      selftests/bpf/test_offload.py: reset ethtool features after failed setting
      selftests/bpf/test_offload.py: filter bpftool internal map when counting maps


 drivers/net/netdevsim/bpf.c                 | 12 ++++-
 drivers/net/netdevsim/netdevsim.h           |  1 +
 tools/testing/selftests/bpf/test_offload.py | 53 +++++++++++----------
 3 files changed, 40 insertions(+), 26 deletions(-)

