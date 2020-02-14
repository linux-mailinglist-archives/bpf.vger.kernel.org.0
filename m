Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98DF15DDC9
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 17:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbgBNQAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 11:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389115AbgBNQAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 11:00:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D57542086A;
        Fri, 14 Feb 2020 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696019;
        bh=vCOwDC4HiMKfA9asIcQGpE8w0AH9BpB7uecmviq9Qsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoH2aBHFXcTynOX7zXn9jT6EOQOJLS+WOExD4jUvdZB5WXHY2ixuwLaJu01TtuWM4
         WVQPXKlWKBwSaG59QRvPZGnoo4FgsZXFeO6aNn0VT6mk4vlIYKty1TCknMRn1ajYV8
         ldeH/soZX6TXxCk9/IZN/gUpRRdplpv3eBVZbKYo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 535/542] i40e: Relax i40e_xsk_wakeup's return value when PF is busy
Date:   Fri, 14 Feb 2020 10:48:47 -0500
Message-Id: <20200214154854.6746-535-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit c77e9f09143822623dd71a0fdc84331129e97c3a ]

Return -EAGAIN instead of -ENETDOWN to provide a slightly milder
information to user space so that an application will know to retry the
syscall when __I40E_CONFIG_BUSY bit is set on pf->state.

Fixes: b3873a5be757 ("net/i40e: Fix concurrency issues between config flow and XSK")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Link: https://lore.kernel.org/bpf/20200205045834.56795-2-maciej.fijalkowski@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index f73cd917c44f7..3156de786d955 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -791,7 +791,7 @@ int i40e_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	struct i40e_ring *ring;
 
 	if (test_bit(__I40E_CONFIG_BUSY, pf->state))
-		return -ENETDOWN;
+		return -EAGAIN;
 
 	if (test_bit(__I40E_VSI_DOWN, vsi->state))
 		return -ENETDOWN;
-- 
2.20.1

