Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67E5C473
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 22:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfGAUsY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 16:48:24 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35880 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUsY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 16:48:24 -0400
Received: by mail-pf1-f202.google.com with SMTP id b195so9070309pfb.3
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1fU963y6n1uxxX6uDB4NB2bxwMtwWhsu0C0kXZ5bPNs=;
        b=uYPfOoRzpRH2tNIG+V1pCcb3F8KuEAEGi1QUvV7SXtbjm8NtGlrD8o61XKC+or3AUP
         qF60O5//VaUaNFarLQpFL6+cXTUa8sXmJoX6V4k7VIiSO4fC+c/g9aTzBOE4dsHmwKvu
         biaebexH6ZOKqahilR9mMajrGMEhmRKL5S3Vdtt3ojL/4fNJeorBuwov/C+MVGbxqVv6
         bXxEKIgm0hfUls4UbgyxrBHi7EoAL4mOVP2TnKE2+YwTGX9widmgL52uYfyIKfZl0wUz
         5OkA+YOzxSAhyGXoHXZ3cgbUD5UkOyxfm9b+fe5jCqXADjN/GvdsZvICbL1lZV/PVknI
         di6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1fU963y6n1uxxX6uDB4NB2bxwMtwWhsu0C0kXZ5bPNs=;
        b=YHMAPvRIccgECw5Gu0Y2l8oFCMUbMz+OhGNfb7RQKlf7GurJOhTn7T4nob2Rt4epR5
         wKUgUJ8XjaIuX5lWQILgyAYuEOKzCeIjBZeHt61kGuRNoFMrqbw/so8fR39pulZ8+ReU
         3c71c7BFWUsLsY8KZVlG+1cJ0dBhUgkr5d6fplR7vMljaQ9GSz42ca9zdUcFBMsKgoKD
         4hHUKx3M7PI03EGc1lGIICQJAu4iibxBb0aWtVQCSwS+gu0ncghVYAwa4ve+vN8Om+c3
         mIZAvFPV4itb/tAbZVCeFypH7F9K3oIhGL1JJVzC+wP2o2ANgJTO4yOQqebzpKCBYxRc
         eKag==
X-Gm-Message-State: APjAAAViDmOJRUUL0k3i087Y7ZNXk02sOZ9LhnzgAvJh7WAvo55R09vd
        jN2BJ8y00mAI5ViGjTQ9tm34yUs=
X-Google-Smtp-Source: APXvYqzReUwAMT6ii0T6l1Fk7MOoclkoZ6uMqHZ9izzIcx70OdGnNHKpKUKWKc65dXxph9wz6m+NnWg=
X-Received: by 2002:a63:3d0f:: with SMTP id k15mr26848612pga.343.1562014103653;
 Mon, 01 Jul 2019 13:48:23 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:48:13 -0700
Message-Id: <20190701204821.44230-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next 0/8] bpf: TCP RTT sock_ops bpf callback
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Congestion control team would like to have a periodic callback to
track some TCP statistics. Let's add a sock_ops callback that can be
selectively enabled on a socket by socket basis and is executed for
every RTT. BPF program frequency can be further controlled by calling
bpf_ktime_get_ns and bailing out early.

I run neper tcp_stream and tcp_rr tests with the sample program
from the last patch and didn't observe any noticeable performance
difference.

Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Priyaranjan Jha <priyarjha@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>

Stanislav Fomichev (8):
  bpf: add BPF_CGROUP_SOCK_OPS callback that is executed on every RTT
  bpf: split shared bpf_tcp_sock and bpf_sock_ops implementation
  bpf: add dsack_dups/delivered{,_ce} to bpf_tcp_sock
  bpf: add icsk_retransmits to bpf_tcp_sock
  bpf/tools: sync bpf.h
  selftests/bpf: test BPF_SOCK_OPS_RTT_CB
  samples/bpf: add sample program that periodically dumps TCP stats
  samples/bpf: fix tcp_bpf.readme detach command

 include/net/tcp.h                           |   8 +
 include/uapi/linux/bpf.h                    |  12 +-
 net/core/filter.c                           | 207 +++++++++++-----
 net/ipv4/tcp_input.c                        |   4 +
 samples/bpf/Makefile                        |   1 +
 samples/bpf/tcp_bpf.readme                  |   2 +-
 samples/bpf/tcp_dumpstats_kern.c            |  65 +++++
 tools/include/uapi/linux/bpf.h              |  12 +-
 tools/testing/selftests/bpf/Makefile        |   3 +-
 tools/testing/selftests/bpf/progs/tcp_rtt.c |  61 +++++
 tools/testing/selftests/bpf/test_tcp_rtt.c  | 253 ++++++++++++++++++++
 11 files changed, 570 insertions(+), 58 deletions(-)
 create mode 100644 samples/bpf/tcp_dumpstats_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_rtt.c
 create mode 100644 tools/testing/selftests/bpf/test_tcp_rtt.c

-- 
2.22.0.410.gd8fdbe21b5-goog
