Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088C5B8788
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2019 00:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392385AbfISWpY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Sep 2019 18:45:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44560 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392278AbfISWpX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Sep 2019 18:45:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so4548274otj.11;
        Thu, 19 Sep 2019 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=haUSW2nZ3c3G2iZ6BINHVsWlZJ1ycviKyW4bDnnGsEo=;
        b=Uvaiz9SLmkkHqRYMDfWiXIVGVFH+UKkX+5LsA9Qr5ZLLKYJgJ4e2HDqCrZ9/Zja13g
         dGvCSYny/pI6hNqxoRF29QZgLD9KPn5Y3st3ULhSozhgpL45r/PMi/o5vDkmIm5aLLZ4
         c3dCPlZ41o7D5QHKB8GULUL+Aag2bLw6o627u1yQCIEUGr9jJGj591mSGUuTlilbXNp4
         MrR7A3a8QLuRND0jQawVUUft4vlBV5sR4XrKJ2p1pdNhxjBjU8XumgYmMmdd/z8HtXRb
         ocP6W3pSRU54ZTMLOvjCVNV6Ze8lXVPtX9xJba7OELqxumtCDSsOMfY9t9I3ZgC3LY7R
         8w+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=haUSW2nZ3c3G2iZ6BINHVsWlZJ1ycviKyW4bDnnGsEo=;
        b=T6mSwohs4ccTxq6gGp1k0iJzeTinW4wFHzxGHQyhjRRv/4KeCdUqXRp+i6XBHGZuwK
         DPXgAwSVf5swhIxB9+ab8wrcwYv3KKwwW5kCtPHcCrNk5Ggcuy73A9KioiB6RvuLy5S0
         E7UJ3jDCELf8OuJmbd62h8uFjK6NmVCwBcq8d2WEmQvx1P0KMjLKSLJzZ7GtxC4RJZY0
         CfR2DFpWU086wHSaA7J6BgCnl2RXmH68/NxR0x6c46icRkTiFIOY8TFezH+6t+YVuqOe
         31cODrJT4fPeVf4jpvVt4K6zc0wGTKnPJDLv2vyYcUnHMixSTxlU7MdPfUEEOYNFA6Y7
         CxbQ==
X-Gm-Message-State: APjAAAVMukLY+SHiDyLz0C1T3+xQMTV4TNm0DT/naJ68b2/HBYgE7Wwg
        h06lhf4Hjv6ZMAT95ypQe9g=
X-Google-Smtp-Source: APXvYqzygx4OQ/zjZJDPRBdLGVUzJCt573VOjfy3NSLyT+NPVmpM0MmkD+vOXvILYulNMsjBMFvUbg==
X-Received: by 2002:a9d:825:: with SMTP id 34mr1195058oty.178.1568933122417;
        Thu, 19 Sep 2019 15:45:22 -0700 (PDT)
Received: from localhost.localdomain (ip24-56-44-135.ph.ph.cox.net. [24.56.44.135])
        by smtp.gmail.com with ESMTPSA id y11sm1621oih.18.2019.09.19.15.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 15:45:21 -0700 (PDT)
From:   Matthew Cover <werekraken@gmail.com>
X-Google-Original-From: Matthew Cover <matthew.cover@stackpath.com>
To:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        nikolay@cumulusnetworks.com, sd@queasysnail.net,
        sbrivio@redhat.com, vincent@bernat.ch, kda@linux-powerpc.org,
        matthew.cover@stackpath.com, jiri@mellanox.com,
        edumazet@google.com, pabeni@redhat.com, idosch@mellanox.com,
        petrm@mellanox.com, f.fainelli@gmail.com,
        stephen@networkplumber.org, dsahern@gmail.com,
        christian@brauner.io, jakub.kicinski@netronome.com,
        roopa@cumulusnetworks.com, johannes.berg@intel.com,
        mkubecek@suse.cz, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC {net,iproute2}-next 0/2] Introduce an eBPF hookpoint for tx queue selection in the XPS (Transmit Packet Steering) code.
