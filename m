Return-Path: <bpf+bounces-60174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E30AD3878
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6A61899E9C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B282D4B6A;
	Tue, 10 Jun 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilTz2dNO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB932D29CA;
	Tue, 10 Jun 2025 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560405; cv=none; b=gsI1WB8mu7B3rujRBx95cyU/7T1TN4oQzLgiPadcciHFPK/ly0/pusAS75+LyC0uAFBkBjtLZoud8KUjiORu9h480uYQzh/5l8DJvcsg5vzDgrFKy8g2vE3QLaSWSgOsYBtc0hDHR1Qw5pSJyMRb9/KIPYGGfhGJ96IVWc0FHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560405; c=relaxed/simple;
	bh=qvyEPAkyWJd6rHjRn0z/FwtBgMu9LAoPjfCs2Mf3FUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJQFzuVuej5Pa8+HdZEAiwTjrnzo6sOhsVbGIUDQiwkeiYeeoY0QzlvVfLAOjfqEXlylXUWQb9acu6DptoBuz5p+K/I7KELVwx8nPvvX3uH/+I2fvQD5DxuNM3y5/uya72uPVzHoP82spoeQduRULhuibVp0n8E8H1vC4lUks34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilTz2dNO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-453066fad06so19537305e9.2;
        Tue, 10 Jun 2025 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560399; x=1750165199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iu3PbwwmtWchyg6RYjBHJGfsO07wYeeW8b2uqF9XL6c=;
        b=ilTz2dNONUYbU5LBjbnpJXrpGxVjh6WuCWSBQ+rQdFmm1KbHhh/TPuBvtJEioyOl9L
         4UACqURD/Ff+fNc6BWE9BQNYy2IvN/SNdrW+v2FS6XpY6PelLLgiVAL7GqwMp3H7ceau
         lTRAuQXSOgf5t4WFdysC3L/hciwaBh3+FSNiWvjJQjJXfVAWGb0I9XqzFWHhILm524xD
         Xft5S+rYU41ykvFr3opqhBzn/yGB9KCq3tVu+SkoP9rVLWfLLHCY2iOWt5AwCjYIkIyS
         XMttoLueIJdt30bA0UHkfklIVZvH0MJLy4CxQxVd7hF6CmdB0NKUwL8mZQWhO4Wih5uK
         6l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560399; x=1750165199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iu3PbwwmtWchyg6RYjBHJGfsO07wYeeW8b2uqF9XL6c=;
        b=n0jeTO6dnrceev7gnR2ZKtXtwlQeJJtl9G6MDxcV65ZcR+UHI2JbDP9p9JB6m7Q50U
         eOq4nGgy3WFNsRRTDZB0wDUcH8CkS2/TcLb+fjoNZur1sqoSbkuEs0hXEOsibcXMeWm9
         +mUia7wkDjypUq/I6TUtgul63ztCt59ijEennUuGPZ4EI7xA+tPw9ljAL89X2Coetaao
         KmIw4NbSeasElUdg75xMdu7FBzX47+xv/yUCG4uSbpuBmswm9w87qYD/PnWhQqA2xAca
         4PeDWj61eFigI5aNaSG46ujnXQeVgaiZz5tJ+/Xzaq/AbCkw7qYvFWAwr+xax2MOfDO8
         vimg==
X-Forwarded-Encrypted: i=1; AJvYcCXhUg7TOIKeismlvpIvG+Vtz3yppwupALWkufWDwKBPpBx/Jyfw/gJRxI5eq78OIGqYhgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknM4fCD/9qPKM4Y4t9iIeyhuTY7v2WN8tXYkCkkvVx6JQPW1E
	hA3/dc1U2wIStzqrCQpXYvtt3/IbVZ0632+thq4zWnclZURSgzQOtyVY11Hmjw==
