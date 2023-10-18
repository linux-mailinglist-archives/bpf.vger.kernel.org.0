Return-Path: <bpf+bounces-12574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4186D7CE06B
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 16:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A201C2084C
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65737170;
	Wed, 18 Oct 2023 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3911C80;
	Wed, 18 Oct 2023 14:53:01 +0000 (UTC)
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 498DA95;
	Wed, 18 Oct 2023 07:52:56 -0700 (PDT)
Received: from localhost.biz (unknown [10.81.81.211])
	by gw.red-soft.ru (Postfix) with ESMTPA id 99E463E1DD0;
	Wed, 18 Oct 2023 17:52:48 +0300 (MSK)
From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
To: Louis Peens <louis.peens@corigine.com>
Cc: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] nfp: bpf: offload: Check prog before dereference
Date: Wed, 18 Oct 2023 17:52:44 +0300
Message-Id: <20231018145244.591454-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 180708 [Oct 18 2023]
X-KLMS-AntiSpam-Version: 6.0.0.2
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 541 541 6f62a06a82e8ec968d29b8e7c7bba6aeceb34f57, {Tracking_from_domain_doesnt_match_to}, red-soft.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;localhost.biz:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/10/18 12:41:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/10/18 12:07:00 #22221112
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In nfp_net_bpf_offload() it is possible to dereference a
NULL pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 drivers/net/ethernet/netronome/nfp/bpf/offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/offload.c b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
index 9d97cd281f18..925862f7b7d6 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/offload.c
@@ -598,8 +598,7 @@ int nfp_net_bpf_offload(struct nfp_net *nn, struct bpf_prog *prog,
 	if (old_prog && !prog)
 		return nfp_net_bpf_stop(nn);
 
-	err = nfp_net_bpf_load(nn, prog, extack);
-	if (err)
+	if (prog && (err = nfp_net_bpf_load(nn, prog, extack)))
 		return err;
 
 	if (!old_prog)
-- 
2.37.3


