Return-Path: <bpf+bounces-50439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76799A279BF
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272411881E99
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD61217705;
	Tue,  4 Feb 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAFwYO5u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B515252D;
	Tue,  4 Feb 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693836; cv=none; b=BRAKteT9T2m47ms10pnVGBuCuJy24ceC87s+Ret8GfLSMumpV+Y2BJ6JoD08QlAboIiFWUoiyb4jxQXjm0IT34XS/JRAu5V4LJJKd09qU8Ntpmjohgan6T6GTULtEst1QeAWxfqMpLiyx65NVmnh5OZ0cmAHDg2CdoXJr3vO0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693836; c=relaxed/simple;
	bh=ArJbdHQwzfrkXpNb3pfo4qe0mHZHMYSRAPhU7mJdzKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OCtOwqsomll4defpC+iuvKZ/SIDzMq5S5cVpTfE73cDSAgzFKj9imKrVsrBt11XRRa0ziJNtWtSsMJhIxZJILDJGb5aziI5I24AoJxpKqYTVT27w9QT/yTNuprbOBPdAEtZqEPPT/Ghtf3vGDVcs/mcOV75/imIaYv8Hz+pIKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAFwYO5u; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9c3124f31so1511844a91.0;
        Tue, 04 Feb 2025 10:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693833; x=1739298633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3amNg7ysrrSBs4wHJi9tlgwBM+AKFJ3JBuOpBfqTVF8=;
        b=KAFwYO5uMj7EE408cbdZjm7jucoMyWkHFxyNvjkulv3MSk8I1Nc82Zh3sUABhaOl7x
         I5qZMvkIanXpeLlaUGIp3AlNzoOYSRg0NDG6VJOOxHvwuc6h9/XxvneZFfMiA9kkOeZ3
         1aw2a1sq5BjJtyG6VvByaZ/KkFDrM3EEB9Ups7XMG3vSClv3mEM7R5ZLJjp8b4JenRqQ
         BwsGUsGQ14svSU67L+LP9j/FVAjZCTqZrKk1VyZy3o86WJepL0Fe9CyGO9qmIuYCBsMx
         t0R910KHWLgeoiG+EizxSLzuetLO5IDJY8a63Flp86BT05kawrS8Ou4EPcW/4H4DGwmf
         24RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693833; x=1739298633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3amNg7ysrrSBs4wHJi9tlgwBM+AKFJ3JBuOpBfqTVF8=;
        b=DvduJv2F9MUZ/l9cCrBaOk6REgJansULOEwAjA3l8go2jqC1Kxut8F4OFhWJWGx5Bh
         tAhqVPI8EZUoy5l9qU8LRUU02/js3ycUFEqB3v4hq9L/OJX9kIOTQ2Xwfifc2xEHGD5w
         W2iEOQ49p/LYQsN5TcDJrpxt5auQFgndXZOon13rQOfMqVdRrpgKmclFYsraARUzakeA
         kfNw7Qr9G3wWd/hdTy6UbxLp3+0mw7Wg1h13KE0rho1nUYd8xyZiSFkXtIQb7os3BAZf
         +gkMs7xI0To2kMpU7921tuflbxNZlA7Bzp3BoI1WHo87ruYVbxEJ8EBCntduBM6eRT3S
         DzWw==
X-Forwarded-Encrypted: i=1; AJvYcCWrXAFRNSSKe5prZwoxNnwFi2wgVZq1f5vVn4VxE2QBcllvYDmYUoCYr5kZhN+y2rNBJK867hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwontLx9YRQ9JvglY13LlCGbWSZ8DQPHNI1tJjN1cIQPNXA0U3+
	agfKPL8tUMlCXlB4swiHIb0SbVIK0YXXudEh1rFFfDRF4MspkhZueuR2ifBt/3w=
X-Gm-Gg: ASbGnctHbR6LicuMVZblMeZf6puByoGvXs7SrG8mvyMZtVdzGbNHdME9MG4g0Oeo0ob
	3jgnJrwPU1mLilVL/E+yLnU5nzvVWhO2hiwNY+xAZYMbZukNpds5e8SUWPC2fwweZVIvP0y1yJO
	D++28tR0yfnQvgY+cR5nw7hbyLTQ5smM6wpmrsTfZsTVECuEt/0WFR0TMgeokgZrtgnPo/vAXNx
	lue6MwhxUaFOukcabztrVicr4SDMV7esZh/x+ANPSTkxL5tcGF3Uii+lzj8lJLcM9dTUbqJKwuY
	wApfETkskdvAamDHod1Gw2OrGEarkSEw3m9ZH7SdS637fK3Zfdk6PA==
X-Google-Smtp-Source: AGHT+IEpHeVVK1biZlZ3C7OZk5fr5A14EbDd2p5b6aF0nLfJQqPiQjGXNXvBBo/ejPP5d8CqlDkrvA==
X-Received: by 2002:a17:90b:51d1:b0:2ee:3fa7:ef4d with SMTP id 98e67ed59e1d1-2f83ac8c4acmr40510988a91.24.1738693833489;
        Tue, 04 Feb 2025 10:30:33 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:30:33 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v8 00/12] net-timestamp: bpf extension to equip applications transparently
Date: Wed,  5 Feb 2025 02:30:12 +0800
Message-Id: <20250204183024.87508-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Timestamping is key to debugging network stack latency. With
SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
network issues can be attributed to the kernel." This is extracted
from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
addressed by Willem de Bruijn at netdevconf 0x17).

