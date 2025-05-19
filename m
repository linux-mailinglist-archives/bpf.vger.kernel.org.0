Return-Path: <bpf+bounces-58501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1665ABC881
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3EB57AEB9D
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 20:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55DA20F09B;
	Mon, 19 May 2025 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffKkQx6+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60421770A;
	Mon, 19 May 2025 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687011; cv=none; b=kXHLaP7SkR33SbgyEtx8ecq4+dOMD3CyVnojuV/9vidpk0xpAfbBR2uya3NBufIruEjJZ/7K8nQRw5UkT4gqlZow1KH5A3Xyj/VwY2VRgdxFF5VLUzmp5Iy+yJ+7uiPi+daLvncX8/5Yye3iKlyUW8PIHPnoJ5iT13Ib8xcZEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687011; c=relaxed/simple;
	bh=0eClR2qaiguFrE2e5T3SFCg3u9TEA65W8tzDXssCHdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IUJG4gjxCbzn2MFKtFQCvXjBuIhBEI55UqJxA7x+vN/+I9HuOVZVVGfrXGW9q/rS754Y0goqAlDPL/f9Y047vE3BdgmrEAhmnEn+9b/Qx2LNwirf4Q5IkWGGdb/VGXUrO/azMPCG+GmnOUoyvTp1egxEc2G9IyUJ4XvNzU3ZE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffKkQx6+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73712952e1cso4619791b3a.1;
        Mon, 19 May 2025 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747687008; x=1748291808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjwqsAmYhzfYFs85Xbdw/aLv2dI+Huc3a/ycSeIq9cE=;
        b=ffKkQx6+/3QJ2PGVa/dEGGJMU+FjeG/Q2+RlMLC1Yl5C/46OBmn25p7EDh+wuQrcPd
         9/eJUNUkj7bL5LdqDsWhRXhDUT2WOieFPH6xW1PThsbmqGF51nIOBIkHUyRlme7RYeD2
         nABd9v7Jn02Q6jMLM1jgh4+euFXhB7DprpODXsSjBjxlZVt39oh3OgpPV9KBoU9rJlU5
         ++sLVWQ/ZBsF8BeYiAevEyBQ/Jgc7Q1SEfahsXOOR8bY7EUe6EKlyXkpTAf9vwovV+RL
         nNIp8lGFj4JqxXjGCYnqVMdrZkpwjVgbsrQfD4AUi4UdhjBof0fPC1wILf/tVmUd7okx
         8SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687008; x=1748291808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjwqsAmYhzfYFs85Xbdw/aLv2dI+Huc3a/ycSeIq9cE=;
        b=YTJTym3mKhXqycZQUXZsC7/09TMX8qQqleny9WbbHN439SUO54nJarqjnwblzsP8lw
         cIPx5frVvx3acRdGCz3Xs96hSaFF8ejmZS7Iza9gL0GRk80o0WRCRjhH4WZDiblRLSJ5
         Hhous9NEfkScdV/+U6ocpiqa8O66Cwi8mPjdb96tsdGwkOblr++IPXYYnjEQltMCry0T
         pStHvDu4y6+HDdfy7YZcFtVaxJTN6Uzk6YtPg/9JmnmudKr734DfKn0iMNoFxv7KCHZF
         sxh8EMSGHny3y9xBEMJbJet3sGZwm2JgIIVhIc+Z4KWKRXOnmJC1gOEbnvc8bRvL7zRm
         BE9g==
X-Gm-Message-State: AOJu0Yw6QuxeYrLTxTW1V6QnXB9KGWhjik5aX/0qPASJFJGgVvFLLFKe
	Ee0g31rDgkKBTf1AcOshgmgetLpjMVcz00VKJZWsxH68SpvVkNwnjbMKG1miLQ==
X-Gm-Gg: ASbGncsQJZ0vw5drFQYhKs4K/cG2armXrXVO7iBdUbwnr2i8JpSy7nBNjekBj0ylLo8
	tcka+XF7a58u56rWA+KsSdDd8CMgF4zL4yNy40i+fqOaqrMN0b1Mmlt4f5Gx6Q6xC/2I/h3Ylz/
	9RzEMq/vysNoOsTkg9OnCMgoOpNv2BywYlhLgk/KnR9YskR2ENNXmfwobbiysAqknOHaOA2iGYY
	U5brKEV6En4M/yUGBtLHerupsNU3IMltkLJYDWyPlH+Ylwecx/kNvt9sRuNYFjERq/xiAyHVa0c
	dJ+vU8CucpOzti4w8+BmMik2OcW7RIg4X4OTNUX4lYDvfQTxOEjsRGQ7fJ3Wjg==
X-Google-Smtp-Source: AGHT+IFVOSeaDT3YYUaUdFznUH8W7pZ51x2+S+QxxOLcYUajJ0s/A7LrCCQFXzrq67vZmMGreOOhCQ==
X-Received: by 2002:a05:6a00:3d11:b0:740:4fd8:a2bc with SMTP id d2e1a72fcca58-742acc8e40cmr16225768b3a.5.1747687008495;
        Mon, 19 May 2025 13:36:48 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970d5aasm6865112b3a.63.2025.05.19.13.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:36:47 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	zhoufeng.zf@bytedance.com,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch bpf-next v3 0/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Mon, 19 May 2025 13:36:24 -0700
Message-Id: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
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


