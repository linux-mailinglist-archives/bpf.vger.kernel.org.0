Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA31236BDDC
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 05:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhD0Drv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Apr 2021 23:47:51 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:33976 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhD0Dru (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Apr 2021 23:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1619495229; x=1651031229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t6tAdQlIpp9W88atuV8CyB0mCSqcS0sDQQjhTKNSrN0=;
  b=D4AmW5SNIONMVO24ueSTVJa2Vvv41gnDsArL2tdW4TkgAuZ3DoBLfF6W
   rXkvXa6XbQv0lgDwhJc2tynzhd6C5GfkkkaORIYiZSBZmFtofgClS8f+g
   Mxcf/UlE0ez3IBKjDCWpOX6WYH+fTKdGoYMwtPI/tZmoM3Dvuie6aM8eg
   M=;
X-IronPort-AV: E=Sophos;i="5.82,254,1613433600"; 
   d="scan'208";a="108548899"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 27 Apr 2021 03:47:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id B02E61201AF;
        Tue, 27 Apr 2021 03:47:05 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 27 Apr 2021 03:47:05 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.93) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 27 Apr 2021 03:47:00 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
CC:     Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 bpf-next 00/11] Socket migration for SO_REUSEPORT.
Date:   Tue, 27 Apr 2021 12:46:12 +0900
Message-ID: <20210427034623.46528-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.93]
X-ClientProxiedBy: EX13D18UWC002.ant.amazon.com (10.43.162.88) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The SO_REUSEPORT option allows sockets to listen on the same port and to
accept connections evenly. However, there is a defect in the current
implementation [1]. When a SYN packet is received, the connection is tied
to a listening socket. Accordingly, when the listener is closed, in-flight
requests during the three-way handshake and child sockets in the accept
queue are dropped even if other listeners on the same port could accept
such connections.

This situation can happen when various server management tools restart
server (such as nginx) processes. For instance, when we change nginx
configurations and restart it, it spins up new workers that respect the new
configuration and closes all listeners on the old workers, resulting in the
in-flight ACK of 3WHS is responded by RST.

To avoid such a situation, users have to know deeply how the kernel handles
SYN packets and implement connection draining by eBPF [2]:

  1. Stop routing SYN packets to the listener by eBPF.
  2. Wait for all timers to expire to complete requests
  3. Accept connections until EAGAIN, then close the listener.

  or

  1. Start counting SYN packets and accept syscalls using the eBPF map.
  2. Stop routing SYN packets.
  3. Accept connections up to the count, then close the listener.

In either way, we cannot close a listener immediately. However, ideally,
the application need not drain the not yet accepted sockets because 3WHS
and tying a connection to a listener are just the kernel behaviour. The
root cause is within the kernel, so the issue should be addressed in kernel
space and should not be visible to user space. This patchset fixes it so
that users need not take care of kernel implementation and connection
draining. With this patchset, the kernel redistributes requests and
connections from a listener to the others in the same reuseport group
at/after close or shutdown syscalls.

Although some software does connection draining, there are still merits in
migration. For some security reasons, such as replacing TLS certificates,
we may want to apply new settings as soon as possible and/or we may not be
able to wait for connection draining. The sockets in the accept queue have
not started application sessions yet. So, if we do not drain such sockets,
they can be handled by the newer listeners and could have a longer
lifetime. It is difficult to drain all connections in every case, but we
can decrease such aborted connections by migration. In that sense,
migration is always better than draining. 

Moreover, auto-migration simplifies user space logic and also works well in
a case where we cannot modify and build a server program to implement the
workaround.

Note that the source and destination listeners MUST have the same settings
at the socket API level; otherwise, applications may face inconsistency and
cause errors. In such a case, we have to use the eBPF program to select a
specific listener or to cancel migration.

Special thanks to Martin KaFai Lau for bouncing ideas and exchanging code
snippets along the way.


Link:
 [1] The SO_REUSEPORT socket option
 https://lwn.net/Articles/542629/

 [2] Re: [PATCH 1/1] net: Add SO_REUSEPORT_LISTEN_OFF socket option as drain mode
 https://lore.kernel.org/netdev/1458828813.10868.65.camel@edumazet-glaptop3.roam.corp.google.com/


