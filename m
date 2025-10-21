Return-Path: <bpf+bounces-71564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B82BF6AF3
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BEE64F48DF
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832C334C17;
	Tue, 21 Oct 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c16Q1L7+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FC2EDD53
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052339; cv=none; b=n1BIJvFpeUEUmlgglIR5kL0t8o/ZuhzKCFaZTlkdMsh2slEYesG/l8ewrIUk3yXgIywZ0FFT5Tc1eXI0EvnAxbGxxmFF6Qk52jmJas7+1dOmBbp8HXM1GiDhtU7/C2rYxg0kn/6tldjA8dYwkIk20guILXtTDYPRCVe7m1dklQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052339; c=relaxed/simple;
	bh=lXXrXhZQlKkja3Hsm370JTFLnuv6HR//m4/vJrb54HY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z5aK4A6V5gAHoQl6UvSeVzkpASM6IJBvXOsqNlVPPBYyZIM/JMiPK/2YCSMqJ6s2WODmNVkJZE4Ynj0/2YX4ZQI0lTjCs309Ly5LyFmEgAt6suQxUMnn/QH4/sQsZTsqp80yERm4h99YVOz+gSFd3zM215cgsCxjXdjvyDKCocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c16Q1L7+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290deb0e643so40926685ad.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052337; x=1761657137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnwEDlLy9NGxzXc8xxMXBW1U2krgWGY/nWxqk6w/IGA=;
        b=c16Q1L7+9Z85/9lvjd7D/pNTdY8AAkV24tDmadXnYRELemSFgvGXw0aYyH4n9S4s4f
         Uzv0FdoSWFTI8nNwV2ZuKmA847+q/rVZcmrqOxCdt9YOxin8Dpbilgb+xD5rbgWouqZC
         0/aKebhrNXIpO0q+hDMyhW57K5C1jCDTmQbatMCJN2KqYPNPAfhgKpF3xUQkRmxHUoHb
         Bo3PC6sxGzJ/TQ/pmvOqLs0JvRqY2Mr8Y0xixxHTVfCePzjpL7wCPthllIXgeo0OZqKX
         IWfSrXyrvkVFclt3SS7sXuN8NrL4EbNje0f3o1aVJ0WjbGNSDg/vQC8VVTS7ndcBs0qI
         5wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052337; x=1761657137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnwEDlLy9NGxzXc8xxMXBW1U2krgWGY/nWxqk6w/IGA=;
        b=MmJKt6oaZV7ngxjzQEreEyOnRmbyNL9T0j13o8NNiq4587cI/ixX0tGr7GG/tX3yw4
         rp1WISWbbYNJES1R6eDTULDDtzBed3yV1i7N0IqNmg2tt2lJ6MQOzO7++hE3sFwJgIyN
         roKxhNOSVPAU3kvSoqL8Vkd1Klg93y03KBBXeZZtkmOZKSOnOR+wFjk/9+r/qR4xUD6t
         HaklcT+joiBRJw6ZdL63CIM2lbOh4fVo8MZHKCXHihJk+I9tnPOWdjjyHDhcB/SIOWJB
         AFCuHk5B/axInS0j0Y/5jOfHXd2iii3TifLdQUV7Mj68CR1dSJhwlX5zl7JdVHtiJ2Qb
         NVbw==
X-Gm-Message-State: AOJu0YxuyR+hbK4yd6EAdslcLtZRtYfMzz5RH8lI4ITBvdI0E9U7cFO5
	u/2yD325YGnZFIBspJbfNc1unlKmwGoX9ZzlRhRBAJpcb3cbAi/nYU85
X-Gm-Gg: ASbGncsEmYZ7iRhpLrS6YNzUUYo/YqNRu5WcvGE3VIilv/j3t3+rCmqPFtPgIKd+32g
	iIhzkktQsRz9N0OD01o4JAdQ99iyuo3o8380eQicBSt+oT4KO0o0Plw3nHFBiFtHGhzJBpsSJ2H
	dUCou3Fvvrrs16vu2SvIUGM2yOoGz/K8W/HfCe6GcforANz8x6vORMRqcXZeTmEO61HFyfAxx0H
	NGQ3B6kTRsDBCDODJMNun4eUOf5RwRo19Bv1a28DOkN5jcBAU6y2+SVIZcRUmbX5Ul/4gfZbnDP
	8iCz4gdvBQkBF/rwVNZqMXtlEojXKmujFYZPmK/h2g1Th1v2/INt8mv+Vj3pZfknTCXcRdBS/Kb
	obxKiM4zvgT7OswlS8nlNWSzehfBHTl7ZAluOPc8FYYaKxIHyEDRcSaZuZI75mubMxJ1pdtHErX
	2WHasUPf/fL3snuWfHq56lIGZ/sVUSVCDSIcyry0v/Hzyb12kH1VmyJqySZQ==
