Return-Path: <bpf+bounces-60177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7562AD3884
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63004189BFE8
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C94D19CD0E;
	Tue, 10 Jun 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcI7QWFJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80828E60C;
	Tue, 10 Jun 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560407; cv=none; b=gCb8tSXUGBlyHC6m8y0H2Xaqiyi1aGaSZsjxH4D7T1XX/XBgfBCAMSBDm8mh5o6cejxEaJbQ8UxUzeUYnbJ/MISOkrapcCWr1CSW4Z6NLuWSnlCZ83mNYC9DkyuRqTSjPOzogvaxLD3APVLf1l7h/0RU2Oi7PJToX5WEjIERWls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560407; c=relaxed/simple;
	bh=WV3qyljp1FFqBKDUIWxhAuvK1rhPdsEMfAJfaDUqOzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QH/xHIRpKk7n3DvYuUoZn2hnuSmzWYQuKgUBEJ1iERyS95tRpradPbYdb0+H2mTuFBmXtlDHP1e4vXhn2PnafNbSdA2pH9kSm7pkg2J/kAW5Y9kxTmpp+qPXgzrW0tB48TxMH5Bh/NAFEENKe7+D5N/69HNu7JS32PN5IAT/CWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcI7QWFJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so64943115e9.1;
        Tue, 10 Jun 2025 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560403; x=1750165203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xODQOsY7Ch1/AVsy1j3cRm2HSOMfXVPATamQo+cFfTI=;
        b=LcI7QWFJFBuf1myVCJvQTSjKC/C6bx+HnnWqXxrk0AiArrhKyc6FNcFt3FdaEON4Sw
         oeoxfEpTzkmD1UXBB/HVrhksQZaYR+uugyHt7vrZX72vy8iJh674pw73Hwxu7ZwPMwcD
         1W6gaVexUMG8EpaR99WzBXry9NYHhq/EIMF7CeTaO/XB5uh+sLQY5eInkUXGQ7TaFx1D
         VH39n8K+/mZe+E71oN0Oe8WgOWT5YRFHiMXgpjT80Mk2GesMJNd/59l1gXqqRLoXbSoS
         opEti8ODHNqtvTo5ox9TwXjsZcF585MZthlwXq3vFijlPWY5GiUFpjuSXBDNnmkoeHtP
         7/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560403; x=1750165203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xODQOsY7Ch1/AVsy1j3cRm2HSOMfXVPATamQo+cFfTI=;
        b=RB2dZDAkC6tvwcjwtIJyfjf4INopqbyjTiVXDM5C1DXhT/vAsXrgtOW8TihBeTq2c7
         w9zxUQlR9UXF3jKbiouxrPHeMJKSlnLGHL5uIUt1rVHfj5R62dtArEfkQaPmsmeiGez4
         JylTBoL+IMNhUNcU3zfkF9lnikCAvvVT9j49bkT9LB29YIupD1mft39vEYa2iiaV8jyn
         3QyOWpp4VDJwlldvmDLqX3ELjw+QR/0RyzVq4M7RBpf4Kwsak3JOfs/R5z4l0jpwsP2P
         KnRMB81ow0d9u/WAVw6f4pvN/HjtVJ1yWN2/I8fDml6cBsrKzM38gXy0v/v1htk5N99R
         CJWg==
X-Forwarded-Encrypted: i=1; AJvYcCXlv+nfnhuZwWRg/FjHFzr5weRwAoa2/OZ3aMAyzJqw7jKe9tyux2/scwP1YuMVGAEp/Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywIpJxPdokqDsXQIW5pYThm7wxyUTSEuxMIgxviKnTwj2hqy2B
	/G4/bkT7HdxcKp/pcZjAR0BcbhbGhKp81cveze+e9WSYoyQLcl7u3YiWrKS7GQ==
X-Gm-Gg: ASbGncsKF14lXkwY7eTI6awSh6WdJx6nAAPiapfvr7Hhd6FtKuucu6Q/tc59FMsxyHs
	Vbh2oV+8Dd6FYrQ+AqxW/EgAxJ6T2MIBKOQ+ZH9CJcNVK9m9MyODJNjgapcKkA4ql9Z6Mh6Yskh
	B3wJ2rkzCUDSHHAlaY3jUiJzt8hv/hme3ZMCPe0JWLWdE7jDm+eqJGdwI+zzR6KsKcv9BVm1+9l
	3cR/qOa72clLcz6mccAx79qLLz60sXLjE7J6pZr9RhFuB2iJAjnJXyzIf5uIq72gpfWzLaMo/gZ
	i6lHQA2iOooudY31ch1azng0PM1+p4JMedehNWpk+wzi3E+pfw7aIPllyog5pxOm4uoLsfmxYrk
	px+he