Changelog:
 v4:
  * Make some functions and variables 'static' in selftest
  * Remove 'scalability' from the cover letter because it is not
    primarily reason to use SO_REUSEPORT

 v3:
 https://lore.kernel.org/bpf/20210420154140.80034-1-kuniyu@amazon.co.jp/
  * Add sysctl back for reuseport_grow()
  * Add helper functions to manage socks[]
  * Separate migration related logic into functions: reuseport_resurrect(),
    reuseport_stop_listen_sock(), reuseport_migrate_sock()
  * Clone request_sock to be migrated
  * Migrate request one by one
  * Pass child socket to eBPF prog

 v2:
 https://lore.kernel.org/netdev/20201207132456.65472-1-kuniyu@amazon.co.jp/
  * Do not save closed sockets in socks[]
  * Revert 607904c357c61adf20b8fd18af765e501d61a385
  * Extract inet_csk_reqsk_queue_migrate() into a single patch
  * Change the spin_lock order to avoid lockdep warning
  * Add static to __reuseport_select_sock
  * Use refcount_inc_not_zero() in reuseport_select_migrated_sock()
  * Set the default attach type in bpf_prog_load_check_attach()
  * Define new proto of BPF_FUNC_get_socket_cookie
  * Fix test to be compiled successfully
  * Update commit messages

 v1:
 https://lore.kernel.org/netdev/20201201144418.35045-1-kuniyu@amazon.co.jp/
  * Remove the sysctl option
  * Enable migration if eBPF progam is not attached
  * Add expected_attach_type to check if eBPF program can migrate sockets
  * Add a field to tell migration type to eBPF program
  * Support BPF_FUNC_get_socket_cookie to get the cookie of sk
  * Allocate an empty skb if skb is NULL
  * Pass req_to_sk(req)->sk_hash because listener's hash is zero
  * Update commit messages and coverletter

 RFC:
 https://lore.kernel.org/netdev/20201117094023.3685-1-kuniyu@amazon.co.jp/


Kuniyuki Iwashima (11):
  net: Introduce net.ipv4.tcp_migrate_req.
  tcp: Add num_closed_socks to struct sock_reuseport.
  tcp: Keep TCP_CLOSE sockets in the reuseport group.
  tcp: Add reuseport_migrate_sock() to select a new listener.
  tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets in accept queues.
  tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.
  tcp: Migrate TCP_NEW_SYN_RECV requests at receiving the final ACK.
  bpf: Support BPF_FUNC_get_socket_cookie() for
    BPF_PROG_TYPE_SK_REUSEPORT.
  bpf: Support socket migration by eBPF.
  libbpf: Set expected_attach_type for BPF_PROG_TYPE_SK_REUSEPORT.
  bpf: Test BPF_SK_REUSEPORT_SELECT_OR_MIGRATE.

 Documentation/networking/ip-sysctl.rst        |  20 +
 include/linux/bpf.h                           |   1 +
 include/linux/filter.h                        |   2 +
 include/net/netns/ipv4.h                      |   1 +
 include/net/request_sock.h                    |   2 +
 include/net/sock_reuseport.h                  |   9 +-
 include/uapi/linux/bpf.h                      |  16 +
 kernel/bpf/syscall.c                          |  13 +
 net/core/filter.c                             |  23 +-
 net/core/request_sock.c                       |  38 ++
 net/core/sock_reuseport.c                     | 337 ++++++++++--
 net/ipv4/inet_connection_sock.c               | 147 +++++-
 net/ipv4/inet_hashtables.c                    |   2 +-
 net/ipv4/sysctl_net_ipv4.c                    |   9 +
 net/ipv4/tcp_ipv4.c                           |  20 +-
 net/ipv6/tcp_ipv6.c                           |  14 +-
 tools/include/uapi/linux/bpf.h                |  16 +
 tools/lib/bpf/libbpf.c                        |   5 +-
 tools/testing/selftests/bpf/network_helpers.c |   2 +-
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../bpf/prog_tests/migrate_reuseport.c        | 484 ++++++++++++++++++
 .../bpf/progs/test_migrate_reuseport.c        |  51 ++
 22 files changed, 1151 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_migrate_reuseport.c

-- 
2.30.2

