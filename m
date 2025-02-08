Return-Path: <bpf+bounces-50853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64059A2D57E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046E93AB729
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA5B1B041F;
	Sat,  8 Feb 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFUUYrpr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CF23C8AC;
	Sat,  8 Feb 2025 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010752; cv=none; b=q7t7uwoElizjehdp4YxNGQYTtAaQn+o/+3bqKLBAwf7FQoKYJexIpcN10YT8TF19pevjo7JK2m7pu+IoO8jdFu9YAXYrx2yIIb985P1xMV+H/r8I6RhYQaRQREqOjxlyZ2mQM+DAdjf0euBfRUUcESuypVgnGqVjb9GDWAcrRh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010752; c=relaxed/simple;
	bh=SgZKdaITQJ9tdo7iveigydlP41JtvvK8PgyVkCcWdSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=unN3eTD5RWgvIbEadn4UDq2B4sHvdy15hOB7TQ/lgv5RQmLqOxDK4n3UO/hnAju4w+WrjxWhg6sPv4rjJAIU8TI7sjRjaChugtP228wHUT88TGdgATrW+ktlBqGHGhBd0gQFal2eTqHoVOP454X3ws4S75KJbDUWFdFatS7pkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFUUYrpr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21670dce0a7so68648695ad.1;
        Sat, 08 Feb 2025 02:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010750; x=1739615550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I8hwGzi3Hp3FiM6WSaA00E6kTxU3J0ZfSTpTwIlQTOI=;
        b=DFUUYrprH4WfGe99xEf8BLyisUJG/re4z5ovUPyLMHBxNihb86vQ3vB0gh7p6eobAS
         dgX7KJQfeMFRAQWD4+cmSDj725lAzunfrUvqhHB8icaoGBimP667gwaCN8woHDeX8wlK
         x4fXZsIPEmwI8C0kaVHwzdWrWRH8mEpUsAptZ6v2979qLXLeLHPQBVxqi+2wFHYq+kbe
         lyXTt2gOJMWmTNQ1Cdeb09bZSqZLQfOvc55f9oBCWR8X7svzunAsrDrXGIM/rV/rLjOr
         r2dJsYsLsRTNCzqf/zOmG/o8Paij97+CtSrWF2Lv6qSIfqolG9xsxRjNGcId+TOkUYeZ
         Nl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010750; x=1739615550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8hwGzi3Hp3FiM6WSaA00E6kTxU3J0ZfSTpTwIlQTOI=;
        b=GEQTk/lWRpcFvzajH5ThJ5nUe0fqX6dodw7NsQEtui+2ZKlbV8dNaci1zDXzBzMQ/Z
         1RQN3BZtgpiBbHj2OZUBO219u1aIp7aPuWDhyayug8AvWBlImwjGgeEJybqMGYHcls2+
         5rZncviL4+qZIKRTdgG7IVhIKmHv6OfvJlLSA2rtd6wl5PZEvWtaWy4BAMthZtLd9O+D
         ViRCHak3KMZDGwBkI4xxhRvzEGGPkIt5uEBAHJ/Car8AFioMdZp4ob6KaIxSEgn/OEWU
         NdTm2JXrekbkb0K9nKRPEBMtscbm3U0vA+9wNtiItlDfj0lMfCCcnJNnk2BfHiFFbecZ
         gq/A==
X-Forwarded-Encrypted: i=1; AJvYcCUzRve2hdTBUPUoxQ6AFtASkzifMvKxpTo7z8i4wWLpBlmn4YWugS/prsbbkGLXT+mdbVwKd5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YynltYeP7WLyNcZnCW52ZDGgBQzoVUjyOTQXziXhs7FkEkHBR0T
	QCVwJNiiS11OA/mMN1ExaPREChxT8p7ym744KT187jIGkKcGgXmh
X-Gm-Gg: ASbGncsuXES/o6CYOAf7qlyCrR0wje2xyLHJ35CIEjP+kV5bM3LUX2zdHKKwV+eqvhY
	6/KcwxIRVMXBUPL1/72pOqAo76m40R0amsBE87jkBK9/Ldjpzd+Z25/nZ+GEDBJG9CMLEmE9Fwu
	/MSkzN/4RIyJA8pEpgwYswUtZNvYoraz8CroAfBbVzUWlkjQAqxMoJSfs/l7Etnp5keLyehmGNI
	KkdtTl4O74UlH28h9wbpBNFdKISALijPIBM+zB/DrWEjRoHnUK1IweE4xqOSY2mQDDK1rnhwWYv
	S06Dpcs93J7qtP8LqKlFdhTE56p28jIe+TylhcCmIpi9v29q46QG8Q==
X-Google-Smtp-Source: AGHT+IG5bjLax9nMi51Uwvnq38d3wV8VHJvLD/WshL3r7K/jHGU++7rTRaIAjlyl4/SoitLvK6gt9w==
X-Received: by 2002:a17:903:240c:b0:21f:454:953c with SMTP id d9443c01a7336-21f4e800da4mr96692055ad.52.1739010749954;
        Sat, 08 Feb 2025 02:32:29 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:32:29 -0800 (PST)
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
Subject: [PATCH bpf-next v9 00/12] net-timestamp: bpf extension to equip applications transparently
Date: Sat,  8 Feb 2025 18:32:08 +0800
Message-Id: <20250208103220.72294-1-kerneljasonxing@gmail.com>
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
  bpf: add support for bpf_setsockopt()
  bpf: prepare for timestamping callbacks use
  bpf: stop unsafely accessing TCP fields in bpf callbacks
  bpf: stop calling some sock_op BPF CALLs in new timestamping callbacks
  net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
  bpf: support SCM_TSTAMP_SCHED of SO_TIMESTAMPING
  bpf: support sw SCM_TSTAMP_SND of SO_TIMESTAMPING
  bpf: support hw SCM_TSTAMP_SND of SO_TIMESTAMPING
  bpf: support SCM_TSTAMP_ACK of SO_TIMESTAMPING
  bpf: add a new callback in tcp_tx_timestamp()
  bpf: support selective sampling for bpf timestamping
  selftests/bpf: add simple bpf tests in the tx path for timestamping
    feature

 include/linux/filter.h                        |   1 +
 include/linux/skbuff.h                        |  12 +-
 include/net/sock.h                            |  10 +
 include/net/tcp.h                             |   5 +-
 include/uapi/linux/bpf.h                      |  30 ++
 kernel/bpf/btf.c                              |   1 +
 net/core/dev.c                                |   3 +-
 net/core/filter.c                             |  75 ++++-
 net/core/skbuff.c                             |  48 ++-
 net/core/sock.c                               |  15 +
 net/dsa/user.c                                |   2 +-
 net/ipv4/tcp.c                                |   4 +
 net/ipv4/tcp_input.c                          |   2 +
 net/ipv4/tcp_output.c                         |   2 +
 net/socket.c                                  |   2 +-
 tools/include/uapi/linux/bpf.h                |  23 ++
 .../bpf/prog_tests/so_timestamping.c          |  79 +++++
 .../selftests/bpf/progs/so_timestamping.c     | 312 ++++++++++++++++++
 18 files changed, 612 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

-- 
2.43.5