X-Gm-Gg: ASbGncuptrpKMfL0s/LQ4qvyoMcqY2aG43rS2xPyR1LCtGfMmVHK1jmfbxwFe48OLPb
	2xG4KOJvNoMtJ/gTjvIIzUZ2OOExZ35KdIMXjbmu9gV21uTNMjfvWPtOarU2UQJv18XElEbk1Z5
	UxijJSf3SY9md2jfNR9EAWYIMc2S5dlQxmsHLtC58wrMBB5Pu5rc5Q2DJcm/9UIWQLHj5L8ZboZ
	4Q+/cv+PDv9/6gFGLG3pjHZv0e0YXIP18RTjSUrvZeuWoRp5jjsdDk+4V1CeDagu2pT30YyGFnX
	XgrmbCkXT91uCbp6hcKUuXTaKktbj7t6s6U4xIeigXkD188dQpPZngDUuGmCMMO3NOAdYT2B1h0
	iAVdeMB0tZTaeMkg=
X-Google-Smtp-Source: AGHT+IGGkr8oa6ZsHhmx6lWte9l4cfXLEUazDaitFApXsLrOxgvzM8VGBkVx/8b00HY09I8vvK4W+Q==
X-Received: by 2002:a05:600c:3f12:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-452014d4870mr138631735e9.28.1749560398483;
        Tue, 10 Jun 2025 05:59:58 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.05.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:59:57 -0700 (PDT)
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
Subject: [PATCH net-next v1 2/7] netlink: specs: clean up spaces in brackets
Date: Tue, 10 Jun 2025 13:59:39 +0100
Message-ID: <20250610125944.85265-3-donald.hunter@gmail.com>
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

Clean up all space inside brackets errors reported by yamllint in
the netlink specs:

    error    too many spaces inside brackets  (brackets)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/devlink.yaml     | 182 +++++++++----------
 Documentation/netlink/specs/dpll.yaml        |  12 +-
 Documentation/netlink/specs/ethtool.yaml     |   8 +-
 Documentation/netlink/specs/fou.yaml         |  12 +-
 Documentation/netlink/specs/handshake.yaml   |   8 +-
 Documentation/netlink/specs/lockd.yaml       |   2 +-
 Documentation/netlink/specs/mptcp_pm.yaml    |  40 ++--
 Documentation/netlink/specs/net_shaper.yaml  |   6 +-
 Documentation/netlink/specs/netdev.yaml      |  10 +-
 Documentation/netlink/specs/nfsd.yaml        |   8 +-
 Documentation/netlink/specs/nlctrl.yaml      |   4 +-
 Documentation/netlink/specs/ovpn.yaml        |  20 +-
 Documentation/netlink/specs/ovs_vport.yaml   |   2 +-
 Documentation/netlink/specs/tcp_metrics.yaml |   6 +-
 Documentation/netlink/specs/team.yaml        |  14 +-
 15 files changed, 167 insertions(+), 167 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index b76b162ce607..c3534e7e063e 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1257,7 +1257,7 @@ operations:
       name: get
       doc: Get devlink instances.
       attribute-set: devlink
-      dont-validate: [ strict, dump ]
+      dont-validate: [strict, dump]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1280,7 +1280,7 @@ operations:
       name: port-get
       doc: Get devlink port instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1304,8 +1304,8 @@ operations:
       name: port-set
       doc: Set devlink port instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1321,8 +1321,8 @@ operations:
       name: port-new
       doc: Create devlink port instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1343,8 +1343,8 @@ operations:
       name: port-del
       doc: Delete devlink port instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1355,8 +1355,8 @@ operations:
       name: port-split
       doc: Split devlink port instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1371,8 +1371,8 @@ operations:
       name: port-unsplit
       doc: Unplit devlink port instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1383,7 +1383,7 @@ operations:
       name: sb-get
       doc: Get shared buffer instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1405,7 +1405,7 @@ operations:
       name: sb-pool-get
       doc: Get shared buffer pool instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1428,8 +1428,8 @@ operations:
       name: sb-pool-set
       doc: Set shared buffer pool instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1446,7 +1446,7 @@ operations:
       name: sb-port-pool-get
       doc: Get shared buffer port-pool combinations and threshold.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1470,8 +1470,8 @@ operations:
       name: sb-port-pool-set
       doc: Set shared buffer port-pool combinations and threshold.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1488,7 +1488,7 @@ operations:
       name: sb-tc-pool-bind-get
       doc: Get shared buffer port-TC to pool bindings and threshold.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1513,8 +1513,8 @@ operations:
       name: sb-tc-pool-bind-set
       doc: Set shared buffer port-TC to pool bindings and threshold.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1533,8 +1533,8 @@ operations:
       name: sb-occ-snapshot
       doc: Take occupancy snapshot of shared buffer.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1549,8 +1549,8 @@ operations:
       name: sb-occ-max-clear
       doc: Clear occupancy watermarks of shared buffer.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1564,8 +1564,8 @@ operations:
       name: eswitch-get
       doc: Get eswitch attributes.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1584,8 +1584,8 @@ operations:
       name: eswitch-set
       doc: Set eswitch attributes.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1596,7 +1596,7 @@ operations:
       name: dpipe-table-get
       doc: Get dpipe table attributes.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1616,7 +1616,7 @@ operations:
       name: dpipe-entries-get
       doc: Get dpipe entries attributes.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1635,7 +1635,7 @@ operations:
       name: dpipe-headers-get
       doc: Get dpipe headers attributes.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1653,8 +1653,8 @@ operations:
       name: dpipe-table-counters-set
       doc: Set dpipe counter attributes.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1669,8 +1669,8 @@ operations:
       name: resource-set
       doc: Set resource attributes.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1685,7 +1685,7 @@ operations:
       name: resource-dump
       doc: Get resource attributes.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1704,8 +1704,8 @@ operations:
       name: reload
       doc: Reload devlink.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-dev-lock
         post: devlink-nl-post-doit-dev-lock