There are a few areas that need optimization with the consideration of
easier use and less performance impact, which I highlighted and mainly
discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
uAPI compatibility, extra system call overhead, and the need for
application modification. I initially managed to solve these issues
by writing a kernel module that hooks various key functions. However,
this approach is not suitable for the next kernel release. Therefore,
a BPF extension was proposed. During recent period, Martin KaFai Lau
provides invaluable suggestions about BPF along the way. Many thanks
here!

In this series, only support foundamental codes and tx for TCP.
This approach mostly relies on existing SO_TIMESTAMPING feature, users
only needs to pass certain flags through bpf_setsocktopt() to a separate
tsflags. Please see the last selftest patch in this series.

---
v8
Link: https://lore.kernel.org/all/20250128084620.57547-1-kerneljasonxing@gmail.com/
1. adjust some commit messages and titles
2. add sk cookie in selftests
3. handle the NULL pointer in hwstamp

v7
Link: https://lore.kernel.org/all/20250121012901.87763-1-kerneljasonxing@gmail.com/
1. target bpf-next tree
2. simplely and directly stop timestamping callbacks calling a few BPF
CALLS due to safety concern.
3. add more new testcases and adjust the existing testcases
4. revise some comments of new timestamping callbacks
5. remove a few BPF CGROUP locks

RFC v6
In the meantime, any suggestions and reviews are welcome!
Link: https://lore.kernel.org/all/20250112113748.73504-1-kerneljasonxing@gmail.com/
1. handle those safety problem by using the correct method.
2. support bpf_getsockopt.
3. adjust the position of BPF_SOCK_OPS_TS_TCP_SND_CB
4. fix mishandling the hardware timestamp error
5. add more corresponding tests

v5
Link: https://lore.kernel.org/all/20241207173803.90744-1-kerneljasonxing@gmail.com/
1. handle the safety issus when someone tries to call unrelated bpf
helpers.
2. avoid adding direct function call in the hot path like
__dev_queue_xmit()
3. remove reporting the hardware timestamp and tskey since they can be
fetched through the existing helper with the help of
bpf_skops_init_skb(), please see the selftest.
4. add new sendmsg callback in tcp_sendmsg, and introduce tskey_bpf used
by bpf program to correlate tcp_sendmsg with other hook points in patch [13/15].

v4
Link: https://lore.kernel.org/all/20241028110535.82999-1-kerneljasonxing@gmail.com/
1. introduce sk->sk_bpf_cb_flags to let user use bpf_setsockopt() (Martin)
2. introduce SKBTX_BPF to enable the bpf SO_TIMESTAMPING feature (Martin)
3. introduce bpf map in tests (Martin)
4. I choose to make this series as simple as possible, so I only support
most cases in the tx path for TCP protocol.

v3
Link: https://lore.kernel.org/all/20241012040651.95616-1-kerneljasonxing@gmail.com/
1. support UDP proto by introducing a new generation point.
2. for OPT_ID, introducing sk_tskey_bpf_offset to compute the delta
between the current socket key and bpf socket key. It is desiged for
UDP, which also applies to TCP.
3. support bpf_getsockopt()
4. use cgroup static key instead.
5. add one simple bpf selftest to show how it can be used.
6. remove the rx support from v2 because the number of patches could
exceed the limit of one series.

V2
Link: https://lore.kernel.org/all/20241008095109.99918-1-kerneljasonxing@gmail.com/
1. Introduce tsflag requestors so that we are able to extend more in the
future. Besides, it enables TX flags for bpf extension feature separately
without breaking users. It is suggested by Vadim Fedorenko.
2. introduce a static key to control the whole feature. (Willem)
3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feature in
some TX/RX cases, not all the cases.


Jason Xing (12):
  bpf: add support for bpf_setsockopt()
  bpf: prepare for timestamping callbacks use
  bpf: stop unsafely accessing TCP fields in bpf callbacks
  bpf: stop calling some sock_op BPF CALLs in new timestamping callbacks
  net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
  bpf: support SCM_TSTAMP_SCHED of SO_TIMESTAMPING
  bpf: support sw SCM_TSTAMP_SND of SO_TIMESTAMPING
  bpf: support hw SCM_TSTAMP_SND of SO_TIMESTAMPING
  bpf: support SCM_TSTAMP_ACK of SO_TIMESTAMPING
  bpf: make TCP tx timestamp bpf extension work
  bpf: add a new callback in tcp_tx_timestamp()
  selftests/bpf: add simple bpf tests in the tx path for timestamping
    feature

 include/linux/filter.h                        |   5 +
 include/linux/skbuff.h                        |  25 +-
 include/net/sock.h                            |  10 +
 include/net/tcp.h                             |   4 +-
 include/uapi/linux/bpf.h                      |  35 ++
 net/core/dev.c                                |   5 +-
 net/core/filter.c                             |  48 ++-
 net/core/skbuff.c                             |  62 +++-
 net/core/sock.c                               |  15 +
 net/dsa/user.c                                |   2 +-
 net/ipv4/tcp.c                                |  11 +
 net/ipv4/tcp_input.c                          |   8 +-
 net/ipv4/tcp_output.c                         |   7 +
 net/socket.c                                  |   2 +-
 tools/include/uapi/linux/bpf.h                |  28 ++
 .../bpf/prog_tests/so_timestamping.c          |  79 +++++
 .../selftests/bpf/progs/so_timestamping.c     | 306 ++++++++++++++++++
 17 files changed, 630 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

-- 
2.43.5