X-Google-Smtp-Source: AGHT+IH50xxd8Tal3uz5MUIZzvNBMrNkJnkjBymLkRdNTd1KaJ0XksyIHVV56Y71+wJZ8TmiEO8msg==
X-Received: by 2002:a05:600c:4ecf:b0:450:d61f:dd45 with SMTP id 5b1f17b1804b1-4520134088bmr168642505e9.4.1749560403134;
        Tue, 10 Jun 2025 06:00:03 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.06.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:00:02 -0700 (PDT)
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
Subject: [PATCH net-next v1 6/7] netlink: specs: wrap long doc lines (>80 chars)
Date: Tue, 10 Jun 2025 13:59:43 +0100
Message-ID: <20250610125944.85265-7-donald.hunter@gmail.com>
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

Clean up all line too long errors reported by yamllint in the netlink
specs, e.g.

    error    line too long (97 > 80 characters)  (line-length)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/devlink.yaml  |  4 +++-
 Documentation/netlink/specs/ethtool.yaml  |  4 +++-
 Documentation/netlink/specs/mptcp_pm.yaml |  4 ++--
 Documentation/netlink/specs/netdev.yaml   | 25 +++++++++++++----------
 Documentation/netlink/specs/nftables.yaml | 14 +++++++++----
 Documentation/netlink/specs/nl80211.yaml  |  5 +++--
 Documentation/netlink/specs/ovpn.yaml     |  4 ++--
 Documentation/netlink/specs/ovs_flow.yaml | 14 ++++++++-----
 Documentation/netlink/specs/tc.yaml       |  7 +++++--
 9 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 6f5348f3d08f..bf54eb2b639c 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1873,7 +1873,9 @@ operations:
 
     -
       name: info-get
-      doc: Get device information, like driver name, hardware and firmware versions etc.
+      doc: |
+        Get device information, like driver name, hardware and firmware versions
+        etc.
       attribute-set: devlink
       dont-validate: [strict, dump]
       do:
diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 35b1cb4834a4..ed9bcdec01cc 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -55,7 +55,9 @@ definitions:
         doc: The firmware flashing process was stopped due to an error.
   -
     name: c33-pse-ext-state
-    doc: "groups of PSE extended states functions. IEEE 802.3-2022 33.2.4.4 Variables"
+    doc: |
+      "groups of PSE extended states functions. IEEE 802.3-2022 33.2.4.4
+      Variables"
     type: enum
     name-prefix: ethtool-c33-pse-ext-state-
     header: linux/ethtool.h
diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 84ddf9053f2e..bc395963e628 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -61,8 +61,8 @@ definitions:
       -
         name: sub-closed
         doc: >-
-          A subflow has been closed. An error (copy of sk_err) could be set if an
-          error has been detected for this subflow.
+          A subflow has been closed. An error (copy of sk_err) could be set if
+          an error has been detected for this subflow.
           Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
           daddr6, sport, dport, backup, if_idx [, error].
       -
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 6819c3636841..ce4cfec82100 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -48,16 +48,19 @@ definitions:
     entries:
       -
         name: timestamp
-        doc:
-          Device is capable of exposing receive HW timestamp via bpf_xdp_metadata_rx_timestamp().
+        doc: |
+          Device is capable of exposing receive HW timestamp via
+          bpf_xdp_metadata_rx_timestamp().
       -
         name: hash
-        doc:
-          Device is capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash().
+        doc: |
+          Device is capable of exposing receive packet hash via
+          bpf_xdp_metadata_rx_hash().
       -
         name: vlan-tag
-        doc:
-          Device is capable of exposing receive packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+        doc: |
+          Device is capable of exposing receive packet VLAN tag via
+          bpf_xdp_metadata_rx_vlan_tag().
   -
     type: flags
     name: xsk-flags
@@ -425,9 +428,9 @@ attribute-sets:
       -
         name: rx-hw-gro-packets
         doc: |
-          Number of packets that were coalesced from smaller packets by the device.
-          Counts only packets coalesced with the HW-GRO netdevice feature,
-          LRO-coalesced packets are not counted.
+          Number of packets that were coalesced from smaller packets by the
+          device. Counts only packets coalesced with the HW-GRO netdevice
+          feature, LRO-coalesced packets are not counted.
         type: uint
       -
         name: rx-hw-gro-bytes
@@ -436,8 +439,8 @@ attribute-sets:
       -
         name: rx-hw-gro-wire-packets
         doc: |