@@ -1728,7 +1728,7 @@ operations:
       name: param-get
       doc: Get param instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1748,8 +1748,8 @@ operations:
       name: param-set
       doc: Set param instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1766,7 +1766,7 @@ operations:
       name: region-get
       doc: Get region instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -1789,8 +1789,8 @@ operations:
       name: region-new
       doc: Create region snapshot.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -1810,8 +1810,8 @@ operations:
       name: region-del
       doc: Delete region snapshot.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -1822,8 +1822,8 @@ operations:
       name: region-read
       doc: Read region data.
       attribute-set: devlink
-      dont-validate: [ dump-strict ]
-      flags: [ admin-perm ]
+      dont-validate: [dump-strict]
+      flags: [admin-perm]
       dump:
         request:
           attributes:
@@ -1847,7 +1847,7 @@ operations:
       name: port-param-get
       doc: Get port param instances.
       attribute-set: devlink
-      dont-validate: [ strict, dump-strict ]
+      dont-validate: [strict, dump-strict]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1863,8 +1863,8 @@ operations:
       name: port-param-set
       doc: Set port param instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port
         post: devlink-nl-post-doit
@@ -1875,7 +1875,7 @@ operations:
       name: info-get
       doc: Get device information, like driver name, hardware and firmware versions etc.
       attribute-set: devlink
-      dont-validate: [ strict, dump ]
+      dont-validate: [strict, dump]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -1900,7 +1900,7 @@ operations:
       name: health-reporter-get
       doc: Get health reporter instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -1921,8 +1921,8 @@ operations:
       name: health-reporter-set
       doc: Set health reporter instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -1940,8 +1940,8 @@ operations:
       name: health-reporter-recover
       doc: Recover health reporter instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -1952,8 +1952,8 @@ operations:
       name: health-reporter-diagnose
       doc: Diagnose health reporter instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -1964,8 +1964,8 @@ operations:
       name: health-reporter-dump-get
       doc: Dump health reporter instances.
       attribute-set: devlink
-      dont-validate: [ dump-strict ]
-      flags: [ admin-perm ]
+      dont-validate: [dump-strict]
+      flags: [admin-perm]
       dump:
         request:
           attributes: *health-reporter-id-attrs
@@ -1978,8 +1978,8 @@ operations:
       name: health-reporter-dump-clear
       doc: Clear dump of health reporter instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -1990,8 +1990,8 @@ operations:
       name: flash-update
       doc: Flash update devlink instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2007,7 +2007,7 @@ operations:
       name: trap-get
       doc: Get trap instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2029,8 +2029,8 @@ operations:
       name: trap-set
       doc: Set trap instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2045,7 +2045,7 @@ operations:
       name: trap-group-get
       doc: Get trap group instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2067,8 +2067,8 @@ operations:
       name: trap-group-set
       doc: Set trap group instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2084,7 +2084,7 @@ operations:
       name: trap-policer-get
       doc: Get trap policer instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2106,8 +2106,8 @@ operations:
       name: trap-policer-set
       doc: Get trap policer instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2123,8 +2123,8 @@ operations:
       name: health-reporter-test
       doc: Test health reporter instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit-port-optional
         post: devlink-nl-post-doit
