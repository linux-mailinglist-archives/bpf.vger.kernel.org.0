Return-Path: <bpf+bounces-52253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E55A40AF6
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 19:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33F23BFE44
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2520B21C;
	Sat, 22 Feb 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaWgSSmr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD335961;
	Sat, 22 Feb 2025 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249068; cv=none; b=ASmRyn+gCFi+3WqWkW8WMVlAYUgMqolzni34VMlQJd4bFtHmLNasZKGnC1+Hpr5Ot3wvWLO9DockCW7PncNBR5OfdFh9pBDIKTIH4Wj8KsNtB+1PybMwhqM9hp8lXgKpJynhovfEyAsq356a/tui39sjrqHAF7w1d+ikQDWUQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249068; c=relaxed/simple;
	bh=F370KETrMWzBfCAknccZHirCmbB67waMtTvyv7WFlGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ewZYfN21mFUdfx3U28LwabbCff5uSYAFqQOFn2rv76105+wO9reZz7f2opOWa3UWraE/M8TdyMDEEDCq63puQmtqMk5dHbBe4sH0X/NcNa4Hjlx1aAI3ZBwOHuhidd17GSUXpMposb2xP8O730Es8YbRbF6tRCLpv9CQ2uvb7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaWgSSmr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-221206dbd7eso64681675ad.2;
        Sat, 22 Feb 2025 10:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740249066; x=1740853866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JO23ucqLx5sqqdPCYez77ZwthsWLwhAUyq51soFFXxk=;
        b=LaWgSSmrwRIh99Lby8ICka4GG9LFkdgkgz7x/gqHdPl6Pj8pkiMZFZxtA+vbHv+fEX
         Ws1SBxLEiUXvqd5/bXKnY5Ha31nqlXkG+cw6zfbJQ6tb5xuU+IkWeymOxAqf+uWSE8Dv
         X+bLFq6GHa6U6o9nN83LRoh82rpQc/fpa36fpeUjyL11aVbD6GvBkF5xhTpTyAgTDIc4
         zou47m09meZehfyETshMEv9UWuy4SNFvfgpqWLYwGVu66a03DUpXDCBh2bWUOVRzrCzg
         HmxXkoN6WdbUb9h2NQq5yl9EhkJQoXOoHeF02nQH0cenrPLDOOOkyzWaQZyC59D/RZXL
         9AUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740249066; x=1740853866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JO23ucqLx5sqqdPCYez77ZwthsWLwhAUyq51soFFXxk=;
        b=LHJHfka02thcysTwN0eAn6EVizc9D8cAKfUpTzYtakDvQfSODlCaWr/qAnebZedBx1
         0GuHPnqFLvRRuNIiMgtyGtp7LbHHEzJULufNTM33Mgfk+l7FYwzfM5mQFNJFc916zBk4
         nEdcGVtCJbnjCLDxmj0ZMd0suh0P4JBGFu4N+jj6RYihBQdBl75tN76YnKKC4e7gMyZr
         M5ggZFrOr1jeYtPy4nDlfkqEMIREYsp6GJRmyBRzvCcw3RYGSqmN888se5dp+saAFreB
         EKmAF5ydfMT3b2wMa8lF5bB7LkfxPNGwLOGlNZvMW77i49GjIxJm+Gg8+7gHHVoEd0v+
         RJCw==
X-Gm-Message-State: AOJu0Yx9Z/vo8urq6Qg9AiKENlYpWoEXhaHwFIB9sFluYt9D7KEQf2oD
	tqDX8yiEtk5grV5Gqs+iXtWJ/PWeOqOCwM1gxj0AEc5E8wPUWaLd9NPwyQ==
X-Gm-Gg: ASbGncseQ43dmH3groonh1ttSOnhQfnOQJ1RXkVk142bsx+QIXGBrAbH0JNZU9Gz2Ya
	46w2aJoJj70nbHQw6zhow1kwk96QDhwFsxEGoXrdufLk4Xy+rZm5iSzWFMsHcTLBeqFURWfQSlv
	Jz1A88xqnb2M1SuIpQqiRQaOpfSHjqkR3qdtJNbeh6Kj1btOmRewZXN/2vVQBGv31/yC6eGOAJw
	gghhbZiUMmRnLiD1HI7Mo1skgrtackr23fDOZEeD3M5G9YlTXViRBUF/z980dYxrFqs4xPuSUTh
	qOnEgyTIT/5PDJZ0SPkZGRf7Op9cy9IeF+A2qvs1gslGzx07CaLV51o=
