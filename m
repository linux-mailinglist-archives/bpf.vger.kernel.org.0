Return-Path: <bpf+bounces-47245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC59F6762
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 14:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58E11893AFE
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE46E1BEF61;
	Wed, 18 Dec 2024 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYFuGHqF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8081B423D
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528868; cv=none; b=rlMndeg2t4fL0xYFlXt+hdiOFanmnH5WuLwnYXha51FvBmQjctQ9M6Wl1yz9AOHpMZ0jAb2wYfUKXk2YTfq/CNEAg4ovFlLtx5pa6PiHyZMw7LNfHcp7UKMj6943Jp+Ba+b3KRjeAJynvVaHZKDRHSKjNS7MFB1K1o2c7n4hw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528868; c=relaxed/simple;
	bh=wDaSHl6EOLx2HW9/Hvaguz2TFU28I1zbXh8HD0FM3Oc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oLpu2FaMwH+ZgV1HmR+Gwk0C/zOCbkHQNiDpy/hrsxPacJnM9YiSgZy0WGYAvyIOKBS+Z3qxvOIERXx8PccjQhBqGQ4VtBWwShoIwwf5tKZHflFM8e61L2y1HjIl3wqmizb5jeIUxGRuiROAmd0ht3SugbRn016q61PWkUCIMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYFuGHqF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-728eb2e190cso5778417b3a.3
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 05:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734528865; x=1735133665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PYcDCL2CgJWsHG7wlCFHCfYZtvaurKzilwan+RLOuVo=;
        b=YYFuGHqFBQRSSboqLgxRI+YijyyueC9Pkbj5w1SRYQ1IpPlvRtCLIFV6lqlY2e3EJF
         lu/XEJ3tArmJoRjiN6YjSAhv6cvGV9JMUfe/iGS5VGzVVKMUMqcmmZSYL4Ce5aPtl9hE
         fCA+zoRS2j0ToiH5DrLWvOAN62xzVzsqQh7rRCtYcSUPEFL6QUV9MBILW4IOAFZNQdBv
         PN91YfmZmPEhmIFEDFXWtDJZvEAE3vd7uNGWzq9yLsJ/TM54gujkKB0rDOjm/m7eyDU1
         aow99hqW9Oz/BVel6VD4lU0qv35ybe608MrDG/u8wNXfaWfXGAi5/QKpDOOntO79uy+3
         JT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528865; x=1735133665;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYcDCL2CgJWsHG7wlCFHCfYZtvaurKzilwan+RLOuVo=;
        b=e+qJ05FbkU7oFsmKkdniqCOKsRKb67EizhKOwTsGcKseZQHaU3j5+myXuetwXw1Hea
         US8FIH2K5VET73fKLGx4CSHVA7kIolWwdV7RE9aFKNo2VLVLtbCKjuDlnGKxWdz+Jb+6
         KvPnvSfPw6odKevBO09n7Wa64fdqKmT1joI0uxzB7lPSduU4XMibqkwGiriFEfcDouGr
         HPwwW+z+BLflXPr5y8X8Qa4dq6ywF8nPZDR2nr0kSOZ9kP4Euf0wlQdJO9LwiLzL4DNf
         rIHlxLvGquDNd+V9xp/TNwz3xqi+lxRU1dUjislhDfGTc4Vtr5YzD9cYQB8USUF7paDX
         qrqA==
X-Forwarded-Encrypted: i=1; AJvYcCXymsMiKZvgNVRTAy2jBcNZrh+c5ATqngIZOQZ+BEGjoYRlwd84ZiOepuY0PCSiPNPYLPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxTZM/Ec9RA7umeKrZzwQEF2jjEt5/7h550d6o21/w3uvPwUp0
	4DWGAJJQkfouIxHl83/KGzMu23gdBXuRMysUsy6tCUofh4N/YwQQWYQOF2HirzJmm0hwDM1cXmG
	0YDNsK4aKgorOor8pcNtIK/t/hg==
X-Google-Smtp-Source: AGHT+IGMX4JT+B6/tlI32NjXcY4ud9Il+SfQQbPXW/r5+4XqZYAzfxIh0LcMi0lWc9+Erexa8mQQmnaBzkGs9j0vCFM=
X-Received: from pfik23.prod.google.com ([2002:aa7:8217:0:b0:725:1e74:6a17])
 (user=pkaligineedi job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1311:b0:72a:8b90:92e9 with SMTP id d2e1a72fcca58-72a8d0310c1mr5167172b3a.5.1734528865392;
 Wed, 18 Dec 2024 05:34:25 -0800 (PST)
Date: Wed, 18 Dec 2024 05:34:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218133415.3759501-1-pkaligineedi@google.com>
Subject: [PATCH net 0/5] gve: various XDP fixes
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, shailend@google.com, willemb@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	hramamurthy@google.com, joshwash@google.com, ziweixiao@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

This patch series contains the following XDP fixes:
 - clean up XDP tx queue when stopping rings
 - use RCU synchronization to guard existence of XDP queues
 - perform XSK TX as part of RX NAPI to fix busy polling
 - fix XDP allocation issues when non-XDP configurations occur

Joshua Washington (5):
  gve: clean XDP queues in gve_tx_stop_ring_gqi
  gve: guard XDP xmit NDO on existence of xdp queues
  gve: guard XSK operations on the existence of queues
  gve: share napi for RX and XSK TX
  gve: fix XDP allocation path in edge cases

 drivers/net/ethernet/google/gve/gve.h      |  1 +
 drivers/net/ethernet/google/gve/gve_main.c | 42 ++++++++++++++------
 drivers/net/ethernet/google/gve/gve_tx.c   | 46 ++++++++++++++--------
 3 files changed, 60 insertions(+), 29 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


