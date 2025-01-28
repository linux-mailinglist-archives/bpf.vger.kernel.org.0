Return-Path: <bpf+bounces-49931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0932A2066C
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5EE168E3C
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BDC1DED4E;
	Tue, 28 Jan 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbCG6O4B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772A1E521;
	Tue, 28 Jan 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053999; cv=none; b=To1w7UE9qOgC6Ew7K6iMSdRw0+422fDOEl639tynt5eqvbXCXmNX3Zw6X9RorhjNrk1ekBe0YLuaOmEWkocs7QHYg2J+hG8gwUbxa9QWtrMGqH4F8n435oewbZUo9ehQOTO3AHf7d7OfYmGVWb8wrkabioZ7MuE6NQ/IxX3/jEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053999; c=relaxed/simple;
	bh=aHW5cZG3nB4a82hjmpdiJ24hN/iOKEoJ9/7yJk6oAj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RDrSN9oKe/im0W0y/eUXrCFp8BrPvPTmTk8qvowTFZrkRDtJHX37kyVvUgpBtRngoCtHp78l7SIGNyiCo5B0ABKPxIdZBQDyHwiaZpvcXXaxk/IGJ8Df8Lj6OvgnekNWATe2eSOL804o/YXpB3V8X/h6RlVaS6cyvXsyxRKAXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbCG6O4B; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b662090so103799995ad.1;
        Tue, 28 Jan 2025 00:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738053996; x=1738658796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9Sp+PcWJIu0XHPlF/6kU7osHPphCkNRJOyL2h8vsqk=;
        b=GbCG6O4BbQlQ3nkzUolugH4nQjKtaTUc88NmQid3pofGmqoegpeZhvt4eNpqDAffEw
         llfbfASptCd3kWcY+2QB1S+QTrMFV+JZsncx2UQuT3DqkuAENOrAf3a1jzj0S3OXqrnh
         1pyXWJiZqZ85ZntG5VfKfAk0S+199yJiMxZ3FUmEZp+KaaTTdEs0QuUyHGJFNXtEyBxu
         YLa/peqOXT2ZBDi6KnvnJmnBvcxzbYZ0N8EsPvDkM/LEn+3lIVOqLDhKimWG4nnakZG8
         QNcDtkUPVHXx2MO8MZNrrJi0bPjD4ntNbjaoSdj7izOp61mckHV4UVXPPjhjb8zJ5VVp
         62dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738053996; x=1738658796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9Sp+PcWJIu0XHPlF/6kU7osHPphCkNRJOyL2h8vsqk=;
        b=FypPTBFjGOb5Ga09gO/kmkElZv1s1+77ymtLK97PDbK7zSq+Ez5yjIuZ9Ia80jTbwv
         FRLNN4Qekrp0xFAshM4kxdellznY6YB/xDC5YtU2c+jHrNh/E4Ne6FElTgeibr2zZypQ
         t+sUS4anZtMK5CGvoV2n93sRCKBgY9arc6Lro1jRN3gDNh2JKQCsoBSYEovIE/uL8913
         maDjAAP4sqWu4hyEvDm15ffiWZQjKCg2F0cyLJEdGxEoYAqQGU8DRur36Api/FuTTyWo
         Wco5nh8iBb3ZB9VSxjeYh/lGHT+Won4y0XEcP4CpOKGOURLAbM0Ye/LG7LIXNrJ7TLOJ
         ZI1g==
X-Forwarded-Encrypted: i=1; AJvYcCXuY3uVHuT+yKnvXNqgL6fgc8uf9LyqwAHCf7b6N+ouKEDZoRWT9oEN7ai9ZPwmfg1jBTLxppU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/ul+u1kNwCTmiqwnq8l2XC3WmS4maIGmmwo9qATX8gX1ULJ4
	rhdiPn2kH0kHfu6EM9fsZJ2s+GCEc8TEZc1pGAMN3yk2OLnAsQL1
