Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B179B107E1C
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 12:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfKWLH6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 06:07:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33586 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfKWLH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 06:07:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so10302425ljk.0
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2019 03:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5IwuyLdmFqA0hYfBlKWtnKw8VICEvkBa15wVnL1xCqA=;
        b=dhwW083UwbO/JBZYf03/oGHYnJymakknphtOycCqiwkAFzsZyuLgYNBmumS53va5tK
         mh4JgOfgmD7s5rMa/YIam9HRmUbwcoevzBJMq2y2SEKlKYIoCd3avMHfAfUr/nwrba6s
         LzkccaLznInXN55BwYeLqqwieFaN0CnCNKtbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5IwuyLdmFqA0hYfBlKWtnKw8VICEvkBa15wVnL1xCqA=;
        b=YJC6jghQqUAvZ7z6umUGJmdrTFaLp5hHLHUSqNoA4jNwYCiDVzAmfds8dBBIYQ6WYZ
         zO+936CxFxoVAtgTEkgl9Yo4MZ68rjn6kfEQdvjv7BqMKLaPF62xvzd8PBdvaSVDWltr
         4iiyVMA8FLXG6vp4n88hgP7uPcIQUFHudsC5J6lSC66fOKwrCkQCIEHeDtwAICMz5zbn
         Vki4g5GiQR7V6ErcPuYKxfyL+ndFu/TzZq0yBGCDGNr6SR8YuB1CGxx+qWCiETIpZjQH
         8w6UIRCZ8pyavasO/0P2QOTwh11qthakvJs7M7/aObQ3oVg6V2ea3pvcfPJjhVJjKjv1
         XDeQ==
X-Gm-Message-State: APjAAAX9mKoS7uqrpKudiAofOlct/RLqtTrla+0bXLe5WHePBqX2df/n
        mM+A1UAJluOqQJCQMRjjU/CqmiLa9kvcNg==
X-Google-Smtp-Source: APXvYqyJZ5GG8ERIUysgoYX6PhxyfZr6OWptdicTt04GjKviVEtsLYC+YfXjm68hGgp0YrEVbwVGOw==
X-Received: by 2002:a2e:3311:: with SMTP id d17mr15831726ljc.237.1574507273369;
        Sat, 23 Nov 2019 03:07:53 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id a18sm553099lfg.2.2019.11.23.03.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 03:07:52 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 0/8] Extend SOCKMAP to store listening sockets
Date:   Sat, 23 Nov 2019 12:07:43 +0100
Message-Id: <20191123110751.6729-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set makes SOCKMAP more flexible by allowing it to hold TCP
sockets that are either in established or listening state. With it SOCKMAP
can act as a drop-in replacement for REUSEPORT_SOCKARRAY which reuseport
BPF programs use. Granted, it is limited to only TCP sockets.

The idea started out at LPC '19 as feedback from John Fastabend to our
troubles with repurposing REUSEPORT_SOCKARRAY as a collection of listening
sockets accessed by a BPF program ran on socket lookup [1]. Without going
into details, REUSEPORT_SOCKARRAY proved to be tightly coupled with
reuseport logic. Talk from LPC (see slides [2] or video [3]) highlights
what problems we ran into when trying to make REUSEPORT_SOCKARRAY work for
our use-case.

Patches have evolved quite a bit since the RFC series from a month ago
[4]. To recap the RFC feedback, John pointed out that BPF redirect helpers
for SOCKMAP need sane semantics when used with listening sockets [5], and
that SOCKMAP lookup from BPF would be useful [6]. While Martin asked for
UDP support [7].

As it happens, patches needed more work to get SOCKMAP to actually behave
correctly with listening sockets. It turns out flexibility has its
price. Change log below outlines them all.

With more than I would like patches in the set, I left the new features,
lookup from BPF as well as UDP support, for another series. I'm quite happy
with how the changes turned out and the test coverage so I'm boldly
proposing it as v1 :-)

Curious to see what you think.

RFC -> v1:

- Switch from overriding proto->accept to af_ops->syn_recv_sock, which
  happens earlier. Clearing the psock state after accept() does not work
  for child sockets that become orphaned (never got accepted). v4-mapped
  sockets need special care.

- Return the socket cookie on SOCKMAP lookup from syscall to be on par with
  REUSEPORT_SOCKARRAY. Requires SOCKMAP to take u64 on lookup/update from
  syscall.

- Make bpf_sk_redirect_map (ingress) and bpf_msg_redirect_map (egress)
  SOCKMAP helpers fail when target socket is a listening one.

- Make bpf_sk_select_reuseport helper fail when target is a TCP established
  socket.

- Teach libbpf to recognize SK_REUSEPORT program type from section name.

- Add a dedicated set of tests for SOCKMAP holding listening sockets,
  covering map operations, overridden socket callbacks, and BPF helpers.

Thanks,
Jakub

[1] https://lore.kernel.org/bpf/20190828072250.29828-1-jakub@cloudflare.com/
[2] https://linuxplumbersconf.org/event/4/contributions/487/
[3] https://www.youtube.com/watch?v=qRDoUpqvYjY
[4] https://lore.kernel.org/bpf/20191022113730.29303-1-jakub@cloudflare.com/
[5] https://lore.kernel.org/bpf/5db1da20174b1_5c282ada047205c046@john-XPS-13-9370.notmuch/
[6] https://lore.kernel.org/bpf/5db1d7a810bdb_5c282ada047205c08f@john-XPS-13-9370.notmuch/
[7] https://lore.kernel.org/bpf/20191028213804.yv3xfjjlayfghkcr@kafai-mbp/


Jakub Sitnicki (8):
  bpf, sockmap: Return socket cookie on lookup from syscall
  bpf, sockmap: Let all kernel-land lookup values in SOCKMAP
  bpf, sockmap: Allow inserting listening TCP sockets into SOCKMAP
  bpf, sockmap: Don't let child socket inherit psock or its ops on copy
  bpf: Allow selecting reuseport socket from a SOCKMAP
  libbpf: Recognize SK_REUSEPORT programs from section name
  selftests/bpf: Extend SK_REUSEPORT tests to cover SOCKMAP
  selftests/bpf: Tests for SOCKMAP holding listening sockets

 include/linux/skmsg.h                         |  17 +-
 kernel/bpf/verifier.c                         |   6 +-
 net/core/filter.c                             |   2 +
 net/core/sock_map.c                           |  68 +-
 net/ipv4/tcp_bpf.c                            |  66 +-
 tools/lib/bpf/libbpf.c                        |   1 +
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   9 +-
 .../bpf/progs/test_sockmap_listen_kern.c      |  75 ++
 tools/testing/selftests/bpf/test_maps.c       |   6 +-
 .../selftests/bpf/test_select_reuseport.c     | 141 ++-
 .../selftests/bpf/test_select_reuseport.sh    |  14 +
 .../selftests/bpf/test_sockmap_listen.c       | 820 ++++++++++++++++++
 13 files changed, 1170 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_listen_kern.c
 create mode 100755 tools/testing/selftests/bpf/test_select_reuseport.sh
 create mode 100644 tools/testing/selftests/bpf/test_sockmap_listen.c

-- 
2.20.1

