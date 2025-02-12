Return-Path: <bpf+bounces-51207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477F1A31E87
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3EC1887082
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E71FBCAF;
	Wed, 12 Feb 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYQFowLc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA02D600;
	Wed, 12 Feb 2025 06:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341146; cv=none; b=fep/QmFifYs2uqc+qaFM6mLWNshiWK9lMMHUAbnYFqwERxA6/gybHvc63y6QoOnNruj0/Uw/ShlU7VCDYEdMa67zuSRz6WlYAeoMde6jy629rFaj594czabJ3Jv2jWN7CKgMnqATHWiz2SA3bcG3ufiP7mFvyP8yphIyxDgJm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341146; c=relaxed/simple;
	bh=q2sAhpApAt4ZYGM64hUa3vrSbFZwyMDtvEeXGLo48fM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cLLiQS406Cdwg6907Dv90QggZmopjmxfNh9cc2d7wocRsHQk81j1bmgtKdw4RIdRJnxhKDsDkHR5V0QtXonZnjFlXT14YFo/IuOBoQt7/ZSo9KwXgCUk+VOe4vY9gpg934QelY/H52c4ohWijTDpbIniXSFEE0ikIJ1rdizH30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYQFowLc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f4af4f9ddso75815925ad.1;
        Tue, 11 Feb 2025 22:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341144; x=1739945944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZIwOt1ZoKNxV0MDBFJTXPKFJJ8/qPKFfO/fgoqzXqU=;
        b=ZYQFowLcAbmxcrrs862vEM6b5zVsvaZ3uCw+isV/xn4I3coSefba5eKNsqaMMaulAt
         jTndzVj9Zxp7jd1f8tmM+m1pa0mU1PZgVFCO0gbMGRMnumqMSFH8YS58W1IwFCmshAIp
         BPaYQsT4k/kkxFhsHBu+RCnvP8Q1ETVx29oCxaAxhk4sGI0YwM2pg23NZB6zqKKQ+HLo
         1rne9Ky4cuUXI8vWQdvZ3unJReMJv9e3zWz2of6mNBlhCVGrXdb6mYdLvbgMqcfQwSmX
         nhEdO7eLA1vkcTnG1IHn1+sR1SBz1ITOJfWXWP49GxvkDLVKnALOsNj0uz65QK8IjE2o
         FCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341144; x=1739945944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZIwOt1ZoKNxV0MDBFJTXPKFJJ8/qPKFfO/fgoqzXqU=;
        b=w3N65il5kdQZBEAc9yPTSXvD5tEHEmh+vtPay708IWMTYRySwp+WLwNAkkjcZGfQDa
         gHGmdZ234xcen9huFjtY8BG70fmiMPBnUfBapuAIA11Jw1Nz90+oJwCjn/WNnsU+3gzj
         n+lCraYDRKqEzY2Zb787HiiAlrH6aJDRGAP2aYQWXKFinGKfa7pSii7WEX44ERe2A7Oz
         A6+nTyFXTqWq9t9Aj85F0Y0sfmEemoMSjNiDKmX8P+3LmjMTgOvi+yJIN+TA7l2nm50e
         VG6kegdZAMHXO1TYFNE11hxxFMzn1Eo6rxHHiT8/cp89BypjTINWAoxQAZQjxSSKehBz
         M4GA==
X-Forwarded-Encrypted: i=1; AJvYcCXnbDMFpmr5M8v8bu/R2F5S4C4Z3BZjX/JRstvZ5y+eX1DCrXcKI9dZOMbUPvuG7/wDoYr81Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHsswyftA2x2vRQ+UZ2PHOLETgSkLCP8rIug4g20gmUP/o8yx+
	T/+2eItIK329iWRgHCj3eSrZjo1MNrgCggvc1+j3+wTlzvRG14gx
X-Gm-Gg: ASbGnctZpyZtRC9ajirMSU/qQsFvsa4Z2+VRvz4qKF8Kl9nqLyWeTiS88s/nKupJcN5
	n9hggjjnkZyNC0Mlr8V4k8BB/XV0JO4QjMJ2L1VVFhFNulpIRYASkof4uzqK1/CQ//7I7QGN+38
	u9nPqvP6/1csai33y9m132DtmByPwAqtqdHckaC5jT5DoQ2awWXKGBO4tbnNbFVK42oZiTL5R3E
	DJ87sdShDTH5b8i0hAKxfzGN3MkTUAV7XCL4YPdrnnld3XJG8ytbiAjkhePvJ/BqtcH2b3MRA9j
	DTyeFoLnUUA1Y4xDdIolU7JyC//RPpdFOYONBPQg/S2Xe5g/FuhlLFp1zU2hQxc=
X-Google-Smtp-Source: AGHT+IHpcD8hKpsTRbToGOBz8IYJ11PreYbV6UCC+7ce7KDYktVQi3asz63Xzp0UZ7GhpWDKxqrbNA==
X-Received: by 2002:a17:902:ebc5:b0:21f:7867:91ac with SMTP id d9443c01a7336-220bbb4f1dbmr33247245ad.26.1739341144097;
        Tue, 11 Feb 2025 22:19:04 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:19:03 -0800 (PST)
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
Subject: [PATCH bpf-next v10 00/12] net-timestamp: bpf extension to equip applications transparently
Date: Wed, 12 Feb 2025 14:18:43 +0800
Message-Id: <20250212061855.71154-1-kerneljasonxing@gmail.com>
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
 net/core/filter.c                             |  80 +++++-
 net/core/skbuff.c                             |  50 ++++
 net/core/sock.c                               |  14 +
 net/dsa/user.c                                |   2 +-
 net/ipv4/tcp.c                                |   6 +-
 net/ipv4/tcp_input.c                          |   2 +
 net/ipv4/tcp_output.c                         |   2 +
 net/socket.c                                  |   2 +-
 tools/include/uapi/linux/bpf.h                |  23 ++
 .../bpf/prog_tests/net_timestamping.c         | 231 +++++++++++++++++
 .../selftests/bpf/progs/net_timestamping.c    | 244 ++++++++++++++++++
 18 files changed, 706 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/net_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/net_timestamping.c

-- 
2.43.5


