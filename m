Return-Path: <bpf+bounces-40854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF82198F5C4
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 20:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A17C28334E
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 18:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B3C1AB525;
	Thu,  3 Oct 2024 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MzffGWIh"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22E1A4F08;
	Thu,  3 Oct 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978612; cv=none; b=FlAzLQTCc8KCNiqHwkH3ynpqENFSSlKCGBhWyu6t6UfIQ98doJosyeDbNIimRR8GBZmWM8C6AuebUYPBP6rh24EM0GyeAlkhXyJBCxXaOfZN8IR77le48xJsON6rnvUNoSOZyK9uXic7F4x7+8sezvpck3gjxLmfhnNQvQxeA/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978612; c=relaxed/simple;
	bh=DYlwMDBGIBQ6ZKw/wdb5qz0tEd2rReGxtQnoOE1IhrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dp0mNI03aFM3V86o91e5OMhKGpEsMRpWN/sayajyFVUWgdDf/9vxhp7YZPDKH8pnsb64Od0ZOdpsHdNku6LrNnCWPr9p1ukLCMD/BkOiDQq4m7zpjFNDpJgH9xt4SUVAXIta+1Oxe67xh1eHwNXM61kNgS/cmWaY5A97y/wbRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MzffGWIh; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tBDUG2BzjjJAUxXFr7V7YZ/wcg5nvB9xrEH9S2GdSEM=; b=MzffGWIhTjY5O5kQrCTmV3Lh0v
	bquyZ9IqYHJkosf2hh6rCHjJkcmDEu7YZJdyEAmMp0YfJBw1uoHKHAuFcw+y9REPsqQAJZ/FnRfFk
	+IuwJQ8GaKu3rTFJ3gYYarUMhGWNg0u7UxOjqbdFApy5fEAVC7svdzTOCBDWHn3t6TrhCOOcmdlbQ
	6kCQtN0ZfZ5rCnNEZoRSRIA+YI2ICw9cjetYnuV1eK3nN8dZbaE4eRTcadZTh/w1s13J00iNqmwvK
	jbfqEwMzKugPHxyf7idXg5nk3giVmEWrO4sFXVOMvJ/G1sy+0QAxYSA8QUCqsWg176/LPRVbtR77E
	NPGFQqHw==;
Received: from 44.249.197.178.dynamic.cust.swisscom.net ([178.197.249.44] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1swQAc-0006De-8t; Thu, 03 Oct 2024 20:03:22 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	jrife@google.com,
	tangchen.1@bytedance.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 2/4] netkit: Add add netkit scrub support to rt_link.yaml
Date: Thu,  3 Oct 2024 20:03:18 +0200
Message-Id: <20241003180320.113002-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003180320.113002-1-daniel@iogearbox.net>
References: <20241003180320.113002-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27416/Thu Oct  3 10:37:25 2024)

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


