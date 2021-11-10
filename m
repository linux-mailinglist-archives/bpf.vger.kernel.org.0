Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B135644BFE2
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 12:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhKJLNa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 06:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhKJLNP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 06:13:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE19C061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:10:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d27so3316156wrb.6
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUDHpGzMacjmb5vscFO1ZQI4jzKJdqLW2tjJmDZCTGY=;
        b=e0HGi1o0OW/CvRSmXyNNsAPjmzbmcCZyI3r6zSN7bHdb6aCtmwXCBsLshGnMo7bdq3
         AajkSrzaAkmVg5MdXNrS0MoxO9faGxPOsmGA1537LCjC+8dRgjaGG1mivCGrMz8u22N4
         yk2Z47tR/xXTbHq/ghVLn6B2LLRwa6dBbYXxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUDHpGzMacjmb5vscFO1ZQI4jzKJdqLW2tjJmDZCTGY=;
        b=TVBZkJWcixgPMRJ1BC2bYl+KOki3vHlx7LyTz3FbMI1S287HAxOxM4qPhqeWzYRoWN
         C8MsMLpIKcYVe9ZgTfio5i/P/xvj8fAR1pZAOxaAcOGbTFqmBY/xsUFr7QA7sWollmoa
         fdGZqtle/rHuPxABkSwJP2s40RvcDZuZS/i1GNdxFM2H9EWw9ZwzIkL5oWkbXhnMlOhi
         ZJxW9WGiPsz/pHoRRcTEGqz5XzHKfRLYEWDc0n9DXn+wn020IJI2RG8I2B4EKrnsRKcF
         3lFx2zkQ6fwul71VbeZV6zuKm+N58MwCn4AADOhhW2MM/tR1UO7IV0oG9KcOKQ7gjl2A
         bOGQ==
X-Gm-Message-State: AOAM531A5yQvcPqm7bUMzGPLMm1KVuGPiI/v6sAGHM0+D6o1P+pzUd8V
        LlVdVbX0qCvsdk3/6cXRET2wzQ==
X-Google-Smtp-Source: ABdhPJw/PkgMUja9aiApBdcdEdqp64kZuxk4Z/t9mZCQEtFh04MMnZf92NvjhSGpv9hE/1Q8SpaXdg==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr18659969wrv.427.1636542619771;
        Wed, 10 Nov 2021 03:10:19 -0800 (PST)
Received: from kharboze.dr-pashinator-m-d.gmail.com.beta.tailscale.net (cust97-dsl60.idnet.net. [212.69.60.97])
        by smtp.gmail.com with ESMTPSA id m14sm18780682wrp.28.2021.11.10.03.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:10:19 -0800 (PST)
From:   Mark Pashmfouroush <markpash@cloudflare.com>
To:     markpash@cloudflare.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] Get ingress_ifindex in BPF_SK_LOOKUP prog type
Date:   Wed, 10 Nov 2021 11:10:14 +0000
Message-Id: <20211110111016.5670-1-markpash@cloudflare.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF_SK_LOOKUP users may want to have access to the ifindex of the skb
which triggered the socket lookup. This may be useful for selectively
applying programmable socket lookup logic to packets that arrive on a
specific interface, or excluding packets from an interface.

v3:
- Rename ifindex field to ingress_ifindex for consistency. (Yonghong)

v2:
- Fix inaccurate comment (Alexei)
- Add more details to commit messages (John)

Mark Pashmfouroush (2):
  bpf: Add ingress_ifindex to bpf_sk_lookup
  selftests/bpf: Add tests for accessing ingress_ifindex in
    bpf_sk_lookup

 include/linux/filter.h                        |  7 ++--
 include/uapi/linux/bpf.h                      |  1 +
 net/core/filter.c                             |  7 ++++
 net/ipv4/inet_hashtables.c                    |  8 ++---
 net/ipv4/udp.c                                |  8 ++---
 net/ipv6/inet6_hashtables.c                   |  8 ++---
 net/ipv6/udp.c                                |  8 ++---
 tools/include/uapi/linux/bpf.h                |  1 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 31 ++++++++++++++++++
 .../selftests/bpf/progs/test_sk_lookup.c      |  8 +++++
 .../selftests/bpf/verifier/ctx_sk_lookup.c    | 32 +++++++++++++++++++
 11 files changed, 101 insertions(+), 18 deletions(-)

-- 
2.31.1

