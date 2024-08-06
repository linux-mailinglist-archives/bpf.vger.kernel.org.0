Return-Path: <bpf+bounces-36460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97098948D0B
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 12:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC0F1C2379D
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F391BC9EE;
	Tue,  6 Aug 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="NeAyJu8r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35F165EF6
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941143; cv=none; b=a6mWJW0PxBaJsJdE8fWl3ys9/Wm2yVoc7goTPVj2ehayVoQlOG2ejA7FbiS1yay9EkEOKmX9WkCGWI8wrVf2e6Zs1E/xKghnPGxNGIVsTCZlgKFjezIavyoi5wekm70QlP8Wn+s8/lCpEw3QeIeezoA06IX8uh2e5TTIrTks66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941143; c=relaxed/simple;
	bh=e7RNq/+/ONuQLzdHf67YRYwH5y/OsEm8waAbEmryC4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzsXnNla/xGrnItZY9I4fQD2bBhcHdNmLgYk8xpDZY2vxJnyq7bYiGADjGMVDb8apirG8t22q11wlxXFKfKr2WtsA9gY82064pfVQMA0Wur8SOBM5TU7dPuXF6eWuQzZXs7IYbn12qPlZ+fROn4szJ37GcVroMu+qcf/qVwdPmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=NeAyJu8r; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so4562981fa.1
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1722941139; x=1723545939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=diUm02Ee/bKj6lfPY+QMxUw1pjVHjgO/jz/e+XCyrz0=;
        b=NeAyJu8r+janoriOoyEPxO8sQITtqxUUUnwbtyZ3tnzJlAXySHET3c6eoRzbqEWTDV
         oAY4knmkoCGEaHV8UKT2qfGyfoQkeHekAuTHQOXBn66WXHjn27lZ7aIpou0edT+MPc+1
         7JW/3E8uEkdw0YxMtGT0440BAjIGPcOYXPN5M3uV4ppYo4IEFl1IRcHUnz2etuMz9scF
         ujYr2lRrj/XPEB0m1RxY3Qdz4UbMvWmTFqZcoQKyhrH4+0C09HzczKv/hbf/0Vje9nvU
         7KeZcpNf9zqq+yrSHHAdS99/g2gtpgBItexlVhOiPWK6IRDWXIoGFaDiK6WQz79nQ7Uj
         /JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722941139; x=1723545939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diUm02Ee/bKj6lfPY+QMxUw1pjVHjgO/jz/e+XCyrz0=;
        b=hR60Izo8Oo9nEEfd/YmrKxSyjkkwwp2WNv76nMsIvyxe3ZntBuQwnFmn8tTrKvlHri
         AltFGlUu60n3bLqRG9tLpv/1Py8nWt7jttvi9k/BP22ohb3iYl9n/GfeRc9ZTSjsC89o
         Nn83a6Qa2B66zh0TktzkQJvsBPh1V1MNvECb3N7AoAqoeQ8MBdbcGfUQIqcYzTZAHfma
         91OamZP6UzygB9wY7TIca2xgv1sdU/Qp6gjHxQirJ9ecAGSRvJZNAta7Ghs+mGbT0mgO
         CtRtoyfQvwTsUd/OsV+9eTfO3i4utTTp2LUHJOhHLnnejXWwVCN1vGO+jTK7h4ZR9CBq
         Hfyg==
X-Forwarded-Encrypted: i=1; AJvYcCWFAr7DQXf1wR+nmJGypvHh5fKZ3sYYk7zjm5BsA7mVOtqhlG2x93cUkpkPKK8ciXfKFOGr/gv8EQ/+bpAsqhvcHGbM
X-Gm-Message-State: AOJu0YxNvWIcnlLtXJmMaBqx8o34MlgFHhNzbYffv5BDZBJ9DlhvhzV1
	MrkD8X55pTD8bdUTr/LZNcV6KWOKILj2hzHKdGw3T+cty+6bARmW1O6jUjeDRKpFuUiRNlXfsMO
	A
X-Google-Smtp-Source: AGHT+IEhERpJK1fvMoFLeT7W6Cansg52ARlI0lRlGGYvspHR6XBIK2SLmal2H1DiRg+1FyhH0vMpfg==
X-Received: by 2002:a2e:9c03:0:b0:2ef:5d1d:773f with SMTP id 38308e7fff4ca-2f15aac1180mr100558991fa.24.1722941139132;
        Tue, 06 Aug 2024 03:45:39 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa93sm236249735e9.10.2024.08.06.03.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 03:45:38 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next] doc/netlink/specs: add netkit support to rt_link.yaml
Date: Tue,  6 Aug 2024 13:45:31 +0300
Message-ID: <20240806104531.3296718-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add netkit support to rt_link.yaml. Only forward(PASS) and
blackhole(DROP) policies are allowed to be set by user-space so I've
added only them to the yaml to avoid confusion.

Example:
  $ ./tools/net/ynl/cli.py \
     --spec Documentation/netlink/specs/rt_link.yaml \
     --do getlink --json '{"ifname": "netkit0"}' --output-json | jq
  ...
  "linkinfo": {
    "kind": "netkit",
    "data": {
      "primary": 1,
      "policy": "blackhole",
      "mode": "l2",
      "peer-policy": "forward"
    }
  },
  ...

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
This has been rotting in my tree for quite some time, sending out
for reviews. :)

 Documentation/netlink/specs/rt_link.yaml | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index de08c12fd56f..0c4d5d40cae9 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -903,6 +903,22 @@ definitions:
       - cfm-config
       - cfm-status
       - mst
+  -
+    name: netkit-policy
+    type: enum
+    entries:
+      -
+        name: forward
+        value: 0
+      -
+        name: blackhole
+        value: 2
+  -
+    name: netkit-mode
+    type: enum
+    entries:
+      - name: l2
+      - name: l3
 
 attribute-sets:
   -
@@ -2109,6 +2125,28 @@ attribute-sets:
       -
         name: id
         type: u32
+  -
+    name: linkinfo-netkit-attrs
+    name-prefix: ifla-netkit-
+    attributes:
+      -
+        name: peer-info
+        type: binary
+      -
+        name: primary
+        type: u8
+      -
+        name: policy
+        type: u32
+        enum: netkit-policy
+      -
+        name: peer-policy
+        type: u32
+        enum: netkit-policy
+      -
+        name: mode
+        type: u32
+        enum: netkit-mode
 
 sub-messages:
   -
@@ -2147,6 +2185,9 @@ sub-messages:
       -
         value: vrf
         attribute-set: linkinfo-vrf-attrs
+      -
+        value: netkit
+        attribute-set: linkinfo-netkit-attrs
   -
     name: linkinfo-member-data-msg
     formats:
-- 
2.44.0


