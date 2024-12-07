Return-Path: <bpf+bounces-46351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48489E8146
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C302E18814A1
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD9014A0BC;
	Sat,  7 Dec 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHirA+q/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E08F14600F;
	Sat,  7 Dec 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593095; cv=none; b=UzKzDQ1gYoqyltnUinVwnj6qqnOsvaUCUeYopEbzxHiWDYDX8ynhh3haG9qI6psrvE9lHYrISA37/zJE6pAagC9q/HSdGhpAmQaXyDnVo5XsmldqIKEr04Bnib0LSsoIz6ZzAPkA9aoTHlkgJZm+4CnZi56qA9ENyCc85DgX56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593095; c=relaxed/simple;
	bh=QEe985tiQTVS16hAd61CGg/r6cQagwmDImmzKLPlT84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ln5ZefLlFENzBn+5r5wxQR757Kx1L4znaO0sF4C0cqaLpq0M2sWVZL3RMgZMJCm5JZWj52hlGSCUI0zpg52OqTY+3eOPiKj9dnjuuaY9nWgJVpr7aR75TkRii7rKCyC84braj7bmUUMUHT/6hoAmjgzYcIGGfvG8wMw2dzzZnhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHirA+q/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso3266759a12.1;
        Sat, 07 Dec 2024 09:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593093; x=1734197893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nU+l7Rta14nl9AS+T862cSexYXyNCC6ms0EVlRumwYM=;
        b=mHirA+q/mJs+0R442fEzuOj9vu/zCH7GguuVd4nJtMT16FB6imbybtZACZUw2dl1Gf
         zObSp6L/xm0Z9zV4k1n/HWJXUrG0+sO2At1jFrxaDEk8dlKlHrz5zt6IkJwXKicQlcla
         +0rs91H4j9plu8g54yF6LOpg6h1lPJGOi701bdqjmOSdJomKgMfxvV/TI8h5ifjn6LLQ
         Lzj9Q0W1qjMUnTwCb4CExR5GvokF48E0l5GpPUA9CbqFANOlJ5ivRpe4Q+PP35WpxbtW
         8136e7GWRVps6gVf1ysGafriP6PkijU95tWFA/0ljVtqNnXxnFOlmxjoacLXShx129h1
         Hp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593093; x=1734197893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nU+l7Rta14nl9AS+T862cSexYXyNCC6ms0EVlRumwYM=;
        b=D09+Z0TnxZCzWDsRHljhV7iICa6/Ee5lmvOVk/6hmg14TWG5RieNPHviQ7ATBXPGl9
         Aj7pTM/tiP2tDbRjSlmyO5Ib9QRH0GtzD/Rc7IlEa2F/cG4xP5Imdm92g1GZqGc8siSP
         W4j02+VOALaSKCiM/iD/40o0gLRa1Tyfixv/7RwikGwBFpvICgn03abynaCXZPlz4aq8
         gTxaKxe5smBjfk2+3ADXtrrhOMkjYNrPt4FQsNq3QLkFCKPSc2xT+27rSbVaILKhuEgY
         88ifIKtq9y4EMaUkwxa6bj6tR/93eBTg9lhpNrex015L/jFfPNoG5OBPfS8qhX5+A1b5
         b1cA==
X-Forwarded-Encrypted: i=1; AJvYcCXX+YEEXZjOgOABDQGBXFGKKlGJ0Xl3DJQWltCsg/Cg+gTVbqG6IeLXKw4Zm6IUKNTbLneAlWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwohJXx61oj8um1P839Dlf/G4hfuuFhuyRLKRo9FUwXET8Sa8eo
	qRPxogazadD65F7/MqkvTPTIMloUWi8AY/0/FQ7eeZnsZC/RVbBx
X-Gm-Gg: ASbGncvHzlFXra62orEXaJQbeB8A/+cAKq4Nfyaj/6PAwalGBtpEJyezUEXqvRXl/Hb
	EmoshVKTX7lqbzLy8H/C4wpn77KlTRTF2QnYiEnPZelUH/weCUmnSWty9tZH7BujQbh/CwuZeJz
	93pkl4y/3/l9fge6rSnBE7qfqxcYtXblHm6t102r2T2eKkAjdQCI6ZxGSFPR1QDbH0LRwxUJuqG
	3iyZGwRg5MpZsTHDW+YC2/6rlfpI9TD1ZA/EGoD9wzMminx6FIVj22Vl7eBI+TJ7JBXBrkGbH1l
	1jJCfwXdECp2
X-Google-Smtp-Source: AGHT+IGFuxDF1zjKhpJcAq1qiXPCtL1J1jcTjjZFjsFXUIz28cQgS0HSR6UhG1iJx8EdfV2fWThpHw==
X-Received: by 2002:a17:90a:778a:b0:2ee:8253:9a9f with SMTP id 98e67ed59e1d1-2ef41c71cb6mr17887102a91.11.1733593093360;
        Sat, 07 Dec 2024 09:38:13 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:38:13 -0800 (PST)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 00/11] net-timestamp: bpf extension to equip applications transparently
Date: Sun,  8 Dec 2024 01:37:52 +0800
Message-Id: <20241207173803.90744-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In August, I planned to extend SO_TIMESTMAMPING feature by using
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
phases.

In this series, I support foundamental codes for TCP.

---
v4
// Sorry for delaying almost one month :(
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


Jason Xing (11):
  net-timestamp: add support for bpf_setsockopt()
  net-timestamp: prepare for bpf prog use
  net-timestamp: reorganize in skb_tstamp_tx_output()
  net-timestamp: support SCM_TSTAMP_SCHED for bpf extension
  net-timestamp: support SCM_TSTAMP_SND for bpf extension
  net-timestamp: support SCM_TSTAMP_ACK for bpf extension
  net-timestamp: support hwtstamp print for bpf extension
  net-timestamp: make TCP tx timestamp bpf extension work
  net-timestamp: introduce cgroup lock to avoid affecting non-bpf cases
  net-timestamp: export the tskey for TCP bpf extension
  bpf: add simple bpf tests in the tx path for so_timstamping feature

 include/linux/skbuff.h                        |  10 +-
 include/net/sock.h                            |  16 +++
 include/net/tcp.h                             |   3 +-
 include/uapi/linux/bpf.h                      |  23 +++
 net/core/dev.c                                |   3 +-
 net/core/filter.c                             |  22 +++
 net/core/skbuff.c                             |  88 +++++++++++-
 net/core/sock.c                               |  17 +++
 net/ipv4/tcp.c                                |  10 ++
 net/ipv4/tcp_input.c                          |   3 +-
 net/ipv4/tcp_output.c                         |   5 +
 tools/include/uapi/linux/bpf.h                |  16 +++
 .../bpf/prog_tests/so_timestamping.c          |  97 +++++++++++++
 .../selftests/bpf/progs/so_timestamping.c     | 135 ++++++++++++++++++
 14 files changed, 435 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c

-- 
2.37.3


