Return-Path: <bpf+bounces-60172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF3AD385C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D0D17EB4A
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA12D3230;
	Tue, 10 Jun 2025 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h047b/Rn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5C28E60C;
	Tue, 10 Jun 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560401; cv=none; b=rsCm0yA4u6kAYmk2vRXDNID6zrAAsdVCs/Q/auHc0WA0W1+5LQ7K0g1c+uq+LuVGFgsmPtRCNgITmFvgxvjQdt/+5SVEi4kiRzcJRmtZlqZv+aSij7UmFRc9nTlZ4GJJAoUq/MczqjB3+caVMMRSF3aV2EXGRqI1k2jk9wuGaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560401; c=relaxed/simple;
	bh=+BLFLrllz1J78kqDxqSGCpszH0IJLr1P8ZkyAohB4Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpAPsW4tFLefhpag9YB5Ba6x23oz2dqG5oKPNUN/kNyRbdwx5TYe7mT+8uwYk1Jc4o7oeIKlefWOyQlQI4UB/kUibnfm+YEHAF51ha5j9N+KawhKBb7mJncHkllxLlQ1++LMu+qZ0bV/AimRm/XrH9iETphcLdeJ++dyhSIoxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h047b/Rn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so48425475e9.3;
        Tue, 10 Jun 2025 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560397; x=1750165197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2jf0bqIzemKYIXkakyySlUtmWmhD9x5Ni3JII1U00U=;
        b=h047b/RnN6yGs0f7xVFWWkxXXMRLSL/7RfEUYQhIAfLNPOFsSQUHZQa9nQPG0I7AW4
         5A2B2S7t2pvqLFS2weMb1w2wZdrTHWCgkuBbDSUhPW13wwoREvQ8CNGtXMy5j5IPBDjz
         ngdS2DGC1g9nyuwHIZXAuHbhc9DA5Ilc1d1EB95TY4U0PDJttl5lg7a/zqMfnGdJmuy0
         lpyQSbn48n2yi0pVk+dgAUquzSIoQ10v/8St0buJ+a1lltaII5iBlHuAxsvrHUmYUnqg
         pKz42xt+Z8quh/df5Lthyn9wNm6lisiR2Rds3VZEUKWyvUJesA2khRDIODsFH0UOa75D
         YFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560397; x=1750165197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2jf0bqIzemKYIXkakyySlUtmWmhD9x5Ni3JII1U00U=;
        b=sAwPSGh6frKX662cWaUYsR4Z0fBENqR/DGmoDvLPwHEPR5j+EYtibIJ4FUvctsuCCC
         tgiIEKHuc1UDAqeLwgdpySGyJ3FbFIiRXXpyH/5/NEp06aL0nsAblumidVchuyLtvPAv
         YW7yf9zITr+3Np+5FTezGT1i/1wWW/UELM9h8LAo3jT48es+l5Ad3x/LRBPvUwswZ5/Q
         897iw6jL98Rq9Pj78zp2DbpijzJaI2IxejIQJCvQkBkeBUcWzY7E6guaMyjhThGKeb8u
         YVpmpxJZIqw1xdiFQKu35weUb5lAJweyjRCgSr1jSg/St4OcR7RVSrvWR/wNOopZBNcS
         sTCw==
X-Forwarded-Encrypted: i=1; AJvYcCUsQ9rMpdHQkyY45fp7eJ1+84z8Mn8ZKwNZQHzlRAWoTcB66d/qxAAbA/enfG7x+IIZ5GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQTtYLqlM120fZAxrTidxcimt50lJ72akmQjlABT+YcNt4a93
	tTRw/ra4oeTqRulLuqHfFNGxuYWHnhkXg2kZnlG6WSTb5l39psh4uJcwQ37g7A==
X-Gm-Gg: ASbGncv+ZiUxNtReN2IJiZNQt3W8HZlv782f162kwdIZrBBZv1jdjpWXXJ+cr6EXhCA
	acPDXGz3GKdf8g3OJqFazHnE6txy8fej1C+iWPixCVWrT6OOAHMwNdRuqTnMcVmEYXIamiYbqI6
	+qujfx5gqAb/lHuagkIbxBGx8yIJ8kx60SLB9KmBRvrUz3oYhZgD8tl/1/wK3DHNbvRA8xn1X9k
	2rkHDz69vZijCnjMB/5qexO/NdwENGuJzqfRbzvE/KGVmbD372yHLOs2uedYSacbMkjOyBK+r6D
	PFMWizKp1OoYDWNPDp6NG6ntO/Z+dfBf6eQp8xuLxs3nDndvfr4kvtUIvJ7u3abJLzIZpEakxHI
	QdHwK
