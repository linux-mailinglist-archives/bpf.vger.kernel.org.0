Return-Path: <bpf+bounces-7106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3407717BD
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 03:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03561C2090A
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 01:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDCB17EC;
	Mon,  7 Aug 2023 01:21:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CB15A2;
	Mon,  7 Aug 2023 01:21:17 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618D171A;
	Sun,  6 Aug 2023 18:21:15 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RJz2f07MCzGprB;
	Mon,  7 Aug 2023 09:17:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 09:21:13 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <jiri@resnulli.us>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next,v3 2/5] team: remove unreferenced header in broadcast and roundrobin files
Date: Mon, 7 Aug 2023 09:25:53 +0800
Message-ID: <20230807012556.3146071-3-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807012556.3146071-1-shaozhengchao@huawei.com>
References: <20230807012556.3146071-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Because linux/errno.h is unreferenced in broadcast and roundrobin
files, so remove it.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/team/team_mode_broadcast.c  | 1 -
 drivers/net/team/team_mode_roundrobin.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/team/team_mode_broadcast.c b/drivers/net/team/team_mode_broadcast.c
index 313a3e2d68bf..61d7d79f0c36 100644
--- a/drivers/net/team/team_mode_broadcast.c
+++ b/drivers/net/team/team_mode_broadcast.c
@@ -8,7 +8,6 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/if_team.h>
 
diff --git a/drivers/net/team/team_mode_roundrobin.c b/drivers/net/team/team_mode_roundrobin.c
index 3ec63de97ae3..dd405d82c6ac 100644
--- a/drivers/net/team/team_mode_roundrobin.c
+++ b/drivers/net/team/team_mode_roundrobin.c
@@ -8,7 +8,6 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/if_team.h>
 
-- 
2.34.1