@@ -2136,7 +2136,7 @@ operations:
       name: rate-get
       doc: Get rate instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2159,8 +2159,8 @@ operations:
       name: rate-set
       doc: Set rate instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2179,8 +2179,8 @@ operations:
       name: rate-new
       doc: Create rate instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2199,8 +2199,8 @@ operations:
       name: rate-del
       doc: Delete rate instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2214,7 +2214,7 @@ operations:
       name: linecard-get
       doc: Get line card instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2236,8 +2236,8 @@ operations:
       name: linecard-set
       doc: Set line card instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2252,7 +2252,7 @@ operations:
       name: selftests-get
       doc: Get device selftest instances.
       attribute-set: devlink
-      dont-validate: [ strict, dump ]
+      dont-validate: [strict, dump]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
@@ -2269,8 +2269,8 @@ operations:
       name: selftests-run
       doc: Run device selftest instances.
       attribute-set: devlink
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
       do:
         pre: devlink-nl-pre-doit
         post: devlink-nl-post-doit
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 0865692bc9ca..115d1a8f50bd 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -445,7 +445,7 @@ operations:
       doc: |
         Get id of dpll device that matches given attributes
       attribute-set: dpll
-      flags: [ admin-perm ]
+      flags: [admin-perm]
 
       do:
         pre: dpll-lock-doit
@@ -464,7 +464,7 @@ operations:
       doc: |
         Get list of DPLL devices (dump) or attributes of a single dpll device
       attribute-set: dpll
-      flags: [ admin-perm ]
+      flags: [admin-perm]
 
       do:
         pre: dpll-pre-doit
@@ -491,7 +491,7 @@ operations:
       name: device-set
       doc: Set attributes for a DPLL device
       attribute-set: dpll
-      flags: [ admin-perm ]
+      flags: [admin-perm]
 
       do:
         pre: dpll-pre-doit
@@ -519,7 +519,7 @@ operations:
       doc: |
         Get id of a pin that matches given attributes
       attribute-set: pin
-      flags: [ admin-perm ]
+      flags: [admin-perm]
 
       do:
         pre: dpll-lock-doit
@@ -547,7 +547,7 @@ operations:
           a given dpll device
         - do request with target dpll and target pin - single pin attributes
       attribute-set: pin
-      flags: [ admin-perm ]
+      flags: [admin-perm]
 
       do:
         pre: dpll-pin-pre-doit
@@ -585,7 +585,7 @@ operations:
       name: pin-set
       doc: Set attributes of a target pin
       attribute-set: pin
-      flags: [ admin-perm ]
+      flags: [admin-perm]
 
       do:
         pre: dpll-pin-pre-doit
diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 90453ab0e0fa..dc7f8e657967 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -12,7 +12,7 @@ definitions:
     name: udp-tunnel-type
     enum-name:
     type: enum
-    entries: [ vxlan, geneve, vxlan-gpe ]
+    entries: [vxlan, geneve, vxlan-gpe]
     enum-cnt-name: __ethtool-udp-tunnel-type-cnt
     render-max: true
   -
@@ -93,11 +93,11 @@ definitions:
     header: linux/ethtool.h
     type: enum
     name-prefix: phy-upstream
-    entries: [ mac, phy ]
+    entries: [mac, phy]
   -
     name: tcp-data-split
     type: enum
-    entries: [ unknown, disabled, enabled ]
+    entries: [unknown, disabled, enabled]
   -
     name: hwtstamp-source
     doc: Source of the hardware timestamp
@@ -1224,7 +1224,7 @@ attribute-sets:
       -
         name: stat
         type: u64
-        type-value: [ id ]
+        type-value: [id]
       -
         name: hist-rx
         type: nest
diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 944463fcae91..46b1fb38ec50 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -18,7 +18,7 @@ definitions:
     name: encap_type
     name-prefix: fou-encap-
     enum-name:
-    entries: [ unspec, direct, gue ]
+    entries: [unspec, direct, gue]
 
 attribute-sets:
   -
