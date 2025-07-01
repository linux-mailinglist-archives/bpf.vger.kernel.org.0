Return-Path: <bpf+bounces-61923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE14AEEBD2
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 03:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294AE17D873
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 01:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7418C322;
	Tue,  1 Jul 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdMLcnAW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CDB1CAB3;
	Tue,  1 Jul 2025 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332346; cv=none; b=VxDj0k3WHqr8pDOzlUNGXzjk9u6tU7ngbuS/dxNsbC3dE9At/HlBnoqZATKPgk+A611rIQfwbss93t9Kw6NS7Ct3FUuRPEY0q4hpqscrARkKyXFMvFZTb0D287sWa9ZC5DoUTHvury+jvoaVnFbBsx5OfGuJxTqnzxeQdFJtIko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332346; c=relaxed/simple;
	bh=OnES28WQihJmhS8qmhKIwC2/bLRQ/l2ImwS6wEdOW7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=d1z7n9mapcw8PY7Xv2nLsqOTXesfxVfNlgZzawGz+5VTrLaLm7N0C7ZIzd4E2IXCkSgDAWibCW7XLix78C7W4XZTn/CEOt2gv/j/2G5zQIUV0EThmS0cfN6w7vGUfm1vZCBfPtqRnyZcENLnRsB7CgQO3BJc46Pr4EjdvZ/e620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdMLcnAW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso2823499a91.3;
        Mon, 30 Jun 2025 18:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751332344; x=1751937144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjtYZ36tAvjB0zry3ZSZH+1/EcQXRIsXI5tMq7yYLHE=;
        b=OdMLcnAW2L+gDH0jOdICsfDfLcAjCTWX/edZ/1sooMJDn5qBEy2A/m6+i7A5QDhiER
         GzysgrJvSG77xB/Xy6vhDTi50oC0itd0sqYjD8eM+ICeBccD7rGanVFUyR7mpSSJDtwG
         0nxUNwZuOXymNVq5OyR/zvyuyO+wFk51LFTf/4eHSvEWTOBWx0CB0vRPOILSiNp8DoLw
         zWmeoNQoXcOwt0CavtJoocsjwuvqZVnkdXbCvS2Z6BKWgzzKVpPnfEu1TCRtO1o3LSRZ
         xGSddB4DySIhcsLnHuwo6UVzNUYLm24IBi23xE/X+WuFiEs8wz6jDuhyOGpe0hR0As+T
         FW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751332344; x=1751937144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjtYZ36tAvjB0zry3ZSZH+1/EcQXRIsXI5tMq7yYLHE=;
        b=HVRMliN6GqlGxrVKcZEADv1hqESfLhF+bX0+9uohmaz9zUgaDsXGOj5035SVDvojn/
         +GpHiS9bSc3pEdEl2u9qJRduFF2I7JsPdmg0tswSSXZ1b4i1p9gLdT4vLrCJpQNGyvZY
         nCAM5M4Qp7Q3PWNEAM8nx58fKXAMDd6XpVZHGxBkP7xYTnfCHWqGLc+5MhQg34pNK/6u
         lKnA1e3YttlNgTggGseKluyXmycJw26f8rnbKAMaDHAdibzhb2zBPwmx34bGoqgTkuTS
         o8k+5h8QLaUXAA6czcVuI6BO1DhACWMHgK1ePslx9pCGbLlsPZbnCVd65IXQm61pEt3a
         q7EQ==
X-Gm-Message-State: AOJu0YzauY7EZPWxjB71ty+fS6042aLTf3/g4iHbUZ9bMpS8//cJa0KE
	fSYLosokIcavrh8fVFfw4CkDCY5a7FL4itKJSgbQeMECNfB+mz4lqrsN/nM8VQ==
X-Gm-Gg: ASbGncv76nD2aTFuGCSY2S3vRH9nHTYKQP9cbTnQkTpqcvR+PX3rSZ2790Yb9aqppU0
	uocNIqdyvG1tN6jbkH7acECl03wsX5bZf67z0z5ZEr9ucNMqiG2G9IV2xQAG1eYPRRXC6SU9Y4a
	1fyazYNu4Rkr1KAjeJze9xXK2lXCbpwYmgGKDp4LJwG6ukb0E1R9o2//Oz85IyX0CmCFHBtiWzy
	koVknN32g3cH9HNmBkPwJyzUczt99oIn36410RVgc7zF7UByOlpCpypjBSrILn5rWoYoF89Mivv
	mk0VzKeSH1MWKrjXZbUe7b/FpXkJx7Y4cZQ/rVKwqx19aXP+Y2NZm9YoNfEsdmBKzJlVGPv1+rS
	Lng/mjHs=
X-Google-Smtp-Source: AGHT+IErhKdws2nEf95XEZjjp1Z2Tu4X6P2O4iAgq9k7oU25Lo27wyBEb8gBjgG1Ne8gu7SKlX2iKA==
X-Received: by 2002:a17:90b:2550:b0:311:e9ac:f5ce with SMTP id 98e67ed59e1d1-318c92a2e3amr20010372a91.21.1751332343616;
        Mon, 30 Jun 2025 18:12:23 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bfbesm100007455ad.109.2025.06.30.18.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:12:23 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	zhoufeng.zf@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch bpf-next v4 0/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Mon, 30 Jun 2025 18:11:57 -0700
Message-Id: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
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


