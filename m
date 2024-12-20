Return-Path: <bpf+bounces-47486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C19F9D40
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 00:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFFF16CC59
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 23:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65022838F;
	Fri, 20 Dec 2024 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="As0i6QJa"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F091A01BD;
	Fri, 20 Dec 2024 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738429; cv=none; b=XdoOsPA3GfgMaPMdO9EecookrcYeUy5GTbigq7sol7kZkg23ru7lqUJT9mBM9H38hDMyK8y2XTaTqCqnr3n1uaEng/xCGRG7+5Z2h7wOABIFbJBjM06E+9vCFJebwZLL6MKTg/E8TUEub0x7LtgUvIONN1Mwfvnn9x+jDWeqaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738429; c=relaxed/simple;
	bh=Qwj5zUiYJ5C7w1yk4PrmhOazfHT/8mw2RrIgrXZ7UfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKmQv+2nhRxIME/KGWwzy/V9ghdoU2q83i/41Xpc9XMBs4IRfNTLISIMOa6qqdXCKwoq4uOVdyZAzYhZ8FhQfQUgsk7NvBTDD9AGDuk65sQoXYcxU7xRxQIcxK0NQ9biNumt0gSa35CGAWEQNSv46y1eQ6ocveSAMQS1pEhp/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=As0i6QJa; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tYKOX4rHpeNX+6/TYEQ8f2DrPyEghKzfu11FgQwFLg4=; b=As0i6QJa8NbluKR9WPDu1jPGZD
	FtLDsBojBMQzPLe83Q1XzaV8RxNnYucdn3S4VcvOm0rpmLabJ45YKSJpmhoC1QeoB9y1l8emP/4yp
	YL8SAuJnZJte5L6rY0s3r/WiWPgT7mCc+EeJp+7UDfXGgWgvctANziWyrLFJ4fUx0VJTeN+Q4LaWR
	6KIW8ugvT2HBvJcmtwgraPhPuwJ4nxWCJGkHE77D+Wq4Bhb0omvRg67Is6tlpC3fAhgLGLz1hiq6f
	282PwxAIlxKejKY17CYlYrKkANGbymnJ524R33ee3oki2e9Sv96DFGk+VvOHWHLi86jlRqvJFpaNB
	yqsvpPRw==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tOmhv-000ISq-Q4; Sat, 21 Dec 2024 00:46:59 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 2/3] netkit: Add add netkit {head,tail}room to rt_link.yaml
Date: Sat, 21 Dec 2024 00:46:57 +0100
Message-ID: <20241220234658.490686-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220234658.490686-1-daniel@iogearbox.net>
References: <20241220234658.490686-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27493/Fri Dec 20 10:46:49 2024)

Add netkit {head,tail}room attribute support to the rt_link.yaml spec file.

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
      "headroom": 0,
      "tailroom": 0,
      "peer-policy": "forward",
      "peer-scrub": "default"
    }
  },
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 Documentation/netlink/specs/rt_link.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 9ffa13b77dcf..dbeae6b1c548 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -2166,6 +2166,12 @@ attribute-sets:
         name: peer-scrub
         type: u32
         enum: netkit-scrub
+      -
+        name: headroom
+        type: u16
+      -
+        name: tailroom
+        type: u16
 
 sub-messages:
   -
-- 
2.43.0