X-Google-Smtp-Source: AGHT+IHxaPUkSpK4p/0zzDJa+3SZDES6FfsGUU/vr0VQymRd3Lgr3mZZ1qpeUaWHuy3FZI13xT7R4g==
X-Received: by 2002:a7b:cc07:0:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-452015d90a2mr133772685e9.10.1749560397077;
        Tue, 10 Jun 2025 05:59:57 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.05.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:59:56 -0700 (PDT)
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
Subject: [PATCH net-next v1 1/7] netlink: specs: add doc start markers to yaml
Date: Tue, 10 Jun 2025 13:59:38 +0100
Message-ID: <20250610125944.85265-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125944.85265-1-donald.hunter@gmail.com>
References: <20250610125944.85265-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up all document-start warnings reported by yamllint in the
netlink specs:

    warning  missing document start "---"  (document-start)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/conntrack.yaml    | 2 +-
 Documentation/netlink/specs/devlink.yaml      | 2 +-
 Documentation/netlink/specs/dpll.yaml         | 2 +-
 Documentation/netlink/specs/ethtool.yaml      | 2 +-
 Documentation/netlink/specs/fou.yaml          | 2 +-
 Documentation/netlink/specs/handshake.yaml    | 2 +-
 Documentation/netlink/specs/lockd.yaml        | 2 +-
 Documentation/netlink/specs/mptcp_pm.yaml     | 2 +-
 Documentation/netlink/specs/net_shaper.yaml   | 1 +
 Documentation/netlink/specs/netdev.yaml       | 2 +-
 Documentation/netlink/specs/nfsd.yaml         | 2 +-
 Documentation/netlink/specs/nftables.yaml     | 2 +-
 Documentation/netlink/specs/nl80211.yaml      | 2 +-
 Documentation/netlink/specs/nlctrl.yaml       | 2 +-
 Documentation/netlink/specs/ovpn.yaml         | 2 +-
 Documentation/netlink/specs/ovs_datapath.yaml | 2 +-
 Documentation/netlink/specs/ovs_flow.yaml     | 2 +-
 Documentation/netlink/specs/ovs_vport.yaml    | 2 +-
 Documentation/netlink/specs/rt-addr.yaml      | 2 +-
 Documentation/netlink/specs/rt-link.yaml      | 2 +-
 Documentation/netlink/specs/rt-neigh.yaml     | 2 +-
 Documentation/netlink/specs/rt-route.yaml     | 2 +-
 Documentation/netlink/specs/rt-rule.yaml      | 2 +-
 Documentation/netlink/specs/tc.yaml           | 2 +-
 Documentation/netlink/specs/tcp_metrics.yaml  | 2 +-
 Documentation/netlink/specs/team.yaml         | 2 +-
 26 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index 840dc4504216..e48add669b6d 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: conntrack
 protocol: netlink-raw
 protonum: 12
diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 05fee1b7fe19..b76b162ce607 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: devlink
 
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 8feefeae5376..0865692bc9ca 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: dpll
 
 doc: DPLL subsystem.
diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 9f98715a6512..90453ab0e0fa 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: ethtool
 
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 0af5ab842c04..944463fcae91 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: fou
 
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index b934cc513e3d..21e0381e878c 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -4,7 +4,7 @@
 #
 # Copyright (c) 2023, Oracle and/or its affiliates.
 #
-
+---
 name: handshake
 
 protocol: genetlink
diff --git a/Documentation/netlink/specs/lockd.yaml b/Documentation/netlink/specs/lockd.yaml
index bbd4da5fe54b..f99244a7dc41 100644
--- a/Documentation/netlink/specs/lockd.yaml
+++ b/Documentation/netlink/specs/lockd.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: lockd
 protocol: genetlink
 uapi-header: linux/lockd_netlink.h
diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index dfd017780d2f..fd2ea7f90441 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: mptcp_pm
 protocol: genetlink-legacy
 doc: Multipath TCP.
diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
index 8ebad0d02904..4fb9c7b6ac19 100644
--- a/Documentation/netlink/specs/net_shaper.yaml
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
 name: net-shaper
 
 doc: |
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index c0ef6d0d7786..fda8a9667bf3 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: netdev
 
 doc:
diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index c87658114852..fcca5a06ddf5 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: nfsd
 protocol: genetlink
 uapi-header: linux/nfsd_netlink.h
diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
index bd938bd01b6b..ed9c5cf68477 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: nftables
 protocol: netlink-raw
 protonum: 12
diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 3611b11a7d8f..8d380670ea6a 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: nl80211
 protocol: genetlink-legacy
 
diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
index a36535350bdb..e9f5328a688d 100644
--- a/Documentation/netlink/specs/nlctrl.yaml
+++ b/Documentation/netlink/specs/nlctrl.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: nlctrl
 protocol: genetlink-legacy
 uapi-header: linux/genetlink.h
diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 096c51f0c69a..b3a5bd00b8a5 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -4,7 +4,7 @@
 #
 # Copyright (c) 2024-2025, OpenVPN Inc.
 #
-
+---
 name: ovpn
 
 protocol: genetlink
diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index df6a8f94975e..0c0abf3f9f05 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: ovs_datapath
 version: 2
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 46f5d1cd8a5f..02ef3597ea94 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: ovs_flow
 version: 1
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index 306da6bb842d..e254537f6192 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: ovs_vport
 version: 2
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 4f86aa1075da..bafe3bfeabfb 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: rt-addr
 protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index b41b31eebcae..8024580c4293 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: rt-link
 protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index e9cba164e3d1..25cc2d528d2f 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: rt-neigh
 protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 800f3a823d47..9c514c543b1f 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: rt-route
 protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
diff --git a/Documentation/netlink/specs/rt-rule.yaml b/Documentation/netlink/specs/rt-rule.yaml
index 003707ca4a3e..46b1d426e7e8 100644
--- a/Documentation/netlink/specs/rt-rule.yaml
+++ b/Documentation/netlink/specs/rt-rule.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: rt-rule
 protocol: netlink-raw
 uapi-header: linux/fib_rules.h
diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index cb7ea7d62e56..52f62ab11136 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: tc
 protocol: netlink-raw
 uapi-header: linux/pkt_cls.h
diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
index 1bd94f43e526..2e57e4c19e58 100644
--- a/Documentation/netlink/specs/tcp_metrics.yaml
+++ b/Documentation/netlink/specs/tcp_metrics.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: tcp_metrics
 
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
index c13529e011c9..83a9d088594e 100644
--- a/Documentation/netlink/specs/team.yaml
+++ b/Documentation/netlink/specs/team.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: team
 
 protocol: genetlink-legacy
-- 
2.49.0