Date:   Thu, 19 Sep 2019 15:44:58 -0700
Message-Id: <20190919224458.91422-1-matthew.cover@stackpath.com>
X-Mailer: git-send-email 2.15.2 (Apple Git-101.1)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

WORK IN PROGRESS:
  * bpf program loading works!
  * txq steering via bpf program return code works!
  * bpf program unloading not working.
  * bpf program attached query not working.

This patch set provides a bpf hookpoint with goals similar to, but a more
generic implementation than, TUNSETSTEERINGEBPF; userspace supplied tx queue
selection policy.

TUNSETSTEERINGEBPF is a useful bpf hookpoint, but has some drawbacks.

First, it only works on tun/tap devices.

Second, there is no way in the current TUNSETSTEERINGEBPF implementation
to bail out or load a noop bpf prog and fallback to the no prog tx queue
selection method.

Third, the TUNSETSTEERINGEBPF interface seems to require possession of existing
or creation of new queues/fds.

This most naturally fits in the "wire" implementation since possession of fds
is ensured. However, it also means the various "wire" implementations (e.g.
qemu) have to all be made aware of TUNSETSTEERINGEBPF and expose an interface
to load/unload a bpf prog (or provide a mechanism to pass an fd to another
program).

Alternatively, you can spin up an extra queue and immediately disable via
IFF_DETACH_QUEUE, but this seems unsafe; packets could be enqueued to this
extra file descriptor which is part of our bpf prog loader, not our "wire".

Placing this in the XPS code and leveraging iproute2 and rtnetlink to provide
our bpf prog loader in a similar manner to xdp gives us a nice way to separate
the tap "wire" and the loading of tx queue selection policy. It also lets us
use this hookpoint for any device traversing XPS.

This patch only introduces the new hookpoint to the XPS code and will not yet
be used by tun/tap devices using the intree tun.ko (which implements an
.ndo_select_queue and does not traverse the XPS code).

In a future patch set, we can optionally refactor tun.ko to traverse this call
to bpf_prog_run_clear_cb() and bpf prog storage. tun/tap devices could then
leverage iproute2 as a generic loader. The TUNSETSTEERINGEBPF interface could
at this point be optionally deprecated/removed.

Both patches in this set have been tested using a rebuilt tun.ko with no
.ndo_select_queue.

  sed -i '/\.ndo_select_queue.*=/d' drivers/net/tun.c

The tap device was instantiated using tap_mq_pong.c, supporting scripts, and
wrapping service found here:

  https://github.com/stackpath/rxtxcpu/tree/v1.2.6/helpers

The bpf prog source and test scripts can be found here:

  https://github.com/werekraken/xps_ebpf

In nstxq, netsniff-ng using PACKET_FANOUT_QM is leveraged to check the
queue_mapping.

With no prog loaded, the tx queue selection is adhering our xps_cpus
configuration.

  [vagrant@localhost ~]$ grep . /sys/class/net/tap0/queues/tx-*/xps_cpus; ./nstxq; sudo timeout 1 cat /sys/kernel/debug/tracing/trace_pipe;
  /sys/class/net/tap0/queues/tx-0/xps_cpus:1
  /sys/class/net/tap0/queues/tx-1/xps_cpus:2
  cpu0: ping: 64 bytes from 169.254.254.1: icmp_seq=1 ttl=64 time=0.146 ms
  cpu0: qm0:  > tap0 98 Unknown => Unknown IPv4 169.254.254.2/169.254.254.1 Len 84 Type 8 Code 0
  cpu1: ping: 64 bytes from 169.254.254.1: icmp_seq=1 ttl=64 time=0.121 ms
  cpu1: qm1:  > tap0 98 Unknown => Unknown IPv4 169.254.254.2/169.254.254.1 Len 84 Type 8 Code 0

