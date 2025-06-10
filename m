Return-Path: <bpf+bounces-60171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC43AD3818
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5EFA7AE0EC
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5572D3213;
	Tue, 10 Jun 2025 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANBQjQQI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC92D29BF;
	Tue, 10 Jun 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560401; cv=none; b=tLXVJg17WjnlAYnOYXVuLNTcz8qh+1PO2B12WBi8bXZ9FouX2QW24+cwAWU+A7N0Zpy2F5AOcE/Y1IB1TMlJZL9b2ncIxZnnoNgR82+VriVRqTGRcC9cqZKyElFE77s9iv5gIYv8zPMk/LzFlXgcUW9azju/hdKSgngrATJZd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560401; c=relaxed/simple;
	bh=8s9eNAGzDntGvZK7Pc6cMHYrqeVLULwscezMnMgGoE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNcYYAWHJrGx3KCqudgsnvZI0d6HXIKAdHeksFRNwZvxlytO6gp1Rm9lDg9fA0peniN674KE/TaT506x2cGlzyHDD0REMzO0DrB7kZs7xvRjY9jIUg3QhSDsiSTyM886fWTEuhKi9/zByKeg58MJr4sNDucBasNXQBZpOOxNFh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANBQjQQI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso47000575e9.2;
        Tue, 10 Jun 2025 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560396; x=1750165196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EBizC4HChtDjhvxMjVZXHxWUIj72Hoy73F5AtjgusPA=;
        b=ANBQjQQIMaw9yw6JaJ53PbudvK/YJYZhWyatwCNres8AsJ+KbaatPTDb/3EDfQqRpx
         2Flq2K2nl9UQ6KVr/WfnLXfv0ALkQHlfYGTRiOmteyskC+7eZLOo42J/q6bHc+wwbFCE
         WAbuKaDndqswJt+CKZZ4q4C8HkxgWCMh9sPi6uS2eJ+ICwQ8JR/a/cwDcwK1At+Xa0lh
         to51pa8zenZR9yfe98kZiJuVkj932jW8cSV1ZcPzG9PfYOY4Np93mrMxXNR2KUvmcaYq
         LD4X90+LqMYR9mHy/TAdz2LPtPkSNdhjw7L/Xje6YfiCuILooe3ZU/xu5eRW8l10de/I
         Im9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560396; x=1750165196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBizC4HChtDjhvxMjVZXHxWUIj72Hoy73F5AtjgusPA=;
        b=A9QMz+pALWucvUuGhBic6VeSoR3kU9igOofh8Umugx8KpHUdXDL2k8R+4WMvQhQywe
         ouNFYdbMBiYBJfbVOoa7dgj8hh23B3qF6tbOd+jMGS91oUDihgxemxCxuL4bGWueXp9K
         qIVHuFba/Qp+gdiKudsnT4rSHT7eo6V1aZOUdDehL7Te/8XXVWmB2MkqbN9LDJUiaPTE
         euMHsH7DBNeOXncGMZeY/SnjmIq1uIucTfmM97M44UeN8g6NnVwjpg8NLblxlP/SFcL4
         of8JHPiCJ+LuEJkbVTpEG/0kz8TDpZF+ZaiCfArUdX70Tm/67QY1nhr7BpUnlqBnSlrC
         Io4A==
X-Forwarded-Encrypted: i=1; AJvYcCUjzI+HA+zgbW5c6F+PvBnolEPnc0LFzH+tSjpWhAk7b8qfpVMpsSpKijycKDuLc1EM9NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEfettX8h1zQaiV2l/0PtzL0nPcxtevmfDw8WsG/ZUrvzFLNu
	qIdcbfLVXI7ICRIG+cpW9hzYzp1WNzdVhtet7mvnzeSg8edpFceB/OZcfrQupg==
