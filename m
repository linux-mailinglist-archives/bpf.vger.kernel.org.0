Return-Path: <bpf+bounces-52047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A797A3D23D
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4C616BE2E
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A831E571F;
	Thu, 20 Feb 2025 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoLVBVgM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4691E0B8A;
	Thu, 20 Feb 2025 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036592; cv=none; b=IuEWGuUB70+mQFXS/4mxxA8auoh7iL8K09jxm/xdT21syZdgETSauXe6lXhmO3AE0doyJmoz3a2XRjtmmB30hybaxnjLQ3C5qvO5kEndG0tGHAQM5BjSOWSw4qPo6lA+q04yD0KInvjb81LR4K7B8vOJLcGD0aCNQJgXEELkP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036592; c=relaxed/simple;
	bh=1BWgP+vbytyqQvFZNt3FAcr05XHuj1XK0+jm2ac17JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IT/dFvzCjuS9gXqkcwyYmHivatLpk452zxe0oETD0meY4kI6Kn5Tw5KrGHOcCNBzo87R0Bu/Y5Kubx0rcjVthqJzQWjIO7RLMDprThtqA6feLjeJvDaVXX0Q7+2ycZoAqzqIhvPPQcFn5gwZpeqIhvc9WVYVsT5UnZeEM+y93zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoLVBVgM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220ec47991aso7023555ad.1;
        Wed, 19 Feb 2025 23:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036589; x=1740641389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnB/rCKOHuFLah/bZQu35dS4R0D2HKlnMf+zA4j9m00=;
        b=VoLVBVgM6IE4mL7XMGZrg7AS8NoKqA8Sb6yffcNoMGuYvDEK/egrAvte58UaOOLX3U
         En2z2rsmQlFEKArdedd6ZoB0alhaEHyNmycYVT47pN31l3WjCSDj4neIY1DK9BWjbYQE
         DrnKpCpTDMBTn2CaRAvDCKxwW5tfhghXBOm0rPyEVvJTVBIhK+pIyPUctrFlqKdBKquV
         RoNaTj4RIvY52z2JO/dwVTvSgzcePgNLlg16zky5YTXcZFwQ8ZQZdf5CDR2HsYWNpAGQ
         CAgsSJgGffHETIifBog+vvOrNKE1mYkmPuYLUrrgrK/bHET0vxTdxZ4moBk+fAVGAssr
         5oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036589; x=1740641389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnB/rCKOHuFLah/bZQu35dS4R0D2HKlnMf+zA4j9m00=;
        b=NTymwIdXej0z0fHqUmA2fL9yjRqKlGFh20Dd6scwKPufopXaaAEIV0DSjWk6lEsowC
         ZOyHKD/ZWX/xdx0+EzVShyibCOQwwm5nkDHWXtnSz+v+gtNtNNqBQ5DBAvnLiG+/HF4z
         96bKx0/QwuKMDMea7s515HuQh6XgNQF39BtjJU1dS1VNA7JFE0JIAtayB6+rBexDr2xM
         WRybOAxB0dFSdrXwKFjFZEYppFjQvYpEc1+jOC/n64Hf7yi4b+6Gz+SB1bSNKLjNnCck
         +j1QTW8uAAzP1xEfG+y8E1FDUF3AzDrQcjLTOTXY+W3498OFzo39WvPq/H42oYgzHFyE
         CTBw==
X-Forwarded-Encrypted: i=1; AJvYcCWfWT7xpS9sMBlmXVJ2xP0Qaas7XS4+J6E5lRRuaSmlFdCxQGrjimNEujsWoO5YmxS0lxY89x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmB4SSG1FrqM9HzNPfF+oWzVBa5KHgFORo66JnlDpEsA2WVXzK
	kPN956bD6v4VtRyBELa81b/TuBRQQn+duKGYO80/cWHtV7aGf1Wf
X-Gm-Gg: ASbGnctpv94uG9VS7YHaqhqL47NxungZ3VkV0krOMrbT7E+BPwBICBQ8mOxe4+yAKFl
	bWpVCO6PpryVFMm8sVjIw5WNEV/Y44sMdNoZb5CUs2iDW1jo51repaHflvlx1JDy+XeG79raVDD
	Lt/BX6cBjiWb4yy2hGcSx9pHlZ6yWWdxSvplOLF7lhEpe1cc6Ko9B31Y+NvumPhr9GGTLpMrvYl
	13699nli/+ck+lI/f/qk6uenKOMepzcygQjBDzY988TFUa9G1MpmmI4m9VZQlRlldm1h6hGc4tM
	9mVgXxjoIanLEKMkRgmyUO8k/4emimvNed+OCA3S/+JVVO8BsyFJI20Qql8lvKk=
X-Google-Smtp-Source: AGHT+IFSvZt35gykkOECUiZy4aKKZ28WJjfYHodu6s6la/jVhOknHaA8AVry96+1+IRhWDwfrOABCw==
X-Received: by 2002:a17:902:d512:b0:220:c4f0:4ee7 with SMTP id d9443c01a7336-2217065a161mr116980265ad.1.1740036589445;
        Wed, 19 Feb 2025 23:29:49 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d643sm114048205ad.126.2025.02.19.23.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:29:49 -0800 (PST)
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
Subject: [PATCH bpf-next v13 00/12] net-timestamp: bpf extension to equip applications transparently
Date: Thu, 20 Feb 2025 15:29:28 +0800
Message-Id: <20250220072940.99994-1-kerneljasonxing@gmail.com>
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
v12
Link: https://lore.kernel.org/all/20250218050125.73676-1-kerneljasonxing@gmail.com/
1. use u8 for sk_bpf_cb_flags and adjust its position to fill a hole
exactly. It will not introduce any hole.
2. rename the CB flags
3. update SK_BPF_CB_TX_TIMESTAMPING enum in tools/include/uapi/linux/bpf.h

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
  bpf: add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback
  bpf: add BPF_SOCK_OPS_TSTAMP_SND_SW_CB callback
  bpf: add BPF_SOCK_OPS_TSTAMP_SND_HW_CB callback
  bpf: add BPF_SOCK_OPS_TSTAMP_ACK_CB callback
  bpf: add BPF_SOCK_OPS_TSTAMP_SENDMSG_CB callback
  bpf: support selective sampling for bpf timestamping
  selftests/bpf: add simple bpf tests in the tx path for timestamping
    feature

 include/linux/filter.h                        |   1 +
 include/linux/skbuff.h                        |  12 +-
 include/net/sock.h                            |  10 +
 include/net/tcp.h                             |   7 +-
 include/uapi/linux/bpf.h                      |  31 +++
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
 tools/include/uapi/linux/bpf.h                |  31 +++
 .../bpf/prog_tests/net_timestamping.c         | 239 +++++++++++++++++
 .../selftests/bpf/progs/net_timestamping.c    | 248 ++++++++++++++++++
 18 files changed, 729 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/net_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/net_timestamping.c

-- 
2.43.5


