Return-Path: <bpf+bounces-43742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09329B9519
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 17:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA721F22F07
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB01CB321;
	Fri,  1 Nov 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oKF5GhK7"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164801AC88B;
	Fri,  1 Nov 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477853; cv=none; b=uB+dwsjfU5Cc4AWDs7wcbdoVANmMHVmWhsU0ytxn9EpVEgfDqdnND3XPqzPp94wtHdb0DvCsSEk637c2uI8l8PF23SHruiRwp8JyGDK2VKzqq0VBqfJDXa6tmx732TVwfn7Rm5ecNmYIbW2X4tIYbe682nwpRP3W3Q75tR8Xmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477853; c=relaxed/simple;
	bh=tS1Gc8vPIQh8n8H6rBUkLuyhZPpgH1EVQn/9fgbiz5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cg/AAnfRNs+in881mou8qDSgbGia9OBPvhEZEh3mT5+Dqkcbh3gDcTpauN9jLOUHbQAmfdcJlafXhcqRDfiZ8dmzXzoZDUN/VIGkmuM8sBmS2pN0UUTEDAVeyTxroT1UNdaXi8kf/YIOhIjRY6VU9XyCcmpFzbQMuFTxHBSVJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oKF5GhK7; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=knObx
	hbX3lmJPvj98NKosuFBhV2Tvs31dvMM8J333N8=; b=oKF5GhK7LJqc7OmxG6eEJ
	OQ2i0uOOheHJ/s1wO1NVx+NL4VMBdVN4kMSVUSaEP2W/QCJveay6Mq2FmLySGz6y
	j9KKKbagUTzCH3CeMfNIWixgjElWdu9Niw/tsC+eovDDupncm3R9Hnqz6FOYxuPl
	eQeQVCGWQv5p5oif4R/LV8=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3H7Th_iRn6adKAA--.9355S2;
	Sat, 02 Nov 2024 00:16:40 +0800 (CST)
From: mrpre <mrpre@163.com>
To: yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mrpre <mrpre@163.com>
Subject: [PATCH v2 0/2] bpf: Introduce cpu affinity for sockmap
Date: Sat,  2 Nov 2024 00:16:22 +0800
Message-ID: <20241101161624.568527-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H7Th_iRn6adKAA--.9355S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw17tw4UWF1rJr18Gw45KFg_yoW5WF15pF
	WrK3W5ZF4DGa4SvwnxJ3yxtry3Cr4kGF17KFyaqw48Ar90va4ktF17KFyfGFy5Crs7AFyU
	XrWa9ryUua4jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piuyIUUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwKKp2ck9vdbhAABs8

Why we need cpu affinity:
Mainstream data planes, like Nginx and HAProxy, utilize CPU affinity
by binding user processes to specific CPUs. This avoids interference
between processes and prevents impact from other processes.

Sockmap, as an optimization to accelerate such proxy programs,
currently lacks the ability to specify CPU affinity. The current
implementation of sockmap handling backlog is based on workqueue,
which operates by calling 'schedule_delayed_work()'. It's current
implementation prefers to schedule on the local CPU, i.e., the CPU
that handled the packet under softirq. 

For extremely high traffic with large numbers of packets,
'sk_psock_backlog' becomes a large loop.

For multi-threaded programs with only one map, we expect different
sockets to run on different CPUs. It is important to note that this
feature is not a general performance optimization. Instead, it
provides users with the ability to bind to specific CPU, allowing
them to enhance overall operating system utilization based on their
own system environments.

Implementation:
1.When updating the sockmap, support passing a CPU parameter and
save it to the psock.
2.When scheduling psock, determine which CPU to run on using the
psock's CPU information.
3.For thoes sockmap without CPU affinity, keep original logic by using
'schedule_delayed_work()'.

Performance Testing:
'client <-> sockmap proxy <-> server'

Using 'iperf3' tests, with the iperf server bound to CPU5 and the iperf
client bound to CPU6, performance without using CPU affinity is
around 34 Gbits/s, and CPU usage is concentrated on CPU5 and CPU6.
'''
[  5] local 127.0.0.1 port 57144 connected to 127.0.0.1 port 10000
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  3.95 GBytes  33.9 Gbits/sec
[  5]   1.00-2.00   sec  3.95 GBytes  34.0 Gbits/sec
......
'''

With using CPU affinity, the performnce is close to direct connection
(without any proxy).
'''
[  5] local 127.0.0.1 port 56518 connected to 127.0.0.1 port 10000
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  7.76 GBytes  66.6 Gbits/sec
[  5]   1.00-2.00   sec  7.76 GBytes  66.7 Gbits/sec
......
'''

---
v1 -> v2: fix compile error when some macro disabled
---

mrpre (2):
  bpf: Introduce cpu affinity for sockmap
  bpf: implement libbpf sockmap cpu affinity

 include/linux/bpf.h                           |  5 ++--
 include/linux/skmsg.h                         |  8 +++++++
 include/uapi/linux/bpf.h                      |  4 ++++
 kernel/bpf/syscall.c                          | 23 ++++++++++++++-----
 net/core/skmsg.c                              | 14 +++++------
 net/core/sock_map.c                           | 13 +++++------
 tools/include/uapi/linux/bpf.h                |  4 ++++
 tools/lib/bpf/bpf.c                           | 22 ++++++++++++++++++
 tools/lib/bpf/bpf.h                           |  9 ++++++++
 tools/lib/bpf/libbpf.map                      |  1 +
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 19 +++++++++++----
 11 files changed, 96 insertions(+), 26 deletions(-)

-- 
2.43.5


