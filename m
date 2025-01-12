Return-Path: <bpf+bounces-48639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38834A0A891
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6149D166CBE
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448851AAE0B;
	Sun, 12 Jan 2025 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBumsGe0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7433F7;
	Sun, 12 Jan 2025 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681879; cv=none; b=ZI7HZDDKpgz1eLYl6bhQLZJfo/xPRO9s3Zle4isqKGstld6jXdqzeBvKJrXZncLX0SL4Ma5ma4CTePIlloI0qXkOiGQeEu5iqIB+bH6aW4JyfQSSGRZy7ovxe/BOs8yWrT5bJu8k/KHYFqHouvPodWTzlUE6n8L+P0isH2yKIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681879; c=relaxed/simple;
	bh=JBaKBfXr4mSXg4+JNjZWWW/Kkab/dwuGYsBnWYlG5Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uiO3BO1RCwj6oCptVJyjAVjY5pxbQ5xHCpgaSgeTzG+Bf9qpGVDfRv3mndmSjbDEn+xAeDUkShBBSPCKFmR+dFM1nzSoOwsO7M9bNnFD6pIsDVaAXz1/8umePoY4cJjZNzyFzYVJ5BuiAjY6x4frQikYWZq0CXvSsonUlnZc8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBumsGe0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso5031753a91.1;
        Sun, 12 Jan 2025 03:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681877; x=1737286677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTCM3wAYNLSHaPz+24WmrDtqoMB5oPtypEIuq9I9aaw=;
        b=lBumsGe0n/KwZozTPU4wuZYeOlKD4l41aAcrPUCufm5qvfgeTnn/jE9HffTG972xVs
         svuBZXj3HqG5zaUM9q0eS6DgI0x025/9uFgl6aCASCzqxSFNC7fsm8V38VJajqA5OaTF
         Bh5TUKWRoRaXD0h2Mt9QgiG2hNDI1mIGLdyXZ7M1jF1nhh1NbEwAl3027vUkRh4v7tj+
         Qz8JgXkJ/BOZpuRAkHIGBzBd4ZBsjsQY6b7Jt3yxNnj1nGhHyy7rr7Fc1nv9ga2LzrOs
         t1rEcHwr8MJYULCDTk6ug0mAMU2TQqPanGXLIBgzntqidJyqgW9B5UBOhbLt7SyO0MWl
         Ny0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681877; x=1737286677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTCM3wAYNLSHaPz+24WmrDtqoMB5oPtypEIuq9I9aaw=;
        b=BJr6pwFnvpY0afC+7xvZ8HiH7jBIPmE63kocE5UgO/MIiJo31fIgKYC4Rc5VntDcMj
         hSHWnsZgk7ubWSJ5J4XoA2Lm2iRL0davMFtlNRp4ah0Li6G662rz/m1Tb3Umgp4AR8E6
         3rwLoWC28FjOc669a/yvDUi6B062CRkwDN3qQNls4gy3HjvRkBzjHuSxnjJ9FbGSbHig
         2ean/Fjciwn3KS1XOApGhNeoMc7klnKj+UV4aH2mnC3gWuynd3k0ZATHSrFhPmKbWGJ4
         RdoM49MLRO4N0oLczX88YAj8JtbWFMj27BRCpFSBIhzWv83foKuIqtUgfHX2Er10QaXk
         6yrA==
X-Forwarded-Encrypted: i=1; AJvYcCXSxYRBF+mBQnntiY4T0jf2WMzWBU2FVZbbAzKGNoE7l5eRMqdMrWrmrKoM4xxD8XjV9nLhdlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZ5PH6s+WomrUFR6GHB974ySg8p88RImeVdxYSJyDclUhNHBx
	67B+sf/2BWKmO5EWs02e7E94BWWBd128VsZ+rNcJG8yVCzAxJCUFX7oop9BG
X-Gm-Gg: ASbGnctDiFvdXS7S/wqfGGdiNzzMZRXekQwkQ2b5qdHO3r+cszJY1JDyW9cQU9WUP8R
	VOGuocRFomIbqo1d7Oper+fhQ4zlZQjzffw+LkquPWHjZbTKKGZm2sY9hC4uSpd/vbYitLxGAvY
	ZimtbdxWyjVH+mzj9Zdr2go+mOM/CYlHsLz/pwpvj1MX9duPB2vrfjsZWJBVlnAjQ/CtknMhJE3
	RW5W1vCrZXilte4a0Tdf/9UAvjeE3N38Z1S5H8udM/ogCzChGFQps9gH3HGiBuN/zIV7ll7Hdz9
	SHN+IeXkJhtxDpz9LgQ=
X-Google-Smtp-Source: AGHT+IH4clRTVSX5XZmSTA59N7s0wACpho9DQAy7oJQCZ+veSmh9IRetCfqYiWxxTe+RmsnHQn4GZA==
X-Received: by 2002:a17:90b:524d:b0:2f2:a974:1e45 with SMTP id 98e67ed59e1d1-2f5583acfd5mr18227729a91.16.1736681877403;
        Sun, 12 Jan 2025 03:37:57 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:37:57 -0800 (PST)
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
Subject: [PATCH net-next v5 00/15] net-timestamp: bpf extension to equip applications transparently
Date: Sun, 12 Jan 2025 19:37:33 +0800
Message-Id: <20250112113748.73504-1-kerneljasonxing@gmail.com>
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


Jason Xing (15):
  net-timestamp: add support for bpf_setsockopt()
  net-timestamp: prepare for bpf prog use
  bpf: introduce timestamp_used to allow UDP socket fetched in bpf prog
  net-timestamp: support SK_BPF_CB_FLAGS only in bpf_sock_ops_setsockopt
  net-timestamp: add strict check in some BPF calls
  net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
  net-timestamp: support SCM_TSTAMP_SCHED for bpf extension
  net-timestamp: support sw SCM_TSTAMP_SND for bpf extension
  net-timestamp: support SCM_TSTAMP_ACK for bpf extension
  net-timestamp: support hw SCM_TSTAMP_SND for bpf extension
  net-timestamp: support export skb to the userspace
  net-timestamp: make TCP tx timestamp bpf extension work
  net-timestamp: support tcp_sendmsg for bpf extension
  net-timestamp: introduce cgroup lock to avoid affecting non-bpf cases
  bpf: add simple bpf tests in the tx path for so_timestamping feature

 include/linux/filter.h                        |   1 +
 include/linux/skbuff.h                        |  36 +++-
 include/net/sock.h                            |  14 ++
 include/net/tcp.h                             |   3 +-
 include/uapi/linux/bpf.h                      |  26 +++
 net/core/dev.c                                |   5 +-
 net/core/filter.c                             |  65 +++++-
 net/core/skbuff.c                             |  70 ++++++-
 net/core/sock.c                               |  17 ++
 net/ipv4/tcp.c                                |  21 +-
 net/ipv4/tcp_input.c                          |   9 +-
 net/ipv4/tcp_output.c                         |   8 +
 net/socket.c                                  |   2 +-
 tools/include/uapi/linux/bpf.h                |  19 ++
 .../bpf/prog_tests/so_timestamping.c          |  95 +++++++++
 .../selftests/bpf/progs/so_timestamping.c     | 186 ++++++++++++++++++
 16 files changed, 548 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

-- 
2.43.5