X-Gm-Gg: ASbGncvB6+eOldPtAzX1wR/43ei9X+WaIORHP5TZDW1eYDDnk9sqjYkqggP6z2ECXnc
	NjTgGTubhPjrsXCdqmPlS62cPyYKWMwvjf4hew8HPJuNSFdDDxb5n69YZ8xARYh1hQWjHGMzCMm
	H/iF3VGepfdmcaQPp8xxwaFIXVgC1nqZpksKHLAIXQpJ4POyP/67lwAIsaqtS1fRlE4XdWBBftG
	CF1neSM8yfWORNDBqjF6LabrUSXa44g8/eAuVg1Bno4Uf4zN+wIzKHxBjdYySR1M88lE1eLbwWr
	ESda7/oV2vXueZphJk2KNL3atl190yEANjOzZ/OTstcwhPfCVZcucQ==
X-Google-Smtp-Source: AGHT+IGgGvgDwwhjDiLTTIZ4hDfc/yZf20veY9tLbZLpQHxE82T9OX4WX04dDTOntOHNx7ogIgpM0w==
X-Received: by 2002:a17:902:d2d2:b0:215:6cb2:7877 with SMTP id d9443c01a7336-21c352c7b8emr720494315ad.4.1738053996531;
        Tue, 28 Jan 2025 00:46:36 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:46:36 -0800 (PST)
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
Subject: [PATCH bpf-next v7 00/13] net-timestamp: bpf extension to equip applications transparently
Date: Tue, 28 Jan 2025 16:46:07 +0800
Message-Id: <20250128084620.57547-1-kerneljasonxing@gmail.com>
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

In this series, I only support foundamental codes and tx for TCP.
This approach mostly relies on existing SO_TIMESTAMPING feature, users
only needs to pass certain flags through bpf_setsocktopt() to a separate
tsflags. Please see the last selftest patch in this series.

After this series, we could step by step implement more advanced
functions/flags already in SO_TIMESTAMPING feature for bpf extension.

---
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

Jason Xing (13):
  net-timestamp: add support for bpf_setsockopt()
  net-timestamp: prepare for timestamping callbacks use
  bpf: stop unsafely accessing TCP fields in bpf callbacks
  bpf: stop calling some sock_op BPF CALLs in new timestamping callbacks
  net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
  net-timestamp: support SCM_TSTAMP_SCHED for bpf extension
  net-timestamp: support sw SCM_TSTAMP_SND for bpf extension
  net-timestamp: support hw SCM_TSTAMP_SND for bpf extension
  net-timestamp: support SCM_TSTAMP_ACK for bpf extension
  net-timestamp: make TCP tx timestamp bpf extension work
  net-timestamp: add a new callback in tcp_tx_timestamp()
  net-timestamp: introduce cgroup lock to avoid affecting non-bpf cases
  bpf: add simple bpf tests in the tx path for so_timestamping feature

 include/linux/filter.h                        |   5 +
 include/linux/skbuff.h                        |  25 +-
 include/net/sock.h                            |  10 +
 include/net/tcp.h                             |   4 +-
 include/uapi/linux/bpf.h                      |  35 ++
 net/core/dev.c                                |   5 +-
 net/core/filter.c                             |  48 ++-
 net/core/skbuff.c                             |  65 +++-
 net/core/sock.c                               |  15 +
 net/dsa/user.c                                |   2 +-
 net/ipv4/tcp.c                                |  11 +
 net/ipv4/tcp_input.c                          |   8 +-
 net/ipv4/tcp_output.c                         |   7 +
 net/socket.c                                  |   2 +-
 tools/include/uapi/linux/bpf.h                |  28 ++
 .../bpf/prog_tests/so_timestamping.c          |  86 +++++
 .../selftests/bpf/progs/so_timestamping.c     | 299 ++++++++++++++++++
 17 files changed, 633 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

-- 
2.43.5