X-Google-Smtp-Source: AGHT+IEIVWVEFQQJlwTvkcEsPIa9G1I0ilTN8+mEn+ignqV9jVSKxaeVbgILkk1uZgjXZQfay/Ld0g==
X-Received: by 2002:a17:902:e5cf:b0:290:9576:d6ef with SMTP id d9443c01a7336-290cba423b1mr231725315ad.54.1761052336909;
        Tue, 21 Oct 2025 06:12:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:16 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/9] xsk: batch xmit in copy mode
Date: Tue, 21 Oct 2025 21:12:00 +0800
Message-Id: <20251021131209.41491-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series is focused on the performance improvement in copy mode. As
observed in the physical servers, there are much room left to ramp up
the transmission for copy mode, compared to zerocopy mode.

Even though we can apply zerocopy to achieve a much better performance,
some limitations are still there especially for virtio and veth cases.
In the real world, many hosts still don't implement and support zerocopy
mode for VMs, so copy mode is the only way we can resort to.

Zerocopy has a good function name xskq_cons_read_desc_batch() which
reads descriptors in batch and then sends them out at a time, rather
than just read and send the descriptor one by one in a loop. Similar
batch ideas can be seen from classic mechanisms like GSO/GRO which also
try to handle as many packets as they can at one time. So the motivation
and idea of the series actually originated from them.

Looking back to the initial design and implementation of AF_XDP, it's
not hard to find the big difference it made is to speed up the
transmission when zerocopy mode is enabled. So the conclusion is that
zerocopy mode of AF_XDP outperforms AF_PACKET that still uses copy mode.
As to the whole logic of copy mode for both of them, they looks quite
similar, especially when application using AF_PACKET sets
PACKET_QDISC_BYPASS option. Digging into the details of AF_PACKET, we
can find the implementation is comparatively heavy which can also be
proved by the real test as shown below. The numbers of AF_PACKET test
are a little bit lower.

At the current moment, I consider copy mode of AF_XDP as a half bypass
mechanism to some extent in comparison with the well known bypass
mechanism like DPDK. To avoid much consumption in kernel as much as
possible, then the batch xmit is proposed to aggregate descriptors in a
certain small group and then read/allocate/build/send them in individual
loops.

Applications are allowed to use setsockopt to turn on this feature.
Since memory allocation can be time consuming and heavy due to lack of
memory, it might not be that good to hold one descriptor for too long,
which brings high latency for one skb. That's the reason why the feature
is not set as default.

Experiments numbers:
1) Tested on ixgbe at 10Gb/sec.
copy mode:   1,861,347 pps (baseline)
batch mode:  2,344,052 pps (+25.9%)
xmit.more:   2,711,077 pps (+45.6%)
zc mode:    13,333,593 pps (+616.3%)
AF_PACKET:   1,375,808 pps (-26.0%)

2) Tested on i40e at 10Gb/sec.
copy mode:   1,813,071 pps (baseline)
xmit.more:   3,044,596 pps (67.9%)
zc mode:    14,880,841 pps (720.7%)
AF_PACKET:   1,553,856 pps (-14.0%)

[2]: taskset -c 1 ./xdpsock -i eth1 -t  -S -s 64
---
v3
Link: https://lore.kernel.org/all/20250825135342.53110-1-kerneljasonxing@gmail.com/
1. I retested and got different test numbers. Previous test is not that
right because my env has two NUMA nodes and only the first one has a
faster speed.
2. To achieve a stable performance result, the development and
evaluation are also finished in physical servers just like the numbers
that I share.
3. I didn't use pool->tx_descs because sockets can share the same umem
pool.
3. Use skb list to chain the allocated and built skbs to send.
5. Add AF_PACKET test numbers.


V2
Link: https://lore.kernel.org/all/20250811131236.56206-1-kerneljasonxing@gmail.com/
1. add xmit.more sub-feature (Jesper)
2. add kmem_cache_alloc_bulk (Jesper and Maciej)

Jason Xing (9):
  xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
  xsk: extend xsk_build_skb() to support passing an already allocated
    skb
  xsk: add xsk_alloc_batch_skb() to build skbs in batch
  xsk: add direct xmit in batch function
  xsk: rename nb_pkts to nb_descs in xsk_tx_peek_release_desc_batch
  xsk: extend xskq_cons_read_desc_batch to count nb_pkts
  xsk: support batch xmit main logic
  xsk: support generic batch xmit in copy mode
  xsk: support dynamic xmit.more control for batch xmit

 Documentation/networking/af_xdp.rst |  17 +++
 include/net/xdp_sock.h              |  14 ++
 include/uapi/linux/if_xdp.h         |   1 +
 net/core/dev.c                      |  26 ++++
 net/core/skbuff.c                   | 101 +++++++++++++
 net/xdp/xsk.c                       | 223 ++++++++++++++++++++++++----
 net/xdp/xsk_queue.h                 |   5 +-
 tools/include/uapi/linux/if_xdp.h   |   1 +
 8 files changed, 359 insertions(+), 29 deletions(-)

-- 
2.41.3


