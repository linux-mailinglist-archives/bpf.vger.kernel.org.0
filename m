Return-Path: <bpf+bounces-51798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E57A39246
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 06:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C6216E766
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 05:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2021AF0BF;
	Tue, 18 Feb 2025 05:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fczev1gi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C7187876;
	Tue, 18 Feb 2025 05:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854925; cv=none; b=YjNrDTf6tkYQQbQZdVOjglXV1Qgq/D6aYahBod/heN2b+ovXWmwSepx6hovp+iFJp+6gtgq9ezpE1LypN4xWHxLF0kH17iFMJrNW47jhE9Zs7ArsXW2XLdTD+ZddX/hHwoFjpHuBoptQPuSmnCM1KTOzd0E0sO7i1Dd3tqV1GgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854925; c=relaxed/simple;
	bh=pCnRAoHa7Rb3xrZFl0ygw3dn5hEKspONspjTSIPbsJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DlUycHyIJG6eEy7L3g3kkMxPwidya0O7+lrRTYwWj1MFUbM+yYLVUOvXeFUQCH6BDC43SrlWZ7w6QoEsa7iNdXDaVWlBgoIDGfDrzRmGDO2VaoA740gxuj4uK8FeuJdtNpRlU+TRfau6dIgzhwMTflVPj9+WFc7ls8vzc3KK06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fczev1gi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f2339dcfdso75637485ad.1;
        Mon, 17 Feb 2025 21:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739854923; x=1740459723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p467FasztVa+WMoxU99Jb8EFct6y3l8T57oFK4uMH4I=;
        b=fczev1giiPLgTAzeBl1Ps5KRuTjJgNYwPG8kJZDtpW4MIvJD9ioQqr53u9mokKV9hk
         K2+2JyM72YLIeo1/nT0rFYdYn+MsPOCeNQlDexEvpc1FRxzUMdVB8j3tKjrRGdjbn7T2
         dW2Rxu1ZOpQNfbRj1H9BnRb3dfN+/yxZFVn3BkedOOhDQP0MSL0o1vIWrtHuSJY8VSa+
         9DeMSUDcuS7FqxJzEPF1OYSHbrxopjzFuoTyoRHVboot1DgwAfl9wq5srLseAC3cSExO
         rG+ohMmyrpbXjRYshsCgMK2PF+h6vLlhKDQikoniTuZgwlqA8My6PTnFKV45zXfqTvX7
         cUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854923; x=1740459723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p467FasztVa+WMoxU99Jb8EFct6y3l8T57oFK4uMH4I=;
        b=dgJYmYC+LYqPY3ZTg7vsLvpYlH34C3HdWGuNt/XkYbJ5BePeF2/MxftCKdgz9JB9P/
         eYwIchNo2AHf+q7R0CfJ4GFNBGWz1vl/6+HJQ+psHf2w6QFyVE7OkYHmWlpat4rKt6tQ
         47QH6pLA/RzH3vQxVUqe+vFX/L0N2rH51Z4UMOVO9ZjouKlsFrOTqOdJJgHTcbvdkjCK
         nCfzeLX6pGuaO9ujAMUOpSHraqM/UPyzIEaXuI54jxRR6XnkdSIF5t/kKFGAf9rHgxft
         ide0qFx4p1aVYgjnfAgWRQlTuwkiuC4csbsEcgwHZ1krG7KGqC6IA4qfMCxL6rc353A5
         jLzg==
X-Forwarded-Encrypted: i=1; AJvYcCUqRywVtI6RVs+FN/DFq5ODz4QCdlJW4kLMKkVKK2b5xjxf2USUx9O6kCqz7kQfG0jmyMoj7QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyofBwLZ4AzLoKr4nNDEcrhCUaX93znnFlrTxt5T9mPwjd5PtTI
	zXU1ZFIylD3hZGvhdLzcGrTy2BloGPtWjuTFokOfyrXKzFIhqo5U
X-Gm-Gg: ASbGncu0r+5WTloZNdq/sldnk1EjxTAez/wvN69xxambn9XCisdy7POHsotYW6BhHl8
	jbSmLy3EMzIbqvTGDBLFTEUYHFJWZSq9o/qPLWpHNwT0pYgK1RdqjQf32nB3pQPR0b2+QTYESRy
	vncAgszXlXO5/ouU2qtgX1/WncGEUNnAEEDDdLXu7UYi3nfncLflNci9sXqbmGg+68vLuzSOjJC
	T78ekEC2S1QigX8K0gO+8aPnXSmWaX2u3ZuYEx58BKETpd/s8/1VFFVaZXnd4s1s889PMb7hX80
	Or/blGzz0T2wiW2nTE/bANAxjcaF4n2g7dq3sKtQTxj+6tQunBrPcLeO0CuI6hE=
