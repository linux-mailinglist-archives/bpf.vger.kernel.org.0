Return-Path: <bpf+bounces-60176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D08EAD387D
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD35189BBDE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD22D8DC3;
	Tue, 10 Jun 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwrgSJSq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278692D3A8D;
	Tue, 10 Jun 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560406; cv=none; b=SiFmJXPXaHIfMVwwSn+yXpB1bS30W+9ZQPSH8r9Sx7Hoon4gqlnu1EQHqwBeNivi+RZoYg3DGKdLbjss5q0tIZL35CMbIVM8FVYHNITQK4Fp0qQIgu/7bjpxtMxWgQ/7eBmUk98dZLSX4MrX16yBzCJttUeeUBg9A/xnHj30Kws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560406; c=relaxed/simple;
	bh=ruRyxqu11IYo4eZzSdGi8OGpZeomHZZexAOLHjT703U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCcQCR0LQOxdWMvtCQjLgvSIHT8V47G6Jl06F2rqnAD+c+NOuZ/bKm9oVpQpjvBXgc+vU8yemPrUzu85ou1B/WRXfapTeOHtbPRilZc2u/OK1INjQ6UfgbSZ5BJZ7Ar7UnqazDoaVbqtSDlsplpe3F6pXifoRbVOB/jUfkbRfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwrgSJSq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d6ade159so45877465e9.1;
        Tue, 10 Jun 2025 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560402; x=1750165202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfBd7lpVrlSmgeZuwrplqniCnY7VqjzOTzQqiKGvaeM=;
        b=EwrgSJSqVi/H23Gd7ThA7OvgzyM9OISLmVB4oJA+6pO04JkAkLnB8+5C9rORVEs6NI
         Mms4qlIVXWPelSs6puFeQ02+VKaEVGsZyIzQ1aEzVWVIbLxzMJyj2cDKV8/QD4pHrRGe
         6g911cc6fMlZCYzjKxre3E71Xt9N2HGq05JGPaXAWhzauuCeZTLv87CHkpzwyC4XS6M1
         wZ5mPC/vyJiYtZ7aBGzi6XIr4DELDwi7eRTCPuD7+WcWMCJklKU3cPgo6R5qOumfe63U
         t62Ty8E6qcPY39Evu4OXXp5nCCibrXSPYTWt7LKhxZn6SqQf56hdrRQ36VC4aFalyzeP
         VpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560402; x=1750165202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfBd7lpVrlSmgeZuwrplqniCnY7VqjzOTzQqiKGvaeM=;
        b=hbmJ4SCn+aXNqscnBdbLU/f1Rn19dbAh8l+vVhZucSXccAzCxAS61OkgoVuvUJcJ8n
         DZg/RyRzFUOjS+EK/pp2TKW0lH4oG88J0vlJDkUl0fw+QIgD5Amo1J4EMce43YbHdX6J
         9qHnz0AwCvXusvrjdRf9oVDlxMAGS7hhKl3LWn2sYn77wXohltJ40aebIxP+0/EkMiVL
         VQR3YnViIq8lts16KgD0kbP0j4r5ZEXM4ZRh/NPrz/x7S66kDxYGAInxYfWmGLkbySYM
         hr0akxlz6kbZ6YR9pE8xSVdnuzC7AzO8lcqVxfykwcJ6CGo4nU+AORmf85dxvdvTuBPE
         IFHA==
X-Forwarded-Encrypted: i=1; AJvYcCVyp3nFilCHBb1aMdKJlS6AC/sd4fHRbC5jJrQmo5GK2YVjvSwHzDE26H3K5bZlVvXhBjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBjNn0ZR8NbhRz4KfZFO/azjsIeI6ygDOfl1MygOg1K6mrJPrT
	Pu7DruPoLjvvxEu8zZgP0qKUkI/CIn16TYBZ+/Lt6F/EQRLEtdvw5/laeoXkkw==
X-Gm-Gg: ASbGnctHV2zoUjRc/1L/H7/Nrh6eeS7wHzLy61lLz9UcqbB6q/RoUnvVZWeO7gCMG/Y
	kG/nvfl5XP1ZQUgUbfLKjM5teROrEZv4lDilWezDqD6MfEDfLlJymfXb48wlNpadmhNMsHHCzTG
	mVI9hT0ts47xN/HpfB7PFStWnK/+sZxSrp2mYKPPLrClFlrsK5qPadqIVd7n15SSNxu23VpEQOz
	CtUC0Ml88ViQJiIfNnNVH+Cqg12NCDTvJan/50mOzOW5GqoxlukeI4+ZEly9iWdbagRYH5kXU4O
	TbakPRy/w2Aj9caSlL4Y/SQXt+8tan9pV7XxapcJeQuPJPna32v5GF70qFDUfv0i5pm/H1Pz0kV
	W0vjv