X-Gm-Gg: ASbGncus3aiAYjnIW8pS7fFWWK+Q8oP3q3yKtHawmM5hoPKpRU+BtiziZ1ORxQXCF42
	eykXZtw/XtXETsTVBiLSZ6Adgx5DOvbnArMiGiZoXVlEwojXpL80beLlTLsBf4mSpkWF8C7zr6n
	9w+7K5H+tEE7+l/eKSYKTqYjn/MmBboityWg3JQj4g7oj8xIyHdfU/JqqCiV8wXpNLl9ZQmHQ2c
	rDoTDX/ZLT0iYa6cszw6Rg/afEmYe81AKaIcvYCtwe64c+nJW18UcEoCHtgeyxn8r+rsPvKkFCA
	IWmNAi5BO6MZBBBHe/h2o12UNSy2rnlmPlkVqWsaV/wzonfvUu/jLoMnA1CnfyycJx87tsvB2EO
	ig3T2
X-Google-Smtp-Source: AGHT+IGpxd1xxIqDK6SYHgkxWT+7F5cwAd7IVV1tuOTh0FRSNPqlNQxFdPzeQh9zjHggZ7MrXo7Uxw==
X-Received: by 2002:a05:600c:3b95:b0:442:faa3:fadb with SMTP id 5b1f17b1804b1-4520134081dmr172208475e9.2.1749560395787;
        Tue, 10 Jun 2025 05:59:55 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:59:55 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev,
	kernel-tls-handshake@lists.linux.dev,
	bpf@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/7] netlink: specs: fix all the yamllint errors
Date: Tue, 10 Jun 2025 13:59:37 +0100
Message-ID: <20250610125944.85265-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yamllint reported ~500 errors and warnings in the netlink specs. Fix all
the reported issues.

Link: https://lore.kernel.org/netdev/m2tt4tt3wv.fsf@gmail.com/

Donald Hunter (7):
  netlink: specs: add doc start markers to yaml
  netlink: specs: clean up spaces in brackets
  netlink: specs: fix up spaces before comments
  netlink: specs: fix up truthy values
  netlink: specs: fix up indentation errors
  netlink: specs: wrap long doc lines (>80 chars)
  netlink: specs: fix a couple of yamllint warnings

 Documentation/netlink/specs/conntrack.yaml    |  38 ++--
 Documentation/netlink/specs/devlink.yaml      | 208 +++++++++---------
 Documentation/netlink/specs/dpll.yaml         |  14 +-
 Documentation/netlink/specs/ethtool.yaml      |  70 +++---
 Documentation/netlink/specs/fou.yaml          |  14 +-
 Documentation/netlink/specs/handshake.yaml    |  10 +-
 Documentation/netlink/specs/lockd.yaml        |   4 +-
 Documentation/netlink/specs/mptcp_pm.yaml     | 192 ++++++++--------
 Documentation/netlink/specs/net_shaper.yaml   |   7 +-
 Documentation/netlink/specs/netdev.yaml       |  43 ++--
 Documentation/netlink/specs/nfsd.yaml         |  10 +-
 Documentation/netlink/specs/nftables.yaml     |  16 +-
 Documentation/netlink/specs/nl80211.yaml      | 109 ++++-----
 Documentation/netlink/specs/nlctrl.yaml       |   6 +-
 Documentation/netlink/specs/ovpn.yaml         |  26 +--
 Documentation/netlink/specs/ovs_datapath.yaml |   2 +-
 Documentation/netlink/specs/ovs_flow.yaml     |  16 +-
 Documentation/netlink/specs/ovs_vport.yaml    |   4 +-
 Documentation/netlink/specs/rt-addr.yaml      |   2 +-
 Documentation/netlink/specs/rt-link.yaml      |   2 +-
 Documentation/netlink/specs/rt-neigh.yaml     |   2 +-
 Documentation/netlink/specs/rt-route.yaml     |  10 +-
 Documentation/netlink/specs/rt-rule.yaml      |   2 +-
 Documentation/netlink/specs/tc.yaml           |  27 ++-
 Documentation/netlink/specs/tcp_metrics.yaml  |   8 +-
 Documentation/netlink/specs/team.yaml         |  16 +-
 26 files changed, 440 insertions(+), 418 deletions(-)

-- 
2.49.0