X-Google-Smtp-Source: AGHT+IHhOYfix2yw/nhson6NU50l6sm551VjCRHt0U4RfUKlhoZbwPgbkLHcVLk4h/MRnKMVs0ZC3w==
X-Received: by 2002:a05:6a00:4f8f:b0:730:9242:e68 with SMTP id d2e1a72fcca58-73426d96062mr10895518b3a.23.1740249065716;
        Sat, 22 Feb 2025 10:31:05 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:2714:159c:631a:37c0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73250dd701bsm16442959b3a.131.2025.02.22.10.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 10:31:05 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zhoufeng.zf@bytedance.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch bpf-next 0/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Sat, 22 Feb 2025 10:30:53 -0800
Message-Id: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset improves skmsg ingress redirection performance by a)
sophisticated batching with kworker; b) skmsg allocation caching with
kmem cache.

As a result, our patches significantly outperforms the vanilla kernel
in terms of throughput for almost all packet sizes. The percentage
improvement in throughput ranges from 3.13% to 160.92%, with smaller
packets showing the highest improvements.

For Latency, it induces slightly higher latency across most packet sizes
compared to the vanilla, which is also expected since this is a natural
side effect of batching.

Please see the detailed benchmarks:

+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| Throughput  | 64     | 128    | 256    | 512    | 1k     | 4k     | 16k    | 32k    | 64k    | 128k   | 256k   |
+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| Vanilla     | 0.17±0.02 | 0.36±0.01 | 0.72±0.02 | 1.37±0.05 | 2.60±0.12 | 8.24±0.44 | 22.38±2.02 | 25.49±1.28 | 43.07±1.36 | 66.87±4.14 | 73.70±7.15 |
| Patched     | 0.41±0.01 | 0.82±0.02 | 1.62±0.05 | 3.33±0.01 | 6.45±0.02 | 21.50±0.08 | 46.22±0.31 | 50.20±1.12 | 45.39±1.29 | 68.96±1.12 | 78.35±1.49 |
| Percentage  | 141.18%   | 127.78%   | 125.00%   | 143.07%   | 148.08%   | 160.92%   | 106.52%    | 97.00%     | 5.38%      | 3.13%      | 6.32%      |
+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+

+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| Latency     | 64        | 128       | 256       | 512       | 1k        | 4k        | 16k       | 32k       | 63k       |
+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| Vanilla     | 5.80±4.02 | 5.83±3.61 | 5.86±4.10 | 5.91±4.19 | 5.98±4.14 | 6.61±4.47 | 8.60±2.59 | 10.96±5.50| 15.02±6.78|
| Patched     | 6.18±3.03 | 6.23±4.38 | 6.25±4.44 | 6.13±4.35 | 6.32±4.23 | 6.94±4.61 | 8.90±5.49 | 11.12±6.10| 14.88±6.55|
| Percentage  | 6.55%     | 6.87%     | 6.66%     | 3.72%     | 5.68%     | 4.99%     | 3.49%     | 1.46%     |-0.93%     |
+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+

---
Cong Wang (2):
  skmsg: rename sk_msg_alloc() to sk_msg_expand()
  skmsg: use bitfields for struct sk_psock

Zijian Zhang (2):
  skmsg: implement slab allocator cache for sk_msg
  tcp_bpf: improve ingress redirection performance with message corking

 include/linux/skmsg.h |  48 +++++++---
 net/core/skmsg.c      | 173 ++++++++++++++++++++++++++++++++---
 net/ipv4/tcp_bpf.c    | 204 +++++++++++++++++++++++++++++++++++++++---
 net/tls/tls_sw.c      |   6 +-
 net/xfrm/espintcp.c   |   2 +-
 5 files changed, 394 insertions(+), 39 deletions(-)

-- 
2.34.1


