Return-Path: <bpf+bounces-58568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0295CABDE28
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E837B4C5185
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5824BBFF;
	Tue, 20 May 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="i3CSniWs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3361FF7B3
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752678; cv=none; b=TsvbefQki95fT14alUEViMRveK822igY+MlueRpwiL69HMwMtHoGYQDJgSrvVP/7YrcUFpfZ8FFksO/PAKM8kgeQYUBwc5MOWSQHT5GGdaP2rxI3Bkkt3Ua82hlhbz/PyF4c3p35R4icA2H8OzH9z6GWfl2JpHscJn1V2l55SCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752678; c=relaxed/simple;
	bh=QEiO8wsCK+qSOz+gK2YWUcQImrIEqec71zcGhBthLRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSl9Tmn3FQzrDGwhiztLPj/8ay6a7NFig+mYa7Zk0kMc1AszZOuyBwZNDKrM+n3nMPc5huO97AfFO8ipT292anoXS2Bg+5na6z2dxyyI/zDn4u91nQfmWL/8yQ6B8XApVJePeqzkEaTeAIOl8h2gk1owthbN+DsKMdJCqLCQlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=i3CSniWs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7429cbbeec6so575789b3a.2
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752676; x=1748357476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CiR/JZnsukZe0SXagOMVdueqyVBVimMB2RijeoqPgRQ=;
        b=i3CSniWsUzalNyWr4CehHOjxoIi82ecSyxSFdN1U5cRz4Wetgi0N3lMw20B4wiyoLR
         YoaMhMDqpSbKu4U0xCR7uYlS5FtijhSmDYlk3EEcT9E/HK+MvFmHNeqTUrHEDsGRZL41
         rXinberXw8MD1aqyZiTp6wpVGhvkFZyiH4BUYF1jLNookXkXfOzuLEt8MEI2qaJtGmzS
         O54eE9rCG2rNhBqBgt5GHLeQoNPBRKLiDbyEh2uilyRsoObSa1lLXrKbfjETHy6CW4/+
         Bx+UbFhUZE2D7SBOZvla5zygK8goYDfffIChII+we3EvIGLFalVzobr7OaD5LGI3waPj
         L1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752676; x=1748357476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiR/JZnsukZe0SXagOMVdueqyVBVimMB2RijeoqPgRQ=;
        b=d7QHBEOSZ7Z0JhuY9xs4TzqpbXaYNS4Bue6M/1dCnYo9Tn4Bi9ifSP7w1K04LrZMhU
         56lNL1/4gazXKHr7byTSshTAmJHDwZThfjT9MeipdmH++XU6+aKZ9THAVfN9+T4MXaLt
         RQK3roRnDYz0zBx2bgMgyPWKBlbX/vGHjaFNmGQDRxFdcm9r0cH9PdZW0FryN35vs+hn
         Y7OIW0sYgK+dhZDm4oTghPyP/wuSjmUQgbEO9R74muD/O2W8Swaslfaz83bNp3v5Ifzb
         5My8YUxEeFdfQw++ra/cyy2RmMw+0VLrKOaBWMQLg9G24+j9/AhtM8JV/zI2Z2F2MIuv
         uNdw==
X-Forwarded-Encrypted: i=1; AJvYcCV/+RrdUarotKwJwyiu5Hf3jYizCxvpK15wG6LMUYB0wo5nR4nSG7cqXqotMq/td+vG/FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycXERZ57hcR+JVTvK8INOEFLE2syyJZnz1bVIIysbzd6mW1BQK
	eBPkr5kZ1JZUAKKIQB9iEjMNUiKHPnHy3pMIlStnBUCwV906/OQLPJTOp7y1l1nnV4w=
X-Gm-Gg: ASbGnctj4LE9rMvGhQkEKGGWLtEjUlZcejGv/OmBWg3I632Q7pCK54iXk/dXqjLXXlO
	WOa8VjJSHqRvnhc2yvgVt/Cv+pKDqXTtifnZPLLFS9dMSCIQY9nMFilyPD0S/Jp2PfnBTQBhs8v
	h7tC7T22wY+JbvqzbJaH5EyGoaaOV/WX1UAN78hpV8KN0bprpd+zD5tZHTpVHnGPrsJX2hTGwJp
	VNQWRfZs12FsDiJDrwMuMytzTw2Guzg6tlgqnTefbHrIaJ7WJcD8o1+OTUdLiStkxpBik+orrv+
	BF2Oe7VOyGkflvSC6KpeuJ0H+p5cLpz1LgGJ9KYo5OU0hyT9Vf8=
X-Google-Smtp-Source: AGHT+IFcA3Js4nz8WesvZtoQqiLsibsJmuFCNOv5K54B+dMZNmGnPSoxGYC5H05u03BOLMlqvphNYw==
X-Received: by 2002:a05:6a00:2790:b0:736:89bd:ffb9 with SMTP id d2e1a72fcca58-742a961344dmr7102688b3a.0.1747752675898;
        Tue, 20 May 2025 07:51:15 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:15 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 00/10] bpf: tcp: Exactly-once socket iteration
Date: Tue, 20 May 2025 07:50:47 -0700
Message-ID: <20250520145059.1773738-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP socket iterators use iter->offset to track progress through a
bucket, which is a measure of the number of matching sockets from the
current bucket that have been seen or processed by the iterator. On
subsequent iterations, if the current bucket has unprocessed items, we
skip at least iter->offset matching items in the bucket before adding
any remaining items to the next batch. However, iter->offset isn't
always an accurate measure of "things already seen" when the underlying
bucket changes between reads which can lead to repeated or skipped
sockets. Instead, this series remembers the cookies of the sockets we
haven't seen yet in the current bucket and resumes from the first cookie
in that list that we can find on the next iteration.

This is a continuation of the work started in [1]. This series largely
replicates the patterns applied to UDP socket iterators, applying them
instead to TCP socket iterators.

Note: This series depends on [1] to apply cleanly, which is currently
      available only in bpf-next/net. As such, CI may not pass if it
      tries to test on top of bpf-next/master, but manual CI executions
      on my branch that included commits from [1] were green.

[1]: https://lore.kernel.org/bpf/20250502161528.264630-1-jordan@jrife.io/

Jordan Rife (10):
  bpf: tcp: Make mem flags configurable through
    bpf_iter_tcp_realloc_batch
  bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
  bpf: tcp: Get rid of st_bucket_done
  bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch
    items
  bpf: tcp: Avoid socket skips and repeats during iteration
  selftests/bpf: Add tests for bucket resume logic in listening sockets
  selftests/bpf: Allow for iteration over multiple ports
  selftests/bpf: Make ehash buckets configurable in socket iterator
    tests
  selftests/bpf: Create established sockets in socket iterator tests
  selftests/bpf: Add tests for bucket resume logic in established
    sockets

 net/ipv4/tcp_ipv4.c                           | 262 ++++++++---
 .../bpf/prog_tests/sock_iter_batch.c          | 442 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |   4 +
 3 files changed, 631 insertions(+), 77 deletions(-)

-- 
2.43.0