@@ -81,8 +81,8 @@ operations:
       doc: Add port.
       attribute-set: fou
 
-      dont-validate: [ strict, dump ]
-      flags: [ admin-perm ]
+      dont-validate: [strict, dump]
+      flags: [admin-perm]
 
       do:
         request: &all_attrs
@@ -103,8 +103,8 @@ operations:
       doc: Delete port.
       attribute-set: fou
 
-      dont-validate: [ strict, dump ]
-      flags: [ admin-perm ]
+      dont-validate: [strict, dump]
+      flags: [admin-perm]
 
       do:
         request: &select_attrs
@@ -122,7 +122,7 @@ operations:
       name: get
       doc: Get tunnel info.
       attribute-set: fou
-      dont-validate: [ strict, dump ]
+      dont-validate: [strict, dump]
 
       do:
         request: *select_attrs
diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 21e0381e878c..39ed1661c7f1 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -16,17 +16,17 @@ definitions:
     type: enum
     name: handler-class
     value-start: 0
-    entries: [ none, tlshd, max ]
+    entries: [none, tlshd, max]
   -
     type: enum
     name: msg-type
     value-start: 0
-    entries: [ unspec, clienthello, serverhello ]
+    entries: [unspec, clienthello, serverhello]
   -
     type: enum
     name: auth
     value-start: 0
-    entries: [ unspec, unauth, psk, x509 ]
+    entries: [unspec, unauth, psk, x509]
 
 attribute-sets:
   -
@@ -95,7 +95,7 @@ operations:
       name: accept
       doc: Handler retrieves next queued handshake request
       attribute-set: accept
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       do:
         request:
           attributes:
diff --git a/Documentation/netlink/specs/lockd.yaml b/Documentation/netlink/specs/lockd.yaml
index f99244a7dc41..3dc4ac1a051b 100644
--- a/Documentation/netlink/specs/lockd.yaml
+++ b/Documentation/netlink/specs/lockd.yaml
@@ -26,7 +26,7 @@ operations:
       name: server-set
       doc: set the lockd server parameters
       attribute-set: server
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       do:
         request:
           attributes:
diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index fd2ea7f90441..1d47ad86d619 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -277,8 +277,8 @@ operations:
       name: add-addr
       doc: Add endpoint
       attribute-set: endpoint
-      dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
+      dont-validate: [strict]
+      flags: [uns-admin-perm]
       do: &add-addr-attrs
         request:
           attributes:
@@ -287,14 +287,14 @@ operations:
       name: del-addr
       doc: Delete endpoint
       attribute-set: endpoint
-      dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
+      dont-validate: [strict]
+      flags: [uns-admin-perm]
       do: *add-addr-attrs
     -
       name: get-addr
       doc: Get endpoint information
       attribute-set: attr
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do: &get-addr-attrs
         request:
           attributes:
@@ -311,15 +311,15 @@ operations:
       name: flush-addrs
       doc: Flush addresses
       attribute-set: endpoint
-      dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
+      dont-validate: [strict]
+      flags: [uns-admin-perm]
       do: *add-addr-attrs
     -
       name: set-limits
       doc: Set protocol limits
       attribute-set: attr
-      dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
+      dont-validate: [strict]
+      flags: [uns-admin-perm]
       do: &mptcp-limits
         request:
           attributes:
@@ -329,7 +329,7 @@ operations:
       name: get-limits
       doc: Get protocol limits
       attribute-set: attr
-      dont-validate: [ strict ]
+      dont-validate: [strict]
       do: &mptcp-get-limits
         request:
            attributes:
@@ -343,8 +343,8 @@ operations:
       name: set-flags
       doc: Change endpoint flags
       attribute-set: attr
-      dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
+      dont-validate: [strict]
+      flags: [uns-admin-perm]
       do: &mptcp-set-flags
         request:
           attributes:
@@ -355,8 +355,8 @@ operations:
       name: announce
       doc: Announce new address
       attribute-set: attr
-      dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
+      dont-validate: [strict]
+      flags: [uns-admin-perm]
       do: &announce-add
         request:
           attributes:
@@ -366,8 +366,8 @@ operations:
       name: remove
       doc: Announce removal
       attribute-set: attr