X-Google-Smtp-Source: AGHT+IGG8m04vZTIjxssS5OJuicVpbIoXFqTeWTWJ2geJNryy0EwBrLIG9dwCeF2vAI7dlNrM6w9tg==
X-Received: by 2002:a05:600c:a08d:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-45201373d52mr151874655e9.6.1749560401962;
        Tue, 10 Jun 2025 06:00:01 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.06.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:00:01 -0700 (PDT)
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
Subject: [PATCH net-next v1 5/7] netlink: specs: fix up indentation errors
Date: Tue, 10 Jun 2025 13:59:42 +0100
Message-ID: <20250610125944.85265-6-donald.hunter@gmail.com>
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

Clean up all indentation related errors reported by yamllint in the
netlink specs, e.g.

    error    wrong indentation: expected 6 but found 5  (indentation)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/conntrack.yaml |  36 ++---
 Documentation/netlink/specs/devlink.yaml   |   8 +-
 Documentation/netlink/specs/ethtool.yaml   |  54 ++++----
 Documentation/netlink/specs/mptcp_pm.yaml  | 150 ++++++++++-----------
 Documentation/netlink/specs/netdev.yaml    |   2 +-
 5 files changed, 125 insertions(+), 125 deletions(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index e48add669b6d..c6832633ab7b 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -195,17 +195,17 @@ attribute-sets:
   -
     name: tuple-attrs
     attributes:
-    -
+      -
         name: tuple-ip
         type: nest
         nested-attributes: tuple-ip-attrs
         doc: conntrack l3 information
-    -
+      -
         name: tuple-proto
         type: nest
         nested-attributes: tuple-proto-attrs
         doc: conntrack l4 information
-    -
+      -
         name: tuple-zone
         type: u16
         byte-order: big-endian
@@ -213,74 +213,74 @@ attribute-sets:
   -
     name: protoinfo-tcp-attrs
     attributes:
-    -
+      -
         name: tcp-state
         type: u8
         enum: nf-ct-tcp-state
         doc: tcp connection state
-    -
+      -
         name: tcp-wscale-original
         type: u8
         doc: window scaling factor in original direction
-    -
+      -
         name: tcp-wscale-reply
         type: u8
         doc: window scaling factor in reply direction
-    -
+      -
         name: tcp-flags-original
         type: binary
         struct: nf-ct-tcp-flags-mask
-    -
+      -
         name: tcp-flags-reply
         type: binary
         struct: nf-ct-tcp-flags-mask
   -
     name: protoinfo-dccp-attrs
     attributes:
-    -
+      -
         name: dccp-state
         type: u8
         doc: dccp connection state
-    -
+      -
         name: dccp-role
         type: u8
-    -
+      -
         name: dccp-handshake-seq
         type: u64
         byte-order: big-endian
-    -
+      -
         name: dccp-pad
         type: pad
   -
     name: protoinfo-sctp-attrs
     attributes:
-    -
+      -
         name: sctp-state
         type: u8
         doc: sctp connection state
         enum: nf-ct-sctp-state
-    -
+      -
         name: vtag-original
         type: u32
         byte-order: big-endian
-    -
+      -
         name: vtag-reply
         type: u32
         byte-order: big-endian
   -
     name: protoinfo-attrs
     attributes:
-    -
+      -
         name: protoinfo-tcp
         type: nest
         nested-attributes: protoinfo-tcp-attrs
         doc: conntrack tcp state information
-    -
+      -
         name: protoinfo-dccp
         type: nest
         nested-attributes: protoinfo-dccp-attrs
         doc: conntrack dccp state information
-    -
+      -
         name: protoinfo-sctp
         type: nest
         nested-attributes: protoinfo-sctp-attrs
diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 939e7e12fe30..6f5348f3d08f 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -812,14 +812,14 @@ attribute-sets:
         name: rate-parent-node-name
         type: string
       -
-         name: region-max-snapshots
-         type: u32
+        name: region-max-snapshots
+        type: u32
       -
         name: linecard-index
         type: u32
       -
-         name: linecard-state
-         type: u8
+        name: linecard-state
+        type: u8
       -
         name: linecard-type
         type: string
diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 0b6a1db71ef5..35b1cb4834a4 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -60,33 +60,33 @@ definitions:
     name-prefix: ethtool-c33-pse-ext-state-
     header: linux/ethtool.h
     entries:
-        -
-          name: none
-          doc: none
-        -
-          name: error-condition
-          doc: Group of error_condition states
-        -
-          name: mr-mps-valid
-          doc: Group of mr_mps_valid states
-        -
-          name: mr-pse-enable
-          doc: Group of mr_pse_enable states
-        -
-          name: option-detect-ted
-          doc: Group of option_detect_ted states
-        -
-          name: option-vport-lim
-          doc: Group of option_vport_lim states
-        -
-          name: ovld-detected
-          doc: Group of ovld_detected states
-        -
-          name: power-not-available
-          doc: Group of power_not_available states
-        -
-          name: short-detected
-          doc: Group of short_detected states
+      -
+        name: none
+        doc: none
+      -
+        name: error-condition
+        doc: Group of error_condition states
+      -
+        name: mr-mps-valid
+        doc: Group of mr_mps_valid states
+      -
+        name: mr-pse-enable
+        doc: Group of mr_pse_enable states
+      -
+        name: option-detect-ted
+        doc: Group of option_detect_ted states
+      -
+        name: option-vport-lim
+        doc: Group of option_vport_lim states
+      -
+        name: ovld-detected
+        doc: Group of ovld_detected states
+      -
+        name: power-not-available
+        doc: Group of power_not_available states
+      -
+        name: short-detected
+        doc: Group of short_detected states
   -
     name: phy-upstream-type
     enum-name: phy-upstream
diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 1d47ad86d619..84ddf9053f2e 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -17,72 +17,72 @@ definitions:
     enum-name: mptcp-event-type
     name-prefix: mptcp-event-
     entries:
-     -
-      name: unspec
-      doc: unused event
-     -
-      name: created
-      doc: >-
-        A new MPTCP connection has been created. It is the good time to
-        allocate memory and send ADD_ADDR if needed. Depending on the
-        traffic-patterns it can take a long time until the
-        MPTCP_EVENT_ESTABLISHED is sent.
-        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, server-side.
-     -
-      name: established
-      doc: >-
-        A MPTCP connection is established (can start new subflows).
-        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, server-side.
-     -
-      name: closed
-      doc: >-
-        A MPTCP connection has stopped.
-        Attribute: token.
-     -
-      name: announced
-      value: 6
-      doc: >-
-        A new address has been announced by the peer.
-        Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
-     -
-      name: removed
-      doc: >-
-        An address has been lost by the peer.
-        Attributes: token, rem_id.
-     -
-      name: sub-established
-      value: 10
-      doc: >-
-        A new subflow has been established. 'error' should not be set.
-        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
-     -
-      name: sub-closed
-      doc: >-
-        A subflow has been closed. An error (copy of sk_err) could be set if an
-        error has been detected for this subflow.
-        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
-     -
-      name: sub-priority
-      value: 13
-      doc: >-
-        The priority of a subflow has changed. 'error' should not be set.
-        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
-     -
-      name: listener-created
-      value: 15
-      doc: >-
-        A new PM listener is created.
-        Attributes: family, sport, saddr4 | saddr6.
-     -
-      name: listener-closed
-      doc: >-
-        A PM listener is closed.
-        Attributes: family, sport, saddr4 | saddr6.
+      -
+        name: unspec
+        doc: unused event
+      -
+        name: created
+        doc: >-
+          A new MPTCP connection has been created. It is the good time to
+          allocate memory and send ADD_ADDR if needed. Depending on the
+          traffic-patterns it can take a long time until the
+          MPTCP_EVENT_ESTABLISHED is sent.
+          Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+          dport, server-side.
+      -
+        name: established
+        doc: >-
+          A MPTCP connection is established (can start new subflows).
+          Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+          dport, server-side.
+      -
+        name: closed
+        doc: >-
+          A MPTCP connection has stopped.
+          Attribute: token.
+      -
+        name: announced
+        value: 6
+        doc: >-
+          A new address has been announced by the peer.
+          Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
+      -
+        name: removed
+        doc: >-
+          An address has been lost by the peer.
+          Attributes: token, rem_id.
+      -
+        name: sub-established
+        value: 10
+        doc: >-
+          A new subflow has been established. 'error' should not be set.
+          Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+          daddr6, sport, dport, backup, if_idx [, error].
+      -
+        name: sub-closed
+        doc: >-
+          A subflow has been closed. An error (copy of sk_err) could be set if an
+          error has been detected for this subflow.
+          Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+          daddr6, sport, dport, backup, if_idx [, error].
+      -
+        name: sub-priority
+        value: 13
+        doc: >-
+          The priority of a subflow has changed. 'error' should not be set.
+          Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+          daddr6, sport, dport, backup, if_idx [, error].
+      -
+        name: listener-created
+        value: 15
+        doc: >-
+          A new PM listener is created.
+          Attributes: family, sport, saddr4 | saddr6.
+      -
+        name: listener-closed
+        doc: >-
+          A PM listener is closed.
+          Attributes: family, sport, saddr4 | saddr6.
 
 attribute-sets:
   -
@@ -298,15 +298,15 @@ operations:
       do: &get-addr-attrs
         request:
           attributes:
-           - addr
-           - token
+            - addr
+            - token
         reply:
           attributes:
-           - addr
+            - addr
       dump:
         reply:
-         attributes:
-           - addr
+          attributes:
+            - addr
     -
       name: flush-addrs
       doc: Flush addresses
@@ -332,7 +332,7 @@ operations:
       dont-validate: [strict]
       do: &mptcp-get-limits
         request:
-           attributes:
+          attributes:
             - rcv-add-addrs
             - subflows
         reply:
@@ -370,9 +370,9 @@ operations:
       flags: [uns-admin-perm]
       do:
         request:
-         attributes:
-           - token
-           - loc-id
+          attributes:
+            - token
+            - loc-id
     -
       name: subflow-create
       doc: Create subflow
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 0422a73776d4..6819c3636841 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -31,7 +31,7 @@ definitions:
       -
         name: hw-offload
         doc:
-         This feature informs if netdev supports XDP hw offloading.
+          This feature informs if netdev supports XDP hw offloading.
       -
         name: rx-sg
         doc:
-- 
2.49.0


