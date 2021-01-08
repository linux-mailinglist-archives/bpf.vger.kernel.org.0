Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB582EF6F1
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbhAHSEQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jan 2021 13:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbhAHSEQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jan 2021 13:04:16 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8007C061380
        for <bpf@vger.kernel.org>; Fri,  8 Jan 2021 10:03:35 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id s14so7422184pjk.4
        for <bpf@vger.kernel.org>; Fri, 08 Jan 2021 10:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=uy999xqJw7BL3WhrZT3LQFvPsdD4ZByTDVZmgN/UR4M=;
        b=hnS6XTf4SbwUDmsws7ObNGr/AOqNQXZkpvnD5Q57hierrmM6HvHGF9b7MHzgQ8fNkl
         rtbofw4YLVMAwAPVUlx5QRFjqGqk8uKnS2FNNT0fuEkRgnGROZg1oNIU4lvifHltqzqh
         niYP6C2fSb8mWGiTUc2sVnIrm8EtAU8q9rMPiX0681pmUpHzo1A+9JMsAkqdFUD/59Jn
         77P2UCbmmPl5xowxko+sbZZp5PhFRc2dByFqDdclokcssbQvMycKC5h3K9wioNrNYqD/
         5ZeusityobxBlEgyiVg5pwVDJuvpTCfLNpKhdrg0y3lFFwgW47lqntIBH3nbwuY0lzc3
         NMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=uy999xqJw7BL3WhrZT3LQFvPsdD4ZByTDVZmgN/UR4M=;
        b=qNXggZnh6oynZAOGyaKS0RMdegjE4qBcgwwhDetVurAQSLg4U3jkdhX080Srv38uO+
         5Xs6wgsN6Tyw4iI2kaGRd2xm53crcKnJsA6N0JSqX+vzK5p3sAfNnQz0lGoSLyg5QmA0
         F7zsS2A3lQ6+ACBtKIPbqP0bZ4IwLWA0DxjUH7G3fjnq/YVu+Yw5i2tXA1LG6eIrpSK0
         kvINMAyNFbzFquFT2i60s+XThYIKfqKTCXp6LGM4lM01ywegY+7GzRNcNA+QwLZLCGkA
         RRMUQeyOcIDjgK56OmpNpvHZO2DmPs1ac1BF0v4VkQ1xadGr3X/Xet/2BH4JdOQsxa+m
         cAQA==
X-Gm-Message-State: AOAM531SZRFg9e7rDWyN3mKWENquyvg86nlihRMH2AkPjmSPDEFCHoKh
        d70P3XGtCri/ySYelU2ZjohZLp0=
X-Google-Smtp-Source: ABdhPJytp7ezHR/hUJtuQDUkct+MRHLjGX+cIlGTvGpFK8YLlJvPoHnqoaBE4OrQl+1Qq3TPMsiOj30=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a63:2265:: with SMTP id t37mr8045351pgm.336.1610129015278;
 Fri, 08 Jan 2021 10:03:35 -0800 (PST)
Date:   Fri,  8 Jan 2021 10:03:30 -0800
Message-Id: <20210108180333.180906-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH bpf-next v5 0/3] bpf: misc performance improvements for cgroup hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First patch adds custom getsockopt for TCP_ZEROCOPY_RECEIVE
to remove kmalloc and lock_sock overhead from the dat path.

Second patch removes kzalloc/kfree from getsockopt for the common cases.

Third patch switches cgroup_bpf_enabled to be per-attach to
to add only overhead for the cgroup attach types used on the system.

No visible user-side changes.

v5:
- reorder patches to reduce the churn (Martin KaFai Lau)

v4:
- update performance numbers
- bypass_bpf_getsockopt (Martin KaFai Lau)

v3:
- remove extra newline, add comment about sizeof tcp_zerocopy_receive
  (Martin KaFai Lau)
- add another patch to remove lock_sock overhead from
  TCP_ZEROCOPY_RECEIVE; technically, this makes patch #1 obsolete,
  but I'd still prefer to keep it to help with other socket
  options

v2:
- perf numbers for getsockopt kmalloc reduction (Song Liu)
- (sk) in BPF_CGROUP_PRE_CONNECT_ENABLED (Song Liu)
- 128 -> 64 buffer size, BUILD_BUG_ON (Martin KaFai Lau)

Stanislav Fomichev (3):
  bpf: remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
  bpf: try to avoid kzalloc in cgroup/{s,g}etsockopt
  bpf: split cgroup_bpf_enabled per attach type

 include/linux/bpf-cgroup.h                    |  61 ++++++----
 include/linux/filter.h                        |   5 +
 include/net/sock.h                            |   2 +
 include/net/tcp.h                             |   1 +
 kernel/bpf/cgroup.c                           | 104 +++++++++++++++---
 net/ipv4/af_inet.c                            |   9 +-
 net/ipv4/tcp.c                                |  14 +++
 net/ipv4/tcp_ipv4.c                           |   1 +
 net/ipv4/udp.c                                |   7 +-
 net/ipv6/af_inet6.c                           |   9 +-
 net/ipv6/tcp_ipv6.c                           |   1 +
 net/ipv6/udp.c                                |   7 +-
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  22 ++++
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  15 +++
 14 files changed, 206 insertions(+), 52 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