-      dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
+      dont-validate: [strict]
+      flags: [uns-admin-perm]
       do:
         request:
          attributes:
@@ -377,8 +377,8 @@ operations:
       name: subflow-create
       doc: Create subflow
       attribute-set: attr
-      dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
+      dont-validate: [strict]
+      flags: [uns-admin-perm]
       do: &sf-create
         request:
           attributes:
@@ -389,6 +389,6 @@ operations:
       name: subflow-destroy
       doc: Destroy subflow
       attribute-set: attr
-      dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
+      dont-validate: [strict]
+      flags: [uns-admin-perm]
       do: *sf-create
diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
index 4fb9c7b6ac19..0b1b54be48f9 100644
--- a/Documentation/netlink/specs/net_shaper.yaml
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -244,7 +244,7 @@ operations:
         The set operation can't be used to create a @node scope shaper,
         use the @group operation instead.
       attribute-set: net-shaper
-      flags: [ admin-perm ]
+      flags: [admin-perm]
 
       do:
         pre: net-shaper-nl-pre-doit
@@ -275,7 +275,7 @@ operations:
         node with infinite bandwidth. The queue's implicit node
         feeds an implicit RR node at the root of the hierarchy.
       attribute-set: net-shaper
-      flags: [ admin-perm ]
+      flags: [admin-perm]
 
       do:
         pre: net-shaper-nl-pre-doit
@@ -306,7 +306,7 @@ operations:
         full identifier, comprising @binding and @handle, is provided
         as the reply.
       attribute-set: net-shaper
-      flags: [ admin-perm ]
+      flags: [admin-perm]
 
       do:
         pre: net-shaper-nl-pre-doit
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index fda8a9667bf3..0ca6c28321c7 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -77,11 +77,11 @@ definitions:
   -
     name: queue-type
     type: enum
-    entries: [ rx, tx ]
+    entries: [rx, tx]
   -
     name: qstats-scope
     type: flags
-    entries: [ queue ]
+    entries: [queue]
 
 attribute-sets:
   -
@@ -721,7 +721,7 @@ operations:
       name: bind-rx
       doc: Bind dmabuf to netdev
       attribute-set: dmabuf
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       do:
         request:
           attributes:
@@ -735,7 +735,7 @@ operations:
       name: napi-set
       doc: Set configurable NAPI instance settings.
       attribute-set: napi
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       do:
         request:
           attributes:
@@ -757,7 +757,7 @@ operations:
             - id
 
 kernel-family:
-  headers: [ "net/netdev_netlink.h"]
+  headers: ["net/netdev_netlink.h"]
   sock-priv: struct netdev_nl_sock
 
 mcast-groups:
diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index fcca5a06ddf5..4cb55864f92b 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -151,7 +151,7 @@ operations:
       name: threads-set
       doc: set the number of running threads
       attribute-set: server
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       do:
         request:
           attributes:
@@ -174,7 +174,7 @@ operations:
       name: version-set
       doc: set nfs enabled versions
       attribute-set: server-proto
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       do:
         request:
           attributes:
@@ -191,7 +191,7 @@ operations:
       name: listener-set
       doc: set nfs running sockets
       attribute-set: server-sock
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       do:
         request:
           attributes:
@@ -208,7 +208,7 @@ operations:
       name: pool-mode-set
       doc: set the current server pool-mode
       attribute-set: pool-mode
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       do:
         request:
           attributes:
diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
index e9f5328a688d..8b4472a6aa36 100644
--- a/Documentation/netlink/specs/nlctrl.yaml
+++ b/Documentation/netlink/specs/nlctrl.yaml
@@ -76,12 +76,12 @@ attribute-sets:
       -
         name: policy
         type: nest-type-value
-        type-value: [ policy-id, attr-id ]
+        type-value: [policy-id, attr-id]
         nested-attributes: policy-attrs
       -
         name: op-policy
         type: nest-type-value
-        type-value: [ op-id ]
+        type-value: [op-id]
         nested-attributes: op-policy-attrs
       -
         name: op
diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index b3a5bd00b8a5..79c37d5dd1a5 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -19,7 +19,7 @@ definitions:
   -
     type: enum
     name: cipher-alg
-    entries: [ none, aes-gcm, chacha20-poly1305 ]
+    entries: [none, aes-gcm, chacha20-poly1305]
   -
     type: enum
     name: del-peer-reason