X-Google-Smtp-Source: AGHT+IGkCzBRCULtqboNcfiKslyrrtEiiqMd+3Yw2uo3I/S7G53/Wj3qRBMHDkl1uuuwD3iQPMfFyQ==
X-Received: by 2002:a17:902:f689:b0:21f:98fc:8414 with SMTP id d9443c01a7336-220d35e2297mr328291825ad.26.1739854923224;
        Mon, 17 Feb 2025 21:02:03 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adda5be52f1sm4337938a12.34.2025.02.17.21.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:02:02 -0800 (PST)
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
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v12 00/12] net-timestamp: bpf extension to equip applications transparently
Date: Tue, 18 Feb 2025 13:01:13 +0800
Message-Id: <20250218050125.73676-1-kerneljasonxing@gmail.com>
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

This series adds the BPF networking timestamping infrastructure through
reusing most of the tx timestamping callback that is currently enabled
by the SO_TIMESTAMPING.. This series also adds TX timestamping support
for TCP. The RX timestamping and UDP support will be added in the future.

---
v11
Link: https://lore.kernel.org/all/20250214010038.54131-1-kerneljasonxing@gmail.com/
1. remove the unused variable 'sk'
2. correct grammar mistakes
3. move two places where using SKBTX_HW_TSTAMP_NOBPF from patch 9 to 8.

v10
Link: https://lore.kernel.org/all/20250212061855.71154-1-kerneljasonxing@gmail.com/
1. rename hwts with hwtimestamp
2. use subtest and pid filter in selftest
3. use 'tcb->txstamp_ack |= TSTAMP_ACK_SK'

v9
Link: https://lore.kernel.org/all/20250208103220.72294-1-kerneljasonxing@gmail.com/
1. set the hwtstamp to skb when the skb enters into the hw SND case
2. fix co-existence problem in patch 9 and add corresponding check in
patch 12.
3. refine some commit messages and titles

v8
Link: https://lore.kernel.org/all/20250128084620.57547-1-kerneljasonxing@gmail.com/
1. adjust some commit messages and titles
2. add sk cookie in selftests
3. handle the NULL pointer in hwstamp
4. use kfunc to do selective sampling

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
  bpf: add networking timestamping support to bpf_get/setsockopt()
  bpf: prepare the sock_ops ctx and call bpf prog for TX timestamping
  bpf: prevent unsafe access to the sock fields in the BPF timestamping
    callback
  bpf: disable unsafe helpers in TX timestamping callbacks
  net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
  bpf: add BPF_SOCK_OPS_TS_SCHED_OPT_CB callback
  bpf: add BPF_SOCK_OPS_TS_SW_OPT_CB callback
  bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB callback
  bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB callback
  bpf: add BPF_SOCK_OPS_TS_SND_CB callback
  bpf: support selective sampling for bpf timestamping
  selftests/bpf: add simple bpf tests in the tx path for timestamping
    feature

 include/linux/filter.h                        |   1 +
 include/linux/skbuff.h                        |  12 +-
 include/net/sock.h                            |  10 +
 include/net/tcp.h                             |   7 +-
 include/uapi/linux/bpf.h                      |  30 +++
 kernel/bpf/btf.c                              |   1 +
 net/core/dev.c                                |   3 +-
 net/core/filter.c                             |  79 +++++-
 net/core/skbuff.c                             |  53 ++++
 net/core/sock.c                               |  14 +
 net/dsa/user.c                                |   2 +-
 net/ipv4/tcp.c                                |   6 +-
 net/ipv4/tcp_input.c                          |   2 +
 net/ipv4/tcp_output.c                         |   2 +
 net/socket.c                                  |   2 +-
 tools/include/uapi/linux/bpf.h                |  23 ++
 .../bpf/prog_tests/net_timestamping.c         | 239 +++++++++++++++++
 .../selftests/bpf/progs/net_timestamping.c    | 248 ++++++++++++++++++
 18 files changed, 720 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/net_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/net_timestamping.c

-- 
2.43.5