With a return 0 bpg prog, our tx queue is 0 (despite xps_cpus).

  [vagrant@localhost ~]$ sudo ip link set dev tap0 xps obj hello0.o sec hello && { ./nstxq; sudo timeout 1 cat /sys/kernel/debug/tracing/trace_pipe; }
  cpu0: ping: 64 bytes from 169.254.254.1: icmp_seq=1 ttl=64 time=0.160 ms
  cpu0: qm0:  > tap0 98 Unknown => Unknown IPv4 169.254.254.2/169.254.254.1 Len 84 Type 8 Code 0
  cpu1: ping: 64 bytes from 169.254.254.1: icmp_seq=1 ttl=64 time=0.124 ms
  cpu1: qm0:  > tap0 98 Unknown => Unknown IPv4 169.254.254.2/169.254.254.1 Len 84 Type 8 Code 0
              ping-4852  [000] ....  2691.633260: 0: xps (RET 0): Hello, World!
              ping-4869  [001] ....  2695.753588: 0: xps (RET 0): Hello, World!

With a return 1 bpg prog, our tx queue is 1.

  [vagrant@localhost ~]$ sudo ip link set dev tap0 xps obj hello1.o sec hello && { ./nstxq; sudo timeout 1 cat /sys/kernel/debug/tracing/trace_pipe; }
  cpu0: ping: 64 bytes from 169.254.254.1: icmp_seq=1 ttl=64 time=0.193 ms
  cpu0: qm1:  > tap0 98 Unknown => Unknown IPv4 169.254.254.2/169.254.254.1 Len 84 Type 8 Code 0
  cpu1: ping: 64 bytes from 169.254.254.1: icmp_seq=1 ttl=64 time=0.135 ms
  cpu1: qm1:  > tap0 98 Unknown => Unknown IPv4 169.254.254.2/169.254.254.1 Len 84 Type 8 Code 0
              ping-4894  [000] ....  2710.652080: 0: xps (RET 1): Hello, World!
              ping-4911  [001] ....  2714.774608: 0: xps (RET 1): Hello, World!

With a return 2 bpg prog, our tx queue is 0 (we only have 2 tx queues).

  [vagrant@localhost ~]$ sudo ip link set dev tap0 xps obj hello2.o sec hello && { ./nstxq; sudo timeout 1 cat /sys/kernel/debug/tracing/trace_pipe; }
  cpu0: ping: 64 bytes from 169.254.254.1: icmp_seq=1 ttl=64 time=1.20 ms
  cpu0: qm0:  > tap0 98 Unknown => Unknown IPv4 169.254.254.2/169.254.254.1 Len 84 Type 8 Code 0
  cpu1: ping: 64 bytes from 169.254.254.1: icmp_seq=1 ttl=64 time=0.986 ms
  cpu1: qm0:  > tap0 98 Unknown => Unknown IPv4 169.254.254.2/169.254.254.1 Len 84 Type 8 Code 0
              ping-4936  [000] ....  2729.442668: 0: xps (RET 2): Hello, World!
              ping-4953  [001] ....  2733.614558: 0: xps (RET 2): Hello, World!

With a return -1 bpf prog, our tx queue selection is once again determined by
xps_cpus. Any negative return should work the same and provides a nice
mechanism to bail out or have a noop bpf prog at this hookpoint.

  [vagrant@localhost ~]$ sudo ip link set dev tap0 xps obj hello_neg1.o sec hello && { ./nstxq; sudo timeout 1 cat /sys/kernel/debug/tracing/trace_pipe; }
  cpu0: ping: 64 bytes from 169.254.254.1: icmp_seq=1 ttl=64 time=0.628 ms
  cpu0: qm0:  > tap0 98 Unknown => Unknown IPv4 169.254.254.2/169.254.254.1 Len 84 Type 8 Code 0
  cpu1: ping: 64 bytes from 169.254.254.1: icmp_seq=1 ttl=64 time=0.322 ms
  cpu1: qm1:  > tap0 98 Unknown => Unknown IPv4 169.254.254.2/169.254.254.1 Len 84 Type 8 Code 0
              ping-4981  [000] ....  2763.510760: 0: xps (RET -1): Hello, World!
              ping-4998  [001] ....  2767.632583: 0: xps (RET -1): Hello, World!

bpf prog unloading is not yet working and neither does `ip link show` report
when an "xps" bpf prog is attached. This is my first time touching iproute2 or
rtnetlink, so it may be something obvious to those more familiar.
