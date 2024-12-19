Return-Path: <bpf+bounces-47339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9459F8272
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 18:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9B2189915A
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 17:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6B51A7253;
	Thu, 19 Dec 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UUFJLiaE"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980C1A4E77;
	Thu, 19 Dec 2024 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629975; cv=none; b=MntpaFRfRstfCG+leHcBLz45s/uJCcqVY5XdnkOnHa44oVW8D3pX7z0FaQUUxzcYHj1zfBqXpvTZA3nlJZ7i4RWzo1hVxL6FIVOHpq7d/v1ZYqE49I3wkdUyfyvftyU206towPlPEnZpanxzQM56/GCg5u73Nw15rUmudCcjEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629975; c=relaxed/simple;
	bh=Ne4AeeqZNqy6Z9M50Jp3t7u/bBE6pTUzohf9Mzl5oEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDioWp2vCLC99wMv+oNjaVggNq/fL0V8sQxxk1CxcyJZPDuKLAyzgVehDooRNLPaMG6RAVkOb8auxWLteIe11f8+/u9J6HTa6CvPaSUrkszS8d3S1FnM1ZlzP9VkpCLnYjbISOWpPhsgHPZzxzqBSERtIMUCET9lIg5j+vDGFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UUFJLiaE; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=bl2hUXNORFJOodMqxSAVtdUGgLb/T+639DMJenOGEK4=; b=UUFJLiaEpXyhja6TBmY0oMxfR1
	yNIoDsjLvBsYgDCGHjdvzSiAkxzgALerRkLZjVQJ5AWYDx0OBe39EGfhV46rdp3nv1aZM2qD3HzCD
	IaRA7UcRBj5FckquJq0TVPxj8VUff/bqNl5El0DraQpMUgIt3VMl3hrkD3LyGhY5GZihwmLOl9Wiy
	e7mv6cpBiTe/PtxxhtKiXnaUj4YneMDTaIfPxLIhPlH0XBxE55jDmaBW8u7n78ntJHcCECol1VGI+
	b1pqRK5P9a2xA8xIjBGroNPvcGTG9eWP84juxuVOYjRC9noEj2KvFmJGuvbmHnidmzOJDrOlf+GZ/
	8vIV/55Q==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tOKUj-000Mmb-Hp; Thu, 19 Dec 2024 18:39:29 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: razor@blackwall.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 2/3] netkit: Add add netkit {head,tail}room to rt_link.yaml
Date: Thu, 19 Dec 2024 18:39:27 +0100
Message-ID: <20241219173928.464437-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219173928.464437-1-daniel@iogearbox.net>
References: <20241219173928.464437-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27492/Thu Dec 19 10:44:32 2024)

Add netkit {head,tail}room attribute support to the rt_link.yaml spec file.

Example:

  # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
   --do getlink --json '{"ifname": "nk0"}' --output-json | jq
  [...]
  "linkinfo": {
    "kind": "netkit",
    "data": {
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


