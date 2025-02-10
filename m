Return-Path: <bpf+bounces-50988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908DA2F046
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD5A1887DC7
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89AD222565;
	Mon, 10 Feb 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kmryy+cV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230DE1F8BA4;
	Mon, 10 Feb 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199143; cv=none; b=BBtwYiflop7qBSCHEabX12nPdRHDEU2fJh9qnN3xWQXVKrqfUexh8qgi/vpqzO7w72rRlyu+e0DF60JWxzZ+2nIZkUCxJA1JaJDXkmtqIKnagcZhkYDWN4kRLCIscJfeqKjInZ4aVgPPTGyzgjzGZpaRPvpXq6xWKZHlYlikNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199143; c=relaxed/simple;
	bh=wwFNBD+2n7iIkpjz+HDpg51f9v6nAIvUywQsatviOGY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=We8tqZ3s9vZFS1jZQLBPzYntraCP2sK0ZeIpvsAKfpJUmTqDQXOVwJEVdG4y7DXxgzk/hgIAm/BmV2QWZWC/0r5Emq0fseUcysrd+kNA4rXzczV5xJo8QRISMRdqaQEdmkV3lZwJ/Q6Esa+BgcQcac1ivO4n3cxOe8Stk7TgrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kmryy+cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FC0C4CED1;
	Mon, 10 Feb 2025 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739199143;
	bh=wwFNBD+2n7iIkpjz+HDpg51f9v6nAIvUywQsatviOGY=;
	h=From:Subject:Date:To:Cc:From;
	b=Kmryy+cVf+JluFTwBz4BWzZBKcdKW7FdeD9R1Eoo8hLLH6xrs/WiaF2ME6LxMs3Xa
	 u+E1qHBaAIGJlTS3g27JU0vkODp6wIwz7SnNypPHYWSSODfrxbyg0SHldOtDVOphfN
	 jUTS9/YVfWuDTRz/+GtRBk4E9IWVjGtzgdQe88CGn9RSFmFFPgfOg45EepANPbGaby
	 ucyKTSqlx7oUzyfj5/cmxGn8aszXMGc+yEmS0ja33+i8Wd5hJNwoO9sgvfACleEINJ
	 HELH1ttrpVocWTMXn8rVaJjsl6CRf1rwUTgGqAzxNgGm35IHma4hLRPu9JjkVwftn1
	 gYIQARw/2vOGw==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net 0/3] net: ethernet: ti: am65-cpsw: XDP fixes
Date: Mon, 10 Feb 2025 16:52:14 +0200
Message-Id: <20250210-am65-cpsw-xdp-fixes-v1-0-ec6b1f7f1aca@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4SqmcC/x3LQQ5AMBBA0avIrE1SpSWuIhbFYBaq6QgScXeN5
 cvPf0AoMgm02QORThbefUKRZzCuzi+EPCWDVtoorWp0mzU4BrnwngLOfJPg0FgqjbW6cjOkM0T
 6Qxo78HRA/74fQX5Q22oAAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, Jacob Keller <jacob.e.keller@intel.com>
Cc: danishanwar@ti.com, s-vadapalli@ti.com, srk@ti.com, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=677; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=wwFNBD+2n7iIkpjz+HDpg51f9v6nAIvUywQsatviOGY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnqhKiATtcQYm+JuEEy6wcpmRai+D+jCvVaQmnI
 /ZOSebmLD2JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ6oSogAKCRDSWmvTvnYw
 kxVaEACw9zOudx9B3C0lX3vAffFZ+jLgSSUR7fd9hEAf8six91LiHhG8cN2lv8BuDoocv8YsMqK
 2W6Rdry6o/TKCN/0IBtVdnf4YOXbH4DeeCDfccNMZia69FZYTil4G9xrHd1cbAWfdJBSXfos5lt
 1f9z/qyHx4sxP1MbysI2dj21eX0HkpqDfZfD5L4xl2JyEXvwF3Sypa3CQrUEzMRy0Ad23B2g9Y1
 dLWrYpvUPJmQuS7y4WqvcKNoAO38nt9QZ26Pq0No53HvIOuIKEvXFMCjW25AlK2VZO+oCz9CEz4
 9tjNGiWIVsW8JD0agxnvla7y545/BupBCFdgEYQ9hnSvAYhvMkueSwjD4uwg1rnjRXJwcpYmKoc
 YJc7nkOiE6OvV0nxKVRxElOYRmUcCy7V+p5r6npWyi6lXCNWirVOzf3bjkq5wTXIBISnUxaUMm/
 2KsREj/ZbthSn+cL1AhEGcqxGBqT5CGTNrQjr6No+dtOTRtFFaNa6upEXCHIUSjAiu+C3WDmFfk
 ZVLa79TUR9oRZvgDtpxJTW9uRNL1ZjBRSzrrKvqqd7uUv7CfvhheocYDBLRr4+4aw2y7al0ljNo
 XzwcElPHbmujXISr5+keMnOiEFXz93scKQ2wadp/ic27IhZSu8oaqZZ8hlVjy2BhnS0vJMVmvs9
 8go216vxRrKKAhQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Hi,

This series fixes memleak and statistics for XDP cases.

cheers,
-roger

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Roger Quadros (3):
      net: ethernet: ti: am65-cpsw: fix memleak in certain XDP cases
      net: ethernet: ti: am65-cpsw: fix RX & TX statistics for XDP_TX case
      net: ethernet: ti: am65_cpsw: fix tx_cleanup for XDP case

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 50 +++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 20 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-am65-cpsw-xdp-fixes-b86e356624af

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


