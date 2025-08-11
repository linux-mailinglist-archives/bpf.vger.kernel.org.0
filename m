Return-Path: <bpf+bounces-65386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE30B21722
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D40D463783
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE352E2F01;
	Mon, 11 Aug 2025 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjWeR+de"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B83311C02;
	Mon, 11 Aug 2025 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946841; cv=none; b=thdri4Hy7NjtiU2LeC/Er+l1Bgfwe4QlkQPpzx+yE16hfZ+KbJ42eaR2egmrqkAmjoBJTWLlxILUOxgnMhf90fCLJ1ho02O+r6toJTDfpEbLn3Kp0VL9s1NztsISTaJMlJakj7ioa4iX5fg21ID2d+bbMdJn2401DQxv+j6bLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946841; c=relaxed/simple;
	bh=d1HlpHNLPxNlwZl84KZVn8ElStRQdoDWy39S5n7it60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZUDhOYSAGn+TerRk0KvCJzomk2HFpldKr9dH0r5N0ZTDRT7K+bDe/Mqh/YpxET2UPcdeRiNZxqk95nppTe0iKYuKO5ctMYyEsSfnNucy7F3LIrQGz5zlvJEHwBfxLdCa6ZvkcA13KDAukOfaLkFEob8OHHJvcpHgeTv0jRoBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjWeR+de; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-458baf449cbso46799195e9.0;
        Mon, 11 Aug 2025 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754946838; x=1755551638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JeFkIy2JN36W/0wDq/oA3VW6V6rBmYYZMfC1rLu9Okk=;
        b=FjWeR+de8BPmrUt/oUltTJUrxA6SjvuuVdtPcASgKF/Zq1uSqFHMRnM77sLz2SzX5H
         FXi6I2BZbT+ZlRNgYsWC1iOC4AcCi2qQRNzcbYjZ043P3WAfCKoaaFAMkWQO8u5eX8+q
         n/Ty4h/EFCSCyp0XQ7Ml2W0KMV0BynC8wKkmtliaX507+7nlm/xT2Q4BR3NyQbyE134O
         tQ7ufuFiplwF+8qnBDzA5MeuzO5ljBo0+/4kHBO26bkQXVlPQhAgY5paMv7znbPwNNNn
         YRmApCm2a+D/lBkuKbz0D/jZj8aKWrDFBvWvY/wEghq5HHqOEUK+NHEphPOpswvgUgXB
         swEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946838; x=1755551638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeFkIy2JN36W/0wDq/oA3VW6V6rBmYYZMfC1rLu9Okk=;
        b=t4fJLBD4fOzLYRL4Pknhow7/cQSXWYdsYPHDg0bZaxcaqqI95AOaAivdI+cggSy3ol
         m6tmENIKnbemchxVZkRTESXGmp7JSlgIvFznS2kkwl3lrZxkwxbv6UDsyzEId1bTwhPB
         c72Wzlxqd4bnJEBSxP4nrSJ4kyYqvRBExl2GFeP1c5fV5o/1HhRk0U+Yr8tsc7uLph1w
         pc8DfVndYqnGUWxsMYJBM/8+mEE/z5Lph/vXThrJQ7aUfWjtyM3IyxK6S3JKXzRDe9Z0
         M8c5LnvNZM0bLQ8GIXBgypv8N9VZ9XsVeYkmYbT2BP9drg86yM/AC5sJ6g72oRpbINIF
         mfhA==
X-Forwarded-Encrypted: i=1; AJvYcCWpwdvP6ELA2QBc+GWMxTnZH3hc/xkwP1ATP2USitfA2pOoWP5wNAehtZHM/k5S3orSJaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2RpakPztbMjQQHwpgX0WbPBwdH3mFg/h1xALLYltTTaxUv9J
	5QU9gPE66MK19z8Ho5HeVTlwCLRZq4k8aE+GXyvIqoTRVkptzcbcQFzCyLJhfjSU
X-Gm-Gg: ASbGncs64sDeudVpFhcTJRXz7dUB/ovVlMF4qQCPPFKAv/Hue1tNqYQV6O8WS5iTj4q
	n+hok0lmW/0bnuwgCzo1KwQK4M0W8ifCEFUF9WNga4KL0HBk8W2DSwAohLQVn3Wxx2kgrzke0+l
	isplzeXkrSwBkITHUWvvdXXu1rhZC7Bw5AaMEEiCniGFj1Rcf4k1LyE9RkjsBbbhmZZaGwcQjZI
	1Ok+GjLwws4zC5BEiGJ/a+Vc1+qgEFurNEVdzTxSz99I61Lu+MWw9jHSTpQtdssYvDxDRMB1Gle
	/15R9gPM1HY3T5l3en9uHOm0OIXlr+k5Di/PQXJqulXVir7yHQdZNfYQo7hndsDNVDw6VOWyEY0
	Yqrl5r8c2YqxT3tO5Du2S2uaQbEi+6w==
X-Google-Smtp-Source: AGHT+IFj53qN0/G0XxDnIS+Gz2G0ntacQ0LlZhIrNyXhLrEMUeVFZA4cuvSrDMvWSz7yWkGPqgMgbg==
X-Received: by 2002:a05:600c:4e8f:b0:459:df48:3b19 with SMTP id 5b1f17b1804b1-45a10bea149mr11279175e9.18.1754946837361;
        Mon, 11 Aug 2025 14:13:57 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5853104sm269695685e9.8.2025.08.11.14.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:13:56 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	jdamato@fastly.com,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev,
	aleksander.lobakin@intel.com
Subject: [PATCH net-next V2 0/9] eth: fbnic: Add XDP support for fbnic
Date: Mon, 11 Aug 2025 14:13:29 -0700
Message-ID: <20250811211338.857992-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces basic XDP support for fbnic. To enable this,
it also includes preparatory changes such as making the HDS threshold
configurable via ethtool, updating headroom for fbnic, tracking
frag state in shinfo, and prefetching the first cacheline of data.

---
Changelog:
V2:
  * P1: Enforce a lower bound on header bytes and start splitting all
    frames on L2, L3, or L4 header boundaries based on frame size when
    hds_thresh is below this threshold
  * P5:
    - Update commit message
    - Update fbnic_run_xdp() to add comment about multi-frag check
  * P8: Address warnings with htmldocs

V1: https://lore.kernel.org/netdev/20250723145926.4120434-1-mohsin.bashr@gmail.com/

Mohsin Bashir (9):
  eth: fbnic: Add support for HDS configuration
  eth: fbnic: Update Headroom
  eth: fbnic: Use shinfo to track frags state on Rx
  eth: fbnic: Prefetch packet headers on Rx
  eth: fbnic: Add XDP pass, drop, abort support
  eth: fbnic: Add support for XDP queues
  eth: fbnic: Add support for XDP_TX action
  eth: fbnic: Collect packet statistics for XDP
  eth: fbnic: Report XDP stats via ethtool

 .../device_drivers/ethernet/meta/fbnic.rst    |  11 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  82 +++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  75 ++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 456 +++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  23 +-
 6 files changed, 575 insertions(+), 81 deletions(-)

-- 
2.47.3


