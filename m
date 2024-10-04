Return-Path: <bpf+bounces-40926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E74DF9900A3
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 12:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B341F22E8C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7938B1514F8;
	Fri,  4 Oct 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="dUAozncb"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749514B061;
	Fri,  4 Oct 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036821; cv=none; b=UrzUT3DVuDQhHymvlHtGzShr1A4r2JarOJrfOQF36FzZcohJIKfkZpB2FBCnn+TAtQkcBgJzbYt2jjldlmyjrIAodsbEhgWOq4Ydt7NPDtRx32r6ydXeIMPnQYKP/MpBMYBvaeZR2D4jCwdchXtmdWEKnXTXoARUXKVL5RNZ1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036821; c=relaxed/simple;
	bh=DYlwMDBGIBQ6ZKw/wdb5qz0tEd2rReGxtQnoOE1IhrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V83LUo9U0YGEltzz8DtIC5/sNDMczgN+sPs8S2QhCBTROJLtzIjklln+ZHLrW2Q/hrZQ+9MoVRr9+opsXAPmNeu/g5u07mmbp7hCVrOMZlYiIbghng33xoRIzOVMfCC+qP5cdZdLpNnfjlPukLh+Mz5Qw0CTmneJFBLr9okAsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=dUAozncb; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tBDUG2BzjjJAUxXFr7V7YZ/wcg5nvB9xrEH9S2GdSEM=; b=dUAozncb9kDSn2Vxgsp3ZH81lc
	TCIPyP9N//VxhqFF3BimXR2OEf+I7n5PTjOX40YkJfw53bMqCtGnluUVZCgp0p4t5jNgNcshH9Q8h
	rdsBP7VAJaAbp9h1PaojFGadOKljcMfMA5k8nppyObxUjZMe6R5M9ZAu3Rb6lFJC0Sxkdd9sPyETd
	29Mu4g01e9j6Ft1a6hYvyQDw6CPuzShn+05CfvPOmJKrIY7Y3qVeCxYJVDTBRbVKpNpmgcDbRDXLd
	e9K71eb+OJxsDn6lAm43OA5xJ+451TVqwTOhCnwU1F4jz/1fXqf2DZaANErZZrQ3ZgHmj9u/kawkQ
	1HTgPOPw==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1swfJZ-000BVS-C7; Fri, 04 Oct 2024 12:13:37 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	kuba@kernel.org,
	jrife@google.com,
	tangchen.1@bytedance.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 3/5] netkit: Add add netkit scrub support to rt_link.yaml
Date: Fri,  4 Oct 2024 12:13:33 +0200
Message-Id: <20241004101335.117711-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004101335.117711-1-daniel@iogearbox.net>
References: <20241004101335.117711-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27417/Fri Oct  4 10:53:24 2024)

Add netkit scrub attribute support to the rt_link.yaml spec file.

Example:

  # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
   --do getlink --json '{"ifname": "nk0"}' --output-json | jq
  [...]
  "linkinfo": {
    "kind": "netkit",
    "data": {
      "primary": 0,
      "policy": "forward",
      "mode": "l3",
      "scrub": "default",
      "peer-policy": "forward",
      "peer-scrub": "default"
    }
  },
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 Documentation/netlink/specs/rt_link.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 0c4d5d40cae9..59c51cf6df31 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -920,6 +920,13 @@ definitions:
       - name: l2
       - name: l3
 
+  -
+    name: netkit-scrub
+    type: enum
+    entries:
+      - name: none
+      - name: default
+
 attribute-sets:
   -
     name: link-attrs
@@ -2147,6 +2154,14 @@ attribute-sets:
         name: mode
         type: u32
         enum: netkit-mode
+      -
+        name: scrub
+        type: u32
+        enum: netkit-scrub
+      -
+        name: peer-scrub
+        type: u32
+        enum: netkit-scrub
 
 sub-messages:
   -
-- 
2.43.0


