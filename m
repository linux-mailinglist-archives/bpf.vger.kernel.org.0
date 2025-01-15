Return-Path: <bpf+bounces-48949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3173A128F3
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD60C1884ACE
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864C17625C;
	Wed, 15 Jan 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utM8w0bk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6F33DB;
	Wed, 15 Jan 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959388; cv=none; b=hAVOvgHNBr24VRCU6ZiyLwhzWxXkDUMwbjzZKI15rsqDfFUXILpLplgDyMGOH8cUc+UKd3kFkYFlH7UkV879SUWwo3UDySN+9YCRcM9RrccMh1qNL3n99TWZLH+sCxGDNmn4ZhWqxUuhjG6UmEWk7IYZQdCVfigIj2b7Ayicnwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959388; c=relaxed/simple;
	bh=ZCamzQkvq1oDoF97LibgjHo8ZRywVZi3FJjGzkleH6M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZJHp7uAUdmB8kQAwDaevWRnYIkpkPj66yjzizc7On6u9Hj/6xFctAJ9ZLHMbYLwLBUVF2pnHBjVj+5ncpGipWDNJS32e5udw5MUR12RG3ViJbozk8WvZL/oRk3TTTiYcUOIbfAcahTLBWAEuhKZmNqp11t1OCvCTLq+8aC8bHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utM8w0bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0793FC4CED1;
	Wed, 15 Jan 2025 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736959387;
	bh=ZCamzQkvq1oDoF97LibgjHo8ZRywVZi3FJjGzkleH6M=;
	h=From:Subject:Date:To:Cc:From;
	b=utM8w0bkCdkDUywj1oq71iNIN9g3q4A3A8blXLNbM3oAmWv6t7fbXRvE1S4BrGVao
	 MIAqH7KF+SHDtD7/P5uAaJAXGtPy42o8B2QL4OolqRH0mdaEAouOtxemm4Jmtcv8Y8
	 X+frP8KgVJcfGfmrCcmPXmsoI12pNGByGY6jgxcATRTffnj5WxNU0rHebOPGeVn3H3
	 ByVlLexTz2egWUkV4RWKdm5GY8987q/7FeuP2Y2DDzv9vHNE0GKm4NFgGB48kEQgtz
	 Rob5vLIhY/BJh0zLgpc8nJ2XrHL0CgKVibNWJUBSutjZsVlf+oLtZGqBNPwCxNcJ7m
	 TrJnzQReQkt+Q==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next 0/4] net: ethernet: ti: am65-cpsw: streamline
 RX/TX queue creation and cleanup
Date: Wed, 15 Jan 2025 18:42:59 +0200
Message-Id: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJPlh2cC/x3MQQqDMBBG4avIrB0wSqz2KtJF0N92oE4lE6wg3
 t3g8lu8d5AhCoyexUERm5j8NMOVBY2foG+wTNlUV7WvnHMcltbzuNqfLUWE5SsKbhrfPQJa9PC
 U0zVilv3eDqRIrNgTvc7zAliIee1wAAAA
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, 
 danishanwar@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=ZCamzQkvq1oDoF97LibgjHo8ZRywVZi3FJjGzkleH6M=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnh+WX+w+qa78nialP4MqMRFcAio+xI6Bh10K1Z
 1bjSu8IoIiJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4fllwAKCRDSWmvTvnYw
 kzPeD/9eczK+j26cmF83cMXBA4yEnjnLCrZ6OHrSD5LkrBQOho4GmSekayao/Hene+mLOr6NiBn
 ukU4ySWfcDse7C1KGCkUIUGYVQVJUiknd3QVIuKil9DJ6cTe4OaTjQZBvPZbr0FXQLvDZGX2RE7
 vIQcA9BTeiYSs2ogvDd7Q55FpvChPBdMg4j15MwNIqFsYllNJd81vgyceLe5FG3WSTWYVJUwQH7
 +14kHVxKCLK49ImG10krDkDUwLGDloV7EkeN3sKkdch9HvScB7pi8iXIUwjJFVzaedGMzgXz01Q
 rU+rFEd8o8jPxGqbGKYk7JUzOcF1Vr0vgwPYF9NgFseq0EnXxUGDBXvkdZ0P0Xyp7wpPXIjbD1i
 u4hCY+sokkXI6GEg9H9SoEeYnZP5gucU4paw2KZOP1eOUeJAfjkeKqfi9CigJ/mYqZuvjb5oe31
 fqjZuc5Iia1pvxEoIJt74yUvWM1RJNBf47t9ZZiGAoMfZLYhU6SSa0G13Ha7cUTfp6y7Tp9/YwD
 sk1dv///YCKnIPUvm/eE9Weiwvw4Hxe1nI4na7EFwmNnLTAZU7dSYanxxGYX5IiH8Ocf4p5DUHm
 LMzgLcKK5/6+YfJyvZboCrXvawQ+FZSp/LF/eC6KU21yRGWSESYrBx0/YhVkBW1NjrmKPjxsBXO
 dzJEpZv4l/3iqIw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

In this series we first cleanup probe error path and get rid of
devm_add/remove_action(). Split code into symmetric init and cleanup
functions and use them.

Then we streamline RX and TX queue creation and cleanup. The queues
can now be created or destroyed by calling the appropriate
functions am65_cpsw_create_rxqs/txqs() and am65_cpsw_destroy_rxq/txqs().

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Roger Quadros (4):
      net: ethernet: am65-cpsw: call netif_carrier_on/off() when appropriate
      net: ethernet: ti: am65-cpsw: streamline .probe() error handling
      net: ethernet: ti: am65-cpsw: streamline RX queue creation and cleanup
      net: ethernet: ti: am65-cpsw: streamline TX queue creation and cleanup

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 643 ++++++++++++++++---------------
 1 file changed, 324 insertions(+), 319 deletions(-)
---
base-commit: 9c7ad35632297edc08d0f2c7b599137e9fb5f9ff
change-id: 20250111-am65-cpsw-streamline-33587ae6e9e5

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


