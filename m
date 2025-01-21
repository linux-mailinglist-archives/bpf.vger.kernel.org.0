Return-Path: <bpf+bounces-49314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B3EA175A9
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1380C1886E7E
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E6136349;
	Tue, 21 Jan 2025 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtS0Kj+N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2BE571;
	Tue, 21 Jan 2025 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422953; cv=none; b=lxMf1LuFOFiSLDyhTZzcYYTaCQYHwE+ncsSR1zRpiwjyoW2OpABgzVXY2FTqNFH19fWdfEzwpwLXlKT1x7D21tMtCKCD+E7+9KDX7IWqGmYm5nt+XIPah2PqLhD0FE2+4RHb2QjcQVsEz5XgP7l6coTxGWq5lX0dw+OFpyqkGbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422953; c=relaxed/simple;
	bh=tK6vOY0mtHP7vhi8/Ikow2TdaPu+4iHogVjUOopcyrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T92p+mLf+w08l5g8bIbZZ5U4h/uCzqqtRt74AKPB74bgqMtyHtdxM5QN2GHMlzaq+3y5t7rYjgZ/9icjy3MlTEW4dSw9gNoRh+GPTndkRA8yfAEGA1cOwzt7sixnykt9y5oli23eyrMhGgQVKUvi1tzBNcWRt71P4YnCyBdplfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtS0Kj+N; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216426b0865so85682745ad.0;
        Mon, 20 Jan 2025 17:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422951; x=1738027751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5lVLBYVctUlZLPHl6TRPFgmjP4LxSvk6S+iEs5KZzIo=;
        b=KtS0Kj+NVjC2djv6myCICkNkIt2fOpkngVWcUmIyVp75H+iM/Gq3YdSB7W3o1tZuVj
         da5S6VNziVlV7Ktv+7u9GjjtSpx3DXBHTxsqbaLLoWi5dATJowJ34c8cnw7CU+gUbYPL
         U6Nr6wrtC9kwMkZSt6/OS6KNgdiYpjPvg843O6kDkdILPdcmUNzsLS3orBQvfNm3SQbC
         bj2z+A19LValMxkZHmCwLgsiJpyoGsGBUEDHkCDJ0H5je3mOlZ7GMrnQvNdxe5j8izRg
         TsrMPfgwjeb0ssxz/9LAeZif3cE5rbNFVyXhUFxyltkPV0BSjbZglFSxVnKS2uhHyaUo
         wqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422951; x=1738027751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lVLBYVctUlZLPHl6TRPFgmjP4LxSvk6S+iEs5KZzIo=;
        b=qfrDbBQmvTdwhfPI1D8lCOVNqBQ7r9Y19a8eqbbsEfW9nNhhhdXq2m5R8fQbfmz6c3
         3RLxNdkTiBmAE1w0eVXpu0SmI0ShfbGEv1Mk6ZtBA1cG3CpSgbrWWuW40yAMi3U2pAgv
         FtTMQeKL8uLGzuwlj/FZqCjFfv5VPN4VuiYSAh4Yc/dJ8wrv/izspKp460IUqMuwIr2C
         EIly0H8AQSWCdlzZ62ditGGyDhWW2+ktEBIQqL28gleuwodzQ1HRaK2rakxkHknR2VLo
         0hS25W/f86pXndqk7iWFRqvRZKaYaVtVAp+/oUksUnTtFD9FOfRgjtNvdH+ZW3xOaIAQ
         AjPg==
X-Forwarded-Encrypted: i=1; AJvYcCUlKpQ2nRdgLWLWLfeYbbPGbLeqzPZNW+kn6RDmTE445TZn+jtfOw4RDh6eX6yzQR9JFO2L7dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAiEvzu/9CUJyDYCbwnpX9eDaQYYV5zo30CgxtJ3l2JQrMqC9
	ghiVx1KCCLC/3DsiuHpfgSJe9pFLtk1qjPlZQo/iFB2Z6J0Ve9EI8fSz7YZU
X-Gm-Gg: ASbGncvlroOFDUynDRZVHMt/EHcPN4jxQJNX5q9O6K0K29nRxlsOun/aoHxtcgthTcg
	jMkMsZHivQcOXoItMcndH19HNvF4t+93MOK+kRyKqMANXuBX9rG0koyVo5a5S6zizrq0w+1kefT
	7c+6YxsTRO/NxivhwlfMplhtCqAkAOvjMGtMUaiN2rFlqcCOMroNWtHJVNqw0ADqq5V86//9Jxw
	lAQ5enaYggHVJmoaKRi1hXq5HTdjdi+38UMYqfyEDIFZ8xhSKYgOy2Sm+cu7vacO7EKiKLK9EnJ
	SyqKPwpQJnINg3G9oxS4SW6LIzIY0SXu
X-Google-Smtp-Source: AGHT+IEIFMy+kX90R/KxKEftE0YlO6tGUwA1CmKCBA4GYQU04V6R6tagYtfXsfzR9EBisZC4N36Apg==
X-Received: by 2002:a05:6a20:841c:b0:1e1:ae9a:6316 with SMTP id adf61e73a8af0-1eb215ec18amr28109813637.35.1737422950564;
        Mon, 20 Jan 2025 17:29:10 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:29:10 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 00/13] net-timestamp: bpf extension to equip applications transparently
Date: Tue, 21 Jan 2025 09:28:48 +0800
Message-Id: <20250121012901.87763-1-kerneljasonxing@gmail.com>
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
  bpf: stop UDP sock accessing TCP fields in bpf callbacks
  bpf: stop UDP sock accessing TCP fields in sock_op BPF CALLs
  net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
  net-timestamp: support SCM_TSTAMP_SCHED for bpf extension
  net-timestamp: support sw SCM_TSTAMP_SND for bpf extension
  net-timestamp: support hw SCM_TSTAMP_SND for bpf extension
  net-timestamp: support SCM_TSTAMP_ACK for bpf extension
  net-timestamp: make TCP tx timestamp bpf extension work
  net-timestamp: add a new callback in tcp_tx_timestamp()
  net-timestamp: introduce cgroup lock to avoid affecting non-bpf cases
  bpf: add simple bpf tests in the tx path for so_timestamping feature

 include/linux/filter.h                        |   1 +
 include/linux/skbuff.h                        |  25 +-
 include/net/sock.h                            |  10 +
 include/net/tcp.h                             |   4 +-
 include/uapi/linux/bpf.h                      |  31 +++
 net/core/dev.c                                |   5 +-
 net/core/filter.c                             |  50 +++-
 net/core/skbuff.c                             |  67 +++++-
 net/core/sock.c                               |  13 +
 net/dsa/user.c                                |   2 +-
 net/ipv4/tcp.c                                |  11 +
 net/ipv4/tcp_input.c                          |   9 +-
 net/ipv4/tcp_output.c                         |   8 +
 net/socket.c                                  |   2 +-
 tools/include/uapi/linux/bpf.h                |  24 ++
 .../bpf/prog_tests/so_timestamping.c          |  98 ++++++++
 .../selftests/bpf/progs/so_timestamping.c     | 227 ++++++++++++++++++
 17 files changed, 563 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

-- 
2.43.5


