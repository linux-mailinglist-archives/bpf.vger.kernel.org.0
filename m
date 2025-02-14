Return-Path: <bpf+bounces-51492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CB6A35355
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AA516DF3E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27C917583;
	Fri, 14 Feb 2025 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxtrNQj7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81DF2753EB;
	Fri, 14 Feb 2025 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494850; cv=none; b=oY8zcI6hTicNyzTScjXovAkJmrTP3zz7ijBnRnNudB2lC37yLkED/qAZKWJZVBR226ktA48GWkPyZMLxB2BBXdNAdmJQ1KvmEGn5vEcYzdibv1fA8PPvPub34In7QClneInJVeKGTDZjJgOLTMI374mchIAXPni7s1rAfNzwk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494850; c=relaxed/simple;
	bh=n0EtK+xYeRelzV925EbaxthfAar4iubZjLdX9Hs0BhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YP2uzI8zf22kNxFAg0Xe3h45wGHArySeyQEzmwoSL7Pf5ALcaeq6hx07lLrGfVd3tYrsGAUZJ3YgqN/8Pw4Lzj1Xfz3kxej7uX+PVx+QY9OaMsD5o1pyJDm2s8krzg1sfk9EG9HjNFBVyR9AAJZVk+AHK+WTGosoRnGxmgNnU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxtrNQj7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f818a980cso23292155ad.3;
        Thu, 13 Feb 2025 17:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494848; x=1740099648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Cnj8arz+IuFd1isxZxDqgMZyR+BIMXopz33+4E2hnY=;
        b=lxtrNQj7A8yzel4ueEZB4rL/eLC7nX9vxEvnjbUxbDGEzi/xZ7ggg9Y48jyn84mrfd
         Aa3Gbd0MC1CwmPjRY434Y4fypZVKBFjofzbCjFsKQRqaAz3jGF03FAbGKmyz09jv0IT6
         KK8X6GvZtQwqq5xpANo/reX549vsi70tW1OEnf1qxn8f6kzD3Ybm46CFv3J6fAov6AN3
         H8MDRdlcE7WLxOPKlbjBOGN8d3LUFuZNRnfgodj/0Rkn7s+ISNzeK/numGS/xOYzQJ9e
         xH2WkLVpxxcsD8347rWWwv0WDatxbaLu3+I6XtFdbHnfPeArV3uK0z0mmfZT576390Is
         cV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494848; x=1740099648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Cnj8arz+IuFd1isxZxDqgMZyR+BIMXopz33+4E2hnY=;
        b=RLJBJa3DRx+PEPgSxM5gmh9v9HUUPBM9SaOkWlBcuyUNZRDy9zxm5yfm5ciTtfdryK
         16cMV0RP62/Zf9MB3Y6y0+kE6wSJnSQ6j8fkOEwz89UOlkSAo9Snekqu8WcXo5Vsy0qu
         ezQnd9MO408QFcAdNNea3OY4Sfw1kBKUmQ6DHDI1a15dvqCXtMEvb+Rq/HT1o8JlCddO
         7U4QpdLb23/pqpV5MUsMM54gENG5+VoCmFN97CaEIKXym9ZJW69YH0PM4G9rkdJIEvuX
         cygyw4tsS1turhZ1gVabNDPMwBZjJGgliu/skAahhlcGtFzmZR0k5jwm/9bovXWSa2up
         U3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCW4xA7heUbq1x3GLETqTrP0bPQQ+j08cRyPJkhUwSNlQyKKfE8JrqA/ShRAuWlVq7zavQm/T3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywscl129D+fUEBS48e4gLDkxvJLBrDc/apSBgZ2UB3kNJkgeU/L
	geuIL8STLe05781OVdzisymTBAJh2iUmdhffJDiqYOj6J04IA8TB
X-Gm-Gg: ASbGncuHJP94tGoWEDXvt2ipPvJLhbFLiojrFIMVQduwTbwI2Ge9G62Me6ao6mUhUWU
	KgBnNa5e8xzBIRQO013ko/dPj0kOlQdOTQ/DPxurT+WM4E8JVy4t6T1paFHzuEjILcrW6ak7HWS
	CJPMhmkzHDs5EhQmZ+mi/yxFkKmUZI8m8GwypXP5ZBk+0HU3TrZKAEQ5tlMNr62mRIFbk09nizm
	9TmvqnZqoYTeIqF6vTxJD0TWqp+VeTnL2E3O0DdVyPaYNk1HusxI86abltWTcq21zjd7GkHNOGI
	kgLSEsXTDKNg0endS7Sk4MUtPOwST1m0nUbKy2sw02R8zxjz/0sq2w==
X-Google-Smtp-Source: AGHT+IHlR+F1sO8IBAe3Ng+r5Sdce+axHL1BEXzejjV1MqPX4//gqXEl6Ty9tOYpuxUtRnrOeoGAdg==
X-Received: by 2002:a17:902:e750:b0:220:e392:c73 with SMTP id d9443c01a7336-220e3920eebmr56229225ad.22.1739494847685;
        Thu, 13 Feb 2025 17:00:47 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:00:47 -0800 (PST)
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
Subject: [PATCH bpf-next v11 00/12] net-timestamp: bpf extension to equip applications transparently
Date: Fri, 14 Feb 2025 09:00:26 +0800
Message-Id: <20250214010038.54131-1-kerneljasonxing@gmail.com>
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
 net/core/filter.c                             |  81 +++++-
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
 18 files changed, 722 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/net_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/net_timestamping.c

-- 
2.43.5


