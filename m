Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE352D43DB
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 15:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgLIOFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 09:05:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732675AbgLIN7M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 08:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607522265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DeJICkmUhNlMDPR60YNJsvyrM89/RB2B3sOMO3Orpnc=;
        b=eTG3ZZZ3f9rtPwCmLGkSbiXpEn72fjqfLVEfLnxswsSCbXGnQEhZHgP2ExyuYdOlMQju5V
        IacDJE+yeSxO6rna+3OZ/2oi/00LMxfyXmZc5M+Ad794CUr3ME7JkHTYc1/LTWxmTcsLsa
        wiw3IiN6apVkGxAYEGyw+/xF8chftUk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-XIYxq7UNOEOGKDmWPdEAyQ-1; Wed, 09 Dec 2020 08:57:41 -0500
X-MC-Unique: XIYxq7UNOEOGKDmWPdEAyQ-1
Received: by mail-wm1-f72.google.com with SMTP id r1so587073wmn.8
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 05:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=DeJICkmUhNlMDPR60YNJsvyrM89/RB2B3sOMO3Orpnc=;
        b=AG6mZ78uNZ0glhrMD8bo77P96vPVrZ+I39GiFqygYHTqnwrMr8BTJ3cRNM17OagbjA
         Nr3ULwAwhLzQ2JLtTQ+6V9oQytgIow6ExwtUXgJYNRcElhfLaLuhX4aGKqVpKekGH4jZ
         /kz9fLHrAjvF3pX7PvWv/IG8b880JVViVUaWobdrQ4k7JrnBwOOKADyB9XFDU4WlCUHW
         MMVH666KKLU502AvRIS6x/02Oa0karHXYy2UqHDoMjOgU2T/+uYj+vuLSQ59Pu5yYtrp
         aWjFP3racYAar/eBWQowjLshXE6J/zpPu1FEEMou6LW3tQO8880uxe9GQt1ixURZRXAj
         kztw==
X-Gm-Message-State: AOAM531PdQoS51FwD01QaORQziut5aadBLeXlZvJt6RZSh8AR5/9BnQu
        +jV6HEVTFVYn7yWY8XVau/SCJ6M9SeEk59ddXsz1d77qFbjaBBD2nXfq84izqIhDWoo5m60TE60
        JTdZrYYG8jUG8
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr2809548wrv.427.1607522257605;
        Wed, 09 Dec 2020 05:57:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyidXDr7AGB88RVIa+qRbPwe75cFxUfdyia554wfcWfHyTBhIc9MtCkfrARVIyBxhWAKdS3PQ==
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr2809518wrv.427.1607522257401;
        Wed, 09 Dec 2020 05:57:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m21sm3556677wml.13.2020.12.09.05.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:57:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7C78F180003; Wed,  9 Dec 2020 14:57:36 +0100 (CET)
Subject: [PATCH bpf v4 0/7] selftests/bpf: Restore test_offload.py to working
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
Date:   Wed, 09 Dec 2020 14:57:36 +0100
Message-ID: <160752225643.110217.4104692937165406635.stgit@toke.dk>
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

v4:
- Accidentally truncated the Fixes: hashes in patches 3/4 to 11 chars

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

