Return-Path: <bpf+bounces-43283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C59B2E69
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08612B233C9
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0A1DEFFB;
	Mon, 28 Oct 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjX3hM1b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D01D61A1;
	Mon, 28 Oct 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113571; cv=none; b=U+s8HZkLwEBDVAFzuyg+bOWUHeW213z5G+mJG2GpFjN4jG+Oj8pTu9B3zsXR6sGbAJ39IsouUUUlO6+R/0skaSVudIpUmmf9wz88n6nLQM2/RyoZXs2T9qqkEAXfuQuK1aFWpH2EXbYiVd9d+UzbveCHwzGBbjsPyba43aKQKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113571; c=relaxed/simple;
	bh=0Qy+zExF5uvq96q7hOQslqZoMLzX5BjP7kKA1/K8jUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4B4FqvCwvtbGhpkl0nN1RHptL98Cu7kng95ZMm+anHbiEZD7oTAETpSAztKrQs0re+THFqgnPljf1FuESPyOLHizeZI30sFRmvoOXT6EvYt0BDD+Bk797BNuPy0ROt1XxUXGMqgy1fzxhfFcRcRAG9/e8eRyKYlOo/5MTaYOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjX3hM1b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cb7139d9dso35828315ad.1;
        Mon, 28 Oct 2024 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113569; x=1730718369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi0lE+IMfKyaZmmjoOJenPEEs9Q4MdJsKONUq91GOE0=;
        b=ZjX3hM1bfA1vXUXOMU1psVA5l4yNM6O5dKdjtPq0lGPQS9TTvTwmzFg5k7xuK84+cc
         XJRzigLi73XjzdqWMUuVOnUI857LKbPHiE/45OGYDuoDpT9ezDYSvRYozGeg7ZzmVA9K
         TtDAtth/P7PlNxwe5Cq/1CbBTBfF0mliLo0nWhaMsLvZ0PaghL01EdsVJH0CjQRYy1i5
         hoEpB0IbFKekACeBTi3fy9j11qi7ZBGMuJ2Ze6QNk45dcounlP4P4s5VEBtI6vf/uHPz
         QFIUw+D8rTMeMVOKG2e7YATXQF6wshWdMoPasmYznUTZCyQZ2KpXBhPGTNEqvrzpdz3t
         6+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113569; x=1730718369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oi0lE+IMfKyaZmmjoOJenPEEs9Q4MdJsKONUq91GOE0=;
        b=auonoGlNHFXP6WqqA/GYaIIobM/d7tLXKPqDZOXfV3VMmoLwb1LvQhvud46h+a/SRp
         +I8jzhl85IQpqZbIXLWqj8uGVPrSDavigTdjXXqEGAdSsMAHTH/bK+Hxmt92WPPgQkKm
         FrXA5u+oikCUnZB0oKwPGDpPn2YBa5sBjVzM4Bw3m8vfWpg29HTaTdcZk652VtzZC9g+
         zVZcKGug9oGIprMyS1E+w+mWBuC+PvSGWdKIkuClmVgwG/UJpJ/NfMSUKUuUkc9dIJlK
         EUfpAhDU7AResRH3WRflgSf/xYY8a1Loc9HbBNo6wPqTQtviuJilMBJy+hOfLm1tQcki
         KQxw==
X-Forwarded-Encrypted: i=1; AJvYcCW15bewas6/GMjcJw56ec/zffEmAPfwmyRLdbLnVm0jjYXVNShrfFie/mG2A8QMs8zxG/1gvD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34asL/EiYwow8hNNb9uvQ1Gd38hBLWD0bxeusGQyXhULq4Nwt
	ddUYFiIZWOUN0j3keRCQkFTw1sjfFBV8kRE+27S+QWsbiekX6RvK
X-Google-Smtp-Source: AGHT+IHbd3froDCnb7vtj5g70Evu4nwO0GXP4MF/uKJ6fC1Hz9gnkZTYzr/0UjxPMJyL+xDA2mKxVg==
X-Received: by 2002:a17:902:e74a:b0:20c:5bf8:bd6e with SMTP id d9443c01a7336-210c6c69c33mr104956775ad.48.1730113568844;
        Mon, 28 Oct 2024 04:06:08 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:06:08 -0700 (PDT)
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
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 00/14] net-timestamp: bpf extension to equip applications transparently
Date: Mon, 28 Oct 2024 19:05:21 +0800
Message-Id: <20241028110535.82999-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by using
tracepoint to print information (say, tstamp) so that we can
transparently equip applications with this feature and require no
modification in user side.

Later, we discussed at netconf and agreed that we can use bpf for better
extension, which is mainly suggested by John Fastabend and Willem de
Bruijn. After sending the a few series in recent days, Martin KaFai Lau
provided many valuable advices. Many thanks here!

I post this series to see if we have a better solution to extend. My
feeling is BPF is a good place to provide a way to add timestamping by
administrators, without having to rebuild applications.  After this
series, we could step by step implement more advanced functions/flags
already in SO_TIMESTAMPING feature for bpf extension.

This approach mostly relies on existing SO_TIMESTAMPING feature, users
only needs to pass certain flags through bpf_setsocktop() to a separate
tsflags. For TX timestamps, they will be printed during generation
phase. For RX timestamps, we will wait for the moment when recvmsg() is
called, which isn't supported right now.

In this series, I support foundamental codes for both TCP and UDP protocols.

---
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


Jason Xing (14):
  net-timestamp: reorganize in skb_tstamp_tx_output()
  net-timestamp: allow two features to work parallelly
  net-timestamp: open gate for bpf_setsockopt/_getsockopt
  net-timestamp: introduce TS_SCHED_OPT_CB to generate dev xmit
    timestamp
  net-timestamp: introduce TS_SW_OPT_CB to generate driver timestamp
  net-timestamp: introduce TS_ACK_OPT_CB to generate tcp acked timestamp
  net-timestamp: add a new triggered point to set sk_tsflags_bpf in UDP
    layer
  net-timestamp: make bpf for tx timestamp work
  net-timestamp: add a common helper to set tskey
  net-timestamp: add basic support with tskey offset
  net-timestamp: support OPT_ID for TCP proto
  net-timestamp: add OPT_ID for UDP proto
  net-timestamp: use static key to control bpf extension
  bpf: add simple bpf tests in the tx path for so_timstamping feature

 include/net/sock.h                            |  14 +-
 include/uapi/linux/bpf.h                      |  18 +++
 include/uapi/linux/net_tstamp.h               |   7 +
 net/core/filter.c                             |   7 +-
 net/core/skbuff.c                             | 114 +++++++++++++++-
 net/core/sock.c                               | 125 ++++++++++++++----
 net/ipv4/ip_output.c                          |  18 ++-
 net/ipv4/tcp.c                                |  19 +++
 net/ipv4/udp.c                                |   4 +-
 net/ipv6/ip6_output.c                         |  18 ++-
 net/mptcp/sockopt.c                           |   2 +-
 net/socket.c                                  |   2 +-
 tools/include/uapi/linux/bpf.h                |  18 +++
 .../bpf/prog_tests/so_timestamping.c          |  98 ++++++++++++++
 .../selftests/bpf/progs/so_timestamping.c     | 123 +++++++++++++++++
 15 files changed, 539 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

-- 
2.37.3