@@ -32,7 +32,7 @@ definitions:
   -
     type: enum
     name: key-slot
-    entries: [ primary, secondary ]
+    entries: [primary, secondary]
 
 attribute-sets:
   -
@@ -241,7 +241,7 @@ operations:
     -
       name: peer-new
       attribute-set: ovpn
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       doc: Add a remote peer
       do:
         pre: ovpn-nl-pre-doit
@@ -253,7 +253,7 @@ operations:
     -
       name: peer-set
       attribute-set: ovpn
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       doc: modify a remote peer
       do:
         pre: ovpn-nl-pre-doit
@@ -265,7 +265,7 @@ operations:
     -
       name: peer-get
       attribute-set: ovpn
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       doc: Retrieve data about existing remote peers (or a specific one)
       do:
         pre: ovpn-nl-pre-doit
@@ -287,7 +287,7 @@ operations:
     -
       name: peer-del
       attribute-set: ovpn
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       doc: Delete existing remote peer
       do:
         pre: ovpn-nl-pre-doit
@@ -305,7 +305,7 @@ operations:
     -
       name: key-new
       attribute-set: ovpn
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       doc: Add a cipher key for a specific peer
       do:
         pre: ovpn-nl-pre-doit
@@ -317,7 +317,7 @@ operations:
     -
       name: key-get
       attribute-set: ovpn
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       doc: Retrieve non-sensitive data about peer key and cipher
       do:
         pre: ovpn-nl-pre-doit
@@ -332,7 +332,7 @@ operations:
     -
       name: key-swap
       attribute-set: ovpn
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       doc: Swap primary and secondary session keys for a specific peer
       do:
         pre: ovpn-nl-pre-doit
@@ -351,7 +351,7 @@ operations:
     -
       name: key-del
       attribute-set: ovpn
-      flags: [ admin-perm ]
+      flags: [admin-perm]
       doc: Delete cipher key for a specific peer
       do:
         pre: ovpn-nl-pre-doit
diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index e254537f6192..da47e65fd574 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -21,7 +21,7 @@ definitions:
     type: enum
     enum-name: ovs-vport-type
     name-prefix: ovs-vport-type-
-    entries: [ unspec, netdev, internal, gre, vxlan, geneve ]
+    entries: [unspec, netdev, internal, gre, vxlan, geneve]
   -
     name: ovs-vport-stats
     type: struct
diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
index 2e57e4c19e58..13144aeed31a 100644
--- a/Documentation/netlink/specs/tcp_metrics.yaml
+++ b/Documentation/netlink/specs/tcp_metrics.yaml
@@ -133,7 +133,7 @@ operations:
       doc: Retrieve metrics.
       attribute-set: tcp-metrics
 
-      dont-validate: [ strict, dump ]
+      dont-validate: [strict, dump]
 
       do:
         request: &sel_attrs
@@ -162,8 +162,8 @@ operations:
       doc: Delete metrics.
       attribute-set: tcp-metrics
 
-      dont-validate: [ strict, dump ]
-      flags: [ admin-perm ]
+      dont-validate: [strict, dump]
+      flags: [admin-perm]
 
       do:
         request: *sel_attrs
diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
index 83a9d088594e..cf02d47d12a4 100644
--- a/Documentation/netlink/specs/team.yaml
+++ b/Documentation/netlink/specs/team.yaml
@@ -152,7 +152,7 @@ operations:
       doc: No operation
       value: 0
       attribute-set: team
-      dont-validate: [ strict ]
+      dont-validate: [strict]
 
       do:
         # Actually it only reply the team netlink family
@@ -164,8 +164,8 @@ operations:
       name: options-set
       doc: Set team options
       attribute-set: team
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
 
       do:
         request: &option_attrs
@@ -178,8 +178,8 @@ operations:
       name: options-get
       doc: Get team options info
       attribute-set: team
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
 
       do:
         request:
@@ -191,8 +191,8 @@ operations:
       name: port-list-get
       doc: Get team ports info
       attribute-set: team
-      dont-validate: [ strict ]
-      flags: [ admin-perm ]
+      dont-validate: [strict]
+      flags: [admin-perm]
 
       do:
         request:
-- 
2.49.0


