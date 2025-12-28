Return-Path: <bpf+bounces-77454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28241CE036A
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 01:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5000E300E7A6
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF42F54758;
	Sun, 28 Dec 2025 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft5j3A7b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA111F9C0
	for <bpf@vger.kernel.org>; Sun, 28 Dec 2025 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766881360; cv=none; b=ciS7PsBHmlSShZLMHAq7wl6y9rNOQjjJQ+XvFfSuUpXYXMUhn286IaxwGpr+1tKJmUuhd73FXEKKMKksPHXmUtPp91S1DOZrWmlQLivyKfnvrJ8XiOJ/GRvmBO0eEck1DtktM6COhyP0AA4CCJLw9vYo8XQ7DedoBMqtHP8Reok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766881360; c=relaxed/simple;
	bh=jpq9wHpx7bbbe0M/sN16gJU+/hyNHN2RoIoLmwCkVWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Q7tnxfdKy8jOEltQsdwxBrn3AcsL/uBaiFmjwEOHbF/02tKcpRjG16+hgisjplzhEM+bCvnP1imDuxcn7wVRYUaPVhlK7qBs5LM4WaW7cmLsUben9/Ew2MEnvUeoFkyfzSzY2pLB++s1g3DeLX+313VU16Eeg358EJE1LroJidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft5j3A7b; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0c09bb78cso59485485ad.0
        for <bpf@vger.kernel.org>; Sat, 27 Dec 2025 16:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766881358; x=1767486158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haWapWv1wXexP50q4CCHapERJCCyXb7DbT6L6pxNCAU=;
        b=ft5j3A7bomz6tpbFHHCwo1z1zp7qkSyye/hIi71dNVx2SRATa0bVQgyDQ64jPjsowE
         FKak+6iHuNyvjWSrXe7fPh5om84n83UN429QcdLVRrdqtrK/ZrVjcb0Xl7VhT4CkwrIZ
         KGpHmzdfGVQxdzVF2X4klDS14A4Cztlvfod28MoNZhNpkxUW98cSfhC6IUjzt2pZdmT6
         J8I93C+zS/weacqfHcP3ECFlYTcxraLUlxd6B2wh32M4rxT+jFiKKw7+9EbbmiUff1yR
         MSHDa8Re7AncYxnFeySuWAXHSv2i2WjMUkL6RbU6WATtMrT/AQk6/7tA6TIiZzqMcWYp
         IvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766881358; x=1767486158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haWapWv1wXexP50q4CCHapERJCCyXb7DbT6L6pxNCAU=;
        b=a5U9stVI9rW71eq2IfFahMgvOwM6Ug8U1Qr3213tdrEG84i1juKIKTl8Zb7zn9hSUS
         X8Mv93ivH96xd1UvdpmyNcA2L4y0l4JwypDwqUVyPav2qZcOCHYKp7pRoBCVm2+JTvTr
         neS45F8PFTOPU6hC8onz2RyqVvAkJgQl0e0jAqtn9t0gLD70IfwKPXPh9LGazXb4n+he
         yz7m8Br2kfA0OSeD6hPF9iOAcpxupPci2B26c5wBEHhSs1MhH8Oymw8mOmJXOOhx/s3g
         utnQbXJwjdnSDrCxsrdlilJMWmxvITFqDPATOub/wKJ1cWRSjJm+TnAKUNzdfbrcU8cv
         ZKtw==
X-Forwarded-Encrypted: i=1; AJvYcCV09AGlKmmuWsNazMmFzfqUlEVJLdhODM99W3gMTMsikhd8Cr9NqqB/Cp/TPROi9kiMju0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQJKT1ig14KNE1hBnEhy6SV0YZs3v+fiODV3K7sGSCAFWu6t0
	DUhzmMRzIKQAeS0JPgeAyUAc+iMrC5i/oIrkfjBjRTO52sLezVQ1hRw03E4H8w==
X-Gm-Gg: AY/fxX7Jh6IWCrGPEPjH/LF4jAISu8SrX546WYuaDaFwrCSPexLVjSPlAPp7wit+eYe
	lvvQAlWI7c6E5vjuBEWicS63DL/Fcmx77HtdBVYlylP1C+XX5+sus5Yql84xkVKgbirN0Jl/lhz
	r4HsPENuOtBPG+KZreW2jhh2iR7vgMe+3uSfX8ndkmj1QGF6CotKJ216BQIaQ/64DOoFjUH1iKz
	mVm4Fpc6IRe+eqyF0ieiHor78WPcv9wDL2UZhnMmCR7E62cH/Pw3Sxxc68q36+eyjFfEQSAL7RC
	YphTF1lY9rxRqfPitBRRcSY1dPc4dNhEuxQV7sQzjlGMP4onUq8kDVS4kKaMiHaBwnFiu4wdFiB
	9OZlm14YvYhTZTLVCjWJ4PPjsDQxEdek0Qws37RquH7Zr6siUKkcHca2H4IwgWvD1QaPyliLgzA
	IO8IiQssaX5VX++l22Z/L2AU3Asjk=
X-Google-Smtp-Source: AGHT+IEyNRCEctvv5fntKI6R4JDlZ+lmDeSwQYl7JEaS49Pj3JQEzp9fSGxOToqojbCum385ObBQaA==
X-Received: by 2002:a17:903:32c5:b0:2a0:97ea:b1bd with SMTP id d9443c01a7336-2a2ca8f6621mr348183025ad.0.1766881358144;
        Sat, 27 Dec 2025 16:22:38 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:70f5:5037:d004:a56e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm236533535ad.100.2025.12.27.16.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 16:22:37 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	bpf@vger.kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch bpf-next v5 0/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Sat, 27 Dec 2025 16:22:15 -0800
Message-Id: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
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

For latency, it induces slightly higher latency across most packet sizes
compared to the vanilla, which is also expected since this is a natural
side effect of batching.

Here are the detailed benchmarks:

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
v5: no change, just rebase

v4: pass false instead of 'redir_ingress' to tcp_bpf_sendmsg_redir()

v3: no change, just rebase

v2: improved commit message of patch 3/4
    changed to 'u8' for bitfields, as suggested by Jakub

Cong Wang (2):
  skmsg: rename sk_msg_alloc() to sk_msg_expand()
  skmsg: save some space in struct sk_psock

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