-          Number of packets that were coalesced to bigger packetss with the HW-GRO
-          netdevice feature. LRO-coalesced packets are not counted.
+          Number of packets that were coalesced to bigger packetss with the
+          HW-GRO netdevice feature. LRO-coalesced packets are not counted.
         type: uint
       -
         name: rx-hw-gro-wire-bytes
diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
index ed9c5cf68477..2ee10d92d644 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -1205,7 +1205,9 @@ operations:
             - name
     -
       name: destroytable
-      doc: Delete an existing table with destroy semantics (ignoring ENOENT errors).
+      doc: |
+        Delete an existing table with destroy semantics (ignoring ENOENT
+        errors).
       attribute-set: table-attrs
       fixed-header: nfgenmsg
       do:
@@ -1249,7 +1251,9 @@ operations:
             - name
     -
       name: destroychain
-      doc: Delete an existing chain with destroy semantics (ignoring ENOENT errors).
+      doc: |
+        Delete an existing chain with destroy semantics (ignoring ENOENT
+        errors).
       attribute-set: chain-attrs
       fixed-header: nfgenmsg
       do:
@@ -1307,7 +1311,8 @@ operations:
             - name
     -
       name: destroyrule
-      doc: Delete an existing rule with destroy semantics (ignoring ENOENT errors).
+      doc: |
+        Delete an existing rule with destroy semantics (ignoring ENOENT errors).
       attribute-set: rule-attrs
       fixed-header: nfgenmsg
       do:
@@ -1351,7 +1356,8 @@ operations:
             - name
     -
       name: destroyset
-      doc: Delete an existing set with destroy semantics (ignoring ENOENT errors).
+      doc: |
+        Delete an existing set with destroy semantics (ignoring ENOENT errors).
       attribute-set: set-attrs
       fixed-header: nfgenmsg
       do:
diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 55555038759f..610fdd5e000e 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -1799,8 +1799,9 @@ operations:
     -
       name: get-wiphy
       doc: |
-        Get information about a wiphy or dump a list of all wiphys. Requests to dump get-wiphy
-        should unconditionally include the split-wiphy-dump flag in the request.
+        Get information about a wiphy or dump a list of all wiphys. Requests to
+        dump get-wiphy should unconditionally include the split-wiphy-dump flag
+        in the request.
       attribute-set: nl80211-attrs
       do:
         request:
diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 79c37d5dd1a5..17e5e9b7f5a5 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -42,8 +42,8 @@ attribute-sets:
         name: id
         type: u32
         doc: >-
-          The unique ID of the peer in the device context. To be used to identify
-          peers during operations for a specific device
+          The unique ID of the peer in the device context. To be used to
+          identify peers during operations for a specific device
         checks:
           max: 0xFFFFFF
       -
diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 02ef3597ea94..06bf048040c7 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -293,9 +293,10 @@ definitions:
     enum-name: ovs-hash-alg
     type: enum
     doc: |
-      Data path hash algorithm for computing Datapath hash. The algorithm type only specifies
-      the fields in a flow will be used as part of the hash. Each datapath is free to use its
-      own hash algorithm. The hash value will be opaque to the user space daemon.
+      Data path hash algorithm for computing Datapath hash. The algorithm type
+      only specifies the fields in a flow will be used as part of the hash. Each
+      datapath is free to use its own hash algorithm. The hash value will be
+      opaque to the user space daemon.
     entries:
       - ovs-hash-alg-l4
 
@@ -615,7 +616,9 @@ attribute-sets:
         name: set
         type: nest
         nested-attributes: key-attrs
-        doc: Replaces the contents of an existing header. The single nested attribute specifies a header to modify and its value.
+        doc: |
+          Replaces the contents of an existing header. The single nested
+          attribute specifies a header to modify and its value.
       -
         name: push-vlan
         type: binary
@@ -630,7 +633,8 @@ attribute-sets:
         type: nest
         nested-attributes: sample-attrs
         doc: |
-          Probabilistically executes actions, as specified in the nested attributes.
+          Probabilistically executes actions, as specified in the nested
+          attributes.
       -
         name: recirc
         type: u32
diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index dfcb9cc3ea0a..4cc1f6a45001 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -76,7 +76,8 @@ definitions:
         name: overlimits
         type: u32
         doc: |
-          Number of throttle events when this flow goes out of allocated bandwidth
+          Number of throttle events when this flow goes out of allocated
+          bandwidth
       -
         name: bps
         type: u32
@@ -751,7 +752,9 @@ definitions:
       -
         name: count
         type: u32
-        doc: How many drops we've done since the last time we entered dropping state
+        doc: |
+          How many drops we've done since the last time we entered dropping
+          state
       -
         name: lastcount
         type: u32
-- 
2.49.0


